-- Thal'vaeth — player creature journal (characters DB)
-- Copy to thalvaeth-server fork: data/sql/updates/pending_db_characters/

DROP TABLE IF EXISTS `thalvaeth_player_creature_journal`;
CREATE TABLE `thalvaeth_player_creature_journal` (
  `guid` int unsigned NOT NULL,
  `creature_entry` int unsigned NOT NULL,
  `sighted_at` int unsigned NOT NULL DEFAULT '0',
  `engaged_at` int unsigned DEFAULT NULL,
  `observed_health_max` int unsigned DEFAULT NULL,
  `observed_abilities` text,
  PRIMARY KEY (`guid`, `creature_entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
