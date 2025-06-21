-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mariadb:3306
-- Generation Time: Jun 21, 2025 at 08:26 AM
-- Server version: 11.6.2-MariaDB-ubu2404
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zap1312222-1`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_users`
--

CREATE TABLE `bank_users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `bank_users`
--

INSERT INTO `bank_users` (`id`, `name`, `identifier`, `charidentifier`, `money`, `gold`, `items`, `invspace`) VALUES
(1, 'Valentine', 'steam:11000016e197d4f', 2, 10.00, 0.00, '[]', 10),
(2, 'Blackwater', 'steam:11000016e197d4f', 2, 100.00, 0.00, '[]', 10),
(3, 'Valentine', 'steam:1100001486701fd', 3, 100.00, 0.00, '[]', 10),
(4, 'Rhodes', 'steam:11000016e197d4f', 2, 0.00, 0.00, '[]', 10),
(5, 'Valentine', 'steam:11000016e197d4f', 5, 5000.00, 0.00, '[]', 100),
(6, 'Valentine', 'steam:1100001486701fd', 7, 1850.00, 2000.00, '[]', 10),
(7, 'Valentine', 'steam:1100001562b75f9', 8, 1000.00, 5000.00, '[]', 10),
(8, 'Valentine', 'steam:110000162cead19', 9, 0.00, 0.00, '[]', 10),
(9, 'Valentine', 'steam:11000016db4fdd0', 11, 150.00, 3500.00, '[]', 10),
(10, 'Valentine', 'steam:11000016e97323d', 10, 900.00, 0.00, '[]', 10);

-- --------------------------------------------------------

--
-- Table structure for table `bcchousing`
--

CREATE TABLE `bcchousing` (
  `charidentifier` varchar(50) NOT NULL,
  `house_coords` longtext NOT NULL,
  `house_radius_limit` varchar(100) NOT NULL,
  `houseid` int(11) NOT NULL,
  `furniture` longtext NOT NULL DEFAULT 'none',
  `doors` longtext NOT NULL DEFAULT 'none',
  `allowed_ids` longtext NOT NULL DEFAULT 'none',
  `invlimit` varchar(50) NOT NULL DEFAULT '200',
  `player_source_spawnedfurn` varchar(50) NOT NULL DEFAULT 'none',
  `taxes_collected` varchar(50) NOT NULL DEFAULT 'false',
  `ledger` float NOT NULL DEFAULT 0,
  `tax_amount` float NOT NULL DEFAULT 0,
  `tpInt` int(10) DEFAULT 0,
  `tpInstance` int(10) DEFAULT 0,
  `uniqueName` varchar(255) NOT NULL,
  `ownershipStatus` enum('purchased','rented') NOT NULL DEFAULT 'purchased'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bcchousinghotels`
--

CREATE TABLE `bcchousinghotels` (
  `charidentifier` varchar(50) NOT NULL,
  `hotels` longtext NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `bcchousinghotels`
--

INSERT INTO `bcchousinghotels` (`charidentifier`, `hotels`) VALUES
('5', '[1]'),
('1', 'none'),
('8', 'none'),
('10', '[1]'),
('11', 'none'),
('9', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `bcchousing_transactions`
--

CREATE TABLE `bcchousing_transactions` (
  `id` int(11) NOT NULL,
  `houseid` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bcc_camp`
--

CREATE TABLE `bcc_camp` (
  `id` int(11) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `campname` varchar(50) NOT NULL DEFAULT '',
  `stash` double NOT NULL DEFAULT 0,
  `furniture` text DEFAULT NULL,
  `camp_coordinates` longtext DEFAULT NULL,
  `tent_model` varchar(255) NOT NULL DEFAULT 'default_tent_model',
  `condition` int(11) NOT NULL DEFAULT 100,
  `last_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `members` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`members`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bcc_crafting_log`
--

CREATE TABLE `bcc_crafting_log` (
  `id` int(11) NOT NULL,
  `charidentifier` varchar(50) NOT NULL,
  `itemName` varchar(100) NOT NULL,
  `itemLabel` varchar(100) NOT NULL,
  `itemAmount` int(11) NOT NULL,
  `requiredItems` text NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `duration` int(11) NOT NULL,
  `rewardXP` int(11) NOT NULL,
  `completed_at` datetime DEFAULT NULL,
  `locationId` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bcc_crafting_log`
--

INSERT INTO `bcc_crafting_log` (`id`, `charidentifier`, `itemName`, `itemLabel`, `itemAmount`, `requiredItems`, `timestamp`, `status`, `duration`, `rewardXP`, `completed_at`, `locationId`) VALUES
(1, '5', 'steak', 'Grilled Meat', 1, '[{\"removeItem\":true,\"itemCount\":1,\"itemName\":\"meat\",\"itemLabel\":\"Meat\"}]', 1750438551, 'completed', 10, 1, '2025-06-21 06:49:33', 'food');

-- --------------------------------------------------------

--
-- Table structure for table `bcc_craft_progress`
--

CREATE TABLE `bcc_craft_progress` (
  `charidentifier` varchar(50) NOT NULL,
  `currentXP` int(11) NOT NULL DEFAULT 0,
  `currentLevel` int(11) NOT NULL DEFAULT 1,
  `lastLevel` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bcc_craft_progress`
--

INSERT INTO `bcc_craft_progress` (`charidentifier`, `currentXP`, `currentLevel`, `lastLevel`) VALUES
('1', 0, 1, 1),
('10', 0, 1, 1),
('5', 0, 1, 1),
('8', 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bcc_farming`
--

CREATE TABLE `bcc_farming` (
  `plant_id` int(40) NOT NULL,
  `plant_coords` longtext NOT NULL,
  `plant_type` varchar(40) NOT NULL,
  `plant_watered` char(6) NOT NULL DEFAULT 'false',
  `time_left` varchar(100) NOT NULL,
  `plant_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `plant_owner` int(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brewing`
--

CREATE TABLE `brewing` (
  `id` uuid NOT NULL,
  `propname` varchar(255) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `h` double DEFAULT NULL,
  `isbrewing` int(11) DEFAULT NULL,
  `stage` int(11) DEFAULT NULL,
  `currentbrew` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `steamname` varchar(50) NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL,
  `group` varchar(10) DEFAULT 'user',
  `money` double(11,2) DEFAULT 0.00,
  `gold` double(11,2) DEFAULT 0.00,
  `rol` double(11,2) NOT NULL DEFAULT 0.00,
  `xp` int(11) DEFAULT 0,
  `healthouter` int(4) DEFAULT 500,
  `healthinner` int(4) DEFAULT 100,
  `staminaouter` int(4) DEFAULT 100,
  `staminainner` int(4) DEFAULT 100,
  `hours` float NOT NULL DEFAULT 0,
  `LastLogin` date DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `slots` decimal(20,1) NOT NULL DEFAULT 35.0,
  `job` varchar(50) DEFAULT 'unemployed',
  `joblabel` varchar(255) DEFAULT 'Unemployed',
  `meta` varchar(255) NOT NULL DEFAULT '{}',
  `firstname` varchar(50) DEFAULT ' ',
  `lastname` varchar(50) DEFAULT ' ',
  `character_desc` mediumtext NOT NULL DEFAULT ' ',
  `gender` varchar(50) NOT NULL DEFAULT ' ',
  `age` int(11) NOT NULL DEFAULT 0,
  `nickname` varchar(50) DEFAULT ' ',
  `skinPlayer` longtext DEFAULT NULL,
  `compPlayer` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT 0,
  `coords` longtext DEFAULT '{}',
  `status` varchar(140) DEFAULT '{}',
  `isdead` tinyint(1) DEFAULT 0,
  `skills` longtext DEFAULT NULL,
  `walk` varchar(50) DEFAULT 'noanim',
  `gunsmith` double(11,2) DEFAULT 0.00,
  `ammo` longtext DEFAULT '{}',
  `discordid` varchar(255) DEFAULT '0',
  `lastjoined` longtext DEFAULT '[]',
  `posseid` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`identifier`, `steamname`, `charidentifier`, `group`, `money`, `gold`, `rol`, `xp`, `healthouter`, `healthinner`, `staminaouter`, `staminainner`, `hours`, `LastLogin`, `inventory`, `slots`, `job`, `joblabel`, `meta`, `firstname`, `lastname`, `character_desc`, `gender`, `age`, `nickname`, `skinPlayer`, `compPlayer`, `compTints`, `jobgrade`, `coords`, `status`, `isdead`, `skills`, `walk`, `gunsmith`, `ammo`, `discordid`, `lastjoined`, `posseid`) VALUES
('steam:110000140823af3', 'Obsidian_CodeZ', 1, 'user', 991553.74, 1001188.00, 0.00, 10, 500, 100, 500, 100, 0, '2025-06-20', '{}', 35.0, 'police', 'police ', '{}', 'Thomas', 'Shelby', 'none', 'Male', 31, 'Thomas', '{\"eyeliner_opacity\":0,\"MouthCRW\":0.0,\"blush_palette_id\":0,\"JawH\":0.0,\"complex_tx_id\":0,\"ShouldersS\":0.0,\"paintedmasks_palette_color_tertiary\":0,\"EyeH\":0.0,\"eyeliner_visibility\":0,\"foundation_palette_color_primary\":0,\"EarsH\":0.0,\"lipsticks_palette_color_secondary\":0,\"disc_opacity\":0,\"EarsW\":0.0,\"paintedmasks_opacity\":0,\"ChinW\":0.0,\"albedo\":317354806,\"EyeLidL\":0.0,\"ageing_opacity\":0,\"NoseS\":0.0,\"NoseAng\":0.0,\"shadows_palette_color_primary\":0,\"eyebrows_tx_id\":24,\"EyeLidH\":0.0,\"grime_opacity\":0,\"complex_visibility\":0,\"FaceW\":0.0,\"NeckW\":0.0,\"MouthCRLD\":0.0,\"MouthY\":0.0,\"foundation_tx_id\":0,\"scars_tx_id\":0,\"ArmsS\":0.0,\"JawD\":0.0,\"paintedmasks_palette_color_primary\":0,\"MouthCLLD\":0.0,\"lipsticks_opacity\":0,\"blush_opacity\":0,\"EyeLidW\":0.0,\"FaceS\":0.0,\"EyeD\":0.0,\"Torso\":0,\"blush_palette_color_primary\":0,\"EarsD\":0.0,\"freckles_opacity\":0,\"FaceD\":0.0,\"ChinD\":0.0,\"grime_visibility\":0,\"beardstabble_opacity\":0,\"ChinH\":0.0,\"EyeBrowH\":0.0,\"lipsticks_tx_id\":0,\"CalvesS\":0.0,\"ShouldersM\":0.0,\"NoseDis\":0.0,\"disc_visibility\":0,\"freckles_visibility\":0,\"eyeliner_color_primary\":0,\"moles_visibility\":0,\"eyebrows_color\":17129595,\"WaistW\":0.0,\"LLiphD\":0.0,\"acne_opacity\":0,\"NoseW\":0.0,\"eyeliner_palette_id\":0,\"scars_opacity\":0,\"ULiphD\":0.0,\"spots_tx_id\":0,\"beardstabble_color_primary\":0,\"foundation_palette_color_tertiary\":0,\"lipsticks_palette_id\":0,\"LegsType\":174153218,\"ChestS\":0.0,\"EyeBrowD\":0.0,\"MouthX\":0.0,\"paintedmasks_tx_id\":0,\"NoseH\":0.0,\"ShouldersT\":0.0,\"acne_visibility\":0,\"eyebrows_opacity\":1.0,\"paintedmasks_palette_color_secondary\":0,\"Albedo\":0,\"LLiphW\":0.0,\"eyeliner_tx_id\":0,\"acne_tx_id\":0,\"JawW\":0.0,\"eyebrows_visibility\":1,\"HeadSize\":0.0,\"beardstabble_tx_id\":0,\"Eyes\":-2099894853,\"scars_visibility\":0,\"hair_color_primary\":0,\"MouthD\":0.0,\"HeadType\":-1598141829,\"paintedmasks_visibility\":0,\"foundation_opacity\":0,\"foundation_visibility\":0,\"lipsticks_palette_color_tertiary\":0,\"ageing_visibility\":0,\"hair_opacity\":0,\"MouthW\":0.0,\"EarsA\":0.0,\"shadows_palette_color_tertiary\":0,\"EyeAng\":0.0,\"paintedmasks_palette_id\":0,\"Waist\":-2045421226,\"disc_tx_id\":0,\"CheekBonesW\":0.0,\"CheekBonesD\":0.0,\"shadows_visibility\":0,\"hair_tx_id\":0,\"LegsS\":0.0,\"spots_opacity\":0,\"EyeDis\":0.0,\"Hair\":623103571,\"MouthCLH\":0.0,\"foundation_palette_color_secondary\":0,\"blush_tx_id\":0,\"EyeBrowW\":0.0,\"freckles_tx_id\":0,\"NoseC\":0.0,\"Body\":-1241887289,\"complex_opacity\":0,\"shadows_opacity\":0,\"grime_tx_id\":0,\"NeckD\":0.0,\"sex\":\"mp_male\",\"beardstabble_visibility\":0,\"MouthCRH\":0.0,\"HipsS\":0.0,\"ageing_tx_id\":1,\"LLiphH\":0.0,\"MouthCLD\":0.0,\"ULiphH\":0.0,\"CheekBonesH\":0.0,\"MouthCLW\":0.0,\"shadows_palette_id\":0,\"Beard\":-1,\"shadows_tx_id\":0,\"EyeLidR\":0.0,\"shadows_palette_color_secondary\":0,\"Scale\":1.0,\"moles_opacity\":0,\"foundation_palette_id\":0,\"ULiphW\":0.0,\"hair_visibility\":1,\"blush_visibility\":0,\"moles_tx_id\":0,\"MouthCRD\":0.0,\"lipsticks_visibility\":0,\"lipsticks_palette_color_primary\":0,\"spots_visibility\":0,\"BodyType\":-162963160}', '{\"NeckTies\":-1,\"GunbeltAccs\":-1,\"Poncho\":-1,\"Boots\":-218859683,\"Holster\":-1,\"Cloak\":-1,\"Gunbelt\":-1,\"Buckle\":-1,\"Spats\":-1,\"Teeth\":712446626,\"Vest\":610861257,\"Satchels\":-1,\"Gauntlets\":-1,\"Coat\":-1031985159,\"RingRh\":-1,\"Chap\":-1,\"Skirt\":-1,\"RingLh\":-1,\"Loadouts\":-1,\"Mask\":-1,\"Belt\":271524070,\"Accessories\":639284852,\"Suspender\":-1,\"Badge\":-1,\"EyeWear\":-1,\"CoatClosed\":-1,\"Spurs\":-1,\"Dress\":-1,\"Bracelet\":-1,\"Armor\":-1,\"Bow\":-1,\"Glove\":-124348917,\"Pant\":1364316748,\"Hat\":-511398545,\"Shirt\":309082937,\"NeckWear\":-1}', '{\"Poncho\":[],\"Boots\":{\"-218859683\":{\"index\":1,\"color\":0,\"palette\":-783849117,\"tint2\":30,\"tint0\":1,\"tint1\":1}},\"RingLh\":[],\"Cloak\":[],\"Gunbelt\":[],\"Belt\":{\"271524070\":{\"index\":4,\"color\":2,\"palette\":0,\"tint2\":0,\"tint0\":0,\"tint1\":0}},\"Accessories\":{\"639284852\":{\"index\":3,\"color\":2,\"palette\":1090645383,\"tint2\":77,\"tint0\":48,\"tint1\":45}},\"Suspender\":[],\"EyeWear\":[],\"Vest\":{\"610861257\":{\"index\":5,\"color\":0,\"palette\":1090645383,\"tint2\":21,\"tint0\":19,\"tint1\":21}},\"Shirt\":{\"309082937\":{\"index\":21,\"color\":3,\"palette\":1090645383,\"tint2\":15,\"tint0\":15,\"tint1\":15}},\"Coat\":{\"-1031985159\":{\"index\":9,\"color\":0,\"palette\":1090645383,\"tint2\":21,\"tint0\":21,\"tint1\":21}},\"Holster\":[],\"Pant\":{\"1364316748\":{\"index\":14,\"color\":0,\"palette\":1090645383,\"tint2\":21,\"tint0\":21,\"tint1\":21}},\"Hat\":{\"-511398545\":{\"index\":38,\"color\":0,\"palette\":-1436165981,\"tint2\":20,\"tint0\":20,\"tint1\":20}},\"Chap\":[],\"Glove\":{\"-124348917\":{\"index\":21,\"color\":0,\"palette\":1064202495,\"tint2\":0,\"tint0\":0,\"tint1\":0}}}', 0, '{\"y\":-1383.6263427734376,\"z\":46.3992919921875,\"heading\":328.81890869140627,\"x\":2786.624267578125}', '{\"Hunger\":997,\"Thirst\":997,\"Metabolism\":-8018}', 0, '{\"Fishing\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Crafting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Mining\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Hunting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0}}', 'noanim', 0.00, '{\"AMMO_PISTOL\":51,\"AMMO_SHOTGUN\":8,\"AMMO_RIFLE\":59}', '1345772493297815603', '[]', 0),
('steam:110000140823af3', 'Obsidian_CodeZ', 4, 'user', 200.00, 0.00, 0.00, 0, 500, 100, 500, 100, 0, '2025-06-18', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'test', 'test', 'none', 'Male', 30, 'none', '{\"complex_opacity\":0,\"blush_palette_id\":0,\"MouthX\":0.0,\"beardstabble_opacity\":0,\"foundation_palette_color_secondary\":0,\"acne_visibility\":0,\"disc_opacity\":0,\"scars_visibility\":0,\"FaceW\":0.0,\"paintedmasks_opacity\":0,\"freckles_opacity\":0,\"LegsType\":174153218,\"Albedo\":0,\"WaistW\":0.0,\"MouthCRLD\":0.0,\"paintedmasks_palette_id\":0,\"foundation_palette_id\":0,\"ShouldersS\":0.0,\"eyeliner_opacity\":0,\"scars_tx_id\":0,\"EyeBrowW\":0.0,\"NoseDis\":0.0,\"Eyes\":612262189,\"lipsticks_palette_id\":0,\"EyeLidL\":0.0,\"BodyType\":-162963160,\"paintedmasks_palette_color_tertiary\":0,\"Body\":61606861,\"NeckD\":0.0,\"moles_tx_id\":0,\"spots_visibility\":0,\"ShouldersT\":0.0,\"sex\":\"mp_male\",\"shadows_tx_id\":0,\"eyeliner_tx_id\":0,\"NoseC\":0.0,\"EyeAng\":0.0,\"eyebrows_color\":1064202495,\"shadows_visibility\":0,\"shadows_palette_color_tertiary\":0,\"Hair\":2112480140,\"HeadSize\":0.0,\"beardstabble_visibility\":0,\"CalvesS\":0.0,\"CheekBonesD\":0.0,\"NoseS\":0.0,\"eyebrows_tx_id\":1,\"JawD\":0.0,\"shadows_palette_color_secondary\":0,\"albedo\":317354806,\"foundation_tx_id\":0,\"eyeliner_color_primary\":0,\"ULiphH\":0.0,\"eyebrows_visibility\":1,\"shadows_opacity\":0,\"HeadType\":-2064391035,\"lipsticks_visibility\":0,\"hair_opacity\":0,\"lipsticks_palette_color_tertiary\":0,\"foundation_palette_color_tertiary\":0,\"paintedmasks_tx_id\":0,\"foundation_visibility\":0,\"EyeBrowD\":0.0,\"EarsH\":0.0,\"freckles_visibility\":0,\"hair_color_primary\":0,\"ageing_visibility\":0,\"blush_visibility\":0,\"LegsS\":0.0,\"EyeDis\":0.0,\"paintedmasks_visibility\":0,\"JawW\":0.0,\"FaceS\":0.0,\"ChinH\":0.0,\"Beard\":0,\"ChinW\":0.0,\"ChestS\":0.0,\"disc_tx_id\":0,\"blush_palette_color_primary\":0,\"beardstabble_tx_id\":0,\"ULiphW\":0.0,\"beardstabble_color_primary\":0,\"EyeLidH\":0.0,\"EyeBrowH\":0.0,\"EarsA\":0.0,\"Waist\":0,\"paintedmasks_palette_color_primary\":0,\"blush_opacity\":0,\"moles_visibility\":0,\"grime_visibility\":0,\"MouthCRH\":0.0,\"hair_tx_id\":0,\"acne_opacity\":0,\"MouthCLD\":0.0,\"MouthY\":0.0,\"CheekBonesH\":0.0,\"lipsticks_palette_color_secondary\":0,\"scars_opacity\":0,\"MouthCLLD\":0.0,\"EarsW\":0.0,\"LLiphW\":0.0,\"disc_visibility\":0,\"EyeH\":0.0,\"ArmsS\":0.0,\"ChinD\":0.0,\"Torso\":0,\"ageing_tx_id\":0,\"moles_opacity\":0,\"EyeLidW\":0.0,\"EyeLidR\":0.0,\"eyeliner_palette_id\":0,\"MouthCLW\":0.0,\"CheekBonesW\":0.0,\"ULiphD\":0.0,\"grime_tx_id\":0,\"NeckW\":0.0,\"acne_tx_id\":0,\"paintedmasks_palette_color_secondary\":0,\"JawH\":0.0,\"MouthD\":0.0,\"LLiphD\":0.0,\"HipsS\":0.0,\"NoseW\":0.0,\"FaceD\":0.0,\"NoseAng\":0.0,\"lipsticks_opacity\":0,\"shadows_palette_id\":0,\"lipsticks_palette_color_primary\":0,\"MouthW\":0.0,\"MouthCRD\":0.0,\"blush_tx_id\":0,\"NoseH\":0.0,\"spots_tx_id\":0,\"ShouldersM\":0.0,\"EyeD\":0.0,\"spots_opacity\":0,\"lipsticks_tx_id\":0,\"foundation_opacity\":0,\"MouthCLH\":0.0,\"grime_opacity\":0,\"freckles_tx_id\":0,\"hair_visibility\":0,\"LLiphH\":0.0,\"shadows_palette_color_primary\":0,\"Scale\":0.0,\"complex_visibility\":0,\"complex_tx_id\":0,\"foundation_palette_color_primary\":0,\"eyebrows_opacity\":1.0,\"ageing_opacity\":0,\"EarsD\":0.0,\"MouthCRW\":0.0,\"eyeliner_visibility\":0}', '{\"Bracelet\":-1,\"Teeth\":712446626,\"Hat\":-1,\"Spurs\":-1,\"Mask\":-1,\"NeckWear\":-1,\"Boots\":-218859683,\"NeckTies\":-1,\"Bow\":-1,\"CoatClosed\":-1,\"Gunbelt\":795591403,\"RingLh\":-1,\"Belt\":-1,\"GunbeltAccs\":-1,\"Loadouts\":-1,\"Accessories\":-1,\"Pant\":1939930032,\"EyeWear\":-1,\"Buckle\":-1,\"Spats\":-1,\"Glove\":-1,\"Gauntlets\":-1,\"Satchels\":-1,\"RingRh\":-1,\"Cloak\":-1,\"Suspender\":-1,\"Coat\":-1,\"Vest\":-1,\"Shirt\":-1665588256,\"Chap\":-1,\"Armor\":-1,\"Holster\":-1,\"Poncho\":-1,\"Skirt\":-1,\"Badge\":-1,\"Dress\":-1}', '{\"Boots\":{\"-218859683\":{\"tint1\":0,\"tint2\":0,\"tint0\":0,\"palette\":0}},\"Pant\":{\"1939930032\":{\"tint1\":0,\"tint2\":0,\"tint0\":0,\"palette\":0}},\"Shirt\":{\"-1665588256\":{\"tint1\":0,\"tint2\":0,\"tint0\":0,\"palette\":0}},\"Gunbelt\":{\"795591403\":{\"tint1\":0,\"tint2\":0,\"tint0\":0,\"palette\":0}}}', 0, '{\"heading\":141.73228454589845,\"z\":74.9091796875,\"y\":-1319.037353515625,\"x\":1211.7098388671876}', '{\"Thirst\":1000,\"Hunger\":1000,\"Metabolism\":-10}', 0, '{\"Hunting\":{\"Exp\":0,\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1},\"Crafting\":{\"Exp\":0,\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1},\"Mining\":{\"Exp\":0,\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1},\"Fishing\":{\"Exp\":0,\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1}}', 'noanim', 0.00, '{}', '1345772493297815603', '[]', 0),
('steam:1100001486701fd', 'Big Mama', 3, 'user', 151.18, 0.00, 0.00, 266, 500, 100, 500, 100, 0, '2025-06-16', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'Big', 'MAMA', 'MAMA IS A VODOU PRIEST AND A WITCH DOC', 'Female', 32, 'MAMA B', '{\"ShouldersT\":0.0,\"foundation_palette_id\":0,\"FaceW\":0.0,\"Waist\":-2045421226,\"scars_tx_id\":0,\"NoseW\":0.9,\"NoseDis\":0.0,\"Eyes\":-521272346,\"ArmsS\":0.0,\"EyeLidL\":0.0,\"paintedmasks_tx_id\":0,\"LegsType\":666304706,\"shadows_visibility\":0,\"HipsS\":0.9,\"JawD\":0.0,\"NoseH\":0.0,\"ageing_visibility\":1,\"moles_tx_id\":0,\"paintedmasks_visibility\":0,\"disc_visibility\":0,\"disc_opacity\":0,\"MouthCLH\":0.0,\"eyeliner_color_primary\":0,\"grime_tx_id\":0,\"hair_tx_id\":0,\"FaceD\":0.0,\"lipsticks_palette_color_secondary\":0,\"NoseC\":0,\"foundation_palette_color_tertiary\":0,\"foundation_visibility\":0,\"NoseAng\":0.0,\"EyeBrowW\":0.0,\"EarsH\":0.0,\"eyeliner_visibility\":0,\"EyeD\":0.0,\"grime_opacity\":0,\"foundation_palette_color_secondary\":0,\"NoseS\":0.0,\"MouthW\":0.6,\"MouthCRW\":0.0,\"eyebrows_tx_id\":15,\"lipsticks_tx_id\":0,\"shadows_opacity\":0,\"foundation_tx_id\":0,\"MouthCRLD\":0.0,\"NeckW\":0.0,\"CalvesS\":0.2,\"spots_opacity\":0,\"blush_opacity\":0,\"hair_visibility\":0,\"foundation_opacity\":0,\"acne_visibility\":0,\"MouthCRD\":0.0,\"BodyType\":-494121669,\"EarsD\":0.0,\"JawH\":0.0,\"shadows_palette_color_secondary\":0,\"LLiphW\":0.2,\"beardstabble_tx_id\":0,\"LegsS\":0.5,\"EyeLidH\":-0.9,\"eyeliner_tx_id\":0,\"ageing_tx_id\":2,\"ULiphW\":0.3,\"foundation_palette_color_primary\":0,\"Torso\":-494121669,\"ageing_opacity\":0.1,\"disc_tx_id\":0,\"scars_opacity\":0,\"MouthY\":0.4,\"MouthCLW\":0.0,\"albedo\":286541378,\"EyeBrowD\":0.0,\"WaistW\":0.5,\"acne_opacity\":0,\"ChinW\":0.0,\"EyeBrowH\":0.0,\"moles_visibility\":0,\"EyeDis\":0.0,\"EarsA\":0.0,\"blush_visibility\":0,\"eyebrows_color\":1064202495,\"blush_palette_id\":0,\"EyeLidR\":0,\"eyeliner_palette_id\":0,\"blush_palette_color_primary\":0,\"sex\":\"mp_female\",\"LLiphD\":0.0,\"paintedmasks_palette_color_primary\":0,\"Body\":32611963,\"lipsticks_palette_color_tertiary\":0,\"scars_visibility\":0,\"ShouldersM\":0.0,\"EyeLidW\":0.0,\"MouthCRH\":0.0,\"FaceS\":0.0,\"freckles_tx_id\":3,\"beardstabble_color_primary\":0,\"freckles_visibility\":1,\"complex_tx_id\":0,\"Albedo\":0,\"ChinD\":0.0,\"grime_visibility\":0,\"CheekBonesW\":0.1,\"paintedmasks_palette_color_tertiary\":0,\"shadows_palette_id\":0,\"lipsticks_opacity\":0,\"EarsW\":0.0,\"CheekBonesD\":0.4,\"lipsticks_visibility\":0,\"NeckD\":0.0,\"ShouldersS\":0.0,\"hair_opacity\":0,\"eyebrows_opacity\":0.8,\"hair_color_primary\":0,\"lipsticks_palette_color_primary\":0,\"spots_visibility\":0,\"ULiphH\":0.0,\"blush_tx_id\":0,\"eyeliner_opacity\":0,\"paintedmasks_opacity\":0,\"shadows_palette_color_tertiary\":0,\"paintedmasks_palette_color_secondary\":0,\"MouthCLD\":0.0,\"paintedmasks_palette_id\":0,\"ULiphD\":0.0,\"Hair\":2025151129,\"shadows_tx_id\":0,\"complex_visibility\":0,\"eyebrows_visibility\":1,\"CheekBonesH\":0.0,\"Beard\":0,\"Scale\":1.0,\"spots_tx_id\":0,\"ChinH\":0.0,\"EyeH\":0.0,\"MouthX\":0.0,\"MouthD\":0.0,\"HeadType\":-1812558457,\"acne_tx_id\":0,\"HeadSize\":0.0,\"EyeAng\":0.0,\"beardstabble_opacity\":0,\"LLiphH\":0.0,\"lipsticks_palette_id\":0,\"ChestS\":0.9,\"Legs\":666304706,\"beardstabble_visibility\":0,\"complex_opacity\":0,\"JawW\":0.2,\"freckles_opacity\":0.7,\"moles_opacity\":0,\"MouthCLLD\":0.0,\"shadows_palette_color_primary\":0}', '{\"Accessories\":-1,\"Mask\":-1,\"Dress\":-1,\"Holster\":1564617196,\"Boots\":-846134590,\"Spurs\":-1,\"Bracelet\":-1,\"Armor\":-1,\"Gunbelt\":1294370506,\"Vest\":558244996,\"Teeth\":959712255,\"Glove\":-1,\"Belt\":-1,\"Buckle\":-1,\"Skirt\":-1073096442,\"RingRh\":-1,\"Spats\":-1,\"Cloak\":-1,\"Suspender\":-1,\"RingLh\":-1,\"Poncho\":-1,\"Badge\":-1,\"Shirt\":-1,\"Satchels\":-1,\"Chap\":-1,\"NeckWear\":646005665,\"Coat\":-1,\"Loadouts\":-1,\"Gauntlets\":-1,\"CoatClosed\":-1,\"EyeWear\":468303075,\"Pant\":-1,\"GunbeltAccs\":-1,\"NeckTies\":-1,\"Hat\":1774471600,\"Bow\":-1}', '{\"EyeWear\":{\"468303075\":{\"tint1\":20,\"tint0\":45,\"palette\":1090645383,\"tint2\":14,\"color\":2,\"index\":8}},\"Gunbelt\":{\"1294370506\":{\"tint1\":114,\"tint0\":1,\"palette\":-783849117,\"tint2\":59,\"color\":0,\"index\":14}},\"Vest\":{\"558244996\":{\"tint1\":56,\"tint0\":50,\"palette\":1064202495,\"tint2\":53,\"color\":2}},\"Pant\":[],\"Holster\":{\"1564617196\":{\"tint1\":107,\"tint0\":18,\"palette\":-1952348042,\"tint2\":65,\"color\":0,\"index\":5}},\"Boots\":{\"-846134590\":{\"tint1\":21,\"tint0\":21,\"palette\":1669565057,\"tint2\":55,\"color\":0,\"index\":2}},\"Satchels\":[],\"NeckWear\":{\"646005665\":{\"tint1\":17,\"tint0\":92,\"palette\":-113397560,\"tint2\":40,\"color\":4,\"index\":9}},\"Bracelet\":[],\"Shirt\":[],\"Hat\":{\"1774471600\":{\"tint1\":44,\"tint0\":77,\"palette\":-783849117,\"tint2\":1,\"color\":3,\"index\":32}},\"Skirt\":{\"-1073096442\":{\"tint1\":52,\"tint0\":0,\"palette\":1064202495,\"tint2\":20,\"color\":2,\"index\":5}}}', 0, '{\"heading\":90.70865631103516,\"z\":76.830078125,\"y\":-1313.841796875,\"x\":1328.1494140625}', '{\"Metabolism\":-280,\"Thirst\":998,\"Hunger\":998}', 0, '{\"Mining\":{\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1,\"Label\":\"Beginner\",\"Exp\":0},\"Crafting\":{\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1,\"Label\":\"Beginner\",\"Exp\":0},\"Fishing\":{\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1,\"Label\":\"Beginner\",\"Exp\":0},\"Hunting\":{\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1,\"Label\":\"Beginner\",\"Exp\":0}}', 'noanim', 0.00, '{\"AMMO_RIFLE\":83}', '801762433718157322', '[]', 0),
('steam:1100001486701fd', 'Big Mama', 7, 'user', 480.27, 971.00, 0.00, 9, 500, 100, 500, 100, 0, '2025-06-20', '{}', 100.0, 'headdoctor', '', '{}', 'Mama', 'Binta', 'Witch doctor walking with spirits, feared and respected by all.', 'Female', 32, 'Mama B', '{\"CheekBonesH\":0.1,\"eyeliner_visibility\":0,\"ChinH\":0.5,\"eyebrows_opacity\":1.0,\"Scale\":1.0,\"JawD\":0.6,\"MouthCRLD\":0.0,\"acne_tx_id\":0,\"MouthCLD\":0.0,\"ChestS\":1.0,\"EarsW\":0.0,\"ageing_visibility\":1,\"hair_visibility\":1,\"lipsticks_tx_id\":0,\"FaceW\":0.2,\"NoseAng\":0.0,\"sex\":\"mp_female\",\"Albedo\":0,\"FaceD\":0,\"EarsD\":0.0,\"freckles_visibility\":1,\"NoseDis\":-0.7,\"ageing_tx_id\":17,\"HipsS\":1.0,\"LLiphW\":0.1,\"ULiphD\":0.1,\"Hair\":3417894291,\"spots_visibility\":0,\"shadows_palette_color_secondary\":0,\"Waist\":-2045421226,\"CheekBonesW\":0.5,\"shadows_palette_color_primary\":0,\"eyeliner_opacity\":0,\"LegsS\":1.0,\"eyeliner_palette_id\":0,\"MouthCLH\":0.0,\"hair_opacity\":0.3,\"disc_visibility\":0,\"lipsticks_visibility\":0,\"MouthD\":0.1,\"acne_visibility\":0,\"EyeLidW\":-0.1,\"CheekBonesD\":0.2,\"Torso\":-494121669,\"paintedmasks_palette_color_secondary\":0,\"EyeLidR\":0.1,\"EarsH\":0.0,\"MouthCRH\":0.0,\"Eyes\":-844112534,\"eyeliner_color_primary\":0,\"shadows_tx_id\":0,\"paintedmasks_tx_id\":0,\"grime_opacity\":0,\"beardstabble_opacity\":0,\"paintedmasks_palette_id\":0,\"grime_visibility\":0,\"NoseW\":0.8,\"blush_palette_color_primary\":0,\"scars_tx_id\":0,\"lipsticks_palette_color_secondary\":0,\"MouthW\":0.5,\"foundation_visibility\":0,\"disc_opacity\":0,\"MouthY\":0.0,\"EyeLidL\":0.1,\"MouthCLW\":0.0,\"LegsType\":666304706,\"MouthX\":0.1,\"NoseS\":0.1,\"NeckD\":-0.1,\"grime_tx_id\":0,\"ShouldersT\":0.0,\"foundation_palette_color_tertiary\":0,\"MouthCRD\":0.0,\"paintedmasks_visibility\":0,\"EyeBrowD\":0.0,\"Beard\":0,\"blush_tx_id\":0,\"EyeDis\":0.2,\"acne_opacity\":0,\"moles_opacity\":0.3,\"eyebrows_color\":936195796,\"spots_tx_id\":0,\"HeadType\":-1812558457,\"ShouldersS\":0.0,\"EyeD\":0.0,\"MouthCRW\":0.0,\"hair_color_primary\":0,\"MouthCLLD\":0.0,\"eyebrows_tx_id\":15,\"complex_visibility\":0,\"eyeliner_tx_id\":0,\"scars_opacity\":0,\"beardstabble_color_primary\":0,\"shadows_palette_id\":0,\"beardstabble_tx_id\":0,\"blush_opacity\":0,\"JawH\":0.8,\"EyeLidH\":-0.5,\"NoseC\":0.1,\"blush_visibility\":0,\"ULiphW\":1.0,\"NeckW\":-0.1,\"EarsA\":0.0,\"paintedmasks_opacity\":0,\"blush_palette_id\":0,\"HeadSize\":0.2,\"ChinD\":0.2,\"scars_visibility\":0,\"EyeBrowH\":-0.1,\"foundation_palette_color_secondary\":0,\"EyeBrowW\":0.1,\"ShouldersM\":0.0,\"lipsticks_palette_id\":0,\"foundation_opacity\":0,\"complex_tx_id\":0,\"NoseH\":0.7,\"BodyType\":-494121669,\"EyeH\":-0.5,\"moles_tx_id\":2,\"lipsticks_palette_color_primary\":0,\"ChinW\":0.2,\"foundation_tx_id\":0,\"EyeAng\":-0.1,\"freckles_opacity\":0.5,\"disc_tx_id\":0,\"lipsticks_opacity\":0,\"albedo\":286541378,\"complex_opacity\":0,\"ULiphH\":0.1,\"paintedmasks_palette_color_primary\":0,\"JawW\":0.1,\"shadows_palette_color_tertiary\":0,\"paintedmasks_palette_color_tertiary\":0,\"ageing_opacity\":0.2,\"CalvesS\":0.5,\"lipsticks_palette_color_tertiary\":0,\"freckles_tx_id\":3,\"foundation_palette_id\":0,\"LLiphD\":0.1,\"foundation_palette_color_primary\":0,\"ArmsS\":0.3,\"spots_opacity\":0,\"beardstabble_visibility\":0,\"LLiphH\":0.1,\"shadows_opacity\":0,\"shadows_visibility\":0,\"hair_tx_id\":4,\"WaistW\":-1.0,\"eyebrows_visibility\":1,\"Body\":-369348190,\"FaceS\":0.1,\"moles_visibility\":1}', '{\"Accessories\":869490822,\"Chap\":-1,\"Badge\":-1,\"CoatClosed\":-1,\"Dress\":-1,\"Armor\":-1,\"Poncho\":-1,\"RingRh\":-1,\"Bracelet\":-1,\"Cloak\":-1,\"Loadouts\":-1,\"Gauntlets\":834504924,\"Mask\":-1,\"Pant\":-1,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Holster\":-83784299,\"EyeWear\":833646746,\"Buckle\":-1,\"Boots\":1178628992,\"Bow\":-1,\"Vest\":558244996,\"RingLh\":-1,\"Spats\":-1,\"Suspender\":-1,\"Coat\":-1,\"Teeth\":-1,\"Skirt\":-753739014,\"Spurs\":-1,\"Gunbelt\":237932673,\"Hat\":-1152095488,\"Glove\":298487871,\"NeckWear\":1237454505,\"Shirt\":-1,\"NeckTies\":-1,\"Belt\":-1}', '{\"Accessories\":{\"869490822\":{\"palette\":-183908539,\"tint1\":90,\"color\":2,\"index\":1,\"tint0\":15,\"tint2\":210}},\"Hat\":{\"-1152095488\":{\"palette\":-1543234321,\"tint1\":0,\"color\":1,\"index\":102,\"tint0\":0,\"tint2\":0}},\"Holster\":{\"-83784299\":{\"palette\":-783849117,\"tint1\":1,\"color\":1,\"index\":15,\"tint0\":1,\"tint2\":1}},\"NeckWear\":{\"1237454505\":{\"palette\":1064202495,\"tint1\":0,\"color\":1,\"index\":15,\"tint0\":0,\"tint2\":0}},\"Skirt\":{\"-753739014\":{\"palette\":17129595,\"tint1\":248,\"color\":4,\"index\":6,\"tint0\":250,\"tint2\":1}},\"Gunbelt\":{\"237932673\":{\"palette\":-783849117,\"tint1\":15,\"color\":1,\"index\":16,\"tint0\":15,\"tint2\":58}},\"Boots\":{\"1178628992\":{\"palette\":1669565057,\"tint1\":54,\"color\":0,\"index\":4,\"tint0\":21,\"tint2\":52}},\"Gauntlets\":{\"834504924\":{\"palette\":1064202495,\"tint1\":68,\"color\":1,\"index\":3,\"tint0\":27,\"tint2\":93}},\"Glove\":{\"298487871\":{\"palette\":-113397560,\"tint1\":39,\"color\":4,\"index\":20,\"tint0\":252,\"tint2\":38}},\"EyeWear\":{\"833646746\":{\"palette\":1090645383,\"tint1\":59,\"color\":4,\"index\":9,\"tint0\":61,\"tint2\":48}},\"Vest\":{\"558244996\":{\"palette\":1064202495,\"tint1\":56,\"color\":2,\"index\":30,\"tint0\":50,\"tint2\":53}}}', 0, '{\"x\":-346.0747375488281,\"heading\":172.91339111328126,\"z\":115.955322265625,\"y\":788.4263916015625}', '{\"Hunger\":1000,\"Metabolism\":82,\"Thirst\":1000}', 0, '{\"Fishing\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1},\"Crafting\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1},\"Mining\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1},\"Hunting\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1}}', 'MP_Style_Flamboyant', 0.00, '{\"AMMO_REVOLVER\":99,\"AMMO_REVOLVER_SPLIT_POINT\":50,\"AMMO_RIFLE\":100,\"AMMO_SHOTGUN_SLUG\":60}', '801762433718157322', '[]', 0),
('steam:1100001562b75f9', 'Stivo', 8, 'user', 688.73, 0.00, 0.00, 3, 500, 100, 500, 100, 0, '2025-06-20', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'BIG', 'DD', 'MOB LEADER', 'Male', 25, 'Bishop', '{\"CheekBonesH\":0.0,\"MouthCLLD\":0.0,\"ChinH\":0.0,\"eyebrows_opacity\":1.0,\"Scale\":1.05,\"JawD\":0,\"MouthCRLD\":0.0,\"acne_tx_id\":0,\"MouthCLD\":0.0,\"ChestS\":1.0,\"EarsW\":0.0,\"ageing_visibility\":0,\"hair_visibility\":1,\"lipsticks_tx_id\":0,\"FaceW\":0.0,\"NoseAng\":0.0,\"sex\":\"mp_male\",\"Albedo\":0,\"Legs\":-457866027,\"FaceD\":0.0,\"shadows_opacity\":0,\"freckles_visibility\":0,\"NoseDis\":0.0,\"blush_opacity\":0,\"HipsS\":-0.8,\"LLiphW\":0.3,\"ULiphD\":0.5,\"hair_color_primary\":0,\"spots_visibility\":0,\"shadows_palette_color_secondary\":0,\"Waist\":-2045421226,\"CheekBonesW\":0.0,\"shadows_palette_color_primary\":0,\"eyeliner_opacity\":0,\"LegsS\":1.0,\"HeadType\":-1990191017,\"MouthCLH\":0.0,\"hair_opacity\":1.0,\"beardstabble_visibility\":0,\"lipsticks_visibility\":0,\"NoseC\":0.0,\"acne_visibility\":0,\"EyeLidW\":0.0,\"shadows_visibility\":0,\"Torso\":1272509601,\"paintedmasks_palette_color_secondary\":0,\"EyeLidR\":0.0,\"EarsH\":0.0,\"MouthCRH\":0.0,\"Eyes\":-2099894853,\"eyeliner_color_primary\":0,\"shadows_tx_id\":0,\"paintedmasks_tx_id\":0,\"grime_opacity\":0,\"beardstabble_opacity\":0,\"complex_tx_id\":0,\"grime_visibility\":0,\"NoseW\":0.0,\"blush_palette_color_primary\":0,\"scars_tx_id\":0,\"lipsticks_palette_color_secondary\":1090645383,\"MouthW\":0.0,\"foundation_visibility\":0,\"disc_opacity\":0.4,\"MouthY\":0.0,\"EyeLidL\":0.0,\"moles_visibility\":0,\"LegsType\":-169859286,\"MouthX\":0.0,\"NoseS\":0.0,\"NeckD\":0.0,\"grime_tx_id\":0,\"ShouldersT\":0.8,\"foundation_palette_color_tertiary\":0,\"MouthCRD\":0.0,\"paintedmasks_visibility\":0,\"EyeBrowD\":0.0,\"Beard\":-1,\"blush_tx_id\":0,\"beardstabble_color_primary\":0,\"acne_opacity\":0,\"moles_opacity\":0,\"LLiphD\":0.0,\"FaceS\":0.0,\"Hair\":3945400824,\"EyeD\":0.0,\"ShouldersM\":0.5,\"MouthCRW\":0.0,\"lipsticks_palette_id\":0,\"MouthCLW\":0.0,\"eyebrows_tx_id\":11,\"eyebrows_color\":0,\"CalvesS\":1.0,\"scars_opacity\":0,\"paintedmasks_palette_id\":0,\"ChinD\":0.0,\"NeckW\":0.0,\"ageing_tx_id\":0,\"JawH\":0.0,\"EyeLidH\":0.0,\"freckles_tx_id\":0,\"freckles_opacity\":0,\"foundation_opacity\":0,\"shadows_palette_color_tertiary\":0,\"paintedmasks_palette_color_primary\":0,\"paintedmasks_opacity\":0,\"blush_palette_id\":0,\"HeadSize\":0.0,\"albedo\":-629195971,\"scars_visibility\":0,\"EyeBrowH\":0.0,\"foundation_palette_color_secondary\":0,\"blush_visibility\":0,\"EarsD\":0.0,\"ageing_opacity\":0.1,\"EyeAng\":0.0,\"EyeDis\":0.0,\"NoseH\":0.0,\"BodyType\":96561259,\"EarsA\":0.0,\"moles_tx_id\":0,\"lipsticks_palette_color_primary\":1090645383,\"ChinW\":0.0,\"foundation_tx_id\":0,\"complex_visibility\":0,\"spots_tx_id\":0,\"disc_tx_id\":6,\"lipsticks_opacity\":0,\"eyebrows_visibility\":1,\"EyeH\":0.0,\"complex_opacity\":0,\"ULiphH\":0.0,\"JawW\":-0.1,\"ArmsS\":1.0,\"paintedmasks_palette_color_tertiary\":0,\"MouthD\":0.0,\"CheekBonesD\":0.0,\"lipsticks_palette_color_tertiary\":0,\"ULiphW\":0.0,\"EyeBrowW\":0.0,\"disc_visibility\":1,\"beardstabble_tx_id\":0,\"eyeliner_tx_id\":0,\"spots_opacity\":0,\"ShouldersS\":0.9,\"LLiphH\":0.0,\"foundation_palette_color_primary\":0,\"foundation_palette_id\":0,\"hair_tx_id\":0,\"WaistW\":1.0,\"eyeliner_palette_id\":0,\"Body\":-369348190,\"shadows_palette_id\":0,\"eyeliner_visibility\":0}', '{\"Gauntlets\":-1,\"CoatClosed\":-1,\"Skirt\":-1,\"Badge\":-1,\"RingLh\":-1,\"Mask\":673079453,\"NeckWear\":-1,\"Dress\":-1,\"Belt\":320684923,\"Glove\":1400381664,\"Hat\":-1,\"Teeth\":712446626,\"Poncho\":-1,\"Holster\":-1,\"EyeWear\":-1,\"Armor\":-1,\"Shirt\":1423458324,\"Boots\":354331505,\"Bow\":-1,\"Loadouts\":-1,\"Suspender\":-1,\"Bracelet\":-1,\"Buckle\":-1,\"Coat\":-993261202,\"Chap\":-1,\"Accessories\":395446814,\"GunbeltAccs\":-1,\"Spats\":-1722855755,\"Spurs\":-1,\"RingRh\":-831098605,\"Pant\":-700430559,\"Gunbelt\":181282117,\"Cloak\":1138484027,\"Satchels\":-1,\"NeckTies\":-1,\"Vest\":-1}', '{\"Poncho\":[],\"Gauntlets\":[],\"Gunbelt\":{\"181282117\":{\"color\":3,\"tint1\":44,\"tint0\":78,\"index\":16,\"palette\":864404955,\"tint2\":80}},\"CoatClosed\":[],\"Shirt\":{\"1423458324\":{\"color\":1,\"tint1\":21,\"tint0\":21,\"index\":21,\"palette\":1090645383,\"tint2\":21}},\"Boots\":{\"354331505\":{\"color\":2,\"tint1\":8,\"tint0\":19,\"index\":5,\"palette\":-1952348042,\"tint2\":113}},\"RingLh\":[],\"Mask\":{\"673079453\":{\"color\":0,\"tint1\":0,\"tint0\":0,\"index\":1,\"palette\":1090645383,\"tint2\":0}},\"Accessories\":{\"395446814\":{\"color\":1,\"tint1\":0,\"tint0\":0,\"index\":2,\"palette\":-1436165981,\"tint2\":0}},\"Chap\":[],\"Coat\":{\"-993261202\":{\"color\":0,\"tint1\":0,\"tint0\":0,\"index\":46,\"palette\":1090645383,\"tint2\":0}},\"Glove\":{\"1400381664\":{\"color\":0,\"tint1\":25,\"tint0\":15,\"index\":27,\"palette\":-783849117,\"tint2\":28}},\"Spurs\":[],\"RingRh\":{\"-831098605\":{\"color\":0,\"tint1\":45,\"tint0\":16,\"index\":2,\"palette\":1090645383,\"tint2\":19}},\"Pant\":{\"-700430559\":{\"color\":1,\"tint1\":21,\"tint0\":21,\"index\":6,\"palette\":-1251868068,\"tint2\":41}},\"Belt\":{\"320684923\":{\"color\":1,\"tint1\":0,\"tint0\":0,\"index\":9,\"palette\":0,\"tint2\":0}},\"Cloak\":{\"1138484027\":{\"color\":3,\"tint1\":123,\"tint0\":1,\"index\":3,\"palette\":-183908539,\"tint2\":125}},\"Hat\":[],\"EyeWear\":[],\"Spats\":{\"-1722855755\":{\"color\":0,\"tint1\":12,\"tint0\":2,\"index\":3,\"palette\":-783849117,\"tint2\":105}}}', 0, '{\"y\":782.927490234375,\"z\":116.781005859375,\"heading\":317.4803161621094,\"x\":-324.27691650390627}', '{\"Hunger\":998,\"Metabolism\":-222,\"Thirst\":999}', 0, '{\"Fishing\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Crafting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Mining\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Hunting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0}}', 'MP_Style_EasyRider', 0.00, '{\"AMMO_REPEATER\":100,\"AMMO_SHOTGUN_SLUG\":60,\"AMMO_RIFLE\":47,\"AMMO_SHOTGUN\":5,\"AMMO_RIFLE_EXPRESS\":100,\"AMMO_RIFLE_SPLIT_POINT\":50}', '1149333265522626601', '[]', 1),
('steam:110000162cead19', 'W 💙', 9, 'user', 200.00, 3000.00, 0.00, 0, 500, 100, 500, 100, 0, '2025-06-20', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'W', 'PRO', 'W PRO\n', 'Male', 27, 'W PRO', '{\"foundation_palette_id\":0,\"NoseH\":0.0,\"foundation_palette_color_tertiary\":0,\"moles_visibility\":0,\"MouthX\":0.0,\"MouthD\":0.0,\"ULiphD\":0.0,\"Scale\":1.05,\"eyebrows_visibility\":1,\"lipsticks_tx_id\":0,\"foundation_palette_color_primary\":0,\"LLiphW\":0.0,\"shadows_palette_color_primary\":0,\"eyeliner_color_primary\":0,\"shadows_palette_color_tertiary\":0,\"NeckW\":0.0,\"ULiphW\":0.0,\"Beard\":382614413,\"EarsA\":0.0,\"hair_visibility\":0,\"Legs\":174153218,\"MouthCRW\":0.0,\"JawH\":0.0,\"grime_opacity\":0,\"CheekBonesD\":0.0,\"shadows_palette_id\":0,\"paintedmasks_palette_color_tertiary\":0,\"grime_visibility\":0,\"acne_visibility\":0,\"spots_tx_id\":2,\"complex_tx_id\":0,\"Albedo\":0,\"eyeliner_opacity\":0,\"LLiphH\":0.0,\"shadows_visibility\":0,\"acne_tx_id\":0,\"EyeBrowH\":0.0,\"NoseDis\":0.4,\"scars_tx_id\":1,\"EyeD\":0.0,\"paintedmasks_palette_color_secondary\":0,\"blush_palette_color_primary\":0,\"EarsD\":0.0,\"FaceW\":0.0,\"CalvesS\":0.0,\"Waist\":-844699484,\"foundation_visibility\":0,\"MouthCRLD\":0.0,\"JawW\":0.0,\"EyeDis\":0.0,\"ChinD\":0.0,\"albedo\":1557597939,\"MouthCLH\":0.0,\"shadows_tx_id\":0,\"Eyes\":-1793635779,\"paintedmasks_tx_id\":0,\"hair_tx_id\":0,\"disc_visibility\":1,\"HeadSize\":0.0,\"lipsticks_palette_id\":0,\"ShouldersM\":0.0,\"NoseAng\":0.2,\"moles_opacity\":0,\"LegsType\":-744001397,\"FaceS\":0.0,\"blush_visibility\":0,\"eyebrows_tx_id\":1,\"lipsticks_visibility\":0,\"freckles_tx_id\":0,\"complex_visibility\":0,\"eyeliner_palette_id\":0,\"MouthCLLD\":0.0,\"ChestS\":1.0,\"CheekBonesW\":0.0,\"HipsS\":0.0,\"EarsH\":0.0,\"spots_visibility\":0,\"NoseC\":0.4,\"ageing_opacity\":0.1,\"EyeLidL\":0.0,\"ChinW\":0.0,\"blush_tx_id\":0,\"ArmsS\":0.0,\"NoseS\":0.1,\"disc_tx_id\":0,\"paintedmasks_opacity\":0,\"CheekBonesH\":0.0,\"MouthCLW\":0.0,\"foundation_tx_id\":0,\"scars_visibility\":1,\"shadows_opacity\":0,\"NeckD\":0.0,\"BodyType\":1210379577,\"EyeBrowW\":0.0,\"blush_palette_id\":0,\"EyeH\":0.0,\"hair_color_primary\":0,\"freckles_opacity\":0,\"ULiphH\":0.0,\"LegsS\":0.0,\"shadows_palette_color_secondary\":0,\"Torso\":1272509601,\"disc_opacity\":0.1,\"MouthCRH\":0.0,\"paintedmasks_palette_id\":0,\"ShouldersT\":0.0,\"ageing_tx_id\":5,\"Hair\":74204665,\"sex\":\"mp_male\",\"LLiphD\":0.0,\"ageing_visibility\":1,\"MouthCRD\":0.0,\"MouthCLD\":0.0,\"EyeLidR\":0.0,\"EarsW\":0.0,\"foundation_opacity\":0,\"foundation_palette_color_secondary\":0,\"WaistW\":0,\"MouthW\":0.0,\"Body\":-1241887289,\"EyeLidH\":0.0,\"hair_opacity\":0,\"MouthY\":0.0,\"beardstabble_visibility\":1,\"lipsticks_palette_color_tertiary\":0,\"EyeLidW\":0.0,\"blush_opacity\":0,\"moles_tx_id\":0,\"NoseW\":0.2,\"EyeBrowD\":0.0,\"ChinH\":0.0,\"eyebrows_opacity\":1.0,\"beardstabble_tx_id\":0,\"paintedmasks_visibility\":0,\"acne_opacity\":0,\"beardstabble_opacity\":0,\"complex_opacity\":0,\"beardstabble_color_primary\":0,\"EyeAng\":0.0,\"spots_opacity\":0,\"lipsticks_palette_color_primary\":0,\"paintedmasks_palette_color_primary\":0,\"eyebrows_color\":1064202495,\"FaceD\":0.2,\"ShouldersS\":0.0,\"lipsticks_opacity\":0,\"grime_tx_id\":0,\"HeadType\":1106971106,\"scars_opacity\":1.0,\"eyeliner_visibility\":0,\"lipsticks_palette_color_secondary\":0,\"JawD\":0.0,\"freckles_visibility\":0,\"eyeliner_tx_id\":0}', '{\"Vest\":-1,\"EyeWear\":-1,\"Armor\":-1,\"Mask\":-1,\"Loadouts\":-1,\"Glove\":-1,\"Poncho\":-1,\"Buckle\":-1,\"Boots\":-218859683,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Coat\":-1,\"Chap\":-1,\"Bow\":-1,\"Gauntlets\":-1,\"Badge\":-1,\"RingRh\":-1,\"Belt\":-1,\"Skirt\":-1,\"Pant\":1939930032,\"Dress\":-1,\"Cloak\":-1,\"Bracelet\":-1,\"Spurs\":-1,\"Holster\":-1,\"CoatClosed\":-1,\"Suspender\":-1,\"Shirt\":-1665588256,\"Gunbelt\":795591403,\"NeckTies\":-1,\"Hat\":-1,\"Accessories\":-1,\"NeckWear\":-1,\"RingLh\":-1,\"Teeth\":1629650936,\"Spats\":-1}', '{\"Shirt\":{\"-1665588256\":{\"palette\":0,\"tint0\":0,\"tint1\":0,\"tint2\":0}},\"Boots\":{\"-218859683\":{\"palette\":0,\"tint0\":0,\"tint1\":0,\"tint2\":0}},\"Accessories\":[],\"Pant\":{\"1939930032\":{\"palette\":0,\"tint0\":0,\"tint1\":0,\"tint2\":0}},\"Gunbelt\":{\"795591403\":{\"palette\":0,\"tint0\":0,\"tint1\":0,\"tint2\":0}}}', 0, '{\"y\":789.96923828125,\"z\":117.3538818359375,\"heading\":300.4724426269531,\"x\":-323.4593505859375}', '{\"Thirst\":1000,\"Hunger\":1000,\"Metabolism\":-56}', 0, '{\"Fishing\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Crafting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Mining\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Hunting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0}}', 'noanim', 0.00, '{}', '842819315748438016', '[]', 0),
('steam:11000016da2474b', 'Laake_Oldtaker', 6, 'user', 2093.50, 0.00, 0.00, 0, 500, 100, 500, 100, 0, '2025-06-20', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'LAAKE', 'OLDTAKER', 'none', 'Male', 28, 'oldtaker', '{\"CheekBonesH\":0.0,\"MouthCLLD\":0.0,\"ChinH\":0.0,\"eyebrows_opacity\":1.0,\"Scale\":1.05,\"JawD\":0.0,\"MouthCRLD\":0.0,\"acne_tx_id\":0,\"MouthCLD\":0.0,\"complex_visibility\":0,\"EarsW\":0.0,\"ageing_visibility\":0,\"hair_visibility\":1,\"lipsticks_tx_id\":0,\"FaceW\":0.0,\"NoseAng\":0.0,\"sex\":\"mp_male\",\"Albedo\":0,\"Legs\":1957643589,\"FaceD\":0.0,\"shadows_opacity\":0,\"freckles_visibility\":0,\"LLiphD\":0.0,\"blush_opacity\":0,\"HipsS\":0.0,\"LLiphW\":0.0,\"ULiphD\":0.0,\"Hair\":4017859389,\"spots_visibility\":0,\"ShouldersS\":0.0,\"Waist\":1736416063,\"CheekBonesW\":0.0,\"shadows_palette_color_primary\":0,\"eyeliner_opacity\":0,\"LegsS\":0.0,\"eyeliner_palette_id\":0,\"MouthCLH\":0.0,\"hair_opacity\":0,\"beardstabble_visibility\":1,\"lipsticks_visibility\":0,\"NoseC\":0.0,\"ArmsS\":0.0,\"EyeLidW\":0.0,\"shadows_visibility\":0,\"Torso\":1272509601,\"freckles_tx_id\":0,\"EyeLidR\":0.0,\"EarsH\":0.0,\"MouthCRH\":0.0,\"Eyes\":-264699789,\"eyeliner_color_primary\":0,\"shadows_tx_id\":0,\"paintedmasks_tx_id\":0,\"grime_opacity\":0,\"EyeH\":0.0,\"complex_tx_id\":0,\"grime_visibility\":0,\"lipsticks_palette_id\":0,\"blush_palette_color_primary\":0,\"scars_tx_id\":7,\"lipsticks_palette_color_secondary\":0,\"MouthW\":0.0,\"shadows_palette_color_tertiary\":0,\"disc_opacity\":0,\"MouthY\":0.0,\"EyeLidL\":0.0,\"moles_visibility\":0,\"LegsType\":-577595642,\"MouthX\":0.0,\"NoseS\":0.0,\"NeckD\":0.0,\"grime_tx_id\":0,\"ShouldersT\":0.0,\"foundation_palette_color_tertiary\":0,\"MouthCRD\":0.0,\"paintedmasks_visibility\":0,\"EyeBrowD\":0.0,\"Beard\":0,\"blush_tx_id\":0,\"beardstabble_color_primary\":1734720533,\"acne_opacity\":0,\"moles_opacity\":0,\"EyeDis\":0.0,\"hair_color_primary\":0,\"foundation_opacity\":0,\"eyeliner_tx_id\":0,\"ShouldersM\":0.0,\"MouthCRW\":0.0,\"freckles_opacity\":0,\"ageing_tx_id\":0,\"eyebrows_tx_id\":2,\"CheekBonesD\":0.0,\"CalvesS\":0.0,\"scars_opacity\":1.0,\"spots_tx_id\":0,\"paintedmasks_palette_id\":0,\"albedo\":-629195971,\"EyeAng\":0.0,\"JawH\":0.0,\"EyeLidH\":0.0,\"ULiphH\":0.0,\"EarsD\":0.0,\"ULiphW\":0.0,\"NeckW\":0.0,\"HeadType\":-1030255847,\"paintedmasks_opacity\":0,\"blush_palette_id\":0,\"HeadSize\":0.0,\"shadows_palette_id\":0,\"scars_visibility\":1,\"EyeBrowH\":0.0,\"foundation_palette_color_secondary\":0,\"beardstabble_opacity\":1.0,\"beardstabble_tx_id\":1,\"NoseW\":0.0,\"foundation_visibility\":0,\"foundation_palette_color_primary\":0,\"NoseH\":0.0,\"BodyType\":96561259,\"ageing_opacity\":0,\"moles_tx_id\":0,\"lipsticks_palette_color_primary\":0,\"ChinW\":0.0,\"foundation_tx_id\":0,\"paintedmasks_palette_color_primary\":0,\"paintedmasks_palette_color_secondary\":0,\"disc_tx_id\":0,\"lipsticks_opacity\":0,\"eyebrows_visibility\":1,\"disc_visibility\":0,\"complex_opacity\":0,\"shadows_palette_color_secondary\":0,\"JawW\":0.0,\"EarsA\":0.0,\"paintedmasks_palette_color_tertiary\":0,\"MouthCLW\":0.0,\"blush_visibility\":0,\"lipsticks_palette_color_tertiary\":0,\"acne_visibility\":0,\"MouthD\":0.0,\"ChinD\":0.0,\"eyebrows_color\":1090645383,\"eyeliner_visibility\":0,\"spots_opacity\":0,\"foundation_palette_id\":0,\"LLiphH\":0.0,\"EyeD\":0.0,\"EyeBrowW\":0.0,\"hair_tx_id\":0,\"WaistW\":0.0,\"NoseDis\":0.0,\"Body\":32611963,\"FaceS\":0.0,\"ChestS\":0.0}', '{\"Belt\":7635313,\"Holster\":-1,\"Spurs\":-1,\"Loadouts\":-1,\"NeckTies\":-1,\"RingRh\":-1,\"Bracelet\":-1,\"Cloak\":-1,\"Teeth\":-509378308,\"Coat\":-1,\"Accessories\":395446814,\"Satchels\":-1,\"Hat\":-1,\"Vest\":-1,\"Pant\":1939930032,\"Gunbelt\":795591403,\"EyeWear\":-1309317717,\"Shirt\":-1665588256,\"RingLh\":-1,\"Spats\":-1,\"Dress\":-1,\"Gauntlets\":586942988,\"Poncho\":-1,\"CoatClosed\":-1,\"Skirt\":-1,\"NeckWear\":-1,\"Glove\":332969337,\"Mask\":-1,\"Chap\":-1,\"GunbeltAccs\":-1,\"Suspender\":-1,\"Boots\":874236056,\"Buckle\":-1,\"Bow\":-1,\"Armor\":-1,\"Badge\":-1}', '{\"Belt\":{\"7635313\":{\"tint2\":0,\"palette\":0,\"index\":4,\"color\":1,\"tint1\":0,\"tint0\":0}},\"Pant\":{\"1939930032\":{\"tint2\":0,\"palette\":0,\"index\":5,\"color\":5,\"tint1\":0,\"tint0\":0}},\"Gunbelt\":{\"795591403\":{\"tint2\":0,\"palette\":0,\"index\":1,\"color\":1,\"tint1\":0,\"tint0\":0}},\"Glove\":{\"332969337\":{\"tint2\":132,\"palette\":-1952348042,\"index\":12,\"color\":0,\"tint1\":117,\"tint0\":44}},\"Boots\":{\"874236056\":{\"tint2\":67,\"palette\":-1952348042,\"index\":3,\"color\":1,\"tint1\":30,\"tint0\":40}},\"Shirt\":{\"-1665588256\":{\"tint2\":0,\"palette\":0,\"index\":5,\"color\":3,\"tint1\":0,\"tint0\":0}},\"EyeWear\":{\"-1309317717\":{\"tint2\":23,\"palette\":896697531,\"index\":4,\"color\":0,\"tint1\":171,\"tint0\":245}},\"Accessories\":{\"395446814\":{\"tint2\":0,\"palette\":-1436165981,\"index\":2,\"color\":1,\"tint1\":0,\"tint0\":0}},\"Gauntlets\":{\"586942988\":{\"tint2\":18,\"palette\":-183908539,\"index\":1,\"color\":0,\"tint1\":14,\"tint0\":30}}}', 0, '{\"x\":1332.923095703125,\"heading\":266.4566955566406,\"z\":76.947998046875,\"y\":-1301.7626953125}', '{\"Thirst\":997,\"Metabolism\":68,\"Hunger\":997}', 0, '{\"Fishing\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1},\"Crafting\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1},\"Mining\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1},\"Hunting\":{\"MaxLevel\":5,\"Exp\":0,\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1}}', 'MP_Style_Flamboyant', 0.00, '{\"AMMO_RIFLE\":59}', '1304344187897905165', '[]', 0),
('steam:11000016db4fdd0', 'successfulgtv', 11, 'user', 50.00, 1417.00, 0.00, 0, 500, 100, 500, 100, 0, '2025-06-20', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'Successful', 'Zino', 'Lord', 'Male', 27, 'Successful', '{\"MouthCRLD\":0.0,\"EarsA\":0.0,\"acne_tx_id\":0,\"hair_opacity\":0,\"ageing_opacity\":0,\"lipsticks_opacity\":0,\"Eyes\":642477207,\"ShouldersM\":0.0,\"MouthCLD\":0.0,\"ULiphD\":0.0,\"lipsticks_tx_id\":0,\"HeadSize\":0.0,\"LLiphH\":0.0,\"shadows_palette_color_secondary\":0,\"Legs\":-249761286,\"LLiphD\":0.0,\"ChinD\":0.0,\"ULiphH\":0.0,\"paintedmasks_palette_color_primary\":0,\"beardstabble_visibility\":1,\"blush_visibility\":0,\"NoseH\":0.0,\"beardstabble_tx_id\":0,\"shadows_palette_color_primary\":0,\"shadows_tx_id\":0,\"blush_palette_id\":0,\"LegsType\":1207869376,\"eyeliner_opacity\":0,\"ArmsS\":0.0,\"Waist\":-2045421226,\"scars_opacity\":0,\"Beard\":75152474,\"LLiphW\":0.0,\"moles_tx_id\":0,\"paintedmasks_opacity\":0,\"eyeliner_visibility\":0,\"MouthCRW\":0.0,\"eyebrows_color\":1064202495,\"CheekBonesH\":0.0,\"BodyType\":-1932953983,\"CheekBonesD\":0.0,\"lipsticks_palette_color_tertiary\":0,\"EyeBrowD\":0.0,\"MouthCRD\":0.0,\"scars_tx_id\":0,\"freckles_opacity\":0,\"eyebrows_opacity\":1.0,\"HeadType\":2063814808,\"paintedmasks_tx_id\":0,\"NoseW\":0.0,\"eyebrows_tx_id\":1,\"ChestS\":0.0,\"foundation_palette_color_secondary\":0,\"Torso\":1272509601,\"sex\":\"mp_male\",\"CalvesS\":0.0,\"CheekBonesW\":0.0,\"ageing_tx_id\":0,\"shadows_palette_color_tertiary\":0,\"beardstabble_opacity\":0,\"acne_opacity\":0,\"LegsS\":0.0,\"paintedmasks_palette_color_secondary\":0,\"JawD\":0.0,\"EyeAng\":0.0,\"NeckD\":0.0,\"shadows_palette_id\":0,\"disc_tx_id\":0,\"foundation_opacity\":0,\"Hair\":2443401377,\"paintedmasks_palette_color_tertiary\":0,\"eyeliner_tx_id\":0,\"EyeDis\":0.0,\"Scale\":0.0,\"foundation_visibility\":0,\"paintedmasks_visibility\":0,\"EyeLidH\":0.0,\"MouthD\":0.0,\"NoseDis\":0.0,\"blush_palette_color_primary\":0,\"complex_opacity\":0,\"FaceD\":0.0,\"disc_opacity\":0,\"NoseC\":0.0,\"lipsticks_palette_color_secondary\":0,\"paintedmasks_palette_id\":0,\"MouthCRH\":0.0,\"eyeliner_color_primary\":0,\"ULiphW\":0.0,\"NoseAng\":0.0,\"shadows_opacity\":0,\"grime_opacity\":0,\"ChinW\":0.0,\"complex_visibility\":0,\"FaceW\":0.0,\"beardstabble_color_primary\":0,\"EyeBrowW\":0.0,\"lipsticks_visibility\":0,\"ChinH\":0.0,\"moles_visibility\":0,\"disc_visibility\":0,\"WaistW\":0.0,\"shadows_visibility\":0,\"spots_visibility\":0,\"EyeD\":0.0,\"albedo\":1590586643,\"moles_opacity\":0,\"Body\":-369348190,\"EyeLidR\":0.0,\"freckles_visibility\":0,\"eyebrows_visibility\":1,\"scars_visibility\":0,\"spots_tx_id\":0,\"MouthCLW\":0.0,\"spots_opacity\":0,\"foundation_palette_id\":0,\"foundation_tx_id\":0,\"NoseS\":0.0,\"ageing_visibility\":0,\"EarsD\":0.0,\"hair_tx_id\":0,\"lipsticks_palette_id\":0,\"FaceS\":0.0,\"JawH\":0.0,\"lipsticks_palette_color_primary\":0,\"eyeliner_palette_id\":0,\"MouthCLH\":0.0,\"EyeLidL\":0.0,\"blush_tx_id\":0,\"ShouldersT\":0.0,\"grime_tx_id\":0,\"MouthCLLD\":0.0,\"EyeH\":0.0,\"foundation_palette_color_primary\":0,\"EarsH\":0.0,\"MouthW\":0.0,\"HipsS\":0.0,\"Albedo\":0,\"MouthX\":0.0,\"EyeBrowH\":0.0,\"MouthY\":0.0,\"foundation_palette_color_tertiary\":0,\"NeckW\":0.0,\"JawW\":0.0,\"grime_visibility\":0,\"hair_color_primary\":0,\"acne_visibility\":0,\"EarsW\":0.0,\"blush_opacity\":0,\"hair_visibility\":0,\"EyeLidW\":0.0,\"freckles_tx_id\":0,\"ShouldersS\":0.0,\"complex_tx_id\":0}', '{\"Spats\":-1,\"Loadouts\":-1,\"Mask\":-1,\"Skirt\":-1,\"Badge\":-1,\"EyeWear\":-1,\"Glove\":-1,\"Belt\":-1,\"Hat\":-1,\"Coat\":-1,\"Chap\":-1,\"Vest\":-1,\"Gauntlets\":-1,\"NeckTies\":-1,\"Dress\":-1,\"Bow\":-1,\"Bracelet\":-1,\"RingRh\":-1,\"Holster\":-1,\"Gunbelt\":795591403,\"Poncho\":-1,\"Spurs\":-1,\"Armor\":-1,\"Boots\":-218859683,\"NeckWear\":-1,\"GunbeltAccs\":-1,\"Buckle\":-1,\"Pant\":1939930032,\"Shirt\":-1665588256,\"Teeth\":712446626,\"RingLh\":-1,\"CoatClosed\":-1,\"Suspender\":-1,\"Satchels\":-1,\"Accessories\":-1,\"Cloak\":-1}', '{\"Boots\":{\"-218859683\":{\"palette\":0,\"tint2\":0,\"tint0\":0,\"tint1\":0}},\"Pant\":{\"1939930032\":{\"palette\":0,\"tint2\":0,\"tint0\":0,\"tint1\":0}},\"Shirt\":{\"-1665588256\":{\"palette\":0,\"tint2\":0,\"tint0\":0,\"tint1\":0}},\"Gunbelt\":{\"795591403\":{\"palette\":0,\"tint2\":0,\"tint0\":0,\"tint1\":0}}}', 0, '{\"y\":789.6791381835938,\"z\":117.134765625,\"heading\":243.77952575683595,\"x\":-317.6175842285156}', '{\"Hunger\":999,\"Thirst\":999,\"Metabolism\":-104}', 0, '{\"Fishing\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Crafting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Mining\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0},\"Hunting\":{\"NextLevel\":100,\"MaxLevel\":5,\"Label\":\"Beginner\",\"Level\":1,\"Exp\":0}}', 'noanim', 0.00, '{}', '1304346933770326017', '[]', 0);
INSERT INTO `characters` (`identifier`, `steamname`, `charidentifier`, `group`, `money`, `gold`, `rol`, `xp`, `healthouter`, `healthinner`, `staminaouter`, `staminainner`, `hours`, `LastLogin`, `inventory`, `slots`, `job`, `joblabel`, `meta`, `firstname`, `lastname`, `character_desc`, `gender`, `age`, `nickname`, `skinPlayer`, `compPlayer`, `compTints`, `jobgrade`, `coords`, `status`, `isdead`, `skills`, `walk`, `gunsmith`, `ammo`, `discordid`, `lastjoined`, `posseid`) VALUES
('steam:11000016e197d4f', 'mraproko', 5, 'user', 5257.12, 30000.00, 0.00, 1057, 500, 100, 500, 100, 0, '2025-06-21', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'Puzo', 'King', 'wise king', 'Male', 30, 'APROKO', '{\"CheekBonesH\":0.0,\"MouthCLLD\":0.0,\"ChinH\":0.0,\"eyebrows_opacity\":1.0,\"Scale\":1.0,\"JawD\":0.0,\"MouthCRLD\":0.0,\"acne_tx_id\":1,\"MouthCLD\":0.0,\"complex_visibility\":0,\"EarsW\":0.0,\"ageing_visibility\":0,\"hair_visibility\":0,\"lipsticks_tx_id\":0,\"FaceW\":0.0,\"NoseAng\":0.0,\"sex\":\"mp_male\",\"Albedo\":0,\"Legs\":1957643589,\"FaceD\":0.0,\"shadows_opacity\":0,\"freckles_visibility\":0,\"NoseDis\":0.0,\"ageing_tx_id\":0,\"HipsS\":0.0,\"LLiphW\":0.0,\"ULiphD\":0.0,\"Hair\":3672461011,\"spots_visibility\":0,\"shadows_palette_color_secondary\":0,\"Waist\":-844699484,\"CheekBonesW\":0.0,\"shadows_palette_color_primary\":0,\"eyeliner_opacity\":0,\"LegsS\":0.0,\"HeadType\":1922396359,\"MouthCLH\":0.0,\"hair_opacity\":0,\"beardstabble_visibility\":1,\"lipsticks_visibility\":0,\"EyeBrowW\":0.0,\"acne_visibility\":1,\"EyeLidW\":0.0,\"CheekBonesD\":0.0,\"Torso\":-1173759763,\"paintedmasks_palette_color_secondary\":0,\"EyeLidR\":0.0,\"EarsH\":0.0,\"MouthCRH\":0.0,\"Eyes\":46507404,\"eyeliner_color_primary\":0,\"shadows_tx_id\":0,\"paintedmasks_tx_id\":0,\"grime_opacity\":0,\"EyeH\":0.0,\"eyebrows_visibility\":1,\"spots_tx_id\":0,\"NoseW\":0.0,\"blush_palette_color_primary\":0,\"scars_tx_id\":0,\"lipsticks_palette_color_secondary\":0,\"MouthW\":0.0,\"foundation_visibility\":0,\"disc_opacity\":0,\"MouthY\":0.0,\"EyeLidL\":0.0,\"moles_visibility\":0,\"LegsType\":-1794701840,\"MouthX\":0.0,\"NoseS\":0.0,\"NeckD\":0.0,\"grime_tx_id\":0,\"ShouldersT\":0.0,\"foundation_palette_color_tertiary\":0,\"MouthCRD\":0.0,\"paintedmasks_visibility\":0,\"EyeBrowD\":0.0,\"Beard\":59227358,\"blush_tx_id\":0,\"beardstabble_color_primary\":0,\"acne_opacity\":0.2,\"moles_opacity\":0,\"beardstabble_opacity\":0,\"eyebrows_color\":1064202495,\"ShouldersS\":0.0,\"EyeDis\":0.0,\"EyeD\":0.0,\"MouthCRW\":0.0,\"eyeliner_palette_id\":0,\"paintedmasks_palette_id\":0,\"eyebrows_tx_id\":3,\"grime_visibility\":0,\"eyeliner_tx_id\":0,\"scars_opacity\":0,\"JawH\":0.0,\"foundation_palette_color_primary\":0,\"beardstabble_tx_id\":1,\"shadows_palette_id\":0,\"blush_visibility\":0,\"EyeLidH\":0.0,\"blush_opacity\":0,\"MouthD\":0.0,\"ULiphW\":0.0,\"NeckW\":0.0,\"EarsA\":0.0,\"paintedmasks_opacity\":0,\"blush_palette_id\":0,\"HeadSize\":0.0,\"NoseC\":0.0,\"scars_visibility\":0,\"EyeBrowH\":0.0,\"foundation_palette_color_secondary\":0,\"shadows_visibility\":0,\"EarsD\":0.0,\"shadows_palette_color_tertiary\":0,\"ShouldersM\":0.0,\"lipsticks_palette_id\":0,\"NoseH\":0.0,\"BodyType\":1773547611,\"freckles_opacity\":0,\"moles_tx_id\":0,\"lipsticks_palette_color_primary\":0,\"ChinW\":0.0,\"foundation_tx_id\":0,\"freckles_tx_id\":0,\"complex_tx_id\":0,\"disc_tx_id\":0,\"lipsticks_opacity\":0,\"paintedmasks_palette_color_primary\":0,\"albedo\":1708217028,\"ULiphH\":0.0,\"complex_opacity\":0,\"JawW\":0.0,\"ChestS\":0.0,\"paintedmasks_palette_color_tertiary\":0,\"ageing_opacity\":0,\"EyeAng\":0.0,\"lipsticks_palette_color_tertiary\":0,\"foundation_palette_id\":0,\"LLiphD\":0.0,\"ArmsS\":0.0,\"foundation_opacity\":0,\"disc_visibility\":0,\"spots_opacity\":0,\"CalvesS\":0.0,\"LLiphH\":0.0,\"eyeliner_visibility\":0,\"hair_color_primary\":0,\"hair_tx_id\":0,\"WaistW\":0.0,\"ChinD\":0.0,\"Body\":-20262001,\"FaceS\":0.0,\"MouthCLW\":0.0}', '{\"Accessories\":-1,\"NeckWear\":-1,\"Badge\":-1,\"CoatClosed\":1133022400,\"Dress\":-1,\"Armor\":-1,\"Poncho\":-1,\"RingRh\":-1,\"Bracelet\":-1,\"Skirt\":-1,\"Loadouts\":-1688431438,\"Gauntlets\":376060699,\"Mask\":-1,\"Pant\":-245398271,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Holster\":-2086565603,\"EyeWear\":633673784,\"Buckle\":-1120042477,\"Boots\":1354409584,\"Bow\":-1,\"Vest\":-1,\"NeckTies\":2116314776,\"Spats\":-1,\"Suspender\":-1,\"Coat\":-1,\"Teeth\":1629650936,\"Cloak\":-1,\"Chap\":-1,\"Gunbelt\":-499572842,\"Spurs\":-1,\"Glove\":1435483306,\"RingLh\":-1,\"Shirt\":-1845028218,\"Hat\":-1,\"Belt\":7635313}', '{\"Loadouts\":{\"-1688431438\":{\"palette\":-783849117,\"tint1\":60,\"color\":1,\"index\":3,\"tint0\":14,\"tint2\":60}},\"Holster\":{\"-2086565603\":{\"palette\":-1952348042,\"tint1\":132,\"color\":4,\"index\":2,\"tint0\":132,\"tint2\":105}},\"Glove\":{\"1435483306\":{\"palette\":896697531,\"tint1\":104,\"color\":2,\"index\":14,\"tint0\":60,\"tint2\":104}},\"NeckTies\":{\"2116314776\":{\"palette\":-1436165981,\"tint1\":21,\"color\":1,\"index\":4,\"tint0\":21,\"tint2\":21}},\"EyeWear\":{\"633673784\":{\"palette\":-1543234321,\"tint1\":250,\"color\":1,\"index\":5,\"tint0\":62,\"tint2\":11}},\"Buckle\":{\"-1120042477\":{\"palette\":0,\"tint1\":0,\"color\":1,\"index\":17,\"tint0\":0,\"tint2\":0}},\"Gunbelt\":{\"-499572842\":{\"palette\":-783849117,\"tint1\":1,\"color\":1,\"index\":6,\"tint0\":1,\"tint2\":58}},\"Boots\":{\"1354409584\":{\"palette\":1090645383,\"tint1\":16,\"color\":1,\"index\":67,\"tint0\":244,\"tint2\":21}},\"Gauntlets\":{\"376060699\":{\"palette\":17129595,\"tint1\":61,\"color\":1,\"index\":3,\"tint0\":21,\"tint2\":30}},\"CoatClosed\":{\"1133022400\":{\"palette\":-1543234321,\"tint1\":68,\"color\":1,\"index\":4,\"tint0\":77,\"tint2\":64}},\"Pant\":{\"-245398271\":{\"palette\":-770746372,\"tint1\":189,\"color\":0,\"index\":22,\"tint0\":60,\"tint2\":248}},\"Shirt\":{\"-1845028218\":{\"palette\":1090645383,\"tint1\":21,\"color\":1,\"index\":30,\"tint0\":20,\"tint2\":21}},\"Belt\":{\"7635313\":{\"palette\":0,\"tint1\":0,\"color\":1,\"index\":4,\"tint0\":0,\"tint2\":0}}}', 0, '{\"z\":59.6094970703125,\"heading\":136.06298828125,\"x\":-1009.9912109375,\"y\":-1199.77587890625}', '{\"Hunger\":985,\"Metabolism\":-2316,\"Thirst\":985}', 0, '{\"Hunting\":{\"Exp\":0,\"Label\":\"Beginner\",\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1},\"Mining\":{\"Exp\":0,\"Label\":\"Beginner\",\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1},\"Fishing\":{\"Exp\":0,\"Label\":\"Beginner\",\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1},\"Crafting\":{\"Exp\":0,\"Label\":\"Beginner\",\"MaxLevel\":5,\"NextLevel\":100,\"Level\":1}}', 'MP_Style_Gunslinger', 0.00, '{\"AMMO_SHOTGUN_SLUG\":37,\"AMMO_BOLAS\":3,\"AMMO_REPEATER\":200,\"AMMO_RIFLE\":100,\"AMMO_SHOTGUN\":0,\"AMMO_PISTOL_EXPRESS\":98,\"AMMO_REVOLVER\":39}', '923486556789022751', '[]', 1),
('steam:11000016e97323d', 'akwugame23', 10, 'user', 96.25, 0.00, 0.00, 0, 500, 100, 500, 100, 0, '2025-06-21', '{}', 100.0, 'unemployed', 'Unemployed', '{}', 'AKW', 'GAME', 'none', 'Male', 32, 'none', '{\"FaceD\":0.0,\"shadows_tx_id\":0,\"EyeLidH\":0.0,\"foundation_palette_id\":0,\"acne_tx_id\":0,\"eyeliner_tx_id\":0,\"shadows_opacity\":0,\"complex_tx_id\":0,\"lipsticks_palette_color_primary\":0,\"paintedmasks_palette_color_primary\":0,\"grime_opacity\":0,\"ULiphD\":0.0,\"Waist\":-1273449080,\"ChinW\":0.5,\"blush_visibility\":0,\"NeckD\":0.0,\"NoseS\":0.0,\"paintedmasks_tx_id\":0,\"LLiphD\":0.0,\"LegsType\":-279528818,\"moles_tx_id\":0,\"foundation_palette_color_primary\":0,\"MouthD\":0.0,\"foundation_tx_id\":0,\"spots_opacity\":0,\"disc_tx_id\":0,\"spots_tx_id\":0,\"complex_opacity\":0,\"EyeH\":0.0,\"lipsticks_palette_color_tertiary\":0,\"scars_opacity\":0,\"beardstabble_visibility\":0,\"HeadType\":1180513553,\"freckles_opacity\":0,\"ArmsS\":0.0,\"NoseH\":0.0,\"beardstabble_opacity\":0.0,\"MouthCRW\":0.0,\"MouthCLW\":0.0,\"EyeD\":0.0,\"EyeDis\":0.0,\"ShouldersT\":0.0,\"lipsticks_palette_id\":0,\"foundation_visibility\":0,\"eyebrows_color\":0,\"lipsticks_opacity\":0,\"MouthCRD\":0.0,\"spots_visibility\":0,\"paintedmasks_opacity\":0,\"grime_visibility\":0,\"EyeLidW\":0.0,\"CheekBonesH\":0.0,\"EyeBrowW\":0.0,\"MouthCRLD\":0.0,\"paintedmasks_palette_color_secondary\":0,\"NeckW\":0.0,\"paintedmasks_visibility\":0,\"CalvesS\":0.0,\"sex\":\"mp_male\",\"disc_opacity\":0,\"EarsH\":0.0,\"FaceW\":0.0,\"scars_visibility\":0,\"eyeliner_color_primary\":0,\"EarsA\":0.0,\"blush_palette_id\":0,\"NoseC\":0.0,\"beardstabble_color_primary\":0,\"ULiphH\":0.0,\"MouthCLLD\":0.0,\"Beard\":166579674,\"paintedmasks_palette_id\":0,\"MouthCLD\":0.0,\"ChinD\":0.5,\"HipsS\":0.0,\"MouthCLH\":0.0,\"CheekBonesD\":0.0,\"Hair\":3496839074,\"WaistW\":0.0,\"EarsW\":0.0,\"EarsD\":0.0,\"disc_visibility\":0,\"lipsticks_tx_id\":0,\"complex_visibility\":0,\"MouthX\":0.0,\"blush_tx_id\":0,\"eyebrows_visibility\":1,\"eyeliner_visibility\":0,\"CheekBonesW\":0.0,\"shadows_visibility\":0,\"JawH\":0.5,\"EyeAng\":0.0,\"hair_tx_id\":4,\"shadows_palette_color_tertiary\":0,\"foundation_palette_color_secondary\":0,\"ChestS\":0.0,\"grime_tx_id\":0,\"NoseDis\":0.0,\"EyeBrowD\":0.0,\"foundation_palette_color_tertiary\":0,\"Legs\":1957643589,\"blush_opacity\":0,\"moles_visibility\":0,\"MouthCRH\":0.0,\"Eyes\":329402181,\"eyebrows_opacity\":1.0,\"ageing_visibility\":0,\"MouthY\":0.0,\"shadows_palette_color_primary\":0,\"LLiphH\":0.0,\"NoseW\":0.0,\"shadows_palette_color_secondary\":0,\"eyeliner_palette_id\":0,\"ageing_tx_id\":0,\"Torso\":-1270325981,\"beardstabble_tx_id\":0,\"acne_opacity\":0,\"foundation_opacity\":0,\"shadows_palette_id\":0,\"eyeliner_opacity\":0,\"hair_color_primary\":0,\"scars_tx_id\":0,\"blush_palette_color_primary\":0,\"MouthW\":0.0,\"LegsS\":0.0,\"HeadSize\":0.0,\"NoseAng\":0.0,\"albedo\":1557597939,\"Albedo\":0,\"ShouldersM\":0.0,\"EyeLidR\":0.0,\"acne_visibility\":0,\"FaceS\":0.0,\"hair_opacity\":0.0,\"hair_visibility\":0,\"moles_opacity\":0,\"ChinH\":0.5,\"eyebrows_tx_id\":22,\"ageing_opacity\":0.1,\"Scale\":1.0,\"EyeBrowH\":0.0,\"LLiphW\":0.0,\"Body\":-369348190,\"ShouldersS\":0.0,\"EyeLidL\":0.0,\"lipsticks_palette_color_secondary\":0,\"ULiphW\":0.0,\"paintedmasks_palette_color_tertiary\":0,\"freckles_visibility\":0,\"JawD\":0.5,\"freckles_tx_id\":0,\"lipsticks_visibility\":0,\"BodyType\":1025441837,\"JawW\":0.5}', '{\"Buckle\":1635771202,\"Glove\":-1,\"Holster\":1858275734,\"Cloak\":-1,\"Badge\":-1,\"CoatClosed\":761551698,\"RingLh\":-1,\"RingRh\":-1,\"Belt\":-1,\"Skirt\":-1,\"Hat\":-1735668802,\"Accessories\":-1,\"Boots\":-315016488,\"Bracelet\":-1,\"Chap\":-1,\"Bow\":-1,\"EyeWear\":-1,\"NeckWear\":-1,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Mask\":-1,\"Gauntlets\":-1,\"Coat\":-1,\"Dress\":-1,\"Loadouts\":-170358564,\"Shirt\":-346529404,\"Poncho\":-1,\"Spats\":-1,\"Vest\":-1,\"Spurs\":-1,\"Teeth\":712446626,\"Gunbelt\":1382144499,\"NeckTies\":-1,\"Armor\":-1,\"Pant\":1738549663,\"Suspender\":-1}', '{\"Gunbelt\":{\"1382144499\":{\"tint2\":8,\"tint0\":0,\"color\":4,\"index\":18,\"tint1\":60,\"palette\":-183908539}},\"Glove\":[],\"Holster\":{\"1858275734\":{\"tint2\":8,\"tint0\":0,\"color\":0,\"index\":15,\"tint1\":60,\"palette\":-183908539}},\"Cloak\":[],\"CoatClosed\":{\"761551698\":{\"tint2\":0,\"tint0\":28,\"color\":1,\"index\":8,\"tint1\":0,\"palette\":-783849117}},\"RingLh\":[],\"Belt\":[],\"Coat\":{\"1209418538\":{\"tint2\":53,\"tint0\":252,\"color\":8,\"index\":33,\"tint1\":16,\"palette\":1090645383}},\"Loadouts\":{\"-170358564\":{\"tint0\":0,\"tint2\":0,\"tint1\":0,\"palette\":1669565057}},\"Shirt\":{\"-346529404\":{\"tint2\":16,\"tint0\":16,\"color\":4,\"index\":14,\"tint1\":16,\"palette\":-1436165981}},\"Hat\":{\"-1735668802\":{\"tint2\":28,\"tint0\":15,\"color\":4,\"index\":146,\"tint1\":21,\"palette\":864404955}},\"Accessories\":[],\"Spats\":[],\"Buckle\":{\"1635771202\":{\"tint2\":63,\"tint0\":50,\"color\":1,\"index\":23,\"tint1\":62,\"palette\":1064202495}},\"Boots\":{\"-315016488\":{\"tint0\":74,\"tint2\":13,\"tint1\":0,\"palette\":-1543234321}},\"NeckTies\":[],\"Pant\":{\"1738549663\":{\"tint2\":35,\"tint0\":21,\"color\":0,\"index\":16,\"tint1\":16,\"palette\":1090645383},\"1939930032\":{\"tint0\":0,\"tint2\":12,\"tint1\":0,\"palette\":-783849117}},\"Chap\":[]}', 0, '{\"x\":-329.96044921875,\"y\":791.4066162109375,\"z\":117.3707275390625,\"heading\":291.968505859375}', '{\"Hunger\":999,\"Thirst\":999,\"Metabolism\":-490}', 0, '{\"Fishing\":{\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1,\"MaxLevel\":5,\"Exp\":0},\"Crafting\":{\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1,\"MaxLevel\":5,\"Exp\":0},\"Hunting\":{\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1,\"MaxLevel\":5,\"Exp\":0},\"Mining\":{\"NextLevel\":100,\"Label\":\"Beginner\",\"Level\":1,\"MaxLevel\":5,\"Exp\":0}}', 'noanim', 0.00, '{\"AMMO_SHOTGUN\":6,\"AMMO_RIFLE\":84}', '1326001280904204362', '[]', 2);

-- --------------------------------------------------------

--
-- Table structure for table `character_inventories`
--

CREATE TABLE `character_inventories` (
  `character_id` int(11) DEFAULT NULL,
  `inventory_type` varchar(100) NOT NULL DEFAULT 'default',
  `item_crafted_id` int(11) NOT NULL,
  `item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'item',
  `amount` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `degradation` int(11) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `character_inventories`
--

INSERT INTO `character_inventories` (`character_id`, `inventory_type`, `item_crafted_id`, `item_name`, `amount`, `created_at`, `degradation`, `percentage`) VALUES
(1, 'default', 1, 'ammorevolvernormal', 1, '2025-06-15 12:51:32', NULL, NULL),
(2, 'default', 6, 'pickaxe', 1, '2025-06-15 15:56:49', NULL, NULL),
(1, 'default', 12, 'ammoshotgunnormal', 8, '2025-06-15 16:46:33', NULL, NULL),
(2, 'default', 13, 'ammoshotgunnormal', 8, '2025-06-15 16:46:54', NULL, NULL),
(2, 'default', 14, 'ammoriflenormal', 1, '2025-06-15 16:48:50', NULL, NULL),
(1, 'default', 15, 'ammoriflenormal', 9, '2025-06-15 16:48:59', NULL, NULL),
(2, 'default', 16, 'hatchet', 1, '2025-06-15 17:16:26', NULL, NULL),
(1, 'default', 18, 'Red_Sage', 4, '2025-06-15 17:17:03', NULL, NULL),
(1, 'default', 23, 'animal_crawfish', 1, '2025-06-15 18:24:58', NULL, NULL),
(1, 'default', 27, 'clay', 3, '2025-06-15 18:46:33', NULL, NULL),
(1, 'default', 31, 'Mutton', 1, '2025-06-15 19:12:41', NULL, NULL),
(2, 'default', 35, 'consumable_raspberrywater', 4, '2025-06-16 00:31:15', NULL, NULL),
(2, 'vorp_banking_Blackwater_2', 37, 'rock', 3, '2025-06-16 00:33:53', NULL, NULL),
(2, 'vorp_banking_Blackwater_2', 38, 'clay', 3, '2025-06-16 00:34:01', NULL, NULL),
(2, 'vorp_banking_Blackwater_2', 40, 'animal_crawfish', 1, '2025-06-16 03:00:42', NULL, NULL),
(3, 'default', 46, 'consumable_raspberrywater', 4, '2025-06-16 08:55:44', NULL, NULL),
(3, 'default', 47, 'ammorevolvernormal', 1, '2025-06-16 08:55:44', NULL, NULL),
(2, 'vorp_banking_Valentine_2', 48, 'meat', 1, '2025-06-16 09:26:10', NULL, NULL),
(2, 'vorp_banking_Valentine_2', 49, 'game', 1, '2025-06-16 09:26:22', NULL, NULL),
(2, 'vorp_banking_Valentine_2', 50, 'rabbits', 1, '2025-06-16 09:26:31', NULL, NULL),
(2, 'vorp_banking_Valentine_2', 51, 'rabbitpaw', 1, '2025-06-16 09:26:36', NULL, NULL),
(3, 'default', 52, 'ammoriflenormal', 1, '2025-06-16 09:43:34', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 65, 'wood', 13, '2025-06-16 10:02:11', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 66, 'Creeking_Thyme', 15, '2025-06-16 10:04:19', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 67, 'foxt', 1, '2025-06-16 10:04:20', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 68, 'foxskin', 1, '2025-06-16 10:04:23', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 69, 'bucks', 1, '2025-06-16 10:04:25', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 70, 'game', 2, '2025-06-16 10:04:29', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 71, 'Milk_Weed', 1, '2025-06-16 10:04:32', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 72, 'buckantler', 1, '2025-06-16 10:04:37', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 73, 'venison', 3, '2025-06-16 10:04:42', NULL, NULL),
(3, 'default', 76, 'water', 1, '2025-06-16 10:15:10', NULL, NULL),
(3, 'default', 78, 'deerheart', 2, '2025-06-16 10:21:34', NULL, NULL),
(3, 'default', 79, 'deerskin', 2, '2025-06-16 10:21:34', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 81, 'Red_Sage', 13, '2025-06-16 10:26:42', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 82, 'Milk_Weed', 5, '2025-06-16 10:26:52', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 85, 'coal', 2, '2025-06-16 10:30:08', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 86, 'nitrite', 3, '2025-06-16 10:30:16', NULL, NULL),
(3, 'default', 88, 'coyotes', 1, '2025-06-16 10:35:49', NULL, NULL),
(3, 'default', 90, 'pork', 1, '2025-06-16 10:39:31', NULL, NULL),
(3, 'default', 91, 'legboars2', 1, '2025-06-16 10:39:31', NULL, NULL),
(3, 'default', 92, 'boarmusk', 1, '2025-06-16 10:39:31', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 93, 'Red_Sage', 4, '2025-06-16 10:47:47', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 94, 'coyotef', 1, '2025-06-16 10:47:54', NULL, NULL),
(3, 'A_C_Horse_Kladruber_Black_3', 95, 'meat', 3, '2025-06-16 10:48:21', NULL, NULL),
(3, 'default', 97, 'consumable_peach', 5, '2025-06-16 10:56:28', NULL, NULL),
(3, 'default', 98, 'pickaxe', 1, '2025-06-16 10:56:43', NULL, NULL),
(3, 'default', 99, 'Crows_Garlic', 2, '2025-06-16 11:02:15', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 100, 'Crows_Garlic', 5, '2025-06-17 02:08:24', NULL, NULL),
(2, 'default', 107, 'stringy', 1, '2025-06-17 23:44:23', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 114, 'English_Mace', 2, '2025-06-18 00:24:11', NULL, NULL),
(2, 'default', 119, 'consumable_breakfast', 2, '2025-06-18 01:18:21', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 125, 'honey', 2, '2025-06-18 01:32:54', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 126, 'Hummingbird_Sage', 6, '2025-06-18 01:33:10', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 131, 'deerskin', 6, '2025-06-18 01:47:18', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 133, 'venison', 7, '2025-06-18 02:02:27', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 134, 'Bulrush', 7, '2025-06-18 02:02:39', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 135, 'blueberry', 9, '2025-06-18 02:02:54', NULL, NULL),
(2, 'default', 139, 'venison', 5, '2025-06-18 02:10:48', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 141, 'Oregano', 8, '2025-06-18 02:25:07', NULL, NULL),
(2, 'default', 142, 'hk_1', 1, '2025-06-18 02:47:28', NULL, NULL),
(2, 'hk_1', 143, 'Milk_Weed', 5, '2025-06-18 02:48:00', NULL, NULL),
(2, 'hk_1', 144, 'Crows_Garlic', 5, '2025-06-18 02:48:08', NULL, NULL),
(2, 'hk_1', 145, 'biggame', 1, '2025-06-18 02:51:30', NULL, NULL),
(2, 'hk_1', 146, 'bucks', 1, '2025-06-18 02:51:38', NULL, NULL),
(2, 'hk_1', 147, 'buckantler', 1, '2025-06-18 02:51:42', NULL, NULL),
(2, 'hk_1', 148, 'wolfheart', 5, '2025-06-18 02:51:55', NULL, NULL),
(2, 'hk_1', 149, 'fibers', 4, '2025-06-18 02:52:21', NULL, NULL),
(2, 'hk_1', 150, 'deerheart', 6, '2025-06-18 02:52:38', NULL, NULL),
(2, 'hk_1', 151, 'aligatorto', 1, '2025-06-18 02:52:48', NULL, NULL),
(2, 'hk_1', 152, 'wsnakeskin', 1, '2025-06-18 02:52:57', NULL, NULL),
(2, 'hk_1', 153, 'snaket', 1, '2025-06-18 02:53:05', NULL, NULL),
(2, 'hk_1', 154, 'pulp', 1, '2025-06-18 02:53:18', NULL, NULL),
(2, 'hk_1', 155, 'American_Ginseng', 2, '2025-06-18 02:53:30', NULL, NULL),
(2, 'hk_1', 156, 'p_baitCorn01x', 2, '2025-06-18 02:53:59', NULL, NULL),
(2, 'hk_1', 157, 'sap', 2, '2025-06-18 02:54:13', NULL, NULL),
(2, 'hk_1', 158, 'pork', 1, '2025-06-18 02:54:57', NULL, NULL),
(2, 'hk_1', 159, 'aligators', 1, '2025-06-18 02:55:15', NULL, NULL),
(2, 'hk_1', 160, 'boarmusk', 1, '2025-06-18 02:55:21', NULL, NULL),
(2, 'hk_1', 161, 'legboars2', 1, '2025-06-18 02:55:25', NULL, NULL),
(2, 'hk_1', 162, 'prongs', 1, '2025-06-18 02:55:31', NULL, NULL),
(2, 'hk_1', 163, 'p_finisdfishlurelegendary01x', 1, '2025-06-18 02:55:37', NULL, NULL),
(2, 'hk_1', 164, 'wolfpelt', 5, '2025-06-18 02:55:52', NULL, NULL),
(2, 'hk_1', 165, 'wolftooth', 5, '2025-06-18 02:56:03', NULL, NULL),
(2, 'default', 167, 'Mutton', 1, '2025-06-18 03:10:05', NULL, NULL),
(2, 'default', 168, 'ramhorn', 1, '2025-06-18 03:10:05', NULL, NULL),
(2, 'default', 169, 'rams', 1, '2025-06-18 03:10:05', NULL, NULL),
(2, 'default', 171, 'wolftooth', 2, '2025-06-18 03:23:01', NULL, NULL),
(2, 'default', 172, 'wolfpelt', 2, '2025-06-18 03:23:01', NULL, NULL),
(2, 'default', 175, 'honey', 2, '2025-06-18 03:29:24', NULL, NULL),
(2, 'default', 177, 'sap', 9, '2025-06-18 03:32:44', NULL, NULL),
(2, 'default', 178, 'hwood', 18, '2025-06-18 03:56:48', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 181, 'Agarita', 5, '2025-06-18 05:32:23', NULL, NULL),
(2, 'A_C_Horse_Kladruber_Black_2', 182, 'game', 7, '2025-06-18 05:32:55', NULL, NULL),
(2, 'default', 184, 'Oregano', 1, '2025-06-18 05:47:11', NULL, NULL),
(2, 'default', 185, 'buckantler', 2, '2025-06-18 06:25:37', NULL, NULL),
(2, 'default', 186, 'bucks', 2, '2025-06-18 06:25:37', NULL, NULL),
(4, 'default', 187, 'consumable_raspberrywater', 2, '2025-06-18 15:50:28', NULL, NULL),
(4, 'default', 188, 'ammorevolvernormal', 1, '2025-06-18 15:50:28', NULL, NULL),
(1, 'default', 189, 'absinthe', 3, '2025-06-18 16:08:19', NULL, NULL),
(2, 'horse_2', 191, 'Creeking_Thyme', 2, '2025-06-18 17:10:56', NULL, NULL),
(2, 'horse_2', 192, 'wolfheart', 2, '2025-06-18 17:11:39', NULL, NULL),
(2, 'horse_2', 193, 'Crows_Garlic', 3, '2025-06-18 17:11:47', NULL, NULL),
(2, 'horse_2', 194, 'Red_Raspberry', 3, '2025-06-18 17:11:54', NULL, NULL),
(2, 'horse_2', 195, 'wood', 20, '2025-06-18 17:13:22', NULL, NULL),
(2, 'horse_2', 196, 'pulp', 10, '2025-06-18 17:13:36', NULL, NULL),
(2, 'default', 197, 'horsemeal', 5, '2025-06-18 17:14:04', NULL, NULL),
(1, 'default', 198, 'blueberry', 4, '2025-06-18 17:29:21', NULL, NULL),
(1, 'default', 199, 'Oregano', 8, '2025-06-18 18:14:15', NULL, NULL),
(2, 'default', 200, 'prongs', 2, '2025-06-18 18:21:55', NULL, NULL),
(1, 'default', 201, 'buckantler', 3, '2025-06-18 18:35:47', NULL, NULL),
(1, 'default', 203, 'venison', 3, '2025-06-18 18:35:47', NULL, NULL),
(2, 'default', 204, 'meat', 10, '2025-06-18 18:37:30', NULL, NULL),
(2, 'default', 205, 'Red_Sage', 5, '2025-06-18 18:45:14', NULL, NULL),
(2, 'default', 206, 'coal', 5, '2025-06-18 19:01:31', NULL, NULL),
(2, 'default', 207, 'copper', 5, '2025-06-18 19:21:00', NULL, NULL),
(5, 'default', 208, 'consumable_raspberrywater', 5, '2025-06-18 20:30:40', NULL, NULL),
(5, 'default', 212, 'ammoriflenormal', 3, '2025-06-19 04:59:58', NULL, NULL),
(5, 'default', 213, 'ammotomahawk', 1, '2025-06-19 05:00:32', NULL, NULL),
(5, 'default', 216, 'hk_2', 1, '2025-06-19 05:44:15', NULL, NULL),
(5, 'default', 219, 'pickaxe', 1, '2025-06-19 06:16:49', NULL, NULL),
(5, 'horse_5', 238, 'beart', 1, '2025-06-19 10:22:44', NULL, NULL),
(5, 'horse_5', 239, 'deerheart', 1, '2025-06-19 10:22:48', NULL, NULL),
(5, 'horse_5', 240, 'deerskin', 1, '2025-06-19 10:23:12', NULL, NULL),
(5, 'horse_5', 241, 'wolfheart', 1, '2025-06-19 10:23:16', NULL, NULL),
(5, 'horse_5', 242, 'antipoison2', 1, '2025-06-19 10:23:23', NULL, NULL),
(5, 'horse_5', 243, 'Crows_Garlic', 8, '2025-06-19 10:23:32', NULL, NULL),
(5, 'horse_5', 244, 'biggame', 1, '2025-06-19 10:23:45', NULL, NULL),
(5, 'horse_5', 245, 'venison', 1, '2025-06-19 10:23:48', NULL, NULL),
(5, 'horse_5', 246, 'ammobolaironspiked', 1, '2025-06-19 10:24:04', NULL, NULL),
(5, 'horse_5', 247, 'wolftooth', 1, '2025-06-19 10:24:11', NULL, NULL),
(5, 'horse_5', 248, 'bearc', 1, '2025-06-19 10:25:12', NULL, NULL),
(5, 'horse_5', 249, 'Creeking_Thyme', 10, '2025-06-19 10:25:23', NULL, NULL),
(5, 'horse_5', 250, 'Oregano', 6, '2025-06-19 10:25:34', NULL, NULL),
(5, 'horse_5', 251, 'wolfpelt', 1, '2025-06-19 10:26:43', NULL, NULL),
(5, 'horse_5', 252, 'bandage', 5, '2025-06-19 10:26:53', NULL, NULL),
(5, 'horse_5', 253, 'Bulrush', 3, '2025-06-19 10:27:05', NULL, NULL),
(5, 'horse_5', 254, 'game', 1, '2025-06-19 10:27:21', NULL, NULL),
(6, 'default', 255, 'ammorevolvernormal', 1, '2025-06-20 05:56:26', NULL, NULL),
(6, 'default', 256, 'consumable_raspberrywater', 2, '2025-06-20 05:56:26', NULL, NULL),
(6, 'default', 259, 'ammoriflenormal', 3, '2025-06-20 06:13:40', NULL, NULL),
(5, 'default', 260, 'game', 2, '2025-06-20 06:20:43', NULL, NULL),
(5, 'default', 264, 'water', 4, '2025-06-20 06:20:58', NULL, NULL),
(5, 'default', 265, 'Red_Sage', 3, '2025-06-20 06:22:51', NULL, NULL),
(5, 'default', 268, 'stringy', 2, '2025-06-20 06:46:27', NULL, NULL),
(5, 'horse_5', 270, 'iron', 10, '2025-06-20 07:10:49', NULL, NULL),
(5, 'horse_5', 271, 'wood', 10, '2025-06-20 07:11:26', NULL, NULL),
(5, 'default', 274, 'meat', 1, '2025-06-20 07:53:36', NULL, NULL),
(7, 'default', 276, 'consumable_raspberrywater', 4, '2025-06-20 08:37:27', NULL, NULL),
(7, 'default', 279, 'pickaxe', 1, '2025-06-20 09:29:36', NULL, NULL),
(7, 'default', 280, 'consumable_breakfast', 3, '2025-06-20 09:31:49', NULL, NULL),
(8, 'default', 285, 'ammorevolvernormal', 1, '2025-06-20 09:53:43', NULL, NULL),
(8, 'default', 286, 'consumable_raspberrywater', 10, '2025-06-20 09:53:43', NULL, NULL),
(7, 'horse_6', 287, 'iron', 35, '2025-06-20 09:54:18', NULL, NULL),
(7, 'horse_6', 288, 'clay', 28, '2025-06-20 09:54:24', NULL, NULL),
(7, 'horse_6', 289, 'Red_Raspberry', 8, '2025-06-20 09:54:43', NULL, NULL),
(7, 'horse_6', 290, 'Red_Sage', 10, '2025-06-20 09:54:55', NULL, NULL),
(7, 'default', 295, 'Red_Sage', 1, '2025-06-20 10:48:11', NULL, NULL),
(8, 'default', 296, 'ammoshotgunnormal', 5, '2025-06-20 10:48:52', NULL, NULL),
(7, 'default', 297, 'ammoriflenormal', 1, '2025-06-20 10:50:08', NULL, NULL),
(7, 'horse_6', 298, 'Creeking_Thyme', 9, '2025-06-20 10:50:11', NULL, NULL),
(7, 'horse_6', 299, 'wolftooth', 3, '2025-06-20 10:50:21', NULL, NULL),
(7, 'horse_6', 300, 'wolfpelt', 3, '2025-06-20 10:50:28', NULL, NULL),
(7, 'horse_6', 301, 'wolfheart', 3, '2025-06-20 10:50:43', NULL, NULL),
(7, 'horse_6', 303, 'Crows_Garlic', 6, '2025-06-20 10:50:56', NULL, NULL),
(5, 'default', 307, 'clay', 9, '2025-06-20 11:10:02', NULL, NULL),
(5, 'default', 311, 'blueberry', 6, '2025-06-20 11:12:52', NULL, NULL),
(7, 'horse_6', 313, 'salt', 12, '2025-06-20 11:15:17', NULL, NULL),
(7, 'horse_6', 314, 'copper', 10, '2025-06-20 11:15:31', NULL, NULL),
(7, 'horse_6', 315, 'Oregano', 5, '2025-06-20 11:15:41', NULL, NULL),
(7, 'horse_6', 316, 'American_Ginseng', 3, '2025-06-20 11:15:48', NULL, NULL),
(7, 'horse_6', 321, 'coal', 3, '2025-06-20 11:37:38', NULL, NULL),
(7, 'default', 322, 'consumable_coffee', 1, '2025-06-20 12:02:12', NULL, NULL),
(7, 'default', 325, 'ammoriflesplitpoint', 2, '2025-06-20 12:07:00', NULL, NULL),
(8, 'default', 326, 'pickaxe', 1, '2025-06-20 12:07:04', NULL, NULL),
(6, 'default', 327, 'consumable_chocolate', 2, '2025-06-20 12:31:41', NULL, NULL),
(6, 'default', 329, 'consumable_fruitsalad', 1, '2025-06-20 12:31:41', NULL, NULL),
(6, 'default', 330, 'consumable_breakfast', 1, '2025-06-20 12:31:42', NULL, NULL),
(7, 'default', 333, 'ammorevolversplitpoint', 1, '2025-06-20 12:34:14', NULL, NULL),
(6, 'default', 334, 'bandage', 4, '2025-06-20 12:34:55', NULL, NULL),
(6, 'default', 335, 'whisky', 3, '2025-06-20 12:35:16', NULL, NULL),
(6, 'default', 336, 'empty_bottle', 2, '2025-06-20 12:35:21', NULL, NULL),
(7, 'default', 338, 'empty_bottle', 1, '2025-06-20 12:36:52', NULL, NULL),
(7, 'default', 339, 'game', 3, '2025-06-20 12:39:02', NULL, NULL),
(7, 'default', 340, 'salt', 3, '2025-06-20 12:39:12', NULL, NULL),
(8, 'default', 341, 'consumable_spongecake', 1, '2025-06-20 13:18:12', NULL, NULL),
(8, 'default', 342, 'consumable_breakfast', 2, '2025-06-20 13:18:12', NULL, NULL),
(8, 'default', 345, 'consumable_chocolatecake', 1, '2025-06-20 13:18:13', NULL, NULL),
(8, 'default', 346, 'consumable_poundcake', 1, '2025-06-20 13:18:13', NULL, NULL),
(6, 'horse_10', 347, 'Crows_Garlic', 8, '2025-06-20 13:19:51', NULL, NULL),
(6, 'horse_10', 348, 'Creeking_Thyme', 2, '2025-06-20 13:19:56', NULL, NULL),
(1, 'default', 349, 'ammopistolnormal', 4, '2025-06-20 13:31:41', NULL, NULL),
(8, 'default', 350, 'ammorifleexpress', 7, '2025-06-20 13:32:10', NULL, NULL),
(8, 'default', 351, 'ammoriflenormal', 7, '2025-06-20 13:32:10', NULL, NULL),
(6, 'horse_10', 352, 'consumable_caramel', 2, '2025-06-20 13:37:21', NULL, NULL),
(8, 'default', 356, 'water', 4, '2025-06-20 14:01:04', NULL, NULL),
(1, 'default', 357, 'fibers', 1, '2025-06-20 14:13:02', NULL, NULL),
(1, 'default', 358, 'ammorepeaternormal', 1, '2025-06-20 14:15:18', NULL, NULL),
(1, 'default', 359, 'water', 1, '2025-06-20 14:15:30', NULL, NULL),
(1, 'default', 360, 'meat', 2, '2025-06-20 14:25:05', NULL, NULL),
(8, 'default', 361, 'English_Mace', 9, '2025-06-20 15:38:13', NULL, NULL),
(5, 'default', 362, 'hatchet', 1, '2025-06-20 15:41:00', NULL, NULL),
(1, 'default', 363, 'hatchet', 1, '2025-06-20 15:41:12', NULL, NULL),
(8, 'default', 364, 'Creeking_Thyme', 9, '2025-06-20 15:46:30', NULL, NULL),
(9, 'default', 365, 'consumable_raspberrywater', 2, '2025-06-20 15:48:32', NULL, NULL),
(9, 'default', 366, 'ammorevolvernormal', 1, '2025-06-20 15:48:32', NULL, NULL),
(8, 'default', 367, 'Bulrush', 8, '2025-06-20 15:48:50', NULL, NULL),
(5, 'default', 368, 'Bulrush', 2, '2025-06-20 15:48:51', NULL, NULL),
(5, 'default', 369, 'Agarita', 3, '2025-06-20 17:07:40', NULL, NULL),
(8, 'default', 370, 'antipoison2', 1, '2025-06-20 17:14:39', NULL, NULL),
(5, 'default', 371, 'Crows_Garlic', 5, '2025-06-20 17:44:15', NULL, NULL),
(5, 'default', 372, 'Creeking_Thyme', 10, '2025-06-20 17:51:28', NULL, NULL),
(8, 'default', 373, 'clay', 3, '2025-06-20 17:51:35', NULL, NULL),
(8, 'default', 374, 'salt', 4, '2025-06-20 17:51:39', NULL, NULL),
(8, 'default', 375, 'Crows_Garlic', 1, '2025-06-20 17:52:53', NULL, NULL),
(8, 'default', 376, 'ammorepeaternormal', 2, '2025-06-20 17:54:26', NULL, NULL),
(8, 'default', 377, 'Red_Sage', 7, '2025-06-20 17:55:35', NULL, NULL),
(8, 'default', 378, 'Red_Raspberry', 8, '2025-06-20 18:04:31', NULL, NULL),
(5, 'default', 379, 'ammorepeaternormal', 2, '2025-06-20 18:21:07', NULL, NULL),
(8, 'default', 380, 'meat', 2, '2025-06-20 18:48:54', NULL, NULL),
(5, 'default', 381, 'fibers', 7, '2025-06-20 19:24:26', NULL, NULL),
(5, 'default', 382, 'wood', 3, '2025-06-20 19:24:34', NULL, NULL),
(5, 'default', 383, 'knivehandle', 3, '2025-06-20 19:24:40', NULL, NULL),
(5, 'default', 384, 'rope', 1, '2025-06-20 19:24:47', NULL, NULL),
(5, 'default', 385, 'powdergun', 1, '2025-06-20 19:25:48', NULL, NULL),
(5, 'default', 386, 'iron', 19, '2025-06-20 19:25:54', NULL, NULL),
(1, 'default', 387, 'dynamite', 4, '2025-06-20 19:35:55', NULL, NULL),
(1, 'default', 388, 'bagofcoal', 1, '2025-06-20 19:37:33', NULL, NULL),
(10, 'default', 390, 'consumable_raspberrywater', 2, '2025-06-20 19:57:16', NULL, NULL),
(10, 'default', 391, 'ammorevolvernormal', 1, '2025-06-20 19:57:16', NULL, NULL),
(10, 'default', 392, 'ammoriflenormal', 4, '2025-06-20 20:06:44', NULL, NULL),
(5, 'default', 393, 'rock', 3, '2025-06-20 20:09:16', NULL, NULL),
(5, 'default', 394, 'ironbar', 3, '2025-06-20 20:09:22', NULL, NULL),
(8, 'default', 395, 'Oregano', 5, '2025-06-20 20:19:46', NULL, NULL),
(8, 'default', 396, 'copperbar', 5, '2025-06-20 20:20:08', NULL, NULL),
(8, 'default', 397, 'iron', 13, '2025-06-20 20:20:32', NULL, NULL),
(10, 'default', 398, 'ammorepeaternormal', 1, '2025-06-20 20:36:06', NULL, NULL),
(8, 'default', 399, 'bird', 1, '2025-06-20 20:36:48', NULL, NULL),
(8, 'default', 400, 'hawkf', 1, '2025-06-20 20:36:48', NULL, NULL),
(8, 'default', 401, 'hawkt', 1, '2025-06-20 20:36:48', NULL, NULL),
(10, 'default', 402, 'Oregano', 9, '2025-06-20 20:41:19', NULL, NULL),
(10, 'default', 403, 'Creeking_Thyme', 8, '2025-06-20 20:43:01', NULL, NULL),
(10, 'default', 404, 'Agarita', 4, '2025-06-20 20:43:35', NULL, NULL),
(11, 'default', 405, 'consumable_raspberrywater', 2, '2025-06-20 21:01:17', NULL, NULL),
(11, 'default', 406, 'ammorevolvernormal', 1, '2025-06-20 21:01:17', NULL, NULL),
(5, 'default', 407, 'consumable_breakfast', 3, '2025-06-20 21:01:54', NULL, NULL),
(8, 'default', 408, 'ammoriflevelocity', 4, '2025-06-20 21:07:16', NULL, NULL),
(8, 'default', 409, 'ammoriflesplitpoint', 3, '2025-06-20 21:07:16', NULL, NULL),
(8, 'default', 410, 'ammoshotgunslug', 2, '2025-06-20 21:07:17', NULL, NULL),
(8, 'default', 411, 'tropicalPunchMoonshine', 3, '2025-06-20 21:11:21', NULL, NULL),
(10, 'default', 412, 'ammopistolnormal', 5, '2025-06-20 21:12:31', NULL, NULL),
(10, 'default', 413, 'ammoshotgunnormal', 2, '2025-06-20 21:12:31', NULL, NULL),
(10, 'default', 414, 'ammoriflesplitpoint', 5, '2025-06-20 21:12:31', NULL, NULL),
(10, 'default', 415, 'ammoarrownormal', 10, '2025-06-20 21:13:32', NULL, NULL),
(9, 'default', 416, 'tropicalPunchMoonshine', 1, '2025-06-20 21:47:41', NULL, NULL),
(10, 'default', 417, 'consumable_breakfast', 5, '2025-06-21 00:37:22', NULL, NULL),
(10, 'default', 418, 'consumable_kidneybeans_can', 5, '2025-06-21 00:37:22', NULL, NULL),
(10, 'default', 419, 'Red_Sage', 1, '2025-06-21 03:26:02', NULL, NULL),
(5, 'default', 420, 'pulp', 1, '2025-06-21 05:48:38', NULL, NULL),
(5, 'default', 421, 'nitrite', 5, '2025-06-21 06:45:54', NULL, NULL),
(5, 'default', 422, 'lockpick', 2, '2025-06-21 06:53:38', NULL, NULL),
(5, 'default', 423, 'ammopistolexpress', 9, '2025-06-21 06:59:04', NULL, NULL),
(5, 'default', 424, 'cigar', 10, '2025-06-21 07:15:17', NULL, NULL),
(5, 'default', 425, 'cigarette', 10, '2025-06-21 07:16:42', NULL, NULL),
(5, 'default', 426, 'shovel', 1, '2025-06-21 08:04:25', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doorlocks`
--

CREATE TABLE `doorlocks` (
  `doorid` int(11) NOT NULL,
  `doorinfo` longtext NOT NULL,
  `jobsallowedtoopen` longtext NOT NULL DEFAULT 'none',
  `keyitem` varchar(50) NOT NULL DEFAULT 'none',
  `locked` varchar(50) NOT NULL DEFAULT 'false',
  `ids_allowed` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `herbalists`
--

CREATE TABLE `herbalists` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `horse_complements`
--

CREATE TABLE `horse_complements` (
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `horse_complements`
--

INSERT INTO `horse_complements` (`identifier`, `charidentifier`, `complements`) VALUES
('1', 1, '[]'),
('2', 2, '[1180033890,491707272,3525692576,3730450693]'),
('3', 3, '[3730450693]');

-- --------------------------------------------------------

--
-- Table structure for table `housing`
--

CREATE TABLE `housing` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `groupId` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'Item Group ID for Filtering',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `desc` varchar(5550) NOT NULL DEFAULT 'nice item',
  `degradation` int(11) NOT NULL DEFAULT 0 COMMENT 'if 0 Item do not degrade use a positive number (in minutes) to enable degradation min is 1',
  `weight` decimal(20,2) NOT NULL DEFAULT 0.25
) ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `degradation`, `weight`) VALUES
('absinthe', 'Absinthe', 10, 1, 'item_standard', 1, 733, 1, '{}', 'An anise-flavoured spirit derived from several plants, including the flowers and leaves of Artemisia absinthium', 0, 0.25),
('acid', 'Acid', 10, 1, 'item_standard', 1, 1, 1, '{}', 'A corrosive substance used for various purposes.', 0, 0.25),
('Agarita', 'Agarita', 10, 1, 'item_standard', 1, 2, 1, '{}', 'A flowering plant found in the wild, known for its medicinal properties.', 0, 0.25),
('Agarita_Seed', 'Agarita Seed', 10, 1, 'item_standard', 1, 3, 1, '{}', 'A seed that can be planted to grow Agarita plants.', 0, 0.25),
('Alaskan_Ginseng', 'Alaskan Ginseng', 10, 1, 'item_standard', 1, 4, 1, '{}', 'A type of ginseng native to the Alaskan region, prized for its healing properties.', 0, 0.25),
('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 10, 1, 'item_standard', 1, 5, 1, '{}', 'A seed that can be planted to grow Alaskan Ginseng.', 0, 0.25),
('alcohol', 'Alcohol', 10, 1, 'item_standard', 1, 6, 1, '{}', 'An intoxicating beverage consumed for recreational purposes.', 0, 0.25),
('aligatormeat', 'Alligator Meat', 20, 1, 'item_standard', 1, 7, 1, '{}', 'Raw meat obtained from hunting alligators, suitable for cooking.', 0, 0.25),
('aligators', 'Alligator Pelt', 20, 1, 'item_standard', 1, 8, 1, '{}', 'The skin of an alligator, commonly used for crafting and trading.', 0, 0.25),
('aligatorto', 'Alligator Tooth', 20, 1, 'item_standard', 1, 9, 1, '{}', 'A tooth extracted from an alligator, sometimes used for decorative purposes.', 0, 0.25),
('American_Ginseng', 'American Ginseng', 10, 1, 'item_standard', 1, 10, 1, '{}', 'A species of ginseng native to North America, valued for its medicinal properties.', 0, 0.25),
('American_Ginseng_Seed', 'American Ginseng Seed', 10, 1, 'item_standard', 1, 11, 1, '{}', 'A seed that can be planted to grow American Ginseng.', 0, 0.25),
('ammoarrowdynamite', 'Arrow Dynamite', 10, 1, 'item_standard', 1, 13, 1, '{}', 'An explosive arrow designed to cause significant damage upon impact.', 0, 0.25),
('ammoarrowfire', 'Arrow Fire', 10, 1, 'item_standard', 1, 14, 1, '{}', 'An arrow equipped with a flaming tip, capable of setting targets on fire.', 0, 0.25),
('ammoarrowimproved', 'Arrow Improved', 10, 1, 'item_standard', 1, 15, 1, '{}', 'An upgraded arrow with improved accuracy and damage.', 0, 0.25),
('ammoarrownormal', 'Arrow Normal', 10, 1, 'item_standard', 1, 12, 1, '{}', 'A standard arrow used with bows for hunting and combat.', 0, 0.25),
('ammoarrowpoison', 'Arrow Poison', 10, 1, 'item_standard', 1, 16, 1, '{}', 'An arrow coated with a poisonous substance, capable of inflicting additional damage over time.', 0, 0.25),
('ammoarrowsmallgame', 'Arrow Small Game', 10, 1, 'item_standard', 1, 17, 1, '{}', 'A specialized arrow designed for hunting small game without damaging their pelts.', 0, 0.25),
('ammobolahawk', 'Bola Ammo Hawk', 10, 1, 'item_standard', 1, 18, 1, '{}', 'A projectile consisting of weights attached to ropes, used to immobilize targets.', 0, 0.25),
('ammobolainterwired', 'Bola Ammo Interwired', 10, 1, 'item_standard', 1, 19, 1, '{}', 'A reinforced bola ammunition with interwoven materials, providing enhanced durability.', 0, 0.25),
('ammobolaironspiked', 'Bola Ammo Ironspiked', 10, 1, 'item_standard', 1, 20, 1, '{}', 'A bola ammunition featuring iron spikes, inflicting additional damage to immobilized targets.', 0, 0.25),
('ammobolla', 'Bolla Ammo', 10, 1, 'item_standard', 1, 21, 1, '{}', 'A weighted throwing weapon used to ensnare and immobilize targets.', 0, 0.25),
('ammodynamite', 'Dynamite Ammo', 10, 1, 'item_standard', 1, 22, 1, '{}', 'An explosive device with a short fuse, capable of causing significant damage.', 0, 0.25),
('ammoelephant', 'Elephant Rifle Ammo', 10, 1, 'item_standard', 1, 23, 1, '{}', 'Ammunition specifically designed for powerful elephant rifles, providing superior stopping power.', 0, 0.25),
('ammoknives', 'Knives Ammo', 10, 1, 'item_standard', 1, 24, 1, '{}', 'Ammunition for a throwing knife, used as a versatile and silent weapon.', 0, 0.25),
('ammomolotov', 'Molotov Ammo', 10, 1, 'item_standard', 1, 25, 1, '{}', 'A glass bottle filled with flammable liquid, designed to burst into flames upon impact.', 0, 0.25),
('ammopistolexplosive', 'Pistol Ammo Explosive', 10, 1, 'item_standard', 1, 26, 1, '{}', 'Ammunition for a pistol with explosive properties, causing significant damage upon impact.', 0, 0.25),
('ammopistolexpress', 'Pistol Ammo Express', 10, 1, 'item_standard', 1, 27, 1, '{}', 'High-velocity ammunition specifically designed for pistols, providing increased range and damage.', 0, 0.25),
('ammopistolnormal', 'Pistol Ammo Normal', 10, 1, 'item_standard', 1, 28, 1, '{}', 'Standard ammunition used with pistols for self-defense and combat.', 0, 0.25),
('ammopistolsplitpoint', 'Pistol Ammo Splitpoint', 10, 1, 'item_standard', 1, 29, 1, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy.', 0, 0.25),
('ammopistolvelocity', 'Pistol Ammo Velocity', 10, 1, 'item_standard', 1, 30, 1, '{}', 'Ammunition designed to enhance the velocity and accuracy of pistol shots.', 0, 0.25),
('ammopoisonbottle', 'Poison Bottle Ammo', 10, 1, 'item_standard', 1, 31, 1, '{}', 'A glass bottle filled with a poisonous substance, used to coat weapons and inflict additional damage.', 0, 0.25),
('ammorepeaterexplosive', 'Repeater Ammo Explosive', 10, 1, 'item_standard', 1, 32, 1, '{}', 'Ammunition for a repeater rifle with explosive properties, causing significant damage upon impact.', 0, 0.25),
('ammorepeaterexpress', 'Repeater Ammo Express', 10, 1, 'item_standard', 1, 33, 1, '{}', 'High-velocity ammunition specifically designed for repeater rifles, providing increased range and damage.', 0, 0.25),
('ammorepeaternormal', 'Repeater Ammo Normal', 10, 1, 'item_standard', 1, 34, 1, '{}', 'Standard ammunition used with repeater rifles for self-defense and combat.', 0, 0.25),
('ammorepeatersplitpoint', 'Repeater Ammo Splitpoint', 10, 1, 'item_standard', 1, 35, 1, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy when used with repeater rifles.', 0, 0.25),
('ammorepeatervelocity', 'Repeater Ammo Velocity', 10, 1, 'item_standard', 1, 36, 1, '{}', 'Ammunition designed to enhance the velocity and accuracy of repeater rifle shots.', 0, 0.25),
('ammorevolverexplosive', 'Revolver Ammo Explosive', 10, 1, 'item_standard', 1, 37, 1, '{}', 'Ammunition for a revolver with explosive properties, causing significant damage upon impact.', 0, 0.25),
('ammorevolverexpress', 'Revolver Ammo Express', 10, 1, 'item_standard', 1, 38, 1, '{}', 'High-velocity ammunition specifically designed for revolvers, providing increased range and damage.', 0, 0.25),
('ammorevolvernormal', 'Revolver Ammo Normal', 10, 1, 'item_standard', 1, 39, 1, '{}', 'Standard ammunition used with revolvers for self-defense and combat.', 0, 0.25),
('ammorevolversplitpoint', 'Revolver Ammo Splitpoint', 10, 1, 'item_standard', 1, 40, 1, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy when used with revolvers.', 0, 0.25),
('ammorevolvervelocity', 'Revolver Ammo Velocity', 10, 1, 'item_standard', 1, 41, 1, '{}', 'Ammunition designed to enhance the velocity and accuracy of revolver shots.', 0, 0.25),
('ammorifleexplosive', 'Rifle Ammo Explosive', 10, 1, 'item_standard', 1, 42, 1, '{}', 'Ammunition for a rifle with explosive properties, causing significant damage upon impact.', 0, 0.25),
('ammorifleexpress', 'Rifle Ammo Express', 10, 1, 'item_standard', 1, 43, 1, '{}', 'High-velocity ammunition specifically designed for rifles, providing increased range and damage.', 0, 0.25),
('ammoriflenormal', 'Rifle Ammo Normal', 10, 1, 'item_standard', 1, 44, 1, '{}', 'Standard ammunition used with rifles for self-defense and combat.', 0, 0.25),
('ammoriflesplitpoint', 'Rifle Ammo Splitpoint', 10, 1, 'item_standard', 1, 45, 1, '{}', 'Ammunition with a split point tip, designed to cause more damage and improve accuracy when used with rifles.', 0, 0.25),
('ammoriflevelocity', 'Rifle Ammo Velocity', 10, 1, 'item_standard', 1, 46, 1, '{}', 'Ammunition designed to enhance the velocity and accuracy of rifle shots.', 0, 0.25),
('ammoshotgunexplosive', 'Shotgun Ammo Explosive', 10, 1, 'item_standard', 1, 47, 1, '{}', 'Ammunition for a shotgun with explosive properties, causing significant damage upon impact.', 0, 0.25),
('ammoshotgunincendiary', 'Shotgun Ammo Incendiary', 10, 1, 'item_standard', 1, 48, 1, '{}', 'Ammunition designed to ignite targets, causing them to burst into flames.', 0, 0.25),
('ammoshotgunnormal', 'Shotgun Ammo Normal', 10, 1, 'item_standard', 1, 49, 1, '{}', 'Standard ammunition used with shotguns for self-defense and combat.', 0, 0.25),
('ammoshotgunslug', 'Shotgun Ammo Slug', 10, 1, 'item_standard', 1, 50, 1, '{}', 'Ammunition with a single solid projectile, offering increased accuracy and range for shotguns.', 0, 0.25),
('ammotomahawk', 'Tomahawk Ammo', 10, 1, 'item_standard', 1, 51, 1, '{}', 'Ammo used for Tomahawk throwing weapons', 0, 0.25),
('ammovarmint', 'Varmint Ammo', 10, 1, 'item_standard', 1, 52, 1, '{}', 'Ammo used for Varmint rifles', 0, 0.25),
('ammovarminttranq', 'Varmint Tranquilizer Ammo', 10, 1, 'item_standard', 1, 53, 1, '{}', 'Ammo used for tranquilizing animals with Varmint rifles', 0, 0.25),
('ammovoldynamite', 'Volatile Dynamite Ammo', 10, 1, 'item_standard', 1, 54, 1, '{}', 'Ammo used for crafting Volatile Dynamite', 0, 0.25),
('ammovolmolotov', 'Volatile Molotov Ammo', 10, 1, 'item_standard', 1, 55, 1, '{}', 'Ammo used for crafting Volatile Molotovs', 0, 0.25),
('animal_crawfish', 'Crawfish', 10, 1, 'item_standard', 1, 958, 1, '{}', 'A small freshwater crustacean.', 0, 0.25),
('antidote', 'Antidote', 5, 1, 'item_standard', 1, 1009, 1, '{}', 'A remedy to cure sickness.', 0, 0.25),
('antipoison', 'Antipoison', 20, 1, 'item_standard', 1, 56, 1, '{}', 'A medicine used to counteract the effects of poison', 0, 0.25),
('antipoison2', 'Anti Snake Poison', 20, 1, 'item_standard', 1, 57, 1, '{}', 'A poison used to fend off snakes', 0, 0.25),
('apple', 'Apple', 20, 1, 'item_standard', 1, 58, 1, '{}', 'A juicy and delicious fruit', 0, 0.25),
('applebarrel', 'Apple Barrel', 20, 1, 'item_standard', 1, 59, 1, '{}', 'A barrel filled with fresh apples', 0, 0.25),
('applebasket', 'Apple Basket', 20, 1, 'item_standard', 1, 60, 1, '{}', 'A basket filled with fresh apples', 0, 0.25),
('appleCrumbMash', 'Minty Berry Mash', 10, 1, 'item_standard', 1, 61, 1, '{}', 'A mashed mixture of mint and berries used for crafting Moonshine', 0, 0.25),
('appleCrumbMoonshine', 'Minty Berry Moonshine', 10, 1, 'item_standard', 1, 62, 1, '{}', 'A strong alcoholic beverage made from mint and berries', 0, 0.25),
('apple_barrel', 'Apple Barrel', 20, 1, 'item_standard', 1, 63, 1, '{}', 'A barrel filled with fresh apples', 0, 0.25),
('apple_basket', 'Apple Basket', 20, 1, 'item_standard', 1, 64, 1, '{}', 'A basket filled with fresh apples', 0, 0.25),
('Apple_Seed', 'Apple Seed', 10, 1, 'item_standard', 1, 65, 1, '{}', 'A seed used for growing apple trees', 0, 0.25),
('armadilloc', 'Armadillo Claws', 20, 1, 'item_standard', 1, 66, 1, '{}', 'Sharp claws harvested from an Armadillo', 0, 0.25),
('armadillos', 'Armadillo Pelt', 20, 1, 'item_standard', 1, 67, 1, '{}', 'A pelt taken from an Armadillo', 0, 0.25),
('asnakes', 'Copperhead Snake pelt', 20, 1, 'item_standard', 1, 68, 1, '{}', 'A valuable pelt from a Copperhead Snake.', 0, 0.25),
('a_c_fishbluegil_01_ms', 'Medium Bluegil', 10, 1, 'item_standard', 0, 69, 1, '{}', 'A medium-sized Bluegil fish.', 0, 0.25),
('a_c_fishbluegil_01_sm', 'Small Bluegil', 5, 1, 'item_standard', 0, 70, 1, '{}', 'A small Bluegil fish.', 0, 0.25),
('a_c_fishbullheadcat_01_ms', 'Medium Bullhead', 10, 1, 'item_standard', 0, 71, 1, '{}', 'A medium-sized Bullhead fish.', 0, 0.25),
('a_c_fishbullheadcat_01_sm', 'Small Bullhead', 5, 1, 'item_standard', 0, 72, 1, '{}', 'A small Bullhead fish.', 0, 0.25),
('a_c_fishchainpickerel_01_ms', 'Medium Pickerel', 10, 1, 'item_standard', 0, 73, 1, '{}', 'A medium-sized Pickerel fish.', 0, 0.25),
('a_c_fishchainpickerel_01_sm', 'Small Pickerel', 5, 1, 'item_standard', 0, 74, 1, '{}', 'A small Pickerel fish.', 0, 0.25),
('a_c_fishlargemouthbass_01_ms', 'Largemouth Bass', 10, 1, 'item_standard', 0, 75, 1, '{}', 'A large Largemouth Bass fish.', 0, 0.25),
('a_c_fishperch_01_ms', 'Medium Perch', 10, 1, 'item_standard', 0, 76, 1, '{}', 'A medium-sized Perch fish.', 0, 0.25),
('a_c_fishperch_01_sm', 'Small Perch', 5, 1, 'item_standard', 0, 77, 1, '{}', 'A small Perch fish.', 0, 0.25),
('a_c_fishrainbowtrout_01_ms', 'Rainbow Trout', 10, 1, 'item_standard', 0, 78, 1, '{}', 'A Rainbow Trout fish.', 0, 0.25),
('a_c_fishredfinpickerel_01_ms', 'Medium Redfin Pickerel', 10, 1, 'item_standard', 0, 79, 1, '{}', 'A medium-sized Redfin Pickerel fish.', 0, 0.25),
('a_c_fishredfinpickerel_01_sm', 'Small Redfin Pickerel', 5, 1, 'item_standard', 0, 80, 1, '{}', 'A small Redfin Pickerel fish.', 0, 0.25),
('a_c_fishrockbass_01_ms', 'Medium Rockbass', 10, 1, 'item_standard', 0, 81, 1, '{}', 'A medium-sized Rockbass fish.', 0, 0.25),
('a_c_fishrockbass_01_sm', 'Small Rockbass', 5, 1, 'item_standard', 0, 82, 1, '{}', 'A small Rockbass fish.', 0, 0.25),
('a_c_fishsalmonsockeye_01_ms', 'Sockeye Salmon', 10, 1, 'item_standard', 0, 83, 1, '{}', 'A Sockeye Salmon fish.', 0, 0.25),
('a_c_fishsmallmouthbass_01_ms', 'Smallmouth Bass', 10, 1, 'item_standard', 0, 84, 1, '{}', 'A small and tasty bass fish.', 0, 0.25),
('bacon', 'Bacon', 10, 1, 'item_standard', 1, 734, 1, '{}', 'Bacon what else do you need to know?', 0, 0.25),
('badgers', 'Badger skin', 20, 1, 'item_standard', 1, 85, 1, '{}', 'Skin obtained from a badger.', 0, 0.25),
('bagofcoal', 'Bag Of Coal', 10, 1, 'item_standard', 0, 1065, 1, '{}', 'nice item', 0, 0.25),
('bait', 'Bait', 20, 1, 'item_standard', 1, 86, 1, '{}', 'Used as bait to attract fish while fishing.', 0, 0.25),
('banana', 'Banana', 20, 1, 'item_standard', 1, 87, 1, '{}', 'A delicious and nutritious tropical fruit.', 0, 0.25),
('bandage', 'Bandage', 20, 1, 'item_standard', 1, 88, 1, '{}', 'A medical item used to dress wounds.', 0, 0.25),
('bandage_2', 'Bandage', 20, 1, 'item_standard', 1, 89, 1, '{}', 'A medical item used to dress wounds.', 0, 0.25),
('barrel', 'Barrel', 5, 1, 'item_standard', 1, 90, 1, '{}', 'A container made of wood or metal used for storing or transporting goods.', 0, 0.25),
('bat_c', 'Bat', 20, 1, 'item_standard', 1, 91, 1, '{}', 'A flying mammal known for its nocturnal habits.', 0, 0.25),
('Bay_Bolete', 'Bay Bolete', 10, 1, 'item_standard', 1, 92, 1, '{}', 'An edible mushroom with a brown cap and yellow pores.', 0, 0.25),
('Bay_Bolete_Seed', 'Bay Bolete Seed', 10, 1, 'item_standard', 1, 93, 1, '{}', 'A seed that can be planted to grow Bay Bolete mushrooms.', 0, 0.25),
('bbears', 'Black Bear skin', 20, 1, 'item_standard', 1, 94, 1, '{}', 'Skin obtained from a black bear.', 0, 0.25),
('bbirdb', 'Cormorant beak', 20, 1, 'item_standard', 1, 95, 1, '{}', 'Beak obtained from a cormorant bird.', 0, 0.25),
('bbirdf', 'Cormorant feather', 20, 1, 'item_standard', 1, 96, 1, '{}', 'Feather obtained from a cormorant bird.', 0, 0.25),
('bcandle', 'Bottle Candle', 20, 1, 'item_standard', 1, 97, 1, '{}', 'A candle made from a glass bottle.', 0, 0.25),
('bcc_clean_bottle', 'Clean Water Bottle', 15, 1, 'item_standard', 1, 1007, 1, '{}', 'A bottle filled with clean water.', 0, 0.25),
('bcc_dirty_bottle', 'Dirty Water Bottle', 15, 1, 'item_standard', 1, 1008, 1, '{}', 'A bottle filled with dirty water.', 0, 0.25),
('bcc_empty_bottle', 'Empty Bottle', 15, 1, 'item_standard', 1, 1006, 1, '{}', 'An empty bottle.', 0, 0.25),
('bcc_repair_hammer', 'Repair Hammer', 1, 1, 'item_standard', 1, 1031, 1, '{}', 'Tool used for repairs.', 0, 0.25),
('bearbench', 'Bear Bench', 20, 1, 'item_standard', 1, 98, 1, '{}', 'A bench made from the hide and bones of a bear.', 0, 0.25),
('bearc', 'Bear claws', 20, 1, 'item_standard', 1, 99, 1, '{}', 'Sharp claws obtained from a bear.', 0, 0.25),
('beart', 'Bear tooth', 20, 1, 'item_standard', 1, 100, 1, '{}', 'A tooth obtained from a bear.', 0, 0.25),
('beartrap', 'Beartrap', 10, 1, 'item_standard', 1, 735, 1, '{}', 'A sturdy beartrap used for catching animals or stopping trespassers', 0, 0.25),
('bear_bench', 'Bear Bench', 20, 1, 'item_standard', 1, 101, 1, '{}', 'A bench made from the hide and bones of a bear.', 0, 0.25),
('beavertail', 'Beaver tail', 20, 1, 'item_standard', 1, 102, 1, '{}', 'A flat and scaly tail obtained from a beaver.', 0, 0.25),
('beawers', 'Beaver pelt', 20, 1, 'item_standard', 1, 103, 1, '{}', 'A pelt obtained from a beaver.', 0, 0.25),
('beef', 'Beef', 20, 1, 'item_standard', 1, 104, 1, '{}', 'Fresh and tender beef meat.', 0, 0.25),
('beefjerky', 'Beef Jerky', 20, 1, 'item_standard', 1, 105, 1, '{}', 'Dried and seasoned beef meat.', 0, 0.25),
('beer', 'Beer', 10, 1, 'item_standard', 1, 106, 1, '{}', 'An alcoholic beverage brewed from grains.', 0, 0.25),
('beerbox', 'Beer Box', 20, 1, 'item_standard', 1, 107, 1, '{}', 'A container holding multiple bottles of beer.', 0, 0.25),
('bigchest', 'Big Chest', 1, 1, 'item_standard', 1, 108, 1, '{}', 'A large chest for storing items.', 0, 0.25),
('biggame', 'Big Game Meat', 20, 1, 'item_standard', 1, 109, 1, '{}', 'Meat obtained from a large game animal.', 0, 0.25),
('Big_Leather', 'Big Leather', 10, 1, 'item_standard', 1, 110, 1, '{}', 'Large piece of leather.', 0, 0.25),
('bird', 'Bird Meat', 20, 1, 'item_standard', 1, 111, 1, '{}', 'Meat obtained from a bird.', 0, 0.25),
('biscuitbox', 'Biscuitbox', 10, 1, 'item_standard', 1, 736, 1, '{}', 'A box of assorted biscuits.', 0, 0.25),
('bisonhorn', 'Bison horn', 20, 1, 'item_standard', 1, 112, 1, '{}', 'A horn obtained from a bison.', 0, 0.25),
('bisons', 'Bison pelt', 20, 1, 'item_standard', 1, 113, 1, '{}', 'A pelt obtained from a bison.', 0, 0.25),
('Bitter_Weed', 'Bitter Weed', 10, 1, 'item_standard', 1, 114, 1, '{}', 'A type of bitter herb.', 0, 0.25),
('Bitter_Weed_Seed', 'Bitter Weed Seed', 10, 1, 'item_standard', 1, 115, 1, '{}', 'A seed that can be planted to grow bitter weed.', 0, 0.25),
('blackberryale', 'Black Berry Ale', 10, 1, 'item_standard', 1, 116, 1, '{}', 'An ale made from blackberries.', 0, 0.25),
('Black_Berry', 'Black Berry', 10, 1, 'item_standard', 1, 117, 1, '{}', 'A small and sweet black-colored berry.', 0, 0.25),
('Black_Berry_Seed', 'Black Berry Seed', 10, 1, 'item_standard', 1, 118, 1, '{}', 'A seed that can be planted to grow blackberries.', 0, 0.25),
('Black_Currant', 'Black Currant', 10, 1, 'item_standard', 1, 119, 1, '{}', 'A small dark purple berry with a tart flavor.', 0, 0.25),
('Black_Currant_Seed', 'Black Currant Seed', 10, 1, 'item_standard', 1, 120, 1, '{}', 'A seed that can be planted to grow black currants.', 0, 0.25),
('blanketbox', 'Blanket Box', 20, 1, 'item_standard', 1, 121, 1, '{}', 'A box used for storing blankets.', 0, 0.25),
('blanket_box', 'Blanket Box', 20, 1, 'item_standard', 1, 122, 1, '{}', 'A box used for storing blankets.', 0, 0.25),
('Blood_Flower', 'Blood Flower', 10, 1, 'item_standard', 1, 123, 1, '{}', 'A type of flower with red petals.', 0, 0.25),
('Blood_Flower_Seed', 'Blood Flower Seed', 10, 1, 'item_standard', 1, 124, 1, '{}', 'A seed that can be planted to grow blood flowers.', 0, 0.25),
('blueberry', 'Blueberry', 10, 1, 'item_standard', 1, 125, 1, '{}', 'A small sweet fruit with a bluish color.', 0, 0.25),
('bluejay_c', 'Blue jay', 20, 1, 'item_standard', 1, 126, 1, '{}', 'A colorful bird known as blue jay.', 0, 0.25),
('bmdresser', 'brown mirror dresser', 20, 1, 'item_standard', 1, 127, 1, '{}', 'A dresser with a brown mirror.', 0, 0.25),
('boarmusk', 'Boar tusk', 20, 1, 'item_standard', 1, 128, 1, '{}', 'A large tusk obtained from a boar.', 0, 0.25),
('boars', 'Boar pelt', 20, 1, 'item_standard', 1, 129, 1, '{}', 'A pelt obtained from a boar.', 0, 0.25),
('boaskin', 'Boa Snake pelt', 20, 1, 'item_standard', 1, 130, 1, '{}', 'A snake skin obtained from a boa.', 0, 0.25),
('boiledegg', 'Boiled Egg', 10, 1, 'item_standard', 1, 131, 1, '{}', 'An egg cooked by boiling.', 0, 0.25),
('bolts', 'Bolts', 10, 1, 'item_standard', 1, 737, 1, '{}', 'Metal bolts often used in construction.', 0, 0.25),
('boobyb', 'Red-footed booby beak', 20, 1, 'item_standard', 1, 132, 1, '{}', 'A beak obtained from a red-footed booby bird.', 0, 0.25),
('boobyf', 'Red-footed booby feather', 20, 1, 'item_standard', 1, 133, 1, '{}', 'A feather obtained from a red-footed booby bird.', 0, 0.25),
('book', 'Book', 5, 1, 'item_standard', 1, 134, 1, '{}', 'A written or printed work consisting of pages.', 0, 0.25),
('bountylicns', 'Bounty Hunter License', 10, 1, 'item_standard', 1, 135, 1, '{}', 'A license granting permission to be a bounty hunter.', 0, 0.25),
('bouquet', 'Bouquet', 1, 1, 'item_standard', 1, 136, 1, '{}', 'A collection of flowers arranged in an artistic way.', 0, 0.25),
('bparrotb', 'Parrot beak', 20, 1, 'item_standard', 1, 137, 1, '{}', 'A beak obtained from a parrot.', 0, 0.25),
('bparrotf', 'Parrot feather', 20, 1, 'item_standard', 1, 138, 1, '{}', 'A feather obtained from a parrot.', 0, 0.25),
('brokenpearlnecklace', 'Broken Pearl Necklace', 10, 1, 'item_standard', 1, 738, 1, '{}', 'A broken pearl necklace.', 0, 0.25),
('buckantler', 'Buck Antlers', 20, 1, 'item_standard', 1, 139, 1, '{}', 'Antlers obtained from a buck.', 0, 0.25),
('bucks', 'Buck skin', 20, 1, 'item_standard', 1, 140, 1, '{}', 'A pelt obtained from a buck.', 0, 0.25),
('bulletscase', 'Bullets Case', 50, 1, 'item_standard', 0, 1044, 1, '{}', 'nice item', 0, 0.25),
('bulletsmould', 'Bullets Mould', 50, 1, 'item_standard', 0, 1045, 1, '{}', 'nice item', 0, 0.25),
('bullhorn', 'Bull horn', 20, 1, 'item_standard', 1, 141, 1, '{}', 'A horn obtained from a bull.', 0, 0.25),
('bulls', 'Bull pelt', 20, 1, 'item_standard', 1, 142, 1, '{}', 'A pelt obtained from a bull.', 0, 0.25),
('Bulrush', 'Bulrush', 10, 1, 'item_standard', 1, 143, 1, '{}', 'A type of tall wetland plant.', 0, 0.25),
('Bulrush_Seed', 'Bulrush Seed', 10, 1, 'item_standard', 1, 144, 1, '{}', 'A seed that can be planted to grow bulrushes.', 0, 0.25),
('bunkbed', 'bunk bed', 20, 1, 'item_standard', 1, 145, 1, '{}', 'A bed with two tiers, designed for multiple occupants.', 0, 0.25),
('Burdock_Root', 'Burdock Root', 10, 1, 'item_standard', 1, 146, 1, '{}', 'The root of a burdock plant, often used for medicinal purposes.', 0, 0.25),
('Burdock_Root_Seed', 'Burdock Root Seed', 10, 1, 'item_standard', 1, 147, 1, '{}', 'A seed that can be planted to grow burdock roots.', 0, 0.25),
('butchertable1', 'Small Butcher Table', 20, 1, 'item_standard', 1, 148, 1, '{}', 'A small table used for butchering animals.', 0, 0.25),
('butchertable2', 'Medium Butcher Table', 20, 1, 'item_standard', 1, 149, 1, '{}', 'A medium-sized table used for butchering animals.', 0, 0.25),
('butchertable3', 'Large Butcher Table', 20, 1, 'item_standard', 1, 150, 1, '{}', 'A large table used for butchering animals.', 0, 0.25),
('bwdresser', 'brown wood dresser', 20, 1, 'item_standard', 1, 151, 1, '{}', 'A dresser made of brown wood.', 0, 0.25),
('camera', 'Camera', 1, 1, 'item_standard', 1, 152, 1, '{}', 'A device used to capture photographs.', 0, 0.25),
('campfire', 'Campfire', 5, 1, 'item_standard', 1, 153, 1, '{}', 'A fire pit used for cooking and warmth during camping.', 0, 0.25),
('candlea', 'Candle', 20, 1, 'item_standard', 1, 154, 1, '{}', 'A wax candle that provides light.', 0, 0.25),
('cane', 'Cane', 1, 1, 'item_standard', 1, 155, 1, '{}', 'A walking stick for support and stability.', 0, 0.25),
('canteen', 'Canteen', 1, 1, 'item_standard', 1, 1005, 1, '{}', 'A portable container to carry water.', 0, 0.25),
('cardinal_c', 'Cardinal bird', 20, 1, 'item_standard', 1, 156, 1, '{}', 'A small, colorful bird known for its distinctive crest.', 0, 0.25),
('Cardinal_Flower', 'Cardinal Flower', 10, 1, 'item_standard', 1, 157, 1, '{}', 'A vibrant red flower often found near water.', 0, 0.25),
('Cardinal_Flower_Seed', 'Cardinal Flower Seed', 10, 1, 'item_standard', 1, 158, 1, '{}', 'A seed that can be planted to grow Cardinal Flowers.', 0, 0.25),
('carrots', 'Carrot', 10, 1, 'item_standard', 1, 159, 1, '{}', 'An orange root vegetable commonly used in cooking.', 0, 0.25),
('cedarwaxwing_c', 'Cedar waxwing', 20, 1, 'item_standard', 1, 160, 1, '{}', 'A medium-sized bird with a distinctive crest and red tips on its wings.', 0, 0.25),
('Chanterelles', 'Chanterelles', 10, 1, 'item_standard', 1, 161, 1, '{}', 'A type of edible mushroom with a fruity aroma.', 0, 0.25),
('Chanterelles_Seed', 'Chanterelles Seed', 10, 1, 'item_standard', 1, 162, 1, '{}', 'A seed that can be planted to grow Chanterelles mushrooms.', 0, 0.25),
('char', 'Char', 10, 1, 'item_standard', 0, 163, 1, '{}', 'A type of fish commonly found in cold, deep lakes and rivers.', 0, 0.25),
('cheesecake', 'Cheesecake', 10, 1, 'item_standard', 1, 739, 1, '{}', 'A tasty cheesecake.', 0, 0.25),
('chestc', 'Chest C', 20, 1, 'item_standard', 1, 164, 1, '{}', 'A storage container used to store items securely.', 0, 0.25),
('chewingtobacco', 'Chewing Tobacco', 20, 1, 'item_standard', 1, 165, 1, '{}', 'A form of tobacco that is chewed rather than smoked.', 0, 0.25),
('chickenf', 'Chicken feather', 20, 1, 'item_standard', 1, 166, 1, '{}', 'A feather obtained from a chicken.', 0, 0.25),
('chickenheart', 'Chicken heart', 20, 1, 'item_standard', 1, 167, 1, '{}', 'The internal organ of a chicken.', 0, 0.25),
('chipmunk_c', 'Chipmunk', 20, 1, 'item_standard', 1, 168, 1, '{}', 'A small, striped rodent known for its burrowing habits.', 0, 0.25),
('chococake', 'Chocolate Cake', 10, 1, 'item_standard', 1, 740, 1, '{}', 'A tasty chocolate cake.', 0, 0.25),
('Choc_Daisy', 'Choc Daisy', 10, 1, 'item_standard', 1, 169, 1, '{}', 'A beautiful Choc Daisy.', 0, 0.25),
('Choc_Daisy_Seed', 'Choc Daisy Seed', 10, 1, 'item_standard', 1, 170, 1, '{}', 'A seed to grow Choc Daisies.', 0, 0.25),
('cigar', 'Cigar', 20, 1, 'item_standard', 1, 171, 1, '{}', 'A fine cigar for relaxing.', 0, 0.25),
('cigarette', 'Cigarette', 20, 1, 'item_standard', 1, 172, 1, '{}', 'A cigarette for a quick smoke.', 0, 0.25),
('cigarettefilter', 'Cig Filter', 20, 1, 'item_standard', 1, 173, 1, '{}', 'A filter for cigarettes.', 0, 0.25),
('cinematicket', 'Ticket', 2, 1, 'item_standard', 0, 174, 1, '{}', 'A ticket for a movie or event.', 0, 0.25),
('clay', 'Clay', 20, 1, 'item_standard', 1, 175, 1, '{}', 'A block of clay for crafting.', 0, 0.25),
('cleanser', 'Cleanser', 5, 1, 'item_standard', 1, 176, 1, '{}', 'A cleanser for various uses.', 0, 0.25),
('cloth', 'Cloth', 10, 1, 'item_standard', 1, 741, 1, '{}', 'Simple cloth with many uses.', 0, 0.25),
('clothbench', 'Cloth Bench', 20, 1, 'item_standard', 1, 177, 1, '{}', 'A bench made of cloth material.', 0, 0.25),
('clothesline', 'Clothes Line', 20, 1, 'item_standard', 1, 178, 1, '{}', 'A line for hanging clothes.', 0, 0.25),
('clothes_line', 'Clothes Line', 20, 1, 'item_standard', 1, 179, 1, '{}', 'A line for hanging clothes.', 0, 0.25),
('cloth_bench', 'Cloth Bench', 20, 1, 'item_standard', 1, 180, 1, '{}', 'A bench made of cloth material.', 0, 0.25),
('coal', 'Coal', 20, 1, 'item_standard', 1, 181, 1, '{}', 'A chunk of coal for fuel.', 0, 0.25),
('cockc', 'Rooster claws', 20, 1, 'item_standard', 1, 182, 1, '{}', 'Claws from a rooster.', 0, 0.25),
('cockf', 'Rooster feather', 20, 1, 'item_standard', 1, 183, 1, '{}', 'Feathers from a rooster.', 0, 0.25),
('cocoa', 'Cocoa', 20, 1, 'item_standard', 1, 184, 1, '{}', 'Cocoa beans for making chocolate.', 0, 0.25),
('cocoaseeds', 'Cocoa Seeds', 10, 1, 'item_standard', 1, 185, 1, '{}', 'Seeds to grow cocoa plants.', 0, 0.25),
('coffeebeans', 'Coffee Beans', 10, 1, 'item_standard', 1, 742, 1, '{}', 'Coffee beans for making that beautiful brew.', 0, 0.25),
('coffeefilter', 'Coffee Filter', 10, 1, 'item_standard', 1, 743, 1, '{}', 'A simple coffee filter.', 0, 0.25),
('coffindecor', 'Coffin Decor', 20, 1, 'item_standard', 1, 186, 1, '{}', 'Decorations for a coffin.', 0, 0.25),
('collector_fossil_bivalve', 'Bivalve Fossil', 10, 1, 'item_standard', 1, 744, 1, '{}', 'A common fossilized mollusc, badly worn.', 0, 0.25),
('collector_fossil_brachiopod', 'Brachiopod Fossil', 10, 1, 'item_standard', 1, 745, 1, '{}', 'A common Brachiopod fossil with some chips and scrapes.', 0, 0.25),
('collector_fossil_brow_horn', 'Brow Horn Fossil', 10, 1, 'item_standard', 1, 746, 1, '{}', 'A rare fossilized brow horn, believed to have belonged to a Triceratops.', 0, 0.25),
('collector_fossil_cephalopod', 'Cephalopod Fossil', 10, 1, 'item_standard', 1, 747, 1, '{}', 'A common cephalopod fossil. Slightly damaged and brittle.', 0, 0.25),
('collector_fossil_coral', 'Agatized Coral Fossil', 10, 1, 'item_standard', 1, 748, 1, '{}', 'A common piece of agatized coral, weather-beaten but still striking.', 0, 0.25),
('collector_fossil_neo', 'Neospirifer Fossil', 10, 1, 'item_standard', 1, 749, 1, '{}', 'A common Neospirifer fossil, millions of years old. Good condition.', 0, 0.25),
('collector_fossil_pet_wood', 'Common Petrified Wood Fossil', 10, 1, 'item_standard', 1, 750, 1, '{}', 'A common chunk of wood turned to stone over the years.', 0, 0.25),
('collector_fossil_pet_wood_rainbow', 'Rainbow Petrified Wood Fossil', 10, 1, 'item_standard', 1, 751, 1, '{}', 'An uncommon piece of petrified wood filled with multicolored crystals.', 0, 0.25),
('collector_fossil_pet_wood_yellow_cat', 'Yellow Cat Petrified Wood Fossil', 10, 1, 'item_standard', 1, 752, 1, '{}', 'An uncommon lump of petrified wood featuring bright red and yellow colors.', 0, 0.25),
('collector_fossil_sea_lily', 'Sea Lily Fossil', 10, 1, 'item_standard', 1, 753, 1, '{}', 'An uncommon fossilized crinoid, a marine animal millions of years old.', 0, 0.25),
('collector_fossil_sea_scorpion', 'Sea Scorpion Fossil', 10, 1, 'item_standard', 1, 754, 1, '{}', 'An uncommon eurypterid fossil in good condition.', 0, 0.25),
('collector_fossil_stone', 'Petoskey Stone Fossil', 10, 1, 'item_standard', 1, 755, 1, '{}', 'A common rock made of fossilized coral. Unpolished.', 0, 0.25),
('collector_fossil_tail_spike', 'Tail Spike Fossil', 10, 1, 'item_standard', 1, 756, 1, '{}', 'A rare fossilized tail spike, thought to have belonged to a Stegosaurus.', 0, 0.25),
('collector_fossil_toe_claw', 'Toe Sickle Claw Fossil', 10, 1, 'item_standard', 1, 757, 1, '{}', 'A rare fossilized claw. Still sharp, it belonged to a genus of Dromaeosauridae.', 0, 0.25),
('collector_fossil_tooth_mega', 'Upper Tooth Fossil', 10, 1, 'item_standard', 1, 758, 1, '{}', 'A rare fossilized tooth from a Megalodon.', 0, 0.25),
('collector_fossil_tooth_serrated', 'Serrated Tooth Fossil', 10, 1, 'item_standard', 1, 759, 1, '{}', 'A rare and jagged fossilized tooth, once belonging to an Allosaurus.', 0, 0.25),
('collector_fossil_tooth_trex', 'Front Tooth Fossil', 10, 1, 'item_standard', 1, 760, 1, '{}', 'A rare fossilized front tooth, perhaps belonging to the recently discovered Manospondylus Gigas. Highly prized.', 0, 0.25),
('collector_fossil_trilobite_crypto', 'Cryptolithus Trilobite Fossil', 10, 1, 'item_standard', 1, 761, 1, '{}', 'A small, uncommon trilobite fossil. Good condition.', 0, 0.25),
('collector_fossil_trilobite_iso', 'Isotelus Trilobite Fossil', 10, 1, 'item_standard', 1, 762, 1, '{}', 'An uncommon fossil of a huge trilobite. Fully intact.', 0, 0.25),
('collector_fossil_tully_monster', 'Tully Monster Fossil', 10, 1, 'item_standard', 1, 763, 1, '{}', 'An uncommon Tullimonstrum fossil, nicely preserved.', 0, 0.25),
('condenser', 'Condenser', 5, 1, 'item_standard', 1, 187, 1, '{}', 'A device used to condense substances.', 0, 0.25),
('condorb', 'Condor beak', 20, 1, 'item_standard', 1, 188, 1, '{}', 'A beak from a condor bird.', 0, 0.25),
('condorf', 'Condor feather', 20, 1, 'item_standard', 1, 189, 1, '{}', 'A beautiful feather from a condor.', 0, 0.25),
('consumable_apple', 'Apple', 10, 1, 'item_standard', 1, 1000, 1, '{}', 'A juicy and delicious fruit.', 0, 0.25),
('consumable_blueberrypie', 'Blueberry Pie', 10, 1, 'item_standard', 1, 764, 1, '{}', 'A delicious pie made with blueberries.', 0, 0.25),
('consumable_bluegil', 'Dried Bluegil', 10, 1, 'item_standard', 1, 190, 1, '{}', 'A dried Bluegil fish.', 0, 0.25),
('consumable_breakfast', 'Breakfast', 5, 1, 'item_standard', 1, 191, 1, '{}', 'A hearty breakfast meal.', 0, 0.25),
('consumable_caramel', 'Caramel', 5, 1, 'item_standard', 1, 192, 1, '{}', 'Sweet and sticky caramel.', 0, 0.25),
('consumable_carrots', 'Carrots', 10, 1, 'item_standard', 1, 1001, 1, '{}', 'An orange root vegetable commonly used in cooking.', 0, 0.25),
('consumable_chickenpie', 'Chicken Pie', 10, 1, 'item_standard', 1, 765, 1, '{}', 'A delicious pie made with chicken.', 0, 0.25),
('consumable_chocolate', 'Chocolate Bar', 10, 1, 'item_standard', 1, 193, 1, '{}', 'A delicious chocolate bar.', 0, 0.25),
('consumable_chocolatecake', 'Chocolate Cake', 10, 1, 'item_standard', 1, 766, 1, '{}', 'A tasty chocolate cake.', 0, 0.25),
('consumable_chocolatecoffee', 'Chocolate Coffee', 10, 1, 'item_standard', 1, 767, 1, '{}', 'A chocolate flaverd coffee drink.', 0, 0.25),
('consumable_coffee', 'Coffee', 5, 1, 'item_standard', 1, 194, 1, '{}', 'A warm cup of coffee.', 0, 0.25),
('consumable_coffeecake', 'Coffee Cake', 10, 1, 'item_standard', 1, 768, 1, '{}', 'A delicious coffee cake.', 0, 0.25),
('consumable_crumbcake', 'Crumb Cake', 10, 1, 'item_standard', 1, 769, 1, '{}', 'A delicious crumb cake.', 0, 0.25),
('consumable_cupcake', 'Cupcake', 10, 1, 'item_standard', 1, 770, 1, '{}', 'A delicious cupcake.', 0, 0.25),
('consumable_donut', 'Donut', 10, 1, 'item_standard', 1, 771, 1, '{}', 'A tasty donut.', 0, 0.25),
('consumable_fruitsalad', 'Fruit Salad', 5, 1, 'item_standard', 1, 195, 1, '{}', 'A refreshing fruit salad.', 0, 0.25),
('consumable_game', 'Jerkied GameMeat', 10, 1, 'item_standard', 1, 196, 1, '{}', 'Dried and seasoned game meat.', 0, 0.25),
('consumable_grapejelly', 'Grape Jelly', 10, 1, 'item_standard', 1, 772, 1, '{}', 'Grape flavored jelly.', 0, 0.25),
('consumable_haycube', 'Haycube', 10, 1, 'item_standard', 1, 197, 1, '{}', 'A compact cube of hay.', 0, 0.25),
('consumable_herb_chanterelles', 'Chanterelles', 10, 1, 'item_standard', 1, 198, 1, '{}', 'A bundle of Chanterelle mushrooms.', 0, 0.25),
('consumable_herb_evergreen_huckleberry', 'Evergreen Huckleberry', 10, 1, 'item_standard', 1, 199, 1, '{}', 'Plump and juicy Evergreen Huckleberries.', 0, 0.25),
('consumable_herb_oregano', 'Oregano', 10, 1, 'item_standard', 1, 200, 1, '{}', 'Fragrant oregano leaves.', 0, 0.25),
('consumable_herb_vanilla_flower', 'Vanilla Flower', 10, 1, 'item_standard', 1, 201, 1, '{}', 'A delicate vanilla flower.', 0, 0.25),
('consumable_herb_wintergreen_berry', 'Wintergreen Berry', 10, 1, 'item_standard', 1, 202, 1, '{}', 'Tart and refreshing Wintergreen Berries.', 0, 0.25),
('consumable_horsepeppermints', 'Peppermint Stick', 10, 1, 'item_standard', 1, 773, 1, '{}', 'Peppermint flavored candy stick.', 0, 0.25),
('consumable_horse_reviver', 'Horse Reviver', 3, 1, 'item_standard', 1, 999, 1, '{}', 'Curative compound for injured horse.', 0, 0.25),
('consumable_kidneybeans_can', 'Kidney Beans', 5, 1, 'item_standard', 1, 203, 1, '{}', 'Canned kidney beans.', 0, 0.25),
('consumable_lemoncake', 'Lemon Cake', 10, 1, 'item_standard', 1, 774, 1, '{}', 'A delicious lemon cake', 0, 0.25),
('consumable_lemondrops', 'Leamon Drops', 10, 1, 'item_standard', 1, 775, 1, '{}', 'Lemon flavored candy.', 0, 0.25),
('consumable_lock_breaker', 'Lock Breaker', 10, 1, 'item_standard', 1, 204, 1, '{}', 'A tool for breaking locks.', 0, 0.25),
('consumable_meat_greavy', 'Meat Stew', 12, 1, 'item_standard', 1, 205, 1, '{}', 'A hearty meat stew.', 0, 0.25),
('consumable_medicine', 'Medicine', 10, 1, 'item_standard', 1, 206, 1, '{}', 'Medicinal treatment.', 0, 0.25),
('consumable_peach', 'Peach', 5, 1, 'item_standard', 1, 207, 1, '{}', 'Juicy and ripe peach.', 0, 0.25),
('consumable_peachcobbler', 'Peach Cobbler', 10, 1, 'item_standard', 1, 776, 1, '{}', 'A tasty peach cobbler.', 0, 0.25),
('consumable_peachjelly', 'Peach Jelly', 10, 1, 'item_standard', 1, 777, 1, '{}', 'Peach flavored jelly.', 0, 0.25),
('consumable_pear', 'Pear', 10, 1, 'item_standard', 1, 208, 1, '{}', 'A sweet and juicy pear.', 0, 0.25),
('consumable_peppermint', 'Peppermint', 10, 1, 'item_standard', 1, 778, 1, '{}', 'Peppermint flavored candy.', 0, 0.25),
('consumable_poundcake', 'Pound Cake', 10, 1, 'item_standard', 1, 779, 1, '{}', 'A delicious pound cake.', 0, 0.25),
('consumable_pretzel', 'Pretzel', 10, 1, 'item_standard', 1, 780, 1, '{}', 'A tasty pretzel with salt.', 0, 0.25),
('consumable_raspberryjelly', 'Raspberry Jelly', 10, 1, 'item_standard', 1, 781, 1, '{}', 'Raspberry flavored jelly.', 0, 0.25),
('consumable_raspberrywater', 'Berry Water', 10, 1, 'item_standard', 1, 209, 1, '{}', 'Refreshing water infused with berries.', 0, 0.25),
('consumable_salmon', 'Dried Salmon', 10, 1, 'item_standard', 1, 210, 1, '{}', 'A dried and preserved salmon.', 0, 0.25),
('consumable_salmon_can', 'Salmon Can', 10, 1, 'item_standard', 1, 211, 1, '{}', 'Canned salmon.', 0, 0.25),
('consumable_spongecake', 'Sponge Cake', 10, 1, 'item_standard', 1, 782, 1, '{}', 'A soft and delicious spong cake.', 0, 0.25),
('consumable_steakpie', 'Steak Pie', 10, 1, 'item_standard', 1, 783, 1, '{}', 'A delicious pie made with beef.', 0, 0.25),
('consumable_trout', 'Cooked Trout', 10, 1, 'item_standard', 1, 212, 1, '{}', 'A cooked and seasoned trout.', 0, 0.25),
('consumable_veggies', 'Edible Veggies', 5, 1, 'item_standard', 1, 213, 1, '{}', 'A mix of various edible vegetables.', 0, 0.25),
('cookedbluegil', 'Cooked Bluegil with Veggies', 5, 1, 'item_standard', 1, 214, 1, '{}', 'A cooked Bluegil fish served with vegetables.', 0, 0.25),
('copper', 'Copper', 30, 1, 'item_standard', 1, 215, 1, '{}', 'A piece of copper.', 0, 0.25),
('copperbar', 'Copper Bar', 50, 1, 'item_standard', 0, 1048, 1, '{}', 'nice item', 0, 0.25),
('cordbow', 'Bow Cord', 10, 1, 'item_standard', 1, 784, 1, '{}', 'Cord used for making a bow.', 0, 0.25),
('corn', 'Corn', 10, 1, 'item_standard', 1, 216, 1, '{}', 'Fresh and juicy corn.', 0, 0.25),
('cornseed', 'Corn seed', 10, 1, 'item_standard', 1, 217, 1, '{}', 'Seeds for growing corn.', 0, 0.25),
('cougarf', 'Cougar tooth', 20, 1, 'item_standard', 1, 218, 1, '{}', 'A sharp tooth from a cougar.', 0, 0.25),
('cougars', 'Cougar skin', 20, 1, 'item_standard', 1, 219, 1, '{}', 'The thick and durable skin of a cougar.', 0, 0.25),
('cougartaxi', 'Cougar Taxidermy', 20, 1, 'item_standard', 1, 220, 1, '{}', 'A taxidermy mount of a cougar.', 0, 0.25),
('cougar_taxidermy', 'Cougar Taxidermy', 20, 1, 'item_standard', 1, 221, 1, '{}', 'A taxidermy mount of a cougar.', 0, 0.25),
('cowh', 'Cow horn', 20, 1, 'item_standard', 1, 222, 1, '{}', 'A long and curved horn from a cow.', 0, 0.25),
('cows', 'Cow pelt', 20, 1, 'item_standard', 1, 223, 1, '{}', 'The soft and furry pelt of a cow.', 0, 0.25),
('coyotef', 'Coyote tooth', 20, 1, 'item_standard', 1, 224, 1, '{}', 'A sharp tooth from a coyote.', 0, 0.25),
('coyotepelt', 'Coyote Pelt', 20, 1, 'item_standard', 1, 225, 1, '{}', 'The fur pelt of a coyote.', 0, 0.25),
('coyotes', 'Coyote skin', 20, 1, 'item_standard', 1, 226, 1, '{}', 'The rugged and weathered skin of a coyote.', 0, 0.25),
('coyotetaxi', 'Coyote Taxidermy', 20, 1, 'item_standard', 1, 227, 1, '{}', 'A taxidermy mount of a coyote.', 0, 0.25),
('coyote_pelt', 'Coyote Pelt', 20, 1, 'item_standard', 1, 228, 1, '{}', 'The fur pelt of a coyote.', 0, 0.25),
('coyote_taxidermy', 'Coyote Taxidermy', 20, 1, 'item_standard', 1, 229, 1, '{}', 'A taxidermy mount of a coyote.', 0, 0.25),
('crabbutter', 'Crab Butter', 10, 1, 'item_standard', 1, 785, 1, '{}', 'Butter made from crab. Delicious on toast.', 0, 0.25),
('crablegs', 'Crab Legs', 10, 1, 'item_standard', 1, 786, 1, '{}', 'Legs from a crab.', 0, 0.25),
('crab_c', 'Crab', 20, 1, 'item_standard', 1, 230, 1, '{}', 'A crab with a hard shell.', 0, 0.25),
('craftingfire', 'Crafting Fire', 20, 1, 'item_standard', 1, 231, 1, '{}', 'A fire used for crafting.', 0, 0.25),
('crafting_fire', 'Crafting Fire', 20, 1, 'item_standard', 1, 232, 1, '{}', 'A fire used for crafting.', 0, 0.25),
('crawfish_c', 'Crawfish', 20, 1, 'item_standard', 1, 233, 1, '{}', 'A small freshwater crustacean.', 0, 0.25),
('Creeking_Thyme', 'Creeping Thyme', 10, 1, 'item_standard', 1, 234, 1, '{}', 'A fragrant herb with small purple flowers.', 0, 0.25),
('Creeking_Thyme_Seed', 'Creeping Thyme Seed', 10, 1, 'item_standard', 1, 235, 1, '{}', 'Seeds for growing creeping thyme.', 0, 0.25),
('Creekplum', 'Creekplum', 10, 1, 'item_standard', 1, 236, 1, '{}', 'A small and juicy creekplum.', 0, 0.25),
('Creekplum_Seed', 'Creekplum Seed', 10, 1, 'item_standard', 1, 237, 1, '{}', 'Seeds for growing creekplums.', 0, 0.25),
('Crows_Garlic', 'Crows Garlic', 10, 1, 'item_standard', 1, 238, 1, '{}', 'A pungent garlic with black bulbs.', 0, 0.25),
('Crows_Garlic_Seed', 'Crows Garlic Seed', 10, 1, 'item_standard', 1, 239, 1, '{}', 'Seeds for growing crows garlic.', 0, 0.25),
('crow_c', 'Crow', 20, 1, 'item_standard', 1, 240, 1, '{}', 'A black-feathered bird with a sharp beak.', 0, 0.25),
('darub', 'Crane beak', 20, 1, 'item_standard', 1, 241, 1, '{}', 'A long and slender beak from a crane.', 0, 0.25),
('daruf', 'Crane feather', 20, 1, 'item_standard', 1, 242, 1, '{}', 'A beautiful feather from a crane.', 0, 0.25),
('dbcandle', 'Dbl Candle', 20, 1, 'item_standard', 1, 243, 1, '{}', 'A double-sided candle with two wicks.', 0, 0.25),
('decortent1', 'Decor Tent 1 Set', 20, 1, 'item_standard', 1, 244, 1, '{}', 'A decorative tent set with unique patterns.', 0, 0.25),
('decortent2', 'Decor Tent 2 Set', 20, 1, 'item_standard', 1, 245, 1, '{}', 'A decorative tent set with unique patterns.', 0, 0.25),
('decortent3', 'Decor Tent 3 Set', 20, 1, 'item_standard', 1, 246, 1, '{}', 'A decorative tent set with unique patterns.', 0, 0.25),
('deerheart', 'Deer heart', 20, 1, 'item_standard', 1, 247, 1, '{}', 'The heart of a deer.', 0, 0.25),
('deerpelt', 'Deer pelt', 20, 1, 'item_standard', 1, 248, 1, '{}', 'The soft and warm pelt of a deer.', 0, 0.25),
('deerskin', 'Deer skin', 20, 1, 'item_standard', 1, 249, 1, '{}', 'The skin of a deer.', 0, 0.25),
('deertaxi', 'Deer Taxidermy', 20, 1, 'item_standard', 1, 250, 1, '{}', 'A taxidermy mount of a deer.', 0, 0.25),
('deer_pelt', 'Deer Pelt', 20, 1, 'item_standard', 1, 251, 1, '{}', 'The soft and warm pelt of a deer.', 0, 0.25),
('deer_taxidermy', 'Deer Taxidermy', 20, 1, 'item_standard', 1, 252, 1, '{}', 'A taxidermy mount of a deer.', 0, 0.25),
('Desert_Sage', 'Desert Sage', 10, 1, 'item_standard', 1, 253, 1, '{}', 'A bundle of Desert Sage used for crafting and medicinal purposes.', 0, 0.25),
('Desert_Sage_Seed', 'Desert Sage Seed', 10, 1, 'item_standard', 1, 254, 1, '{}', 'A seed of Desert Sage that can be planted to grow Desert Sage plants.', 0, 0.25),
('diamond', 'Diamond', 20, 1, 'item_standard', 1, 255, 1, '{}', 'A precious gemstone known for its brilliance and value.', 0, 0.25),
('dleguans', 'Desert Iguana pelt', 20, 1, 'item_standard', 1, 256, 1, '{}', 'The skin of a Desert Iguana, commonly used for crafting and trading.', 0, 0.25),
('dreamcatcher', 'Dream Catcher', 20, 1, 'item_standard', 1, 257, 1, '{}', 'A traditional Native American ornament believed to filter out bad dreams and let only good dreams pass through.', 0, 0.25),
('Drink_For_Dog', 'Pet Water', 10, 1, 'item_standard', 1, 258, 1, '{}', 'A refreshing drink specially made for pets to keep them hydrated.', 0, 0.25),
('duckfat', 'Duck fat', 20, 1, 'item_standard', 1, 259, 1, '{}', 'The rendered fat from a duck, commonly used in cooking and baking.', 0, 0.25),
('Duck_Egg', 'Duck Egg', 10, 1, 'item_standard', 1, 260, 1, '{}', 'An egg laid by a duck, often used in various culinary preparations.', 0, 0.25),
('dynamite', 'Pipe charge dynamite', 30, 1, 'item_standard', 1, 261, 1, '{}', 'An explosive device consisting of a tube filled with explosive material, used for various purposes including mining and demolition.', 0, 0.25),
('dynamitebundle', 'Dynamite Bundle', 10, 1, 'item_standard', 0, 1067, 1, '{}', 'nice item', 0, 0.25),
('eaglef', 'Eagle feather', 20, 1, 'item_standard', 1, 262, 1, '{}', 'A feather obtained from an eagle, often used for decorative purposes and in crafting.', 0, 0.25),
('eaglet', 'Eagle claws', 20, 1, 'item_standard', 1, 263, 1, '{}', 'The sharp claws of an eagle, sometimes collected as a trophy or used in traditional medicine.', 0, 0.25),
('egg', 'Egg', 20, 1, 'item_standard', 1, 264, 1, '{}', 'A small oval object laid by a female bird, reptile, or fish, containing a fertilized embryo and nutrients for development.', 0, 0.25),
('eggs', 'Egg', 50, 1, 'item_standard', 1, 265, 1, '{}', 'Various types of eggs collected from different animals, often used in cooking and crafting.', 0, 0.25),
('egretb', 'Snowy Egret beak', 20, 1, 'item_standard', 1, 266, 1, '{}', 'The beak of a Snowy Egret, commonly used for crafting and trading.', 0, 0.25),
('egretf', 'Snowy Egret feather', 20, 1, 'item_standard', 1, 267, 1, '{}', 'A feather obtained from a Snowy Egret, often used for decorative purposes and in crafting.', 0, 0.25),
('elkantler', 'Elk antler', 20, 1, 'item_standard', 1, 268, 1, '{}', 'A large branched horn-like appendage grown by male elks.', 0, 0.25),
('elks', 'Elk pelt', 20, 1, 'item_standard', 1, 269, 1, '{}', 'A high-quality pelt obtained from an elk.', 0, 0.25),
('emerald', 'Emerald', 20, 1, 'item_standard', 1, 270, 1, '{}', 'A precious green gemstone with a sparkling appearance.', 0, 0.25),
('empty_bottle', 'Empty Bottle', 20, 1, 'item_standard', 1, 271, 1, '{}', 'Empty Bottle', 0, 0.25),
('empty_mud_bucket', 'Empty mud bucket', 20, 1, 'item_standard', 1, 1062, 1, '{}', 'nice item', 0, 0.25),
('English_Mace', 'English Mace', 10, 1, 'item_standard', 1, 272, 1, '{}', 'A type of spice commonly used in cooking and herbal medicine.', 0, 0.25),
('English_Mace_Seed', 'English Mace Seed', 10, 1, 'item_standard', 1, 273, 1, '{}', 'Seeds that can be planted to grow English Mace plants.', 0, 0.25),
('Evergreen_Huckleberry', 'Evergreen Huckleberry', 10, 1, 'item_standard', 1, 274, 1, '{}', 'A small, dark purple berry known for its tart and sweet flavor.', 0, 0.25),
('Evergreen_Huckleberry_Seed', 'Evergreen Huckleberry Seed', 10, 1, 'item_standard', 1, 275, 1, '{}', 'Seeds that can be planted to grow Evergreen Huckleberry bushes.', 0, 0.25),
('fan', 'Fan', 5, 1, 'item_standard', 1, 276, 1, '{}', 'A handheld device with flat blades used to create a breeze or provide cooling.', 0, 0.25),
('fancydouble', 'Fancy Double', 20, 1, 'item_standard', 1, 277, 1, '{}', 'A stylish and well-crafted double-barreled firearm.', 0, 0.25),
('Fat', 'Animal Fat', 10, 1, 'item_standard', 1, 278, 1, '{}', 'Rendered fat obtained from animals, commonly used in cooking and crafting.', 0, 0.25),
('Feather', 'Feather', 20, 1, 'item_standard', 1, 279, 1, '{}', 'A lightweight and delicate feather, often used for decorative purposes.', 0, 0.25),
('Feed_For_Dog', 'Dog Food', 10, 1, 'item_standard', 1, 280, 1, '{}', 'Nutritious food specifically formulated for dogs.', 0, 0.25),
('fertilizer', 'Fertilizer', 10, 1, 'item_standard', 1, 281, 1, '{}', 'A substance used to enrich soil and promote plant growth.', 0, 0.25),
('fertilizer1', 'Fertilizer Grade C', 10, 1, 'item_standard', 1, 1013, 1, '{}', 'Low grade fertilizer.', 0, 0.25),
('fertilizer2', 'Fertilizer Grade B', 10, 1, 'item_standard', 1, 1014, 1, '{}', 'Mid grade fertilizer.', 0, 0.25),
('fertilizer3', 'Fertilizer Grade A', 10, 1, 'item_standard', 1, 1015, 1, '{}', 'High grade fertilizer.', 0, 0.25),
('fertilizerbless', 'Blessed Fertilizer', 10, 1, 'item_standard', 1, 282, 1, '{}', 'Sacred fertilizer imbued with spiritual blessings, known to enhance crop yield.', 0, 0.25),
('fertilizeregg', 'Fertilizer with Eggs', 10, 1, 'item_standard', 1, 283, 1, '{}', 'Fertilizer enriched with nutrients from various eggs, providing excellent nourishment for plants.', 0, 0.25),
('fertilizerpro', 'Fertilizer with Produce', 10, 1, 'item_standard', 1, 284, 1, '{}', 'Fertilizer containing organic matter from fresh produce, enhancing soil fertility and plant health.', 0, 0.25),
('fertilizerpulpsap', 'Fertilizer with Pulp/Sap', 10, 1, 'item_standard', 1, 285, 1, '{}', 'Fertilizer enriched with natural pulp or sap, promoting robust growth and vitality in plants.', 0, 0.25),
('fertilizersn', 'Fertilizer with Snake', 10, 1, 'item_standard', 1, 286, 1, '{}', 'Fertilizer enriched with beneficial nutrients extracted from snakes, promoting vigorous growth in plants.', 0, 0.25),
('fertilizersq', 'Fertilizer with Squirrel', 10, 1, 'item_standard', 1, 287, 1, '{}', 'Fertilizer infused with nutrients derived from squirrels, providing essential elements for plant nourishment and vitality.', 0, 0.25),
('fertilizersw', 'Fertilizer with Soft Wood', 10, 1, 'item_standard', 1, 288, 1, '{}', 'Fertilizer blended with fine particles of softwood, enriching the soil with organic matter and enhancing plant development.', 0, 0.25),
('fertilizersyn', 'Synful Fertilizer', 10, 1, 'item_standard', 1, 289, 1, '{}', 'A potent and forbidden fertilizer concocted from mystical ingredients, known to produce extraordinary growth in plants.', 0, 0.25),
('fertilizerwoj', 'Fertilizer with Wojape', 10, 1, 'item_standard', 1, 290, 1, '{}', 'Fertilizer infused with the essence of Wojape, a rare and powerful herb known for its profound effects on plant growth.', 0, 0.25),
('fibers', 'Fibers', 20, 1, 'item_standard', 0, 291, 1, '{}', 'Fine threads or filaments extracted from plants or animals, often used for crafting or weaving.', 0, 0.25),
('fish', 'Fish', 50, 1, 'item_standard', 1, 292, 1, '{}', 'A aquatic creature with fins and scales, commonly caught for food or sport.', 0, 0.25),
('fishbait', 'Fishbait', 10, 1, 'item_standard', 1, 293, 1, '{}', 'A substance or lure used to attract fish, increasing the chances of a successful catch.', 0, 0.25),
('fishchips', 'Fish and Chips', 10, 1, 'item_standard', 1, 294, 1, '{}', 'A classic dish consisting of fried fish fillets and potato chips, often served with tartar sauce.', 0, 0.25),
('fishmeat', 'Bigfish Meat', 20, 1, 'item_standard', 1, 295, 1, '{}', 'Meat obtained from large fish species, known for its tender texture and rich flavor.', 0, 0.25),
('flag', 'Camp Flag', 10, 1, 'item_standard', 1, 296, 1, '{}', 'A colorful and distinctive flag used to mark and identify a campsite or specific location.', 0, 0.25);
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `degradation`, `weight`) VALUES
('flour', 'Flour', 10, 1, 'item_standard', 1, 787, 1, '{}', 'Ground up wheat used for cooking and baking.', 0, 0.25),
('floursack', 'Flour Sack', 10, 1, 'item_standard', 1, 788, 1, '{}', 'A sack of flour.', 0, 0.25),
('flowerboxes', 'Flower Boxes', 20, 1, 'item_standard', 1, 297, 1, '{}', 'Containers or receptacles designed to hold and display blooming flowers, adding beauty and charm to any setting.', 0, 0.25),
('foodbarrel', 'Food Barrel', 20, 1, 'item_standard', 1, 298, 1, '{}', 'A sturdy barrel used for storing and preserving food items, keeping them fresh and safe from pests.', 0, 0.25),
('food_barrel', 'Food Barrel', 20, 1, 'item_standard', 1, 299, 1, '{}', 'A large barrel specifically designed for storing and transporting food, ideal for provisioning during long journeys or expeditions.', 0, 0.25),
('food_craftbook', 'Food Craftbook', 1, 1, 'item_standard', 1, 1019, 1, '{}', 'Used to open the food crafting menu.', 0, 0.25),
('foxskin', 'Foxskin', 20, 1, 'item_standard', 1, 300, 1, '{}', 'The skin of a fox.', 0, 0.25),
('foxt', 'Fox tooth', 20, 1, 'item_standard', 1, 301, 1, '{}', 'A tooth extracted from a fox.', 0, 0.25),
('friedtater', 'Fried Taters', 10, 1, 'item_standard', 1, 302, 1, '{}', 'Crispy and delicious fried potatoes.', 0, 0.25),
('frogbull2_c', 'Poisoned Frogbull', 20, 1, 'item_standard', 1, 303, 1, '{}', 'A toxic variant of a frogbull.', 0, 0.25),
('frogbull_c', 'Frogbull', 20, 1, 'item_standard', 1, 304, 1, '{}', 'A small creature found near water bodies.', 0, 0.25),
('fsnakes', 'Blacktail rattlesnake pelt', 20, 1, 'item_standard', 1, 305, 1, '{}', 'The skin of a blacktail rattlesnake.', 0, 0.25),
('game', 'Game Meat', 20, 1, 'item_standard', 1, 306, 1, '{}', 'Fresh meat obtained from hunting animals.', 0, 0.25),
('Gamey_Meat', 'Gamey Meat', 10, 1, 'item_standard', 1, 307, 1, '{}', 'A type of meat with a distinct gamey flavor.', 0, 0.25),
('Gator_Egg_3', 'Aligator Egg 3', 10, 1, 'item_standard', 1, 308, 1, '{}', 'The third stage of an alligator egg.', 0, 0.25),
('Gator_Egg_4', 'Aligator Egg 4', 10, 1, 'item_standard', 1, 309, 1, '{}', 'The fourth stage of an alligator egg.', 0, 0.25),
('Gator_Egg_5', 'Aligator Egg 5', 10, 1, 'item_standard', 1, 310, 1, '{}', 'The final stage of an alligator egg.', 0, 0.25),
('gbarrelx', 'Gun Barrel', 20, 1, 'item_standard', 1, 311, 1, '{}', 'A part used in firearm manufacturing.', 0, 0.25),
('gbears', 'Grizzly Bear skin', 20, 1, 'item_standard', 1, 312, 1, '{}', 'The skin of a grizzly bear.', 0, 0.25),
('ginsengtea', 'Ginseng Tea', 10, 1, 'item_standard', 1, 313, 1, '{}', 'A soothing tea made from ginseng roots.', 0, 0.25),
('glassbottle', 'Glass Bottle', 15, 1, 'item_standard', 1, 314, 1, '{}', 'A transparent bottle made of glass.', 0, 0.25),
('glasseye', 'Glass Eye', 10, 1, 'item_standard', 1, 789, 1, '{}', 'A glass eye. Probably lost in a bar fight.', 0, 0.25),
('gleguans', 'Green Iguana pelt', 20, 1, 'item_standard', 1, 315, 1, '{}', 'The skin of a green iguana.', 0, 0.25),
('goathead', 'Goat head', 20, 1, 'item_standard', 1, 316, 1, '{}', 'The severed head of a goat.', 0, 0.25),
('goats', 'Goat pelt', 20, 1, 'item_standard', 1, 317, 1, '{}', 'The skin of a goat.', 0, 0.25),
('goldbar', 'GoldBar', 5, 1, 'item_standard', 1, 318, 1, '{}', 'A bar made of solid gold.', 0, 0.25),
('Golden_Currant', 'Golden Currant', 10, 1, 'item_standard', 1, 319, 1, '{}', 'A type of golden-colored currant.', 0, 0.25),
('Golden_Currant_Seed', 'Golden Currant Seed', 10, 1, 'item_standard', 1, 320, 1, '{}', 'A seed that can be planted to grow golden currants.', 0, 0.25),
('goldfish', 'Gold Fish', 10, 1, 'item_standard', 0, 321, 1, '{}', 'A shimmering gold-colored fish.', 0, 0.25),
('goldpan', 'Gold pan', 10, 1, 'item_standard', 1, 322, 1, '{}', 'A shallow pan used for gold panning.', 0, 0.25),
('goldring', 'Gold Ring', 10, 1, 'item_standard', 1, 323, 1, '{}', 'A ring made of solid gold.', 0, 0.25),
('gold_nugget', 'Gold nugget', 30, 1, 'item_standard', 0, 324, 1, '{}', 'A nugget of pure gold.', 0, 0.25),
('gold_panning_license', 'Gold Panning License', 10, 1, 'item_standard', 1, 790, 1, '{}', 'A license to pan gold.', 0, 0.25),
('gooseb', 'Goose beak', 20, 1, 'item_standard', 1, 325, 1, '{}', 'The beak of a goose.', 0, 0.25),
('goosef', 'Goose feather', 20, 1, 'item_standard', 1, 326, 1, '{}', 'A feather obtained from a goose.', 0, 0.25),
('Goose_Egg_4', 'Goose Egg', 10, 1, 'item_standard', 1, 327, 1, '{}', 'An egg laid by a goose.', 0, 0.25),
('grainmill', 'Grain Mill', 10, 1, 'item_standard', 1, 791, 1, '{}', 'A hand-held Grain Mill for grinding grain.', 0, 0.25),
('grapes', 'Grapes', 10, 1, 'item_standard', 1, 792, 1, '{}', 'A tasty fruit that grows in clusters. Often used to make wine.', 0, 0.25),
('grinder', 'Grinder', 10, 1, 'item_standard', 1, 793, 1, '{}', 'Used to crush up and grind herbs and plants.', 0, 0.25),
('guitar', 'Classic Guitar', 1, 1, 'item_standard', 1, 328, 1, '{}', 'A traditional six-string guitar.', 0, 0.25),
('gun_barrel', 'Gun Barrel', 20, 1, 'item_standard', 1, 329, 1, '{}', 'A cylindrical barrel used in firearm construction.', 0, 0.25),
('gypsywagon', 'Gypsys Wagon Set', 20, 1, 'item_standard', 1, 330, 1, '{}', 'A set of items related to a gypsy wagon.', 0, 0.25),
('hairpomade', 'Hair Pomade', 5, 1, 'item_standard', 1, 331, 1, '{}', 'A grooming product for styling hair.', 0, 0.25),
('handcuffkey', 'Handcuff Key', 1, 1, 'item_standard', 1, 959, 1, '{}', 'A key used to unlock handcuffs.', 0, 0.25),
('handcuffs', 'Handcuffs', 10, 1, 'item_standard', 1, 332, 1, '{}', 'Metal restraints used for restraining someone.', 0, 0.25),
('handmixer', 'Handmixer', 10, 1, 'item_standard', 1, 794, 1, '{}', 'A hand-held mixing device', 0, 0.25),
('handsaw', 'Handsaw', 10, 1, 'item_standard', 1, 795, 1, '{}', 'A hand saw used to cut wood', 0, 0.25),
('hatchet', 'Hatchet', 1, 1, 'item_standard', 1, 333, 1, '{}', 'A small axe with a short handle.', 0, 0.25),
('hawkf', 'Hawk feather', 20, 1, 'item_standard', 1, 334, 1, '{}', 'A feather obtained from a hawk.', 0, 0.25),
('hawkt', 'Hawk claws', 20, 1, 'item_standard', 1, 335, 1, '{}', 'The sharp claws of a hawk.', 0, 0.25),
('Health_For_Dog', 'Pet Bandages', 10, 1, 'item_standard', 1, 336, 1, '{}', 'Bandages designed for treating injuries in pets.', 0, 0.25),
('hemp', 'Hemp', 10, 1, 'item_standard', 1, 337, 1, '{}', 'A plant commonly used for its fiber.', 0, 0.25),
('hemp_cig', 'Hemp Cigarette', 1, 1, 'item_standard', 1, 338, 1, '{}', 'A cigarette made from hemp leaves.', 0, 0.25),
('hemp_seed', 'Hemp Seed', 20, 1, 'item_standard', 1, 339, 1, '{}', 'A seed that can be planted to grow hemp plants.', 0, 0.25),
('herbal_medicine', 'Herbal Medicine', 20, 1, 'item_standard', 1, 340, 1, '{}', 'Medicine made from natural herbal ingredients.', 0, 0.25),
('herbal_tonic', 'Herbal Tonic', 20, 1, 'item_standard', 1, 341, 1, '{}', 'A tonic made from herbal extracts.', 0, 0.25),
('herbmed', 'Herbal Remedy', 10, 1, 'item_standard', 1, 342, 1, '{}', 'A remedy made from various herbs.', 0, 0.25),
('heroin', 'Heroin', 5, 1, 'item_standard', 1, 343, 1, '{}', 'A highly addictive and illegal drug.', 0, 0.25),
('herptile', 'Herptile meat', 20, 1, 'item_standard', 1, 344, 1, '{}', 'Meat obtained from reptiles and amphibians.', 0, 0.25),
('hitchingpost', 'Hitching Post', 20, 1, 'item_standard', 1, 345, 1, '{}', 'A post used for tying up horses.', 0, 0.25),
('hk_1', 'House Key', 1, 1, 'item_standard', 1, 961, 1, '{}', 'A standard house key.', 0, 0.25),
('hk_101', 'House Key', 1, 1, 'item_standard', 1, 964, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_102', 'House Key', 1, 1, 'item_standard', 1, 965, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_103', 'House Key', 1, 1, 'item_standard', 1, 966, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_104', 'House Key', 1, 1, 'item_standard', 1, 967, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_105', 'House Key', 1, 1, 'item_standard', 1, 968, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_106', 'House Key', 1, 1, 'item_standard', 1, 969, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_107', 'House Key', 1, 1, 'item_standard', 1, 970, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_108', 'House Key', 1, 1, 'item_standard', 1, 971, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_109', 'House Key', 1, 1, 'item_standard', 1, 972, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_110', 'House Key', 1, 1, 'item_standard', 1, 973, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_111', 'House Key', 1, 1, 'item_standard', 1, 974, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_112', 'House Key', 1, 1, 'item_standard', 1, 975, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_113', 'House Key', 1, 1, 'item_standard', 1, 976, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_114', 'House Key', 1, 1, 'item_standard', 1, 977, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_115', 'House Key', 1, 1, 'item_standard', 1, 978, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_116', 'House Key', 1, 1, 'item_standard', 1, 979, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_117', 'House Key', 1, 1, 'item_standard', 1, 980, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_118', 'House Key', 1, 1, 'item_standard', 1, 981, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_119', 'House Key', 1, 1, 'item_standard', 1, 982, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_120', 'House Key', 1, 1, 'item_standard', 1, 983, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_121', 'House Key', 1, 1, 'item_standard', 1, 984, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_122', 'House Key', 1, 1, 'item_standard', 1, 985, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_123', 'House Key', 1, 1, 'item_standard', 1, 986, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_124', 'House Key', 1, 1, 'item_standard', 1, 987, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_125', 'House Key', 1, 1, 'item_standard', 1, 988, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_126', 'House Key', 1, 1, 'item_standard', 1, 989, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_127', 'House Key', 1, 1, 'item_standard', 1, 990, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_128', 'House Key', 1, 1, 'item_standard', 1, 991, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_129', 'House Key', 1, 1, 'item_standard', 1, 992, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_130', 'House Key', 1, 1, 'item_standard', 1, 993, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_131', 'House Key', 1, 1, 'item_standard', 1, 994, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_132', 'House Key', 1, 1, 'item_standard', 1, 995, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_133', 'House Key', 1, 1, 'item_standard', 1, 996, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_134', 'House Key', 1, 1, 'item_standard', 1, 997, 1, '{}', 'A specialized house key.', 0, 0.25),
('hk_2', 'House Key', 1, 1, 'item_standard', 1, 962, 1, '{}', 'A standard house key.', 0, 0.25),
('hk_3', 'House Key', 1, 1, 'item_standard', 1, 963, 1, '{}', 'A standard house key.', 0, 0.25),
('hoe', 'Garden Hoe', 10, 1, 'item_standard', 1, 346, 1, '{}', 'A gardening tool with a thin metal blade.', 0, 0.25),
('honey', 'Honey', 10, 1, 'item_standard', 1, 347, 1, '{}', 'A sweet and sticky substance produced by bees.', 0, 0.25),
('hop', 'Hop', 10, 1, 'item_standard', 1, 348, 1, '{}', 'A plant used in brewing beer.', 0, 0.25),
('hop_seed', 'Hop Seed', 10, 1, 'item_standard', 1, 349, 1, '{}', 'A seed that can be planted to grow hop plants.', 0, 0.25),
('horsebrush', 'Horse Brush', 5, 1, 'item_standard', 1, 350, 1, '{}', 'A brush used for grooming horses.', 0, 0.25),
('horsehitches', 'Horse Hitches Set', 20, 1, 'item_standard', 1, 351, 1, '{}', 'A set of items used for hitching horses.', 0, 0.25),
('horsemeal', 'Horse ration', 10, 1, 'item_standard', 1, 352, 1, '{}', 'Food provided to horses for sustenance.', 0, 0.25),
('Hummingbird_Sage', 'Hummingbird Sage', 10, 1, 'item_standard', 1, 353, 1, '{}', 'A type of sage plant favored by hummingbirds.', 0, 0.25),
('Hummingbird_Sage_Seed', 'Hummingbird Sage Seed', 10, 1, 'item_standard', 1, 354, 1, '{}', 'A seed that can be planted to grow hummingbird sage.', 0, 0.25),
('hwood', 'Hard Wood', 20, 1, 'item_standard', 0, 355, 1, '{}', 'Durable and strong wood used in various applications.', 0, 0.25),
('iguanabits', 'Iguana Bits', 10, 1, 'item_standard', 1, 796, 1, '{}', 'Tasy cooked Iguna pieces.', 0, 0.25),
('Indian_Tobbaco', 'Indian Tobbaco', 20, 1, 'item_standard', 1, 356, 1, '{}', 'A type of tobacco used by Native Americans.', 0, 0.25),
('Indian_Tobbaco_Seed', 'Indian Tobbaco Seed', 10, 1, 'item_standard', 1, 357, 1, '{}', 'A seed that can be planted to grow Indian tobbaco plants.', 0, 0.25),
('ink', 'Ink', 10, 1, 'item_standard', 1, 797, 1, '{}', 'A small bottle of ink.', 0, 0.25),
('iron', 'Iron', 30, 1, 'item_standard', 0, 358, 1, '{}', 'A strong and durable metal.', 0, 0.25),
('ironbar', 'Iron Bar', 30, 1, 'item_standard', 1, 359, 1, '{}', 'A solid bar made of iron, known for its strength and durability.', 0, 0.25),
('ironextract', 'Iron Extract', 1, 1, 'item_standard', 0, 360, 1, '{}', 'A concentrated form of iron, extracted from natural sources.', 0, 0.25),
('ironhammer', 'Iron Hammer', 5, 1, 'item_standard', 1, 361, 1, '{}', 'A hammer with a head made of iron, used for various construction and crafting purposes.', 0, 0.25),
('items_craftbook', 'Items Craftbook', 1, 1, 'item_standard', 1, 1021, 1, '{}', 'Used to open the items crafting menu.', 0, 0.25),
('kbirdb', 'Great Blue Heron Beak', 20, 1, 'item_standard', 1, 362, 1, '{}', 'The beak of a Great Blue Heron, known for its long and slender shape.', 0, 0.25),
('kbirdf', 'Great Blue Heron Feather', 20, 1, 'item_standard', 1, 363, 1, '{}', 'A feather obtained from a Great Blue Heron, valued for its beauty and softness.', 0, 0.25),
('kitchencounter', 'Kitchen Counter', 20, 1, 'item_standard', 1, 364, 1, '{}', 'A sturdy counter surface typically found in kitchens, providing space for food preparation and other tasks.', 0, 0.25),
('kit_bandana', 'Bandana', 2, 1, 'item_standard', 1, 365, 1, '{}', 'A versatile and stylish piece of cloth that can be worn around the neck or head for various purposes. It adds a touch of fashion to any outfit.', 0, 0.25),
('knivehandle', 'Knife Handle', 50, 1, 'item_standard', 0, 1047, 1, '{}', 'nice item', 0, 0.25),
('lamppost1', 'Lamp Post 1 Set', 20, 1, 'item_standard', 1, 366, 1, '{}', 'A set of Lamp Post 1', 0, 0.25),
('lamppost2', 'Lamp Post 2 Set', 20, 1, 'item_standard', 1, 367, 1, '{}', 'A set of Lamp Post 2', 0, 0.25),
('lanterna', 'Lantern', 20, 1, 'item_standard', 1, 368, 1, '{}', 'A lantern', 0, 0.25),
('leather', 'Leather', 50, 1, 'item_standard', 1, 369, 1, '{}', 'Leather material', 0, 0.25),
('leatherchair', 'Leather Chair', 20, 1, 'item_standard', 1, 370, 1, '{}', 'A leather chair', 0, 0.25),
('leather_chair', 'Leather Chair', 20, 1, 'item_standard', 1, 371, 1, '{}', 'A leather chair', 0, 0.25),
('legalbook', 'Legal Book', 1, 1, 'item_standard', 1, 372, 1, '{}', 'A legal book', 0, 0.25),
('legaligators', 'Legendary Alligator pelt', 20, 1, 'item_standard', 1, 373, 1, '{}', 'A legendary pelt from an alligator', 0, 0.25),
('legaligators1', 'Legendary Teca Alligator pelt', 20, 1, 'item_standard', 1, 374, 1, '{}', 'A legendary pelt from a Teca Alligator', 0, 0.25),
('legaligators2', 'Legendary Sun Alligator pelt', 20, 1, 'item_standard', 1, 375, 1, '{}', 'A legendary pelt from a Sun Alligator', 0, 0.25),
('legaligators3', 'Legendary Banded Alligator pelt', 20, 1, 'item_standard', 1, 376, 1, '{}', 'A legendary pelt from a Banded Alligator', 0, 0.25),
('legalpaper', 'Legal Paper', 4, 1, 'item_standard', 1, 377, 1, '{}', 'Legal paper', 0, 0.25),
('legbears1', 'Legendary Deadly Bear pelt', 20, 1, 'item_standard', 1, 378, 1, '{}', 'A legendary pelt from a Deadly Bear', 0, 0.25),
('legbears2', 'Legendary Owiza Bear pelt', 20, 1, 'item_standard', 1, 379, 1, '{}', 'A legendary pelt from an Owiza Bear', 0, 0.25),
('legbears3', 'Legendary Ridgeback Spirit Bear pelt', 20, 1, 'item_standard', 1, 380, 1, '{}', 'A legendary pelt from a Ridgeback Spirit Bear', 0, 0.25),
('legbears4', 'Legendary Golden Spirit Bear pelt', 20, 1, 'item_standard', 1, 381, 1, '{}', 'A legendary pelt from a Golden Spirit Bear', 0, 0.25),
('legbeavers1', 'Legendary Grey Beaver pelt', 20, 1, 'item_standard', 1, 382, 1, '{}', 'A legendary pelt from a Grey Beaver', 0, 0.25),
('legbeavers2', 'Legendary White Beaver pelt', 20, 1, 'item_standard', 1, 383, 1, '{}', 'A legendary pelt from a White Beaver', 0, 0.25),
('legbeavers3', 'Legendary Black Beaver pelt', 20, 1, 'item_standard', 1, 384, 1, '{}', 'A legendary pelt from a Black Beaver', 0, 0.25),
('legbeawers', 'Legendary Beaver pelt', 20, 1, 'item_standard', 1, 385, 1, '{}', 'A legendary pelt from a Beaver', 0, 0.25),
('legbisonhorn', 'Legendary Bison Horns', 20, 1, 'item_standard', 1, 386, 1, '{}', 'A pair of majestic horns from a legendary bison', 0, 0.25),
('legbisons', 'Legendary Bison pelt', 20, 1, 'item_standard', 1, 387, 1, '{}', 'A rare and valuable pelt from a legendary bison', 0, 0.25),
('legbisons1', 'Legendary Tatanka Bison pelt', 20, 1, 'item_standard', 1, 388, 1, '{}', 'An exquisite pelt from a legendary Tatanka Bison', 0, 0.25),
('legbisons2', 'Legendary Winyan Bison pelt', 20, 1, 'item_standard', 1, 389, 1, '{}', 'A beautiful pelt from a legendary Winyan Bison', 0, 0.25),
('legbisons3', 'Legendary Payata Bison pelt', 20, 1, 'item_standard', 1, 390, 1, '{}', 'A prized pelt from a legendary Payata Bison', 0, 0.25),
('legbisonstak', 'Legendary Takanta Bison pelt', 20, 1, 'item_standard', 1, 391, 1, '{}', 'An exceptional pelt from a legendary Takanta Bison', 0, 0.25),
('legboars', 'Legendary Boar pelt', 20, 1, 'item_standard', 1, 392, 1, '{}', 'A rare and sought-after pelt from a legendary boar', 0, 0.25),
('legboars1', 'Legendary Cogi Boar pelt', 20, 1, 'item_standard', 1, 393, 1, '{}', 'A magnificent pelt from a legendary Cogi Boar', 0, 0.25),
('legboars2', 'Legendary Wakpa Boar pelt', 20, 1, 'item_standard', 1, 394, 1, '{}', 'A formidable pelt from a legendary Wakpa Boar', 0, 0.25),
('legboars3', 'Legendary Icahi Boar pelt', 20, 1, 'item_standard', 1, 395, 1, '{}', 'A rare pelt from a legendary Icahi Boar', 0, 0.25),
('legboars4', 'Legendary Wildhog pelt', 20, 1, 'item_standard', 1, 396, 1, '{}', 'An untamed pelt from a legendary Wildhog', 0, 0.25),
('legbucks', 'Legendary Buck skin', 20, 1, 'item_standard', 1, 397, 1, '{}', 'A prized skin from a legendary buck', 0, 0.25),
('legbucks1', 'Legendary Buck pelt', 20, 1, 'item_standard', 1, 398, 1, '{}', 'A splendid pelt from a legendary buck', 0, 0.25),
('legbucks2', 'Legendary Mudrunner Buck pelt', 20, 1, 'item_standard', 1, 399, 1, '{}', 'A distinct pelt from a legendary Mudrunner Buck', 0, 0.25),
('legbucks3', 'Legendary Snow Buck pelt', 20, 1, 'item_standard', 1, 400, 1, '{}', 'A pristine pelt from a legendary Snow Buck', 0, 0.25),
('legbucks4', 'Legendary Shadow Buck pelt', 20, 1, 'item_standard', 1, 401, 1, '{}', 'A mysterious pelt from a legendary Shadow Buck', 0, 0.25),
('legcougars', 'Legendary Cougar skin', 20, 1, 'item_standard', 1, 402, 1, '{}', 'A rare and valuable skin from a legendary cougar', 0, 0.25),
('legcougars1', 'Legendary Iguga Cougar pelt', 20, 1, 'item_standard', 1, 403, 1, '{}', 'A striking pelt from a legendary Iguga Cougar', 0, 0.25),
('legcougars2', 'Legendary Maza Cougar pelt', 20, 1, 'item_standard', 1, 404, 1, '{}', 'An exceptional pelt from a legendary Maza Cougar', 0, 0.25),
('legcougars3', 'Legendary Sapa Cougar pelt', 20, 1, 'item_standard', 1, 405, 1, '{}', 'A majestic pelt from a legendary Sapa Cougar', 0, 0.25),
('legcougars4', 'Legendary Black Cougar pelt', 20, 1, 'item_standard', 1, 406, 1, '{}', 'A rare pelt from a legendary Black Cougar', 0, 0.25),
('legcoyotes', 'Legendary Coyote skin', 20, 1, 'item_standard', 1, 407, 1, '{}', 'A prized skin from a legendary coyote', 0, 0.25),
('legcoyotes1', 'Legendary Red Streak Coyote pelt', 20, 1, 'item_standard', 1, 408, 1, '{}', 'A vibrant pelt from a legendary Red Streak Coyote', 0, 0.25),
('legcoyotes2', 'Legendary Midnight Paw Coyote pelt', 20, 1, 'item_standard', 1, 409, 1, '{}', 'A dark and mysterious pelt from a legendary Midnight Paw Coyote', 0, 0.25),
('legcoyotes3', 'Legendary Milk Coyote pelt', 20, 1, 'item_standard', 1, 410, 1, '{}', 'A rare pelt from a legendary Milk Coyote', 0, 0.25),
('legelkantler', 'Legendary Elk Antlers', 20, 1, 'item_standard', 1, 411, 1, '{}', 'A magnificent set of antlers from a legendary elk', 0, 0.25),
('legelks', 'Legendary Elk pelt', 20, 1, 'item_standard', 1, 412, 1, '{}', 'An impressive pelt from a legendary elk', 0, 0.25),
('legelks1', 'Legendary Katata Elk pelt', 20, 1, 'item_standard', 1, 413, 1, '{}', 'An exceptional pelt from a legendary Katata Elk', 0, 0.25),
('legelks2', 'Legendary Ozula Elk pelt', 20, 1, 'item_standard', 1, 414, 1, '{}', 'A rare pelt from a legendary Ozula Elk', 0, 0.25),
('legelks3', 'Legendary Inahme Elk pelt', 20, 1, 'item_standard', 1, 415, 1, '{}', 'An exquisite pelt from a legendary Inahme Elk', 0, 0.25),
('legendbuckantler', 'Legendary Buck Antlers', 20, 1, 'item_standard', 1, 416, 1, '{}', 'A pair of majestic antlers from a legendary buck', 0, 0.25),
('legendsnakes', 'Legendary Boa pelt', 20, 1, 'item_standard', 1, 417, 1, '{}', 'A rare and valuable pelt from a legendary boa', 0, 0.25),
('legfoxs2', 'Legendary Marble Fox pelt', 20, 1, 'item_standard', 1, 418, 1, '{}', 'A beautiful pelt from a legendary Marble Fox', 0, 0.25),
('legfoxs3', 'Legendary Cross Fox pelt', 20, 1, 'item_standard', 1, 419, 1, '{}', 'An exquisite pelt from a legendary Cross Fox', 0, 0.25),
('legfoxskin', 'Legendary Fox skin', 20, 1, 'item_standard', 1, 420, 1, '{}', 'A valuable and versatile skin from a legendary fox', 0, 0.25),
('leggbears', 'Legendary Bear skin', 20, 1, 'item_standard', 1, 421, 1, '{}', 'A formidable and sought-after skin from a legendary bear', 0, 0.25),
('legmooseantler', 'Legendary Moose Antlers', 20, 1, 'item_standard', 1, 422, 1, '{}', 'A massive set of antlers from a legendary moose', 0, 0.25),
('legmooses', 'Legendary Moose pelt', 20, 1, 'item_standard', 1, 423, 1, '{}', 'A majestic pelt from a legendary moose', 0, 0.25),
('legmooses1', 'Legendary Snowflake Moose pelt', 20, 1, 'item_standard', 1, 424, 1, '{}', 'A pristine pelt from a legendary Snowflake Moose', 0, 0.25),
('legmooses2', 'Legendary Knight Moose pelt', 20, 1, 'item_standard', 1, 425, 1, '{}', 'An impressive pelt from a legendary Knight Moose', 0, 0.25),
('legmooses3', 'Legendary Rudy Moose pelt', 20, 1, 'item_standard', 1, 426, 1, '{}', 'A distinctive pelt from a legendary Rudy Moose', 0, 0.25),
('legpanthers1', 'Legendary Nightwalker Panther pelt', 20, 1, 'item_standard', 1, 427, 1, '{}', 'A dark and elusive pelt from a legendary Nightwalker Panther', 0, 0.25),
('legpanthers2', 'Legendary Ghost Panther pelt', 20, 1, 'item_standard', 1, 428, 1, '{}', 'An ethereal pelt from a legendary Ghost Panther', 0, 0.25),
('legpanthers3', 'Legendary Iwakta Panther pelt', 20, 1, 'item_standard', 1, 429, 1, '{}', 'A rare and valuable pelt from a legendary Iwakta Panther', 0, 0.25),
('legprongs', 'Legendary Pronghorn skin', 20, 1, 'item_standard', 1, 430, 1, '{}', 'A sleek and coveted skin from a legendary pronghorn', 0, 0.25),
('legramhorn', 'Legendary Ram Horns', 20, 1, 'item_standard', 1, 431, 1, '{}', 'Impressive horns from a legendary ram', 0, 0.25),
('legrams', 'Legendary Ram pelt', 20, 1, 'item_standard', 1, 432, 1, '{}', 'A distinctive pelt from a legendary ram', 0, 0.25),
('legrams1', 'Legendary Gabbro Horn Ram pelt', 20, 1, 'item_standard', 1, 433, 1, '{}', 'A rare and valuable pelt from a legendary Gabbro Horn Ram', 0, 0.25),
('legrams2', 'Legendary Chalk Horn Ram pelt', 20, 1, 'item_standard', 1, 434, 1, '{}', 'An exceptional pelt from a legendary Chalk Horn Ram', 0, 0.25),
('legrams3', 'Legendary Rutile Horn Ram pelt', 20, 1, 'item_standard', 1, 435, 1, '{}', 'An exquisite pelt from a legendary Rutile Horn Ram', 0, 0.25),
('legrams4', 'Legendary GreatHorn Ram pelt', 20, 1, 'item_standard', 1, 436, 1, '{}', 'An impressive pelt from a legendary GreatHorn Ram', 0, 0.25),
('legwolfpelt', 'Legendary Wolf skin', 20, 1, 'item_standard', 1, 437, 1, '{}', 'A prized and valuable skin from a legendary wolf', 0, 0.25),
('legwolfs1', 'Legendary Emerald Wolf pelt', 20, 1, 'item_standard', 1, 438, 1, '{}', 'A vibrant pelt from a legendary Emerald Wolf', 0, 0.25),
('legwolfs2', 'Legendary Onyx Wolf pelt', 20, 1, 'item_standard', 1, 439, 1, '{}', 'nice item', 0, 0.25),
('legwolfs3', 'Legendary Moonstone Wolf pelt', 20, 1, 'item_standard', 1, 440, 1, '{}', 'A magnificent pelt from a legendary Moonstone Wolf', 0, 0.25),
('lizardl', 'Lizard foot', 20, 1, 'item_standard', 1, 441, 1, '{}', 'A preserved foot of a lizard', 0, 0.25),
('lizards', 'Lizard pelt', 20, 1, 'item_standard', 1, 442, 1, '{}', 'A unique and scaly skin from a lizard', 0, 0.25),
('lockpick', 'Lockpick', 5, 1, 'item_standard', 1, 443, 1, '{}', 'A handy tool used for picking locks', 0, 0.25),
('lockpickmold', 'Lockpick Mold', 5, 1, 'item_standard', 1, 444, 1, '{}', 'A mold used for crafting lockpicks', 0, 0.25),
('logbechs', 'Log Bench 2', 20, 1, 'item_standard', 1, 445, 1, '{}', 'A sturdy and rustic log bench design', 0, 0.25),
('logbench', 'Log Bench 1', 20, 1, 'item_standard', 1, 446, 1, '{}', 'A simple and natural log bench', 0, 0.25),
('log_bencha', 'Log Bench 1', 20, 1, 'item_standard', 1, 447, 1, '{}', 'A comfortable log bench for outdoor seating', 0, 0.25),
('log_benchb', 'Log Bench 2', 20, 1, 'item_standard', 1, 448, 1, '{}', 'A spacious log bench for outdoor gatherings', 0, 0.25),
('loonb', 'Common loon beak', 20, 1, 'item_standard', 1, 449, 1, '{}', 'The beak of a common loon bird', 0, 0.25),
('loonf', 'Common loon feather', 20, 1, 'item_standard', 1, 450, 1, '{}', 'A beautiful feather from a common loon bird', 0, 0.25),
('loungechair', 'Lounge Chair', 20, 1, 'item_standard', 1, 451, 1, '{}', 'A comfortable and stylish lounge chair', 0, 0.25),
('loungechair2', 'Lounge Chair 2', 20, 1, 'item_standard', 1, 452, 1, '{}', 'A modern and luxurious lounge chair', 0, 0.25),
('lumberaxe', 'Lumber Axe', 1, 1, 'item_standard', 1, 453, 1, '{}', 'A sturdy axe designed for cutting lumber', 0, 0.25),
('mackerel', 'Mackerel', 10, 1, 'item_standard', 0, 454, 1, '{}', 'A small and silvery fish called mackerel', 0, 0.25),
('marriagebook', 'Marriage Book', 1, 1, 'item_standard', 1, 455, 1, '{}', 'A book containing the guidelines and rituals for marriage', 0, 0.25),
('marriagecertification', 'Marriage Certify', 2, 1, 'item_standard', 1, 456, 1, '{}', 'A legal document certifying a marriage', 0, 0.25),
('mashalaskan', 'Alaskan Gin Mash', 20, 1, 'item_standard', 1, 457, 1, '{}', 'A mixture of ingredients used in the production of Alaskan gin', 0, 0.25),
('mashamerican', 'Alaskan Gin Mash', 20, 1, 'item_standard', 1, 458, 1, '{}', 'A blend of ingredients used in the production of Alaskan gin', 0, 0.25),
('mashapple', 'Apple Mash', 20, 1, 'item_standard', 1, 459, 1, '{}', 'A mashed mixture of apples used for various recipes', 0, 0.25),
('mashblackberry', 'Blackberry Mash', 20, 1, 'item_standard', 1, 460, 1, '{}', 'A mashed mixture of blackberries used in cooking and beverages', 0, 0.25),
('mashblackberry90p', 'Blackberry Mash 90p', 20, 1, 'item_standard', 1, 461, 1, '{}', 'A concentrated blackberry mash used for crafting high-quality beverages', 0, 0.25),
('mashpeach', 'Peach Mash', 20, 1, 'item_standard', 1, 462, 1, '{}', 'A mashed mixture of peaches used in culinary preparations', 0, 0.25),
('mashplum', 'Plum Mash', 20, 1, 'item_standard', 1, 463, 1, '{}', 'A mashed mixture of plums used in cooking and distilling', 0, 0.25),
('mashraspberry', 'Raspberry Mash', 20, 1, 'item_standard', 1, 464, 1, '{}', 'A mashed mixture of raspberries used for culinary purposes', 0, 0.25),
('mashraspberry90p', 'Raspberry Mash 90p', 20, 1, 'item_standard', 1, 465, 1, '{}', 'A concentrated raspberry mash used for crafting potent beverages', 0, 0.25),
('mashstrong', 'Strong Mash Batch', 20, 1, 'item_standard', 1, 466, 1, '{}', 'A powerful and highly concentrated mash batch for advanced recipes', 0, 0.25),
('meat', 'Meat', 20, 1, 'item_standard', 1, 467, 1, '{}', 'Fresh and uncooked meat from various animals', 0, 0.25),
('metal_gear', 'Metal gear', 10, 1, 'item_standard', 1, 798, 1, '{}', 'A metal gear used in many machines.', 0, 0.25),
('mexitillas', 'Mexitillas', 10, 1, 'item_standard', 1, 799, 1, '{}', 'A can of mixed mexcian beans.', 0, 0.25),
('mexitillastaco', 'Taco', 10, 1, 'item_standard', 1, 800, 1, '{}', 'A delicous taco.', 0, 0.25),
('milk', 'Milk', 50, 1, 'item_standard', 1, 468, 1, '{}', 'A nutritious and creamy dairy product', 0, 0.25),
('Milk_Weed', 'Milk Weed', 10, 1, 'item_standard', 1, 469, 1, '{}', 'A plant with milky sap used for medicinal purposes', 0, 0.25),
('Milk_Weed_Seed', 'Milk Weed Seed', 10, 1, 'item_standard', 1, 470, 1, '{}', 'Seeds of the milkweed plant for cultivation', 0, 0.25),
('money_coin', 'Coin', 10, 1, 'item_standard', 1, 801, 1, '{}', 'A simple metal coin', 0, 0.25),
('money_coinpurse', 'Coin Purse', 10, 1, 'item_standard', 1, 802, 1, '{}', 'A small coin purse.', 0, 0.25),
('moonshine', 'Moonshine', 10, 1, 'item_standard', 1, 471, 1, '{}', 'An illegally distilled and potent alcoholic beverage', 0, 0.25),
('mooseantler', 'Moose Antlers', 20, 1, 'item_standard', 1, 472, 1, '{}', 'Impressive antlers shed by a moose', 0, 0.25),
('mooses', 'Moose pelt', 20, 1, 'item_standard', 1, 473, 1, '{}', 'A large and thick fur coat from a moose', 0, 0.25),
('morpcert', 'Morphine Prescription', 10, 1, 'item_standard', 1, 474, 1, '{}', 'A medical prescription for morphine medication', 0, 0.25),
('morphine', 'Morphine', 10, 1, 'item_standard', 1, 475, 1, '{}', 'A potent analgesic and narcotic medication', 0, 0.25),
('mountainmen', 'Mountain Camp Set', 20, 1, 'item_standard', 1, 476, 1, '{}', 'A set of equipment and supplies for a mountain camp', 0, 0.25),
('mp001_p_mp_still02x', 'Brennerei', 1, 1, 'item_standard', 1, 477, 1, '{}', 'A large still used for distilling alcoholic beverages', 0, 0.25),
('mud_bucket', 'Bucket of Mud', 20, 1, 'item_standard', 1, 1061, 1, '{}', 'nice item', 0, 0.25),
('muskrats', 'Muskrat skin', 20, 1, 'item_standard', 1, 478, 1, '{}', 'The fur skin of a muskrat, commonly used for crafting', 0, 0.25),
('Mutton', 'Mutton', 20, 1, 'item_standard', 1, 479, 1, '{}', 'Meat from mature sheep used in cooking', 0, 0.25),
('nails', 'Nails', 40, 1, 'item_standard', 1, 480, 1, '{}', 'Small metal fasteners used for joining materials', 0, 0.25),
('nativebasket1', 'Native Basket 1', 20, 1, 'item_standard', 1, 481, 1, '{}', 'A traditional native basket for carrying items', 0, 0.25),
('nativebasket2', 'Native Basket 2', 20, 1, 'item_standard', 1, 482, 1, '{}', 'A second variation of a traditional native basket', 0, 0.25),
('nativedecor', 'Native Decor Set', 20, 1, 'item_standard', 1, 483, 1, '{}', 'A set of decorative native items for display', 0, 0.25),
('nativepot', 'Native Pot', 20, 1, 'item_standard', 1, 484, 1, '{}', 'A traditional native pot for cooking and storage', 0, 0.25),
('nativeskull', 'Native Decor 1', 20, 1, 'item_standard', 1, 485, 1, '{}', 'A decorative native skull for ornamental purposes', 0, 0.25),
('naturalwagon', 'Naturalists Wagon Set', 20, 1, 'item_standard', 1, 486, 1, '{}', 'A wagon set equipped for naturalists and explorers', 0, 0.25),
('newspaper', 'Newspaper', 20, 1, 'item_standard', 1, 487, 1, '{}', 'A printed publication containing news and articles', 0, 0.25),
('nightstand', 'Nightstand', 20, 1, 'item_standard', 1, 488, 1, '{}', 'A small bedside table for holding personal items', 0, 0.25),
('nitrite', 'Nitrite', 20, 1, 'item_standard', 1, 489, 1, '{}', 'A chemical compound used in various industrial processes', 0, 0.25),
('nitroglyserolia', 'Nitroglycerol', 30, 1, 'item_standard', 1, 490, 1, '{}', 'A highly explosive liquid compound used in explosives', 0, 0.25),
('normaltable', 'Table', 20, 1, 'item_standard', 1, 491, 1, '{}', 'A standard table for dining or work purposes', 0, 0.25),
('notebook', 'Notebook', 5, 1, 'item_standard', 1, 492, 1, '{}', 'A small book with blank pages for writing or drawing', 0, 0.25),
('obed', 'Old bed', 20, 1, 'item_standard', 1, 493, 1, '{}', 'An old bed that has seen better days.', 0, 0.25),
('oil_lantern', 'Oil Lantern', 1, 1, 'item_standard', 1, 998, 1, '{}', 'A portable light source.', 0, 0.25),
('Oleander_Sage', 'Oleander Sage', 10, 1, 'item_standard', 1, 494, 1, '{}', 'A herb known for its medicinal properties.', 0, 0.25),
('Oleander_Sage_Seed', 'Oleander Sage Seed', 10, 1, 'item_standard', 1, 495, 1, '{}', 'A seed that can be planted to grow Oleander Sage.', 0, 0.25),
('opossumc', 'Opossum claws', 20, 1, 'item_standard', 1, 496, 1, '{}', 'Sharp claws from an opossum.', 0, 0.25),
('opossums', 'Opossum skin', 20, 1, 'item_standard', 1, 497, 1, '{}', 'The fur and skin of an opossum.', 0, 0.25),
('orden_presidente', 'Order of the President', 10, 1, 'item_standard', 0, 498, 1, '{}', 'A prestigious order awarded by the President.', 0, 0.25),
('Oregano', 'Oregano', 10, 1, 'item_standard', 1, 499, 1, '{}', 'A fragrant herb commonly used in cooking.', 0, 0.25),
('Oregano_Seed', 'Oregano Seed', 10, 1, 'item_standard', 1, 500, 1, '{}', 'A seed that can be planted to grow Oregano.', 0, 0.25),
('oriole2_c', 'Hooded Oriole', 20, 1, 'item_standard', 1, 501, 1, '{}', 'Brightly colored feathers from a Hooded Oriole.', 0, 0.25),
('oriole_c', 'Oriole', 20, 1, 'item_standard', 1, 502, 1, '{}', 'Vibrant feathers from an Oriole bird.', 0, 0.25),
('others_craftbook', 'Others Craftbook', 1, 1, 'item_standard', 1, 1022, 1, '{}', 'Used to open the miscellaneous items crafting menu.', 0, 0.25),
('owlf', 'Owl feather', 20, 1, 'item_standard', 1, 503, 1, '{}', 'Feathers shed by an owl.', 0, 0.25),
('owlt', 'Owl claws', 20, 1, 'item_standard', 1, 504, 1, '{}', 'Sharp claws from an owl.', 0, 0.25),
('oxhorn', 'Angus Bull horn', 20, 1, 'item_standard', 1, 505, 1, '{}', 'A sturdy horn from an Angus Bull.', 0, 0.25),
('oxs', 'Angus Bull pelt', 20, 1, 'item_standard', 1, 506, 1, '{}', 'The thick fur and skin of an Angus Bull.', 0, 0.25),
('panthere', 'Panther eyes', 20, 1, 'item_standard', 1, 507, 1, '{}', 'Intense and captivating eyes from a panther.', 0, 0.25),
('panthers', 'Panther skin', 20, 1, 'item_standard', 1, 508, 1, '{}', 'The sleek and supple skin of a panther.', 0, 0.25),
('paper', 'Paper', 20, 1, 'item_standard', 1, 509, 1, '{}', 'Sheets of paper for writing or drawing.', 0, 0.25),
('parasol', 'Parasol', 1, 1, 'item_standard', 1, 510, 1, '{}', 'A stylish and functional parasol to shield from the sun.', 0, 0.25),
('Parasol_Mushroom', 'Parasol Mushroom', 10, 1, 'item_standard', 1, 511, 1, '{}', 'A mushroom with a wide, umbrella-like cap.', 0, 0.25),
('Parasol_Mushroom_Seed', 'Parasol Mushroom Seed', 10, 1, 'item_standard', 1, 512, 1, '{}', 'A seed that can be planted to grow parasol mushrooms.', 0, 0.25),
('peachseeds', 'Peach Seeds', 10, 1, 'item_standard', 1, 513, 1, '{}', 'Seeds that can be planted to grow peach trees.', 0, 0.25),
('pearl', 'Pearl', 10, 1, 'item_standard', 1, 803, 1, '{}', 'A hard, glistening object produced within the soft tissue of a living shelled mollusk.', 0, 0.25),
('peasantb', 'Peasant beak', 20, 1, 'item_standard', 1, 514, 1, '{}', 'The beak of a peasant bird.', 0, 0.25),
('peasantf', 'Peasant feather', 20, 1, 'item_standard', 1, 515, 1, '{}', 'A feather from a peasant bird.', 0, 0.25),
('pecaris', 'Peccary pelt', 20, 1, 'item_standard', 1, 516, 1, '{}', 'The fur of a peccary, a pig-like mammal.', 0, 0.25),
('pelicanb', 'Pelican beak', 20, 1, 'item_standard', 1, 517, 1, '{}', 'The beak of a pelican bird.', 0, 0.25),
('pelicanf', 'Pelican feather', 20, 1, 'item_standard', 1, 518, 1, '{}', 'A feather from a pelican bird.', 0, 0.25),
('pen', 'Pen', 2, 1, 'item_standard', 0, 519, 1, '{}', 'A writing instrument used to apply ink.', 0, 0.25),
('pheasant_taxidermy', 'Pheasant Taxidermy', 20, 1, 'item_standard', 1, 520, 1, '{}', 'A preserved mount of a pheasant bird for display.', 0, 0.25),
('phestaxi', 'Pheasant Taxidermy', 20, 1, 'item_standard', 1, 521, 1, '{}', 'A preserved mount of a pheasant bird for display.', 0, 0.25),
('pickaxe', 'Pickaxe', 1, 1, 'item_standard', 0, 522, 1, '{}', 'A tool with a pointed end and a handle, used for breaking up rocks and mining.', 0, 0.25),
('pigeon_c', 'Pigeon', 20, 1, 'item_standard', 1, 523, 1, '{}', 'A pigeon bird.', 0, 0.25),
('pigs', 'Pig pelt', 20, 1, 'item_standard', 1, 524, 1, '{}', 'The skin and fur of a pig.', 0, 0.25),
('pipe', 'Pipe', 5, 1, 'item_standard', 1, 525, 1, '{}', 'A tubular device used for smoking tobacco or other substances.', 0, 0.25),
('pipecopper', 'Copper Pipe', 5, 1, 'item_standard', 1, 526, 1, '{}', 'A pipe made of copper.', 0, 0.25),
('planttrimmer', 'Plant Trimmer', 10, 1, 'item_standard', 1, 804, 1, '{}', 'A set plant trimmers to keep the weeds in check.', 0, 0.25),
('pliers', 'Pliers', 50, 1, 'item_standard', 0, 1051, 1, '{}', 'nice item', 0, 0.25),
('pocket_watch', 'Pocket Watch', 5, 1, 'item_standard', 1, 527, 1, '{}', 'A small timepiece designed to be carried in a pocket.', 0, 0.25),
('pokerset', 'Poker Table Set', 20, 1, 'item_standard', 1, 528, 1, '{}', 'A complete set for playing poker, including a table and cards.', 0, 0.25),
('pork', 'Pork', 20, 1, 'item_standard', 1, 529, 1, '{}', 'The meat from a pig, commonly used for cooking and eating.', 0, 0.25),
('porkfat', 'Pig fat', 20, 1, 'item_standard', 1, 530, 1, '{}', 'The fat obtained from a pig, often used in cooking and making lard.', 0, 0.25),
('pot', 'Distillery Pot', 1, 1, 'item_standard', 1, 531, 1, '{}', 'A large pot used in the distillation process for making alcohol.', 0, 0.25),
('pota', 'House Pot', 20, 1, 'item_standard', 1, 532, 1, '{}', 'A pot typically used for cooking and boiling ingredients.', 0, 0.25),
('potato', 'Potato', 20, 1, 'item_standard', 1, 533, 1, '{}', 'An edible starchy tuber that is commonly used in cooking.', 0, 0.25),
('potatoseed', 'Potato Seed', 10, 1, 'item_standard', 1, 534, 1, '{}', 'A seed that can be planted to grow potato plants.', 0, 0.25),
('potion', 'Potion', 5, 1, 'item_standard', 1, 960, 1, '{}', 'A potion with magical healing properties.', 0, 0.25),
('powdergun', 'Gunpowder', 50, 1, 'item_standard', 0, 1046, 1, '{}', 'nice item', 0, 0.25),
('prairib', 'Prairie Chicken Beak', 20, 1, 'item_standard', 1, 535, 1, '{}', 'The beak of a prairie chicken, a bird species found in grassland habitats.', 0, 0.25),
('Prairie_Poppy', 'Prairie Poppy', 10, 1, 'item_standard', 1, 536, 1, '{}', 'A type of poppy flower that is native to prairie regions.', 0, 0.25),
('Prairie_Poppy_Seed', 'Prairie Poppy Seed', 10, 1, 'item_standard', 1, 537, 1, '{}', 'A seed that can be planted to grow prairie poppy flowers.', 0, 0.25),
('prairif', 'Prairie Chicken Feather', 20, 1, 'item_standard', 1, 538, 1, '{}', 'A feather from a prairie chicken bird, often used in crafts and decorations.', 0, 0.25),
('pronghornh', 'Pronghorn Horn', 20, 1, 'item_standard', 1, 539, 1, '{}', 'The horn of a pronghorn, a mammal native to North America.', 0, 0.25),
('prongs', 'Pronghorn Skin', 20, 1, 'item_standard', 1, 540, 1, '{}', 'The skin of a pronghorn, known for its soft and durable fur.', 0, 0.25),
('provision_arrowhead_agate', 'Agate Arrowhead', 10, 1, 'item_standard', 1, 805, 1, '{}', 'A rare arrowhead fashioned from sharp, colorful agate.', 0, 0.25),
('provision_arrowhead_bone', 'Bone Arrowhead', 10, 1, 'item_standard', 1, 806, 1, '{}', 'A serrated arrowhead made from animal bone.', 0, 0.25),
('provision_arrowhead_chipped', 'Chipped Arrowhead', 10, 1, 'item_standard', 1, 807, 1, '{}', 'A hurriedly made arrowhead made from chiseled flint.', 0, 0.25),
('provision_arrowhead_crude', 'Crude Arrowhead', 10, 1, 'item_standard', 1, 808, 1, '{}', 'A clumsily made flint arrowhead, blunt from age.', 0, 0.25),
('provision_arrowhead_feldspar', 'Feldspar Arrowhead', 10, 1, 'item_standard', 1, 809, 1, '{}', 'A mysterious arrowhead made from some sort of feldspar.', 0, 0.25),
('provision_arrowhead_granite', 'Flint Arrowhead', 10, 1, 'item_standard', 1, 810, 1, '{}', 'A strong arrowhead made of flint.', 0, 0.25),
('provision_arrowhead_obsidian', 'Obsidian Arrowhead', 10, 1, 'item_standard', 1, 811, 1, '{}', 'A valuable arrowhead of smooth, gleaming obsidian.', 0, 0.25),
('provision_arrowhead_quartz', 'Quartz Arrowhead', 10, 1, 'item_standard', 1, 812, 1, '{}', 'An eye-catching arrowhead of cut quartz, in good condition.', 0, 0.25),
('provision_arrowhead_raw', 'Raw Arrowhead', 10, 1, 'item_standard', 1, 813, 1, '{}', 'A roughly hacked arrowhead made from pale stone.', 0, 0.25),
('provision_arrowhead_rough', 'Rough Arrowhead', 10, 1, 'item_standard', 1, 814, 1, '{}', 'A stone arrowhead, badly weathered over time.', 0, 0.25),
('provision_arrowhead_slate', 'Slate Arrowhead', 10, 1, 'item_standard', 1, 815, 1, '{}', 'A carefully made, well-preserved slate arrowhead.', 0, 0.25),
('provision_arrowhead_splintered', 'Splintered Arrowhead', 10, 1, 'item_standard', 1, 816, 1, '{}', 'A partially damaged, jagged arrowhead made of chert.', 0, 0.25),
('provision_asteroid_chunk', 'Meteorite', 10, 1, 'item_standard', 1, 817, 1, '{}', 'A rock that has fallen from space.', 0, 0.25),
('provision_bracelet_gold', 'Gold Bracelet', 10, 1, 'item_standard', 1, 818, 1, '{}', 'A gold bracelet.', 0, 0.25),
('provision_bracelet_platinum', 'Platinum Bracelet', 10, 1, 'item_standard', 1, 819, 1, '{}', 'A platinum bracelet', 0, 0.25),
('provision_bracelet_silver', 'Silver Bracelet', 10, 1, 'item_standard', 1, 820, 1, '{}', 'A silver bracelet.', 0, 0.25),
('provision_bra_shield', 'Brass Shield', 10, 1, 'item_standard', 1, 821, 1, '{}', 'An old brass shield. Probably valuable.', 0, 0.25),
('provision_buckle_gold', 'Gold Buckle', 10, 1, 'item_standard', 1, 822, 1, '{}', 'A gold belt buckle.', 0, 0.25),
('provision_buckle_platinum', 'Platinum Buckle', 10, 1, 'item_standard', 1, 823, 1, '{}', 'A platinum belt buckle.', 0, 0.25),
('provision_buckle_silver', 'Silver Buckle', 10, 1, 'item_standard', 1, 824, 1, '{}', 'A silver belt buckle.', 0, 0.25),
('provision_calderon_cross', 'Wooden Cross', 10, 1, 'item_standard', 1, 825, 1, '{}', 'A simple wooden cross. Often used by preists and clergymen.', 0, 0.25),
('provision_capitale', 'Capitale', 10, 1, 'item_standard', 1, 826, 1, '{}', 'Capitale. very valuable.', 0, 0.25),
('provision_coin_1700_ny_tkn', '1700 New Yorke Token', 10, 1, 'item_standard', 1, 827, 1, '{}', 'A rare 1700 New Yorke Token', 0, 0.25),
('provision_coin_1787_cent_tkn', '1787 One cent Token', 10, 1, 'item_standard', 1, 828, 1, '{}', 'A rare 1787 One cent Token', 0, 0.25),
('provision_coin_1789_pny', '1789 Penny', 10, 1, 'item_standard', 1, 829, 1, '{}', 'A rare 1789 Penny', 0, 0.25),
('provision_coin_1792_lib_qtr', '1792 Liberty Quarter', 10, 1, 'item_standard', 1, 830, 1, '{}', 'A rare 1792 Liberty Quarter', 0, 0.25),
('provision_coin_1792_nickel', '1792 Nickel', 10, 1, 'item_standard', 1, 831, 1, '{}', 'A rare 1792 Nickel', 0, 0.25),
('provision_coin_1792_qtr', '1792 Quarter', 10, 1, 'item_standard', 1, 832, 1, '{}', 'A rare 1792 Quarter', 0, 0.25),
('provision_coin_1794_slv_dlr', '1794 Silver Dollar', 10, 1, 'item_standard', 1, 833, 1, '{}', 'A rare 1794 Silver Dollar', 0, 0.25),
('provision_coin_1795_hlf_eag', '1795 Half Eagle', 10, 1, 'item_standard', 1, 834, 1, '{}', 'A rare 1795 Half Eagle', 0, 0.25),
('provision_coin_1796_hlf_pny', '1796 Half Penny', 10, 1, 'item_standard', 1, 835, 1, '{}', 'A rare 1796 Half Penny', 0, 0.25),
('provision_coin_1797_gld_eag', '1797 Gold Eagle', 10, 1, 'item_standard', 1, 836, 1, '{}', 'A rare 1797 Gold Eagle', 0, 0.25),
('provision_coin_1798_slv_dlr', '1798 Silver Dollar', 10, 1, 'item_standard', 1, 837, 1, '{}', 'A rare 1798 Silver Dollar', 0, 0.25),
('provision_coin_1800_five_dlr', '1800 Five Dollar', 10, 1, 'item_standard', 1, 838, 1, '{}', 'A rare 1800 Five Dollar', 0, 0.25),
('provision_coin_1800_gld_dlr', '1800 Gold Dollar', 10, 1, 'item_standard', 1, 839, 1, '{}', 'A rare 1800 Gold Dollar', 0, 0.25),
('provision_coin_1800_gld_qtr', '1800 Gold Quarter', 10, 1, 'item_standard', 1, 840, 1, '{}', 'A rare 1800 Gold Quarter', 0, 0.25),
('provision_coin_1800_hlf_dime', '1800 Half Dime', 10, 1, 'item_standard', 1, 841, 1, '{}', 'A rare 1800 Half Dime', 0, 0.25),
('provision_db_finger_bone', 'Bone', 10, 1, 'item_standard', 1, 842, 1, '{}', 'A small bone possibly from a finger.', 0, 0.25),
('provision_diamond_ring', 'Diamond Ring', 10, 1, 'item_standard', 1, 843, 1, '{}', 'A beautiful diamond ring.', 0, 0.25),
('provision_disco_ammolite', 'Ammolite', 10, 1, 'item_standard', 1, 844, 1, '{}', 'Fossilized shell of an ammonite.', 0, 0.25),
('provision_disco_ancient_eagle', 'Ancient Eagle', 10, 1, 'item_standard', 1, 845, 1, '{}', 'An ancient eagle statue.', 0, 0.25),
('provision_disco_ancient_necklace', 'Ancient Necklace', 10, 1, 'item_standard', 1, 846, 1, '{}', 'An ancient necklace.', 0, 0.25),
('provision_disco_fertility_statue', 'Fertility Statue', 10, 1, 'item_standard', 1, 847, 1, '{}', 'A statue that apparently possesses the power to grant fertility.', 0, 0.25),
('provision_disco_fluorite', 'Fluorite', 10, 1, 'item_standard', 1, 848, 1, '{}', 'The mineral form of calcium fluoride.', 0, 0.25),
('provision_disco_shrunken_head', 'Shrunken Head', 10, 1, 'item_standard', 1, 849, 1, '{}', 'A shurken head. possibly used in vodoo.', 0, 0.25),
('provision_disco_urn', 'Urn', 10, 1, 'item_standard', 1, 850, 1, '{}', 'A simple urn often used to hold things.', 0, 0.25),
('provision_disco_viking_comb', 'Viking Comb', 10, 1, 'item_standard', 1, 851, 1, '{}', 'A old viking comb.', 0, 0.25),
('provision_dog_tag', 'Dog Tag', 10, 1, 'item_standard', 1, 852, 1, '{}', 'A dog tag. Possibly from a soldier.', 0, 0.25),
('provision_earring_gold', 'Gold Earring', 10, 1, 'item_standard', 1, 853, 1, '{}', 'A gold earring.', 0, 0.25),
('provision_earring_pearl', 'Pearl Earring', 10, 1, 'item_standard', 1, 854, 1, '{}', 'A gold earring.', 0, 0.25),
('provision_earring_platinum', 'Platinum Earring', 10, 1, 'item_standard', 1, 855, 1, '{}', 'A beautiful pearl earring.', 0, 0.25),
('provision_earring_silver', 'Silver Earring', 10, 1, 'item_standard', 1, 856, 1, '{}', 'A silver earring.', 0, 0.25),
('provision_generic_key', 'Key', 10, 1, 'item_standard', 1, 857, 1, '{}', 'A simple key.', 0, 0.25),
('provision_hrlm_brush_boar', 'Boar bristle Brush', 10, 1, 'item_standard', 1, 858, 1, '{}', 'A beautifully made boar bristle brush.', 0, 0.25),
('provision_hrlm_brush_ebony', 'Ebony Hairbrush', 10, 1, 'item_standard', 1, 859, 1, '{}', 'A delicate and finely crafted ebony brush.', 0, 0.25),
('provision_hrlm_brush_goathair', 'Goat Hair Brush', 10, 1, 'item_standard', 1, 860, 1, '{}', 'A exquisite hand crafted goat hair brush.', 0, 0.25),
('provision_hrlm_brush_horsehair', 'Horse Hair brush', 10, 1, 'item_standard', 1, 861, 1, '{}', 'A finley made horse hair brush.', 0, 0.25),
('provision_hrlm_brush_rosewood', 'Rosewood Hairbrush', 10, 1, 'item_standard', 1, 862, 1, '{}', 'A hand carved rosewood brush.', 0, 0.25),
('provision_hrlm_brush_rosewood_ng', 'New Guinea Rosewood Hairbrush', 10, 1, 'item_standard', 1, 863, 1, '{}', 'An exotic new guinea rosewood hairbrush.', 0, 0.25),
('provision_hrlm_comb_boxwood', 'Boxwood Comb', 10, 1, 'item_standard', 1, 864, 1, '{}', 'A finley made boxwood comb.', 0, 0.25),
('provision_hrlm_comb_cherrywood', 'Cherrywood Comb', 10, 1, 'item_standard', 1, 865, 1, '{}', 'A exquisite cheerywood comb.', 0, 0.25),
('provision_hrlm_comb_ivory', 'Ivory Comb', 10, 1, 'item_standard', 1, 866, 1, '{}', 'A delicate ivory comb.', 0, 0.25),
('provision_hrlm_comb_tortoiseshell', 'Tortoiseshell Comb', 10, 1, 'item_standard', 1, 867, 1, '{}', 'A beautiful tortoiseshell comb.', 0, 0.25),
('provision_hrlm_hairpin_ebony', 'Ebony Hairpin', 10, 1, 'item_standard', 1, 868, 1, '{}', 'A exquisite ebony hairpin.', 0, 0.25),
('provision_hrlm_hairpin_ivory', 'Ivory Hairpin', 10, 1, 'item_standard', 1, 869, 1, '{}', 'A delicate ivory hairpin.', 0, 0.25),
('provision_hrlm_hairpin_jade', 'Jade Hairpin', 10, 1, 'item_standard', 1, 870, 1, '{}', 'A exotic jade hairpin.', 0, 0.25),
('provision_hrlm_hairpin_metal', 'Meatl Hairpin', 10, 1, 'item_standard', 1, 871, 1, '{}', 'A beautiful metal hairpin.', 0, 0.25),
('provision_hrlm_hairpin_wooden', 'Wooden Hairpin', 10, 1, 'item_standard', 1, 872, 1, '{}', 'A hand carved wooden hairpin.', 0, 0.25),
('provision_jail_keys', 'Jail Keys', 10, 1, 'item_standard', 1, 541, 1, '{}', 'A set of keys used to unlock jail cells and gates.', 0, 0.25),
('provision_jewelry_amethyst_necklace', 'Richelieu Amethyst Necklace', 10, 1, 'item_standard', 1, 873, 1, '{}', 'A delicate necklace featuring a duo of purple amethyst and silver pearl.', 0, 0.25),
('provision_jewelry_blck_pearl_necklace', 'Tuamotu Pearl Necklace', 10, 1, 'item_standard', 1, 874, 1, '{}', 'A silk strung necklace of magnificent black Tahitian pearls.', 0, 0.25),
('provision_jewelry_box', 'Jewelry Box', 10, 1, 'item_standard', 1, 875, 1, '{}', 'A small jewlery box.', 0, 0.25),
('provision_jewelry_carved_bracelet', 'Elliston Carved Bracelet', 10, 1, 'item_standard', 1, 876, 1, '{}', 'A solid gold bracelet with elegant etching.', 0, 0.25),
('provision_jewelry_coral_dngl_earring', 'Emmeline Coral Earrings', 10, 1, 'item_standard', 1, 877, 1, '{}', 'Drop hook earrings of polished pink coral set in gold.', 0, 0.25),
('provision_jewelry_coral_ring', 'Harland Coral Ring', 10, 1, 'item_standard', 1, 878, 1, '{}', 'A delicate gold ring featuring a large angel skin coral.', 0, 0.25),
('provision_jewelry_dmnd_bngle_bracelet', 'Abelló Ruby Bangle Bracelet', 10, 1, 'item_standard', 1, 879, 1, '{}', 'A hinged gold bangle with a series of claw set rubies.', 0, 0.25),
('provision_jewelry_dmnd_pendt_earring', 'Orchidée Diamond Earrings', 10, 1, 'item_standard', 1, 880, 1, '{}', 'Earrings set with clusters of brilliant cut diamonds in a floral pattern.', 0, 0.25),
('provision_jewelry_elk_tooth_earring', 'Sterling Tooth Earrings', 10, 1, 'item_standard', 1, 881, 1, '{}', 'A striking pair of elk teeth set into silver.', 0, 0.25),
('provision_jewelry_emerald_earring', 'Duchess Emerald Earrings', 10, 1, 'item_standard', 1, 882, 1, '{}', 'A famous set of oval cut emeralds fashioned into earrings.', 0, 0.25);
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `degradation`, `weight`) VALUES
('provision_jewelry_emerald_ring', 'Bosque Emerald Ring', 10, 1, 'item_standard', 1, 883, 1, '{}', 'A gold band with an extravagant bezel set Columbian emerald.', 0, 0.25),
('provision_jewelry_french_dmnd_ring', 'Beaulieux Diamond Ring', 10, 1, 'item_standard', 1, 884, 1, '{}', 'A number of old mine cut diamonds claw set in a silver ring from France.', 0, 0.25),
('provision_jewelry_gld_bngle_bracelet', 'Ojeda Rose Gold Bangle Bracelet', 10, 1, 'item_standard', 1, 885, 1, '{}', 'A large bracelet of rose gold with elaborate cameo detailing.', 0, 0.25),
('provision_jewelry_gld_cross_necklace', 'Ainsworth Cross Necklace', 10, 1, 'item_standard', 1, 886, 1, '{}', 'A solid gold chain necklace with an etched gold cross.', 0, 0.25),
('provision_jewelry_gld_pearl_necklace', 'Rou Pearl Necklace', 10, 1, 'item_standard', 1, 887, 1, '{}', 'A necklace made of fine rose gold featuring a single pearl from the Orient.', 0, 0.25),
('provision_jewelry_gld_pendt_necklace', 'Gosselin White Gold Necklace', 10, 1, 'item_standard', 1, 888, 1, '{}', 'A lavalier style white gold necklace with a series of small diamonds.', 0, 0.25),
('provision_jewelry_grnet_bracelet', 'Hajnal Garnet Bangle Bracelet', 10, 1, 'item_standard', 1, 889, 1, '{}', 'A bohemian style silver bangle with numerous claw set garnets.', 0, 0.25),
('provision_jewelry_grnet_post_earring', 'Harford Garnet Earrings', 10, 1, 'item_standard', 1, 890, 1, '{}', 'Clustered garnet studs with silver posts and scrolls.', 0, 0.25),
('provision_jewelry_moon_ring', 'Pilgrim Moonstone Ring', 10, 1, 'item_standard', 1, 891, 1, '{}', 'A thick gold band with a single claw set moonstone.', 0, 0.25),
('provision_jewelry_mthr_pearl_necklace', 'Pellé Pearl Necklace', 10, 1, 'item_standard', 1, 892, 1, '{}', 'A beaded chain necklace with a fashionable mother of pearl pendant.', 0, 0.25),
('provision_jewelry_onyx_ring', 'Aubrey Onyx Ring', 10, 1, 'item_standard', 1, 893, 1, '{}', 'A rare white gold ring with a bezel set diamond surrounded by polished onyx.', 0, 0.25),
('provision_jewelry_pearl_bracelet', 'Durant Pearl Bracelet', 10, 1, 'item_standard', 1, 894, 1, '{}', 'An intricate link bracelet with natural pearls and gold filigree.', 0, 0.25),
('provision_jewelry_pearl_earring', 'Josephine Pearl Earrings', 10, 1, 'item_standard', 1, 895, 1, '{}', 'Fashionable pearl earrings with neat gold hooks.', 0, 0.25),
('provision_jewelry_pearl_ring', 'Bonnard Pearl Ring', 10, 1, 'item_standard', 1, 896, 1, '{}', 'A valuable pearl set into a white gold band.', 0, 0.25),
('provision_jewelry_pers_turq_ring', 'Thorburn Turquoise Ring', 10, 1, 'item_standard', 1, 897, 1, '{}', 'A delicately crafted rose gold ring with turquoise beads.', 0, 0.25),
('provision_jewelry_porcelain_necklace', 'Braxton Amethyst Necklace', 10, 1, 'item_standard', 1, 898, 1, '{}', 'A fashionable necklace with a porcelain hand painted miniature.', 0, 0.25),
('provision_jewelry_qn_dmnd_earring', 'Royal Victoria Diamond Earrings', 10, 1, 'item_standard', 1, 899, 1, '{}', 'A series of small diamonds claw set in a floral cluster on a white gold band.', 0, 0.25),
('provision_jewelry_rudy_dngl_earring', 'Beauchêne Ruby Earrings', 10, 1, 'item_standard', 1, 900, 1, '{}', 'Elaborate gold hook earrings with vivid rubies.', 0, 0.25),
('provision_jewelry_slvr_pearl_necklace', 'Silver Pearl Necklace', 10, 1, 'item_standard', 1, 901, 1, '{}', 'A necklace made of fine silver and pearls.', 0, 0.25),
('provision_jewelry_sphr_bngle_bracelet', 'Greco Sapphire Bracelet', 10, 1, 'item_standard', 1, 902, 1, '{}', 'A delicate gold bracelet with three small sapphires.', 0, 0.25),
('provision_jewelry_sphr_bracelet', 'Helena Sapphire Bracelet', 10, 1, 'item_standard', 1, 903, 1, '{}', 'A fine silver bracelet with claw set sapphires.', 0, 0.25),
('provision_jewelry_topaz_necklace', 'Dane Topaz Necklace', 10, 1, 'item_standard', 1, 904, 1, '{}', 'A precious platinum chain necklace with a small drop of topaz.', 0, 0.25),
('provision_jewelry_topaz_ring', 'Banais Topaz Ring', 10, 1, 'item_standard', 1, 905, 1, '{}', 'A neat silver wedding ring with brilliant cut topaz.', 0, 0.25),
('provision_jewelry_turquoise_bracelet', 'Infanta Turquoise Bracelet', 10, 1, 'item_standard', 1, 906, 1, '{}', 'A solid silver bracelet with a large turquoise stone.', 0, 0.25),
('provision_jewelry_turquoise_ring', 'Magnate Turquoise Ring', 10, 1, 'item_standard', 1, 907, 1, '{}', 'A solid gold ring with an oval of polished turquoise from Persia.', 0, 0.25),
('provision_jewelry_turq_stud_earring', 'Calumet Turquoise Earrings', 10, 1, 'item_standard', 1, 908, 1, '{}', 'Lavish gold studs with claw set turquoise stones.', 0, 0.25),
('provision_jewelry_whtgld_dmnd_ring', 'Sackville Diamond Ring', 10, 1, 'item_standard', 1, 909, 1, '{}', 'A series of small diamonds claw set in a floral cluster on a white gold band.', 0, 0.25),
('provision_jewelry_wht_dmnd_earring', 'Endicott Diamond Earrings', 10, 1, 'item_standard', 1, 910, 1, '{}', 'Exquisite pendant earrings with old mine cut diamonds.', 0, 0.25),
('provision_jewelry_ylwgld_dmnd_ring', 'Yates Diamond Ring', 10, 1, 'item_standard', 1, 911, 1, '{}', 'An intricate gold band with one cushion cut diamond.', 0, 0.25),
('provision_ring_platinum', 'Platinum Ring', 10, 1, 'item_standard', 1, 912, 1, '{}', 'A finely crafted platinum ring.', 0, 0.25),
('provision_ro_flower_acunas_star', 'Acunas Star Orchid', 10, 1, 'item_standard', 1, 913, 1, '{}', 'The Acunas Star Orchid an be identified by the branching of the stems, alternate leaves, and cream colored petals. The trailing plant is often found on the ground or growing around trees in swampland areas.', 0, 0.25),
('provision_ro_flower_cigar', 'Cigar Orchid', 10, 1, 'item_standard', 1, 914, 1, '{}', 'The Cigar Orchid can be identified by the inflorescence which can produce around five hundred bright yellow flowers with purple and brown markings.', 0, 0.25),
('provision_ro_flower_clamshell', 'Clamshell Orchid', 10, 1, 'item_standard', 1, 915, 1, '{}', 'The Clamshell Orchid can be identified by the deep purple and white petals with yellow streaks, and thin leaves.', 0, 0.25),
('provision_ro_flower_dragons', 'Dragons Orchid', 10, 1, 'item_standard', 1, 916, 1, '{}', 'Dragons Mouth Orchids can be recognized by their wild purple flowers which are said to resemble a dragon. The general size of this type of orchid is around six inches.', 0, 0.25),
('provision_ro_flower_ghost', 'Ghost Orchid', 10, 1, 'item_standard', 1, 917, 1, '{}', 'The Ghost Orchid is named after the white to pale pink flowers that can be seen in shaded habitats. This small orchid grows in shaded areas, such as woodlands, and under leaves and soil, with only the flower appearing above ground.', 0, 0.25),
('provision_ro_flower_lady_of_night', 'Lady of Night Orchid', 10, 1, 'item_standard', 1, 918, 1, '{}', 'Lady of the Night Orchid takes its name from the sweet citrus fragrance it produces during nightfall. The orchid can be identified by the white heart shaped flowers and long leaves.', 0, 0.25),
('provision_ro_flower_lady_slipper', 'Lady Slipper Orchid', 10, 1, 'item_standard', 1, 919, 1, '{}', 'Lady Slipper Orchid can be identified by the large bulbous purple flower and speckled purple leaves. This type of orchid can be seen growing in the ground of forests, meadows and woodland areas.', 0, 0.25),
('provision_ro_flower_moccasin', 'Moccasin Orchid', 10, 1, 'item_standard', 1, 920, 1, '{}', 'Moccasin Flower Orchid can be identified by the yellow pouch like petal, red sepals, and wide leaves. This orchid can be found growing near pines or conifers in woodlands and forests.', 0, 0.25),
('provision_ro_flower_night_scented', 'Night Scented Orchid', 10, 1, 'item_standard', 1, 921, 1, '{}', 'Night Scented Orchid can be identified by the alternate stems, the long sepals, and white petal flowers. This orchid can be found growing upon another plant, often draping down from trees.', 0, 0.25),
('provision_ro_flower_queens', 'Queens Orchid', 10, 1, 'item_standard', 1, 922, 1, '{}', 'The Queens Orchid can be identified by the white sepals, and purple and white curled petal.', 0, 0.25),
('provision_ro_flower_rat_tail', 'Rat Tail Orchid', 10, 1, 'item_standard', 1, 923, 1, '{}', 'The Rat Tail Orchid has long, thin hanging stems, pencil-like leaves and rigid flowering stems bearing up to twelve crowded white to cream-coloured flowers.', 0, 0.25),
('provision_ro_flower_sparrows', 'Sparrows Orchid', 10, 1, 'item_standard', 1, 924, 1, '{}', 'The Sparrows Orchid usually has 3 to 7 oval or lance-shaped leaves arranged alternately on the stem.', 0, 0.25),
('provision_ro_flower_spider', 'Spider Orchid', 10, 1, 'item_standard', 1, 925, 1, '{}', 'The Spider Orchid is Characterised by five long spreading petals and sepals around a broad down-curled lip.', 0, 0.25),
('pulp', 'Pulp', 20, 1, 'item_standard', 0, 542, 1, '{}', 'A soft and moist mass of plant fibers, typically obtained from crushing or processing plant materials.', 0, 0.25),
('p_baitBread01x', 'Bread Bait', 20, 1, 'item_standard', 1, 543, 1, '{}', 'A piece of bread used as bait for fishing.', 0, 0.25),
('p_baitCheese01x', 'Cheese Bait', 10, 1, 'item_standard', 1, 946, 1, '{}', 'A soft cheese bait, favored by fish with a strong sense of smell like catfish.', 0, 0.25),
('p_baitCorn01x', 'Corn Bait', 10, 1, 'item_standard', 1, 945, 1, '{}', 'A simple bait made from corn, commonly used to attract small freshwater fish.', 0, 0.25),
('p_baitCricket01x', 'Cricket Bait', 10, 1, 'item_standard', 1, 948, 1, '{}', 'A lively bait made from crickets, effective for attracting larger fish.', 0, 0.25),
('p_baitWorm01x', 'Worm Bait', 10, 1, 'item_standard', 1, 947, 1, '{}', 'A classic bait made from worms, ideal for catching a wide variety of fish species.', 0, 0.25),
('p_barrelmoonshine', 'Barrel', 1, 1, 'item_standard', 1, 544, 1, '{}', 'A container, typically made of wood, used for storing and aging moonshine.', 0, 0.25),
('p_crawdad01x', 'Crawfish Bait', 10, 1, 'item_standard', 1, 949, 1, '{}', 'A freshwater bait made from crawfish, used to catch larger predatory fish.', 0, 0.25),
('p_FinisdFishlure01x', 'Fish Lure', 10, 1, 'item_standard', 1, 951, 1, '{}', 'A versatile fish lure designed to attract a variety of freshwater species.', 0, 0.25),
('p_finisdfishlurelegendary01x', 'Legendary Fish Lure', 10, 1, 'item_standard', 1, 954, 1, '{}', 'A premium fish lure designed to catch elusive legendary fish.', 0, 0.25),
('p_finishdcrawd01x', 'Crawfish Lure', 10, 1, 'item_standard', 1, 952, 1, '{}', 'A lure that mimics the movement of a crawfish, enticing larger predatory fish.', 0, 0.25),
('p_finishdcrawdlegendary01x', 'Legendary Crawfish Lure', 10, 1, 'item_standard', 1, 955, 1, '{}', 'A specialized crawfish lure made for catching rare legendary fish.', 0, 0.25),
('p_finishedragonfly01x', 'Dragonfly Lure', 10, 1, 'item_standard', 1, 950, 1, '{}', 'A realistic dragonfly lure designed to mimic flying insects, perfect for catching surface-feeding fish.', 0, 0.25),
('p_finishedragonflylegendary01x', 'Legendary Dragonfly Lure', 10, 1, 'item_standard', 1, 953, 1, '{}', 'A high-quality dragonfly lure crafted to attract legendary fish in special locations.', 0, 0.25),
('p_goldcradlestand01x', 'Gold Wash Table', 1, 1, 'item_standard', 1, 1060, 1, '{}', 'nice item', 0, 0.25),
('p_lgoc_spinner_v4', 'Spinner V4', 10, 1, 'item_standard', 1, 956, 1, '{}', 'A high-speed spinner lure, perfect for attracting aggressive, fast-moving fish.', 0, 0.25),
('p_lgoc_spinner_v6', 'Spinner V6', 10, 1, 'item_standard', 1, 957, 1, '{}', 'An advanced spinner lure with enhanced spinning action, ideal for large, deep-water fish.', 0, 0.25),
('quailb', 'Quail Beak', 20, 1, 'item_standard', 1, 545, 1, '{}', 'The beak of a quail bird, often used for crafts and decorative purposes.', 0, 0.25),
('quailf', 'Quail Feather', 20, 1, 'item_standard', 1, 546, 1, '{}', 'A feather from a quail bird, known for its small size and distinctive patterns.', 0, 0.25),
('quartz', 'Quartz', 20, 1, 'item_standard', 1, 547, 1, '{}', 'A hard mineral often used in jewelry and decorative items.', 0, 0.25),
('rabbitpaw', 'Rabbitfoot', 20, 1, 'item_standard', 1, 548, 1, '{}', 'The foot of a rabbit, sometimes considered a good luck charm.', 0, 0.25),
('rabbits', 'Rabbit Skin', 20, 1, 'item_standard', 1, 549, 1, '{}', 'The skin of a rabbit, commonly used in making fur garments and accessories.', 0, 0.25),
('raccoons', 'Raccoon Skin', 20, 1, 'item_standard', 1, 550, 1, '{}', 'The skin of a raccoon, known for its distinctive ringed tail and soft fur.', 0, 0.25),
('raccoont', 'Raccoon Tooth', 20, 1, 'item_standard', 1, 551, 1, '{}', 'A tooth from a raccoon, often used in crafts and jewelry.', 0, 0.25),
('raisin', 'Raisin', 10, 1, 'item_standard', 1, 926, 1, '{}', 'A dried grape that makes good eating.', 0, 0.25),
('rajahdysoljy', 'Explosive Oil', 30, 1, 'item_standard', 1, 552, 1, '{}', 'An explosive oil used for various purposes, such as creating dynamite and explosives.', 0, 0.25),
('ramhorn', 'Ram Horn', 20, 1, 'item_standard', 1, 553, 1, '{}', 'The horn of a ram, a male sheep, often used in crafting and decoration.', 0, 0.25),
('rams', 'Ram Pelt', 20, 1, 'item_standard', 1, 554, 1, '{}', 'The fur and skin of a ram, known for its warmth and durability.', 0, 0.25),
('Rams_Head', 'Rams Head', 10, 1, 'item_standard', 1, 555, 1, '{}', 'The preserved head of a ram, often used as a hunting trophy or decorative item.', 0, 0.25),
('Rams_Head_Seed', 'Rams Head Seed', 10, 1, 'item_standard', 1, 556, 1, '{}', 'A seed that can be planted to grow plants resembling a rams head.', 0, 0.25),
('raspberryale', 'Raspberry Ale', 10, 1, 'item_standard', 1, 557, 1, '{}', 'A type of ale infused with the flavor of raspberries.', 0, 0.25),
('rat_c', 'Rat', 20, 1, 'item_standard', 1, 558, 1, '{}', 'A small rodent known for its agility and ability to adapt to various environments.', 0, 0.25),
('ravenc', 'Raven Claws', 20, 1, 'item_standard', 1, 559, 1, '{}', 'The claws of a raven bird, often used for crafts and jewelry.', 0, 0.25),
('ravenf', 'Raven Feather', 20, 1, 'item_standard', 1, 560, 1, '{}', 'A feather from a raven bird, known for its glossy black color and sleek appearance.', 0, 0.25),
('raw_bacon', 'Raw Bacon', 10, 1, 'item_standard', 1, 927, 1, '{}', 'Raw uncooked bacon.', 0, 0.25),
('rectable', 'Rectangle Table', 20, 1, 'item_standard', 1, 561, 1, '{}', 'A rectangular-shaped table, suitable for various purposes such as dining or work.', 0, 0.25),
('rectangle_table', 'Rectangle Table', 20, 1, 'item_standard', 1, 562, 1, '{}', 'A table with a rectangular shape, often used for dining or as a work surface.', 0, 0.25),
('Red_Raspberry', 'Red Raspberry', 10, 1, 'item_standard', 1, 563, 1, '{}', 'A type of raspberry with a red color, commonly used in desserts and preserves.', 0, 0.25),
('Red_Raspberry_Seed', 'Red Raspberry Seed', 10, 1, 'item_standard', 1, 564, 1, '{}', 'A seed that can be planted to grow red raspberry plants.', 0, 0.25),
('Red_Sage', 'Red Sage', 10, 1, 'item_standard', 1, 565, 1, '{}', 'A type of sage plant with red-colored flowers, often used in herbal remedies and smudging ceremonies.', 0, 0.25),
('Red_Sage_Seed', 'Red Sage Seed', 10, 1, 'item_standard', 1, 566, 1, '{}', 'A seed that can be planted to grow red sage plants.', 0, 0.25),
('repeaterbarrel', 'Repeater Barrel', 5, 1, 'item_standard', 1, 567, 1, '{}', 'A replacement barrel for a repeater firearm, used for improving accuracy and performance.', 0, 0.25),
('repeatermold', 'Repeater Mold', 5, 1, 'item_standard', 1, 568, 1, '{}', 'A mold used for casting the components of a repeater firearm.', 0, 0.25),
('repeaterreceiver', 'Repeater Receiver', 5, 1, 'item_standard', 1, 569, 1, '{}', 'A replacement receiver for a repeater firearm, which houses the firing mechanism.', 0, 0.25),
('repeaterrecmold', 'Repeater Receiver Mold', 5, 1, 'item_standard', 1, 570, 1, '{}', 'A mold used for casting the receiver of a repeater firearm.', 0, 0.25),
('repeaterstock', 'Repeater Stock', 5, 1, 'item_standard', 1, 571, 1, '{}', 'A replacement stock for a repeater firearm, providing stability and control.', 0, 0.25),
('revolverbarrel', 'Revolver Barrel', 5, 1, 'item_standard', 1, 572, 1, '{}', 'A replacement barrel for a revolver firearm, used for improving accuracy and performance.', 0, 0.25),
('revolvercylinder', 'Revolver Cylinder', 5, 1, 'item_standard', 1, 573, 1, '{}', 'A replacement cylinder for a revolver firearm, which holds the ammunition.', 0, 0.25),
('revolverhandle', 'Revolver Handle', 5, 1, 'item_standard', 1, 574, 1, '{}', 'A replacement handle for a revolver firearm, providing grip and control.', 0, 0.25),
('revolvermold', 'Revolver Mold', 5, 1, 'item_standard', 1, 575, 1, '{}', 'A mold used for casting the components of a revolver firearm.', 0, 0.25),
('riflebarrel', 'Rifle Barrel', 5, 1, 'item_standard', 1, 576, 1, '{}', 'A replacement barrel for a rifle firearm, used for improving accuracy and performance.', 0, 0.25),
('riflemold', 'Rifle Mold', 5, 1, 'item_standard', 1, 577, 1, '{}', 'A mold used for casting the components of a rifle firearm.', 0, 0.25),
('riflereceiver', 'Rifle Receiver', 5, 1, 'item_standard', 1, 578, 1, '{}', 'A replacement receiver for a rifle firearm, which houses the firing mechanism.', 0, 0.25),
('riflerecmold', 'Rifle Receiver Mold', 5, 1, 'item_standard', 1, 579, 1, '{}', 'A mold used for casting the receiver of a rifle firearm.', 0, 0.25),
('riflestock', 'Rifle Stock', 5, 1, 'item_standard', 1, 580, 1, '{}', 'A replacement stock for a rifle firearm, providing stability and control.', 0, 0.25),
('roach', 'Roach', 10, 1, 'item_standard', 0, 581, 1, '{}', 'A small insect commonly found in households and other environments.', 0, 0.25),
('robberyplanning', 'Robbery Planning Set', 20, 1, 'item_standard', 1, 582, 1, '{}', 'A set of tools and materials used for planning a robbery or heist.', 0, 0.25),
('robin_c', 'Robin', 20, 1, 'item_standard', 1, 583, 1, '{}', 'A small songbird known for its red breast and melodious voice.', 0, 0.25),
('rock', 'Rock', 30, 1, 'item_standard', 0, 584, 1, '{}', 'A solid mineral material that forms the Earths crust, commonly found in various shapes and sizes.', 0, 0.25),
('rollingpaper', 'Rolling paper', 30, 1, 'item_standard', 1, 585, 1, '{}', 'A thin, lightweight paper used for rolling cigarettes or other smoking materials.', 0, 0.25),
('rope', 'Rope', 50, 1, 'item_standard', 0, 1049, 1, '{}', 'nice item', 0, 0.25),
('roundtable', 'Round Table', 20, 1, 'item_standard', 1, 586, 1, '{}', 'A circular table with a flat top surface, often used for dining or discussions.', 0, 0.25),
('round_table', 'Round Table', 20, 1, 'item_standard', 1, 587, 1, '{}', 'A table with a round top surface, typically used for dining or meetings.', 0, 0.25),
('rspoonb', 'Roseta Spoonbill beak', 20, 1, 'item_standard', 1, 588, 1, '{}', 'The long, slender beak of a Roseta Spoonbill bird, known for its distinctive shape and color.', 0, 0.25),
('rspoonf', 'Roseta Spoonbill feather', 20, 1, 'item_standard', 1, 589, 1, '{}', 'A feather from a Roseta Spoonbill bird, often used in crafts and decorative items.', 0, 0.25),
('rubber', 'Rubber', 20, 1, 'item_standard', 0, 590, 1, '{}', 'A flexible, elastic material derived from the sap of certain plants or synthesized chemically.', 0, 0.25),
('rubbertube', 'Rubber Tube', 5, 1, 'item_standard', 0, 591, 1, '{}', 'A cylindrical tube made of rubber, commonly used for various applications such as plumbing or medical procedures.', 0, 0.25),
('salamelle', 'Fresh Pork ', 20, 1, 'item_standard', 1, 592, 1, '{}', 'Fresh pork salamelle', 0, 0.25),
('salmon', 'Salmon', 10, 1, 'item_standard', 0, 593, 1, '{}', 'Fresh salmon', 0, 0.25),
('salt', 'Salt', 20, 1, 'item_standard', 1, 594, 1, '{}', 'Common salt', 0, 0.25),
('Saltbush', 'Saltbush', 10, 1, 'item_standard', 1, 595, 1, '{}', 'Saltbush plant', 0, 0.25),
('Saltbush_Seed', 'Saltbush Seed', 10, 1, 'item_standard', 1, 596, 1, '{}', 'Seed of Saltbush plant', 0, 0.25),
('sandbag', 'Sandbag', 10, 1, 'item_standard', 1, 928, 1, '{}', 'A bag of sand. often used in construction.', 0, 0.25),
('sandpaper', 'Sandpaper', 10, 1, 'item_standard', 1, 929, 1, '{}', 'A sheet of sandpaper used for smoothing wood.', 0, 0.25),
('sap', 'Sap', 20, 1, 'item_standard', 0, 597, 1, '{}', 'Sticky sap', 0, 0.25),
('sarsaparilla', 'Sarsaparilla', 10, 1, 'item_standard', 1, 598, 1, '{}', 'Medicinal sarsaparilla', 0, 0.25),
('scale', 'Scale', 5, 1, 'item_standard', 1, 599, 1, '{}', 'Measuring scale', 0, 0.25),
('scentg', 'Scent glad', 20, 1, 'item_standard', 1, 600, 1, '{}', 'Scented glad', 0, 0.25),
('screwdriver', 'Screwdriver', 50, 1, 'item_standard', 0, 1052, 1, '{}', 'nice item', 0, 0.25),
('seagullb', 'Seagull beak', 20, 1, 'item_standard', 1, 601, 1, '{}', 'Beak of a seagull', 0, 0.25),
('seagullf', 'Seagull feather', 20, 1, 'item_standard', 1, 602, 1, '{}', 'Feather from a seagull', 0, 0.25),
('secondchance', 'Second Chance', 10, 1, 'item_standard', 1, 603, 1, '{}', 'Opportunity for a second chance', 0, 0.25),
('sheephead', 'Sheep head', 20, 1, 'item_standard', 1, 604, 1, '{}', 'Head of a sheep', 0, 0.25),
('shellcasing', 'Shell Casing', 40, 1, 'item_standard', 1, 605, 1, '{}', 'Empty shell casing', 0, 0.25),
('shootingtarget', 'Shooting Target', 20, 1, 'item_standard', 1, 606, 1, '{}', 'Target for shooting practice', 0, 0.25),
('shotgunbarrel', 'Shotgun Barrel', 5, 1, 'item_standard', 1, 607, 1, '{}', 'Barrel for a shotgun', 0, 0.25),
('shotgunmold', 'Shotgun Mold', 5, 1, 'item_standard', 1, 608, 1, '{}', 'Mold for a shotgun', 0, 0.25),
('shotgunstock', 'Shotgun Stock', 5, 1, 'item_standard', 1, 609, 1, '{}', 'Stock for a shotgun', 0, 0.25),
('shovel', 'Shovel', 50, 1, 'item_standard', 0, 1059, 1, '{}', 'nice item', 0, 0.25),
('shrimps', 'Shrimp Stew', 1, 1, 'item_standard', 1, 610, 1, '{}', 'Delicious shrimp stew', 0, 0.25),
('sidetable', 'side table 1', 20, 1, 'item_standard', 1, 611, 1, '{}', 'Functional side table', 0, 0.25),
('sidetablea', 'side table 2', 20, 1, 'item_standard', 1, 612, 1, '{}', 'Stylish side table', 0, 0.25),
('sidetableb', 'side table 3', 20, 1, 'item_standard', 1, 613, 1, '{}', 'A beautiful side table', 0, 0.25),
('side_table', 'side table 1', 20, 1, 'item_standard', 1, 614, 1, '{}', 'A stylish side table', 0, 0.25),
('side_tablea', 'side table 2', 20, 1, 'item_standard', 1, 615, 1, '{}', 'An elegant side table', 0, 0.25),
('side_tableb', 'side table 3', 20, 1, 'item_standard', 1, 616, 1, '{}', 'A modern side table', 0, 0.25),
('singlebed', 'single bed', 20, 1, 'item_standard', 1, 617, 1, '{}', 'A comfortable single bed', 0, 0.25),
('skullpost', 'Skull Post', 20, 1, 'item_standard', 1, 618, 1, '{}', 'A decorative skull post', 0, 0.25),
('smallchest', 'Small Chest', 1, 1, 'item_standard', 1, 619, 1, '{}', 'A small storage chest', 0, 0.25),
('smallmcandle', 'Small Melted Candle', 20, 1, 'item_standard', 1, 620, 1, '{}', 'A small melted candle', 0, 0.25),
('Small_Leather', 'Small Leather', 10, 1, 'item_standard', 1, 621, 1, '{}', 'A small piece of leather', 0, 0.25),
('SnakeSkin', 'Snake Skin', 20, 1, 'item_standard', 1, 622, 1, '{}', 'A snake skin', 0, 0.25),
('snaket', 'Snake tooth', 20, 1, 'item_standard', 1, 623, 1, '{}', 'A tooth from a snake', 0, 0.25),
('Snake_Poison', 'Snake Poison', 10, 1, 'item_standard', 1, 624, 1, '{}', 'Poison extracted from a snake', 0, 0.25),
('soborno', 'Soborno Alcohol', 15, 1, 'item_standard', 0, 625, 1, '{}', 'A bottle of Soborno alcohol', 0, 0.25),
('songbird2_c', 'Scarlet songbird', 20, 1, 'item_standard', 1, 626, 1, '{}', 'A beautiful scarlet songbird', 0, 0.25),
('songbird_c', 'Songbird', 20, 1, 'item_standard', 1, 627, 1, '{}', 'A lovely songbird', 0, 0.25),
('sparrow0_c', 'Common Sparrow', 20, 1, 'item_standard', 1, 628, 1, '{}', 'A common sparrow', 0, 0.25),
('sparrow1_c', 'Sparrow', 20, 1, 'item_standard', 1, 629, 1, '{}', 'A sparrow', 0, 0.25),
('sparrow2_c', 'Golden Sparrow', 20, 1, 'item_standard', 1, 630, 1, '{}', 'A golden sparrow', 0, 0.25),
('spool', 'Spool', 10, 1, 'item_standard', 1, 930, 1, '{}', 'A empty spool. often used to wrap wire around.', 0, 0.25),
('squirrel_black_c', 'Black Squirrel', 20, 1, 'item_standard', 1, 631, 1, '{}', 'A black squirrel', 0, 0.25),
('squirrel_grey_c', 'Gray Squirrel', 20, 1, 'item_standard', 1, 632, 1, '{}', 'A gray squirrel', 0, 0.25),
('squirrel_red_c', 'Red Squirrel', 20, 1, 'item_standard', 1, 633, 1, '{}', 'A Red squirrel', 0, 0.25),
('standard_table', 'Table', 20, 1, 'item_standard', 1, 634, 1, '{}', 'A standard table for various uses.', 0, 0.25),
('standingtorch', 'Standing Torch', 20, 1, 'item_standard', 1, 635, 1, '{}', 'A standing torch to provide light.', 0, 0.25),
('steak', 'Steak', 10, 1, 'item_standard', 1, 636, 1, '{}', 'A delicious steak for a hearty meal.', 0, 0.25),
('steakveg', 'Steak with Veggies', 10, 1, 'item_standard', 1, 637, 1, '{}', 'A balanced meal with steak and vegetables.', 0, 0.25),
('stillkit', 'Still Kit', 5, 1, 'item_standard', 1, 638, 1, '{}', 'A kit for setting up a still to make distilled spirits.', 0, 0.25),
('stim', 'Horse Stimulant', 2, 1, 'item_standard', 1, 639, 1, '{}', 'A stimulant to boost a horses performance.', 0, 0.25),
('stolenmerch', 'Stolen Items', 10, 1, 'item_standard', 0, 640, 1, '{}', 'Various stolen items of questionable origin.', 0, 0.25),
('stonehammer', 'Stone Hammer', 5, 1, 'item_standard', 1, 641, 1, '{}', 'A durable hammer made of stone.', 0, 0.25),
('string', 'String', 10, 1, 'item_standard', 1, 931, 1, '{}', 'A bundle of string with many uses.', 0, 0.25),
('stringy', 'Stringy Meat', 20, 1, 'item_standard', 1, 642, 1, '{}', 'Tough and chewy meat that requires thorough cooking.', 0, 0.25),
('sugar', 'Sugar', 20, 1, 'item_standard', 0, 643, 1, '{}', 'A sweet and granulated substance used for sweetening.', 0, 0.25),
('sugarcaneseed', 'Sugarcane Seed', 10, 1, 'item_standard', 1, 644, 1, '{}', 'Seeds for growing sugarcane.', 0, 0.25),
('sugarcube', 'Sugar Cube', 10, 1, 'item_standard', 1, 645, 1, '{}', 'A compact form of sugar for easy use.', 0, 0.25),
('sulfur', 'Sulfur', 30, 1, 'item_standard', 0, 646, 1, '{}', 'A yellow chemical element often used in manufacturing.', 0, 0.25),
('syn', 'Syn', 50, 1, 'item_standard', 1, 647, 1, '{}', 'A synthetic substance used for various purposes.', 0, 0.25),
('synpackage', 'Syn Package', 10, 1, 'item_standard', 1, 648, 1, '{}', 'A package containing synthetic substances.', 0, 0.25),
('syringe', 'Syringe', 20, 1, 'item_standard', 1, 649, 1, '{}', 'A medical instrument used for injecting fluids.', 0, 0.25),
('syringecert', 'Syringe Cert', 10, 1, 'item_standard', 1, 651, 1, '{}', 'A certification for the proper use of syringes.', 0, 0.25),
('syringe_2', 'Syringe', 20, 1, 'item_standard', 1, 650, 1, '{}', 'A medical instrument used for injecting fluids.', 0, 0.25),
('teabag', 'Teabag', 10, 1, 'item_standard', 1, 932, 1, '{}', 'A teabag for making that perfect cup.', 0, 0.25),
('tealeaf', 'Tealeaf', 10, 1, 'item_standard', 1, 933, 1, '{}', 'Used to make tea or teabags.', 0, 0.25),
('tent', 'Tent', 1, 1, 'item_standard', 1, 652, 1, '{}', 'A portable shelter for camping or temporary use.', 0, 0.25),
('tent2', 'Trader Tent', 20, 1, 'item_standard', 1, 653, 1, '{}', 'A tent specifically designed for trading purposes.', 0, 0.25),
('tent3', 'Simple Tent', 20, 1, 'item_standard', 1, 654, 1, '{}', 'A basic tent for camping.', 0, 0.25),
('tent4', 'Canvas Shade', 20, 1, 'item_standard', 1, 655, 1, '{}', 'A canvas shade for shelter.', 0, 0.25),
('tequila', 'Tequila', 10, 1, 'item_standard', 1, 656, 1, '{}', 'A bottle of tequila.', 0, 0.25),
('Texas_Bonnet', 'Texas Bonnet', 10, 1, 'item_standard', 1, 657, 1, '{}', 'A traditional Texas bonnet.', 0, 0.25),
('Texas_Bonnet_Seed', 'Texas Bonnet Seed', 10, 1, 'item_standard', 1, 658, 1, '{}', 'Seeds to grow Texas Bonnet flowers.', 0, 0.25),
('timber', 'Timber', 10, 1, 'item_standard', 1, 934, 1, '{}', 'A sturdy chunck of timber.', 0, 0.25),
('timbertable', 'Timber Table', 20, 1, 'item_standard', 1, 659, 1, '{}', 'A sturdy table made of timber.', 0, 0.25),
('timber_table', 'Timber Table', 20, 1, 'item_standard', 1, 660, 1, '{}', 'A table made of timber.', 0, 0.25),
('tipi', 'Native Tipi', 20, 1, 'item_standard', 1, 661, 1, '{}', 'A traditional Native American tipi.', 0, 0.25),
('toaddesert_c', 'Desert Toad', 20, 1, 'item_standard', 1, 662, 1, '{}', 'A toad found in the desert.', 0, 0.25),
('toadpoison_c', 'Poisoned Toad', 20, 1, 'item_standard', 1, 663, 1, '{}', 'A toad that carries poison.', 0, 0.25),
('toad_c', 'Toad', 20, 1, 'item_standard', 1, 664, 1, '{}', 'A common toad.', 0, 0.25),
('token', 'Camp License', 5, 1, 'item_standard', 1, 665, 1, '{}', 'A license for setting up a camp.', 0, 0.25),
('toolbarrel', 'Tool Barrel', 20, 1, 'item_standard', 1, 666, 1, '{}', 'A barrel for storing tools.', 0, 0.25),
('tool_barrel', 'Tool Barrel', 20, 1, 'item_standard', 1, 667, 1, '{}', 'A barrel used for storing tools.', 0, 0.25),
('trainkey', 'Train Key', 1, 1, 'item_standard', 1, 668, 1, '{}', 'A key to unlock a train.', 0, 0.25),
('trainoil', 'Train Oil', 10, 1, 'item_standard', 0, 1050, 1, '{}', 'nice item', 0, 0.25),
('trayoffood', 'Serving Table', 20, 1, 'item_standard', 1, 669, 1, '{}', 'A table used for serving food.', 0, 0.25),
('tropicalPunchMash', 'Ginseng Mash', 10, 1, 'item_standard', 0, 670, 1, '{}', 'A mash made from ginseng.', 0, 0.25),
('tropicalPunchMoonshine', 'Ginseng Moonshine', 10, 1, 'item_standard', 1, 671, 1, '{}', 'Moonshine infused with ginseng.', 0, 0.25),
('trout', 'Trout', 10, 1, 'item_standard', 0, 672, 1, '{}', 'A fish of the trout family.', 0, 0.25),
('turkeyb', 'Turkey beak', 20, 1, 'item_standard', 1, 673, 1, '{}', 'The beak of a turkey.', 0, 0.25),
('turkeyf', 'Turkey feather', 20, 1, 'item_standard', 1, 674, 1, '{}', 'A feather from a turkey.', 0, 0.25),
('TurtleShell', 'Turtle Shell', 20, 1, 'item_standard', 1, 675, 1, '{}', 'The shell of a turtle.', 0, 0.25),
('turtlet', 'Turtle tooth', 20, 1, 'item_standard', 1, 676, 1, '{}', 'A tooth extracted from a turtle.', 0, 0.25),
('tylenol', 'Tylenol', 10, 1, 'item_standard', 1, 677, 1, '{}', 'A medication called Tylenol.', 0, 0.25),
('undertaker1', 'Coffin', 20, 1, 'item_standard', 1, 678, 1, '{}', 'A wooden coffin.', 0, 0.25),
('undertaker2', 'Flower Coffin', 20, 1, 'item_standard', 1, 679, 1, '{}', 'A coffin decorated with flowers.', 0, 0.25),
('unique_brad_horsesugar', 'Brad Horse Sugar', 5, 1, 'item_standard', 1, 680, 1, '{}', 'Sugar used for horses owned by Brad.', 0, 0.25),
('unique_horse_feed', 'Horse Feed', 5, 1, 'item_standard', 1, 681, 1, '{}', 'Feed for horses.', 0, 0.25),
('vanillacake', 'Vanilla Cake', 10, 1, 'item_standard', 1, 935, 1, '{}', 'A tasty vanilla flavored cake.', 0, 0.25),
('vanillaFlower', 'Vanille Flower', 20, 1, 'item_standard', 0, 682, 1, '{}', 'A flower known as Vanille.', 0, 0.25),
('varnish', 'Varnish', 10, 1, 'item_standard', 1, 936, 1, '{}', 'A typical wood finish made from oils and resins.', 0, 0.25),
('venison', 'Venison', 20, 1, 'item_standard', 1, 683, 1, '{}', 'Lean meat obtained from deer.', 0, 0.25),
('Violet_Snowdrop', 'Violet Snowdrop', 10, 1, 'item_standard', 1, 684, 1, '{}', 'A delicate flower called Violet Snowdrop.', 0, 0.25),
('Violet_Snowdrop_Seed', 'Violet Snowdrop Seed', 10, 1, 'item_standard', 1, 685, 1, '{}', 'Seeds to grow Violet Snowdrop flowers.', 0, 0.25),
('vodka', 'Vodka', 10, 1, 'item_standard', 1, 686, 1, '{}', 'A strong alcoholic beverage known as Vodka.', 0, 0.25),
('Volture_Egg', 'Volture Egg', 10, 1, 'item_standard', 1, 687, 1, '{}', 'An egg laid by a Volture bird.', 0, 0.25),
('vulturetaxi', 'Vulture Taxidermy', 20, 1, 'item_standard', 1, 688, 1, '{}', 'A taxidermy of a vulture bird.', 0, 0.25),
('vulture_taxidermy', 'Vulture Taxidermy', 20, 1, 'item_standard', 1, 689, 1, '{}', 'A preserved vulture bird for display.', 0, 0.25),
('washtub', 'Wash Tub', 20, 1, 'item_standard', 1, 690, 1, '{}', 'A tub used for washing clothes or other items.', 0, 0.25),
('water', 'Water', 15, 1, 'item_standard', 1, 691, 1, '{}', 'Clean drinking water.', 0, 0.25),
('waterbarrel', 'Water Barrel', 20, 1, 'item_standard', 1, 692, 1, '{}', 'A large barrel used for storing water.', 0, 0.25),
('wateringcan', 'Water Jug', 10, 1, 'item_standard', 1, 693, 1, '{}', 'A bucket of clean water.', 0, 0.25),
('wateringcan_dirtywater', 'Dirty Water Jug', 10, 1, 'item_standard', 1, 694, 1, '{}', 'A bucket filled with dirty water.', 0, 0.25),
('wateringcan_empty', 'Empty Watering Jug', 10, 1, 'item_standard', 1, 695, 1, '{}', 'An empty water bucket.', 0, 0.25),
('waterpump', 'Water Pump', 20, 1, 'item_standard', 1, 696, 1, '{}', 'A device used for pumping water.', 0, 0.25),
('water_pump', 'Water Pump', 20, 1, 'item_standard', 1, 697, 1, '{}', 'A pump designed to move water.', 0, 0.25),
('weapons_craftbook', 'Weapons Craftbook', 1, 1, 'item_standard', 1, 1020, 1, '{}', 'Used to open the weapons crafting menu.', 0, 0.25),
('wedding_chain_ring', 'Wedding Ring on chain', 10, 1, 'item_standard', 1, 937, 1, '{}', 'A wedding ring on chain. usally worn this way so they dont get lost.', 0, 0.25),
('wedding_ring', 'Wedding Ring', 10, 1, 'item_standard', 1, 938, 1, '{}', 'A beautiful wedding ring.', 0, 0.25),
('wheat', 'Wheat', 10, 1, 'item_standard', 1, 939, 1, '{}', 'Often ground up into flour to used in cooking and baking', 0, 0.25),
('wheatseed', 'Wheat Seed', 10, 1, 'item_standard', 1, 940, 1, '{}', 'When planted will grow into wheat.', 0, 0.25),
('whisky', 'Whisky', 10, 1, 'item_standard', 1, 698, 1, '{}', 'An alcoholic beverage known as whisky.', 0, 0.25),
('wicker', 'Wicker', 10, 1, 'item_standard', 1, 941, 1, '{}', 'A natural material made from woven branches or reeds', 0, 0.25),
('wickerbench', 'Wicker Bench', 20, 1, 'item_standard', 1, 699, 1, '{}', 'A bench made from wicker material.', 0, 0.25),
('wicker_bench', 'Wicker Bench', 20, 1, 'item_standard', 1, 700, 1, '{}', 'A bench constructed with wicker material.', 0, 0.25),
('wildCiderMash', 'Black Berry Mash', 10, 1, 'item_standard', 0, 701, 1, '{}', 'Mashed blackberries used for making cider.', 0, 0.25),
('wildCiderMoonshine', 'Black Berry Moonshine', 10, 1, 'item_standard', 1, 702, 1, '{}', 'Homemade moonshine crafted from blackberries.', 0, 0.25),
('Wild_Carrot', 'Wild Carrot', 10, 1, 'item_standard', 1, 703, 1, '{}', 'A type of carrot that grows in the wild.', 0, 0.25),
('Wild_Carrot_Seed', 'Wild Carrot Seed', 10, 1, 'item_standard', 1, 704, 1, '{}', 'Seeds to cultivate wild carrots.', 0, 0.25),
('Wild_Feverfew', 'Wild Feverfew', 10, 1, 'item_standard', 1, 705, 1, '{}', 'A wild plant known as Feverfew.', 0, 0.25),
('Wild_Feverfew_Seed', 'Wild Feverfew Seed', 10, 1, 'item_standard', 1, 706, 1, '{}', 'Seeds to grow Feverfew plants.', 0, 0.25),
('Wild_Mint', 'Wild Mint', 10, 1, 'item_standard', 1, 707, 1, '{}', 'A type of mint that grows in the wild.', 0, 0.25),
('Wild_Mint_Seed', 'Wild Mint Seed', 10, 1, 'item_standard', 1, 708, 1, '{}', 'Seeds to cultivate wild mint.', 0, 0.25),
('Wild_Rhubarb', 'Wild Rhubarb', 10, 1, 'item_standard', 1, 709, 1, '{}', 'A rhubarb plant that grows in the wild.', 0, 0.25),
('Wild_Rhubarb_Seed', 'Wild Rhubarb Seed', 10, 1, 'item_standard', 1, 710, 1, '{}', 'Seeds to grow wild rhubarb.', 0, 0.25),
('wine', 'Wine', 10, 1, 'item_standard', 1, 711, 1, '{}', 'An alcoholic beverage made from fermented grapes.', 0, 0.25),
('Wintergreen_Berry', 'Wintergreen Berry', 10, 1, 'item_standard', 1, 712, 1, '{}', 'Berries from the wintergreen plant.', 0, 0.25),
('Wintergreen_Berry_Seed', 'Wintergreen Berry Seed', 10, 1, 'item_standard', 1, 713, 1, '{}', 'Seeds to cultivate wintergreen berries.', 0, 0.25),
('Wisteria', 'Wisteria', 10, 1, 'item_standard', 1, 714, 1, '{}', 'A flowering plant called Wisteria.', 0, 0.25),
('Wisteria_Seed', 'Wisteria Seed', 10, 1, 'item_standard', 1, 715, 1, '{}', 'Seeds to grow Wisteria plants.', 0, 0.25),
('wojape', 'Wojape', 5, 1, 'item_standard', 1, 716, 1, '{}', 'A traditional Native American sauce made from berries.', 0, 0.25),
('wolfheart', 'Wolf heart', 20, 1, 'item_standard', 1, 717, 1, '{}', 'The heart of a wolf.', 0, 0.25),
('wolfpelt', 'Wolf skin', 20, 1, 'item_standard', 1, 718, 1, '{}', 'The skin of a wolf.', 0, 0.25),
('wolftooth', 'Wolf tooth', 20, 1, 'item_standard', 1, 719, 1, '{}', 'A tooth extracted from a wolf.', 0, 0.25),
('wood', 'Soft Wood', 20, 1, 'item_standard', 0, 720, 1, '{}', 'A type of wood that is soft and easy to work with.', 0, 0.25),
('woodbench', 'Wooden Bench', 20, 1, 'item_standard', 1, 721, 1, '{}', 'A bench made from wood material.', 0, 0.25),
('woodchair', 'Wood Chair', 20, 1, 'item_standard', 1, 722, 1, '{}', 'A chair made from wood material.', 0, 0.25),
('wooden_bench', 'Wooden Bench', 20, 1, 'item_standard', 1, 723, 1, '{}', 'A bench constructed with wooden material.', 0, 0.25),
('wooden_boards', 'Wooden Boards', 25, 1, 'item_standard', 0, 724, 1, '{}', 'Boards made from wood material.', 0, 0.25),
('woodpeck01_c', 'Woodpecker', 20, 1, 'item_standard', 1, 725, 1, '{}', 'The skin and feathers of a woodpecker.', 0, 0.25),
('woodpeck02_c', 'Woodpecker 2', 20, 1, 'item_standard', 1, 726, 1, '{}', 'The skin and feathers of a woodpecker.', 0, 0.25),
('woodsaw', 'Woodsaw', 10, 1, 'item_standard', 1, 942, 1, '{}', 'Used to cut wood.', 0, 0.25),
('wood_chair', 'Wood Chair', 20, 1, 'item_standard', 1, 727, 1, '{}', 'A chair made from wood material.', 0, 0.25),
('wood_plane', 'Wood Plane', 10, 1, 'item_standard', 1, 943, 1, '{}', 'A wood plane used for shaping wood.', 0, 0.25),
('wool', 'Wool', 50, 1, 'item_standard', 1, 728, 1, '{}', 'Fiber obtained from the fleece of sheep.', 0, 0.25),
('wrench', 'Wrench', 10, 1, 'item_standard', 1, 944, 1, '{}', 'A wrech used to tighten bolts and other things.', 0, 0.25),
('wsnakes', 'Western rattlesnake pelt', 20, 1, 'item_standard', 1, 729, 1, '{}', 'The skin of a western rattlesnake.', 0, 0.25),
('wsnakeskin', 'Watersnake pelt', 20, 1, 'item_standard', 1, 730, 1, '{}', 'The skin of a watersnake.', 0, 0.25),
('Yarrow', 'Yarrow', 10, 1, 'item_standard', 1, 731, 1, '{}', 'A flowering plant known as Yarrow.', 0, 0.25),
('Yarrow_Seed', 'Yarrow Seed', 10, 1, 'item_standard', 1, 732, 1, '{}', 'Seeds to grow Yarrow plants.', 0, 0.25);

-- --------------------------------------------------------

--
-- Table structure for table `items_crafted`
--

CREATE TABLE `items_crafted` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'item',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `items_crafted`
--

INSERT INTO `items_crafted` (`id`, `character_id`, `item_id`, `item_name`, `updated_at`, `metadata`) VALUES
(1, 1, 39, 'ammorevolvernormal', '2025-06-15 12:51:32', '[]'),
(6, 2, 522, 'pickaxe', '2025-06-15 15:56:49', '{\"description\":\"Durability  94\",\"durability\":94}'),
(12, 1, 49, 'ammoshotgunnormal', '2025-06-15 16:46:33', '[]'),
(13, 2, 49, 'ammoshotgunnormal', '2025-06-15 16:46:54', '[]'),
(14, 2, 44, 'ammoriflenormal', '2025-06-15 16:48:50', '[]'),
(15, 1, 44, 'ammoriflenormal', '2025-06-15 16:48:59', '[]'),
(16, 2, 333, 'hatchet', '2025-06-15 17:16:26', '{\"durability\":84,\"description\":\"Durability  84\"}'),
(18, 1, 565, 'Red_Sage', '2025-06-15 17:17:03', '[]'),
(23, 1, 958, 'animal_crawfish', '2025-06-15 18:24:58', '[]'),
(27, 1, 175, 'clay', '2025-06-15 18:46:33', '[]'),
(31, 1, 479, 'Mutton', '2025-06-15 19:12:41', '[]'),
(35, 2, 209, 'consumable_raspberrywater', '2025-06-16 00:31:15', '[]'),
(37, 2, 584, 'rock', '2025-06-16 00:33:53', '[]'),
(38, 2, 175, 'clay', '2025-06-16 00:34:01', '[]'),
(40, 2, 958, 'animal_crawfish', '2025-06-16 03:00:42', '[]'),
(46, 3, 209, 'consumable_raspberrywater', '2025-06-16 08:55:44', '[]'),
(47, 3, 39, 'ammorevolvernormal', '2025-06-16 08:55:44', '[]'),
(48, 2, 467, 'meat', '2025-06-16 09:26:10', '[]'),
(49, 2, 306, 'game', '2025-06-16 09:26:22', '[]'),
(50, 2, 549, 'rabbits', '2025-06-16 09:26:31', '[]'),
(51, 2, 548, 'rabbitpaw', '2025-06-16 09:26:36', '[]'),
(52, 3, 44, 'ammoriflenormal', '2025-06-16 09:43:34', '[]'),
(65, 2, 720, 'wood', '2025-06-16 10:02:11', '[]'),
(66, 2, 234, 'Creeking_Thyme', '2025-06-16 10:04:19', '[]'),
(67, 3, 301, 'foxt', '2025-06-16 10:04:20', '[]'),
(68, 3, 300, 'foxskin', '2025-06-16 10:04:23', '[]'),
(69, 3, 140, 'bucks', '2025-06-16 10:04:25', '[]'),
(70, 3, 306, 'game', '2025-06-16 10:04:29', '[]'),
(71, 3, 469, 'Milk_Weed', '2025-06-16 10:04:32', '[]'),
(72, 3, 139, 'buckantler', '2025-06-16 10:04:37', '[]'),
(73, 3, 683, 'venison', '2025-06-16 10:04:42', '[]'),
(76, 3, 691, 'water', '2025-06-16 10:15:10', '[]'),
(78, 3, 247, 'deerheart', '2025-06-16 10:21:34', '[]'),
(79, 3, 249, 'deerskin', '2025-06-16 10:21:34', '[]'),
(81, 2, 565, 'Red_Sage', '2025-06-16 10:26:42', '[]'),
(82, 2, 469, 'Milk_Weed', '2025-06-16 10:26:52', '[]'),
(85, 2, 181, 'coal', '2025-06-16 10:30:08', '[]'),
(86, 2, 489, 'nitrite', '2025-06-16 10:30:16', '[]'),
(88, 3, 226, 'coyotes', '2025-06-16 10:35:49', '[]'),
(90, 3, 529, 'pork', '2025-06-16 10:39:31', '[]'),
(91, 3, 394, 'legboars2', '2025-06-16 10:39:31', '[]'),
(92, 3, 128, 'boarmusk', '2025-06-16 10:39:31', '[]'),
(93, 3, 565, 'Red_Sage', '2025-06-16 10:47:47', '[]'),
(94, 3, 224, 'coyotef', '2025-06-16 10:47:54', '[]'),
(95, 3, 467, 'meat', '2025-06-16 10:48:21', '[]'),
(97, 3, 207, 'consumable_peach', '2025-06-16 10:56:28', '[]'),
(98, 3, 522, 'pickaxe', '2025-06-16 10:56:43', '[]'),
(99, 3, 238, 'Crows_Garlic', '2025-06-16 11:02:15', '[]'),
(100, 2, 238, 'Crows_Garlic', '2025-06-17 02:08:24', '[]'),
(107, 2, 642, 'stringy', '2025-06-17 23:44:23', '[]'),
(114, 2, 272, 'English_Mace', '2025-06-18 00:24:11', '[]'),
(119, 2, 191, 'consumable_breakfast', '2025-06-18 01:18:21', '[]'),
(125, 2, 347, 'honey', '2025-06-18 01:32:54', '[]'),
(126, 2, 353, 'Hummingbird_Sage', '2025-06-18 01:33:10', '[]'),
(131, 2, 249, 'deerskin', '2025-06-18 01:47:18', '[]'),
(133, 2, 683, 'venison', '2025-06-18 02:02:27', '[]'),
(134, 2, 143, 'Bulrush', '2025-06-18 02:02:39', '[]'),
(135, 2, 125, 'blueberry', '2025-06-18 02:02:54', '[]'),
(139, 2, 683, 'venison', '2025-06-18 02:10:48', '[]'),
(141, 2, 499, 'Oregano', '2025-06-18 02:25:07', '[]'),
(142, 2, 961, 'hk_1', '2025-06-18 02:47:28', '[]'),
(143, 2, 469, 'Milk_Weed', '2025-06-18 02:48:00', '[]'),
(144, 2, 238, 'Crows_Garlic', '2025-06-18 02:48:08', '[]'),
(145, 2, 109, 'biggame', '2025-06-18 02:51:30', '[]'),
(146, 2, 140, 'bucks', '2025-06-18 02:51:38', '[]'),
(147, 2, 139, 'buckantler', '2025-06-18 02:51:42', '[]'),
(148, 2, 717, 'wolfheart', '2025-06-18 02:51:55', '[]'),
(149, 2, 291, 'fibers', '2025-06-18 02:52:21', '[]'),
(150, 2, 247, 'deerheart', '2025-06-18 02:52:38', '[]'),
(151, 2, 9, 'aligatorto', '2025-06-18 02:52:48', '[]'),
(152, 2, 730, 'wsnakeskin', '2025-06-18 02:52:57', '[]'),
(153, 2, 623, 'snaket', '2025-06-18 02:53:05', '[]'),
(154, 2, 542, 'pulp', '2025-06-18 02:53:18', '[]'),
(155, 2, 10, 'American_Ginseng', '2025-06-18 02:53:30', '[]'),
(156, 2, 945, 'p_baitCorn01x', '2025-06-18 02:53:59', '[]'),
(157, 2, 597, 'sap', '2025-06-18 02:54:13', '[]'),
(158, 2, 529, 'pork', '2025-06-18 02:54:57', '[]'),
(159, 2, 8, 'aligators', '2025-06-18 02:55:15', '[]'),
(160, 2, 128, 'boarmusk', '2025-06-18 02:55:21', '[]'),
(161, 2, 394, 'legboars2', '2025-06-18 02:55:25', '[]'),
(162, 2, 540, 'prongs', '2025-06-18 02:55:31', '[]'),
(163, 2, 954, 'p_finisdfishlurelegendary01x', '2025-06-18 02:55:37', '[]'),
(164, 2, 718, 'wolfpelt', '2025-06-18 02:55:52', '[]'),
(165, 2, 719, 'wolftooth', '2025-06-18 02:56:03', '[]'),
(167, 2, 479, 'Mutton', '2025-06-18 03:10:05', '[]'),
(168, 2, 553, 'ramhorn', '2025-06-18 03:10:05', '[]'),
(169, 2, 554, 'rams', '2025-06-18 03:10:05', '[]'),
(171, 2, 719, 'wolftooth', '2025-06-18 03:23:01', '[]'),
(172, 2, 718, 'wolfpelt', '2025-06-18 03:23:01', '[]'),
(175, 2, 347, 'honey', '2025-06-18 03:29:24', '[]'),
(177, 2, 597, 'sap', '2025-06-18 03:32:44', '[]'),
(178, 2, 355, 'hwood', '2025-06-18 03:56:48', '[]'),
(181, 2, 2, 'Agarita', '2025-06-18 05:32:23', '[]'),
(182, 2, 306, 'game', '2025-06-18 05:32:55', '[]'),
(184, 2, 499, 'Oregano', '2025-06-18 05:47:11', '[]'),
(185, 2, 139, 'buckantler', '2025-06-18 06:25:37', '[]'),
(186, 2, 140, 'bucks', '2025-06-18 06:25:37', '[]'),
(187, 4, 209, 'consumable_raspberrywater', '2025-06-18 15:50:28', '[]'),
(188, 4, 39, 'ammorevolvernormal', '2025-06-18 15:50:28', '[]'),
(189, 1, 733, 'absinthe', '2025-06-18 16:08:19', '[]'),
(191, 2, 234, 'Creeking_Thyme', '2025-06-18 17:10:56', '[]'),
(192, 2, 717, 'wolfheart', '2025-06-18 17:11:39', '[]'),
(193, 2, 238, 'Crows_Garlic', '2025-06-18 17:11:47', '[]'),
(194, 2, 563, 'Red_Raspberry', '2025-06-18 17:11:54', '[]'),
(195, 2, 720, 'wood', '2025-06-18 17:13:22', '[]'),
(196, 2, 542, 'pulp', '2025-06-18 17:13:36', '[]'),
(197, 2, 352, 'horsemeal', '2025-06-18 17:14:04', '[]'),
(198, 1, 125, 'blueberry', '2025-06-18 17:29:21', '[]'),
(199, 1, 499, 'Oregano', '2025-06-18 18:14:15', '[]'),
(200, 2, 540, 'prongs', '2025-06-18 18:21:55', '[]'),
(201, 1, 139, 'buckantler', '2025-06-18 18:35:47', '[]'),
(203, 1, 683, 'venison', '2025-06-18 18:35:47', '[]'),
(204, 2, 467, 'meat', '2025-06-18 18:37:30', '[]'),
(205, 2, 565, 'Red_Sage', '2025-06-18 18:45:14', '[]'),
(206, 2, 181, 'coal', '2025-06-18 19:01:31', '[]'),
(207, 2, 215, 'copper', '2025-06-18 19:21:00', '[]'),
(208, 5, 209, 'consumable_raspberrywater', '2025-06-18 20:30:40', '[]'),
(212, 5, 44, 'ammoriflenormal', '2025-06-19 04:59:58', '[]'),
(213, 5, 51, 'ammotomahawk', '2025-06-19 05:00:32', '[]'),
(216, 5, 962, 'hk_2', '2025-06-19 05:44:15', '[]'),
(219, 5, 522, 'pickaxe', '2025-06-19 06:16:49', '{\"durability\":92,\"description\":\"Durability  92\"}'),
(238, 5, 100, 'beart', '2025-06-19 10:22:44', '[]'),
(239, 5, 247, 'deerheart', '2025-06-19 10:22:48', '[]'),
(240, 5, 249, 'deerskin', '2025-06-19 10:23:12', '[]'),
(241, 5, 717, 'wolfheart', '2025-06-19 10:23:16', '[]'),
(242, 5, 57, 'antipoison2', '2025-06-19 10:23:23', '[]'),
(243, 5, 238, 'Crows_Garlic', '2025-06-19 10:23:32', '[]'),
(244, 5, 109, 'biggame', '2025-06-19 10:23:45', '[]'),
(245, 5, 683, 'venison', '2025-06-19 10:23:48', '[]'),
(246, 5, 20, 'ammobolaironspiked', '2025-06-19 10:24:04', '[]'),
(247, 5, 719, 'wolftooth', '2025-06-19 10:24:11', '[]'),
(248, 5, 99, 'bearc', '2025-06-19 10:25:12', '[]'),
(249, 5, 234, 'Creeking_Thyme', '2025-06-19 10:25:23', '[]'),
(250, 5, 499, 'Oregano', '2025-06-19 10:25:34', '[]'),
(251, 5, 718, 'wolfpelt', '2025-06-19 10:26:43', '[]'),
(252, 5, 88, 'bandage', '2025-06-19 10:26:53', '[]'),
(253, 5, 143, 'Bulrush', '2025-06-19 10:27:05', '[]'),
(254, 5, 306, 'game', '2025-06-19 10:27:21', '[]'),
(255, 6, 39, 'ammorevolvernormal', '2025-06-20 05:56:26', '[]'),
(256, 6, 209, 'consumable_raspberrywater', '2025-06-20 05:56:26', '[]'),
(259, 6, 44, 'ammoriflenormal', '2025-06-20 06:13:40', '[]'),
(260, 5, 306, 'game', '2025-06-20 06:20:43', '[]'),
(264, 5, 691, 'water', '2025-06-20 06:20:58', '[]'),
(265, 5, 565, 'Red_Sage', '2025-06-20 06:22:51', '[]'),
(268, 5, 642, 'stringy', '2025-06-20 06:46:27', '[]'),
(270, 5, 358, 'iron', '2025-06-20 07:10:49', '[]'),
(271, 5, 720, 'wood', '2025-06-20 07:11:26', '[]'),
(274, 5, 467, 'meat', '2025-06-20 07:53:36', '[]'),
(276, 7, 209, 'consumable_raspberrywater', '2025-06-20 08:37:27', '[]'),
(279, 7, 522, 'pickaxe', '2025-06-20 09:29:36', '{\"durability\":86,\"description\":\"Durability  86\"}'),
(280, 7, 191, 'consumable_breakfast', '2025-06-20 09:31:49', '[]'),
(285, 8, 39, 'ammorevolvernormal', '2025-06-20 09:53:43', '[]'),
(286, 8, 209, 'consumable_raspberrywater', '2025-06-20 09:53:43', '[]'),
(287, 7, 358, 'iron', '2025-06-20 09:54:18', '[]'),
(288, 7, 175, 'clay', '2025-06-20 09:54:24', '[]'),
(289, 7, 563, 'Red_Raspberry', '2025-06-20 09:54:43', '[]'),
(290, 7, 565, 'Red_Sage', '2025-06-20 09:54:55', '[]'),
(295, 7, 565, 'Red_Sage', '2025-06-20 10:48:11', '[]'),
(296, 8, 49, 'ammoshotgunnormal', '2025-06-20 10:48:52', '[]'),
(297, 7, 44, 'ammoriflenormal', '2025-06-20 10:50:08', '[]'),
(298, 7, 234, 'Creeking_Thyme', '2025-06-20 10:50:11', '[]'),
(299, 7, 719, 'wolftooth', '2025-06-20 10:50:20', '[]'),
(300, 7, 718, 'wolfpelt', '2025-06-20 10:50:28', '[]'),
(301, 7, 717, 'wolfheart', '2025-06-20 10:50:43', '[]'),
(303, 7, 238, 'Crows_Garlic', '2025-06-20 10:50:56', '[]'),
(307, 5, 175, 'clay', '2025-06-20 11:10:02', '[]'),
(311, 5, 125, 'blueberry', '2025-06-20 11:12:52', '[]'),
(313, 7, 594, 'salt', '2025-06-20 11:15:17', '[]'),
(314, 7, 215, 'copper', '2025-06-20 11:15:31', '[]'),
(315, 7, 499, 'Oregano', '2025-06-20 11:15:41', '[]'),
(316, 7, 10, 'American_Ginseng', '2025-06-20 11:15:48', '[]'),
(321, 7, 181, 'coal', '2025-06-20 11:37:38', '[]'),
(322, 7, 194, 'consumable_coffee', '2025-06-20 12:02:12', '[]'),
(325, 7, 45, 'ammoriflesplitpoint', '2025-06-20 12:07:00', '[]'),
(326, 8, 522, 'pickaxe', '2025-06-20 12:07:04', '{\"durability\":97,\"description\":\"Durability  97\"}'),
(327, 6, 193, 'consumable_chocolate', '2025-06-20 12:31:41', '[]'),
(329, 6, 195, 'consumable_fruitsalad', '2025-06-20 12:31:41', '[]'),
(330, 6, 191, 'consumable_breakfast', '2025-06-20 12:31:42', '[]'),
(333, 7, 40, 'ammorevolversplitpoint', '2025-06-20 12:34:14', '[]'),
(334, 6, 88, 'bandage', '2025-06-20 12:34:55', '[]'),
(335, 6, 698, 'whisky', '2025-06-20 12:35:16', '[]'),
(336, 6, 271, 'empty_bottle', '2025-06-20 12:35:21', '[]'),
(338, 7, 271, 'empty_bottle', '2025-06-20 12:36:52', '[]'),
(339, 7, 306, 'game', '2025-06-20 12:39:01', '[]'),
(340, 7, 594, 'salt', '2025-06-20 12:39:12', '[]'),
(341, 8, 782, 'consumable_spongecake', '2025-06-20 13:18:12', '[]'),
(342, 8, 191, 'consumable_breakfast', '2025-06-20 13:18:12', '[]'),
(345, 8, 766, 'consumable_chocolatecake', '2025-06-20 13:18:13', '[]'),
(346, 8, 779, 'consumable_poundcake', '2025-06-20 13:18:13', '[]'),
(347, 6, 238, 'Crows_Garlic', '2025-06-20 13:19:51', '[]'),
(348, 6, 234, 'Creeking_Thyme', '2025-06-20 13:19:56', '[]'),
(349, 1, 28, 'ammopistolnormal', '2025-06-20 13:31:41', '[]'),
(350, 8, 43, 'ammorifleexpress', '2025-06-20 13:32:10', '[]'),
(351, 8, 44, 'ammoriflenormal', '2025-06-20 13:32:10', '[]'),
(352, 6, 192, 'consumable_caramel', '2025-06-20 13:37:21', '[]'),
(356, 8, 691, 'water', '2025-06-20 14:01:04', '[]'),
(357, 1, 291, 'fibers', '2025-06-20 14:13:02', '[]'),
(358, 1, 34, 'ammorepeaternormal', '2025-06-20 14:15:18', '[]'),
(359, 1, 691, 'water', '2025-06-20 14:15:30', '[]'),
(360, 1, 467, 'meat', '2025-06-20 14:25:05', '[]'),
(361, 8, 272, 'English_Mace', '2025-06-20 15:38:13', '[]'),
(362, 5, 333, 'hatchet', '2025-06-20 15:41:00', '{\"durability\":93,\"description\":\"Durability  93\"}'),
(363, 1, 333, 'hatchet', '2025-06-20 15:41:12', '[]'),
(364, 8, 234, 'Creeking_Thyme', '2025-06-20 15:46:30', '[]'),
(365, 9, 209, 'consumable_raspberrywater', '2025-06-20 15:48:32', '[]'),
(366, 9, 39, 'ammorevolvernormal', '2025-06-20 15:48:32', '[]'),
(367, 8, 143, 'Bulrush', '2025-06-20 15:48:50', '[]'),
(368, 5, 143, 'Bulrush', '2025-06-20 15:48:51', '[]'),
(369, 5, 2, 'Agarita', '2025-06-20 17:07:40', '[]'),
(370, 8, 57, 'antipoison2', '2025-06-20 17:14:39', '[]'),
(371, 5, 238, 'Crows_Garlic', '2025-06-20 17:44:15', '[]'),
(372, 5, 234, 'Creeking_Thyme', '2025-06-20 17:51:28', '[]'),
(373, 8, 175, 'clay', '2025-06-20 17:51:35', '[]'),
(374, 8, 594, 'salt', '2025-06-20 17:51:39', '[]'),
(375, 8, 238, 'Crows_Garlic', '2025-06-20 17:52:53', '[]'),
(376, 8, 34, 'ammorepeaternormal', '2025-06-20 17:54:26', '[]'),
(377, 8, 565, 'Red_Sage', '2025-06-20 17:55:35', '[]'),
(378, 8, 563, 'Red_Raspberry', '2025-06-20 18:04:31', '[]'),
(379, 5, 34, 'ammorepeaternormal', '2025-06-20 18:21:07', '[]'),
(380, 8, 467, 'meat', '2025-06-20 18:48:54', '[]'),
(381, 5, 291, 'fibers', '2025-06-20 19:24:26', '[]'),
(382, 5, 720, 'wood', '2025-06-20 19:24:34', '[]'),
(383, 5, 1047, 'knivehandle', '2025-06-20 19:24:40', '[]'),
(384, 5, 1049, 'rope', '2025-06-20 19:24:47', '[]'),
(385, 5, 1046, 'powdergun', '2025-06-20 19:25:48', '[]'),
(386, 5, 358, 'iron', '2025-06-20 19:25:54', '[]'),
(387, 1, 261, 'dynamite', '2025-06-20 19:35:55', '[]'),
(388, 1, 1065, 'bagofcoal', '2025-06-20 19:37:33', '[]'),
(390, 10, 209, 'consumable_raspberrywater', '2025-06-20 19:57:16', '[]'),
(391, 10, 39, 'ammorevolvernormal', '2025-06-20 19:57:16', '[]'),
(392, 10, 44, 'ammoriflenormal', '2025-06-20 20:06:44', '[]'),
(393, 5, 584, 'rock', '2025-06-20 20:09:16', '[]'),
(394, 5, 359, 'ironbar', '2025-06-20 20:09:22', '[]'),
(395, 8, 499, 'Oregano', '2025-06-20 20:19:46', '[]'),
(396, 8, 1048, 'copperbar', '2025-06-20 20:20:08', '[]'),
(397, 8, 358, 'iron', '2025-06-20 20:20:32', '[]'),
(398, 10, 34, 'ammorepeaternormal', '2025-06-20 20:36:06', '[]'),
(399, 8, 111, 'bird', '2025-06-20 20:36:48', '[]'),
(400, 8, 334, 'hawkf', '2025-06-20 20:36:48', '[]'),
(401, 8, 335, 'hawkt', '2025-06-20 20:36:48', '[]'),
(402, 10, 499, 'Oregano', '2025-06-20 20:41:19', '[]'),
(403, 10, 234, 'Creeking_Thyme', '2025-06-20 20:43:00', '[]'),
(404, 10, 2, 'Agarita', '2025-06-20 20:43:35', '[]'),
(405, 11, 209, 'consumable_raspberrywater', '2025-06-20 21:01:17', '[]'),
(406, 11, 39, 'ammorevolvernormal', '2025-06-20 21:01:17', '[]'),
(407, 5, 191, 'consumable_breakfast', '2025-06-20 21:01:54', '[]'),
(408, 8, 46, 'ammoriflevelocity', '2025-06-20 21:07:16', '[]'),
(409, 8, 45, 'ammoriflesplitpoint', '2025-06-20 21:07:16', '[]'),
(410, 8, 50, 'ammoshotgunslug', '2025-06-20 21:07:17', '[]'),
(411, 8, 671, 'tropicalPunchMoonshine', '2025-06-20 21:11:21', '[]'),
(412, 10, 28, 'ammopistolnormal', '2025-06-20 21:12:31', '[]'),
(413, 10, 49, 'ammoshotgunnormal', '2025-06-20 21:12:31', '[]'),
(414, 10, 45, 'ammoriflesplitpoint', '2025-06-20 21:12:31', '[]'),
(415, 10, 12, 'ammoarrownormal', '2025-06-20 21:13:32', '[]'),
(416, 9, 671, 'tropicalPunchMoonshine', '2025-06-20 21:47:41', '[]'),
(417, 10, 191, 'consumable_breakfast', '2025-06-21 00:37:21', '[]'),
(418, 10, 203, 'consumable_kidneybeans_can', '2025-06-21 00:37:22', '[]'),
(419, 10, 565, 'Red_Sage', '2025-06-21 03:26:02', '[]'),
(420, 5, 542, 'pulp', '2025-06-21 05:48:38', '[]'),
(421, 5, 489, 'nitrite', '2025-06-21 06:45:54', '[]'),
(422, 5, 443, 'lockpick', '2025-06-21 06:53:38', '[]'),
(423, 5, 27, 'ammopistolexpress', '2025-06-21 06:59:04', '[]'),
(424, 5, 171, 'cigar', '2025-06-21 07:15:17', '[]'),
(425, 5, 172, 'cigarette', '2025-06-21 07:16:42', '[]'),
(426, 5, 1059, 'shovel', '2025-06-21 08:04:25', '{\"durability\":85,\"id\":426,\"description\":\"Shovel durability %85\"}');

-- --------------------------------------------------------

--
-- Table structure for table `item_group`
--

CREATE TABLE `item_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL COMMENT 'Description of Item Group'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `item_group`
--

INSERT INTO `item_group` (`id`, `description`) VALUES
(1, 'default'),
(2, 'medical'),
(3, 'foods'),
(4, 'tools'),
(5, 'weapons'),
(6, 'ammo'),
(7, 'documents'),
(8, 'animals'),
(9, 'valuables'),
(10, 'horse'),
(11, 'herbs');

-- --------------------------------------------------------

--
-- Table structure for table `legendaries`
--

CREATE TABLE `legendaries` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `trust` int(100) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `legendaries`
--

INSERT INTO `legendaries` (`identifier`, `charidentifier`, `trust`) VALUES
('steam:110000140823af3', 1, 0),
('steam:11000016e197d4f', 2, 0),
('steam:11000016e197d4f', 5, 1),
('steam:1100001562b75f9', 8, 0);

-- --------------------------------------------------------

--
-- Table structure for table `loadout`
--

CREATE TABLE `loadout` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `components` varchar(255) NOT NULL DEFAULT '{}',
  `dirtlevel` double DEFAULT 0,
  `mudlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `rustlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  `used2` tinyint(4) DEFAULT 0,
  `dropped` int(11) NOT NULL DEFAULT 0,
  `comps` longtext NOT NULL DEFAULT '{}',
  `label` varchar(50) DEFAULT NULL,
  `curr_inv` varchar(100) NOT NULL DEFAULT 'default',
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `custom_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `custom_desc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `loadout`
--

INSERT INTO `loadout` (`id`, `identifier`, `charidentifier`, `name`, `ammo`, `components`, `dirtlevel`, `mudlevel`, `conditionlevel`, `rustlevel`, `used`, `used2`, `dropped`, `comps`, `label`, `curr_inv`, `serial_number`, `custom_label`, `custom_desc`) VALUES
(1, 'steam:110000140823af3', 1, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(2, 'steam:11000016e197d4f', 2, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(3, 'steam:11000016e197d4f', 2, 'WEAPON_SHOTGUN_SEMIAUTO', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Semi-Auto Shotgun', 'default', '1750004156-5317', 'Semi-Auto Shotgun', NULL),
(5, 'steam:110000140823af3', 1, 'WEAPON_RIFLE_VARMINT', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Varmint Rifle', 'default', '1750006163-3717', 'Varmint Rifle', NULL),
(6, '', 2, 'WEAPON_RIFLE_VARMINT', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Varmint Rifle', 'vorp_banking_Blackwater_2', '1750006171-5570', 'Varmint Rifle', NULL),
(7, 'steam:11000016e197d4f', 2, 'WEAPON_RIFLE_BOLTACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'default', '1750006290-8058', 'BoltAction Rifle', NULL),
(9, '', 2, 'WEAPON_FISHINGROD', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Fishing Rod', 'vorp_banking_Blackwater_2', '', 'Fishing Rod', NULL),
(10, 'steam:1100001486701fd', 3, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(11, 'steam:1100001486701fd', 3, 'WEAPON_RIFLE_BOLTACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'default', '1750066458-7941', 'BoltAction Rifle', NULL),
(12, 'steam:1100001486701fd', 3, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(13, 'steam:1100001486701fd', 3, 'WEAPON_REVOLVER_NAVY', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Revolver Navy', 'default', '1750066458-3546', 'Revolver Navy', NULL),
(14, 'steam:1100001486701fd', 3, 'WEAPON_FISHINGROD', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Fishing Rod', 'default', '', 'Fishing Rod', NULL),
(15, 'steam:1100001486701fd', 3, 'WEAPON_MELEE_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Lantern', 'default', '', 'Lantern', NULL),
(16, '', 2, 'WEAPON_FISHINGROD', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Fishing Rod', 'A_C_Horse_Kladruber_Black_2', '', 'Fishing Rod', NULL),
(17, 'steam:11000016e197d4f', 2, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(18, 'steam:11000016e197d4f', 2, 'WEAPON_MELEE_LANTERN', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Lantern', 'default', '', 'Lantern', NULL),
(19, 'steam:11000016e197d4f', 2, 'WEAPON_THROWN_TOMAHAWK', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Tomahawk', 'default', '1750218809-2742', 'Tomahawk', NULL),
(20, 'steam:110000140823af3', 1, 'WEAPON_SHOTGUN_REPEATING', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Repeating Shotgun', 'default', '1750261445-4047', 'Repeating Shotgun', NULL),
(21, 'steam:110000140823af3', 4, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(22, '', 5, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'horse_5', '', 'Knife', NULL),
(23, 'steam:11000016e197d4f', 5, 'WEAPON_SHOTGUN_REPEATING', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Repeating Shotgun', 'default', '1750308956-3132', 'Repeating Shotgun', NULL),
(24, '', 5, 'WEAPON_REVOLVER_NAVY', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Revolver Navy', 'horse_5', '1750308974-2933', 'Revolver Navy', NULL),
(25, 'steam:11000016e197d4f', 5, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(26, '', 5, 'WEAPON_RIFLE_BOLTACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'horse_5', '1750309014-9846', 'BoltAction Rifle', NULL),
(27, 'steam:11000016e197d4f', 5, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(28, '', 5, 'WEAPON_MELEE_KNIFE_JAWBONE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife Jawbone', 'horse_5', '', 'Knife Jawbone', NULL),
(30, 'steam:11000016e197d4f', 5, 'WEAPON_MELEE_DAVY_LANTERN', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Davy Lantern', 'default', '', 'Davy Lantern', NULL),
(31, 'steam:11000016da2474b', 6, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(32, 'steam:1100001486701fd', 7, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(33, 'steam:1100001486701fd', 7, 'WEAPON_SHOTGUN_REPEATING', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Repeating Shotgun', 'default', '1750411417-6998', 'Repeating Shotgun', NULL),
(34, 'steam:1100001562b75f9', 8, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(35, 'steam:1100001562b75f9', 8, 'WEAPON_SHOTGUN_REPEATING', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Repeating Shotgun', 'default', '1750416511-4797', 'Repeating Shotgun', NULL),
(36, 'steam:1100001562b75f9', 8, 'WEAPON_MELEE_CLEAVER', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Cleaver', 'default', '', 'Cleaver', NULL),
(37, 'steam:1100001562b75f9', 8, 'WEAPON_THROWN_TOMAHAWK', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Tomahawk', 'default', '1750420874-7347', 'Tomahawk', NULL),
(38, 'steam:1100001562b75f9', 8, 'WEAPON_MELEE_HATCHET_HUNTER', '{\"nothing\":0}', '[\"nothing\"]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Hachet Hunter', 'default', '', 'Hachet Hunter', NULL),
(39, 'steam:11000016e197d4f', 5, 'WEAPON_MELEE_HATCHET_HUNTER', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Hachet Hunter', 'default', '', 'Hachet Hunter', NULL),
(40, 'steam:11000016e197d4f', 5, 'WEAPON_KIT_BINOCULARS', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Binoculars', 'default', '', 'Binoculars', NULL),
(41, 'steam:1100001486701fd', 7, 'WEAPON_FISHINGROD', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Fishing Rod', 'default', '', 'Fishing Rod', NULL),
(42, 'steam:1100001486701fd', 7, 'WEAPON_MELEE_KNIFE_TRADER', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Knife Trader', 'default', '', 'Knife Trader', NULL),
(43, 'steam:1100001486701fd', 7, 'WEAPON_RIFLE_BOLTACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'default', '1750421169-5100', 'BoltAction Rifle', NULL),
(44, 'steam:1100001486701fd', 7, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(45, '', 7, 'WEAPON_MELEE_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Lantern', 'horse_6', '', 'Lantern', NULL),
(46, 'steam:1100001486701fd', 7, 'WEAPON_MELEE_DAVY_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Davy Lantern', 'default', '', 'Davy Lantern', NULL),
(47, 'steam:1100001486701fd', 7, 'WEAPON_REVOLVER_DOUBLEACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Revolver Double Action', 'default', '1750422834-2791', 'Revolver Double Action', NULL),
(48, 'steam:1100001486701fd', 7, 'WEAPON_KIT_BINOCULARS_IMPROVED', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Improved Binoculars', 'default', '', 'Improved Binoculars', NULL),
(49, 'steam:1100001562b75f9', 8, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(50, 'steam:1100001562b75f9', 8, 'WEAPON_MELEE_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Lantern', 'default', '', 'Lantern', NULL),
(51, 'steam:1100001562b75f9', 8, 'WEAPON_KIT_BINOCULARS_IMPROVED', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Improved Binoculars', 'default', '', 'Improved Binoculars', NULL),
(52, 'steam:11000016da2474b', 6, 'WEAPON_FISHINGROD', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Fishing Rod', 'default', '', 'Fishing Rod', NULL),
(53, '', 6, 'WEAPON_MELEE_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Lantern', 'horse_10', '', 'Lantern', NULL),
(54, 'steam:11000016da2474b', 6, 'WEAPON_KIT_BINOCULARS_IMPROVED', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Improved Binoculars', 'default', '', 'Improved Binoculars', NULL),
(55, '', 6, 'WEAPON_THROWN_POISONBOTTLE', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Poison Bottle', 'horse_10', '1750425473-8932', 'Poison Bottle', NULL),
(56, 'steam:11000016da2474b', 6, 'WEAPON_REVOLVER_SCHOFIELD', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Revolver Schofield', 'default', '1750425473-1987', 'Revolver Schofield', NULL),
(57, '', 6, 'WEAPON_KIT_BINOCULARS', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Binoculars', 'horse_10', '', 'Binoculars', NULL),
(58, 'steam:11000016da2474b', 6, 'WEAPON_LASSO', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Lasso', 'default', '', 'Lasso', NULL),
(59, 'steam:11000016da2474b', 6, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(60, 'steam:11000016da2474b', 6, 'WEAPON_THROWN_BOLAS', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Bolas', 'default', '1750425474-3421', 'Bolas', NULL),
(61, '', 6, 'WEAPON_REVOLVER_LEMAT', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Revolver Lemat', 'horse_10', '1750425474-4178', 'Revolver Lemat', NULL),
(62, 'steam:11000016da2474b', 6, 'WEAPON_MELEE_DAVY_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Davy Lantern', 'default', '', 'Davy Lantern', NULL),
(63, 'steam:110000140823af3', 1, 'WEAPON_PISTOL_M1899', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Pistol M1899', 'default', '1750425946-4729', 'Pistol M1899', NULL),
(64, 'steam:1100001562b75f9', 8, 'WEAPON_RIFLE_BOLTACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'default', '1750425996-6375', 'BoltAction Rifle', NULL),
(65, 'steam:11000016da2474b', 6, 'WEAPON_MELEE_LANTERN', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Lantern', 'default', '', 'Lantern', NULL),
(67, 'steam:11000016da2474b', 6, 'WEAPON_RIFLE_BOLTACTION', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'default', '1750426692-6782', 'BoltAction Rifle', NULL),
(68, 'steam:110000162cead19', 9, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(69, 'steam:11000016e197d4f', 5, 'WEAPON_PISTOL_M1899', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Pistol M1899', 'default', '1750448293-7019', 'Pistol M1899', NULL),
(70, 'steam:11000016e97323d', 10, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(71, 'steam:11000016e97323d', 10, 'WEAPON_RIFLE_BOLTACTION', '{\"nothing\":0}', '[\"nothing\"]', 0, 0, 0, 0, 1, 0, 0, '[]', 'BoltAction Rifle', 'default', '1750426531-4258', 'BoltAction Rifle', NULL),
(72, 'steam:11000016db4fdd0', 11, 'WEAPON_MELEE_KNIFE', '[]', '[]', 0, 0, 0, 0, 0, 0, 0, '[]', 'Knife', 'default', '', 'Knife', NULL),
(73, 'steam:11000016e97323d', 10, 'WEAPON_MELEE_KNIFE_JAWBONE', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Knife Jawbone', 'default', '', 'Knife Jawbone', NULL),
(74, 'steam:11000016e97323d', 10, 'WEAPON_KIT_BINOCULARS_IMPROVED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Improved Binoculars', 'default', '', 'Improved Binoculars', NULL),
(75, 'steam:11000016e97323d', 10, 'WEAPON_SHOTGUN_SAWEDOFF', '[]', '[]', 0, 0, 0, 0, 1, 1, 0, '[]', 'Sawedoff Shotgun', 'default', '1750453876-7987', 'Sawedoff Shotgun', NULL),
(76, 'steam:11000016e97323d', 10, 'WEAPON_THROWN_TOMAHAWK', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Tomahawk', 'default', '1750453876-4304', 'Tomahawk', NULL),
(77, 'steam:11000016e97323d', 10, 'WEAPON_LASSO_REINFORCED', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Reinforced Lasso', 'default', '', 'Reinforced Lasso', NULL),
(78, 'steam:11000016e97323d', 10, 'WEAPON_BOW', '[]', '[]', 0, 0, 0, 0, 1, 0, 0, '[]', 'Bow', 'default', '', 'Bow', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mailbox_mails`
--

CREATE TABLE `mailbox_mails` (
  `id` int(11) NOT NULL,
  `sender_id` varchar(50) DEFAULT NULL,
  `sender_firstname` varchar(50) DEFAULT NULL,
  `sender_lastname` varchar(50) DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `receiver_firstname` varchar(50) DEFAULT NULL,
  `receiver_lastname` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `opened` tinyint(1) DEFAULT 0,
  `received_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `mailbox_mails`
--

INSERT INTO `mailbox_mails` (`id`, `sender_id`, `sender_firstname`, `sender_lastname`, `receiver_id`, `receiver_firstname`, `receiver_lastname`, `message`, `opened`, `received_at`) VALUES
(1, 'steam:110000140823af3', 'Thomas', 'Shelby', 'steam:11000016e197d4f', 'MR', 'aproko', 'MR Aproko welcome', 0, '2025-06-15 17:09:24'),
(3, 'steam:110000140823af3', 'Thomas', 'Shelby', 'steam:11000016e197d4f', 'MR', 'aproko', 'i think you got some money now right?\n', 0, '2025-06-16 00:24:18'),
(4, 'steam:11000016e197d4f', 'MR', 'aproko', 'steam:110000140823af3', 'Thomas', 'Shelby', 'Hello Mr Thomas, I just wanted to let you know that I got the $2000 and I assure you that I\'ll put it to good use\n\nMr Aproko', 0, '2025-06-16 03:40:36'),
(5, 'steam:11000016e197d4f', 'Puzo', 'King', 'steam:11000016e197d4f', 'Puzo', 'King', 'WElcome to African kings', 0, '2025-06-19 06:46:46'),
(6, 'steam:11000016e197d4f', 'Puzo', 'King', 'steam:1100001486701fd', 'Big', 'MAMA', 'Are you still interested for the Doctors Job', 0, '2025-06-20 10:06:06');

-- --------------------------------------------------------

--
-- Table structure for table `oil`
--

CREATE TABLE `oil` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `manager_trust` int(100) NOT NULL DEFAULT 0,
  `enemy_trust` int(100) NOT NULL DEFAULT 0,
  `oil_wagon` varchar(50) NOT NULL DEFAULT 'none',
  `delivery_wagon` varchar(50) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `oil`
--

INSERT INTO `oil` (`identifier`, `charidentifier`, `manager_trust`, `enemy_trust`, `oil_wagon`, `delivery_wagon`) VALUES
('steam:11000016e197d4f', 5, 0, 0, 'oilwagon02x', 'none'),
('steam:1100001562b75f9', 8, 0, 0, 'none', 'none'),
('steam:11000016e97323d', 10, 0, 1, 'none', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `outfits`
--

CREATE TABLE `outfits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `outfits`
--

INSERT INTO `outfits` (`id`, `identifier`, `charidentifier`, `title`, `comps`, `compTints`) VALUES
(1, 'steam:11000016e197d4f', 2, 'new', '{\"Teeth\":712446626,\"GunbeltAccs\":-1,\"Mask\":-1,\"Bow\":-1,\"RingRh\":-552206191,\"Buckle\":-1,\"Gunbelt\":-499572842,\"Suspender\":-1,\"Vest\":-1,\"Dress\":-1,\"Shirt\":1268605773,\"Hat\":-1,\"Boots\":-218859683,\"NeckWear\":-1,\"Satchels\":-1,\"Accessories\":334838281,\"Bracelet\":-1,\"Coat\":-1,\"Glove\":-1,\"Poncho\":-1,\"Cloak\":-1,\"RingLh\":-1978766118,\"Spurs\":-1,\"NeckTies\":-1,\"Badge\":-1,\"EyeWear\":-135591396,\"Spats\":-1,\"Chap\":-1,\"Holster\":-1484084376,\"Armor\":-1,\"Loadouts\":-1,\"Skirt\":-1,\"Pant\":-1487913642,\"CoatClosed\":2005466233,\"Gauntlets\":-1,\"Belt\":1061814043}', '{\"Gunbelt\":{\"-499572842\":{\"tint2\":58,\"color\":1,\"tint0\":1,\"tint1\":1,\"palette\":-783849117,\"index\":6}},\"Pant\":{\"-1487913642\":{\"tint2\":183,\"color\":1,\"tint0\":121,\"tint1\":59,\"palette\":-1251868068,\"index\":2}},\"EyeWear\":{\"-135591396\":{\"tint2\":227,\"color\":1,\"tint0\":103,\"tint1\":103,\"palette\":896697531,\"index\":1}},\"Shirt\":{\"1268605773\":{\"tint2\":19,\"color\":0,\"tint0\":21,\"tint1\":21,\"palette\":-1436165981,\"index\":7}},\"Holster\":{\"-1484084376\":{\"tint2\":60,\"color\":1,\"tint0\":60,\"tint1\":60,\"palette\":-783849117,\"index\":6}},\"Boots\":{\"-218859683\":{\"tint2\":0,\"color\":1,\"tint0\":8,\"tint1\":0,\"palette\":0,\"index\":1}},\"Belt\":{\"1061814043\":{\"tint2\":0,\"color\":3,\"tint0\":0,\"tint1\":0,\"palette\":0,\"index\":4}},\"RingRh\":{\"-552206191\":{\"tint2\":255,\"color\":1,\"tint0\":15,\"tint1\":254,\"palette\":1090645383,\"index\":3}},\"CoatClosed\":{\"2005466233\":{\"tint2\":60,\"color\":3,\"tint0\":0,\"tint1\":15,\"palette\":-783849117,\"index\":2}},\"RingLh\":{\"-1978766118\":{\"tint2\":19,\"color\":1,\"tint0\":16,\"tint1\":45,\"palette\":1090645383,\"index\":1}},\"Accessories\":{\"334838281\":{\"tint2\":210,\"color\":2,\"tint0\":16,\"tint1\":85,\"palette\":-183908539,\"index\":1}}}'),
(2, 'steam:11000016e197d4f', 2, 'moscow', '{\"Teeth\":712446626,\"GunbeltAccs\":-1,\"Mask\":-1,\"Bow\":-1,\"RingRh\":-552206191,\"Buckle\":-1,\"Gunbelt\":-499572842,\"Suspender\":-1,\"Pant\":-1487913642,\"Skirt\":-1,\"Shirt\":1268605773,\"Hat\":-1,\"Boots\":-218859683,\"NeckWear\":-1,\"Satchels\":-1,\"Accessories\":334838281,\"Bracelet\":-1,\"Coat\":-1,\"Holster\":-1484084376,\"Poncho\":-1,\"Cloak\":-1,\"RingLh\":-1978766118,\"Chap\":-1,\"NeckTies\":-1,\"Spurs\":-1,\"EyeWear\":-135591396,\"Badge\":-1,\"Vest\":-1,\"Gauntlets\":-1,\"Armor\":-1,\"Loadouts\":-1,\"Glove\":1657329436,\"Spats\":-1,\"CoatClosed\":2005466233,\"Dress\":-1,\"Belt\":1061814043}', '{\"Gunbelt\":{\"-499572842\":{\"tint2\":58,\"color\":1,\"tint0\":1,\"tint1\":1,\"palette\":-783849117,\"index\":6}},\"Pant\":{\"-1487913642\":{\"tint2\":183,\"color\":1,\"tint0\":121,\"tint1\":59,\"palette\":-1251868068,\"index\":2}},\"EyeWear\":{\"-135591396\":{\"tint2\":227,\"color\":1,\"tint0\":103,\"tint1\":103,\"palette\":896697531,\"index\":1}},\"Shirt\":{\"1268605773\":{\"tint2\":19,\"color\":1,\"tint0\":21,\"tint1\":21,\"palette\":-1436165981,\"index\":7}},\"Holster\":{\"-1484084376\":{\"tint2\":60,\"color\":1,\"tint0\":60,\"tint1\":60,\"palette\":-783849117,\"index\":6}},\"Glove\":{\"1657329436\":{\"tint2\":90,\"color\":0,\"tint0\":214,\"tint1\":22,\"palette\":-183908539,\"index\":14}},\"Boots\":{\"-218859683\":{\"tint2\":0,\"color\":1,\"tint0\":8,\"tint1\":0,\"palette\":0,\"index\":1}},\"Accessories\":{\"334838281\":{\"tint2\":210,\"color\":2,\"tint0\":16,\"tint1\":85,\"palette\":-183908539,\"index\":1}},\"RingRh\":{\"-552206191\":{\"tint2\":255,\"color\":1,\"tint0\":15,\"tint1\":254,\"palette\":1090645383,\"index\":3}},\"CoatClosed\":{\"2005466233\":{\"tint2\":60,\"color\":3,\"tint0\":0,\"tint1\":15,\"palette\":-783849117,\"index\":2}},\"RingLh\":{\"-1978766118\":{\"tint2\":19,\"color\":1,\"tint0\":16,\"tint1\":45,\"palette\":1090645383,\"index\":1}},\"Belt\":{\"1061814043\":{\"tint2\":0,\"color\":3,\"tint0\":0,\"tint1\":0,\"palette\":0,\"index\":4}}}'),
(3, 'steam:11000016e197d4f', 2, 'monsour', '{\"Suspender\":-1,\"Spats\":-1,\"Satchels\":-1,\"Buckle\":-1,\"Vest\":-1,\"Gauntlets\":-1,\"CoatClosed\":-1,\"Accessories\":334838281,\"EyeWear\":633673784,\"Armor\":-1,\"Mask\":-1,\"Boots\":-1883901215,\"Glove\":1657329436,\"Skirt\":-1,\"RingLh\":-1978766118,\"Badge\":-1,\"Dress\":-1,\"NeckWear\":-1,\"Cloak\":-1,\"Poncho\":-1,\"Hat\":-1600756294,\"Gunbelt\":-499572842,\"Teeth\":712446626,\"Spurs\":-1,\"Shirt\":1268605773,\"Coat\":444916443,\"NeckTies\":-1,\"Bracelet\":-1,\"RingRh\":-552206191,\"Pant\":-472924005,\"Loadouts\":-1,\"Chap\":-1,\"Belt\":1061814043,\"GunbeltAccs\":-1,\"Bow\":-1,\"Holster\":-1484084376}', '{\"Holster\":{\"-1484084376\":{\"index\":6,\"color\":1,\"tint0\":60,\"palette\":-783849117,\"tint1\":60,\"tint2\":60}},\"EyeWear\":{\"633673784\":{\"index\":5,\"color\":0,\"tint0\":62,\"palette\":-1543234321,\"tint1\":250,\"tint2\":11}},\"Coat\":{\"444916443\":{\"index\":28,\"color\":5,\"tint0\":5,\"palette\":1064202495,\"tint1\":55,\"tint2\":59}},\"Hat\":{\"-1600756294\":{\"index\":16,\"color\":0,\"tint0\":131,\"palette\":-1952348042,\"tint1\":131,\"tint2\":116}},\"Gunbelt\":{\"-499572842\":{\"index\":6,\"color\":1,\"tint0\":1,\"palette\":-783849117,\"tint1\":1,\"tint2\":58}},\"Boots\":{\"-1883901215\":{\"index\":6,\"color\":9,\"tint0\":44,\"palette\":-783849117,\"tint1\":11,\"tint2\":44}},\"Glove\":{\"1657329436\":{\"index\":14,\"color\":1,\"tint0\":214,\"palette\":-183908539,\"tint1\":22,\"tint2\":90}},\"Belt\":{\"1061814043\":{\"index\":4,\"color\":3,\"tint0\":0,\"palette\":0,\"tint1\":0,\"tint2\":0}},\"RingLh\":{\"-1978766118\":{\"index\":1,\"color\":1,\"tint0\":16,\"palette\":1090645383,\"tint1\":45,\"tint2\":19}},\"Shirt\":{\"1268605773\":{\"index\":7,\"color\":1,\"tint0\":21,\"palette\":-1436165981,\"tint1\":21,\"tint2\":19}},\"Pant\":{\"-472924005\":{\"index\":13,\"color\":11,\"tint0\":0,\"palette\":-783849117,\"tint1\":72,\"tint2\":3}},\"Accessories\":{\"334838281\":{\"index\":1,\"color\":2,\"tint0\":16,\"palette\":-183908539,\"tint1\":85,\"tint2\":210}},\"CoatClosed\":{\"2005466233\":{\"index\":2,\"color\":3,\"tint0\":0,\"palette\":-783849117,\"tint1\":15,\"tint2\":60}},\"RingRh\":{\"-552206191\":{\"index\":3,\"color\":1,\"tint0\":15,\"palette\":1090645383,\"tint1\":254,\"tint2\":255}}}'),
(4, 'steam:11000016e197d4f', 5, 'first outfit', '{\"NeckTies\":2116314776,\"Pant\":1738549663,\"Poncho\":-1,\"GunbeltAccs\":-1,\"Teeth\":1629650936,\"Accessories\":-1712765457,\"Coat\":-1,\"Shirt\":-1845028218,\"Gauntlets\":-1132666637,\"Badge\":-1,\"CoatClosed\":-1,\"Glove\":1435483306,\"Bow\":-1,\"RingLh\":-1,\"Spats\":-1,\"Bracelet\":-1,\"Chap\":-1,\"Skirt\":-1,\"Spurs\":-1,\"Loadouts\":-1688431438,\"Vest\":-1,\"Belt\":7635313,\"Buckle\":-1120042477,\"RingRh\":-1,\"Gunbelt\":-499572842,\"NeckWear\":-1,\"Holster\":-2086565603,\"Hat\":-1,\"Dress\":-1,\"Mask\":-1,\"Satchels\":-1,\"Suspender\":-1,\"Boots\":-2110134463,\"Armor\":-1,\"Cloak\":-1,\"EyeWear\":633673784}', '{\"Buckle\":{\"-1120042477\":{\"index\":17,\"tint2\":0,\"palette\":0,\"color\":0,\"tint0\":0,\"tint1\":0}},\"NeckTies\":{\"2116314776\":{\"index\":4,\"tint2\":21,\"palette\":-1436165981,\"color\":0,\"tint0\":21,\"tint1\":21}},\"Gauntlets\":{\"-1132666637\":{\"index\":2,\"tint2\":120,\"palette\":1064202495,\"color\":0,\"tint0\":27,\"tint1\":5}},\"Cloak\":[],\"Gunbelt\":{\"-499572842\":{\"index\":6,\"tint2\":58,\"palette\":-783849117,\"color\":0,\"tint0\":1,\"tint1\":1}},\"Glove\":{\"1435483306\":{\"index\":14,\"tint2\":104,\"palette\":896697531,\"color\":2,\"tint0\":60,\"tint1\":104}},\"Holster\":{\"-2086565603\":{\"index\":2,\"tint2\":105,\"palette\":-1952348042,\"color\":4,\"tint0\":132,\"tint1\":132}},\"Shirt\":{\"-1845028218\":{\"index\":30,\"tint2\":21,\"palette\":1090645383,\"color\":0,\"tint0\":20,\"tint1\":21}},\"Loadouts\":{\"-1688431438\":{\"index\":3,\"tint2\":60,\"palette\":-783849117,\"color\":0,\"tint0\":14,\"tint1\":60}},\"Pant\":{\"1738549663\":{\"index\":16,\"tint2\":15,\"palette\":1090645383,\"color\":0,\"tint0\":21,\"tint1\":16}},\"Accessories\":{\"-1712765457\":{\"index\":1,\"tint2\":210,\"palette\":-183908539,\"color\":3,\"tint0\":47,\"tint1\":104}},\"Belt\":{\"7635313\":{\"index\":4,\"tint2\":0,\"palette\":0,\"color\":0,\"tint0\":0,\"tint1\":0}},\"Bracelet\":[],\"Satchels\":[],\"Boots\":{\"-2110134463\":{\"index\":71,\"tint2\":15,\"palette\":-783849117,\"color\":0,\"tint0\":14,\"tint1\":0}},\"EyeWear\":{\"633673784\":{\"index\":5,\"tint2\":11,\"palette\":-1543234321,\"color\":0,\"tint0\":62,\"tint1\":250}}}'),
(5, 'steam:11000016e197d4f', 5, 'remode', '{\"Badge\":-1,\"Holster\":-2086565603,\"Spurs\":-1,\"Loadouts\":-1688431438,\"NeckTies\":2116314776,\"RingRh\":-1,\"Bracelet\":-1,\"Cloak\":-1,\"Teeth\":1629650936,\"Coat\":-1,\"Accessories\":-1,\"Gauntlets\":376060699,\"Hat\":-1,\"Vest\":-1,\"Mask\":-1,\"Gunbelt\":-499572842,\"EyeWear\":633673784,\"Shirt\":-1845028218,\"Bow\":-1,\"Satchels\":-1,\"Dress\":-1,\"RingLh\":-1,\"Poncho\":-1,\"CoatClosed\":-1,\"Spats\":-1,\"NeckWear\":-1,\"Glove\":1435483306,\"Boots\":-2110134463,\"Chap\":-1,\"GunbeltAccs\":-1,\"Suspender\":-1,\"Pant\":1738549663,\"Buckle\":-1120042477,\"Belt\":7635313,\"Armor\":-1,\"Skirt\":-1}', '{\"Belt\":{\"7635313\":{\"tint2\":0,\"palette\":0,\"index\":4,\"color\":1,\"tint1\":0,\"tint0\":0}},\"Holster\":{\"-2086565603\":{\"tint2\":105,\"palette\":-1952348042,\"index\":2,\"color\":4,\"tint1\":132,\"tint0\":132}},\"Pant\":{\"1738549663\":{\"tint2\":15,\"palette\":1090645383,\"index\":16,\"color\":1,\"tint1\":16,\"tint0\":21}},\"Gunbelt\":{\"-499572842\":{\"tint2\":58,\"palette\":-783849117,\"index\":6,\"color\":1,\"tint1\":1,\"tint0\":1}},\"Loadouts\":{\"-1688431438\":{\"tint2\":60,\"palette\":-783849117,\"index\":3,\"color\":1,\"tint1\":60,\"tint0\":14}},\"NeckTies\":{\"2116314776\":{\"tint2\":21,\"palette\":-1436165981,\"index\":4,\"color\":1,\"tint1\":21,\"tint0\":21}},\"Boots\":{\"-2110134463\":{\"tint2\":15,\"palette\":-783849117,\"index\":71,\"color\":1,\"tint1\":0,\"tint0\":14}},\"EyeWear\":{\"633673784\":{\"tint2\":11,\"palette\":-1543234321,\"index\":5,\"color\":1,\"tint1\":250,\"tint0\":62}},\"Glove\":{\"1435483306\":{\"tint2\":104,\"palette\":896697531,\"index\":14,\"color\":2,\"tint1\":104,\"tint0\":60}},\"Shirt\":{\"-1845028218\":{\"tint2\":21,\"palette\":1090645383,\"index\":30,\"color\":1,\"tint1\":21,\"tint0\":20}},\"Buckle\":{\"-1120042477\":{\"tint2\":0,\"palette\":0,\"index\":17,\"color\":1,\"tint1\":0,\"tint0\":0}},\"Satchels\":[],\"Accessories\":[],\"Gauntlets\":{\"376060699\":{\"tint2\":30,\"palette\":17129595,\"index\":3,\"color\":0,\"tint1\":61,\"tint0\":21}}}'),
(6, 'steam:1100001486701fd', 7, 'yellow corset', '{\"Accessories\":869490822,\"Chap\":-1,\"Badge\":-1,\"CoatClosed\":-1,\"Dress\":-1,\"Armor\":-1,\"Poncho\":-1,\"RingRh\":-1,\"Bracelet\":-1,\"Cloak\":-1,\"Loadouts\":-1,\"Gauntlets\":834504924,\"Mask\":-1,\"Pant\":-1,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Holster\":-83784299,\"EyeWear\":833646746,\"Buckle\":-1,\"Boots\":1178628992,\"Bow\":-1,\"Vest\":558244996,\"RingLh\":-1,\"Spats\":-1,\"Suspender\":-1,\"Coat\":-1,\"Teeth\":-1,\"Skirt\":-753739014,\"Spurs\":-1,\"Gunbelt\":237932673,\"Hat\":-1152095488,\"Glove\":298487871,\"NeckWear\":1237454505,\"Shirt\":-1,\"NeckTies\":-1,\"Belt\":-1}', '{\"Accessories\":{\"869490822\":{\"palette\":-183908539,\"tint1\":90,\"color\":2,\"index\":1,\"tint0\":15,\"tint2\":210}},\"Hat\":{\"-1152095488\":{\"palette\":-1543234321,\"tint1\":0,\"color\":1,\"index\":102,\"tint0\":0,\"tint2\":0}},\"Holster\":{\"-83784299\":{\"palette\":-783849117,\"tint1\":1,\"color\":1,\"index\":15,\"tint0\":1,\"tint2\":1}},\"NeckWear\":{\"1237454505\":{\"palette\":1064202495,\"tint1\":0,\"color\":1,\"index\":15,\"tint0\":0,\"tint2\":0}},\"Skirt\":{\"-753739014\":{\"palette\":17129595,\"tint1\":248,\"color\":4,\"index\":6,\"tint0\":250,\"tint2\":1}},\"Gunbelt\":{\"237932673\":{\"palette\":-783849117,\"tint1\":15,\"color\":1,\"index\":16,\"tint0\":15,\"tint2\":58}},\"Boots\":{\"1178628992\":{\"palette\":1669565057,\"tint1\":54,\"color\":0,\"index\":4,\"tint0\":21,\"tint2\":52}},\"Gauntlets\":{\"834504924\":{\"palette\":1064202495,\"tint1\":68,\"color\":1,\"index\":3,\"tint0\":27,\"tint2\":93}},\"Glove\":{\"298487871\":{\"palette\":-113397560,\"tint1\":39,\"color\":4,\"index\":20,\"tint0\":252,\"tint2\":38}},\"EyeWear\":{\"833646746\":{\"palette\":1090645383,\"tint1\":59,\"color\":4,\"index\":9,\"tint0\":61,\"tint2\":48}},\"Vest\":{\"558244996\":{\"palette\":1064202495,\"tint1\":56,\"color\":2,\"index\":30,\"tint0\":50,\"tint2\":53}}}'),
(7, 'steam:11000016e197d4f', 5, 'coat man', '{\"Accessories\":-1,\"NeckWear\":-1,\"Badge\":-1,\"CoatClosed\":1133022400,\"Dress\":-1,\"Armor\":-1,\"Poncho\":-1,\"RingRh\":-1,\"Bracelet\":-1,\"Skirt\":-1,\"Loadouts\":-1688431438,\"Gauntlets\":376060699,\"Mask\":-1,\"Pant\":1738549663,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Holster\":-2086565603,\"EyeWear\":633673784,\"Buckle\":-1120042477,\"Boots\":1354409584,\"Bow\":-1,\"Vest\":-1,\"NeckTies\":2116314776,\"Spats\":-1,\"Suspender\":-1,\"Coat\":-1,\"Teeth\":1629650936,\"Cloak\":-1,\"Chap\":-1,\"Gunbelt\":-499572842,\"Spurs\":-1,\"Glove\":1435483306,\"RingLh\":-1,\"Shirt\":-1845028218,\"Hat\":-1,\"Belt\":7635313}', '{\"Boots\":{\"1354409584\":{\"palette\":1090645383,\"tint1\":16,\"color\":0,\"index\":67,\"tint0\":244,\"tint2\":21}},\"Holster\":{\"-2086565603\":{\"palette\":-1952348042,\"tint1\":132,\"color\":4,\"index\":2,\"tint0\":132,\"tint2\":105}},\"Glove\":{\"1435483306\":{\"palette\":896697531,\"tint1\":104,\"color\":2,\"index\":14,\"tint0\":60,\"tint2\":104}},\"NeckTies\":{\"2116314776\":{\"palette\":-1436165981,\"tint1\":21,\"color\":1,\"index\":4,\"tint0\":21,\"tint2\":21}},\"EyeWear\":{\"633673784\":{\"palette\":-1543234321,\"tint1\":250,\"color\":1,\"index\":5,\"tint0\":62,\"tint2\":11}},\"Buckle\":{\"-1120042477\":{\"palette\":0,\"tint1\":0,\"color\":1,\"index\":17,\"tint0\":0,\"tint2\":0}},\"Gunbelt\":{\"-499572842\":{\"palette\":-783849117,\"tint1\":1,\"color\":1,\"index\":6,\"tint0\":1,\"tint2\":58}},\"Loadouts\":{\"-1688431438\":{\"palette\":-783849117,\"tint1\":60,\"color\":1,\"index\":3,\"tint0\":14,\"tint2\":60}},\"Gauntlets\":{\"376060699\":{\"palette\":17129595,\"tint1\":61,\"color\":1,\"index\":3,\"tint0\":21,\"tint2\":30}},\"CoatClosed\":{\"1133022400\":{\"palette\":-1543234321,\"tint1\":68,\"color\":0,\"index\":4,\"tint0\":77,\"tint2\":64}},\"Pant\":{\"1738549663\":{\"palette\":1090645383,\"tint1\":16,\"color\":1,\"index\":16,\"tint0\":21,\"tint2\":15}},\"Shirt\":{\"-1845028218\":{\"palette\":1090645383,\"tint1\":21,\"color\":1,\"index\":30,\"tint0\":20,\"tint2\":21}},\"Belt\":{\"7635313\":{\"palette\":0,\"tint1\":0,\"color\":1,\"index\":4,\"tint0\":0,\"tint2\":0}}}'),
(8, 'steam:11000016e197d4f', 5, 'whiteman', '{\"Accessories\":-1,\"NeckWear\":-1,\"Badge\":-1,\"CoatClosed\":1133022400,\"Dress\":-1,\"Armor\":-1,\"Poncho\":-1,\"RingRh\":-1,\"Bracelet\":-1,\"Skirt\":-1,\"Loadouts\":-1688431438,\"Gauntlets\":376060699,\"Mask\":-1,\"Pant\":-245398271,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Holster\":-2086565603,\"EyeWear\":633673784,\"Buckle\":-1120042477,\"Boots\":1354409584,\"Bow\":-1,\"Vest\":-1,\"NeckTies\":2116314776,\"Spats\":-1,\"Suspender\":-1,\"Coat\":-1,\"Teeth\":1629650936,\"Cloak\":-1,\"Chap\":-1,\"Gunbelt\":-499572842,\"Spurs\":-1,\"Glove\":1435483306,\"RingLh\":-1,\"Shirt\":-1845028218,\"Hat\":-1,\"Belt\":7635313}', '{\"Loadouts\":{\"-1688431438\":{\"palette\":-783849117,\"tint1\":60,\"color\":1,\"index\":3,\"tint0\":14,\"tint2\":60}},\"Holster\":{\"-2086565603\":{\"palette\":-1952348042,\"tint1\":132,\"color\":4,\"index\":2,\"tint0\":132,\"tint2\":105}},\"Glove\":{\"1435483306\":{\"palette\":896697531,\"tint1\":104,\"color\":2,\"index\":14,\"tint0\":60,\"tint2\":104}},\"NeckTies\":{\"2116314776\":{\"palette\":-1436165981,\"tint1\":21,\"color\":1,\"index\":4,\"tint0\":21,\"tint2\":21}},\"EyeWear\":{\"633673784\":{\"palette\":-1543234321,\"tint1\":250,\"color\":1,\"index\":5,\"tint0\":62,\"tint2\":11}},\"Buckle\":{\"-1120042477\":{\"palette\":0,\"tint1\":0,\"color\":1,\"index\":17,\"tint0\":0,\"tint2\":0}},\"Gunbelt\":{\"-499572842\":{\"palette\":-783849117,\"tint1\":1,\"color\":1,\"index\":6,\"tint0\":1,\"tint2\":58}},\"Boots\":{\"1354409584\":{\"palette\":1090645383,\"tint1\":16,\"color\":1,\"index\":67,\"tint0\":244,\"tint2\":21}},\"Gauntlets\":{\"376060699\":{\"palette\":17129595,\"tint1\":61,\"color\":1,\"index\":3,\"tint0\":21,\"tint2\":30}},\"CoatClosed\":{\"1133022400\":{\"palette\":-1543234321,\"tint1\":68,\"color\":1,\"index\":4,\"tint0\":77,\"tint2\":64}},\"Pant\":{\"-245398271\":{\"palette\":-770746372,\"tint1\":189,\"color\":0,\"index\":22,\"tint0\":60,\"tint2\":248}},\"Shirt\":{\"-1845028218\":{\"palette\":1090645383,\"tint1\":21,\"color\":1,\"index\":30,\"tint0\":20,\"tint2\":21}},\"Belt\":{\"7635313\":{\"palette\":0,\"tint1\":0,\"color\":1,\"index\":4,\"tint0\":0,\"tint2\":0}}}'),
(9, 'steam:11000016e97323d', 10, 'WHITE AND BALCK', '{\"Buckle\":1635771202,\"Glove\":-1,\"Holster\":1858275734,\"Cloak\":-1,\"Badge\":-1,\"CoatClosed\":761551698,\"RingLh\":-1,\"RingRh\":-1,\"Belt\":-1,\"Skirt\":-1,\"Hat\":-1735668802,\"Accessories\":-1,\"Boots\":-315016488,\"Bracelet\":-1,\"Chap\":-1,\"Bow\":-1,\"EyeWear\":-1,\"NeckWear\":-1,\"GunbeltAccs\":-1,\"Satchels\":-1,\"Mask\":-1,\"Gauntlets\":-1,\"Coat\":-1,\"Dress\":-1,\"Loadouts\":-170358564,\"Shirt\":-346529404,\"Poncho\":-1,\"Spats\":-1,\"Vest\":-1,\"Spurs\":-1,\"Teeth\":712446626,\"Gunbelt\":1382144499,\"NeckTies\":-1,\"Armor\":-1,\"Pant\":1738549663,\"Suspender\":-1}', '{\"Gunbelt\":{\"1382144499\":{\"tint2\":8,\"tint0\":0,\"color\":4,\"index\":18,\"tint1\":60,\"palette\":-183908539}},\"Glove\":[],\"Holster\":{\"1858275734\":{\"tint2\":8,\"tint0\":0,\"color\":0,\"index\":15,\"tint1\":60,\"palette\":-183908539}},\"Cloak\":[],\"CoatClosed\":{\"761551698\":{\"tint2\":0,\"tint0\":28,\"color\":1,\"index\":8,\"tint1\":0,\"palette\":-783849117}},\"RingLh\":[],\"Belt\":[],\"Coat\":{\"1209418538\":{\"tint2\":53,\"tint0\":252,\"color\":8,\"index\":33,\"tint1\":16,\"palette\":1090645383}},\"Loadouts\":{\"-170358564\":{\"tint0\":0,\"tint2\":0,\"tint1\":0,\"palette\":1669565057}},\"Shirt\":{\"-346529404\":{\"tint2\":16,\"tint0\":16,\"color\":4,\"index\":14,\"tint1\":16,\"palette\":-1436165981}},\"Hat\":{\"-1735668802\":{\"tint2\":28,\"tint0\":15,\"color\":4,\"index\":146,\"tint1\":21,\"palette\":864404955}},\"Accessories\":[],\"Spats\":[],\"Buckle\":{\"1635771202\":{\"tint2\":63,\"tint0\":50,\"color\":1,\"index\":23,\"tint1\":62,\"palette\":1064202495}},\"Boots\":{\"-315016488\":{\"tint0\":74,\"tint2\":13,\"tint1\":0,\"palette\":-1543234321}},\"NeckTies\":[],\"Pant\":{\"1738549663\":{\"tint2\":35,\"tint0\":21,\"color\":0,\"index\":16,\"tint1\":16,\"palette\":1090645383},\"1939930032\":{\"tint0\":0,\"tint2\":12,\"tint1\":0,\"palette\":-783849117}},\"Chap\":[]}');

-- --------------------------------------------------------

--
-- Table structure for table `pets`
--

CREATE TABLE `pets` (
  `petid` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `dog` varchar(255) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT 0,
  `xp` int(11) NOT NULL DEFAULT 0,
  `transfered` int(11) NOT NULL DEFAULT 0,
  `called` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `pets`
--

INSERT INTO `pets` (`petid`, `identifier`, `charidentifier`, `dog`, `skin`, `xp`, `transfered`, `called`) VALUES
(10, 'steam:110000140823af3', 1, 'A_C_DogHound_01', 1, 0, 0, 0),
(11, 'steam:1100001486701fd', 7, 'A_C_DogCollie_01', 1, 0, 0, 0),
(12, 'steam:1100001486701fd', 7, 'A_C_DogBluetickCoonhound_01', 2, 0, 0, 0),
(13, 'steam:1100001562b75f9', 8, 'A_C_DogAustralianSheperd_01', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_horses`
--

CREATE TABLE `player_horses` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `components` varchar(5000) NOT NULL DEFAULT '{}',
  `gender` enum('male','female') DEFAULT 'male',
  `xp` int(11) NOT NULL DEFAULT 0,
  `captured` int(11) NOT NULL DEFAULT 0,
  `born` datetime NOT NULL DEFAULT current_timestamp(),
  `health` int(11) NOT NULL DEFAULT 50,
  `stamina` int(11) NOT NULL DEFAULT 50,
  `writhe` int(11) NOT NULL DEFAULT 0,
  `dead` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `player_horses`
--

INSERT INTO `player_horses` (`id`, `identifier`, `charid`, `selected`, `name`, `model`, `components`, `gender`, `xp`, `captured`, `born`, `health`, `stamina`, `writhe`, `dead`) VALUES
(2, 'steam:11000016e197d4f', 2, 1, 'Ghosted', 'a_c_horse_gang_micah', '[\"0x003897CA\",\"0x127E0412\",\"0x3685C57A\",\"0xE57042B4\",\"0x0354F6B7\",0,\"0x107D9598\",0,\"0x406FC6C7\",0,\"0xF772CED6\",\"0x7956475F\",\"0x0865A270\"]', 'male', 43, 0, '2025-06-18 17:06:27', 0, 0, 0, 0),
(3, 'steam:110000140823af3', 1, 1, 'Michaela', 'a_c_horse_kladruber_black', '[0,0,0,0,\"0x054A3CB0\",\"0x1A3B721B\",0,0,0,0,\"0xF772CED6\",\"0xFB2178EC\",\"0x0865A270\"]', 'female', 9, 0, '2025-06-18 18:43:03', 50, 50, 0, 0),
(4, 'steam:11000016e197d4f', 5, 0, 'whitehorseclan', 'a_c_horse_gang_dutch', '[\"0x003897CA\",\"0x20D4A0BF\",\"0x3685C57A\",\"0x867B1D30\",\"0x2D47B5FD\",0,\"0x2A28C8BE\",\"0x12F0DF9F\",\"0x4A992729\",\"0x004BBEED\",\"0xF772CED6\",\"0x880FE4D2\",\"0x0865A270\"]', 'male', 0, 0, '2025-06-19 05:40:11', 0, 0, 0, 0),
(5, 'steam:11000016e197d4f', 5, 0, 'booster', 'a_c_horse_nokota_reversedappleroan', '[\"0x19FFCB58\",\"0x127E0412\",\"0x587DD49F\",\"0xD048C482\",0,0,0,0,\"0x08A78F53\",0,0,0,0]', 'male', 267, 0, '2025-06-19 07:01:37', 100, 65, 0, 0),
(6, 'steam:1100001486701fd', 7, 0, 'Noire', 'a_c_horse_shire_ravenblack', '[\"0x454BA1F7\",\"0xC097E12C\",\"0x67AF7302\",\"0x191DB6CF\",\"0x130E341A\",\"0x33E7B1CB\",\"0x107D9598\",\"0x0AC1F34C\",0,0,\"0xF772CED6\",\"0x880FE4D2\",\"0x0865A270\"]', 'female', 39, 0, '2025-06-20 09:37:03', 0, 0, 0, 0),
(7, 'steam:1100001562b75f9', 8, 0, 'Tasha', 'a_c_horse_gang_bill', '[\"0x454BA1F7\",\"0x0FAE487F\",\"0x587DD49F\",\"0x3A9E79D0\",\"0x6CB9310E\",\"0x4124CC49\",\"0x3D2B5410\",\"0x69B21ADD\",\"0x62C5B02A\",0,\"0xF772CED6\",\"0x0C48F261\",\"0x0865A270\"]', 'female', 81, 0, '2025-06-20 11:43:44', 20, 20, 1, 0),
(8, 'steam:11000016e197d4f', 5, 1, 'blACKMAMABA', 'a_c_horse_shire_ravenblack', '[\"0x445FEF15\",\"0x269583CA\",\"0x3685C57A\",\"0x20AA8620\",\"0x14098229\",\"0x12DBBBAF\",\"0x333CDC06\",\"0x1B43F045\",\"0x53EEEBD4\",\"0x281A6D81\",\"0xF772CED6\",\"0x433DE046\",\"0x0865A270\"]', 'male', 152, 0, '2025-06-20 11:52:31', 20, 0, 0, 0),
(9, 'steam:1100001486701fd', 7, 1, 'whitey', 'a_c_horse_shire_lightgrey', '[\"0x4BC19FC4\",\"0x127E0412\",\"0x8D0BC7DA\",\"0xC05AA4AA\",\"0x94F58186\",\"0x1A3B721B\",0,0,\"0x7BFA791B\",0,0,0,0]', 'male', 0, 0, '2025-06-20 12:14:15', 50, 50, 0, 0),
(10, 'steam:11000016da2474b', 6, 1, 'roy', 'a_c_horse_ardennes_bayroan', '[\"0xF4B14B4A\",\"0xCDD2FB96\",\"0xEDF82EF6\",\"0x10DBA6D6\",\"0xFC57549F\",\"0xF867D611\",\"0xDC172DE4\",\"0xA1FD8B43\",\"0xFA5B72BB\",\"0xB755402E\",\"0xF772CED6\",\"0x0C48F261\",\"0x0865A270\"]', 'female', 40, 0, '2025-06-20 12:16:48', 30, 0, 0, 0),
(11, 'steam:11000016db4fdd0', 11, 1, 'Zahra', 'a_c_horse_arabian_white', '[\"0x4BC19FC4\",\"0x3973A986\",\"0x317A705D\",\"0xC019F804\",\"0x5DE62AE8\",\"0x475D7417\",\"0x2A28C8BE\",\"0x12F0DF9F\",0,0,\"0xF772CED6\",\"0x0C48F261\",\"0x0865A270\"]', 'female', 0, 0, '2025-06-20 21:31:24', 50, 50, 0, 0),
(12, 'steam:11000016e97323d', 10, 1, 'SpeedGhost', 'a_c_horse_gang_dutch', '[\"0x8FFCF06B\",\"0xC4C732B2\",0,\"0xAE110017\",\"0xF571F429\",0,0,\"0x7B55D476\",\"0x75637CBD\",0,\"0xF772CED6\",\"0xCFFBF4B5\",\"0x0865A270\"]', 'male', 31, 0, '2025-06-20 21:32:12', 0, 0, 0, 0),
(13, 'steam:1100001562b75f9', 8, 1, 'Tarzan', 'a_c_horse_kladruber_white', '[\"0x454BA1F7\",\"0x64BE7DF8\",\"0x29E063EB\",\"0xA5A844AC\",\"0x41EA9196\",\"0x30603BB5\",\"0xE1B1B8F1\",\"0x9FD99D7D\",\"0x406FC6C7\",0,\"0xF772CED6\",\"0x880FE4D2\",\"0x0865A270\"]', 'male', 0, 0, '2025-06-20 21:39:45', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_wagons`
--

CREATE TABLE `player_wagons` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `condition` int(11) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `player_wagons`
--

INSERT INTO `player_wagons` (`id`, `identifier`, `charid`, `selected`, `name`, `model`, `condition`) VALUES
(1, 'steam:11000016e197d4f', 5, 1, 'coachafred', 'coach5', 95);

-- --------------------------------------------------------

--
-- Table structure for table `posse`
--

CREATE TABLE `posse` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `characterid` varchar(50) NOT NULL DEFAULT '0',
  `possename` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `posse`
--

INSERT INTO `posse` (`id`, `identifier`, `characterid`, `possename`) VALUES
(1, 'steam:1100001562b75f9', '8', 'Dark Blood'),
(2, 'steam:11000016e97323d', '10', 'Ak posse');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `identifier`, `charidentifier`, `key`) VALUES
(1, 'Room 2A', 'steam:11000016e197d4f', 2, 'hk_1'),
(2, 'Room 2B', 'steam:11000016e197d4f', 5, 'hk_2');

-- --------------------------------------------------------

--
-- Table structure for table `stables`
--

CREATE TABLE `stables` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `modelname` varchar(70) NOT NULL,
  `type` varchar(11) NOT NULL,
  `status` longtext DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `injured` int(11) DEFAULT 0,
  `gear` longtext DEFAULT NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `stables`
--

INSERT INTO `stables` (`id`, `identifier`, `charidentifier`, `name`, `modelname`, `type`, `status`, `xp`, `injured`, `gear`, `isDefault`, `inventory`) VALUES
(1, 'steam:', 2, 'kabiru', 'A_C_Horse_Kladruber_Black', 'horse', NULL, 0, 0, '{\"Saddles\":3730450693,\"Blankets\":1180033890}', 1, NULL),
(2, 'steam:', 1, 'Obsidian', 'A_C_Horse_Kladruber_Black', 'horse', NULL, 0, 10, NULL, 1, NULL),
(3, 'steam:', 3, 'Noir', 'A_C_Horse_Kladruber_Black', 'horse', NULL, 0, 0, '{\"Saddles\":3730450693}', 1, NULL),
(4, 'steam:', 2, 'Hunter move', 'huntercart01', 'cart', NULL, 0, 0, NULL, 1, NULL),
(5, 'steam:', 1, 'cart1', 'cart05', 'cart', NULL, 0, 0, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `train`
--

CREATE TABLE `train` (
  `trainid` int(11) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `trainModel` varchar(50) NOT NULL,
  `fuel` int(11) NOT NULL,
  `condition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(1) DEFAULT NULL,
  `banneduntil` int(10) DEFAULT 0,
  `char` int(11) DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`identifier`, `group`, `warnings`, `banned`, `banneduntil`, `char`) VALUES
('steam:110000140823af3', 'admin', 0, 0, 0, 5),
('steam:1100001486701fd', 'user', 0, 0, 0, 5),
('steam:1100001562b75f9', 'user', 0, 0, 0, 5),
('steam:110000162cead19', 'user', 0, 0, 0, 5),
('steam:11000016da2474b', 'user', 0, 0, 0, 5),
('steam:11000016db4fdd0', 'user', 0, 0, 0, 5),
('steam:11000016e197d4f', 'admin', 0, 0, 0, 5),
('steam:11000016e97323d', 'user', 0, 0, 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `wagons`
--

CREATE TABLE `wagons` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `items` longtext DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `whitelist`
--

CREATE TABLE `whitelist` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `firstconnection` tinyint(1) DEFAULT 1,
  `discordid` varchar(255) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank_users`
--
ALTER TABLE `bank_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `bankusers` (`identifier`) USING BTREE;

--
-- Indexes for table `bcchousing`
--
ALTER TABLE `bcchousing`
  ADD PRIMARY KEY (`houseid`);

--
-- Indexes for table `bcchousinghotels`
--
ALTER TABLE `bcchousinghotels`
  ADD KEY `idx_charidentifier` (`charidentifier`);

--
-- Indexes for table `bcchousing_transactions`
--
ALTER TABLE `bcchousing_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bcc_camp`
--
ALTER TABLE `bcc_camp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bcc_crafting_log`
--
ALTER TABLE `bcc_crafting_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bcc_craft_progress`
--
ALTER TABLE `bcc_craft_progress`
  ADD PRIMARY KEY (`charidentifier`);

--
-- Indexes for table `bcc_farming`
--
ALTER TABLE `bcc_farming`
  ADD PRIMARY KEY (`plant_id`);

--
-- Indexes for table `brewing`
--
ALTER TABLE `brewing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE,
  ADD KEY `charidentifier` (`charidentifier`) USING BTREE,
  ADD KEY `identifier` (`identifier`),
  ADD KEY `compPlayer` (`compPlayer`(768)),
  ADD KEY `inventory` (`inventory`(768)),
  ADD KEY `coords` (`coords`(768)),
  ADD KEY `money` (`money`),
  ADD KEY `meta` (`meta`),
  ADD KEY `steamname` (`steamname`);

--
-- Indexes for table `character_inventories`
--
ALTER TABLE `character_inventories`
  ADD KEY `character_inventory_idx` (`character_id`,`inventory_type`);

--
-- Indexes for table `doorlocks`
--
ALTER TABLE `doorlocks`
  ADD PRIMARY KEY (`doorid`);

--
-- Indexes for table `herbalists`
--
ALTER TABLE `herbalists`
  ADD PRIMARY KEY (`identifier`) USING BTREE,
  ADD UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE;

--
-- Indexes for table `horse_complements`
--
ALTER TABLE `horse_complements`
  ADD UNIQUE KEY `identifier` (`identifier`) USING BTREE;

--
-- Indexes for table `housing`
--
ALTER TABLE `housing`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item`) USING BTREE,
  ADD UNIQUE KEY `id` (`id`) USING BTREE,
  ADD KEY `FK_items_item_group` (`groupId`) USING BTREE;

--
-- Indexes for table `items_crafted`
--
ALTER TABLE `items_crafted`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ID` (`id`),
  ADD KEY `crafted_item_idx` (`character_id`);

--
-- Indexes for table `item_group`
--
ALTER TABLE `item_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `legendaries`
--
ALTER TABLE `legendaries`
  ADD UNIQUE KEY `charidentifier` (`charidentifier`);

--
-- Indexes for table `loadout`
--
ALTER TABLE `loadout`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `mailbox_mails`
--
ALTER TABLE `mailbox_mails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oil`
--
ALTER TABLE `oil`
  ADD UNIQUE KEY `charidentifier` (`charidentifier`);

--
-- Indexes for table `outfits`
--
ALTER TABLE `outfits`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
  ADD KEY `petid` (`petid`);

--
-- Indexes for table `player_horses`
--
ALTER TABLE `player_horses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_charid` (`charid`),
  ADD KEY `idx_identifier` (`identifier`);

--
-- Indexes for table `player_wagons`
--
ALTER TABLE `player_wagons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posse`
--
ALTER TABLE `posse`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `stables`
--
ALTER TABLE `stables`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `train`
--
ALTER TABLE `train`
  ADD PRIMARY KEY (`trainid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`),
  ADD UNIQUE KEY `identifier` (`identifier`);

--
-- Indexes for table `wagons`
--
ALTER TABLE `wagons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_horses_characters` (`charid`),
  ADD KEY `model` (`model`);

--
-- Indexes for table `whitelist`
--
ALTER TABLE `whitelist`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `identifier` (`identifier`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank_users`
--
ALTER TABLE `bank_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bcchousing`
--
ALTER TABLE `bcchousing`
  MODIFY `houseid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bcchousing_transactions`
--
ALTER TABLE `bcchousing_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bcc_camp`
--
ALTER TABLE `bcc_camp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bcc_crafting_log`
--
ALTER TABLE `bcc_crafting_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bcc_farming`
--
ALTER TABLE `bcc_farming`
  MODIFY `plant_id` int(40) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `charidentifier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `doorlocks`
--
ALTER TABLE `doorlocks`
  MODIFY `doorid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items_crafted`
--
ALTER TABLE `items_crafted`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=427;

--
-- AUTO_INCREMENT for table `item_group`
--
ALTER TABLE `item_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `loadout`
--
ALTER TABLE `loadout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `mailbox_mails`
--
ALTER TABLE `mailbox_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `outfits`
--
ALTER TABLE `outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pets`
--
ALTER TABLE `pets`
  MODIFY `petid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `player_horses`
--
ALTER TABLE `player_horses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `player_wagons`
--
ALTER TABLE `player_wagons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `posse`
--
ALTER TABLE `posse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stables`
--
ALTER TABLE `stables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `train`
--
ALTER TABLE `train`
  MODIFY `trainid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wagons`
--
ALTER TABLE `wagons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `whitelist`
--
ALTER TABLE `whitelist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bank_users`
--
ALTER TABLE `bank_users`
  ADD CONSTRAINT `bankusers` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `characters`
--
ALTER TABLE `characters`
  ADD CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `FK_items_item_group` FOREIGN KEY (`groupId`) REFERENCES `item_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
