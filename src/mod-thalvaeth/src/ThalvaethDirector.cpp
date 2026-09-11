/*
 * Thal'vaeth — Director stub implementation
 */

#include "ThalvaethDirector.h"
#include "Creature.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Random.h"
#include "Weather.h"

#include <algorithm>

namespace Thalvaeth::Director
{
    void SpawnScavengerWave(Creature* anchor, uint8 count)
    {
        if (!anchor || !anchor->IsInWorld())
            return;

        Map* map = anchor->GetMap();
        if (!map)
            return;

        Position const pos = anchor->GetPosition();
        float const orient = anchor->GetOrientation();

        for (uint8 i = 0; i < count; ++i)
        {
            float const angle = orient + static_cast<float>(i) * (6.2831853f / count);
            float const dist = 4.0f + frand(0.0f, 3.0f);
            float const x = pos.GetPositionX() + std::cos(angle) * dist;
            float const y = pos.GetPositionY() + std::sin(angle) * dist;
            float const z = pos.GetPositionZ();

            if (Creature* spawn = map->SummonCreature(ENTRY_SCAVENGER, { x, y, z, angle },
                    TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000, 0, 0, 0, anchor->GetGUID()))
            {
                if (Unit* victim = anchor->GetVictim())
                    spawn->AI()->AttackStart(victim);
            }
        }
    }

    void NotifyNoise(Unit* /*source*/, float /*radius*/, uint8 /*intensity*/)
    {
        // TODO: weight Ghoul/Stalker spawns; wake nearby Sleepers via map creature search
    }

    void SetRunFog(Map* map, uint32 zoneId, float intensity)
    {
        if (!map)
            return;

        // Mor'Ladim hill look = Duskwood baked fog. Two layers:
        // 1) SetZoneOverrideLight with Duskwood light ID (MPQ/doc: capture from zone 10)
        // 2) WEATHER_STATE_FOG packet for dynamic peaks (Director budget)
        float const grade = std::clamp(intensity, 0.0f, 0.9999f);
        map->SetZoneWeather(zoneId, WEATHER_STATE_FOG, grade);
    }

    void ClearRunFog(Map* map, uint32 zoneId)
    {
        if (!map)
            return;

        map->SetZoneWeather(zoneId, WEATHER_STATE_FINE, 0.0f);
    }
}
