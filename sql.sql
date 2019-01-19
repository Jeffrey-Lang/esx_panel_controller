CREATE TABLE `user_warnings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `type` varchar(255) NULL,
  `admin` varchar(255) NULL,
  `warning` longtext NULL,
  `time_added` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `user_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reported_by` int(11) NULL,
  `report_type` varchar(255) NULL,
  `report_comment` varchar(255) NULL,
  `report_admin` varchar(255) NULL,
  `report_time` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `received_bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NULL,
  `banned_by` varchar(255) NULL,
  `banned_on` varchar(255),
  `ban_expires` varchar(255) NULL,
  `userid` varchar(255) NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `user_admin_notes` (
  `id` int(11) NOT NULL,
  `note` longblob NULL,
  `admin` varchar(255) NULL,
  `note_added` varchar(255),
  PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `kicks`;
CREATE TABLE `kicks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `steamid` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `kicked` int(10) NOT NULL,
  `reason` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

ALTER TABLE `users` ADD `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE `users` ADD timeplayed VARCHAR(255);

ALTER TABLE `users` ADD online int(10);
