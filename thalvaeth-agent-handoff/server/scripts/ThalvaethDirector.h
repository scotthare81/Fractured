/*
 * Thal'vaeth — Stress Director stub (wave budget, noise hooks)
 * Replace internals when full Director module lands.
 */

#ifndef THALVAETH_DIRECTOR_H
#define THALVAETH_DIRECTOR_H

#include "ThalvaethCommon.h"

class Creature;
class Unit;

namespace Thalvaeth::Director
{
    // Spawn Scavengers around anchor (Caller death / shriek)
    void SpawnScavengerWave(Creature* anchor, uint8 count = 3);

    // Future: noise from Hustle, lockpick fail, combat volume
    void NotifyNoise(Unit* source, float radius, uint8 intensity);

    // Run atmosphere — Duskwood / Mor'Ladim hill fog (see docs/MAPS.md)
    void SetRunFog(class Map* map, uint32 zoneId, float intensity);
    void ClearRunFog(class Map* map, uint32 zoneId);
}

#endif
