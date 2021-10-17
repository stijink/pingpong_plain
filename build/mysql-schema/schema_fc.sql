# ************************************************************
# Sequel Pro SQL dump
# Version 5446
#
# https://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 10.200.1.150 (MySQL 5.1.66-rel14.1-log)
# Database: fc
# Generation Time: 2020-01-17 12:32:06 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account_history
# ------------------------------------------------------------

CREATE TABLE `account_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processor_id` varchar(30) NOT NULL DEFAULT '',
  `processor_ref` varchar(30) NOT NULL DEFAULT '',
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `level` smallint(6) NOT NULL DEFAULT '0',
  `processor` enum('f','p','b','v','m','x') NOT NULL DEFAULT 'm',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `type` varchar(15) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `rollback_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table adobe_voucher
# ------------------------------------------------------------

CREATE TABLE `adobe_voucher` (
  `code` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT 'Plain Adobe Gutscheincode',
  `type` varchar(8) DEFAULT '',
  `userid` int(11) NOT NULL COMMENT 'Zugehöriger User',
  `date_assigned` datetime NOT NULL COMMENT 'Zeitpunkt der Zuordnung zum User',
  `transaction_id` int(11) NOT NULL COMMENT 'Id des Zahlungsevents',
  PRIMARY KEY (`userid`,`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Adobe Gutschein-Codes';



# Dump of table api_application
# ------------------------------------------------------------

CREATE TABLE `api_application` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `userid` bigint(20) NOT NULL,
  `public_key` varchar(32) NOT NULL,
  `private_key` varchar(32) NOT NULL,
  `active` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table api_token
# ------------------------------------------------------------

CREATE TABLE `api_token` (
  `token` char(32) NOT NULL DEFAULT '',
  `api_public_key` char(32) DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `permissions` tinyint(3) unsigned DEFAULT NULL,
  `charges` bigint(20) unsigned DEFAULT NULL,
  `expires_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`token`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table blacklist_content
# ------------------------------------------------------------

CREATE TABLE `blacklist_content` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content` (`content`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table blacklist_email_domains
# ------------------------------------------------------------

CREATE TABLE `blacklist_email_domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table blacklisted_email_verifications
# ------------------------------------------------------------

CREATE TABLE `blacklisted_email_verifications` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `hash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table blacklisted_removal_log
# ------------------------------------------------------------

CREATE TABLE `blacklisted_removal_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `removed_from_redis` tinyint(1) NOT NULL,
  `removed_from_mysql` tinyint(1) NOT NULL,
  `count_removed_from_mysql_by_userid` tinyint(1) NOT NULL,
  `count_removed_from_mysql_by_email` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table blz
# ------------------------------------------------------------

CREATE TABLE `blz` (
  `blz` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table bounced_emails
# ------------------------------------------------------------

CREATE TABLE `bounced_emails` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '-',
  `userid` int(10) NOT NULL DEFAULT '1',
  `notified` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table bounced_emails_log
# ------------------------------------------------------------

CREATE TABLE `bounced_emails_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `timestamp` int(10) DEFAULT NULL,
  `mailid` varchar(15) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `relay` varchar(255) DEFAULT NULL,
  `dsn` varchar(255) DEFAULT NULL,
  `msg` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table bounced_emails_log_lastid
# ------------------------------------------------------------

CREATE TABLE `bounced_emails_log_lastid` (
  `lastid` int(10) NOT NULL,
  PRIMARY KEY (`lastid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table buddy
# ------------------------------------------------------------

CREATE TABLE `buddy` (
  `ref` int(11) NOT NULL AUTO_INCREMENT,
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `refid` int(11) NOT NULL DEFAULT '0',
  `type` char(1) NOT NULL DEFAULT 'b',
  PRIMARY KEY (`ref`),
  KEY `refuserid_refid_type` (`refuserid`,`refid`,`type`),
  KEY `refid` (`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table buddy_waiting
# ------------------------------------------------------------

CREATE TABLE `buddy_waiting` (
  `refid` int(10) unsigned NOT NULL DEFAULT '0',
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `refuserid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('p','c') COLLATE latin1_german1_ci DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `checksum` char(32) COLLATE latin1_german1_ci DEFAULT NULL,
  PRIMARY KEY (`refid`),
  KEY `userid` (`userid`),
  KEY `refuserid` (`refuserid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table calendar
# ------------------------------------------------------------

CREATE TABLE `calendar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0',
  `userid2` int(11) NOT NULL DEFAULT '0',
  `userid3` int(11) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` char(1) NOT NULL DEFAULT '',
  `country` int(11) NOT NULL DEFAULT '0',
  `city` varchar(50) NOT NULL DEFAULT '',
  `plz` varchar(6) NOT NULL DEFAULT '',
  `meeting` varchar(50) NOT NULL DEFAULT '',
  `adress` varchar(50) NOT NULL DEFAULT '',
  `number` varchar(10) NOT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `shortdescr` varchar(150) NOT NULL DEFAULT '',
  `longdescr` text NOT NULL,
  `days` float NOT NULL DEFAULT '0',
  `refpic` int(11) NOT NULL DEFAULT '0',
  `refnews` int(11) NOT NULL DEFAULT '0',
  `booking` char(1) NOT NULL DEFAULT '',
  `price` int(11) NOT NULL DEFAULT '0',
  `currency` int(11) NOT NULL DEFAULT '0',
  `userdef` varchar(50) NOT NULL DEFAULT '',
  `num_zusagen` int(11) unsigned NOT NULL DEFAULT '0',
  `num_interesse` int(11) unsigned NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  `angelegt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table campaign_tracking
# ------------------------------------------------------------

CREATE TABLE `campaign_tracking` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(14) unsigned NOT NULL,
  `utm_source` varchar(32) DEFAULT NULL,
  `utm_campaign` varchar(32) DEFAULT NULL,
  `utm_medium` varchar(32) DEFAULT NULL,
  `gclid` varchar(100) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL COMMENT 's. PROD-4081',
  `created` datetime NOT NULL,
  `type` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table cat
# ------------------------------------------------------------

CREATE TABLE `cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `translation_tag` varchar(30) NOT NULL,
  `vor` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `seclevel` int(11) NOT NULL DEFAULT '0',
  `shortname` varchar(30) NOT NULL DEFAULT '',
  `catpic` int(11) NOT NULL DEFAULT '0',
  `channel` int(11) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `active` char(1) NOT NULL DEFAULT 'y',
  `userid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `max` int(11) NOT NULL DEFAULT '0',
  `createcatpic` char(1) NOT NULL DEFAULT '',
  `uploadright` tinyint(4) NOT NULL DEFAULT '2',
  `newwho` tinyint(4) NOT NULL DEFAULT '-1',
  `votewho` tinyint(4) NOT NULL DEFAULT '-1',
  `votehow` tinyint(4) NOT NULL DEFAULT '-1',
  `uploadlimit` tinyint(4) NOT NULL DEFAULT '-1',
  `feature` char(1) NOT NULL DEFAULT 'n',
  `special` char(1) NOT NULL DEFAULT '',
  `flimit` int(11) NOT NULL DEFAULT '0',
  `sql_new` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `altpic` int(10) unsigned NOT NULL DEFAULT '0',
  `international_contest` enum('y','n') NOT NULL DEFAULT 'n',
  `title_extension` varchar(200) NOT NULL COMMENT 'SEO title tag',
  `title_extension2` varchar(200) NOT NULL COMMENT 'SEO title tag',
  `meta_description` text NOT NULL COMMENT 'SEO meta description',
  `keywords` text NOT NULL COMMENT 'SEO meta keywords',
  `is_archived` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `vor` (`vor`),
  KEY `channel` (`channel`),
  KEY `active_feature_channel_time` (`active`,`feature`,`channel`,`time`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table channel
# ------------------------------------------------------------

CREATE TABLE `channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `translation_tag` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `shortname` varchar(50) NOT NULL DEFAULT '',
  `owner` int(11) NOT NULL DEFAULT '0',
  `header` varchar(150) NOT NULL DEFAULT '',
  `footer` varchar(150) NOT NULL DEFAULT '',
  `bcolor1` varchar(10) NOT NULL DEFAULT '',
  `bcolor2` varchar(10) NOT NULL DEFAULT '',
  `bcolor3` varchar(10) NOT NULL DEFAULT '',
  `color1` varchar(10) NOT NULL DEFAULT '',
  `color2` varchar(10) NOT NULL DEFAULT '',
  `color3` varchar(10) NOT NULL DEFAULT '',
  `stylesheet` varchar(150) NOT NULL DEFAULT '',
  `private` tinyint(4) NOT NULL DEFAULT '0',
  `newwho` varchar(200) NOT NULL DEFAULT '',
  `votewho` varchar(200) NOT NULL DEFAULT '',
  `votehow` varchar(200) NOT NULL DEFAULT '',
  `movecat` int(11) NOT NULL DEFAULT '0',
  `design1` varchar(250) NOT NULL DEFAULT '',
  `design2` varchar(250) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `textinclude` varchar(250) NOT NULL DEFAULT '',
  `picserver` varchar(120) NOT NULL DEFAULT '',
  `title_extension` varchar(200) NOT NULL,
  `meta_description` text NOT NULL,
  `keywords` text NOT NULL,
  `sql_new` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  `ulimit` smallint(4) NOT NULL DEFAULT '5',
  `sortorder` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fclang` (`fclang`,`movecat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table checkout_completion_log
# ------------------------------------------------------------

CREATE TABLE `checkout_completion_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `product_option_id` int(10) unsigned NOT NULL,
  `client_ip` varchar(20) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `date_created` datetime NOT NULL,
  `origin` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table checkout_process
# ------------------------------------------------------------

CREATE TABLE `checkout_process` (
  `user_id` int(10) unsigned NOT NULL,
  `product_option_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table contest_photos
# ------------------------------------------------------------


CREATE TABLE `contest_photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contest_id` int(10) unsigned NOT NULL,
  `photo_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contest_photo_id` (`contest_id`,`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table contests2
# ------------------------------------------------------------

CREATE TABLE `contests2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `file_hash` char(36) DEFAULT NULL,
  `description` text NOT NULL,
  `photos_per_user` tinyint NOT NULL DEFAULT '1',
  `is_anonym` boolean NOT NULL DEFAULT '1',
  `is_approved` boolean NOT NULL DEFAULT '0',
  `locale` char(2) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_upload` datetime NOT NULL,
  `date_user_voting` datetime NOT NULL,
  `date_jury_voting` datetime DEFAULT NULL,
  `date_results` datetime NOT NULL,
  `sponsor_name` varchar (100) DEFAULT NULL,
  `sponsor_logo` varchar (512) DEFAULT NULL,
  `sponsor_text` text DEFAULT NULL,
  `sponsor_link` varchar(512) DEFAULT NULL,
  `terms` text DEFAULT NULL,
  `tags` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table contest_votes
# ------------------------------------------------------------

CREATE TABLE `contest_votes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contest_photo_id` int(10) unsigned NOT NULL,
   `user_id` int(10) unsigned NOT NULL,
  `is_jury_vote` boolean DEFAULT '0',
  `rating` float(6) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table contest_jury
# ------------------------------------------------------------

CREATE TABLE `contest_jury` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contest_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contest_user_id` (`contest_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table contest_bookmarks
# ------------------------------------------------------------

CREATE TABLE `contest_bookmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contest_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contest_user_id` (`contest_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table contest
# ------------------------------------------------------------

CREATE TABLE `contest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sort` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `linktext` varchar(50) NOT NULL DEFAULT '',
  `link` varchar(150) NOT NULL DEFAULT '',
  `bgcolor` varchar(7) NOT NULL DEFAULT '',
  `bgimage` int(11) NOT NULL DEFAULT '0',
  `titlecolor` varchar(7) NOT NULL DEFAULT '',
  `textcolor` varchar(7) NOT NULL DEFAULT '',
  `notecolor` varchar(7) NOT NULL DEFAULT '',
  `note` text NOT NULL,
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `win` enum('n','y') NOT NULL DEFAULT 'n',
  `active` smallint(2) NOT NULL DEFAULT '0',
  `in_progress` enum('y','n') NOT NULL DEFAULT 'n',
  `section` int(11) NOT NULL DEFAULT '0',
  `section2` int(11) NOT NULL DEFAULT '0',
  `uploadlimit` int(11) NOT NULL DEFAULT '0',
  `no_initactions` enum('y','n') NOT NULL DEFAULT 'n',
  `1_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `1_type` char(2) NOT NULL DEFAULT '',
  `1_init` varchar(10) NOT NULL DEFAULT '',
  `1_special` varchar(10) NOT NULL DEFAULT '',
  `1_userdef` int(11) NOT NULL DEFAULT '0',
  `2_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `2_type` char(2) NOT NULL DEFAULT '',
  `2_init` varchar(10) NOT NULL DEFAULT '',
  `2_special` varchar(10) NOT NULL DEFAULT '',
  `2_userdef` int(11) NOT NULL DEFAULT '0',
  `3_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `3_type` char(2) NOT NULL DEFAULT '',
  `3_init` varchar(10) NOT NULL DEFAULT '',
  `3_special` varchar(10) NOT NULL DEFAULT '',
  `3_userdef` int(11) NOT NULL DEFAULT '0',
  `4_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `4_type` char(2) NOT NULL DEFAULT '',
  `4_init` varchar(10) NOT NULL DEFAULT '',
  `4_special` varchar(10) NOT NULL DEFAULT '',
  `4_userdef` int(11) NOT NULL DEFAULT '0',
  `5_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `5_type` char(2) NOT NULL DEFAULT '',
  `5_init` varchar(10) NOT NULL DEFAULT '',
  `5_special` varchar(10) NOT NULL DEFAULT '',
  `5_userdef` int(11) NOT NULL DEFAULT '0',
  `usermessage` enum('n','s','y') NOT NULL DEFAULT 'y',
  `bgimagehomepage` int(11) DEFAULT '0',
  `bgimagemenu` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fclang_active` (`fclang`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table country
# ------------------------------------------------------------

CREATE TABLE `country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lang_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fclang_2` (`fclang`,`lang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table descr
# ------------------------------------------------------------

CREATE TABLE `descr` (
  `descr` varchar(100) NOT NULL DEFAULT '',
  `seclevel` smallint(4) NOT NULL DEFAULT '0',
  `submitter` varchar(60) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userid` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `cat` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `thumb_x` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `thumb_y` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `points` decimal(5,3) NOT NULL DEFAULT '0.000',
  `channel` smallint(4) NOT NULL DEFAULT '0',
  `active` enum('n','p','x','y','z','a') NOT NULL DEFAULT 'y',
  `pcat` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `movechannel` smallint(4) NOT NULL DEFAULT '0',
  `movecat` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `movetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` smallint(4) NOT NULL DEFAULT '-1',
  `ptime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `parserver` char(1) NOT NULL DEFAULT '0',
  `fflag` enum('0','u','v','p','h','1','2','3','l') NOT NULL DEFAULT '0',
  `ftype` enum('n','d') NOT NULL DEFAULT 'n',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `contestlot` int(6) NOT NULL,
  `timeint` int(10) unsigned DEFAULT NULL,
  `rss` enum('y','n') NOT NULL DEFAULT 'y',
  `seen_comments` smallint(4) DEFAULT NULL,
  `experts_choice` tinyint(1) DEFAULT '0',
  `rank` tinyint(3) unsigned DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `feedback_welcome` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pcat` (`pcat`),
  KEY `cat` (`cat`),
  KEY `catview` (`cat`,`active`,`time`),
  KEY `time_id_cat_active` (`time`,`id`,`cat`,`active`),
  KEY `userid_time_id` (`userid`,`time`,`id`),
  KEY `timeint` (`timeint`),
  KEY `movechannel_2` (`movechannel`,`active`,`movetime`),
  KEY `userid_timeint_id` (`userid`,`timeint`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (id)
PARTITIONS 20 */;



# Dump of table descr_del
# ------------------------------------------------------------

CREATE TABLE `descr_del` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `descr_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `action` varchar(16) NOT NULL DEFAULT 'delete',
  `done` enum('y','n') NOT NULL DEFAULT 'n',
  `time` datetime NOT NULL,
  `time_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table descr_traffic
# ------------------------------------------------------------

CREATE TABLE `descr_traffic` (
  `descr` varchar(100) NOT NULL DEFAULT '',
  `seclevel` smallint(4) NOT NULL DEFAULT '0',
  `submitter` varchar(60) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `id` int(11) unsigned NOT NULL,
  `userid` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `cat` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `thumb_x` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `thumb_y` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `points` decimal(5,3) NOT NULL DEFAULT '0.000',
  `channel` smallint(4) NOT NULL DEFAULT '0',
  `active` enum('n','p','x','y','z','a') NOT NULL DEFAULT 'y',
  `pcat` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `movechannel` smallint(4) NOT NULL DEFAULT '0',
  `movecat` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `movetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` smallint(4) NOT NULL DEFAULT '-1',
  `ptime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `parserver` char(1) NOT NULL DEFAULT '0',
  `fflag` enum('0','u','v','p','h','1','2','3','l') NOT NULL DEFAULT '0',
  `ftype` enum('n','d') NOT NULL DEFAULT 'n',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `contestlot` int(6) NOT NULL,
  `timeint` int(10) unsigned DEFAULT NULL,
  `rss` enum('y','n') NOT NULL DEFAULT 'y',
  `seen_comments` smallint(4) DEFAULT NULL,
  `experts_choice` tinyint(1) DEFAULT '0',
  `rank` tinyint(3) unsigned DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `feedback_welcome` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table descr2
# ------------------------------------------------------------

CREATE TABLE `descr2` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `ip` varchar(16) NOT NULL DEFAULT '',
  `special` smallint(4) unsigned NOT NULL DEFAULT '0',
  `hr_x` smallint(4) unsigned NOT NULL DEFAULT '0',
  `hr_y` smallint(4) unsigned NOT NULL DEFAULT '0',
  `counter` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `creativecommons` varchar(20) NOT NULL,
  `centered` enum('y','n') NOT NULL DEFAULT 'n',
  `thumb_md5` varchar(50) NOT NULL DEFAULT '0',
  `last_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `original` varchar(30) DEFAULT '-',
  `sellable` smallint(4) NOT NULL DEFAULT '0',
  `approved` enum('y','n') NOT NULL DEFAULT 'n',
  `original_x` mediumint(5) NOT NULL DEFAULT '0',
  `original_y` mediumint(5) NOT NULL DEFAULT '0',
  `tags` text NOT NULL,
  `qthumb_x` smallint(6) DEFAULT NULL,
  `qthumb_y` smallint(6) DEFAULT NULL,
  `qthumb_length` smallint(6) DEFAULT NULL,
  `last_discuss` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `imagePreviewLastModified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (id)
PARTITIONS 20 */;



# Dump of table design
# ------------------------------------------------------------

CREATE TABLE `design` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(25) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `t1` text NOT NULL,
  `t2` text NOT NULL,
  `t3` text NOT NULL,
  `t4` text NOT NULL,
  `t_header` varchar(128) NOT NULL DEFAULT '',
  `t_footer` varchar(128) NOT NULL DEFAULT '',
  `t_prev` varchar(128) NOT NULL DEFAULT '',
  `t_next` varchar(128) NOT NULL DEFAULT '',
  `t_home` varchar(128) NOT NULL DEFAULT '',
  `t_clicks` varchar(128) NOT NULL DEFAULT '',
  `t_back` varchar(128) NOT NULL DEFAULT '',
  `t_fotos` varchar(128) NOT NULL DEFAULT '',
  `design` varchar(255) NOT NULL DEFAULT '',
  `t_password` varchar(128) NOT NULL DEFAULT '',
  `t_background` varchar(128) NOT NULL DEFAULT '',
  `t_button` varchar(128) NOT NULL DEFAULT '',
  `t_discuss` varchar(128) NOT NULL DEFAULT '',
  `t_private` text NOT NULL,
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `userid_name_fclang` (`userid`,`name`,`fclang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table discussion_retraction
# ------------------------------------------------------------

CREATE TABLE `discussion_retraction` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `photo_id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `photo_id` (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table domainblacklist
# ------------------------------------------------------------

CREATE TABLE `domainblacklist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table editors_choice
# ------------------------------------------------------------

CREATE TABLE `editors_choice` (
  `imageId` int(11) NOT NULL COMMENT 'Bild-ID',
  `since` datetime NOT NULL COMMENT 'Im EC seit\n',
  `submitter` int(11) NOT NULL COMMENT 'User, der das Bild in EC eingetragen hat',
  `fclang` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Sprachversion, in der das Foto in EC gewaehlt wurde',
  PRIMARY KEY (`imageId`),
  KEY `since` (`since`),
  KEY `fclang` (`fclang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Meta-Daten zu Editor''s-Choice-Bildern';



# Dump of table email
# ------------------------------------------------------------

CREATE TABLE `email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `html` text NOT NULL,
  `culture` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table email_ads
# ------------------------------------------------------------

CREATE TABLE `email_ads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `weight` tinyint(3) NOT NULL,
  `fclang` tinyint(1) NOT NULL,
  `active` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Email-Werbung';



# Dump of table email_bounce
# ------------------------------------------------------------

CREATE TABLE `email_bounce` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `bounce_type` varchar(15) DEFAULT NULL,
  `bounce_sub_type` varchar(20) DEFAULT NULL,
  `diagnostic_code` varchar(255) DEFAULT NULL,
  `timestamp_bounce` datetime DEFAULT NULL,
  `timestamp_sent` datetime DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_complaint
# ------------------------------------------------------------

CREATE TABLE `email_complaint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `complaint_feedback_type` varchar(15) DEFAULT NULL,
  `timestamp_complaint` datetime DEFAULT NULL,
  `timestamp_sent` datetime DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_placeholder
# ------------------------------------------------------------

CREATE TABLE `email_placeholder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `html` text NOT NULL,
  `culture` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table event
# ------------------------------------------------------------

CREATE TABLE `event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) DEFAULT NULL,
  `provider_id` int(11) NOT NULL DEFAULT '0',
  `provider_event_id` varchar(128) NOT NULL DEFAULT '0',
  `event_data` text NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `transaction_error` char(1) NOT NULL DEFAULT 'n',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table exifData
# ------------------------------------------------------------

CREATE TABLE `exifData` (
  `fotoID` int(20) NOT NULL DEFAULT '0',
  `type` enum('o','m') NOT NULL DEFAULT 'o',
  `changed` enum('y','n') NOT NULL DEFAULT 'n',
  `filename` varchar(100) NOT NULL DEFAULT '-',
  `cameramodel` varchar(100) DEFAULT NULL,
  `make` varchar(100) DEFAULT NULL,
  `lens` varchar(255) DEFAULT NULL,
  `focalLength` varchar(30) DEFAULT NULL,
  `focalLength35` varchar(100) DEFAULT NULL,
  `iso` int(10) DEFAULT NULL,
  `aperture` varchar(10) DEFAULT NULL,
  `exposure` varchar(10) DEFAULT NULL,
  `ecorrection` varchar(10) DEFAULT NULL,
  `flashEcorrection` varchar(10) DEFAULT NULL,
  `exposureprogram` varchar(100) DEFAULT NULL,
  `flash` varchar(100) DEFAULT NULL,
  `datetime` int(10) DEFAULT NULL,
  `place` varchar(60) DEFAULT NULL,
  `GPSLatitude` varchar(40) DEFAULT NULL,
  `GPSLongitude` varchar(40) DEFAULT NULL,
  `GPSAltitude` varchar(40) DEFAULT NULL,
  `width` int(5) DEFAULT NULL,
  `height` int(5) DEFAULT NULL,
  `orientation` varchar(50) DEFAULT NULL,
  `colorspace` varchar(50) DEFAULT NULL,
  `meteringmode` varchar(100) DEFAULT NULL,
  `whitebalance` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`fotoID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table faq_key
# ------------------------------------------------------------

CREATE TABLE `faq_key` (
  `refid` int(20) NOT NULL DEFAULT '0',
  `text` char(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table faq_loesung
# ------------------------------------------------------------

CREATE TABLE `faq_loesung` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `refid` int(30) NOT NULL DEFAULT '0',
  `user` varchar(50) NOT NULL DEFAULT '',
  `timestamp` varchar(30) NOT NULL DEFAULT '',
  `typ` varchar(15) NOT NULL DEFAULT '',
  `antwort` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table faq_problem
# ------------------------------------------------------------

CREATE TABLE `faq_problem` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `user` varchar(20) NOT NULL DEFAULT '',
  `timestamp` int(20) NOT NULL DEFAULT '0',
  `frage` text NOT NULL,
  `detail` text NOT NULL,
  `kat` varchar(10) NOT NULL DEFAULT '',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fc_mail
# ------------------------------------------------------------

CREATE TABLE `fc_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  `placeholder` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fc_mailfrom
# ------------------------------------------------------------

CREATE TABLE `fc_mailfrom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fc_mailspecial
# ------------------------------------------------------------

CREATE TABLE `fc_mailspecial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(32) NOT NULL DEFAULT '',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `plain` text NOT NULL,
  `html` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fc_mailtext
# ------------------------------------------------------------

CREATE TABLE `fc_mailtext` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `mailfrom_id` int(11) NOT NULL DEFAULT '1',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `plain` text NOT NULL,
  `html` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fc_online_com
# ------------------------------------------------------------

CREATE TABLE `fc_online_com` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `tnow` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;



# Dump of table fc_online_de
# ------------------------------------------------------------

CREATE TABLE `fc_online_de` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `tnow` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;



# Dump of table fc_online_es
# ------------------------------------------------------------

CREATE TABLE `fc_online_es` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `tnow` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;



# Dump of table fc_online_fr
# ------------------------------------------------------------

CREATE TABLE `fc_online_fr` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `tnow` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;



# Dump of table fc_online_it
# ------------------------------------------------------------

CREATE TABLE `fc_online_it` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `tnow` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;



# Dump of table fclock
# ------------------------------------------------------------

CREATE TABLE `fclock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `t` int(14) DEFAULT NULL,
  `ip` char(15) NOT NULL DEFAULT '',
  `userid` int(11) NOT NULL DEFAULT '0',
  `ty` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `time` (`t`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fcprints_auftraege
# ------------------------------------------------------------

CREATE TABLE `fcprints_auftraege` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `auftragsID` bigint(10) NOT NULL DEFAULT '801000',
  `userID` int(10) NOT NULL DEFAULT '-1',
  `eigentuemerID` int(10) NOT NULL DEFAULT '0',
  `produktID` int(10) NOT NULL DEFAULT '0',
  `bildID` int(10) NOT NULL DEFAULT '0',
  `anzahl` int(5) NOT NULL DEFAULT '1',
  `RAnrede` enum('Herr','Frau','Firma') NOT NULL DEFAULT 'Herr',
  `RVorname` varchar(50) NOT NULL DEFAULT '-',
  `RNachname` varchar(50) NOT NULL DEFAULT '-',
  `RFirma` varchar(50) DEFAULT NULL,
  `RStrasse` varchar(100) NOT NULL DEFAULT '-',
  `RStrasse2` varchar(100) DEFAULT NULL,
  `RStrasse3` varchar(100) DEFAULT NULL,
  `RPlz` varchar(30) NOT NULL DEFAULT '-',
  `ROrt` varchar(100) NOT NULL DEFAULT '-',
  `RTelefon` varchar(50) NOT NULL DEFAULT '-',
  `RMail` varchar(100) NOT NULL DEFAULT '-',
  `LAnrede` enum('Herr','Frau','Firma') DEFAULT 'Herr',
  `LVorname` varchar(50) DEFAULT NULL,
  `LNachname` varchar(50) DEFAULT NULL,
  `LFirma` varchar(50) DEFAULT NULL,
  `LStrasse` varchar(100) DEFAULT NULL,
  `LStrasse2` varchar(100) DEFAULT NULL,
  `LStrasse3` varchar(100) DEFAULT NULL,
  `LPlz` varchar(30) DEFAULT NULL,
  `LOrt` varchar(100) DEFAULT NULL,
  `nettoeinzelpreis` float NOT NULL DEFAULT '0',
  `UMargeProzent` int(5) NOT NULL DEFAULT '0',
  `FCMargeProzent` int(3) NOT NULL DEFAULT '15',
  `status` enum('n','o','p','e','x','s','c') NOT NULL DEFAULT 'c',
  `bestelldatum` int(10) NOT NULL DEFAULT '0',
  `o_datum` int(10) NOT NULL DEFAULT '0',
  `p_datum` int(10) NOT NULL DEFAULT '0',
  `e_datum` int(10) NOT NULL DEFAULT '0',
  `paid_out` enum('y','n') NOT NULL DEFAULT 'n',
  `payout_id` smallint(6) NOT NULL DEFAULT '0',
  `tradetracker` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table files
# ------------------------------------------------------------

CREATE TABLE `files` (
  `ref_id` int(11) NOT NULL,
  `file_context` tinyint(3) unsigned NOT NULL,
  `file_type` tinyint(3) unsigned NOT NULL,
  `hash` varchar(36) NOT NULL,
  `secure` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ref_id`,`file_context`,`file_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fotohome
# ------------------------------------------------------------

CREATE TABLE `fotohome` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(14) NOT NULL,
  `title` varchar(50) NOT NULL,
  `url_name` varchar(30) NOT NULL,
  `fotohome_url_version_id` bigint(20) NOT NULL,
  `fotohome_theme_id` bigint(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `sm_fotocommunity_show_profile` tinyint(1) NOT NULL,
  `sm_facebook_show_sharelink` tinyint(1) NOT NULL,
  `sm_facebook_show_profile` tinyint(1) NOT NULL,
  `sm_facebook_url` varchar(255) NOT NULL DEFAULT '',
  `sm_twitter_show_sharelink` tinyint(1) NOT NULL,
  `sm_twitter_show_profile` tinyint(1) NOT NULL,
  `sm_twitter_url` varchar(255) NOT NULL,
  `sm_pinterest_show_sharelink` tinyint(1) NOT NULL,
  `sm_pinterest_show_profile` tinyint(1) NOT NULL,
  `sm_pinterest_url` varchar(255) NOT NULL,
  `sm_googleplus_show_sharelink` tinyint(1) NOT NULL,
  `sm_googleplus_show_profile` tinyint(1) NOT NULL,
  `sm_googleplus_url` varchar(255) NOT NULL,
  `legal_info` text,
  `about_is_active` tinyint(1) NOT NULL,
  `about_name` varchar(45) NOT NULL,
  `about_text` text,
  `contactform_is_active` tinyint(1) NOT NULL,
  `contactform_name` varchar(45) NOT NULL,
  `show_photo_caption` tinyint(1) NOT NULL DEFAULT '1',
  `show_photo_description` tinyint(1) NOT NULL DEFAULT '1',
  `show_exif` tinyint(1) NOT NULL,
  `photo_fullscreen` tinyint(1) NOT NULL,
  `fotocommunity_link` tinyint(1) NOT NULL,
  `seo_allow_google` tinyint(1) NOT NULL DEFAULT '0',
  `seo_meta_description` varchar(156) NOT NULL,
  `seo_title` varchar(70) NOT NULL,
  `show_photo_sell_link` tinyint(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `show_photos_on_start` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fotohome_url_name` (`url_name`),
  KEY `idx_fotohome_user_id` (`user_id`),
  KEY `fk_fotohome_url_version_id` (`fotohome_url_version_id`),
  CONSTRAINT `fk_fotohome_url_version_id` FOREIGN KEY (`fotohome_url_version_id`) REFERENCES `fotohome_url_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='The Fotohomes themselves';



# Dump of table fotohome_theme
# ------------------------------------------------------------

CREATE TABLE `fotohome_theme` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_premium` tinyint(1) NOT NULL,
  `is_responsive` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Fotohome themes';



# Dump of table fotohome_url_version
# ------------------------------------------------------------

CREATE TABLE `fotohome_url_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Fotohome URL versions, i.e. subdomains for Fotohomes';



# Dump of table geo_events
# ------------------------------------------------------------

CREATE TABLE `geo_events` (
  `gid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventid` int(10) NOT NULL DEFAULT '0',
  `longitude` double NOT NULL DEFAULT '0',
  `latitude` double NOT NULL DEFAULT '0',
  `coordX` double NOT NULL DEFAULT '0',
  `coordY` double NOT NULL DEFAULT '0',
  `coordZ` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`gid`),
  KEY `eventid` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table geo_users
# ------------------------------------------------------------

CREATE TABLE `geo_users` (
  `user_id` int(11) NOT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL,
  `city` varchar(30) NOT NULL,
  `radius` int(5) NOT NULL DEFAULT '100',
  `workshop` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`user_id`),
  KEY `workshop` (`workshop`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Standorte/Geo-Koordinaten unserer User ';



# Dump of table geoip
# ------------------------------------------------------------

CREATE TABLE `geoip` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `ip_from` bigint(10) NOT NULL,
  `ip_to` bigint(10) NOT NULL,
  `registrar` varchar(50) NOT NULL,
  `date_assigned` bigint(10) NOT NULL,
  `code2` varchar(2) NOT NULL,
  `code3` varchar(3) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table guest_newsletter
# ------------------------------------------------------------

CREATE TABLE `guest_newsletter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL DEFAULT '',
  `abo_special_nl` tinyint(1) DEFAULT '0',
  `abo_info_nl` tinyint(1) DEFAULT '0',
  `gender` enum('m','f') DEFAULT 'm',
  `name` varchar(255) DEFAULT NULL,
  `fclang` enum('0','1','2','3','4','5') DEFAULT '1',
  `date_registration_special` datetime DEFAULT NULL,
  `date_registration_info` datetime DEFAULT NULL,
  `date_opt_special` datetime DEFAULT NULL,
  `date_opt_info` datetime DEFAULT NULL,
  `email_flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table invoice_addresses
# ------------------------------------------------------------

CREATE TABLE `invoice_addresses` (
  `user_id` int(14) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `zip` varchar(12) NOT NULL,
  `city` varchar(32) NOT NULL,
  `country` char(2) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table job
# ------------------------------------------------------------

CREATE TABLE `job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `action` char(2) NOT NULL DEFAULT '',
  `sqlcommand` text,
  `subject` text,
  `text` text,
  `lim` int(11) DEFAULT '0',
  `done` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table magazines
# ------------------------------------------------------------

CREATE TABLE `magazines` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `category` varchar(30) NOT NULL,
  `year_published` char(4) DEFAULT NULL,
  `title` varchar(30) NOT NULL,
  `filename` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table nameChangeQueue
# ------------------------------------------------------------

CREATE TABLE `nameChangeQueue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `old_username` varchar(60) NOT NULL,
  `new_username` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table namenswechsel
# ------------------------------------------------------------

CREATE TABLE `namenswechsel` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) NOT NULL,
  `old_name` char(255) NOT NULL,
  `new_name` varchar(255) NOT NULL,
  `changed_when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table newsletter_subscription_tracking
# ------------------------------------------------------------

CREATE TABLE `newsletter_subscription_tracking` (
  `email_address` varchar(254) NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `subscribed_from` varchar(20) NOT NULL,
  `newsletter_type` char(10) NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`email_address`,`newsletter_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table newsletter_subscriptions
# ------------------------------------------------------------

CREATE TABLE `newsletter_subscriptions` (
  `user_id` int(10) unsigned NOT NULL,
  `newsletter` varchar(20) NOT NULL DEFAULT '',
  `date_optin` datetime NOT NULL,
  `date_optout` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`newsletter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_buddyphotos
# ------------------------------------------------------------

CREATE TABLE `notifications_buddyphotos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `photo_id` (`photo_id`,`receiver_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_discussions
# ------------------------------------------------------------

CREATE TABLE `notifications_discussions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `comment_id` bigint(20) unsigned NOT NULL,
  `comment_userid` int(14) NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `photo_id` (`photo_id`,`receiver_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_favorites
# ------------------------------------------------------------

CREATE TABLE `notifications_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `public` tinyint(1) NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`),
  KEY `photo_id` (`photo_id`,`receiver_userid`,`is_unread`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_follow
# ------------------------------------------------------------

CREATE TABLE `notifications_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_receiver_userid` (`sender_userid`,`receiver_userid`),
  KEY `receiver_userid_is_unread` (`receiver_userid`,`is_unread`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_fotomails
# ------------------------------------------------------------

CREATE TABLE `notifications_fotomails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `fotomail_id` int(11) NOT NULL,
  `photo_userid` int(14) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `fotomail_id` (`fotomail_id`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_mycomments
# ------------------------------------------------------------

CREATE TABLE `notifications_mycomments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `comment_id` bigint(20) unsigned NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`),
  KEY `photo_id` (`photo_id`,`receiver_userid`,`is_unread`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_photocommentlikes
# ------------------------------------------------------------

CREATE TABLE `notifications_photocommentlikes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `comment_id` bigint(20) unsigned NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`),
  KEY `photo_id` (`photo_id`,`receiver_userid`,`is_unread`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_photocommentreplies
# ------------------------------------------------------------

CREATE TABLE `notifications_photocommentreplies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `comment_id` bigint(20) unsigned NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`),
  KEY `photo_id` (`photo_id`,`receiver_userid`,`is_unread`),
  KEY `comment_id` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications_photolikes
# ------------------------------------------------------------

CREATE TABLE `notifications_photolikes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_userid` int(14) NOT NULL,
  `receiver_userid` int(14) NOT NULL,
  `photo_id` bigint(20) unsigned NOT NULL,
  `is_unread` tinyint(4) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_userid` (`sender_userid`),
  KEY `receiver_userid` (`receiver_userid`,`date_created`),
  KEY `photo_id` (`photo_id`,`receiver_userid`,`is_unread`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table office_dashboard
# ------------------------------------------------------------

CREATE TABLE `office_dashboard` (
  `users` int(11) unsigned NOT NULL DEFAULT '0',
  `photos` int(11) unsigned NOT NULL DEFAULT '0',
  `comments` int(11) unsigned NOT NULL DEFAULT '0',
  `likes` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table payment_failures
# ------------------------------------------------------------

CREATE TABLE `payment_failures` (
  `user_id` int(10) unsigned NOT NULL,
  `payment_method` int(10) unsigned NOT NULL COMMENT '1=DirectDebit, 2=CreditCard, 3=Paypal, 4=BankTransfer',
  `product_option_id` int(11) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `date_failed` datetime NOT NULL,
  `reason` varchar(255) NOT NULL,
  `problem_category` int(10) unsigned NOT NULL COMMENT '1=account overdrawn, 2=account data invalid',
  `is_resolved` tinyint(1) NOT NULL DEFAULT '0',
  `attempt` int(10) DEFAULT '1',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table payment_reminder_export
# ------------------------------------------------------------

CREATE TABLE `payment_reminder_export` (
  `user_id` int(11) unsigned NOT NULL,
  `date_exported` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`date_exported`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table payment_reminder_mail_log
# ------------------------------------------------------------

CREATE TABLE `payment_reminder_mail_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `payment_method` tinyint(3) unsigned NOT NULL COMMENT '1=DirectDebit, 2=CreditCard, 3=Paypal, 4=BankTransfer',
  `days_since_failure` tinyint(3) NOT NULL COMMENT 'distinct mail types for 0, 5, 10, 20 days after failure',
  `date_failed` datetime NOT NULL,
  `date_sent` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pcat
# ------------------------------------------------------------

CREATE TABLE `pcat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vor` int(11) NOT NULL DEFAULT '0',
  `name` varchar(250) NOT NULL DEFAULT '',
  `gtype` int(11) NOT NULL DEFAULT '0',
  `catpic` int(11) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `active` char(1) NOT NULL DEFAULT 'y',
  `userdef1` bigint(20) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `max` int(11) NOT NULL DEFAULT '0',
  `createcatpic` char(1) NOT NULL DEFAULT '',
  `pass` varchar(32) NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT '1',
  `picsort` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `design` int(11) NOT NULL DEFAULT '0',
  `shortname` varchar(20) NOT NULL DEFAULT '',
  `rss` enum('y','n') NOT NULL DEFAULT 'y',
  `numPublicPhotos` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `active_userid_time` (`active`,`userid`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pending
# ------------------------------------------------------------

CREATE TABLE `pending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userid` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `action` char(2) NOT NULL DEFAULT '0',
  `how` tinyint(4) NOT NULL DEFAULT '0',
  `who` tinyint(4) NOT NULL DEFAULT '0',
  `refid` int(11) NOT NULL DEFAULT '0',
  `type2` tinyint(4) NOT NULL DEFAULT '0',
  `action2` char(1) NOT NULL DEFAULT '0',
  `refid2` int(11) NOT NULL DEFAULT '0',
  `channel` smallint(6) NOT NULL DEFAULT '0',
  `ownerveto` int(11) unsigned NOT NULL DEFAULT '0',
  `userdef1` varchar(60) DEFAULT NULL,
  `userdef2` varchar(60) DEFAULT NULL,
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pending_uniq` (`refid`,`type`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table permission
# ------------------------------------------------------------

CREATE TABLE `permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table phistory
# ------------------------------------------------------------

CREATE TABLE `phistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `action` char(2) NOT NULL DEFAULT '0',
  `how` int(11) NOT NULL DEFAULT '0',
  `who` int(11) NOT NULL DEFAULT '0',
  `refid` int(11) NOT NULL DEFAULT '0',
  `type2` int(11) NOT NULL DEFAULT '0',
  `action2` char(1) NOT NULL DEFAULT '0',
  `refid2` int(11) NOT NULL DEFAULT '0',
  `channel` int(11) NOT NULL DEFAULT '0',
  `ownerveto` int(11) NOT NULL DEFAULT '0',
  `name` char(30) NOT NULL DEFAULT '',
  `step` int(11) NOT NULL DEFAULT '0',
  `pro` int(11) NOT NULL DEFAULT '0',
  `contra` int(11) NOT NULL DEFAULT '0',
  `userdef1` int(11) NOT NULL DEFAULT '0',
  `userdef2` tinyint(11) NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `channel` (`channel`),
  KEY `refid` (`refid`),
  KEY `time` (`time`),
  KEY `userid` (`userid`),
  KEY `ownerveto` (`ownerveto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table photo_comment_likes
# ------------------------------------------------------------

CREATE TABLE `photo_comment_likes` (
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`comment_id`,`user_id`),
  KEY `photo_comment_likes_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table photo_comments
# ------------------------------------------------------------

CREATE TABLE `photo_comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `photo_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date_created` datetime NOT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(1) NOT NULL DEFAULT 'p' COMMENT 'e=EditorsChoice, v=Voting, p=Photo',
  PRIMARY KEY (`id`,`photo_id`),
  KEY `parent_id` (`parent_id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `date_created` (`date_created`),
  KEY `photo_id_date_deleted` (`photo_id`,`date_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY HASH (photo_id div 1000000)
PARTITIONS 25 */;



# Dump of table photo_likes
# ------------------------------------------------------------

CREATE TABLE `photo_likes` (
  `photo_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`photo_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (photo_id)
PARTITIONS 10 */;



# Dump of table photo_meta
# ------------------------------------------------------------

CREATE TABLE `photo_meta` (
  `photo_id` int(11) unsigned NOT NULL,
  `show_exif` tinyint(1) NOT NULL DEFAULT '1',
  `show_location` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table photo_sections
# ------------------------------------------------------------

CREATE TABLE `photo_sections` (
  `photo_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`,`category_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table photo_topic
# ------------------------------------------------------------

CREATE TABLE `photo_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `topic_name` varchar(50) NOT NULL,
  `description` text,
  `publish_date` datetime NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table photo2folder
# ------------------------------------------------------------

CREATE TABLE `photo2folder` (
  `photo_id` bigint(20) unsigned NOT NULL,
  `folder_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`photo_id`,`folder_id`),
  KEY `position` (`position`),
  KEY `fk_photo2folder_folder_id` (`folder_id`),
  CONSTRAINT `fk_photo2folder_folder_id` FOREIGN KEY (`folder_id`) REFERENCES `pcat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Assigning photos (descr) to multiple folders (pcat)';



# Dump of table pics_deactivated
# ------------------------------------------------------------

CREATE TABLE `pics_deactivated` (
  `id` int(16) NOT NULL,
  `user_id` int(10) NOT NULL,
  `cat` mediumint(6) DEFAULT NULL,
  `pcat` mediumint(6) DEFAULT NULL,
  `movecat` mediumint(6) DEFAULT NULL,
  `zeit` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pics_deactivation_cue
# ------------------------------------------------------------

CREATE TABLE `pics_deactivation_cue` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pics_deleted
# ------------------------------------------------------------

CREATE TABLE `pics_deleted` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `zeit` int(10) NOT NULL DEFAULT '0',
  `userid` int(10) DEFAULT NULL,
  `type` enum('userdel','picdel','limitdel','admindel','mypicsdel','pendingactiondel','uploaderrordel','manualdel') NOT NULL DEFAULT 'picdel',
  PRIMARY KEY (`id`,`type`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pics_reactivation_cue
# ------------------------------------------------------------

CREATE TABLE `pics_reactivation_cue` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table prints_produkte
# ------------------------------------------------------------

CREATE TABLE `prints_produkte` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `produktname` varchar(255) NOT NULL DEFAULT '-',
  `oberflaeche` varchar(255) DEFAULT NULL,
  `seitenverhaeltnis` varchar(20) NOT NULL DEFAULT '1:1',
  `print_breite` int(5) NOT NULL DEFAULT '0',
  `print_hoehe` int(5) NOT NULL DEFAULT '0',
  `qIndex` int(4) NOT NULL DEFAULT '0',
  `bruttopreis` float NOT NULL DEFAULT '0',
  `Artikelbezeichnung` varchar(100) NOT NULL DEFAULT '-',
  `ArtikelID` int(5) NOT NULL DEFAULT '0',
  `bruttoEndpreis_15` float NOT NULL DEFAULT '0',
  `bruttoEndpreis_30` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table privacy_change_confirmations
# ------------------------------------------------------------

CREATE TABLE `privacy_change_confirmations` (
  `user_id` int(10) unsigned NOT NULL,
  `date_accepted` datetime NOT NULL,
  `privacy_version_date` datetime NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table products
# ------------------------------------------------------------

CREATE TABLE `products` (
  `product_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `option_name` varchar(128) NOT NULL DEFAULT '',
  `recurring` char(1) NOT NULL DEFAULT '',
  `price_1_standard` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price_display_standard` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price_1` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price_1_display` decimal(10,2) NOT NULL DEFAULT '0.00',
  `months_1` smallint(6) NOT NULL DEFAULT '0',
  `price_r` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price_r_display` decimal(10,2) NOT NULL DEFAULT '0.00',
  `months_r` smallint(6) NOT NULL DEFAULT '0',
  `currency` char(3) NOT NULL DEFAULT '',
  `currency_display` char(3) DEFAULT NULL,
  `product_type` char(1) NOT NULL DEFAULT '',
  `valid_start` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `valid_stop` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `domain_filter` varchar(20) NOT NULL DEFAULT '',
  `provider_filter` varchar(20) NOT NULL DEFAULT '',
  `user_status_filter` varchar(20) NOT NULL DEFAULT '',
  `special_offer` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_option_id`),
  KEY `productid` (`product_id`),
  KEY `domain_filter` (`domain_filter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Product Versions';



# Dump of table publish_descr
# ------------------------------------------------------------

CREATE TABLE `publish_descr` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `descr_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `medium_id` mediumint(4) NOT NULL DEFAULT '1',
  `marge` smallint(3) NOT NULL DEFAULT '0',
  `currency` varchar(3) NOT NULL DEFAULT 'EUR',
  `time` datetime NOT NULL,
  `publish_allowed` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`),
  KEY `userid_mediumid` (`user_id`,`medium_id`),
  KEY `descr_id_2` (`descr_id`,`publish_allowed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table publish_dta
# ------------------------------------------------------------

CREATE TABLE `publish_dta` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `datum` int(10) NOT NULL DEFAULT '0',
  `dta` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table publish_order
# ------------------------------------------------------------

CREATE TABLE `publish_order` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(64) NOT NULL,
  `user_id` int(10) NOT NULL,
  `ext_sessid` varchar(127) DEFAULT NULL,
  `ext_kundenid` varchar(127) DEFAULT NULL,
  `last_url` varchar(255) NOT NULL,
  `items` mediumint(5) NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `shipping` decimal(5,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) NOT NULL DEFAULT 'EUR',
  `time` datetime NOT NULL,
  `approved` datetime DEFAULT NULL,
  `paid_out` enum('y','n') NOT NULL DEFAULT 'n',
  `payout_id` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table publish_order_items
# ------------------------------------------------------------

CREATE TABLE `publish_order_items` (
  `item_id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL,
  `pd_id` int(10) NOT NULL,
  `medium` tinyint(3) NOT NULL DEFAULT '1',
  `descr_id` int(10) NOT NULL,
  `single_marge` decimal(5,2) NOT NULL,
  `currency` varchar(3) NOT NULL DEFAULT 'EUR',
  `marge_percent` smallint(3) NOT NULL DEFAULT '0',
  `quantity` mediumint(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table publish_payout
# ------------------------------------------------------------

CREATE TABLE `publish_payout` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `dta_id` int(10) NOT NULL DEFAULT '0',
  `amount` float(8,2) NOT NULL,
  `account` varchar(127) NOT NULL,
  `date` datetime NOT NULL,
  `done` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table publish_user
# ------------------------------------------------------------

CREATE TABLE `publish_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `vorname` varchar(127) DEFAULT NULL,
  `nachname` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL,
  `strasse` varchar(127) NOT NULL,
  `plz` varchar(8) NOT NULL,
  `ort` varchar(127) NOT NULL,
  `land` varchar(127) NOT NULL,
  `konto_nr` varchar(16) NOT NULL,
  `blz` varchar(16) NOT NULL,
  `iban` varchar(30) DEFAULT NULL,
  `bic` varchar(16) DEFAULT NULL,
  `default_for_new` enum('y','n') NOT NULL DEFAULT 'y',
  `marge_p` smallint(3) NOT NULL DEFAULT '0',
  `allowed_p` enum('y','n') NOT NULL DEFAULT 'n',
  `last_changed_p` datetime DEFAULT NULL,
  `marge_s` smallint(3) NOT NULL DEFAULT '0',
  `allowed_s` enum('y','n') NOT NULL DEFAULT 'n',
  `last_changed_s` datetime DEFAULT NULL,
  `marge_m` smallint(3) NOT NULL DEFAULT '0',
  `allowed_m` enum('y','n') NOT NULL DEFAULT 'n',
  `last_changed_m` datetime DEFAULT NULL,
  `marge_l` smallint(3) NOT NULL DEFAULT '0',
  `allowed_l` enum('y','n') NOT NULL DEFAULT 'n',
  `last_changed_l` datetime DEFAULT NULL,
  `gewerblich` enum('y','n') NOT NULL DEFAULT 'n',
  `umst_id` varchar(32) DEFAULT NULL,
  `active` enum('y','n','d') NOT NULL DEFAULT 'n',
  `anmerkung` varchar(127) DEFAULT NULL,
  `time_activated` datetime DEFAULT NULL,
  `time_created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table qmail
# ------------------------------------------------------------

CREATE TABLE `qmail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0',
  `fromuserid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `new` char(1) NOT NULL DEFAULT '',
  `priority` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `userkey` (`userid`,`time`),
  KEY `fromuserid` (`fromuserid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table RefCalendari
# ------------------------------------------------------------

CREATE TABLE `RefCalendari` (
  `ref` int(11) NOT NULL AUTO_INCREMENT,
  `refid` int(11) NOT NULL DEFAULT '0',
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `user` varchar(100) NOT NULL,
  `i` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ref`),
  KEY `refid` (`refid`),
  KEY `i` (`i`),
  KEY `refuserid_refid_i` (`refuserid`,`refid`,`i`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table RefDiscuss
# ------------------------------------------------------------

CREATE TABLE `RefDiscuss` (
  `ref` int(11) NOT NULL AUTO_INCREMENT,
  `refid` int(11) NOT NULL DEFAULT '0',
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ref`,`refuserid`),
  KEY `refuserid_refid` (`refuserid`,`refid`),
  KEY `refid` (`refid`),
  KEY `refuserid_time` (`refuserid`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (refuserid)
PARTITIONS 10 */;



# Dump of table RefFavorites
# ------------------------------------------------------------

CREATE TABLE `RefFavorites` (
  `ref` int(11) NOT NULL AUTO_INCREMENT,
  `refid` int(11) NOT NULL DEFAULT '0',
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `public` enum('y','n') NOT NULL DEFAULT 'n',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ref`,`refuserid`),
  KEY `refid_refuserid_public` (`refid`,`refuserid`,`public`),
  KEY `time_refuserid_refid_public` (`time`,`refuserid`,`refid`,`public`),
  KEY `refuserid_public` (`refuserid`,`public`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (refuserid)
PARTITIONS 10 */;



# Dump of table RefFotomails
# ------------------------------------------------------------

CREATE TABLE `RefFotomails` (
  `ref` int(11) NOT NULL AUTO_INCREMENT,
  `refid` int(11) NOT NULL DEFAULT '0',
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `neu` char(1) NOT NULL DEFAULT 'y',
  `submitter` varchar(60) NOT NULL DEFAULT '',
  `code` bigint(20) NOT NULL DEFAULT '0',
  `name` varchar(60) NOT NULL DEFAULT '',
  `userdef1` varchar(50) NOT NULL DEFAULT '',
  `reffromuserid` int(11) NOT NULL DEFAULT '0',
  `benach` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`ref`,`refuserid`),
  KEY `refuserid_neu` (`refuserid`,`neu`),
  KEY `refid` (`refid`),
  KEY `reffromuserid` (`reffromuserid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (refuserid)
PARTITIONS 10 */;



# Dump of table Refpicask
# ------------------------------------------------------------

CREATE TABLE `Refpicask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` int(5) NOT NULL DEFAULT '0',
  `descrid` int(11) NOT NULL DEFAULT '0',
  `status` enum('a','p','c') COLLATE latin1_german1_ci NOT NULL DEFAULT 'p',
  `verwendungsdauer` varchar(64) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `message` text COLLATE latin1_german1_ci NOT NULL,
  `datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `used_date` date NOT NULL DEFAULT '0000-00-00',
  `used` enum('0','1') COLLATE latin1_german1_ci NOT NULL DEFAULT '0',
  `zeitraum_bis` date NOT NULL DEFAULT '0000-00-00',
  `shadow` enum('0','1') COLLATE latin1_german1_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `descrid` (`descrid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table Refpv
# ------------------------------------------------------------

CREATE TABLE `Refpv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `stop` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `refid` int(11) NOT NULL DEFAULT '0',
  `active` char(1) NOT NULL DEFAULT '',
  `done` char(1) NOT NULL DEFAULT '',
  `whoright` mediumint(9) NOT NULL DEFAULT '0',
  `channel` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table Refpvpoints
# ------------------------------------------------------------

CREATE TABLE `Refpvpoints` (
  `refid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  `points` float NOT NULL DEFAULT '0',
  `pic` int(11) NOT NULL DEFAULT '0',
  `cat` mediumint(8) unsigned NOT NULL DEFAULT '0',
  KEY `userid` (`userid`,`points`),
  KEY `pic` (`pic`,`cat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table Refpvusers
# ------------------------------------------------------------

CREATE TABLE `Refpvusers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `catuserid` (`cat`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table saccounts
# ------------------------------------------------------------

CREATE TABLE `saccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(50) NOT NULL DEFAULT 'localhost',
  `account` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(20) NOT NULL DEFAULT '',
  `teamid` int(11) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table scase
# ------------------------------------------------------------

CREATE TABLE `scase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket` char(15) NOT NULL DEFAULT '',
  `open` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` char(1) NOT NULL DEFAULT '',
  `closed` char(1) NOT NULL DEFAULT '',
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `name` char(50) NOT NULL DEFAULT '',
  `email` char(100) NOT NULL DEFAULT '',
  `team` mediumint(9) NOT NULL DEFAULT '0',
  `byid` int(11) NOT NULL DEFAULT '0',
  `priority` smallint(6) NOT NULL DEFAULT '0',
  `status` char(1) NOT NULL DEFAULT '',
  `locked` int(11) NOT NULL DEFAULT '0',
  `intern` char(200) NOT NULL DEFAULT '',
  `keywords` char(200) NOT NULL DEFAULT '',
  `alert` char(1) NOT NULL DEFAULT '',
  `locktime` bigint(20) NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `casetype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `last` (`last`),
  KEY `locked` (`locked`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table scasetype
# ------------------------------------------------------------

CREATE TABLE `scasetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typecode` int(11) NOT NULL DEFAULT '0',
  `typetext` varchar(255) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `fclang` enum('0','1','2','3','4','5') COLLATE latin1_german1_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;


# Dump of table section_subscriptions
# ------------------------------------------------------------

CREATE TABLE `section_subscriptions` (
  `user_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`user_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table sedcard
# ------------------------------------------------------------

CREATE TABLE `sedcard` (
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(60) COLLATE latin1_german1_ci NOT NULL,
  `geschlecht` char(1) COLLATE latin1_german1_ci DEFAULT NULL,
  `plz` varchar(6) COLLATE latin1_german1_ci NOT NULL,
  `stadt` varchar(40) COLLATE latin1_german1_ci NOT NULL,
  `land` varchar(3) COLLATE latin1_german1_ci NOT NULL,
  `geburtstag` date NOT NULL,
  `isset_foto1` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `isset_foto2` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `isset_foto3` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `isset_foto4` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `isset_foto5` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `kontakt_text` varchar(250) COLLATE latin1_german1_ci DEFAULT NULL,
  `about_text` text COLLATE latin1_german1_ci,
  `koerpergroesse` char(5) COLLATE latin1_german1_ci DEFAULT '0',
  `gewicht` char(4) COLLATE latin1_german1_ci DEFAULT '0',
  `konfektionsgroesse` char(5) COLLATE latin1_german1_ci DEFAULT NULL,
  `schuhgroesse` char(2) COLLATE latin1_german1_ci DEFAULT '0',
  `brust` char(3) COLLATE latin1_german1_ci DEFAULT NULL,
  `taille` char(3) COLLATE latin1_german1_ci DEFAULT NULL,
  `huefte` char(3) COLLATE latin1_german1_ci DEFAULT NULL,
  `unterbrust` char(3) COLLATE latin1_german1_ci DEFAULT NULL,
  `koerbchen` char(2) COLLATE latin1_german1_ci NOT NULL DEFAULT '0',
  `haarfarbe` tinyint(1) NOT NULL DEFAULT '0',
  `haarlaenge` tinyint(1) NOT NULL DEFAULT '0',
  `augenfarbe` tinyint(1) NOT NULL DEFAULT '0',
  `teint` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_portrait` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_fashion` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_beauty` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_bademode` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_dessous` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_teilakt` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_akt` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_fetisch` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_video` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_bodypainting` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_tv` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_tanz` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_laufsteg` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_messe` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_studio` tinyint(1) NOT NULL DEFAULT '0',
  `bereich_outdoor` tinyint(1) NOT NULL DEFAULT '0',
  `einsatzgebiet` char(1) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `verfuegbarkeit` char(1) COLLATE latin1_german1_ci NOT NULL,
  `honorar_tfp` char(1) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `honorar_text` varchar(250) COLLATE latin1_german1_ci DEFAULT NULL,
  `anzahl_referenzen` int(10) unsigned NOT NULL DEFAULT '0',
  `referenzen_text` text COLLATE latin1_german1_ci,
  `referenzen_rendered` text COLLATE latin1_german1_ci,
  `option_sedcard_active` enum('y','n','d','x','c') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `option_sedcard_first` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `option_contactinfo_requires_login` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `option_bookingform_requires_login` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'y',
  `option_hide_bookingform` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `option_deactivate_mypics_link` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `option_show_age` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'y',
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_indexed` enum('y','n') COLLATE latin1_german1_ci NOT NULL,
  `scase_id` int(10) unsigned NOT NULL,
  `date_confirmed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `qualified` enum('y','n') COLLATE latin1_german1_ci NOT NULL DEFAULT 'n',
  `latitude` double(16,10) NOT NULL,
  `longitude` double(16,10) NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `active_date_created` (`option_sedcard_active`,`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table sedcard_referenzen
# ------------------------------------------------------------

CREATE TABLE `sedcard_referenzen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `refuserid` int(10) unsigned NOT NULL DEFAULT '0',
  `refusername` varchar(60) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `position` char(1) COLLATE latin1_german1_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`,`refuserid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table sellable_photos
# ------------------------------------------------------------

CREATE TABLE `sellable_photos` (
  `photo_id` bigint(20) NOT NULL,
  `print` tinyint(1) NOT NULL DEFAULT '0',
  `download` tinyint(1) NOT NULL DEFAULT '0',
  `comments` int(11) DEFAULT NULL,
  `favorites` int(11) DEFAULT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table seller_address
# ------------------------------------------------------------

CREATE TABLE `seller_address` (
  `userid` int(10) unsigned NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `commercial` tinyint(1) DEFAULT '0',
  `ustid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table seller_status
# ------------------------------------------------------------

CREATE TABLE `seller_status` (
  `userid` int(10) unsigned NOT NULL,
  `agb_accepted` tinyint(1) DEFAULT '0',
  `agb_fcprints_accepted` tinyint(1) DEFAULT '0',
  `date_agb_accepted` datetime DEFAULT NULL,
  `approved` tinyint(1) DEFAULT '0',
  `date_approved` datetime DEFAULT NULL,
  `print` tinyint(1) DEFAULT '0',
  `download` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `approved` (`approved`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table semails
# ------------------------------------------------------------

CREATE TABLE `semails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `account` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table service_history
# ------------------------------------------------------------

CREATE TABLE `service_history` (
  `service_command_id` int(11) NOT NULL DEFAULT '0',
  `provider_id` smallint(6) NOT NULL DEFAULT '0',
  `provider_user_id` varchar(128) COLLATE latin1_german1_ci NOT NULL DEFAULT '0',
  `provider_subscription_id` varchar(127) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `product_option_id` int(11) NOT NULL DEFAULT '0',
  `product_name` varchar(128) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `recurring` char(1) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `valid` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` char(1) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `umst` decimal(10,2) NOT NULL DEFAULT '0.00',
  `currency` char(3) COLLATE latin1_german1_ci NOT NULL DEFAULT 'EUR',
  `command` varchar(25) COLLATE latin1_german1_ci NOT NULL,
  `reason` varchar(128) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  `fclang` enum('0','1','2','3','4','5') COLLATE latin1_german1_ci DEFAULT NULL,
  PRIMARY KEY (`service_command_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table signup_key
# ------------------------------------------------------------

CREATE TABLE `signup_key` (
  `signupkey` char(10) NOT NULL DEFAULT '',
  `userid` int(14) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`signupkey`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table smessage
# ------------------------------------------------------------

CREATE TABLE `smessage` (
  `ref` int(11) NOT NULL AUTO_INCREMENT,
  `refid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type` char(1) NOT NULL DEFAULT '',
  `refby` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(30) NOT NULL DEFAULT '',
  `header` text NOT NULL,
  `body` text NOT NULL,
  `account` int(11) NOT NULL DEFAULT '0',
  `file1` varchar(100) NOT NULL DEFAULT '',
  `file2` varchar(100) NOT NULL DEFAULT '',
  `file3` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`ref`,`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (refid)
PARTITIONS 10 */;



# Dump of table spammer_rating
# ------------------------------------------------------------

CREATE TABLE `spammer_rating` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `activity` varchar(32) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table speaking_bild_urls
# ------------------------------------------------------------

CREATE TABLE `speaking_bild_urls` (
  `refid` int(12) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '-',
  PRIMARY KEY (`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table sright
# ------------------------------------------------------------

CREATE TABLE `sright` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `refuserid` int(11) NOT NULL DEFAULT '0',
  `rights` char(255) NOT NULL,
  `alert` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `refuserid` (`refuserid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table system_tags_migration_photos
# ------------------------------------------------------------

CREATE TABLE `system_tags_migration_photos` (
  `photo_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table tags_buddies
# ------------------------------------------------------------

CREATE TABLE `tags_buddies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) COLLATE latin1_german1_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table tags_photos
# ------------------------------------------------------------

CREATE TABLE `tags_photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table tags_to_buddies
# ------------------------------------------------------------

CREATE TABLE `tags_to_buddies` (
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `refid` int(10) unsigned NOT NULL DEFAULT '0',
  `tagid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`,`refid`,`tagid`),
  KEY `userid-refid` (`userid`,`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table tags_to_photos
# ------------------------------------------------------------

CREATE TABLE `tags_to_photos` (
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `refid` int(10) unsigned NOT NULL DEFAULT '0',
  `tagid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`,`refid`,`tagid`),
  KEY `refid` (`refid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table top_photos
# ------------------------------------------------------------

CREATE TABLE `top_photos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned DEFAULT NULL,
  `photoid` int(10) unsigned DEFAULT NULL,
  `sort` int(10) unsigned DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`,`sort`),
  KEY `photoid` (`photoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table translations
# ------------------------------------------------------------

CREATE TABLE `translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `translation_tag` varchar(30) NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  `name` varchar(100) NOT NULL,
  `shortname` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `title_extension` varchar(200) NOT NULL,
  `meta_description` text NOT NULL,
  `keywords` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `translation_tag_fclang` (`translation_tag`,`fclang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table upload_gutschrift
# ------------------------------------------------------------

CREATE TABLE `upload_gutschrift` (
  `userid` int(10) NOT NULL DEFAULT '0',
  `anzahl` int(6) NOT NULL DEFAULT '0',
  `grund` text NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table uploads
# ------------------------------------------------------------

CREATE TABLE `uploads` (
  `id` int(11) NOT NULL DEFAULT '0',
  `userid` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `channel` smallint(4) NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `counts` smallint(6) NOT NULL DEFAULT '0',
  `berechtigung` enum('s','g') NOT NULL DEFAULT 's',
  PRIMARY KEY (`id`,`userid`,`berechtigung`),
  KEY `userid_berechtigung_time` (`userid`,`berechtigung`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (userid)
PARTITIONS 10 */;



# Dump of table user_interests
# ------------------------------------------------------------

CREATE TABLE `user_interests` (
  `user_id` int(11) NOT NULL,
  `interest_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_interests_identifier
# ------------------------------------------------------------

CREATE TABLE `user_interests_identifier` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_interests_onboarding
# ------------------------------------------------------------

CREATE TABLE `user_interests_onboarding` (
  `user_id` int(11) NOT NULL,
  `interest_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Dump of table user_limits
# ------------------------------------------------------------

CREATE TABLE `user_limits` (
  `userid` int(11) NOT NULL DEFAULT '0',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `action` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_logins
# ------------------------------------------------------------

CREATE TABLE `user_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `login_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`,`login_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_permission
# ------------------------------------------------------------

CREATE TABLE `user_permission` (
  `user_id` int(11) unsigned NOT NULL,
  `permission_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_properties
# ------------------------------------------------------------

CREATE TABLE `user_properties` (
  `user_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_properties_identifier
# ------------------------------------------------------------

CREATE TABLE `user_properties_identifier` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `rank` smallint(3) DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_social_networks
# ------------------------------------------------------------

CREATE TABLE `user_social_networks` (
  `userid` int(14) unsigned NOT NULL,
  `social_network_id` tinyint(1) unsigned NOT NULL,
  `social_network_userid` varchar(128) NOT NULL,
  `profile_image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userid`,`social_network_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table userdelete_queue
# ------------------------------------------------------------

CREATE TABLE `userdelete_queue` (
  `userid` int(10) unsigned NOT NULL,
  `by_userid` int(10) unsigned NOT NULL,
  `agb` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `in_progress` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table users
# ------------------------------------------------------------

CREATE TABLE `users` (
  `login` varchar(254) NOT NULL,
  `pass` varchar(32) NOT NULL DEFAULT '',
  `cookieval` varchar(128) NOT NULL DEFAULT '',
  `seclevel` int(11) NOT NULL DEFAULT '0',
  `userid` int(14) NOT NULL AUTO_INCREMENT,
  `vorname` varchar(60) NOT NULL,
  `picid` int(11) NOT NULL DEFAULT '0',
  `fclang` enum('0','1','2','3','4','5') NOT NULL DEFAULT '1',
  `text` text NOT NULL,
  `uploads` int(11) NOT NULL DEFAULT '0',
  `comments` int(11) NOT NULL DEFAULT '0',
  `credits` int(11) NOT NULL DEFAULT '0',
  `visits` int(11) NOT NULL DEFAULT '0',
  `active` char(1) NOT NULL DEFAULT 'n',
  `web` varchar(100) NOT NULL DEFAULT '',
  `geburtstag` datetime DEFAULT NULL,
  `benach` smallint(6) NOT NULL DEFAULT '0',
  `newsletter` smallint(6) NOT NULL DEFAULT '0',
  `newsletter_special` smallint(6) NOT NULL DEFAULT '0',
  `anmeldedatum` int(14) NOT NULL DEFAULT '0',
  `geschlecht` char(1) NOT NULL DEFAULT '',
  `stadt` varchar(40) NOT NULL DEFAULT '',
  `woher` varchar(32) NOT NULL,
  `wohertext` varchar(50) NOT NULL DEFAULT '',
  `pmail` char(1) NOT NULL DEFAULT '',
  `agb` char(1) NOT NULL DEFAULT 'n',
  `seclevel2` int(11) NOT NULL DEFAULT '0',
  `plz` varchar(6) NOT NULL DEFAULT '',
  `homedesign` int(11) NOT NULL DEFAULT '0',
  `showpw` char(1) NOT NULL DEFAULT 'n',
  `nick` varchar(30) NOT NULL DEFAULT '',
  `domain` smallint(6) NOT NULL DEFAULT '0',
  `account` smallint(6) NOT NULL DEFAULT '0',
  `valid` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `recurring` enum('n','y','q','u','b') NOT NULL DEFAULT 'n',
  `online` int(14) NOT NULL DEFAULT '0',
  `ccode` mediumint(9) NOT NULL DEFAULT '0',
  `showonline` char(1) NOT NULL DEFAULT 'y',
  `showfh` char(1) NOT NULL DEFAULT 'y',
  `moveright` char(1) NOT NULL DEFAULT 'a',
  `votingcomments` enum('y','n') NOT NULL DEFAULT 'y',
  `logsec` char(1) NOT NULL DEFAULT 'y',
  `qmsec` char(1) NOT NULL DEFAULT 'n',
  `datesec` char(1) NOT NULL DEFAULT 'i',
  `datenew` char(1) NOT NULL DEFAULT 'n',
  `dateplz` varchar(22) NOT NULL DEFAULT '',
  `globalmode` enum('n','y') NOT NULL DEFAULT 'n',
  `processor` enum('f','p','b','v','m','0','e','w') NOT NULL DEFAULT '0',
  `account_active` char(1) NOT NULL DEFAULT 'y',
  `formular_status` enum('0','1') NOT NULL DEFAULT '0',
  `adfree` enum('y','n') NOT NULL DEFAULT 'n',
  `creativecommons` varchar(20) NOT NULL,
  `feedlogging` text NOT NULL,
  `filterfeedview` text NOT NULL,
  `pass_secure` enum('y','n') NOT NULL DEFAULT 'n',
  `log_my_visits` enum('y','n') NOT NULL DEFAULT 'y',
  `global_sichtbar` tinyint(2) NOT NULL DEFAULT '1',
  `last_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `facebook_like` char(1) NOT NULL DEFAULT 'y',
  `credentials` text,
  `hideNude` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `login` (`login`),
  KEY `cookieval` (`cookieval`(4)),
  KEY `vorname` (`vorname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_delete
# ------------------------------------------------------------

CREATE TABLE `users_delete` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `user_mail` varchar(254) NOT NULL,
  `user_name` varchar(60) NOT NULL,
  `deleted_by` int(10) NOT NULL,
  `account` int(4) NOT NULL DEFAULT '2',
  `domain` tinyint(1) NOT NULL DEFAULT '1',
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_email_notification
# ------------------------------------------------------------

CREATE TABLE `users_email_notification` (
  `userid` int(10) unsigned NOT NULL,
  `comments` tinyint(1) NOT NULL DEFAULT '1',
  `comment_replies` tinyint(1) NOT NULL DEFAULT '1',
  `reply_siblings` tinyint(1) NOT NULL DEFAULT '1',
  `comment_likes` tinyint(1) NOT NULL DEFAULT '1',
  `favorites` tinyint(1) NOT NULL DEFAULT '1',
  `likes` tinyint(1) NOT NULL DEFAULT '1',
  `followers` tinyint(1) NOT NULL DEFAULT '1',
  `mentions` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_log
# ------------------------------------------------------------

CREATE TABLE `users_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `userid` int(14) NOT NULL,
  `type` varchar(255) NOT NULL,
  `refuserid` int(14) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_privacy_settings
# ------------------------------------------------------------

CREATE TABLE `users_privacy_settings` (
  `userid` int(10) unsigned NOT NULL,
  `anonymous_follow` tinyint(1) NOT NULL DEFAULT '0',
  `disable_photo_filters` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_profile
# ------------------------------------------------------------

CREATE TABLE `users_profile` (
  `userid` int(10) unsigned NOT NULL,
  `equipment` text NOT NULL,
  `showTopPhotos` tinyint(1) NOT NULL DEFAULT '1',
  `showOwnProfileDialog` tinyint(1) NOT NULL DEFAULT '1',
  `filterMyCommunityPhotos` tinyint(1) NOT NULL DEFAULT '0',
  `filterMyCommunityFavorites` tinyint(1) NOT NULL DEFAULT '0',
  `sortMyCommunityDiscussions` tinyint(1) NOT NULL DEFAULT '0',
  `showProfileStats` tinyint(1) NOT NULL DEFAULT '1',
  `i_am` varchar(160) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_special
# ------------------------------------------------------------

CREATE TABLE `users_special` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `special` enum('m','h','f','b','a','d','p','v') NOT NULL DEFAULT 'm',
  `value` mediumint(9) NOT NULL DEFAULT '0',
  `valid` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`,`special`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users_urls
# ------------------------------------------------------------

CREATE TABLE `users_urls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL,
  `url` varchar(255) NOT NULL,
  `priority` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `prio` (`userid`,`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table vote
# ------------------------------------------------------------

CREATE TABLE `vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0',
  `refid` int(11) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `std` (`refid`,`userid`),
  KEY `std2` (`refid`,`vote`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table warteschlange
# ------------------------------------------------------------

CREATE TABLE `warteschlange` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prioritaet` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `refid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` enum('galerie','contest','vorschlag') COLLATE latin1_german1_ci NOT NULL DEFAULT 'galerie',
  `refuserid` int(10) unsigned NOT NULL DEFAULT '0',
  `userid_owner` int(10) unsigned NOT NULL DEFAULT '0',
  `slot_start` datetime DEFAULT NULL,
  `slot_stop` datetime DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `channel` int(4) NOT NULL,
  `fclang` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_slot` (`slot_start`,`slot_stop`,`fclang`),
  KEY `fclang` (`fclang`,`refid`),
  KEY `userid_owner_id` (`userid_owner`),
  KEY `refid_slot_start` (`refid`,`slot_start`),
  KEY `fclang_refid_slot_start` (`fclang`,`refid`,`slot_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;



# Dump of table whitewall_orders
# ------------------------------------------------------------

CREATE TABLE `whitewall_orders` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT,
  `itemCount` int(11) NOT NULL COMMENT 'Anzahl der bestellten Produkte',
  `netItemShare` float NOT NULL COMMENT 'Nettopreis',
  `netItemShareTotal` float NOT NULL COMMENT 'Netto-Anteil am Produktpreis (Summe)',
  `netLicenceShare` float NOT NULL COMMENT 'Netto-Marge',
  `netLicenceShareTotal` float NOT NULL COMMENT 'Netto Lizenz-Anteil für Contentgeber (Summe)',
  `currency` varchar(32) NOT NULL COMMENT 'Währung',
  `processId` int(11) NOT NULL COMMENT 'ID des Prozesses, der die Bestellung ausgelöst hat\n',
  `referenceId` int(11) NOT NULL COMMENT 'ID der Bestellposition (Zeile auf der Rechnung)',
  `printSize` varchar(32) NOT NULL COMMENT 'Größe des bestellten Produkts',
  `artistAccountId` int(11) NOT NULL COMMENT 'Account-ID des Verkäufers zum Zeitpunkt der Bestellung',
  `artistTaxIdNumber` varchar(20) DEFAULT NULL COMMENT 'Umsatzsteuer-Identifikationsnummer des Verkäufers zum Zeitpunkt der Bestellung',
  `confirmation` datetime DEFAULT NULL,
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bestellungen, die bei whitewall abgeschickt wurden';



# Dump of table whitewall_processes
# ------------------------------------------------------------

CREATE TABLE `whitewall_processes` (
  `processId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID des Prozesses',
  `processToken` varchar(34) NOT NULL COMMENT 'Token, unter dem der Przess verarbeitet wird: fc([0-9a-z){32})',
  `userId` int(11) DEFAULT NULL COMMENT 'User, der den Prozess angestoßen hat (falls bekannt)',
  `motifId` int(11) DEFAULT NULL COMMENT 'Bild, über das der Prozess ausgelöst wurde',
  `processStart` datetime NOT NULL COMMENT 'Zeitpunkt, an dem der Prozess gestartet wurde',
  PRIMARY KEY (`processId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Prozesse, die an whitewall übergeben wurden (fotoprints)';



# Dump of table xcomments
# ------------------------------------------------------------

CREATE TABLE `xcomments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text NOT NULL,
  `datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user` text NOT NULL,
  `ip` varchar(16) NOT NULL DEFAULT '',
  `userid` int(11) NOT NULL DEFAULT '0',
  `refid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`refid`),
  KEY `userid` (`userid`),
  KEY `refid_type` (`refid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LINEAR HASH (refid)
PARTITIONS 10 */;


# Dump of table votings
# ------------------------------------------------------------

CREATE TABLE `votings2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `locale` char(2) NOT NULL,
  `is_anonym` TINYINT(1) NOT NULL DEFAULT '0',
  `is_started` TINYINT(1) NOT NULL DEFAULT '0',
  `is_finished` TINYINT(1) NOT NULL DEFAULT '0',
  `allow_comments` TINYINT(1) NOT NULL DEFAULT '0',
  `votes_pro` int(11) NOT NULL DEFAULT '0',
  `votes_contra` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  UNIQUE KEY `photo_id` (`photo_id`),
  KEY `current_votings` (`is_started`, `is_finished`, `locale`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table voting_votes
# ------------------------------------------------------------

CREATE TABLE `voting_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voting_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vote` TINYINT(1) NOT NULL,
  `date_created` datetime NOT NULL,
  UNIQUE KEY `unique_vote` (`voting_id`,`user_id`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `voting_comments` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `voting_id` int(11) NOT NULL,
    `user_id` int(11) NOT NULL,
    `comment` text NOT NULL,
    `date_created` datetime NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Dump of table photo_awards
# ------------------------------------------------------------

CREATE TABLE `photo_awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `payload` text NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`user_id`),
  KEY `photoid` (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# OFFICE DASHBOARD TRIGGERS

DELIMITER $$

# USER

CREATE TRIGGER dashboard_user_added
after insert ON users
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET users = users + 1;
END$$

CREATE TRIGGER dashboard_user_removed
after delete ON users
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET users = users - 1;
END$$

# PHOTO

CREATE TRIGGER dashboard_photo_added
after insert ON descr
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET photos = photos + 1;
END$$

CREATE TRIGGER dashboard_photo_removed
after delete ON descr
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET photos = photos - 1;
END$$

# COMMENT

CREATE TRIGGER dashboard_comment_added
after insert ON photo_comments
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET comments = comments + 1;
END$$

CREATE TRIGGER dashboard_comment_removed
after delete ON photo_comments
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET comments = comments - 1;
END$$

# LIKE

CREATE TRIGGER dashboard_like_added
after insert ON photo_likes
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET likes = likes + 1;
END$$

CREATE TRIGGER dashboard_like_removed
after delete ON photo_likes
FOR EACH ROW
BEGIN
   UPDATE office_dashboard SET likes = likes - 1;
END$$

DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
