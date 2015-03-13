-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 13, 2015 at 10:09 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `symfony`
--

-- --------------------------------------------------------

--
-- Table structure for table `ode_dataset`
--

CREATE TABLE IF NOT EXISTS `ode_dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci NOT NULL,
  `num_instances` int(11) NOT NULL,
  `num_features` int(11) NOT NULL,
  `filetype` longtext COLLATE utf8_unicode_ci NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `filename` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ode_dataset`
--

INSERT INTO `ode_dataset` (`id`, `name`, `description`, `num_instances`, `num_features`, `filetype`, `filesize`, `filename`) VALUES
(1, 'Iris', '', 150, 4, 'CSV', 3867, 'iris'),
(2, 'Pima Indians Diabetes', '', 768, 8, 'CSV', 24576, 'pima-indians-diabetes');

-- --------------------------------------------------------

--
-- Table structure for table `ode_results`
--

CREATE TABLE IF NOT EXISTS `ode_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `algorithm` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `params` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  `runtime` int(11) DEFAULT NULL,
  `finished` tinyint(1) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dataset` int(11) NOT NULL,
  `result` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ode_results`
--

INSERT INTO `ode_results` (`id`, `algorithm`, `params`, `runtime`, `finished`, `username`, `dataset`, `result`) VALUES
(1, 'rf', NULL, NULL, 0, 'reid.johnson2', 1, NULL),
(2, 'lg', NULL, NULL, 1, 'reid.johnson2', 1, '{"auroc": 0.62, "precision": 0.1, "accuracy": 0.3215}');

-- --------------------------------------------------------

--
-- Table structure for table `ode_user`
--

CREATE TABLE IF NOT EXISTS `ode_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `locked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `credentials_expired` tinyint(1) NOT NULL,
  `credentials_expire_at` datetime DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `affiliation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastEdited` datetime NOT NULL,
  `profilePicturePath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_5DBDCA2E92FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_5DBDCA2EA0D96FBF` (`email_canonical`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ode_user`
--

INSERT INTO `ode_user` (`id`, `username`, `username_canonical`, `email`, `email_canonical`, `enabled`, `salt`, `password`, `last_login`, `locked`, `expired`, `expires_at`, `confirmation_token`, `password_requested_at`, `roles`, `credentials_expired`, `credentials_expire_at`, `firstname`, `lastname`, `affiliation`, `lastEdited`, `profilePicturePath`) VALUES
(1, 'reid.johnson', 'reid.johnson', 'reid.johnson@gmail.com', 'reid.johnson@gmail.com', 1, 'h6egfskoq6o8sgw84kkso04w8woo484', 'EDBESSCGHZzSGt8Rpjp5QeBBIT7pGQyDzCGNtn/WfmQMCqRihqQ5CpLoTbUuU3vFTXXTENsraTn2HrWzTlo5zQ==', '2015-03-04 20:23:15', 0, 0, NULL, NULL, NULL, 'a:0:{}', 0, NULL, 'Reid', 'Johnson', 'University of Notre Dame', '0000-00-00 00:00:00', NULL),
(2, 'reid.johnson2', 'reid.johnson2', 'reid.johnson2@gmail.com', 'reid.johnson2@gmail.com', 1, '7n4ioe1jpf0ogsccw8sg0k0g8wg8s4k', 'N7V6tfZxrxtMzBW4Dhhd/XWF76W6AVRCvcK3jMSB2ZjTcOTGccJb+XYPdIvZGYnS5ZTVU6EGK7mkjlnS0+A+PA==', '2015-03-11 02:16:44', 0, 0, NULL, NULL, NULL, 'a:0:{}', 0, NULL, 'Reid', 'Johnson', 'University of Notre Dame', '2015-03-11 02:16:44', '/assets/profilepictures/8d1e883c7aa219a5cef55aa8e2e6442c');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
