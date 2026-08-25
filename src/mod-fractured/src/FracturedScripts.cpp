/*
 * Fractured module stubs (Step 2).
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
    bool FracturedEnabled()
    {
        return sConfigMgr->GetOption<bool>("Fractured.Enable", true);
    }

    // Playerbots is not on this server yet. Keep the call site so Gate
    // can grow a real check without a new hook.
    bool FracturedIsBot(Player const* player)
    {
        if (!player || !player->GetSession())
            return true;

        return false;
    }
}

class FracturedWorldScript : public WorldScript
{
public:
    FracturedWorldScript() : WorldScript("FracturedWorldScript", {
        WORLDHOOK_ON_STARTUP,
        WORLDHOOK_ON_BEFORE_CONFIG_LOAD
    }) { }

    void OnBeforeConfigLoad(bool /*reload*/) override { }

    void OnStartup() override
    {
        if (!FracturedEnabled())
            return;

        LOG_INFO("module", "Fractured: module loaded (stubs: survival, Gate, death).");
    }
};

class FracturedPlayerScript : public PlayerScript
{
public:
    FracturedPlayerScript() : PlayerScript("FracturedPlayerScript", {
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_UPDATE,
        PLAYERHOOK_ON_PLAYER_JUST_DIED,
        PLAYERHOOK_ON_PLAYER_RELEASED_GHOST
    }) { }

    void OnPlayerLogin(Player* player) override
    {
        if (!FracturedEnabled() || !player)
            return;

        ChatHandler(player->GetSession()).PSendSysMessage(
            "Fractured: survival meters, Gate, and morgue are stubs.");
    }

    // Step 4 will tick Hunger / Thirst / Corruption here.
    void OnPlayerUpdate(Player* /*player*/, uint32 /*p_time*/) override { }

    void OnPlayerJustDied(Player* player) override
    {
        if (!FracturedEnabled() || !player)
            return;

        // L2: haul lost, Corruption spike, Fractured debuff — later.
        LOG_DEBUG("module", "Fractured: {} died (morgue stub).", player->GetName());
    }

    void OnPlayerReleasedGhost(Player* player) override
    {
        if (!FracturedEnabled() || !player)
            return;

        // Step 3 assigns Sanctuary map/instance IDs; then this teleports
        // to the morgue instead of a corpse run.
        ChatHandler(player->GetSession()).PSendSysMessage(
            "Fractured: you would wake in the Sanctuary morgue (stub).");
    }
};

class FracturedGateScript : public GameObjectScript
{
public:
    FracturedGateScript() : GameObjectScript("go_fractured_gate") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (!FracturedEnabled() || !player)
            return true;

        if (sConfigMgr->GetOption<bool>("Fractured.Gate.BlockBots", true) && FracturedIsBot(player))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "Fractured: bots stop at the Gate.");
            return true;
        }

        ChatHandler(player->GetSession()).PSendSysMessage(
            "Fractured: Gate would load Mouth (stub).");
        return true;
    }
};

void AddFracturedScripts()
{
    new FracturedWorldScript();
    new FracturedPlayerScript();
    new FracturedGateScript();
}
