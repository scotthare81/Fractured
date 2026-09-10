-- Thal'vaeth — Rotwood (first outdoor run district, map 0, Duskwood worgen cluster)
-- Player name: docs/NAMES.md. Bounded by gate shell — see rev_thalvaeth_run_gates.sql

-- Run zone: corruption on, Director on, Duskwood fog native
DELETE FROM `areatrigger_scripts` WHERE `entry` = 90002;
DELETE FROM `areatrigger` WHERE `entry` = 90002;
INSERT INTO `areatrigger` (`entry`, `map`, `x`, `y`, `z`, `radius`, `length`, `width`, `height`, `orientation`) VALUES
(90002, 0, -10736.0, -857.0, 55.0, 320.0, 0, 0, 0, 0);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(90002, 'at_thalvaeth_rotwood');

-- Run entry spawn (port from Hearthglen — south approach toward Darkshire)
DELETE FROM `game_graveyard` WHERE `ID` = 90002;
INSERT INTO `game_graveyard` (`ID`, `Map`, `x`, `y`, `z`, `Comment`) VALUES
(90002, 0, -10850.0, -1150.0, 52.0, 'Thalvaeth - Rotwood entry');

-- Ash Hollow breather (once per run) — small AT inside Brightwood Grove
DELETE FROM `areatrigger_scripts` WHERE `entry` = 90003;
DELETE FROM `areatrigger` WHERE `entry` = 90003;
INSERT INTO `areatrigger` (`entry`, `map`, `x`, `y`, `z`, `radius`, `length`, `width`, `height`, `orientation`) VALUES
(90003, 0, -10520.0, -810.0, 50.0, 12.0, 0, 0, 0, 0);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(90003, 'at_thalvaeth_ash_hollow');

-- TODO: phase 2 for Remnants on run start
-- TODO: strip vanilla Duskwood spawns (incl. Nightbane worgen) inside AT 90002 on instance boot
