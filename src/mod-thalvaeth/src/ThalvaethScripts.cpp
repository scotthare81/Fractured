/*
 * Thalvaeth module stubs (Step 2).
 * Survival meters, Gate (bots blocked), death → morgue.
 * No real meters, no teleport, no instance IDs yet.
 */

#include "Chat.h"
#include "Config.h"
#include "GameObject.h"
#include "Log.h"
#include "Player.h"
#include "ScriptMgr.h"

namespace
{
    bool ThalvaethEnabled()
    {
        return sConfigMgr->GetOption<bool>("Thalvaeth.Enable", true);
    }

    // Playerbots is not on this server yet. Keep the call site so Gate
    // can grow a real check without a new hook.
    bool ThalvaethIsBot(Player const* player)
    {
        if (!player || !player->GetSession())
            return true;

        return false;
    }
}

class ThalvaethWorldScript : public WorldScript
{
public:
    ThalvaethWorldScript() : WorldScript("ThalvaethWorldScript", {
        WORLDHOOK_ON_STARTUP,
        WORLDHOOK_ON_BEFORE_CONFIG_LOAD
    }) { }

    void OnBeforeConfigLoad(bool /*reload*/) override { }

    void OnStartup() override
    {
        if (!ThalvaethEnabled())
            return;

        LOG_INFO("module", "Thal'vaeth: module loaded (stubs: survival, Gate, death).");
    }
};

class ThalvaethPlayerScript : public PlayerScript
{
public:
    ThalvaethPlayerScript() : PlayerScript("ThalvaethPlayerScript", {
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_UPDATE,
        PLAYERHOOK_ON_PLAYER_JUST_DIED,
        PLAYERHOOK_ON_PLAYER_RELEASED_GHOST
    }) { }

    void OnPlayerLogin(Player* player) override
    {
        if (!ThalvaethEnabled() || !player)
            return;

        ChatHandler(player->GetSession()).PSendSysMessage(
            "Thal'vaeth: survival meters, Gate, and morgue are stubs.");
    }

    // Step 4 will tick Hunger / Thirst / Infection here.
    void OnPlayerUpdate(Player* /*player*/, uint32 /*p_time*/) override { }

    void OnPlayerJustDied(Player* player) override
    {
        if (!ThalvaethEnabled() || !player)
            return;

        // L2: haul lost, Infection spike, Fevered debuff — later.
        LOG_DEBUG("module", "Thal'vaeth: {} died (morgue stub).", player->GetName());
    }

    void OnPlayerReleasedGhost(Player* player) override
    {
        if (!ThalvaethEnabled() || !player)
            return;

        // Step 3 assigns Monastery map/instance IDs; then this teleports
        // to the morgue instead of a corpse run.
        ChatHandler(player->GetSession()).PSendSysMessage(
            "Thal'vaeth: you would wake in the Monastery morgue (stub).");
    }
};

class ThalvaethGateScript : public GameObjectScript
{
public:
    ThalvaethGateScript() : GameObjectScript("go_thalvaeth_gate") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (!ThalvaethEnabled() || !player)
            return true;

        if (sConfigMgr->GetOption<bool>("Thalvaeth.Gate.BlockBots", true) && ThalvaethIsBot(player))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Thal'vaeth: bots stop at the Gate.");
            return true;
        }

        ChatHandler(player->GetSession()).PSendSysMessage(
            "Thal'vaeth: Gate would load Rotwood (stub).");
        return true;
    }
};

void AddThalvaethScripts()
{
    new ThalvaethWorldScript();
    new ThalvaethPlayerScript();
    new ThalvaethGateScript();
}
