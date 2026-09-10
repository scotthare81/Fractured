/*
 * Thal'vaeth — Wild creature AI
 * Copy into thalvaeth-server fork: src/server/scripts/Custom/
 * Register AddSC_thalvaeth_creatures() from Custom script loader.
 */

#include "ThalvaethCommon.h"
#include "ThalvaethDirector.h"
#include "Creature.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

namespace Thalvaeth::Creatures
{
    enum SleeperEvents : uint8
    {
        EVENT_SLEEPER_CHECK_DISTURB = 1
    };

    enum CallerEvents : uint8
    {
        EVENT_CALLER_SHRIEK = 1
    };

    enum SnareEvents : uint8
    {
        EVENT_SNARE_HOOK = 1
    };

    enum StalkerEvents : uint8
    {
        EVENT_STALKER_PACE = 1,
        EVENT_STALKER_FLEE   = 2
    };

    struct npc_thalvaeth_sleeper : public ScriptedAI
    {
        npc_thalvaeth_sleeper(Creature* creature) : ScriptedAI(creature), _disturbed(false) { }

        void Reset() override
        {
            _disturbed = false;
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            me->SetReactState(REACT_PASSIVE);
            events.Reset();
            events.ScheduleEvent(EVENT_SLEEPER_CHECK_DISTURB, 500ms);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                if (eventId == EVENT_SLEEPER_CHECK_DISTURB && !_disturbed)
                {
                    if (Player* player = SelectNearestPlayer(10.0f))
                    {
                        if (player->IsInCombat() || player->IsRunning())
                            Wake(player);
                    }

                    if (!_disturbed)
                        events.ScheduleEvent(EVENT_SLEEPER_CHECK_DISTURB, 500ms);
                }
            }

            if (_disturbed)
                DoMeleeAttackIfReady();
        }

        void Wake(Unit* who)
        {
            _disturbed = true;
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetReactState(REACT_AGGRESSIVE);
            AttackStart(who);
            DoCast(who, SPELL_SLEEPER_RAKE);
        }

    private:
        EventMap events;
        bool _disturbed;
    };

    struct npc_thalvaeth_caller : public ScriptedAI
    {
        npc_thalvaeth_caller(Creature* creature) : ScriptedAI(creature), _shrieked(false) { }

        void Reset() override
        {
            _shrieked = false;
            events.Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            ScriptedAI::JustEngagedWith(who);
            events.ScheduleEvent(EVENT_CALLER_SHRIEK, 2s);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Director::SpawnScavengerWave(me, 3);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (events.ExecuteEvent() == EVENT_CALLER_SHRIEK && !_shrieked)
            {
                _shrieked = true;
                DoCastVictim(SPELL_CALLER_SHRIEK);
                Director::SpawnScavengerWave(me, 2);
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        bool _shrieked;
    };

    struct npc_thalvaeth_rafter : public ScriptedAI
    {
        npc_thalvaeth_rafter(Creature* creature) : ScriptedAI(creature), _leaped(false) { }

        void Reset() override
        {
            _leaped = false;
            me->SetReactState(REACT_PASSIVE);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (_leaped || !who->IsPlayer())
                return;

            if (!me->IsWithinDistInMap(who, 18.0f))
                return;

            if (!me->IsWithinDistInMap(who, 6.0f))
                return;

            if (!me->IsWithinLOSInMap(who))
                return;

            LeapTo(who->ToPlayer());
        }

        void LeapTo(Player* target)
        {
            _leaped = true;
            me->SetReactState(REACT_AGGRESSIVE);
            Position const dest = target->GetPosition();
            me->GetMotionMaster()->MoveJump(dest.GetPositionX(), dest.GetPositionY(), dest.GetPositionZ(), 18.0f, 12.0f, 0);
            me->m_Events.AddEventAtOffset([this, guid = target->GetGUID()]
            {
                if (Player* player = ObjectAccessor::GetPlayer(*me, guid))
                    AttackStart(player);
            }, 800ms);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (_leaped)
                DoMeleeAttackIfReady();
        }

    private:
        bool _leaped;
    };

    struct npc_thalvaeth_snare : public ScriptedAI
    {
        npc_thalvaeth_snare(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit* who) override
        {
            ScriptedAI::JustEngagedWith(who);
            events.ScheduleEvent(EVENT_SNARE_HOOK, 3s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (events.ExecuteEvent() == EVENT_SNARE_HOOK)
            {
                if (Unit* victim = me->GetVictim())
                {
                    if (me->IsWithinLOSInMap(victim) && me->GetDistance(victim) > 5.0f)
                        DoCast(victim, SPELL_SNARE_HOOK);
                }
                events.ScheduleEvent(EVENT_SNARE_HOOK, 8s);
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
    };

    struct npc_thalvaeth_stalker : public ScriptedAI
    {
        npc_thalvaeth_stalker(Creature* creature) : ScriptedAI(creature), _hitOnce(false) { }

        void Reset() override
        {
            _hitOnce = false;
            me->SetWalk(true);
            events.Reset();
            events.ScheduleEvent(EVENT_STALKER_PACE, 1s);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!_hitOnce)
            {
                _hitOnce = true;
                events.ScheduleEvent(EVENT_STALKER_FLEE, 0ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_STALKER_PACE:
                        if (Player* player = SelectNearestPlayer(40.0f))
                        {
                            float const dist = me->GetDistance(player);
                            if (dist < 18.0f)
                                me->GetMotionMaster()->MoveFollow(player, 22.0f, 0.0f);
                            else if (dist > 28.0f)
                                me->GetMotionMaster()->MoveFollow(player, 26.0f, 0.0f);
                        }
                        events.ScheduleEvent(EVENT_STALKER_PACE, 1500ms);
                        break;
                    case EVENT_STALKER_FLEE:
                        me->AttackStop(true);
                        me->GetMotionMaster()->MoveRandom(15.0f);
                        events.ScheduleEvent(EVENT_STALKER_PACE, 8s);
                        _hitOnce = false;
                        break;
                    default:
                        break;
                }
            }

            if (me->IsInCombat())
                DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        bool _hitOnce;
    };

    struct npc_thalvaeth_brute : public ScriptedAI
    {
        npc_thalvaeth_brute(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            me->SetReactState(REACT_DEFENSIVE);
            me->SetWalk(true);
            _home = me->GetPosition();
            _leashRadius = 12.0f;
        }

        void JustEngagedWith(Unit* who) override
        {
            ScriptedAI::JustEngagedWith(who);
            DoCastVictim(SPELL_BRUTE_STOMP);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            if (me->GetDistance(_home) > _leashRadius)
            {
                EnterEvadeMode();
                me->NearTeleportTo(_home.GetPositionX(), _home.GetPositionY(), _home.GetPositionZ(), _home.GetOrientation());
                return;
            }

            DoMeleeAttackIfReady();
        }

    private:
        Position _home;
        float _leashRadius;
    };
}

void AddSC_thalvaeth_creatures()
{
    using namespace Thalvaeth::Creatures;
    RegisterCreatureAI(npc_thalvaeth_sleeper);
    RegisterCreatureAI(npc_thalvaeth_caller);
    RegisterCreatureAI(npc_thalvaeth_rafter);
    RegisterCreatureAI(npc_thalvaeth_snare);
    RegisterCreatureAI(npc_thalvaeth_stalker);
    RegisterCreatureAI(npc_thalvaeth_brute);
}
