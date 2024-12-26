-- --------------------------------------------------------
-- Host:                         db.legacyhosting.xyz
-- Server version:               11.7.1-MariaDB-ubu2204 - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for lega_lh_status
CREATE DATABASE IF NOT EXISTS `lega_lh_status` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci */;
USE `lega_lh_status`;

-- Dumping structure for table lega_lh_status.maintainance
CREATE TABLE IF NOT EXISTS `maintainance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` enum('Planned','Currently','Finished','') DEFAULT 'Planned',
  `sent_disc` enum('No','Yes') NOT NULL DEFAULT 'No',
  `start` datetime DEFAULT NULL,
  `est_end` datetime DEFAULT NULL,
  `type` enum('Maintenance on Router','Maintenance on Server') DEFAULT NULL,
  `affected_1` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_2` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_3` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_4` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_5` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_6` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_7` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_8` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_9` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  `affected_10` enum('DE.Node.GS1','DE.Node.GS2','DE.Node.BOT1','DE.Node.BOT2','DE.Node.VS1','DE.Node.VS2','DE.Node.WEB1','DE.Node.WEB2','FI.Node.GS1','FI.Node.GS2','FI.Node.BOT1','FI.Node.BOT2','FI.Node.VS1','FI.Node.VS2','FI.Node.WEB1','FI.Node.WEB2','FR.Node.GS1','FR.Node.GS2','FR.Node.BOT1','FR.Node.BOT2','FR.Node.VS1','FR.Node.VS2','FR.Node.WEB1','FR.Node.WEB2','NL.Node.GS1','NL.Node.GS2','NL.Node.BOT1','NL.Node.BOT2','NL.Node.VS1','NL.Node.VS2','NL.Node.WEB1','NL.Node.WEB2','NO.Node.GS1','NO.Node.GS2','NO.Node.BOT1','NO.Node.BOT2','NO.Node.VS1','NO.Node.VS2','NO.Node.WEB1','NO.Node.WEB2') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table lega_lh_status.servers
CREATE TABLE IF NOT EXISTS `servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity` int(1) NOT NULL DEFAULT 1,
  `status` int(1) NOT NULL DEFAULT 0,
  `maintainance` int(1) NOT NULL DEFAULT 0,
  `service` int(1) DEFAULT 0,
  `service_name` enum('CP-Panel','GS-Panel','Status-System','WEB-Panel') DEFAULT NULL,
  `country` enum('DE','FI','FR','NL','NO') DEFAULT NULL,
  `type` enum('Node') DEFAULT 'Node',
  `type2` enum('GS','VS','BOT','WEB','FTP','DB','WIN') DEFAULT NULL,
  `number` enum('1','2','3','4','5','6','7','8','9','10') DEFAULT NULL,
  `ip` enum('legacyh.fyi','legacyh.xyz','legacyh.dev','legacyhosting.xyz') NOT NULL DEFAULT 'legacyh.fyi',
  `port` int(5) DEFAULT 22,
  `discord_id` bigint(20) DEFAULT NULL,
  `discord_cat` bigint(20) DEFAULT NULL,
  `info` enum('Planned Maintainance','Locating Problem','Power Outage') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `discord_id` (`discord_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table lega_lh_status.session
CREATE TABLE IF NOT EXISTS `session` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT 0,
  `data` blob NOT NULL,
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table lega_lh_status.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `steam_id` bigint(17) NOT NULL DEFAULT 0,
  `rank` int(2) NOT NULL DEFAULT 0,
  `name` text DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table lega_lh_status.users_auth
CREATE TABLE IF NOT EXISTS `users_auth` (
  `steam_id` bigint(17) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
