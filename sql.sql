
SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE
IF
	NOT EXISTS user_warnings (
	id INT ( 11 ) NOT NULL AUTO_INCREMENT,
	userid INT ( 11 ) NOT NULL,
	type VARCHAR ( 255 ) NULL,
	admin VARCHAR ( 255 ) NULL,
	warning LONGTEXT NULL,
	time_added VARCHAR ( 255 ),
	PRIMARY KEY ( id ) 
	);
CREATE TABLE
IF
	NOT EXISTS user_reports (
		id INT ( 11 ) NOT NULL AUTO_INCREMENT,
		reported_by VARCHAR ( 80 ) NULL,
		report_type VARCHAR ( 255 ) NULL,
		report_comment VARCHAR ( 255 ) NULL,
		report_admin VARCHAR ( 255 ) NULL,
		report_time VARCHAR ( 255 ),
		userid VARCHAR ( 255 ) CHARACTER 
		SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
		PRIMARY KEY ( id ) 
	);
CREATE TABLE
IF
	NOT EXISTS received_bans (
		id INT ( 11 ) NOT NULL AUTO_INCREMENT,
		reason VARCHAR ( 255 ) NULL,
		banned_by VARCHAR ( 255 ) NULL,
		banned_on VARCHAR ( 255 ),
		ban_expires VARCHAR ( 255 ) NULL,
		userid VARCHAR ( 255 ) NULL,
		PRIMARY KEY ( id ) 
	);
CREATE TABLE
IF
	NOT EXISTS user_admin_notes (
		id INT ( 11 ) NOT NULL,
		note LONGBLOB NULL,
		admin VARCHAR ( 255 ) NULL,
		note_added VARCHAR ( 255 ),
		PRIMARY KEY ( id ) 
	);
CREATE TABLE
IF
	NOT EXISTS kicks (
		id INT ( 10 ) UNSIGNED NOT NULL AUTO_INCREMENT,
		steamid VARCHAR ( 250 ) CHARACTER 
		SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
		kicked INT ( 10 ) NOT NULL,
		reason VARCHAR ( 250 ) CHARACTER 
		SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
		PRIMARY KEY ( id ) USING BTREE 
	) ENGINE = INNODB AUTO_INCREMENT = 2 CHARACTER 
	SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;
/*
  use the line below if you get an error on user table primary key already exsists then run the rest below it again:
  ALTER TABLE users DROP PRIMARY KEY;
*/
ALTER TABLE users ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE users ADD timeplayed VARCHAR ( 255 ) NOT NULL DEFAULT '0';
ALTER TABLE users ADD online INT ( 10 ) NOT NULL DEFAULT '0';
ALTER TABLE users ADD server INT ( 10 ) NOT NULL DEFAULT '1';
ALTER TABLE owned_vehicles DROP PRIMARY KEY;
ALTER TABLE owned_vehicles ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE items DROP PRIMARY KEY;
ALTER TABLE items ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE jobs DROP PRIMARY KEY;
ALTER TABLE jobs ADD id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE jobs ADD whitelisted INT ( 10 ) NOT NULL DEFAULT '0';

SET FOREIGN_KEY_CHECKS = 1;