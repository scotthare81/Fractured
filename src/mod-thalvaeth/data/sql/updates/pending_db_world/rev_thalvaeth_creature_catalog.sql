-- Thal'vaeth — creature catalog + Wild templates (world DB)
-- Module SQL (mod-thalvaeth) — applies via module data/sql, or copy to core: data/sql/updates/pending_db_world/
-- Entry band 90001–90010. Display IDs per docs/CREATURES.md (locked).

-- ---------------------------------------------------------------------------
-- Catalog (journal / UI)
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS `thalvaeth_creature_catalog`;
CREATE TABLE `thalvaeth_creature_catalog` (
  `entry` int unsigned NOT NULL,
  `journal_name` varchar(64) NOT NULL,
  `sighted_description` varchar(512) NOT NULL,
  `tags` varchar(128) NOT NULL DEFAULT '',
  `archetype` varchar(32) NOT NULL,
  `silhouette_icon` int unsigned NOT NULL DEFAULT '0',
  `ability_map` text,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `thalvaeth_creature_catalog` WHERE `entry` BETWEEN 90001 AND 90010;
INSERT INTO `thalvaeth_creature_catalog`
  (`entry`, `journal_name`, `sighted_description`, `tags`, `archetype`, `ability_map`) VALUES
(90001, 'Ash Sleeper', 'Crouched like sleep. Eyes open. Don''t run past it.', 'sleeper,special', 'sleeper', NULL),
(90002, 'Cellar Scavenger', 'Picks at the rubble. Still has hands.', 'scavenger', 'scavenger', NULL),
(90003, 'Catwalk Prowler', 'Someone on the catwalk. Not moving. Yet.', 'rafter,special', 'rafter', '{"leap":{"name":"Drops from the rail","note":"Leap from above."}}'),
(90004, 'Ash Caller', 'Hand over mouth. Waiting to scream.', 'caller,special', 'caller', '{"shriek":{"name":"Shrieks for help","note":"More Scavengers answer."}}'),
(90005, 'Patchwork Brute', 'Stitched to stand guard. Still is.', 'brute,special', 'brute', NULL),
(90006, 'Broken Snare', 'Wrong shoulder. Still throws a line.', 'snare,special', 'snare', '{"hook":{"name":"Throws a hook","note":"Drags you into the choke."}}'),
(90007, 'Edge Stalker', 'Parallel. Never closer. Never leaving.', 'stalker,special', 'stalker', NULL),
(90008, 'Drifter', 'Wrong gait. Won''t meet your eyes.', 'drifter', 'drifter', NULL),
(90009, 'Stumbler', 'Shouldn''t stand. Does anyway.', 'stumbler', 'stumbler', NULL),
(90010, 'Ghoul', 'All teeth. Used to be a jaw.', 'ghoul', 'ghoul', NULL);

-- ---------------------------------------------------------------------------
-- creature_template — name matches journal_name (docs/NAMES.md)
-- Faction 14 = monster. type 6 humanoid, 7 undead for ghouls.
-- ---------------------------------------------------------------------------
DELETE FROM `creature_template_model` WHERE `CreatureID` BETWEEN 90001 AND 90010;
DELETE FROM `creature_template` WHERE `entry` BETWEEN 90001 AND 90010;

INSERT INTO `creature_template`
  (`entry`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `speed_walk`, `speed_run`, `rank`,
   `unit_class`, `unit_flags`, `type`, `AIName`, `HealthModifier`, `DamageModifier`, `ScriptName`, `VerifiedBuild`) VALUES
(90001, 'Ash Sleeper', '', 24, 24, 14, 0.8, 1.4, 1, 1, 0, 6, '', 8, 2.5, 'npc_thalvaeth_sleeper', 12340),
(90002, 'Cellar Scavenger', '', 22, 22, 14, 0.9, 1.1, 0, 1, 0, 6, 'SmartAI', 1.2, 1, '', 12340),
(90003, 'Catwalk Prowler', '', 23, 23, 14, 1, 1.3, 0, 1, 0, 6, '', 2, 1.5, 'npc_thalvaeth_rafter', 12340),
(90004, 'Ash Caller', '', 22, 22, 14, 1, 1.2, 0, 1, 0, 6, '', 1.5, 1, 'npc_thalvaeth_caller', 12340),
(90005, 'Patchwork Brute', '', 25, 25, 14, 0.7, 1, 1, 1, 0, 6, '', 12, 2, 'npc_thalvaeth_brute', 12340),
(90006, 'Broken Snare', '', 24, 24, 14, 1, 1.1, 0, 1, 0, 6, '', 3, 1.2, 'npc_thalvaeth_snare', 12340),
(90007, 'Edge Stalker', '', 23, 23, 14, 1, 1.2, 0, 1, 0, 6, '', 2, 1, 'npc_thalvaeth_stalker', 12340),
(90008, 'Drifter', '', 21, 21, 14, 0.85, 1, 0, 1, 0, 6, 'SmartAI', 1, 0.9, '', 12340),
(90009, 'Stumbler', '', 22, 22, 14, 0.6, 0.9, 0, 1, 0, 7, 'SmartAI', 2.5, 1.1, '', 12340),
(90010, 'Ghoul', '', 23, 23, 14, 1, 1.4, 0, 1, 0, 7, 'SmartAI', 1.8, 1.3, '', 12340);

INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(90001, 0, 22844, 1, 1, 12340),
(90002, 0, 10973, 1, 1, 12340),
(90003, 0, 22843, 1, 1, 12340),
(90004, 0, 14537, 1, 1, 12340),
(90005, 0, 7858, 1, 1, 12340),
(90006, 0, 4688, 1, 1, 12340),
(90007, 0, 22845, 1, 1, 12340),
(90008, 0, 15513, 1, 1, 12340),
(90009, 0, 559, 1, 1, 12340),
(90010, 0, 10626, 1, 1, 12340);
