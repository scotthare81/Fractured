-- Thal'vaeth Monastery — home (map 0, Hearthglen outdoor grounds)
-- Aesthetic: Brill/Tirisfal grey via MPQ (see client/mpq/README.md)
-- Runs = Rotwood (map 0 outdoor Duskwood). Ash Hollow breather inside Rotwood AT 90003.

DELETE FROM `game_graveyard` WHERE `ID` = 90001;
INSERT INTO `game_graveyard` (`ID`, `Map`, `x`, `y`, `z`, `Comment`) VALUES
(90001, 0, 2793.09, -1621.40, 129.33, 'Thalvaeth Monastery - Hearthglen');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 90001;
DELETE FROM `areatrigger` WHERE `entry` = 90001;
INSERT INTO `areatrigger` (`entry`, `map`, `x`, `y`, `z`, `radius`, `length`, `width`, `height`, `orientation`) VALUES
(90001, 0, 2793.09, -1621.40, 129.33, 120.0, 0, 0, 0, 0);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(90001, 'at_thalvaeth_monastery');

-- TODO: phase mask + despawn vanilla Hearthglen NPCs inside AT 90001
-- TODO: hide crusader banners/GOs in bounds (or MPQ)
-- TODO: NPC/GO "Enter Rotwood" → teleport to graveyard 90002
-- TODO: extract/death from Rotwood → teleport (2793, -1621, 129)
