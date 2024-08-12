-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 06, 2024 at 12:40 PM
-- Server version: 10.11.6-MariaDB-0+deb12u1
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fearandrespect`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL,
  `account_name` varchar(24) NOT NULL,
  `account_password` varchar(65) NOT NULL,
  `account_stafflevel` tinyint(4) NOT NULL DEFAULT 0,
  `account_staffrole` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `account_contributor` tinyint(4) NOT NULL DEFAULT 0,
  `account_premiumlevel` tinyint(4) NOT NULL DEFAULT 0,
  `account_respected` int(11) NOT NULL DEFAULT 0,
  `account_reports_done` int(11) NOT NULL DEFAULT 0,
  `account_questions_done` int(11) NOT NULL DEFAULT 0,
  `account_supporter` int(11) NOT NULL DEFAULT 0,
  `account_forumname` varchar(64) NOT NULL DEFAULT 'Undefined',
  `account_discordname` varchar(64) NOT NULL DEFAULT 'Undefined',
  `account_email` varchar(256) NOT NULL DEFAULT 'Undefined',
  `account_email_verifycode` varchar(32) NOT NULL DEFAULT 'Undefined',
  `account_email_verified` tinyint(4) NOT NULL DEFAULT 0,
  `account_gunaccess` int(11) NOT NULL DEFAULT 0,
  `account_namestyle` int(11) NOT NULL DEFAULT 0,
  `account_lastip` varchar(32) NOT NULL DEFAULT '0.0.0.0.0',
  `account_setting_tips` int(11) NOT NULL DEFAULT 1,
  `account_setting_gangzones` tinyint(4) NOT NULL DEFAULT 1,
  `account_setting_blinkers` tinyint(4) NOT NULL DEFAULT 1,
  `account_setting_drawdistance` smallint(5) UNSIGNED NOT NULL DEFAULT 750,
  `account_setting_admin_cmd` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `account_setting_admin_wrn` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `account_setting_admin_msg` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `account_setting_helper_msg` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `account_gunban` int(11) NOT NULL DEFAULT 0,
  `account_bikeban` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `account_vehban` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `account_reward_amount` int(11) NOT NULL DEFAULT 0,
  `account_reward_claimed` int(11) NOT NULL DEFAULT 0,
  `account_reward_ipaddress` varchar(64) NOT NULL DEFAULT '0.0.0.0.0',
  `account_resetpass_token` varchar(24) NOT NULL DEFAULT '0',
  `account_resetpass_expire` int(11) NOT NULL DEFAULT 0,
  `account_registration_legacy` tinyint(4) NOT NULL DEFAULT 0,
  `account_lastlogin` datetime DEFAULT NULL,
  `account_name_style` tinyint(4) NOT NULL DEFAULT 0,
  `account_register_date` int(11) NOT NULL DEFAULT 0,
  `account_ucphandler` int(11) NOT NULL DEFAULT 0,
  `account_discord` varchar(50) DEFAULT NULL,
  `account_quiz_status` enum('pending','passed','failed') NOT NULL DEFAULT 'pending',
  `account_quiz_failed_tries` tinyint(4) DEFAULT NULL,
  `account_quiz_cooldown` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_notes`
--

CREATE TABLE `admin_notes` (
  `note_id` int(11) NOT NULL,
  `note_account` int(11) NOT NULL,
  `note_admin` varchar(64) NOT NULL,
  `note_date` int(11) NOT NULL,
  `note_text` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_record`
--

CREATE TABLE `admin_record` (
  `record_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `record_type` int(11) NOT NULL,
  `record_reason` varchar(64) NOT NULL,
  `record_time` int(11) NOT NULL,
  `record_admin` int(11) NOT NULL,
  `record_date` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `attach_character_id` int(11) NOT NULL DEFAULT 0,
  `attach_character_index` int(11) NOT NULL DEFAULT 0,
  `attach_character_array` int(11) NOT NULL DEFAULT 0,
  `attach_character_bone` int(11) NOT NULL DEFAULT 0,
  `attach_character_offsetx` float NOT NULL DEFAULT 0,
  `attach_character_offsety` float NOT NULL DEFAULT 0,
  `attach_character_offsetz` float NOT NULL DEFAULT 0,
  `attach_character_rotx` float NOT NULL DEFAULT 0,
  `attach_character_roty` float NOT NULL DEFAULT 0,
  `attach_character_rotz` float NOT NULL DEFAULT 0,
  `attach_character_scalex` float NOT NULL DEFAULT 0,
  `attach_character_scaley` float NOT NULL DEFAULT 0,
  `attach_character_scalez` float NOT NULL DEFAULT 0,
  `attach_character_visible` int(11) NOT NULL DEFAULT 0,
  `attach_sqlid` int(11) NOT NULL,
  `attach_character_attach_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attachpoint`
--

CREATE TABLE `attachpoint` (
  `attach_point_id` int(11) NOT NULL,
  `attach_point_type` int(11) NOT NULL DEFAULT 0,
  `attach_point_linkedbiz` int(11) NOT NULL DEFAULT 0,
  `attach_point_pos_x` float NOT NULL,
  `attach_point_pos_y` float NOT NULL,
  `attach_point_pos_z` float NOT NULL,
  `attach_point_int` int(11) NOT NULL,
  `attach_point_vw` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `bank_sqlid` int(11) NOT NULL,
  `bank_pos_x` float NOT NULL,
  `bank_pos_y` float NOT NULL,
  `bank_pos_z` float NOT NULL,
  `bank_vw` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `ban_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `account_name` varchar(24) NOT NULL,
  `account_ip` varchar(16) NOT NULL DEFAULT '0',
  `ban_admin` varchar(255) NOT NULL,
  `ban_reason` varchar(64) NOT NULL,
  `ban_time` int(11) NOT NULL,
  `unban_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blocklist`
--

CREATE TABLE `blocklist` (
  `blocklist_player_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `blocklist_blocked_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `buyable_skins`
--

CREATE TABLE `buyable_skins` (
  `buyable_skin_id` int(10) UNSIGNED NOT NULL,
  `buyable_skin_propertyid` int(10) NOT NULL,
  `buyable_skin_skinid` int(10) UNSIGNED NOT NULL,
  `buyable_skin_cost` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `player_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `player_name` varchar(24) NOT NULL,
  `player_uniqueid` varchar(12) NOT NULL DEFAULT 'undefined',
  `player_ip` varchar(64) NOT NULL DEFAULT '127.0.0.1',
  `player_registered` tinyint(4) NOT NULL DEFAULT 0,
  `player_last_pos_x` float NOT NULL DEFAULT 0,
  `player_last_pos_y` float NOT NULL DEFAULT 0,
  `player_last_pos_z` float NOT NULL DEFAULT 0,
  `player_last_pos_a` float NOT NULL DEFAULT 0,
  `player_last_pos_int` int(11) NOT NULL DEFAULT 0,
  `player_last_pos_vw` int(11) NOT NULL DEFAULT 0,
  `player_skinid` smallint(6) NOT NULL DEFAULT 264,
  `player_skin_model` varchar(128) NOT NULL DEFAULT ' ',
  `player_skin_dir` varchar(128) NOT NULL DEFAULT ' ',
  `player_chatstyle` tinyint(4) NOT NULL DEFAULT 0,
  `player_cash` int(11) NOT NULL DEFAULT 750,
  `player_bankcash` int(11) NOT NULL DEFAULT 1500,
  `player_paycheck` int(11) NOT NULL DEFAULT 0,
  `player_level` smallint(6) NOT NULL DEFAULT 1,
  `player_hours` mediumint(9) NOT NULL DEFAULT 0,
  `player_exp` mediumint(9) NOT NULL DEFAULT 8,
  `player_registerdate` int(11) NOT NULL DEFAULT 0,
  `player_logindate` int(11) NOT NULL DEFAULT 0,
  `player_driverslicense` tinyint(4) NOT NULL DEFAULT 0,
  `player_gascan` tinyint(4) NOT NULL DEFAULT 0,
  `player_radio` tinyint(4) NOT NULL DEFAULT 0,
  `player_radiochan1` smallint(6) NOT NULL DEFAULT 0,
  `player_radiochan2` smallint(6) NOT NULL DEFAULT 0,
  `player_radiochan3` smallint(6) NOT NULL DEFAULT 0,
  `player_phnumber` mediumint(9) NOT NULL DEFAULT 0,
  `player_phcolour` tinyint(4) NOT NULL DEFAULT 0,
  `player_phbg` tinyint(4) DEFAULT 0,
  `player_phcredit` mediumint(9) NOT NULL DEFAULT 0,
  `player_phbattery` tinyint(4) NOT NULL DEFAULT 0,
  `player_health` float NOT NULL DEFAULT 100,
  `player_armour` float NOT NULL DEFAULT 0,
  `player_carkey` mediumint(9) NOT NULL DEFAULT -1,
  `player_factionid` tinyint(4) NOT NULL DEFAULT 0,
  `player_factiontier` tinyint(4) NOT NULL DEFAULT 3,
  `player_factionrank` varchar(64) NOT NULL DEFAULT 'None',
  `player_factionsquad` tinyint(4) NOT NULL DEFAULT 0,
  `player_factionsquad2` tinyint(4) NOT NULL DEFAULT 0,
  `player_factionsquad3` tinyint(4) NOT NULL DEFAULT 0,
  `player_factionbadge` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `player_factionsuspension` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `player_outstanding_fines` int(11) NOT NULL DEFAULT 0,
  `player_arrest_time` int(11) NOT NULL DEFAULT 0,
  `player_arrest_x` float NOT NULL DEFAULT 0,
  `player_arrest_y` float NOT NULL DEFAULT 0,
  `player_arrest_z` float NOT NULL DEFAULT 0,
  `player_arrest_vw` int(11) NOT NULL DEFAULT 0,
  `player_arrest_int` int(11) NOT NULL DEFAULT 0,
  `player_soldproperty` int(11) NOT NULL DEFAULT 0,
  `player_rentroom` int(11) NOT NULL DEFAULT -1,
  `player_spawnproperty` int(11) NOT NULL DEFAULT 0,
  `player_maskid` int(11) NOT NULL DEFAULT 0,
  `player_hud_trademark` tinyint(4) NOT NULL DEFAULT 1,
  `player_hud_vehfadein` int(11) NOT NULL DEFAULT 1,
  `player_hud_direction` int(11) NOT NULL DEFAULT 1,
  `player_hud_datetime` int(11) NOT NULL DEFAULT 1,
  `player_hud_vehicle` tinyint(4) NOT NULL DEFAULT 1,
  `player_hud_territory` tinyint(4) NOT NULL DEFAULT 1,
  `player_hud_voicelines` int(11) NOT NULL DEFAULT 0,
  `player_hud_minigame` int(11) NOT NULL DEFAULT 0,
  `player_hud_clock` int(11) NOT NULL DEFAULT 1,
  `player_blunt_strain` smallint(6) NOT NULL DEFAULT 0,
  `player_blunt_progress` mediumint(9) NOT NULL DEFAULT 0,
  `player_bandage_cd` int(11) NOT NULL DEFAULT 0,
  `player_last_bandage_cd` int(11) NOT NULL DEFAULT 0,
  `player_helpup_cd` int(11) NOT NULL DEFAULT 0,
  `player_heal_cd` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `player_ajail_time` int(11) NOT NULL DEFAULT 0,
  `player_weed_seed_0` int(11) NOT NULL DEFAULT 0,
  `player_weed_seed_1` int(11) NOT NULL DEFAULT 0,
  `player_weed_seed_2` int(11) NOT NULL DEFAULT 0,
  `player_weed_seed_3` int(11) NOT NULL DEFAULT 0,
  `player_weed_seed_4` int(11) NOT NULL DEFAULT 0,
  `player_gd_wood` smallint(6) NOT NULL DEFAULT 0,
  `player_gd_metal` smallint(6) NOT NULL DEFAULT 0,
  `player_gd_parts` smallint(6) DEFAULT 0,
  `player_tutorial` int(11) NOT NULL DEFAULT 0,
  `player_ammo_a` int(11) NOT NULL DEFAULT 0,
  `player_ammo_b` int(11) NOT NULL DEFAULT 0,
  `player_ammo_c` int(11) NOT NULL DEFAULT 0,
  `player_ammo_d` int(11) NOT NULL DEFAULT 0,
  `player_ammo_e` int(11) NOT NULL DEFAULT 0,
  `player_ammo_f` int(11) NOT NULL DEFAULT 0,
  `player_ammo_g` int(11) NOT NULL DEFAULT 0,
  `player_ammo_h` int(11) NOT NULL DEFAULT 0,
  `player_ammo_i` int(11) NOT NULL DEFAULT 0,
  `player_ammo_j` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_0` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_1` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_2` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_3` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_4` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_5` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_6` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_7` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_8` int(11) NOT NULL DEFAULT 0,
  `player_vl_slot_9` int(11) NOT NULL DEFAULT 0,
  `player_spraytag` int(11) NOT NULL DEFAULT -1,
  `player_property_refund` int(11) NOT NULL DEFAULT 0,
  `player_vehicle_refund` int(11) NOT NULL DEFAULT 0,
  `player_update_reward` int(11) NOT NULL DEFAULT 0,
  `player_respect` int(11) NOT NULL DEFAULT 0,
  `player_fear` int(11) NOT NULL DEFAULT 0,
  `player_fnr_givable` int(11) NOT NULL DEFAULT 0,
  `player_drug_effect_ticks` int(11) NOT NULL DEFAULT 0,
  `player_drug_effect_active` int(11) NOT NULL DEFAULT 0,
  `player_drug_effect_param` int(11) NOT NULL DEFAULT 0,
  `player_drug_effect_type` int(11) NOT NULL DEFAULT 0,
  `player_mole` int(11) NOT NULL DEFAULT -1,
  `player_prop_food` int(11) NOT NULL DEFAULT 0,
  `player_prop_food_timeleft` int(11) NOT NULL DEFAULT 0,
  `player_prop_food_uses` int(11) NOT NULL DEFAULT 0,
  `player_prop_drink` int(11) NOT NULL DEFAULT 0,
  `player_prop_drink_timeleft` int(11) NOT NULL DEFAULT 0,
  `player_prop_drink_uses` int(11) NOT NULL DEFAULT 0,
  `player_prop_cigarette` int(11) NOT NULL DEFAULT 0,
  `player_prop_cigarette_uses_left` int(11) NOT NULL DEFAULT 0,
  `player_prop_menu` int(11) NOT NULL DEFAULT 0,
  `player_prop_crate` int(11) NOT NULL DEFAULT 0,
  `player_hitman` int(11) NOT NULL DEFAULT 0,
  `player_hitman_rank` int(11) NOT NULL DEFAULT 0,
  `player_hitman_killed` int(11) NOT NULL DEFAULT 0,
  `player_hitman_unlocked` int(11) NOT NULL DEFAULT 0,
  `player_robbery_cooldown` int(11) NOT NULL DEFAULT 0,
  `player_fat` float NOT NULL DEFAULT 400,
  `player_muscle` float NOT NULL DEFAULT 400,
  `player_stamina` float NOT NULL DEFAULT 400,
  `player_fightstyle` int(11) NOT NULL DEFAULT 0,
  `player_fightstyle_tick` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_1` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_1_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_2` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_2_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_3` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_3_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_4` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_4_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_5` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_5_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_6` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_6_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_7` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_7_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_8` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_8_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_9` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_9_ammo` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_0` int(11) NOT NULL DEFAULT 0,
  `player_gun_package_0_ammo` int(11) NOT NULL DEFAULT 0,
  `player_soldfurni` int(11) NOT NULL DEFAULT 0,
  `player_spraytag_wipe_cd` int(11) NOT NULL DEFAULT 0,
  `player_spraytag_dynamic` int(11) NOT NULL DEFAULT -1,
  `player_spraytag_dyn_text` varchar(64) NOT NULL DEFAULT '0',
  `player_spraytag_dyn_fcolor` int(11) NOT NULL DEFAULT 0,
  `player_spraytag_dyn_cd` int(11) NOT NULL DEFAULT 0,
  `player_spraytag_static_cd` int(11) NOT NULL DEFAULT 0,
  `player_driver_warnings` int(11) NOT NULL DEFAULT 0,
  `player_chopshop_cd` int(11) NOT NULL DEFAULT 0,
  `player_lockpicks` int(11) NOT NULL DEFAULT 0,
  `player_savings` int(11) NOT NULL DEFAULT 0,
  `player_keep_duty` int(11) NOT NULL DEFAULT 0,
  `player_gym_setup` int(11) NOT NULL DEFAULT 0,
  `player_gym_energy` int(11) NOT NULL DEFAULT 0,
  `player_gym_energy_internal` int(11) NOT NULL DEFAULT 0,
  `player_gym_weight` int(11) NOT NULL DEFAULT 0,
  `player_gym_weight_xp` int(11) NOT NULL DEFAULT 0,
  `player_gym_weight_internal` int(11) NOT NULL DEFAULT 0,
  `player_gym_muscle` int(11) NOT NULL DEFAULT 0,
  `player_gym_muscle_xp` int(11) NOT NULL DEFAULT 0,
  `player_gym_muscle_internal` int(11) NOT NULL DEFAULT 0,
  `player_gym_hunger` int(11) NOT NULL DEFAULT 0,
  `player_gym_hunger_internal` int(11) NOT NULL DEFAULT 0,
  `player_gym_thirst` int(11) NOT NULL DEFAULT 0,
  `player_gym_thirst_internal` int(11) NOT NULL DEFAULT 0,
  `player_soldfuelstation` int(11) NOT NULL DEFAULT 0,
  `player_oajail_reason` varchar(256) NOT NULL DEFAULT '0',
  `player_oajail_admin` varchar(24) NOT NULL DEFAULT '0',
  `player_pager_freq` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `player_pager_nick` varchar(12) NOT NULL DEFAULT '0',
  `player_last_mugshot` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `player_gunlicense` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `player_strawman` tinyint(4) NOT NULL DEFAULT 0,
  `player_vehdup` int(11) NOT NULL DEFAULT -1,
  `player_propdup` int(11) NOT NULL DEFAULT -1,
  `player_attribute_sex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_age` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_race` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_eyes` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_hair` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_body` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_height` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_attribute_desc` varchar(255) NOT NULL DEFAULT 'None',
  `player_skill_pistol` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_sdpistol` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_deagle` tinyint(3) UNSIGNED NOT NULL DEFAULT 2,
  `player_skill_shotgun` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_sawnoff` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_spaz` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_uzi` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_mp5` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_ak47` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_m4` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_skill_sniper` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_ammo_purged` tinyint(4) NOT NULL DEFAULT 1,
  `player_groupid` int(11) NOT NULL DEFAULT 0,
  `player_grouptier` tinyint(4) NOT NULL DEFAULT 0,
  `player_account_hidden` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `player_account_hidden_name` varchar(255) DEFAULT NULL,
  `player_admin_hidden` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `contract_sqlid` int(11) NOT NULL,
  `contract_status` int(11) NOT NULL DEFAULT 0,
  `contract_hirer` int(11) NOT NULL,
  `contract_victim` varchar(24) NOT NULL,
  `contract_fee` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `criminalfines`
--

CREATE TABLE `criminalfines` (
  `fine_id` int(10) UNSIGNED NOT NULL,
  `fine_date` datetime NOT NULL DEFAULT current_timestamp(),
  `fine_player_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fine_player_name` varchar(255) DEFAULT NULL,
  `fine_giver_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fine_giver_name` varchar(32) DEFAULT NULL,
  `fine_giver_rank` varchar(32) DEFAULT NULL,
  `fine_reason` varchar(255) DEFAULT NULL,
  `fine_reason_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fine_amount` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `fine_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `fine_revoker` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `criminalrecords`
--

CREATE TABLE `criminalrecords` (
  `record_id` int(11) NOT NULL,
  `record_desc` varchar(128) NOT NULL,
  `record_crime_type` smallint(6) NOT NULL DEFAULT -1,
  `record_date` bigint(20) NOT NULL,
  `record_holder` varchar(24) NOT NULL,
  `record_officer` varchar(24) NOT NULL,
  `record_officer_rank` varchar(255) NOT NULL,
  `record_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `record_revoker` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drugplants`
--

CREATE TABLE `drugplants` (
  `drug_plant_id` int(11) NOT NULL,
  `drug_plant_pos_x` float NOT NULL,
  `drug_plant_pos_y` float NOT NULL,
  `drug_plant_pos_z` float NOT NULL,
  `drug_plant_rot_x` float NOT NULL,
  `drug_plant_rot_y` float NOT NULL,
  `drug_plant_rot_z` float NOT NULL,
  `drug_plant_type` int(11) NOT NULL,
  `drug_plant_growth` int(11) NOT NULL,
  `drug_plant_water` int(11) NOT NULL,
  `drug_plant_water_tick` int(11) NOT NULL DEFAULT 0,
  `drug_plant_buds` int(11) NOT NULL DEFAULT 0,
  `drug_total_grams` float NOT NULL DEFAULT 0,
  `drug_grams_per_bud` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drugs_player_owned`
--

CREATE TABLE `drugs_player_owned` (
  `player_drug_sqlid` int(11) NOT NULL,
  `player_drug_index` int(11) NOT NULL,
  `player_drug_characterid` int(11) NOT NULL,
  `player_drug_type` int(11) NOT NULL,
  `player_drug_param` int(11) NOT NULL,
  `player_drug_container` int(11) NOT NULL,
  `player_drug_amount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drugs_player_packages`
--

CREATE TABLE `drugs_player_packages` (
  `package_character_id` int(11) NOT NULL,
  `package_ziploc_bag` int(11) NOT NULL,
  `package_wrapped_foil` int(11) NOT NULL,
  `package_pill_bottle` int(11) NOT NULL,
  `package_plastic_cup` int(11) NOT NULL,
  `package_pizza_box` int(11) NOT NULL,
  `package_burger_carton` int(11) NOT NULL,
  `package_milk_carton` int(11) NOT NULL,
  `package_takeaway_bag` int(11) NOT NULL,
  `package_brick` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drugs_player_stations`
--

CREATE TABLE `drugs_player_stations` (
  `drug_sqlid` int(11) NOT NULL,
  `drug_type` int(11) NOT NULL,
  `drug_param` int(11) NOT NULL DEFAULT 0,
  `drug_stage` int(11) NOT NULL DEFAULT 0,
  `drug_ticks` int(11) NOT NULL DEFAULT 0,
  `drug_pos_x` float NOT NULL,
  `drug_pos_y` float NOT NULL,
  `drug_pos_z` float NOT NULL,
  `drug_rot_x` float NOT NULL,
  `drug_rot_y` float NOT NULL,
  `drug_rot_z` float NOT NULL,
  `drug_world` int(11) NOT NULL,
  `drug_interior` int(11) NOT NULL,
  `drug_growth_param_int` int(11) NOT NULL DEFAULT 0,
  `drug_growth_param_float_i` float NOT NULL DEFAULT 0,
  `drug_growth_param_float_ii` float NOT NULL DEFAULT 0,
  `drug_growth_param_float_iii` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drugs_player_supplies`
--

CREATE TABLE `drugs_player_supplies` (
  `drug_supply_characterid` int(11) NOT NULL,
  `drug_supply_weed_0` int(11) NOT NULL,
  `drug_supply_weed_1` int(11) NOT NULL,
  `drug_supply_weed_2` int(11) NOT NULL,
  `drug_supply_coke_0` int(11) NOT NULL,
  `drug_supply_coke_1` int(11) NOT NULL,
  `drug_supply_coke_2` int(11) NOT NULL,
  `drug_supply_crack_0` int(11) NOT NULL,
  `drug_supply_crack_1` int(11) NOT NULL,
  `drug_supply_crack_2` int(11) NOT NULL,
  `drug_supply_meth_0` int(11) NOT NULL,
  `drug_supply_meth_1` int(11) NOT NULL,
  `drug_supply_meth_2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emmet`
--

CREATE TABLE `emmet` (
  `emmet_sqlid` int(11) NOT NULL,
  `emmet_name` varchar(32) NOT NULL,
  `emmet_pos_x` float DEFAULT NULL,
  `emmet_pos_y` float DEFAULT NULL,
  `emmet_pos_z` float DEFAULT NULL,
  `emmet_pos_a` float DEFAULT NULL,
  `emmet_skin` int(11) DEFAULT NULL,
  `emmet_ownedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emmet_factions`
--

CREATE TABLE `emmet_factions` (
  `emmet_faction_sqlid` int(11) NOT NULL,
  `emmet_faction_fid` int(11) NOT NULL,
  `emmet_faction_index` int(11) NOT NULL,
  `emmet_colt45_stock` int(11) DEFAULT NULL,
  `emmet_colt45_unix` int(11) DEFAULT NULL,
  `emmet_uzi_stock` int(11) DEFAULT NULL,
  `emmet_uzi_unix` int(11) DEFAULT NULL,
  `emmet_tec_stock` int(11) DEFAULT NULL,
  `emmet_tec_unix` int(11) DEFAULT NULL,
  `emmet_ak47_stock` int(11) DEFAULT NULL,
  `emmet_ak47_unix` int(11) DEFAULT NULL,
  `emmet_shotgun_stock` int(11) DEFAULT NULL,
  `emmet_shotgun_unix` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emmet_player`
--

CREATE TABLE `emmet_player` (
  `emmet_player_account_id` int(11) NOT NULL,
  `emmet_player_colt_tax` int(11) DEFAULT 0,
  `emmet_player_colt_cd` int(11) DEFAULT 0,
  `emmet_player_uzi_tax` int(11) DEFAULT 0,
  `emmet_player_uzi_cd` int(11) DEFAULT 0,
  `emmet_player_tec_tax` int(11) DEFAULT 0,
  `emmet_player_tec_cd` int(11) DEFAULT 0,
  `emmet_player_ak47_tax` int(11) DEFAULT 0,
  `emmet_player_ak47_cd` int(11) DEFAULT 0,
  `emmet_player_shotgun_tax` int(11) DEFAULT 0,
  `emmet_player_shotgun_cd` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enex_buypoint`
--

CREATE TABLE `enex_buypoint` (
  `enex_buypoint_sqlid` int(11) NOT NULL,
  `enex_buypoint_enexid` int(11) NOT NULL,
  `enex_buypoint_pos_x` float NOT NULL,
  `enex_buypoint_pos_y` float NOT NULL,
  `enex_buypoint_pos_z` float NOT NULL,
  `enex_buypoint_pos_int` int(11) NOT NULL,
  `enex_buypoint_pos_vw` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `enex_master`
--

CREATE TABLE `enex_master` (
  `enex_sqlid` int(11) NOT NULL,
  `enex_owner` smallint(6) NOT NULL DEFAULT 0,
  `enex_type` smallint(6) NOT NULL DEFAULT 0,
  `enex_money` int(11) NOT NULL DEFAULT 0,
  `enex_pos_x` float NOT NULL DEFAULT 0,
  `enex_pos_y` float NOT NULL DEFAULT 0,
  `enex_pos_z` float NOT NULL DEFAULT 0,
  `enex_pos_int` mediumint(9) NOT NULL DEFAULT 0,
  `enex_pos_vw` mediumint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_christmas`
--

CREATE TABLE `event_christmas` (
  `account_id` int(11) NOT NULL DEFAULT 0,
  `santahat` int(11) NOT NULL DEFAULT 0,
  `santa_pos_x` float DEFAULT 0,
  `santa_pos_y` float NOT NULL DEFAULT 0,
  `santa_pos_z` float NOT NULL DEFAULT 0,
  `santa_pos_rx` float NOT NULL DEFAULT 0,
  `santa_pos_ry` float NOT NULL DEFAULT 0,
  `santa_pos_rz` float NOT NULL DEFAULT 0,
  `santa_pos_sx` float NOT NULL DEFAULT 0,
  `santa_pos_sy` float NOT NULL DEFAULT 0,
  `santa_pos_sz` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_easter_eggs`
--

CREATE TABLE `event_easter_eggs` (
  `found_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `egg_id` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_halloween`
--

CREATE TABLE `event_halloween` (
  `found_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `pumpkin_id` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `faction_id` int(11) NOT NULL,
  `faction_name` varchar(256) NOT NULL DEFAULT 'Undefined',
  `faction_abbrev` varchar(5) NOT NULL DEFAULT 'Null',
  `faction_type` tinyint(4) NOT NULL DEFAULT 1,
  `faction_extra` int(11) NOT NULL DEFAULT 0,
  `faction_chat` tinyint(4) NOT NULL DEFAULT 0,
  `faction_hex` int(11) NOT NULL,
  `faction_playerslots` tinyint(4) NOT NULL DEFAULT 8,
  `faction_carslots` tinyint(4) NOT NULL DEFAULT 8,
  `faction_spawnvisible` tinyint(4) DEFAULT 0,
  `faction_spawn_x` float NOT NULL DEFAULT 0,
  `faction_spawn_y` float NOT NULL DEFAULT 0,
  `faction_spawn_z` float NOT NULL DEFAULT 0,
  `faction_spawn_a` float NOT NULL DEFAULT 0,
  `faction_spawn_int` int(11) NOT NULL DEFAULT 0,
  `faction_spawn_vw` int(11) NOT NULL DEFAULT 0,
  `faction_spawn_icon` tinyint(19) NOT NULL DEFAULT 0,
  `faction_bank` int(11) NOT NULL DEFAULT 0,
  `faction_visible` tinyint(4) NOT NULL DEFAULT 1,
  `faction_perk_cd` int(11) NOT NULL DEFAULT 0,
  `faction_assigned_emmet` tinyint(4) NOT NULL DEFAULT 0,
  `faction_f_on` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faction_skins`
--

CREATE TABLE `faction_skins` (
  `faction_skin_id` int(11) NOT NULL,
  `faction_skin_factionid` tinyint(4) NOT NULL,
  `faction_skin_skinid` mediumint(9) NOT NULL,
  `faction_skin_tier` tinyint(4) NOT NULL,
  `faction_skin_squad` tinyint(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faction_skins_dev`
--

CREATE TABLE `faction_skins_dev` (
  `faction_skin_id` int(11) NOT NULL,
  `faction_skin_factionid` tinyint(4) NOT NULL,
  `faction_skin_skinid` mediumint(9) NOT NULL,
  `faction_skin_baseid` int(11) NOT NULL,
  `faction_skin_dff` varchar(255) NOT NULL,
  `faction_skin_txd` varchar(255) NOT NULL,
  `faction_skin_tier` tinyint(4) NOT NULL,
  `faction_skin_squad` tinyint(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `firms`
--

CREATE TABLE `firms` (
  `firm_sqlid` int(11) NOT NULL,
  `firm_type` int(11) NOT NULL DEFAULT 0,
  `firm_owner` int(11) NOT NULL DEFAULT 0,
  `firm_desc` varchar(64) NOT NULL DEFAULT '0',
  `firm_collect` int(11) NOT NULL DEFAULT 0,
  `firm_pos_x` int(11) NOT NULL DEFAULT 0,
  `firm_pos_y` int(11) NOT NULL DEFAULT 0,
  `firm_pos_z` int(11) NOT NULL DEFAULT 0,
  `firm_pos_int` int(11) NOT NULL DEFAULT 0,
  `firm_pos_vw` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuelmanager`
--

CREATE TABLE `fuelmanager` (
  `fuelmanager_id` int(11) NOT NULL,
  `fuelmanager_owner` int(11) NOT NULL,
  `fuelmanager_pos_x` float NOT NULL,
  `fuelmanager_pos_y` float NOT NULL,
  `fuelmanager_pos_z` float NOT NULL,
  `fuelmanager_pos_int` int(11) NOT NULL DEFAULT 0,
  `fuelmanager_pos_vw` int(11) NOT NULL DEFAULT 0,
  `fuelmanager_income` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fuelstation`
--

CREATE TABLE `fuelstation` (
  `fuelstation_id` int(11) NOT NULL,
  `fuelstation_type` int(11) NOT NULL,
  `fuelstation_manager_id` int(11) NOT NULL,
  `fuelstation_radius` float NOT NULL,
  `fuelstation_pos_x` float NOT NULL,
  `fuelstation_pos_y` float NOT NULL,
  `fuelstation_pos_z` float NOT NULL,
  `fuelstation_pos_rx` float NOT NULL,
  `fuelstation_pos_ry` float NOT NULL,
  `fuelstation_pos_rz` float NOT NULL,
  `fuelstation_pos_int` int(11) NOT NULL,
  `fuelstation_pos_vw` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `furniture`
--

CREATE TABLE `furniture` (
  `furniture_sqlid` int(11) NOT NULL,
  `furniture_extraid` int(11) NOT NULL,
  `furniture_model` int(11) NOT NULL,
  `furniture_pos_x` float NOT NULL,
  `furniture_pos_y` float NOT NULL,
  `furniture_pos_z` float NOT NULL,
  `furniture_rot_x` float NOT NULL,
  `furniture_rot_y` float NOT NULL,
  `furniture_rot_z` float NOT NULL,
  `furniture_vw` int(11) NOT NULL,
  `furniture_int` int(11) NOT NULL,
  `furniture_txd_0` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_1` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_2` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_3` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_4` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_5` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_6` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_7` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_8` int(11) NOT NULL DEFAULT -1,
  `furniture_txd_9` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gangzones`
--

CREATE TABLE `gangzones` (
  `gz_sqlid` int(11) NOT NULL,
  `gz_min_x` float NOT NULL,
  `gz_min_y` float NOT NULL,
  `gz_max_x` float NOT NULL,
  `gz_max_y` float NOT NULL,
  `gz_faction` int(11) NOT NULL,
  `gz_contested` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `gate_sqlid` int(11) NOT NULL,
  `gate_modelid` int(11) NOT NULL,
  `gate_type` tinyint(4) NOT NULL,
  `gate_toll` int(11) NOT NULL DEFAULT 0,
  `gate_autoclose` tinyint(4) NOT NULL DEFAULT 0,
  `gate_owner` int(11) NOT NULL,
  `gate_radius` float NOT NULL DEFAULT 2.5,
  `gate_speed` float NOT NULL DEFAULT 0.75,
  `gate_interior` int(11) NOT NULL,
  `gate_virtualworld` int(11) NOT NULL,
  `gate_closed_pos_x` float NOT NULL,
  `gate_closed_pos_y` float NOT NULL,
  `gate_closed_pos_z` float NOT NULL,
  `gate_closed_rot_x` float NOT NULL,
  `gate_closed_rot_y` float NOT NULL,
  `gate_closed_rot_z` float NOT NULL,
  `gate_open_pos_x` float NOT NULL DEFAULT 0,
  `gate_open_pos_y` float NOT NULL DEFAULT 0,
  `gate_open_pos_z` float NOT NULL DEFAULT 0,
  `gate_open_rot_x` float NOT NULL DEFAULT 0,
  `gate_open_rot_y` float NOT NULL DEFAULT 0,
  `gate_open_rot_z` float NOT NULL DEFAULT 0,
  `gate_textureid0` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd0` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename0` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid1` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd1` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename1` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid2` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd2` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename2` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid3` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd3` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename3` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid4` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd4` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename4` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid5` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd5` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename5` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid6` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd6` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename6` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid7` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd7` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename7` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid8` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd8` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename8` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid9` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd9` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename9` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid10` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd10` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename10` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid11` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd11` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename11` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid12` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd12` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename12` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid13` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd13` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename13` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid14` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd14` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename14` varchar(256) NOT NULL DEFAULT 'null',
  `gate_textureid15` int(11) NOT NULL DEFAULT 0,
  `gate_texturetxd15` varchar(256) NOT NULL DEFAULT 'null',
  `gate_texturename15` varchar(256) NOT NULL DEFAULT 'null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gd_factory`
--

CREATE TABLE `gd_factory` (
  `factory` int(11) NOT NULL,
  `wood` int(11) NOT NULL DEFAULT 150,
  `metal` int(11) NOT NULL DEFAULT 150,
  `parts` int(11) NOT NULL DEFAULT 150,
  `slot_0_type` int(11) NOT NULL,
  `slot_0_wood` int(11) NOT NULL,
  `slot_0_metal` int(11) NOT NULL,
  `slot_0_parts` int(11) NOT NULL,
  `slot_0_unix` int(11) NOT NULL DEFAULT 0,
  `slot_1_type` int(11) NOT NULL,
  `slot_1_wood` int(11) NOT NULL,
  `slot_1_metal` int(11) NOT NULL,
  `slot_1_parts` int(11) NOT NULL,
  `slot_1_unix` int(11) NOT NULL DEFAULT 0,
  `slot_2_type` int(11) NOT NULL,
  `slot_2_wood` int(11) NOT NULL,
  `slot_2_metal` int(11) NOT NULL,
  `slot_2_parts` int(11) NOT NULL,
  `slot_2_unix` int(11) NOT NULL DEFAULT 0,
  `slot_3_type` int(11) NOT NULL,
  `slot_3_wood` int(11) NOT NULL,
  `slot_3_metal` int(11) NOT NULL,
  `slot_3_parts` int(11) NOT NULL,
  `slot_3_unix` int(11) NOT NULL DEFAULT 0,
  `slot_4_type` int(11) NOT NULL,
  `slot_4_wood` int(11) NOT NULL,
  `slot_4_metal` int(11) NOT NULL,
  `slot_4_parts` int(11) NOT NULL,
  `slot_4_unix` int(11) NOT NULL DEFAULT 0,
  `ammo_0_type` int(11) NOT NULL DEFAULT -1,
  `ammo_0_amount` int(11) NOT NULL DEFAULT 0,
  `ammo_0_parts` int(11) NOT NULL DEFAULT 0,
  `ammo_0_metal` int(11) NOT NULL DEFAULT 0,
  `ammo_0_unix` int(11) NOT NULL DEFAULT 0,
  `ammo_1_type` int(11) NOT NULL DEFAULT -1,
  `ammo_1_amount` int(11) NOT NULL DEFAULT 0,
  `ammo_1_parts` int(11) NOT NULL DEFAULT 0,
  `ammo_1_metal` int(11) NOT NULL DEFAULT 0,
  `ammo_1_unix` int(11) NOT NULL DEFAULT 0,
  `ammo_2_type` int(11) NOT NULL DEFAULT -1,
  `ammo_2_amount` int(11) NOT NULL DEFAULT 0,
  `ammo_2_parts` int(11) NOT NULL DEFAULT 0,
  `ammo_2_metal` int(11) NOT NULL DEFAULT 0,
  `ammo_2_unix` int(11) NOT NULL DEFAULT 0,
  `ammo_3_type` int(11) NOT NULL DEFAULT -1,
  `ammo_3_amount` int(11) NOT NULL DEFAULT 0,
  `ammo_3_parts` int(11) NOT NULL DEFAULT 0,
  `ammo_3_metal` int(11) NOT NULL DEFAULT 0,
  `ammo_3_unix` int(11) NOT NULL DEFAULT 0,
  `ammo_4_type` int(11) NOT NULL DEFAULT -1,
  `ammo_4_amount` int(11) NOT NULL DEFAULT 0,
  `ammo_4_parts` int(11) NOT NULL DEFAULT 0,
  `ammo_4_metal` int(11) NOT NULL DEFAULT 0,
  `ammo_4_unix` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `group_data_sqlid` int(11) NOT NULL,
  `group_data_type` tinyint(4) NOT NULL DEFAULT 0,
  `group_data_name` varchar(64) NOT NULL,
  `group_data_motd` varchar(128) NOT NULL,
  `group_data_chat` tinyint(4) NOT NULL,
  `group_data_hex` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gym`
--

CREATE TABLE `gym` (
  `equipment_id` int(11) NOT NULL,
  `equipment_type` tinyint(255) NOT NULL,
  `equipment_pos_x` float NOT NULL,
  `equipment_pos_y` float NOT NULL,
  `equipment_pos_z` float NOT NULL,
  `equipment_interior` int(11) NOT NULL,
  `equipment_virtualworld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kiosks`
--

CREATE TABLE `kiosks` (
  `kiosk_id` int(11) NOT NULL,
  `kiosk_name` varchar(256) NOT NULL DEFAULT 'Undefined',
  `kiosk_faction` tinyint(4) NOT NULL DEFAULT -1,
  `kiosk_squad` int(11) NOT NULL DEFAULT 0,
  `kiosk_pos_x` float NOT NULL,
  `kiosk_pos_y` float NOT NULL,
  `kiosk_pos_z` float NOT NULL,
  `kiosk_pos_int` int(11) NOT NULL DEFAULT 0,
  `kiosk_pos_vw` int(11) NOT NULL DEFAULT 0,
  `kiosk_weapon1` tinyint(4) NOT NULL DEFAULT 0,
  `kiosk_weapon1ammo` smallint(6) NOT NULL DEFAULT 0,
  `kiosk_weapon2` smallint(6) NOT NULL DEFAULT 0,
  `kiosk_weapon2ammo` smallint(6) NOT NULL DEFAULT 0,
  `kiosk_weapon3` tinyint(4) DEFAULT 0,
  `kiosk_weapon3ammo` smallint(6) NOT NULL DEFAULT 0,
  `kiosk_weapon4` tinyint(4) NOT NULL DEFAULT 0,
  `kiosk_weapon4ammo` smallint(6) NOT NULL DEFAULT 0,
  `kiosk_weapon5` tinyint(4) NOT NULL DEFAULT 0,
  `kiosk_weapon5ammo` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `licenses`
--

CREATE TABLE `licenses` (
  `license_id` int(11) NOT NULL,
  `license_no` int(11) NOT NULL,
  `license_owner` int(11) NOT NULL,
  `license_type` tinyint(4) NOT NULL,
  `license_subtype` tinyint(4) NOT NULL,
  `license_exp` int(11) NOT NULL,
  `license_issuer` int(11) NOT NULL,
  `license_status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `dir` varchar(1024) NOT NULL,
  `text` varchar(1024) NOT NULL,
  `date` varchar(1024) NOT NULL,
  `ip` varchar(1024) NOT NULL,
  `info` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `modshops`
--

CREATE TABLE `modshops` (
  `mod_shop_id` int(11) NOT NULL,
  `mod_shop_type` tinyint(4) NOT NULL,
  `mod_shop_x` float NOT NULL,
  `mod_shop_y` float NOT NULL,
  `mod_shop_z` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `passpoints`
--

CREATE TABLE `passpoints` (
  `passpoint_sqlid` int(11) NOT NULL,
  `passpoint_desc` varchar(64) NOT NULL,
  `passpoint_color` int(11) NOT NULL,
  `passpoint_type` int(11) NOT NULL,
  `passpoint_faction` int(11) NOT NULL DEFAULT 0,
  `passpoint_pos_x` float NOT NULL,
  `passpoint_pos_y` float NOT NULL,
  `passpoint_pos_z` float NOT NULL,
  `passpoint_pos_a` float NOT NULL DEFAULT 0,
  `passpoint_linked_x` float NOT NULL DEFAULT 0,
  `passpoint_linked_y` float NOT NULL DEFAULT 0,
  `passpoint_linked_z` float NOT NULL DEFAULT 0,
  `passpoint_linked_a` float NOT NULL DEFAULT 0,
  `passpoint_linked_world` int(11) NOT NULL DEFAULT 0,
  `passpoint_linked_interior` int(11) NOT NULL DEFAULT 0,
  `passpoint_pos_world` int(11) NOT NULL DEFAULT 0,
  `passpoint_pos_interior` int(11) NOT NULL DEFAULT 0,
  `passpoint_radius` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payphones`
--

CREATE TABLE `payphones` (
  `payphone_sqlid` int(11) NOT NULL,
  `payphone_number` int(11) NOT NULL DEFAULT 0,
  `payphone_pos_x` float NOT NULL DEFAULT 0,
  `payphone_pos_y` float NOT NULL DEFAULT 0,
  `payphone_pos_z` float NOT NULL DEFAULT 0,
  `payphone_facing` float NOT NULL DEFAULT 0,
  `payphone_worldid` int(11) NOT NULL DEFAULT 0,
  `payphone_interiorid` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phonebook`
--

CREATE TABLE `phonebook` (
  `phonebook_id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `phone_number` mediumint(9) NOT NULL,
  `phone_desc` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phones`
--

CREATE TABLE `phones` (
  `phone_number_id` int(11) NOT NULL,
  `phone_number_type` int(11) NOT NULL DEFAULT 0,
  `phone_number_owner` int(11) NOT NULL,
  `phone_number_digits` mediumint(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_contacts`
--

CREATE TABLE `phone_contacts` (
  `phone_contact_sqlid` int(11) NOT NULL,
  `phone_contact_owner` int(11) NOT NULL DEFAULT 0,
  `phone_contact_number` int(11) NOT NULL DEFAULT 0,
  `phone_contact_desc` varchar(64) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_logs`
--

CREATE TABLE `phone_logs` (
  `phone_log_sqlid` int(11) NOT NULL,
  `phone_log_type` int(11) DEFAULT 0,
  `phone_log_status` int(11) NOT NULL DEFAULT 0,
  `phone_log_sender` int(11) NOT NULL DEFAULT 0,
  `phone_log_recipient` int(11) NOT NULL DEFAULT 0,
  `phone_log_data` varchar(144) NOT NULL,
  `phone_log_unix` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_attachments`
--

CREATE TABLE `player_attachments` (
  `player_attach_sqlid` int(11) NOT NULL,
  `player_attach_charid` int(11) NOT NULL,
  `player_attach_model_0` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_0` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_0` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_0` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_0` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_0` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_0` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_0` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_0` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_0` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_0` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_0` float NOT NULL DEFAULT 1,
  `player_attach_visible_0` int(11) NOT NULL DEFAULT 0,
  `player_attach_model_1` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_1` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_1` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_1` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_1` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_1` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_1` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_1` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_1` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_1` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_1` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_1` float NOT NULL DEFAULT 1,
  `player_attach_visible_1` int(11) NOT NULL DEFAULT 0,
  `player_attach_model_2` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_2` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_2` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_2` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_2` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_2` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_2` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_2` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_2` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_2` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_2` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_2` float NOT NULL DEFAULT 1,
  `player_attach_visible_2` int(11) NOT NULL DEFAULT 0,
  `player_attach_model_3` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_3` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_3` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_3` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_3` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_3` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_3` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_3` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_3` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_3` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_3` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_3` float NOT NULL DEFAULT 1,
  `player_attach_visible_3` int(11) NOT NULL DEFAULT 0,
  `player_attach_model_4` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_4` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_4` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_4` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_4` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_4` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_4` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_4` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_4` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_4` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_4` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_4` float NOT NULL DEFAULT 1,
  `player_attach_visible_4` int(11) NOT NULL DEFAULT 0,
  `player_attach_model_5` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_5` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_5` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_5` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_5` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_5` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_5` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_5` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_5` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_5` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_5` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_5` float NOT NULL DEFAULT 1,
  `player_attach_visible_5` int(11) NOT NULL DEFAULT 0,
  `player_attach_model_6` int(11) NOT NULL DEFAULT 0,
  `player_attach_index_6` int(11) NOT NULL DEFAULT 0,
  `player_attach_bone_6` int(11) NOT NULL DEFAULT 0,
  `player_attach_offset_x_6` float NOT NULL DEFAULT 0,
  `player_attach_offset_y_6` float NOT NULL DEFAULT 0,
  `player_attach_offset_z_6` float NOT NULL DEFAULT 0,
  `player_attach_rot_x_6` float NOT NULL DEFAULT 0,
  `player_attach_rot_y_6` float NOT NULL DEFAULT 0,
  `player_attach_rot_z_6` float NOT NULL DEFAULT 0,
  `player_attach_scale_x_6` float NOT NULL DEFAULT 1,
  `player_attach_scale_y_6` float NOT NULL DEFAULT 1,
  `player_attach_scale_z_6` float NOT NULL DEFAULT 1,
  `player_attach_visible_6` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_drugs`
--

CREATE TABLE `player_drugs` (
  `drug_sqlid` int(11) NOT NULL,
  `drug_characterid` int(11) NOT NULL,
  `drug_package` tinyint(4) NOT NULL,
  `drug_type` tinyint(4) NOT NULL,
  `drug_grams` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_logs`
--

CREATE TABLE `player_logs` (
  `log_id` int(10) UNSIGNED NOT NULL,
  `log_time` datetime NOT NULL DEFAULT current_timestamp(),
  `log_type` tinyint(3) UNSIGNED NOT NULL,
  `log_char_id` int(10) UNSIGNED NOT NULL,
  `logged_name` varchar(32) NOT NULL,
  `logged_playerid` tinyint(3) UNSIGNED NOT NULL,
  `logged_ip` varchar(16) NOT NULL,
  `logged_zone` mediumint(8) UNSIGNED NOT NULL,
  `log_entry` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_props`
--

CREATE TABLE `player_props` (
  `prop_index` int(11) NOT NULL,
  `prop_modelid` int(11) NOT NULL,
  `prop_characterid` int(11) NOT NULL DEFAULT 0,
  `prop_offset_x` float NOT NULL DEFAULT 0,
  `prop_offset_y` float NOT NULL DEFAULT 0,
  `prop_offset_z` float NOT NULL DEFAULT 0,
  `prop_rot_x` float NOT NULL DEFAULT 0,
  `prop_rot_y` float NOT NULL DEFAULT 0,
  `prop_rot_z` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_skins`
--

CREATE TABLE `player_skins` (
  `player_skin_id` int(11) NOT NULL,
  `player_skin_charid` int(11) NOT NULL,
  `player_skin_baseid` int(11) NOT NULL,
  `player_skin_dff` varchar(64) NOT NULL,
  `player_skin_txd` varchar(64) NOT NULL,
  `player_skin_lastused` int(11) NOT NULL DEFAULT 0,
  `player_skin_disabled` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_wardrobes`
--

CREATE TABLE `player_wardrobes` (
  `player_wardrobe_char_id` int(10) UNSIGNED NOT NULL,
  `player_wardrobe_skin_id` int(10) UNSIGNED NOT NULL,
  `player_wardrobe_skin_lastused` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_weapons`
--

CREATE TABLE `player_weapons` (
  `character_id` int(11) NOT NULL,
  `weapon_id` tinyint(16) NOT NULL,
  `weapon_ammo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_weapons_attach`
--

CREATE TABLE `player_weapons_attach` (
  `SQLID` int(11) NOT NULL,
  `CharID` int(11) NOT NULL,
  `WeaponID` int(11) NOT NULL,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `RotX` float NOT NULL DEFAULT 0,
  `RotY` float NOT NULL DEFAULT 0,
  `RotZ` float NOT NULL DEFAULT 0,
  `Bone` int(11) NOT NULL DEFAULT 0,
  `Hidden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `poker`
--

CREATE TABLE `poker` (
  `poker_table_id` int(11) NOT NULL,
  `poker_table_buy_in` int(11) NOT NULL DEFAULT 0,
  `poker_table_small_blind` int(11) NOT NULL DEFAULT 0,
  `poker_table_x_pos` float NOT NULL,
  `poker_table_y_pos` float NOT NULL,
  `poker_table_z_pos` float NOT NULL,
  `poker_table_seats` tinyint(4) NOT NULL DEFAULT 0,
  `poker_table_vw` int(11) NOT NULL DEFAULT 0,
  `poker_table_interior` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pool`
--

CREATE TABLE `pool` (
  `pool_sqlid` int(11) NOT NULL,
  `pool_pos_x` float NOT NULL,
  `pool_pos_y` float NOT NULL,
  `pool_pos_z` float NOT NULL,
  `pool_pos_angle` float NOT NULL,
  `pool_pos_int` int(11) NOT NULL,
  `pool_pos_world` int(11) NOT NULL,
  `pool_color` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `property_id` int(11) NOT NULL,
  `property_type` tinyint(4) NOT NULL,
  `property_price` int(11) NOT NULL,
  `property_owner` int(11) NOT NULL,
  `property_name` varchar(128) NOT NULL DEFAULT 'Undefined',
  `property_name_color` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `property_locked` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `property_ext_x` float NOT NULL,
  `property_ext_y` float NOT NULL,
  `property_ext_z` float NOT NULL,
  `property_ext_int` int(11) NOT NULL,
  `property_ext_vw` int(11) NOT NULL,
  `property_int_x` float NOT NULL,
  `property_int_y` float NOT NULL,
  `property_int_z` float NOT NULL,
  `property_int_int` int(11) NOT NULL,
  `property_int_vw` int(11) NOT NULL DEFAULT -1,
  `property_rent` int(11) NOT NULL DEFAULT 0,
  `property_collect` int(11) NOT NULL DEFAULT 0,
  `property_gun_0` int(11) NOT NULL DEFAULT 0,
  `property_ammo_0` int(11) NOT NULL DEFAULT 0,
  `property_gun_1` int(11) NOT NULL DEFAULT 0,
  `property_ammo_1` int(11) NOT NULL DEFAULT 0,
  `property_gun_2` int(11) NOT NULL DEFAULT 0,
  `property_ammo_2` int(11) NOT NULL DEFAULT 0,
  `property_gun_3` int(11) NOT NULL DEFAULT 0,
  `property_ammo_3` int(11) NOT NULL DEFAULT 0,
  `property_gun_4` int(11) NOT NULL DEFAULT 0,
  `property_ammo_4` int(11) NOT NULL DEFAULT 0,
  `property_gun_5` int(11) NOT NULL DEFAULT 0,
  `property_ammo_5` int(11) NOT NULL DEFAULT 0,
  `property_gun_6` int(11) NOT NULL DEFAULT 0,
  `property_ammo_6` int(11) NOT NULL DEFAULT 0,
  `property_gun_7` int(11) NOT NULL DEFAULT 0,
  `property_ammo_7` int(11) NOT NULL DEFAULT 0,
  `property_gun_8` int(11) NOT NULL DEFAULT 0,
  `property_ammo_8` int(11) NOT NULL DEFAULT 0,
  `property_gun_9` int(11) NOT NULL DEFAULT 0,
  `property_ammo_9` int(11) NOT NULL DEFAULT 0,
  `property_buy_type` tinyint(4) NOT NULL DEFAULT 0,
  `property_buy_pos_x` float NOT NULL DEFAULT 0,
  `property_buy_pos_y` float NOT NULL DEFAULT 0,
  `property_buy_pos_z` float NOT NULL DEFAULT 0,
  `property_buy_pos_int` int(11) NOT NULL DEFAULT 0,
  `property_buy_pos_vw` int(11) NOT NULL DEFAULT 0,
  `property_furni_limit` int(11) NOT NULL DEFAULT 0,
  `property_fee` int(11) NOT NULL DEFAULT 0,
  `property_extra_type` int(11) NOT NULL DEFAULT 0,
  `property_extra_pos_x` float NOT NULL DEFAULT 0,
  `property_extra_pos_y` float NOT NULL DEFAULT 0,
  `property_extra_pos_z` float NOT NULL DEFAULT 0,
  `property_extra_pos_int` int(11) NOT NULL DEFAULT 0,
  `property_extra_pos_vw` int(11) NOT NULL DEFAULT 0,
  `property_drugs_type_0` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_0` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_0` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_0` float NOT NULL DEFAULT 0,
  `property_drugs_type_1` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_1` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_1` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_1` float NOT NULL DEFAULT 0,
  `property_drugs_type_2` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_2` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_2` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_2` float NOT NULL DEFAULT 0,
  `property_drugs_type_3` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_3` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_3` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_3` float NOT NULL DEFAULT 0,
  `property_drugs_type_4` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_4` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_4` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_4` float NOT NULL DEFAULT 0,
  `property_drugs_type_5` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_5` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_5` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_5` float NOT NULL DEFAULT 0,
  `property_drugs_type_6` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_6` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_6` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_6` float NOT NULL DEFAULT 0,
  `property_drugs_type_7` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_7` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_7` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_7` float NOT NULL DEFAULT 0,
  `property_drugs_type_8` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_8` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_8` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_8` float NOT NULL DEFAULT 0,
  `property_drugs_type_9` int(11) NOT NULL DEFAULT 0,
  `property_drugs_param_9` int(11) NOT NULL DEFAULT 0,
  `property_drugs_container_9` int(11) NOT NULL DEFAULT 0,
  `property_drugs_amount_9` float NOT NULL DEFAULT 0,
  `property_int_hours` int(11) NOT NULL DEFAULT -1,
  `property_int_mins` int(11) NOT NULL DEFAULT -1,
  `property_int_weather` tinyint(4) NOT NULL DEFAULT -1,
  `property_int_audio_on` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `property_int_audio_x` float NOT NULL DEFAULT 0,
  `property_int_audio_y` float NOT NULL DEFAULT 0,
  `property_int_audio_z` float NOT NULL DEFAULT 0,
  `property_int_audio_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `property_int_audio_url` varchar(255) NOT NULL DEFAULT 'NULL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refunds`
--

CREATE TABLE `refunds` (
  `refund_id` int(11) UNSIGNED NOT NULL,
  `refund_date` datetime NOT NULL DEFAULT current_timestamp(),
  `refund_player_id` int(11) UNSIGNED NOT NULL,
  `refund_type` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refund_itemtype` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refund_subtype` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refund_infratype` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refund_amount` float UNSIGNED NOT NULL DEFAULT 0,
  `refund_reason` varchar(255) NOT NULL,
  `refund_claimed` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registrations`
--

CREATE TABLE `registrations` (
  `registration_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `day` tinyint(4) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `year` mediumint(9) NOT NULL,
  `unix` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_activity`
--

CREATE TABLE `report_activity` (
  `report_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `report` varchar(128) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `server`
--

CREATE TABLE `server` (
  `server_propertytax` int(11) NOT NULL DEFAULT 0,
  `server_index` int(11) NOT NULL,
  `server_slots_jackpot` int(11) NOT NULL,
  `server_slots_motd_1` varchar(96) NOT NULL,
  `server_slots_motd_2` varchar(96) NOT NULL,
  `server_slots_motd_3` varchar(96) NOT NULL,
  `server_motd_editor` varchar(24) NOT NULL,
  `server_motd_edit_time` int(11) NOT NULL,
  `server_admin_hex` int(11) NOT NULL DEFAULT -1,
  `server_helper_hex` int(11) NOT NULL DEFAULT -1,
  `server_chopshop_factionid` int(11) NOT NULL DEFAULT -1,
  `server_chopshop_collect` int(11) NOT NULL DEFAULT 1500,
  `police_kiosk_x` float NOT NULL DEFAULT 0,
  `police_kiosk_y` float NOT NULL DEFAULT 0,
  `police_kiosk_z` float NOT NULL DEFAULT 0,
  `police_kiosk_vw` int(11) NOT NULL DEFAULT 0,
  `police_kiosk_int` int(11) NOT NULL DEFAULT 0,
  `medic_kiosk_x` float NOT NULL,
  `medic_kiosk_y` float NOT NULL,
  `medic_kiosk_z` float NOT NULL,
  `medic_kiosk_vw` tinyint(4) NOT NULL,
  `medic_kiosk_int` tinyint(4) NOT NULL,
  `dea_kiosk_x` float NOT NULL DEFAULT 0,
  `dea_kiosk_y` float NOT NULL DEFAULT 0,
  `dea_kiosk_z` float NOT NULL DEFAULT 0,
  `dea_kiosk_vw` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dea_kiosk_int` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `sheriff_kiosk_x` float NOT NULL DEFAULT 0,
  `sheriff_kiosk_y` float NOT NULL DEFAULT 0,
  `sheriff_kiosk_z` float NOT NULL DEFAULT 0,
  `sheriff_kiosk_vw` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sheriff_kiosk_int` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `server_song_url` varchar(255) NOT NULL DEFAULT 'https://streetzofls.com/themes/intro_0_gta_sa_theme.mp3',
  `police_fines_total` int(11) NOT NULL DEFAULT 0,
  `registration_ucp` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `e_session_id` int(11) NOT NULL,
  `e_session_acc` int(11) NOT NULL,
  `e_session_char` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `e_session_web` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `e_session_time` int(11) NOT NULL,
  `e_session_idle` int(11) NOT NULL,
  `e_session_ip` varchar(32) NOT NULL,
  `e_session_duty` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `e_session_unix_store` int(11) NOT NULL DEFAULT 0,
  `e_session_unix_last` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sms`
--

CREATE TABLE `sms` (
  `sms_id` int(11) NOT NULL,
  `sms_character_id` int(11) NOT NULL,
  `sms_sender` mediumint(9) NOT NULL,
  `sms_receiver_charid` int(11) NOT NULL,
  `sms_data_type` tinyint(4) NOT NULL,
  `sms_text` varchar(128) NOT NULL,
  `sms_date` int(11) NOT NULL DEFAULT 0,
  `sms_read` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sols_passpoints`
--

CREATE TABLE `sols_passpoints` (
  `passpoint_sqlid` int(11) NOT NULL,
  `passpoint_desc` varchar(64) NOT NULL,
  `passpoint_color` int(11) NOT NULL,
  `passpoint_type` int(11) NOT NULL,
  `passpoint_faction` int(11) NOT NULL DEFAULT 0,
  `passpoint_pos_x` float NOT NULL,
  `passpoint_pos_y` float NOT NULL,
  `passpoint_pos_z` float NOT NULL,
  `passpoint_pos_a` float NOT NULL DEFAULT 0,
  `passpoint_linked_x` float NOT NULL DEFAULT 0,
  `passpoint_linked_y` float NOT NULL DEFAULT 0,
  `passpoint_linked_z` float NOT NULL DEFAULT 0,
  `passpoint_linked_a` float NOT NULL DEFAULT 0,
  `passpoint_linked_world` int(11) NOT NULL DEFAULT 0,
  `passpoint_linked_interior` int(11) NOT NULL DEFAULT 0,
  `passpoint_pos_world` int(11) NOT NULL DEFAULT 0,
  `passpoint_pos_interior` int(11) NOT NULL DEFAULT 0,
  `passpoint_radius` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spraytags`
--

CREATE TABLE `spraytags` (
  `spraytag_sqlid` int(11) NOT NULL,
  `spraytag_type` tinyint(4) NOT NULL DEFAULT 0,
  `spraytag_modelid` int(11) NOT NULL,
  `spraytag_pos_x` float NOT NULL,
  `spraytag_pos_y` float NOT NULL,
  `spraytag_pos_z` float NOT NULL,
  `spraytag_rot_x` float NOT NULL,
  `spraytag_rot_y` float NOT NULL,
  `spraytag_rot_z` float NOT NULL,
  `spraytag_owner` int(11) NOT NULL,
  `spraytag_owner_acc` varchar(24) NOT NULL DEFAULT 'None',
  `spraytag_owner_char` varchar(24) NOT NULL DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `strawman_logs`
--

CREATE TABLE `strawman_logs` (
  `strawman_log_id` int(11) NOT NULL,
  `strawman_log_note` varchar(512) NOT NULL,
  `strawman_log_interact` tinyint(4) NOT NULL,
  `strawman_log_accountid` int(11) NOT NULL,
  `strawman_log_unix` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ucp_applications`
--

CREATE TABLE `ucp_applications` (
  `ucp_application_id` int(11) NOT NULL,
  `ucp_date` varchar(24) NOT NULL DEFAULT 'NaN',
  `ucp_account_id` int(11) NOT NULL DEFAULT 0,
  `ucp_account_name` varchar(24) NOT NULL,
  `ucp_account_email` varchar(96) DEFAULT NULL,
  `ucp_question_1` text NOT NULL,
  `ucp_question_2` text NOT NULL,
  `ucp_question_3` text NOT NULL,
  `ucp_question_4` text NOT NULL,
  `ucp_question_5` text NOT NULL,
  `ucp_question_6` text NOT NULL,
  `ucp_app_status` tinyint(4) NOT NULL DEFAULT 0,
  `ucp_ip_address` varchar(32) NOT NULL,
  `ucp_handled_by` varchar(24) DEFAULT 'NaN',
  `ucp_handled_note` text NOT NULL DEFAULT 'NaN',
  `ucp_handled_date` bigint(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ucp_requests`
--

CREATE TABLE `ucp_requests` (
  `ucp_request_id` int(11) NOT NULL,
  `ucp_request_name` varchar(24) NOT NULL,
  `ucp_request_ip` varchar(32) NOT NULL,
  `ucp_request_timestamp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_sqlid` int(11) NOT NULL,
  `vehicle_modelid` smallint(6) NOT NULL DEFAULT 462,
  `vehicle_type` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_jobid` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_siren` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_owner` int(11) NOT NULL DEFAULT -1,
  `vehicle_mileage` int(11) NOT NULL DEFAULT 0,
  `vehicle_color_a` smallint(6) NOT NULL DEFAULT -1,
  `vehicle_color_b` smallint(6) NOT NULL DEFAULT -1,
  `vehicle_pos_x` float NOT NULL,
  `vehicle_pos_y` float NOT NULL,
  `vehicle_pos_z` float NOT NULL,
  `vehicle_pos_a` float NOT NULL,
  `vehicle_license` varchar(16) NOT NULL DEFAULT 'LS-0000',
  `vehicle_fuel` tinyint(4) NOT NULL DEFAULT 25,
  `vehicle_neon` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_1` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_1` smallint(6) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_2` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_2` smallint(6) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_3` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_3` smallint(6) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_4` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_4` smallint(6) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_5` tinyint(4) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_5` smallint(6) NOT NULL DEFAULT 0,
  `vehicle_paintjob` tinyint(4) NOT NULL DEFAULT 3,
  `vehicle_health` float NOT NULL DEFAULT 1000,
  `vehicle_dmg_panels` int(11) NOT NULL DEFAULT 0,
  `vehicle_dmg_doors` int(11) NOT NULL DEFAULT 0,
  `vehicle_dmg_lights` int(11) NOT NULL DEFAULT 0,
  `vehicle_dmg_tires` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_6` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_6` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_7` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_7` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_8` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_8` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_9` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_9` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_wep_10` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_ammo_10` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_1` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_1` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_1` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_1` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_2` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_2` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_2` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_2` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_3` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_3` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_3` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_3` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_4` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_4` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_4` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_4` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_5` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_5` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_5` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_5` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_6` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_6` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_6` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_6` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_7` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_7` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_7` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_7` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_8` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_8` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_8` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_8` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_9` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_9` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_9` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_9` float NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_type_10` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_param_10` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_cont_10` int(11) NOT NULL DEFAULT 0,
  `vehicle_trunk_drugs_amount_10` float NOT NULL DEFAULT 0,
  `vehicle_doors` int(11) NOT NULL DEFAULT 0,
  `vehicle_parked_at` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `vehicle_impounded` int(11) NOT NULL DEFAULT 0,
  `vehicle_impounded_until` datetime DEFAULT NULL,
  `vehicle_impound_cost` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `vehicle_impound_reason` varchar(255) DEFAULT NULL,
  `vehicle_impounded_by` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_components`
--

CREATE TABLE `vehicle_components` (
  `componentid` smallint(4) UNSIGNED NOT NULL,
  `part` enum('Exhausts','Front Bullbars','Front Bumper','Hood','Hydraulics','Lights','Misc','Rear Bullbars','Rear Bumper','Roof','Side Skirts','Spoilers','Vents','Wheels') DEFAULT NULL,
  `type` varchar(22) NOT NULL,
  `cars` smallint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_model_parts`
--

CREATE TABLE `vehicle_model_parts` (
  `modelid` smallint(3) UNSIGNED NOT NULL,
  `parts` bit(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_saved_mods`
--

CREATE TABLE `vehicle_saved_mods` (
  `vehicle_saved_id` int(11) NOT NULL,
  `vehicle_sql_id` int(11) NOT NULL,
  `vehicle_component_id` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_trunks`
--

CREATE TABLE `vehicle_trunks` (
  `trunk_sql_id` int(11) NOT NULL,
  `trunk_veh_sql_id` int(11) NOT NULL,
  `trunk_weapon_1` tinyint(11) NOT NULL,
  `trunk_weapon_ammo_1` int(11) NOT NULL,
  `trunk_weapon_2` tinyint(11) NOT NULL,
  `trunk_weapon_ammo_2` int(11) NOT NULL,
  `trunk_weapon_3` tinyint(11) NOT NULL,
  `trunk_weapon_ammo_3` int(11) NOT NULL,
  `trunk_weapon_4` tinyint(11) NOT NULL,
  `trunk_weapon_ammo_4` int(11) NOT NULL,
  `trunk_weapon_5` tinyint(11) NOT NULL,
  `trunk_weapon_ammo_5` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wardrobes`
--

CREATE TABLE `wardrobes` (
  `wardrobe_id` int(10) UNSIGNED NOT NULL,
  `wardrobe_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `wardrobe_owner` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `wardrobe_name` varchar(255) DEFAULT 'Wardrobe',
  `wardrobe_pos_x` float NOT NULL,
  `wardrobe_pos_y` float NOT NULL,
  `wardrobe_pos_z` float NOT NULL,
  `wardrobe_pos_a` float NOT NULL DEFAULT 0,
  `wardrobe_world` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `wardrobe_int` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weapons`
--

CREATE TABLE `weapons` (
  `character_id` int(11) NOT NULL,
  `weapon_id` tinyint(16) NOT NULL,
  `weapon_ammo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_id`);

--
-- Indexes for table `admin_notes`
--
ALTER TABLE `admin_notes`
  ADD PRIMARY KEY (`note_id`);

--
-- Indexes for table `admin_record`
--
ALTER TABLE `admin_record`
  ADD PRIMARY KEY (`record_id`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`attach_sqlid`);

--
-- Indexes for table `attachpoint`
--
ALTER TABLE `attachpoint`
  ADD PRIMARY KEY (`attach_point_id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`bank_sqlid`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`ban_id`);

--
-- Indexes for table `buyable_skins`
--
ALTER TABLE `buyable_skins`
  ADD PRIMARY KEY (`buyable_skin_id`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`contract_sqlid`);

--
-- Indexes for table `criminalfines`
--
ALTER TABLE `criminalfines`
  ADD PRIMARY KEY (`fine_id`);

--
-- Indexes for table `criminalrecords`
--
ALTER TABLE `criminalrecords`
  ADD PRIMARY KEY (`record_id`);

--
-- Indexes for table `drugplants`
--
ALTER TABLE `drugplants`
  ADD PRIMARY KEY (`drug_plant_id`),
  ADD UNIQUE KEY `drug_plant_id` (`drug_plant_id`);

--
-- Indexes for table `drugs_player_owned`
--
ALTER TABLE `drugs_player_owned`
  ADD PRIMARY KEY (`player_drug_sqlid`);

--
-- Indexes for table `drugs_player_packages`
--
ALTER TABLE `drugs_player_packages`
  ADD PRIMARY KEY (`package_character_id`);

--
-- Indexes for table `drugs_player_stations`
--
ALTER TABLE `drugs_player_stations`
  ADD PRIMARY KEY (`drug_sqlid`);

--
-- Indexes for table `drugs_player_supplies`
--
ALTER TABLE `drugs_player_supplies`
  ADD UNIQUE KEY `drug_supply_characterid` (`drug_supply_characterid`);

--
-- Indexes for table `emmet`
--
ALTER TABLE `emmet`
  ADD PRIMARY KEY (`emmet_sqlid`) USING BTREE;

--
-- Indexes for table `emmet_factions`
--
ALTER TABLE `emmet_factions`
  ADD PRIMARY KEY (`emmet_faction_sqlid`);

--
-- Indexes for table `emmet_player`
--
ALTER TABLE `emmet_player`
  ADD PRIMARY KEY (`emmet_player_account_id`),
  ADD UNIQUE KEY `unique_emmet_player_account_id` (`emmet_player_account_id`);

--
-- Indexes for table `enex_buypoint`
--
ALTER TABLE `enex_buypoint`
  ADD PRIMARY KEY (`enex_buypoint_sqlid`),
  ADD UNIQUE KEY `enex_buypoint_sqlid_2` (`enex_buypoint_sqlid`),
  ADD KEY `enex_buypoint_sqlid` (`enex_buypoint_sqlid`),
  ADD KEY `enex_buypoint_sqlid_3` (`enex_buypoint_sqlid`);

--
-- Indexes for table `enex_master`
--
ALTER TABLE `enex_master`
  ADD PRIMARY KEY (`enex_sqlid`);

--
-- Indexes for table `event_christmas`
--
ALTER TABLE `event_christmas`
  ADD PRIMARY KEY (`account_id`),
  ADD UNIQUE KEY `account_id` (`account_id`);

--
-- Indexes for table `event_easter_eggs`
--
ALTER TABLE `event_easter_eggs`
  ADD PRIMARY KEY (`found_id`);

--
-- Indexes for table `event_halloween`
--
ALTER TABLE `event_halloween`
  ADD PRIMARY KEY (`found_id`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`faction_id`);

--
-- Indexes for table `faction_skins`
--
ALTER TABLE `faction_skins`
  ADD PRIMARY KEY (`faction_skin_id`);

--
-- Indexes for table `faction_skins_dev`
--
ALTER TABLE `faction_skins_dev`
  ADD PRIMARY KEY (`faction_skin_id`);

--
-- Indexes for table `firms`
--
ALTER TABLE `firms`
  ADD PRIMARY KEY (`firm_sqlid`);

--
-- Indexes for table `fuelmanager`
--
ALTER TABLE `fuelmanager`
  ADD PRIMARY KEY (`fuelmanager_id`);

--
-- Indexes for table `fuelstation`
--
ALTER TABLE `fuelstation`
  ADD PRIMARY KEY (`fuelstation_id`);

--
-- Indexes for table `furniture`
--
ALTER TABLE `furniture`
  ADD PRIMARY KEY (`furniture_sqlid`);

--
-- Indexes for table `gangzones`
--
ALTER TABLE `gangzones`
  ADD PRIMARY KEY (`gz_sqlid`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`gate_sqlid`);

--
-- Indexes for table `gd_factory`
--
ALTER TABLE `gd_factory`
  ADD PRIMARY KEY (`factory`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`group_data_sqlid`);

--
-- Indexes for table `gym`
--
ALTER TABLE `gym`
  ADD PRIMARY KEY (`equipment_id`);

--
-- Indexes for table `kiosks`
--
ALTER TABLE `kiosks`
  ADD PRIMARY KEY (`kiosk_id`);

--
-- Indexes for table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`license_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modshops`
--
ALTER TABLE `modshops`
  ADD PRIMARY KEY (`mod_shop_id`);

--
-- Indexes for table `passpoints`
--
ALTER TABLE `passpoints`
  ADD PRIMARY KEY (`passpoint_sqlid`);

--
-- Indexes for table `payphones`
--
ALTER TABLE `payphones`
  ADD PRIMARY KEY (`payphone_sqlid`);

--
-- Indexes for table `phonebook`
--
ALTER TABLE `phonebook`
  ADD PRIMARY KEY (`phonebook_id`);

--
-- Indexes for table `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`phone_number_id`),
  ADD UNIQUE KEY `phone_number_digits` (`phone_number_digits`);

--
-- Indexes for table `phone_contacts`
--
ALTER TABLE `phone_contacts`
  ADD PRIMARY KEY (`phone_contact_sqlid`);

--
-- Indexes for table `phone_logs`
--
ALTER TABLE `phone_logs`
  ADD PRIMARY KEY (`phone_log_sqlid`);

--
-- Indexes for table `player_attachments`
--
ALTER TABLE `player_attachments`
  ADD PRIMARY KEY (`player_attach_sqlid`);

--
-- Indexes for table `player_drugs`
--
ALTER TABLE `player_drugs`
  ADD PRIMARY KEY (`drug_sqlid`);

--
-- Indexes for table `player_logs`
--
ALTER TABLE `player_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `log_type` (`log_type`),
  ADD KEY `log_char_id` (`log_char_id`),
  ADD KEY `log_id` (`log_id`),
  ADD KEY `log_time` (`log_time`);

--
-- Indexes for table `player_props`
--
ALTER TABLE `player_props`
  ADD UNIQUE KEY `prop_index` (`prop_index`);

--
-- Indexes for table `player_skins`
--
ALTER TABLE `player_skins`
  ADD PRIMARY KEY (`player_skin_id`),
  ADD KEY `player_skin_charid` (`player_skin_charid`);

--
-- Indexes for table `player_wardrobes`
--
ALTER TABLE `player_wardrobes`
  ADD PRIMARY KEY (`player_wardrobe_char_id`,`player_wardrobe_skin_id`);

--
-- Indexes for table `player_weapons`
--
ALTER TABLE `player_weapons`
  ADD UNIQUE KEY `character_id` (`character_id`,`weapon_id`);

--
-- Indexes for table `player_weapons_attach`
--
ALTER TABLE `player_weapons_attach`
  ADD PRIMARY KEY (`SQLID`);

--
-- Indexes for table `poker`
--
ALTER TABLE `poker`
  ADD PRIMARY KEY (`poker_table_id`);

--
-- Indexes for table `pool`
--
ALTER TABLE `pool`
  ADD PRIMARY KEY (`pool_sqlid`),
  ADD UNIQUE KEY `pool_sqlid` (`pool_sqlid`),
  ADD KEY `pool_sqlid_2` (`pool_sqlid`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`property_id`);

--
-- Indexes for table `refunds`
--
ALTER TABLE `refunds`
  ADD PRIMARY KEY (`refund_id`);

--
-- Indexes for table `registrations`
--
ALTER TABLE `registrations`
  ADD PRIMARY KEY (`registration_id`),
  ADD UNIQUE KEY `account_id` (`account_id`);

--
-- Indexes for table `report_activity`
--
ALTER TABLE `report_activity`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `server`
--
ALTER TABLE `server`
  ADD PRIMARY KEY (`server_index`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`e_session_id`);

--
-- Indexes for table `sms`
--
ALTER TABLE `sms`
  ADD PRIMARY KEY (`sms_id`);

--
-- Indexes for table `sols_passpoints`
--
ALTER TABLE `sols_passpoints`
  ADD PRIMARY KEY (`passpoint_sqlid`);

--
-- Indexes for table `spraytags`
--
ALTER TABLE `spraytags`
  ADD PRIMARY KEY (`spraytag_sqlid`);

--
-- Indexes for table `strawman_logs`
--
ALTER TABLE `strawman_logs`
  ADD PRIMARY KEY (`strawman_log_id`);

--
-- Indexes for table `ucp_applications`
--
ALTER TABLE `ucp_applications`
  ADD PRIMARY KEY (`ucp_application_id`);

--
-- Indexes for table `ucp_requests`
--
ALTER TABLE `ucp_requests`
  ADD PRIMARY KEY (`ucp_request_id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_sqlid`);

--
-- Indexes for table `vehicle_components`
--
ALTER TABLE `vehicle_components`
  ADD PRIMARY KEY (`componentid`),
  ADD KEY `cars` (`cars`),
  ADD KEY `part` (`part`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `vehicle_model_parts`
--
ALTER TABLE `vehicle_model_parts`
  ADD PRIMARY KEY (`modelid`);

--
-- Indexes for table `vehicle_saved_mods`
--
ALTER TABLE `vehicle_saved_mods`
  ADD PRIMARY KEY (`vehicle_saved_id`);

--
-- Indexes for table `vehicle_trunks`
--
ALTER TABLE `vehicle_trunks`
  ADD PRIMARY KEY (`trunk_sql_id`);

--
-- Indexes for table `wardrobes`
--
ALTER TABLE `wardrobes`
  ADD PRIMARY KEY (`wardrobe_id`);

--
-- Indexes for table `weapons`
--
ALTER TABLE `weapons`
  ADD UNIQUE KEY `character_id` (`character_id`,`weapon_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_notes`
--
ALTER TABLE `admin_notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_record`
--
ALTER TABLE `admin_record`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `attach_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attachpoint`
--
ALTER TABLE `attachpoint`
  MODIFY `attach_point_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `bank_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `ban_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buyable_skins`
--
ALTER TABLE `buyable_skins`
  MODIFY `buyable_skin_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `contract_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `criminalfines`
--
ALTER TABLE `criminalfines`
  MODIFY `fine_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `criminalrecords`
--
ALTER TABLE `criminalrecords`
  MODIFY `record_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drugplants`
--
ALTER TABLE `drugplants`
  MODIFY `drug_plant_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drugs_player_owned`
--
ALTER TABLE `drugs_player_owned`
  MODIFY `player_drug_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drugs_player_stations`
--
ALTER TABLE `drugs_player_stations`
  MODIFY `drug_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emmet`
--
ALTER TABLE `emmet`
  MODIFY `emmet_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emmet_factions`
--
ALTER TABLE `emmet_factions`
  MODIFY `emmet_faction_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enex_buypoint`
--
ALTER TABLE `enex_buypoint`
  MODIFY `enex_buypoint_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enex_master`
--
ALTER TABLE `enex_master`
  MODIFY `enex_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_easter_eggs`
--
ALTER TABLE `event_easter_eggs`
  MODIFY `found_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_halloween`
--
ALTER TABLE `event_halloween`
  MODIFY `found_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `faction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faction_skins`
--
ALTER TABLE `faction_skins`
  MODIFY `faction_skin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faction_skins_dev`
--
ALTER TABLE `faction_skins_dev`
  MODIFY `faction_skin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `firms`
--
ALTER TABLE `firms`
  MODIFY `firm_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuelmanager`
--
ALTER TABLE `fuelmanager`
  MODIFY `fuelmanager_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuelstation`
--
ALTER TABLE `fuelstation`
  MODIFY `fuelstation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `furniture`
--
ALTER TABLE `furniture`
  MODIFY `furniture_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gangzones`
--
ALTER TABLE `gangzones`
  MODIFY `gz_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gates`
--
ALTER TABLE `gates`
  MODIFY `gate_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `group_data_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gym`
--
ALTER TABLE `gym`
  MODIFY `equipment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kiosks`
--
ALTER TABLE `kiosks`
  MODIFY `kiosk_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `licenses`
--
ALTER TABLE `licenses`
  MODIFY `license_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modshops`
--
ALTER TABLE `modshops`
  MODIFY `mod_shop_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `passpoints`
--
ALTER TABLE `passpoints`
  MODIFY `passpoint_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payphones`
--
ALTER TABLE `payphones`
  MODIFY `payphone_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phonebook`
--
ALTER TABLE `phonebook`
  MODIFY `phonebook_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phones`
--
ALTER TABLE `phones`
  MODIFY `phone_number_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_contacts`
--
ALTER TABLE `phone_contacts`
  MODIFY `phone_contact_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_logs`
--
ALTER TABLE `phone_logs`
  MODIFY `phone_log_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_attachments`
--
ALTER TABLE `player_attachments`
  MODIFY `player_attach_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_drugs`
--
ALTER TABLE `player_drugs`
  MODIFY `drug_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_logs`
--
ALTER TABLE `player_logs`
  MODIFY `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_props`
--
ALTER TABLE `player_props`
  MODIFY `prop_index` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_skins`
--
ALTER TABLE `player_skins`
  MODIFY `player_skin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_weapons_attach`
--
ALTER TABLE `player_weapons_attach`
  MODIFY `SQLID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `poker`
--
ALTER TABLE `poker`
  MODIFY `poker_table_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pool`
--
ALTER TABLE `pool`
  MODIFY `pool_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `property_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refunds`
--
ALTER TABLE `refunds`
  MODIFY `refund_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registrations`
--
ALTER TABLE `registrations`
  MODIFY `registration_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_activity`
--
ALTER TABLE `report_activity`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `e_session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sms`
--
ALTER TABLE `sms`
  MODIFY `sms_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sols_passpoints`
--
ALTER TABLE `sols_passpoints`
  MODIFY `passpoint_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spraytags`
--
ALTER TABLE `spraytags`
  MODIFY `spraytag_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `strawman_logs`
--
ALTER TABLE `strawman_logs`
  MODIFY `strawman_log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ucp_applications`
--
ALTER TABLE `ucp_applications`
  MODIFY `ucp_application_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ucp_requests`
--
ALTER TABLE `ucp_requests`
  MODIFY `ucp_request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_saved_mods`
--
ALTER TABLE `vehicle_saved_mods`
  MODIFY `vehicle_saved_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wardrobes`
--
ALTER TABLE `wardrobes`
  MODIFY `wardrobe_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
