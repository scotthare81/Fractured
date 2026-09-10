/*
 * Thal'vaeth — Creature journal (sighted / engaged) + ThalvaethUI addon sync
 */

#include "ThalvaethCommon.h"
#include "CharacterDatabase.h"
#include "Creature.h"
#include "GameTime.h"
#include "ObjectAccessor.h"
#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "StringFormat.h"
#include "UnitScript.h"

#include <list>

namespace Thalvaeth::Journal
{
    namespace
    {
        uint32 NowUnix()
        {
            return static_cast<uint32>(GameTime::GetGameTime().count());
        }

        void UpsertJournal(Player* player, uint32 entry, bool engaged, uint32 healthMax = 0)
        {
            if (!player)
                return;

            uint32 const now = NowUnix();
            if (engaged)
            {
                CharacterDatabase.Execute(
                    "INSERT INTO thalvaeth_player_creature_journal (guid, creature_entry, sighted_at, engaged_at, observed_health_max) "
                    "VALUES ({}, {}, {}, {}, {}) "
                    "ON DUPLICATE KEY UPDATE engaged_at = VALUES(engaged_at), "
                    "observed_health_max = IFNULL(VALUES(observed_health_max), observed_health_max)",
                    player->GetGUID().GetCounter(), entry, now, now, healthMax);
            }
            else
            {
                CharacterDatabase.Execute(
                    "INSERT INTO thalvaeth_player_creature_journal (guid, creature_entry, sighted_at) "
                    "VALUES ({}, {}, {}) "
                    "ON DUPLICATE KEY UPDATE sighted_at = IF(sighted_at = 0, VALUES(sighted_at), sighted_at)",
                    player->GetGUID().GetCounter(), entry, now);
            }
        }

        void PushJournalUpdate(Player* player, uint32 entry, char const* tier)
        {
            SendAddonMessage(player, "JOURNAL", Acore::StringFormat("{}~{}", entry, tier));
        }

        bool HandleAddonPayload(Player* player, std::string const& payload)
        {
            auto const [opcode, rest] = [&payload]() -> std::pair<std::string, std::string>
            {
                size_t const sep = payload.find(ADDON_FIELD_SEP);
                if (sep == std::string::npos)
                    return { payload, {} };
                return { payload.substr(0, sep), payload.substr(sep + 1) };
            }();

            if (opcode == "SIGHTED")
            {
                Creature* creature = nullptr;
                float bestDist = 25.0f;

                if (Unit* target = ObjectAccessor::GetUnit(*player, player->GetTarget()))
                    creature = target->ToCreature();

                if (!creature || !IsWildCatalogEntry(creature->GetEntry()) || !player->IsWithinDistInMap(creature, 25.0f))
                {
                    creature = nullptr;
                    for (uint32 entry = ENTRY_BAND_MIN; entry <= ENTRY_BAND_MAX; ++entry)
                    {
                        std::list<Creature*> nearby;
                        player->GetCreatureListWithEntryInGrid(nearby, entry, 25.0f);
                        for (Creature* candidate : nearby)
                        {
                            if (!candidate)
                                continue;

                            float const dist = player->GetDistance(candidate);
                            if (dist < bestDist)
                            {
                                bestDist = dist;
                                creature = candidate;
                            }
                        }
                    }
                }

                if (!creature)
                    return true;

                UpsertJournal(player, creature->GetEntry(), false);
                PushJournalUpdate(player, creature->GetEntry(), "sighted");
                return true;
            }

            return false;
        }
    }

    class ThalvaethJournalUnitScript : public UnitScript
    {
    public:
        ThalvaethJournalUnitScript() : UnitScript("ThalvaethJournalUnitScript", { UNITHOOK_ON_UNIT_ENTER_COMBAT })
        {
        }

        void OnUnitEnterCombat(Unit* unit, Unit* victim) override
        {
            if (!unit || !victim || !victim->IsPlayer())
                return;

            Creature* creature = unit->ToCreature();
            if (!creature)
                return;

            uint32 const entry = creature->GetEntry();
            if (!IsWildCatalogEntry(entry))
                return;

            Player* player = victim->ToPlayer();
            UpsertJournal(player, entry, true, creature->GetMaxHealth());
            PushJournalUpdate(player, entry, "engaged");
        }
    };

    class ThalvaethJournalPlayerScript : public PlayerScript
    {
    public:
        ThalvaethJournalPlayerScript() : PlayerScript("ThalvaethJournalPlayerScript",
            { PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT, PLAYERHOOK_ON_LOGIN })
        {
        }

        void OnPlayerLogin(Player* player) override
        {
            SendAddonMessage(player, "HELLO", "1");
        }

        bool OnPlayerCanUseChat(Player* player, uint32 /*type*/, uint32 lang, std::string& msg, Player* /*receiver*/) override
        {
            if (lang != LANG_ADDON)
                return true;

            std::string payload = msg;
            if (payload.rfind(ADDON_PREFIX, 0) == 0)
            {
                payload.erase(0, sizeof(ADDON_PREFIX) - 1);
                while (!payload.empty() && (payload.front() == '\t' || payload.front() == ' '))
                    payload.erase(payload.begin());
            }

            if (HandleAddonPayload(player, payload))
            {
                msg.clear();
                return false;
            }

            return true;
        }
    };
}

void AddSC_thalvaeth_creature_journal()
{
    new Thalvaeth::Journal::ThalvaethJournalUnitScript();
    new Thalvaeth::Journal::ThalvaethJournalPlayerScript();
}
