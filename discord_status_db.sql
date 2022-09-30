-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 06. Aug, 2022 18:43 PM
-- Tjener-versjon: 10.3.31-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 7.3.29-1+focal

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s84_farlrp_status`
--

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `servers`
--

CREATE TABLE `servers` (
  `id` int(11) NOT NULL,
  `activity` int(11) NOT NULL DEFAULT 0,
  `friendly_name` text DEFAULT NULL,
  `shortname` varchar(10) NOT NULL,
  `country` int(1) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0,
  `maintainance` int(1) NOT NULL DEFAULT 0,
  `ip` varchar(255) NOT NULL DEFAULT 'play.legacyh.xyz',
  `port` int(5) NOT NULL DEFAULT 0,
  `discord_id` bigint(20) DEFAULT NULL,
  `discord_cat` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` text NOT NULL,
  `steam_id` bigint(17) NOT NULL DEFAULT 0,
  `rank` int(2) NOT NULL DEFAULT 0,
  `name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dataark for tabell `users`
--

INSERT INTO `users` (`user_id`, `username`, `steam_id`, `rank`, `name`) VALUES
(1, 'Mr. Angel', 76561198020713701, 4, 'Angel');

-- --------------------------------------------------------

--
-- Tabellstruktur for tabell `users_auth`
--

CREATE TABLE `users_auth` (
  `steam_id` bigint(17) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `shortname` (`shortname`),
  ADD UNIQUE KEY `discord_id` (`discord_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `servers`
--
ALTER TABLE `servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
