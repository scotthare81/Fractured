/*
 * Thal'vaeth — shared constants (copy with other Custom scripts)
 */

#ifndef THALVAETH_COMMON_H
#define THALVAETH_COMMON_H

#include "Chat.h"
#include "Player.h"
#include "WorldPacket.h"

namespace Thalvaeth
{
    // Addon wire format: "THALVAETH\t<opcode>~<payload>"
    inline constexpr char ADDON_PREFIX[] = "THALVAETH";
    inline constexpr char ADDON_FIELD_SEP = '~';

    // Wild creature entry band (world DB)
    enum CreatureEntries : uint32
    {
        ENTRY_SLEEPER    = 90001,
        ENTRY_SCAVENGER  = 90002,
        ENTRY_RAFTER     = 90003,
        ENTRY_CALLER     = 90004,
        ENTRY_BRUTE      = 90005,
        ENTRY_SNARE      = 90006,
        ENTRY_STALKER    = 90007,
        ENTRY_DRIFTER    = 90008,
        ENTRY_STUMBLER   = 90009,
        ENTRY_GHOUL      = 90010,

        ENTRY_BAND_MIN   = 90001,
        ENTRY_BAND_MAX   = 90010
    };

    // Vanilla spell IDs used as ability stand-ins (tune in POC)
    enum Spells : uint32
    {
        SPELL_SLEEPER_RAKE     = 48256, // Claw Rampage — brutal opener
        SPELL_CALLER_SHRIEK    = 38607, // Terrifying Screech
        SPELL_SNARE_HOOK       = 49366, // Grab (Gundrak pull)
        SPELL_BRUTE_STOMP      = 42723, // Stomp
        SPELL_GHOUL_FRENZY     = 8599   // Enrage on rush
    };

    inline bool IsWildCatalogEntry(uint32 entry)
    {
        return entry >= ENTRY_BAND_MIN && entry <= ENTRY_BAND_MAX;
    }

    inline void SendAddonMessage(Player* player, std::string_view opcode, std::string_view payload = {},
        ChatMsg chatType = CHAT_MSG_WHISPER)
    {
        if (!player || !player->GetSession())
            return;

        std::string wire = std::string(ADDON_PREFIX) + "\t" + std::string(opcode);
        if (!payload.empty())
            wire += std::string(1, ADDON_FIELD_SEP) + std::string(payload);

        WorldPacket data;
        ChatHandler::BuildChatPacket(data, chatType, LANG_ADDON, player, nullptr, wire.c_str());
        player->SendDirectMessage(&data);
    }
}

#endif
