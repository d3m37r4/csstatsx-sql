CREATE TABLE `csstats_maps` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`session_id` int(11) NOT NULL,
	`player_id` int(11) NOT NULL,
	`map` varchar(32) NOT NULL,
	`skill` float NOT NULL DEFAULT '0.0',
	`kills` int(11) NOT NULL DEFAULT '0',
	`deaths` int(11) NOT NULL DEFAULT '0',
	`hs` int(11) NOT NULL DEFAULT '0',
	`tks` int(11) NOT NULL DEFAULT '0',
	`shots` int(11) NOT NULL DEFAULT '0',
	`hits` int(11) NOT NULL DEFAULT '0',
	`dmg` int(11) NOT NULL DEFAULT '0',
	`bombdef` int(11) NOT NULL DEFAULT '0',
	`bombdefused` int(11) NOT NULL DEFAULT '0',
	`bombplants` int(11) NOT NULL DEFAULT '0',
	`bombexplosions` int(11) NOT NULL DEFAULT '0',
	`h_0` int(11) NOT NULL DEFAULT '0',
	`h_1` int(11) NOT NULL DEFAULT '0',
	`h_2` int(11) NOT NULL DEFAULT '0',
	`h_3` int(11) NOT NULL DEFAULT '0',
	`h_4` int(11) NOT NULL DEFAULT '0',
	`h_5` int(11) NOT NULL DEFAULT '0',
	`h_6` int(11) NOT NULL DEFAULT '0',
	`h_7` int(11) NOT NULL DEFAULT '0',
	`connection_time` int(11) NOT NULL DEFAULT '0',
	`connects` INT NOT NULL DEFAULT '0',
	`roundt` INT NOT NULL DEFAULT '0',
	`wint` INT NOT NULL DEFAULT '0',
	`roundct` INT NOT NULL DEFAULT '0',
	`winct` INT NOT NULL DEFAULT '0',
	`first_join` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`last_join` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
	PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

DELIMITER //
CREATE TRIGGER `map_stats` AFTER UPDATE ON `csstats`
 FOR EACH ROW BEGIN
	IF EXISTS (SELECT 1 FROM `csstats_maps` WHERE `player_id` = NEW.`id` AND `session_id` = NEW.`session_id`)
	THEN
		UPDATE `csstats_maps` SET
			`skill` = `skill` + (NEW.`skill` - OLD.`skill`),
			`kills` = `kills` + (NEW.`kills` - OLD.`kills`),
			`deaths` = `deaths` + (NEW.`deaths` - OLD.`deaths`),
			`hs` = `hs` + (NEW.`hs`  - OLD.`hs`),
			`tks` = `tks` + (NEW.`tks` - OLD.`tks`),
			`shots` = `shots`+ (NEW.`shots` - OLD.`shots`),
			`hits` = `hits` + (NEW.`hits` - OLD.`hits`),
			`dmg` = `dmg` + (NEW.`dmg` - OLD.`dmg`),
			`bombdef` = `bombdef` + (NEW.`bombdef` - OLD.`bombdef`),
			`bombdefused` = `bombdefused` + (NEW.`bombdefused` - OLD.`bombdefused`),
			`bombplants` = `bombplants` + (NEW.`bombplants` - OLD.`bombplants`),
			`bombexplosions` = `bombexplosions` + (NEW.`bombexplosions` - OLD.`bombexplosions`),
			`h_0` = `h_0` + (NEW.`h_0` - OLD.`h_0`),
			`h_1` = `h_1` + (NEW.`h_1` - OLD.`h_1`),
			`h_2` = `h_2` + (NEW.`h_2` - OLD.`h_2`),
			`h_3` = `h_3` + (NEW.`h_3` - OLD.`h_3`),
			`h_4` = `h_4` + (NEW.`h_4` - OLD.`h_4`),
			`h_5` = `h_5` + (NEW.`h_5` - OLD.`h_5`),
			`h_6` = `h_6` + (NEW.`h_6` - OLD.`h_6`),
			`h_7` = `h_7` + (NEW.`h_7` - OLD.`h_7`),
			`connection_time` = `connection_time` + (NEW.`connection_time` - OLD.`connection_time`),
			`connects` = `connects` + (NEW.`connects` - OLD.`connects`),
			`roundt` = `roundt` + (NEW.`roundt` - OLD.`roundt`),
			`wint` = `wint` + (NEW.`wint` - OLD.`wint`),
			`roundct` = `roundct` + (NEW.`roundct` - OLD.`roundct`),
			`winct` = `winct` + (NEW.`winct` - OLD.`winct`),
			`last_join` = NOW()
		WHERE `player_id` = NEW.`id` AND `session_id` = NEW.`session_id`;
	ELSE
		INSERT INTO `csstats_maps` (
			`player_id`,
			`session_id`,
			`map`,
			`skill`,
			`kills`,
			`deaths`,
			`hs`,
			`tks`,
			`shots`,
			`hits`,
			`dmg`,
			`bombdef`,
			`bombdefused`,
			`bombplants`,
			`bombexplosions`,
			`h_0`,
			`h_1`,
			`h_2`,
			`h_3`,
			`h_4`,
			`h_5`,
			`h_6`,
			`h_7`,
			`connection_time`,
			`connects`,
			`roundt`,
			`wint`,
			`roundct`,
			`winct`,
			`last_join`
		) VALUES (
			NEW.`id`,
			NEW.`session_id`,
			NEW.`session_map`,
			NEW.`skill` - OLD.`skill`,
			NEW.`kills` - OLD.`kills`,
			NEW.`deaths` - OLD.`deaths`,
			NEW.`hs`  - OLD.`hs`,
			NEW.`tks` - OLD.`tks`,
			NEW.`shots` - OLD.`shots`,
			NEW.`hits` - OLD.`hits`,
			NEW.`dmg` - OLD.`dmg`,
			NEW.`bombdef` - OLD.`bombdef`,
			NEW.`bombdefused` - OLD.`bombdefused`,
			NEW.`bombplants` - OLD.`bombplants`,
			NEW.`bombexplosions` - OLD.`bombexplosions`,
			NEW.`h_0` - OLD.`h_0`,
			NEW.`h_1` - OLD.`h_1`,
			NEW.`h_2` - OLD.`h_2`,
			NEW.`h_3` - OLD.`h_3`,
			NEW.`h_4` - OLD.`h_4`,
			NEW.`h_5` - OLD.`h_5`,
			NEW.`h_6` - OLD.`h_6`,
			NEW.`h_7` - OLD.`h_7`,
			NEW.`connection_time` - OLD.`connection_time`,
			NEW.`connects` - OLD.`connects`,
			NEW.`roundt` - OLD.`roundt`,
			NEW.`wint` - OLD.`wint`,
			NEW.`roundct` - OLD.`roundct`,
			NEW.`winct` - OLD.`winct`,
			NOW()
		);
	END IF;
END
//
DELIMITER ;