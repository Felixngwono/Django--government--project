-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 27, 2024 at 05:56 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `django-government`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add contact', 7, 'add_contact'),
(26, 'Can change contact', 7, 'change_contact'),
(27, 'Can delete contact', 7, 'delete_contact'),
(28, 'Can view contact', 7, 'view_contact'),
(29, 'Can add feedback', 8, 'add_feedback'),
(30, 'Can change feedback', 8, 'change_feedback'),
(31, 'Can delete feedback', 8, 'delete_feedback'),
(32, 'Can view feedback', 8, 'view_feedback'),
(33, 'Can add project', 9, 'add_project'),
(34, 'Can change project', 9, 'change_project'),
(35, 'Can delete project', 9, 'delete_project'),
(36, 'Can view project', 9, 'view_project'),
(37, 'Can add division', 10, 'add_division'),
(38, 'Can change division', 10, 'change_division'),
(39, 'Can delete division', 10, 'delete_division'),
(40, 'Can view division', 10, 'view_division'),
(41, 'Can add project_type', 11, 'add_project_type'),
(42, 'Can change project_type', 11, 'change_project_type'),
(43, 'Can delete project_type', 11, 'delete_project_type'),
(44, 'Can view project_type', 11, 'view_project_type'),
(45, 'Can add project_ division', 10, 'add_project_division'),
(46, 'Can change project_ division', 10, 'change_project_division'),
(47, 'Can delete project_ division', 10, 'delete_project_division'),
(48, 'Can view project_ division', 10, 'view_project_division'),
(49, 'Can add pdf', 12, 'add_pdf'),
(50, 'Can change pdf', 12, 'change_pdf'),
(51, 'Can delete pdf', 12, 'delete_pdf'),
(52, 'Can view pdf', 12, 'view_pdf');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(7, 'member', 'contact'),
(8, 'member', 'feedback'),
(12, 'member', 'pdf'),
(9, 'member', 'project'),
(10, 'member', 'project_division'),
(11, 'member', 'project_type'),
(6, 'member', 'user'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-02-23 10:14:12.710125'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-02-23 10:14:13.076350'),
(3, 'auth', '0001_initial', '2024-02-23 10:14:16.470648'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-02-23 10:14:17.013899'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-02-23 10:14:17.036166'),
(6, 'auth', '0004_alter_user_username_opts', '2024-02-23 10:14:17.059354'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-02-23 10:14:17.089517'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-02-23 10:14:17.104872'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-02-23 10:14:17.133324'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-02-23 10:14:17.152211'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-02-23 10:14:17.176585'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-02-23 10:14:17.239535'),
(13, 'auth', '0011_update_proxy_permissions', '2024-02-23 10:14:17.294186'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-02-23 10:14:17.319746'),
(15, 'member', '0001_initial', '2024-02-23 10:14:20.029561'),
(16, 'admin', '0001_initial', '2024-02-23 10:14:21.813824'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-02-23 10:14:21.880805'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-02-23 10:14:22.061037'),
(19, 'sessions', '0001_initial', '2024-02-23 10:14:22.424106'),
(20, 'member', '0002_user_avatar_user_bio_user_name_alter_user_email', '2024-02-23 10:20:40.853754'),
(21, 'member', '0003_alter_user_username', '2024-02-23 10:53:34.343461'),
(22, 'member', '0004_alter_user_username', '2024-02-23 11:19:51.606299'),
(23, 'member', '0005_contact', '2024-02-25 20:05:02.321604'),
(24, 'member', '0006_feedback', '2024-02-25 21:49:07.760282'),
(25, 'member', '0007_alter_feedback_full_name_alter_feedback_phone_number', '2024-02-25 21:55:49.426333'),
(26, 'member', '0008_project', '2024-02-26 14:18:52.860918'),
(27, 'member', '0009_alter_project_end_date', '2024-02-26 15:03:28.239391'),
(28, 'member', '0010_project_project_images_alter_project_end_date_and_more', '2024-02-29 15:17:38.564028'),
(29, 'member', '0011_alter_project_end_date_alter_project_project_images_and_more', '2024-02-29 15:31:48.613206'),
(30, 'member', '0012_alter_project_project_images', '2024-02-29 15:45:18.571650'),
(31, 'member', '0013_alter_project_project_images', '2024-02-29 15:55:47.554859'),
(32, 'member', '0014_alter_project_project_images', '2024-02-29 15:58:09.552141'),
(33, 'member', '0015_alter_project_project_images', '2024-02-29 15:59:30.801454'),
(34, 'member', '0016_alter_project_project_images', '2024-02-29 16:11:24.748076'),
(35, 'member', '0017_alter_project_project_images', '2024-02-29 16:13:10.271676'),
(36, 'member', '0018_alter_project_project_images', '2024-03-01 09:12:25.203551'),
(37, 'member', '0019_alter_project_options_alter_project_project_images', '2024-03-06 08:30:30.731169'),
(38, 'member', '0020_alter_project_project_images', '2024-03-06 09:02:45.066382'),
(39, 'member', '0021_alter_project_project_images', '2024-03-06 10:29:42.413853'),
(40, 'member', '0022_alter_project_project_images', '2024-03-06 10:31:24.289299'),
(41, 'member', '0023_alter_project_project_images', '2024-03-06 10:35:52.686205'),
(42, 'member', '0024_project_type_division', '2024-03-06 18:03:08.477682'),
(43, 'member', '0025_alter_division_options', '2024-03-07 14:49:58.677190'),
(44, 'member', '0025_alter_project_project_images', '2024-03-07 17:59:02.919658'),
(45, 'member', '0026_alter_project_project_images', '2024-03-08 07:56:12.966148'),
(46, 'member', '0027_alter_project_project_images', '2024-03-08 08:02:32.603854'),
(47, 'member', '0009_alter_project_project_images', '2024-03-08 20:21:00.869128'),
(48, 'member', '0010_project_type_alter_project_project_images_division', '2024-03-10 08:02:53.133711'),
(49, 'member', '0011_rename_division_project_division', '2024-03-10 08:10:45.831884'),
(50, 'member', '0002_user_is_enduser_alter_user_is_superuser', '2024-03-12 21:03:58.265588'),
(51, 'member', '0003_alter_user_is_enduser_alter_user_is_superuser', '2024-03-12 21:08:13.004874'),
(52, 'member', '0004_project_division_project_division', '2024-03-14 09:22:05.183523'),
(53, 'member', '0005_rename_project_division_project_division_status', '2024-03-14 09:38:24.450238'),
(54, 'member', '0006_remove_project_division_project_type_and_more', '2024-03-14 09:49:34.676048'),
(55, 'member', '0007_rename_status_project_division_project_list', '2024-03-14 16:14:34.632288'),
(56, 'member', '0008_user_profile', '2024-03-16 20:44:04.191540'),
(57, 'member', '0009_alter_user_profile', '2024-03-19 21:10:28.226833'),
(58, 'member', '0010_pdf', '2024-03-26 08:08:21.702589');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('2vt089yzk93g1jpe57uy09avc6k2uh3w', '.eJxVjMsOwiAURP-FtSGXt7h07zeQy4VK1UBS2pXx36VJF5rZnTkzbxZwW0vYel7CnNiFWXb6ZRHpmetepAfWe-PU6rrMke8KP9rOby3l1_Vw_w4K9jLW4MhokybplCNQWigCi96YLO10ttIJiOhU1NGDlJhADe7NiCBrPbDPF7SFNlM:1rhcPt:u0nI9VTPScEu_f0KIt3qoA0NruBXJG7sQAHQti-AwAo', '2024-03-19 21:33:41.747387'),
('7cqcb4uyhxobtlq22seeqtfjt1p34tfu', '.eJxVjDEOwjAQBP_iGlm5I9gxJT1viHzeMw6gRIqTCvF3iJQC2p2ZfZk-rkvp16pzP8CcDZM5_I4S00PHjeAex9tk0zQu8yB2U-xOq71O0Odld_8OSqzlW7vMXloCeWRuHWmCo4aVQ-dDOMJnEsonkEPsRAlQp4kaoPPCic37AwhYOJM:1rp4im:_tGpGbuxRybIDCAcJDIqgVCh6wnkjv2NKzK_SeOcogU', '2024-04-09 11:12:00.596147'),
('vq8jx9u6g3jv0rkhvs7p2xrpruyetmaa', '.eJxVjDEOwjAQBP_iGlm5I9gxJT1viHzeMw6gRIqTCvF3iJQC2p2ZfZk-rkvp16pzP8CcDZM5_I4S00PHjeAex9tk0zQu8yB2U-xOq71O0Odld_8OSqzlW7vMXloCeWRuHWmCo4aVQ-dDOMJnEsonkEPsRAlQp4kaoPPCic37AwhYOJM:1rnaJD:lJfsWCpGXA3wipO1J-a77bDDCZKbaWWdVksZqSrTLmc', '2024-04-05 08:31:27.730193'),
('yuhw4u40yp7imkfmp1hjsmefrumsjy3k', '.eJxVjDsOwjAQBe_iGlk268-akj5nsNY_HEC2FCcV4u4QKQW0b2bei3na1uq3kRc_J3Zhip1-t0DxkdsO0p3arfPY27rMge8KP-jgU0_5eT3cv4NKo35rGUSRELGgLUUWI43TUWR0VljtSKsIINGBJaBkCBFUQE0SDbpAZ8XeH81wNv8:1reMYv:hpkdkwmRKxdr2tVLRqN6L_QOEpHjcL5ACviepinIcoQ', '2024-03-10 22:01:33.454716');

-- --------------------------------------------------------

--
-- Table structure for table `member_contact`
--

CREATE TABLE `member_contact` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `message` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_contact`
--

INSERT INTO `member_contact` (`id`, `name`, `email`, `message`) VALUES
(2, 'Toto Lavender', 'wodinga@gmail.com', 'nmbgv'),
(3, 'Victoria Amanda', 'lavender@gmail.com', 'ergyujiopmk'),
(4, 'Toto Vanessah', 'vanessa@gmail.com', 'thanks'),
(5, 'Toto Lavender', 'oketchmichael7@gmail.com', 'vgdfsaz'),
(6, 'Frank Libe', 'libe@gmail.com', 'im frank libe and thanks for the service');

-- --------------------------------------------------------

--
-- Table structure for table `member_feedback`
--

CREATE TABLE `member_feedback` (
  `id` bigint(20) NOT NULL,
  `Full_name` varchar(30) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` int(11) DEFAULT NULL,
  `feedback` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_feedback`
--

INSERT INTO `member_feedback` (`id`, `Full_name`, `email`, `phone_number`, `feedback`) VALUES
(5, 'Victoria Amanda', 'amanda@gmail.com', 798643789, 'Amanda Nyar Usonga penjo'),
(6, 'Ashley Young', 'young@gmail.com', 798564321, 'thanks for the service');

-- --------------------------------------------------------

--
-- Table structure for table `member_pdf`
--

CREATE TABLE `member_pdf` (
  `id` bigint(20) NOT NULL,
  `project_title` varchar(100) NOT NULL,
  `project_status` varchar(10) NOT NULL,
  `project_description` longtext NOT NULL,
  `project_location` varchar(100) NOT NULL,
  `implementing_agency` varchar(100) NOT NULL,
  `project_Budget` varchar(100) NOT NULL,
  `project_images` varchar(100) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_pdf`
--

INSERT INTO `member_pdf` (`id`, `project_title`, `project_status`, `project_description`, `project_location`, `implementing_agency`, `project_Budget`, `project_images`, `start_date`, `end_date`) VALUES
(1, 'blas', 'ongoing', 'kjh vgbjhk', 'bjkm,', 'iokl', 'nnklm,', '', '2024-03-26 08:09:03.955929', '2024-03-26');

-- --------------------------------------------------------

--
-- Table structure for table `member_project`
--

CREATE TABLE `member_project` (
  `id` bigint(20) NOT NULL,
  `project_title` varchar(100) NOT NULL,
  `project_description` longtext NOT NULL,
  `project_location` varchar(100) NOT NULL,
  `implementing_agency` varchar(100) NOT NULL,
  `project_Budget` varchar(100) NOT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `project_status` varchar(10) NOT NULL,
  `project_images` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_project`
--

INSERT INTO `member_project` (`id`, `project_title`, `project_description`, `project_location`, `implementing_agency`, `project_Budget`, `start_date`, `end_date`, `project_status`, `project_images`) VALUES
(11, 'Thika super highway', 'Repair and maintanance of Thika super highway', 'Thika', 'KeNHA', '80billion', '2024-03-01 14:44:27.185753', '2024-03-09', 'upcoming', 'images/thika_Ua6mF2X.jpg'),
(12, 'Kisumu Port', 'Project extension of L.Victoria port has reached its completion stage.', 'Kisumu', 'National government', 'ksh. 10billion', '2024-03-02 06:38:03.369717', '2024-03-09', 'completed', 'images/dala.jpg'),
(18, 'tree plantation farming', 'tree plantatiion farming in Nakuru county', 'kampi ya moto- Nakuru', 'National government', '40billion', '2024-03-06 07:08:16.898200', '2024-03-09', 'ongoing', 'images/tree.jpg'),
(22, 'Street development in Dandora, Nairobi', 'The project in Dandora focuses on the implementation of a ‘model street’ in a low income neighbourhood in Nairobi. Previously a well-planned neighborhood, Dandora has gradually degenerated to almost slum status. The implementation site, a street in Dandora, was selected as it is an essential part of the ‘Must Seed’ strategy, a step by step process of making small interventions that have large impact in the community.', 'Dandora-Nairobi', 'Placemakers, KUWA, Dandora Transformation League (DTL)', '3billion', '2024-03-07 10:42:29.686591', '2024-03-09', 'ongoing', 'images/dandora_9E3A1mg.jpg'),
(24, 'Building of a Dam', 'Dam Description', 'Kisumu', 'National Government', '1B', '2024-03-12 13:04:37.000000', '2024-03-09', 'upcoming', 'images/tana_river_X7uQrF2.jpg'),
(27, 'express way', 'Completion of expressway along Haile Sellasie avenue', 'Nairobi', 'National government', '80billion', '2024-03-08 20:34:26.847574', '2024-03-09', 'completed', 'images/expressway.jpg'),
(28, 'Irrigation Farming', 'The government is yet to initiate irrigation farming along the seven Folks dams of R.Tana', 'Mount Kenya region', 'National government', '40billion', '2024-03-08 21:10:28.584586', '2024-03-09', 'upcoming', 'images/nile.jpg'),
(29, 'Kisumu Highway', 'Kisumu started as a small town called Kisuma. Grey due to the greate snaking metal rod of Jorochere', 'Kisumu', 'Nyong\'o government', '50million', '2024-03-08 22:18:37.552629', '2024-03-09', 'completed', 'images/pacho_7f3AtUZ.jpg'),
(30, 'Northlands City', 'The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'Ruiru, Nairobi city', 'Governmental Agencies', '80billion', '2024-03-12 16:42:26.359357', '2024-03-12', 'ongoing', 'images/northlands.jpg'),
(31, 'Standard Gauge Railway', 'Construction of the Mombasa-Malaba standard gauge railway was launched by President Uhuru Kenyatta on November 28, 2013.\r\n\r\nPhase one of the project – from Mombasa to Nairobi was completed in 2017.', 'Mombasa', 'Mombasa county government', 'ksh.600billion', '2024-03-12 16:45:17.015463', '2024-03-12', 'completed', 'images/sgr.png'),
(33, 'Mau Mau Road', 'Construction of a 540km road that seeks to honour the role of Mau Mau freedom fighters in the liberation of Kenya from colonialists is underway, offering three central Kenya counties a new artery into Nairobi.\r\n\r\nChristened Mau Mau Road, the highway starts at Gataka in Limuru, and then passes through Kamahindu and Kibichoi in Kiambu before negotiating its way through Kinyona in Kigumo and Ichichi in Murang’a.', 'Limuru, Nairobi', 'National government', 'ksh.600billion', '2024-03-12 20:32:35.340304', '2024-03-12', 'ongoing', 'images/mau_mau.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `member_project_division`
--

CREATE TABLE `member_project_division` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `Project_list_id` bigint(20) DEFAULT NULL,
  `project_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_project_division`
--

INSERT INTO `member_project_division` (`id`, `name`, `Project_list_id`, `project_type_id`) VALUES
(1, 'Ground Breaking', NULL, NULL),
(2, 'Tile Fittings', NULL, NULL),
(3, 'Land clearence', NULL, NULL),
(4, 'Initiation stage', NULL, NULL),
(5, 'Ground Breaking', 22, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_project_type`
--

CREATE TABLE `member_project_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_project_type`
--

INSERT INTO `member_project_type` (`id`, `name`) VALUES
(1, 'Highways'),
(2, 'Building/construction'),
(3, 'Traditional projects'),
(4, 'Agile Projects'),
(5, 'Agency Projects'),
(6, 'Remote Projects'),
(7, 'research project'),
(27, 'environmental factors');

-- --------------------------------------------------------

--
-- Table structure for table `member_user`
--

CREATE TABLE `member_user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(20) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `bio` longtext DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `is_enduser` tinyint(1) NOT NULL,
  `profile` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_user`
--

INSERT INTO `member_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `avatar`, `bio`, `name`, `is_enduser`, `profile`) VALUES
(15, 'pbkdf2_sha256$720000$s0EQTnZrzzLmHe4r4xucPy$w1tK11w+rnmwIzTXcNua1+q5puTyfRe6DoxWdi7RT6w=', '2024-03-18 19:52:21.675846', 0, 'Ajumbutule', '', '', 'omondi@gamil.com', 0, 1, '2024-03-17 08:35:44.262524', 'avatar.png', 'Im Ajumbutule', 'Frank Omondi', 1, 'images/3006.webp'),
(21, 'pbkdf2_sha256$720000$egu4GkZiUKQyRTWRl8TglI$gDt6MJ/vyTSQghwsNrrBhhV9KPezim4VmS7JYacOQ/I=', '2024-03-26 11:12:00.513063', 1, 'FelloMarley', '', '', 'fellomarley@gmail.com', 0, 1, '2024-03-18 21:04:19.576787', 'avatar.png', 'Im Marley', 'Felix Odhiambo', 0, 'images/chief_J9TcRuW.jpg'),
(22, 'felixodhiambo@kabarak.ac.ke', NULL, 1, 'StoryTeller', '', '', NULL, 1, 0, '2024-03-07 12:52:01.000000', '10', 'im Marley', 'Felix Odhiambo', 0, 'avartor.jpg'),
(23, 'pbkdf2_sha256$720000$DmNhwrWdCFAV35coAQQe6q$7wF5Km+FOQ/lU7yGFCx3bctroyESCsTie2kd/LyadPs=', '2024-03-20 19:39:13.871283', 0, 'Vanessah', '', '', 'vanessa@gmail.com', 0, 1, '2024-03-20 19:38:48.673003', 'avatar.png', 'Im Vanessah. The only Titan from the lake in the family of akina Fellix The StoryTeller', 'Toto Vanessah', 1, 'profile/amanda.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `member_user_groups`
--

CREATE TABLE `member_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member_user_user_permissions`
--

CREATE TABLE `member_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_member_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `member_contact`
--
ALTER TABLE `member_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_feedback`
--
ALTER TABLE `member_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_pdf`
--
ALTER TABLE `member_pdf`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_project`
--
ALTER TABLE `member_project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_project_divis_project_type_id_68de0c34_fk_member_pr` (`project_type_id`),
  ADD KEY `member_project_divis_Project_list_id_ff6280ac_fk_member_pr` (`Project_list_id`);

--
-- Indexes for table `member_project_type`
--
ALTER TABLE `member_project_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_user`
--
ALTER TABLE `member_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_user_email_2c519eb8_uniq` (`email`);

--
-- Indexes for table `member_user_groups`
--
ALTER TABLE `member_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_user_groups_user_id_group_id_319d015e_uniq` (`user_id`,`group_id`),
  ADD KEY `member_user_groups_group_id_0e94112f_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `member_user_user_permissions`
--
ALTER TABLE `member_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_user_user_permissions_user_id_permission_id_decb7580_uniq` (`user_id`,`permission_id`),
  ADD KEY `member_user_user_per_permission_id_01ea1829_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `member_contact`
--
ALTER TABLE `member_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_feedback`
--
ALTER TABLE `member_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_pdf`
--
ALTER TABLE `member_pdf`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_project`
--
ALTER TABLE `member_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `member_project_division`
--
ALTER TABLE `member_project_division`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_project_type`
--
ALTER TABLE `member_project_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `member_user`
--
ALTER TABLE `member_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `member_user_groups`
--
ALTER TABLE `member_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_user_user_permissions`
--
ALTER TABLE `member_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD CONSTRAINT `member_project_divis_Project_list_id_ff6280ac_fk_member_pr` FOREIGN KEY (`Project_list_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_project_divis_project_type_id_68de0c34_fk_member_pr` FOREIGN KEY (`project_type_id`) REFERENCES `member_project_type` (`id`);

--
-- Constraints for table `member_user_groups`
--
ALTER TABLE `member_user_groups`
  ADD CONSTRAINT `member_user_groups_group_id_0e94112f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `member_user_groups_user_id_b92f2689_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_user_user_permissions`
--
ALTER TABLE `member_user_user_permissions`
  ADD CONSTRAINT `member_user_user_per_permission_id_01ea1829_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `member_user_user_permissions_user_id_21f02833_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
