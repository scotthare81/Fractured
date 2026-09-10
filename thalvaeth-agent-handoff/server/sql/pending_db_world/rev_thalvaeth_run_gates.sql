-- Thal'vaeth — Rotwood gate objects (map 0, Duskwood worgen cluster)
-- Shell ring + segment gates + extract. Tune positions in GM mode.

DELETE FROM `gameobject` WHERE `id` BETWEEN 91001 AND 91020 AND `map` = 0;
DELETE FROM `gameobject_template` WHERE `entry` BETWEEN 91001 AND 91005;

-- Templates (clone stock collision models)
INSERT INTO `gameobject_template`
  (`entry`, `type`, `displayId`, `name`, `size`, `Data0`, `Data1`, `ScriptName`, `VerifiedBuild`) VALUES
(91001, 5, 6157, 'Rotwood Fence', 1.0, 0, 1, '', 12340),
(91002, 5, 9384, 'Rotwood Wall', 1.0, 0, 1, '', 12340),
(91003, 0, 411, 'Rotwood Segment Gate', 2.0, 0, 3000, 'go_thalvaeth_gate_segment', 12340),
(91004, 0, 411, 'Rotwood Extract Gate', 2.5, 0, 3000, 'go_thalvaeth_gate_extract', 12340),
(91005, 0, 411, 'Rotwood Run Blocker', 1.0, 0, 3000, '', 12340);

-- POC layout: entry (south) → segment1 → Brightwood → segment2 → Rotting Orchard → extract (north)

-- Shell — south entry line (closed; run starts inside)
INSERT INTO `gameobject`
  (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `VerifiedBuild`) VALUES
(910001, 91001, 0, 0, 0, 1, 1, -10980.0, -1180.0, 52.0, 0.0, 0, 0, 0, 1, 300, 12340),
(910002, 91001, 0, 0, 0, 1, 1, -10920.0, -1180.0, 52.0, 0.0, 0, 0, 0, 1, 300, 12340),
(910003, 91001, 0, 0, 0, 1, 1, -10860.0, -1180.0, 52.0, 0.0, 0, 0, 0, 1, 300, 12340),
(910004, 91001, 0, 0, 0, 1, 1, -10800.0, -1180.0, 52.0, 0.0, 0, 0, 0, 1, 300, 12340),

-- Shell — west side (Rotting Orchard flank)
(910005, 91001, 0, 0, 0, 1, 1, -11080.0, -1100.0, 54.0, 1.5708, 0, 0, 0, 1, 300, 12340),
(910006, 91001, 0, 0, 0, 1, 1, -11080.0, -950.0, 54.0, 1.5708, 0, 0, 0, 1, 300, 12340),
(910007, 91001, 0, 0, 0, 1, 1, -11080.0, -800.0, 54.0, 1.5708, 0, 0, 0, 1, 300, 12340),

-- Shell — east side (Brightwood Grove flank)
(910008, 91001, 0, 0, 0, 1, 1, -10400.0, -950.0, 50.0, 1.5708, 0, 0, 0, 1, 300, 12340),
(910009, 91001, 0, 0, 0, 1, 1, -10400.0, -800.0, 50.0, 1.5708, 0, 0, 0, 1, 300, 12340),
(910010, 91001, 0, 0, 0, 1, 1, -10400.0, -650.0, 50.0, 1.5708, 0, 0, 0, 1, 300, 12340),

-- Shell — north (except extract gap)
(910011, 91002, 0, 0, 0, 1, 1, -10900.0, -580.0, 58.0, 0.0, 0, 0, 0, 1, 300, 12340),
(910012, 91002, 0, 0, 0, 1, 1, -10600.0, -580.0, 58.0, 0.0, 0, 0, 0, 1, 300, 12340),

-- Segment gates (Director opens)
(910013, 91003, 0, 0, 0, 1, 1, -10750.0, -1000.0, 52.5, 0.0, 0, 0, 0, 1, 300, 12340),
(910014, 91003, 0, 0, 0, 1, 1, -10600.0, -870.0, 51.0, 1.5708, 0, 0, 0, 1, 300, 12340),

-- Extract gate (north — interact to leave run)
(910015, 91004, 0, 0, 0, 1, 1, -10736.0, -620.0, 55.0, 0.0, 0, 0, 0, 1, 300, 12340);
