-- Thal'vaeth — Rotwood creature POC (map 0, Duskwood worgen cluster)
-- Home = Hearthglen. Gates = rev_thalvaeth_run_gates.sql

DELETE FROM `creature` WHERE `id1` BETWEEN 90001 AND 90010 AND `map` = 0
  AND `position_x` BETWEEN -11150 AND -10350 AND `position_y` BETWEEN -1220 AND -540;

-- POC path: entry yard → Scavengers → [gate 1] → Sleeper → Caller → [gate 2] → Brute / Snare → Extract
INSERT INTO `creature`
  (`id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
   `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(90002, 0, 0, 0, 1, 2, 0, -10840.0, -1120.0, 52.0, 0.0, 300, 6, 1, 12340),
(90002, 0, 0, 0, 1, 2, 0, -10830.0, -1110.0, 52.0, 1.2, 300, 6, 1, 12340),
(90001, 0, 0, 0, 1, 2, 0, -10780.0, -980.0, 52.0, 3.14, 300, 0, 0, 12340),
(90004, 0, 0, 0, 1, 2, 0, -10720.0, -920.0, 51.0, 2.5, 300, 0, 0, 12340),
(90005, 0, 0, 0, 1, 2, 0, -10650.0, -850.0, 51.0, 0.0, 300, 0, 0, 12340),
(90006, 0, 0, 0, 1, 2, 0, -10620.0, -820.0, 50.0, 4.7, 300, 0, 0, 12340),
(90008, 0, 0, 0, 1, 2, 0, -10800.0, -1090.0, 52.0, 0.8, 300, 8, 1, 12340),
(90009, 0, 0, 0, 1, 2, 0, -10680.0, -880.0, 51.0, 2.0, 300, 3, 1, 12340);
