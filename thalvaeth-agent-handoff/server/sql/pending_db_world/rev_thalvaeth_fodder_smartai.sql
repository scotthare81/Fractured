-- Thal'vaeth — SmartAI for fodder (90002, 90008–90010)
-- Copy to thalvaeth-server fork pending_db_world

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (90002, 90008, 90009, 90010) AND `source_type` = 0;

-- Scavenger: wander OOC, melee in combat
INSERT INTO `smart_scripts`
  (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
   `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`,
   `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`,
   `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(90002, 0, 0, 0, 1, 0, 100, 0, 5000, 5000, 10000, 15000, 0, 89, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
 'Cellar Scavenger - OOC - Random move'),
(90002, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 6000, 9000, 0, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
 'Cellar Scavenger - IC - Cast Rend'),

-- Drifter: slow wander, delayed aggro
(90008, 0, 0, 0, 1, 0, 100, 0, 8000, 8000, 15000, 25000, 0, 89, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
 'Drifter - OOC - Random move'),

-- Stumbler: cleave in combat
(90009, 0, 0, 0, 0, 0, 100, 0, 3000, 8000, 8000, 12000, 0, 11, 40505, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
 'Stumbler - IC - Cast Cleave'),

-- Ghoul: enrage below 40% HP
(90010, 0, 0, 1, 2, 0, 100, 1, 0, 40, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
 'Ghoul - HP 0-40% - Cast Enrage'),
(90010, 0, 1, 0, 0, 0, 100, 0, 2000, 5000, 5000, 8000, 0, 11, 11977, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0,
 'Ghoul - IC - Cast Rend');
