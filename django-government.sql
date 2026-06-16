-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2026 at 07:36 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(25, 'Can add announcement', 7, 'add_announcement'),
(26, 'Can change announcement', 7, 'change_announcement'),
(27, 'Can delete announcement', 7, 'delete_announcement'),
(28, 'Can view announcement', 7, 'view_announcement'),
(29, 'Can add contact', 8, 'add_contact'),
(30, 'Can change contact', 8, 'change_contact'),
(31, 'Can delete contact', 8, 'delete_contact'),
(32, 'Can view contact', 8, 'view_contact'),
(33, 'Can add contractor', 9, 'add_contractor'),
(34, 'Can change contractor', 9, 'change_contractor'),
(35, 'Can delete contractor', 9, 'delete_contractor'),
(36, 'Can view contractor', 9, 'view_contractor'),
(37, 'Can add feedback', 10, 'add_feedback'),
(38, 'Can change feedback', 10, 'change_feedback'),
(39, 'Can delete feedback', 10, 'delete_feedback'),
(40, 'Can view feedback', 10, 'view_feedback'),
(41, 'Can add project', 11, 'add_project'),
(42, 'Can change project', 11, 'change_project'),
(43, 'Can delete project', 11, 'delete_project'),
(44, 'Can view project', 11, 'view_project'),
(45, 'Can add project expense', 12, 'add_projectexpense'),
(46, 'Can change project expense', 12, 'change_projectexpense'),
(47, 'Can delete project expense', 12, 'delete_projectexpense'),
(48, 'Can view project expense', 12, 'view_projectexpense'),
(49, 'Can add project stage', 13, 'add_projectstage'),
(50, 'Can change project stage', 13, 'change_projectstage'),
(51, 'Can delete project stage', 13, 'delete_projectstage'),
(52, 'Can view project stage', 13, 'view_projectstage'),
(53, 'Can add team', 14, 'add_team'),
(54, 'Can change team', 14, 'change_team'),
(55, 'Can delete team', 14, 'delete_team'),
(56, 'Can view team', 14, 'view_team'),
(57, 'Can add tender', 15, 'add_tender'),
(58, 'Can change tender', 15, 'change_tender'),
(59, 'Can delete tender', 15, 'delete_tender'),
(60, 'Can view tender', 15, 'view_tender'),
(61, 'Can add testimonial', 16, 'add_testimonial'),
(62, 'Can change testimonial', 16, 'change_testimonial'),
(63, 'Can delete testimonial', 16, 'delete_testimonial'),
(64, 'Can view testimonial', 16, 'view_testimonial'),
(65, 'Can add tender application', 17, 'add_tenderapplication'),
(66, 'Can change tender application', 17, 'change_tenderapplication'),
(67, 'Can delete tender application', 17, 'delete_tenderapplication'),
(68, 'Can view tender application', 17, 'view_tenderapplication'),
(69, 'Can add stakeholder', 18, 'add_stakeholder'),
(70, 'Can change stakeholder', 18, 'change_stakeholder'),
(71, 'Can delete stakeholder', 18, 'delete_stakeholder'),
(72, 'Can view stakeholder', 18, 'view_stakeholder'),
(73, 'Can add stage report', 19, 'add_stagereport'),
(74, 'Can change stage report', 19, 'change_stagereport'),
(75, 'Can delete stage report', 19, 'delete_stagereport'),
(76, 'Can view stage report', 19, 'view_stagereport'),
(77, 'Can add report issue', 20, 'add_reportissue'),
(78, 'Can change report issue', 20, 'change_reportissue'),
(79, 'Can delete report issue', 20, 'delete_reportissue'),
(80, 'Can view report issue', 20, 'view_reportissue'),
(81, 'Can add project update', 21, 'add_projectupdate'),
(82, 'Can change project update', 21, 'change_projectupdate'),
(83, 'Can delete project update', 21, 'delete_projectupdate'),
(84, 'Can view project update', 21, 'view_projectupdate'),
(85, 'Can add project risk', 22, 'add_projectrisk'),
(86, 'Can change project risk', 22, 'change_projectrisk'),
(87, 'Can delete project risk', 22, 'delete_projectrisk'),
(88, 'Can view project risk', 22, 'view_projectrisk'),
(89, 'Can add project report', 23, 'add_projectreport'),
(90, 'Can change project report', 23, 'change_projectreport'),
(91, 'Can delete project report', 23, 'delete_projectreport'),
(92, 'Can view project report', 23, 'view_projectreport'),
(93, 'Can add project document', 24, 'add_projectdocument'),
(94, 'Can change project document', 24, 'change_projectdocument'),
(95, 'Can delete project document', 24, 'delete_projectdocument'),
(96, 'Can view project document', 24, 'view_projectdocument'),
(97, 'Can add project_type', 25, 'add_project_type'),
(98, 'Can change project_type', 25, 'change_project_type'),
(99, 'Can delete project_type', 25, 'delete_project_type'),
(100, 'Can view project_type', 25, 'view_project_type'),
(101, 'Can add project_ division', 26, 'add_project_division'),
(102, 'Can change project_ division', 26, 'change_project_division'),
(103, 'Can delete project_ division', 26, 'delete_project_division'),
(104, 'Can view project_ division', 26, 'view_project_division'),
(105, 'Can add progress update', 27, 'add_progressupdate'),
(106, 'Can change progress update', 27, 'change_progressupdate'),
(107, 'Can delete progress update', 27, 'delete_progressupdate'),
(108, 'Can view progress update', 27, 'view_progressupdate'),
(109, 'Can add progress report', 28, 'add_progressreport'),
(110, 'Can change progress report', 28, 'change_progressreport'),
(111, 'Can delete progress report', 28, 'delete_progressreport'),
(112, 'Can view progress report', 28, 'view_progressreport'),
(113, 'Can add program impact', 29, 'add_programimpact'),
(114, 'Can change program impact', 29, 'change_programimpact'),
(115, 'Can delete program impact', 29, 'delete_programimpact'),
(116, 'Can view program impact', 29, 'view_programimpact'),
(117, 'Can add program funding', 30, 'add_programfunding'),
(118, 'Can change program funding', 30, 'change_programfunding'),
(119, 'Can delete program funding', 30, 'delete_programfunding'),
(120, 'Can view program funding', 30, 'view_programfunding'),
(121, 'Can add pdf', 31, 'add_pdf'),
(122, 'Can change pdf', 31, 'change_pdf'),
(123, 'Can delete pdf', 31, 'delete_pdf'),
(124, 'Can view pdf', 31, 'view_pdf'),
(125, 'Can add participation', 32, 'add_participation'),
(126, 'Can change participation', 32, 'change_participation'),
(127, 'Can delete participation', 32, 'delete_participation'),
(128, 'Can view participation', 32, 'view_participation'),
(129, 'Can add notification', 33, 'add_notification'),
(130, 'Can change notification', 33, 'change_notification'),
(131, 'Can delete notification', 33, 'delete_notification'),
(132, 'Can view notification', 33, 'view_notification'),
(133, 'Can add milestone', 34, 'add_milestone'),
(134, 'Can change milestone', 34, 'change_milestone'),
(135, 'Can delete milestone', 34, 'delete_milestone'),
(136, 'Can view milestone', 34, 'view_milestone'),
(137, 'Can add media', 35, 'add_media'),
(138, 'Can change media', 35, 'change_media'),
(139, 'Can delete media', 35, 'delete_media'),
(140, 'Can view media', 35, 'view_media'),
(141, 'Can add contractor rating', 36, 'add_contractorrating'),
(142, 'Can change contractor rating', 36, 'change_contractorrating'),
(143, 'Can delete contractor rating', 36, 'delete_contractorrating'),
(144, 'Can view contractor rating', 36, 'view_contractorrating'),
(145, 'Can add comment', 37, 'add_comment'),
(146, 'Can change comment', 37, 'change_comment'),
(147, 'Can delete comment', 37, 'delete_comment'),
(148, 'Can view comment', 37, 'view_comment'),
(149, 'Can add citizen submission', 38, 'add_citizensubmission'),
(150, 'Can change citizen submission', 38, 'change_citizensubmission'),
(151, 'Can delete citizen submission', 38, 'delete_citizensubmission'),
(152, 'Can view citizen submission', 38, 'view_citizensubmission'),
(153, 'Can add citizen evidence', 39, 'add_citizenevidence'),
(154, 'Can change citizen evidence', 39, 'change_citizenevidence'),
(155, 'Can delete citizen evidence', 39, 'delete_citizenevidence'),
(156, 'Can view citizen evidence', 39, 'view_citizenevidence'),
(157, 'Can add budget', 40, 'add_budget'),
(158, 'Can change budget', 40, 'change_budget'),
(159, 'Can delete budget', 40, 'delete_budget'),
(160, 'Can view budget', 40, 'view_budget'),
(161, 'Can add audit log', 41, 'add_auditlog'),
(162, 'Can change audit log', 41, 'change_auditlog'),
(163, 'Can delete audit log', 41, 'delete_auditlog'),
(164, 'Can view audit log', 41, 'view_auditlog'),
(165, 'Can add activity', 42, 'add_activity'),
(166, 'Can change activity', 42, 'change_activity'),
(167, 'Can delete activity', 42, 'delete_activity'),
(168, 'Can view activity', 42, 'view_activity'),
(169, 'Can add government request', 43, 'add_governmentrequest'),
(170, 'Can change government request', 43, 'change_governmentrequest'),
(171, 'Can delete government request', 43, 'delete_governmentrequest'),
(172, 'Can view government request', 43, 'view_governmentrequest'),
(173, 'Can add new model', 44, 'add_newmodel'),
(174, 'Can change new model', 44, 'change_newmodel'),
(175, 'Can delete new model', 44, 'delete_newmodel'),
(176, 'Can view new model', 44, 'view_newmodel');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(42, 'member', 'activity'),
(7, 'member', 'announcement'),
(41, 'member', 'auditlog'),
(40, 'member', 'budget'),
(39, 'member', 'citizenevidence'),
(38, 'member', 'citizensubmission'),
(37, 'member', 'comment'),
(8, 'member', 'contact'),
(9, 'member', 'contractor'),
(36, 'member', 'contractorrating'),
(10, 'member', 'feedback'),
(43, 'member', 'governmentrequest'),
(35, 'member', 'media'),
(34, 'member', 'milestone'),
(44, 'member', 'newmodel'),
(33, 'member', 'notification'),
(32, 'member', 'participation'),
(31, 'member', 'pdf'),
(30, 'member', 'programfunding'),
(29, 'member', 'programimpact'),
(28, 'member', 'progressreport'),
(27, 'member', 'progressupdate'),
(11, 'member', 'project'),
(24, 'member', 'projectdocument'),
(12, 'member', 'projectexpense'),
(23, 'member', 'projectreport'),
(22, 'member', 'projectrisk'),
(13, 'member', 'projectstage'),
(21, 'member', 'projectupdate'),
(26, 'member', 'project_division'),
(25, 'member', 'project_type'),
(20, 'member', 'reportissue'),
(19, 'member', 'stagereport'),
(18, 'member', 'stakeholder'),
(14, 'member', 'team'),
(15, 'member', 'tender'),
(17, 'member', 'tenderapplication'),
(16, 'member', 'testimonial'),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-04-26 11:08:47.116280'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-04-26 11:08:47.226368'),
(3, 'auth', '0001_initial', '2026-04-26 11:08:47.583345'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-04-26 11:08:47.656046'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-04-26 11:08:47.665929'),
(6, 'auth', '0004_alter_user_username_opts', '2026-04-26 11:08:47.678199'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-04-26 11:08:47.687627'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-04-26 11:08:47.692026'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-04-26 11:08:47.704496'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-04-26 11:08:47.714449'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-04-26 11:08:47.724513'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-04-26 11:08:47.753278'),
(13, 'auth', '0011_update_proxy_permissions', '2026-04-26 11:08:47.761785'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-04-26 11:08:47.770333'),
(15, 'member', '0001_initial', '2026-04-26 11:08:51.704112'),
(19, 'sessions', '0001_initial', '2026-04-26 11:08:51.982623'),
(23, 'member', '0002_rename_user_notification_recipient_and_more', '2026-06-09 08:08:39.463404'),
(24, 'member', '0002_auto_20260609_0351', '2026-06-09 10:52:05.024736'),
(28, 'admin', '0001_initial', '2026-06-10 13:26:49.529549'),
(29, 'admin', '0002_logentry_remove_auto_add', '2026-06-10 13:26:49.581501'),
(30, 'admin', '0003_logentry_add_action_flag_choices', '2026-06-10 13:26:49.638609'),
(31, 'member', '0002_newmodel', '2026-06-11 05:18:12.149265'),
(32, 'member', '0003_alter_contractor_projects', '2026-06-11 05:47:45.172546'),
(33, 'member', '0004_delete_newmodel', '2026-06-11 05:48:05.737046'),
(34, 'member', '0005_delete_comment', '2026-06-11 06:26:37.556565'),
(35, 'member', '0006_alter_contractor_projects_comment', '2026-06-11 06:26:37.800189'),
(36, 'member', '0007_delete_citizensubmission', '2026-06-11 06:44:30.459091'),
(37, 'member', '0008_alter_contractor_projects_citizensubmission', '2026-06-11 06:46:19.129982'),
(38, 'member', '0009_delete_citizenevidence', '2026-06-11 06:53:17.109074'),
(39, 'member', '0010_citizenevidence', '2026-06-11 06:54:09.561831'),
(40, 'member', '0011_delete_comment', '2026-06-11 07:05:14.182734'),
(41, 'member', '0012_comment', '2026-06-11 07:06:21.032229'),
(42, 'member', '0002_delete_governmentrequest', '2026-06-11 07:15:24.138461'),
(43, 'member', '0003_governmentrequest', '2026-06-11 07:16:15.185090'),
(44, 'member', '0004_delete_auditlog', '2026-06-11 07:26:05.622462'),
(45, 'member', '0005_auditlog', '2026-06-11 07:26:36.073182'),
(46, 'member', '0006_alter_auditlog_user', '2026-06-11 07:42:22.546046'),
(47, 'member', '0002_budget', '2026-06-16 06:28:17.103745'),
(48, 'member', '0003_remove_contractorrating_contractor_and_more', '2026-06-16 07:03:29.013601'),
(49, 'member', '0004_contractor_contractorrating_contractor_and_more', '2026-06-16 07:03:29.021251');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('13rc1o2gyneg0mtf4gugknw1yoxa7y5o', '.eJxVjLsOwjAMAP_FM4rywCHpyM43VI7jkgJKpKadEP-OKnWA9e50bxhpW8u4dVnGOcMA1sPpFybip9Td5AfVe1Pc6rrMSe2JOmxXt5bldT3av0GhXmCAIFpHsZgceeNs5IzZWBGL7uxCnAwRo0t60j5qRgmEEiJfDDJh4gSfL_vUOCw:1wHbRO:LGNacgZMl7vjw_49bEdGhZ8Oa5c6e-iojCNxm55ELmU', '2026-05-12 05:57:02.230908'),
('5q6p769hrbhyh7esawk3q9d82v3b68g3', '.eJxVjMsOwiAQAP9lz4aUp2yP3vsNBNitVA0kpT0Z_9006UGvM5N5Q4j7VsLeeQ0LwQgKLr8sxfzkegh6xHpvIre6rUsSRyJO28XUiF-3s_0blNgLjIDJESnLzFKyZVYojUNpaZhTQjc7Y7y23qLiPHhil686Zp1QkTcaI3y-7OE37g:1wH5cP:Qw_bs23tzMx--7FMW7or8ZXZTIVFrmMeCNJRrKxhoCo', '2026-05-10 19:58:17.264025'),
('lj4x0otrlw2jsatfnzyhwaliwp6vaatn', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWVjy:F1Q_e2DpAIoXRbbyq1kwQnBa0A4Zoxpd6oySv3tlmyY', '2026-06-22 08:53:50.029226'),
('ojnovp86l18dr3ghiygi4s7bx2r0wj83', '.eJxVjEEOwiAQAP-yZ0MKZYH26N03kIUFqRpISnsy_t006UGvM5N5g6d9K37vafULwwwSLr8sUHymegh-UL03EVvd1iWIIxGn7eLWOL2uZ_s3KNQLzGApWKmsy8rlacyDSWhGxahJG7ZDnDBozCqhZIvZIikpQ2AdnaZREsLnC84hN3I:1wGxWF:1uXwrAfLoeLh_dUFDU61Qr_uLhtqWslXqp3weNnNdro', '2026-05-10 11:19:23.081924'),
('oteepgwgeknhs5ymdtgp5sccevtdu4dy', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWsFm:dTpaW2sNHwAtoX3Z_VVwxrl-_ulcTZozkYPqg4dWPUs', '2026-06-23 08:56:10.831602'),
('qclz3l0agn7x7cvre48wracmrnz9uw1g', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWvcg:nmDSvfzeoLXxRAE-ovOecU1jEgogjWUx6J0tUvYmyqs', '2026-06-23 12:32:02.873818');

-- --------------------------------------------------------

--
-- Table structure for table `member_announcement`
--

CREATE TABLE `member_announcement` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `level` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_auditlog`
--

CREATE TABLE `member_auditlog` (
  `id` bigint(20) NOT NULL,
  `action` varchar(255) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_budget`
--

CREATE TABLE `member_budget` (
  `id` bigint(20) NOT NULL,
  `allocated_amount` decimal(15,2) NOT NULL,
  `spent_amount` decimal(15,2) NOT NULL,
  `last_updated` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_citizenevidence`
--

CREATE TABLE `member_citizenevidence` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `location` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_citizenevidence`
--

INSERT INTO `member_citizenevidence` (`id`, `title`, `description`, `location`, `image`, `is_verified`, `created_at`, `project_id`, `stage_id`, `user_id`) VALUES
(1, 'fdgn', 'cvdxfg', ' cv', '', 0, '2026-06-11 06:54:43.125873', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `member_citizensubmission`
--

CREATE TABLE `member_citizensubmission` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `category` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_comment`
--

CREATE TABLE `member_comment` (
  `id` bigint(20) NOT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_contact`
--

CREATE TABLE `member_contact` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `message` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_contact`
--

INSERT INTO `member_contact` (`id`, `name`, `email`, `message`) VALUES
(2, 'Toto Lavender', 'wodinga@gmail.com', 'nmbgv'),
(3, 'Victoria Amanda', 'lavender@gmail.com', 'ergyujiopmk'),
(4, 'Toto Vanessah', 'vanessa@gmail.com', 'thanks'),
(5, 'Toto Lavender', 'oketchmichael7@gmail.com', 'vgdfsaz'),
(6, 'Frank Libe', 'libe@gmail.com', 'im frank libe and thanks for the service'),
(7, 'Argwings Kodhek', 'kodhek@gmail.com', 'good work');

-- --------------------------------------------------------

--
-- Table structure for table `member_contractor`
--

CREATE TABLE `member_contractor` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `contractor_id` int(10) NOT NULL,
  `company` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `profile` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_contractorrating`
--

CREATE TABLE `member_contractorrating` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `quality_score` int(11) NOT NULL DEFAULT 0,
  `speed_score` int(11) NOT NULL DEFAULT 0,
  `compliance_score` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_feedback`
--

CREATE TABLE `member_feedback` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `feedback` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_feedback`
--

INSERT INTO `member_feedback` (`id`, `full_name`, `email`, `phone_number`, `feedback`) VALUES
(5, NULL, 'amanda@gmail.com', '798643789', 'Amanda Nyar Usonga penjo'),
(6, NULL, 'young@gmail.com', '798564321', 'thanks for the service');

-- --------------------------------------------------------

--
-- Table structure for table `member_governmentrequest`
--

CREATE TABLE `member_governmentrequest` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `category` varchar(50) NOT NULL,
  `location` varchar(255) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `citizen_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_governmentrequest`
--

INSERT INTO `member_governmentrequest` (`id`, `title`, `description`, `category`, `location`, `image`, `status`, `created_at`, `updated_at`, `citizen_id`) VALUES
(1, 'qewr', 'qwer', 'infrastructure', 'qewr', '', 'pending', '2026-06-11 07:17:01.434909', '2026-06-11 07:17:01.434957', 1);

-- --------------------------------------------------------

--
-- Table structure for table `member_media`
--

CREATE TABLE `member_media` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `media_type` varchar(10) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_media`
--

INSERT INTO `member_media` (`id`, `file`, `media_type`, `uploaded_at`, `project_id`) VALUES
(1, 'project_media/RamogiFM_RamogiFM___Twitter.mp4', 'video', '2025-03-06 12:05:42.502636', NULL),
(2, 'project_media/-5069072835879741643_121.jpg', 'image', '2025-03-06 12:41:04.143274', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_milestone`
--

CREATE TABLE `member_milestone` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `completion_date` date DEFAULT NULL,
  `progress_percentage` int(11) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_milestone`
--

INSERT INTO `member_milestone` (`id`, `title`, `description`, `completion_date`, `progress_percentage`, `project_id`, `stage_id`) VALUES
(1, 'nbnm', 'nmjhmn', '2025-03-12', 87, 35, 1),
(2, 'geothermal power project', 'power station installation', '2026-02-16', 10, 35, 1);

-- --------------------------------------------------------

--
-- Table structure for table `member_notification`
--

CREATE TABLE `member_notification` (
  `id` bigint(20) NOT NULL,
  `notification_type` varchar(30) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `recipient_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_notification`
--

INSERT INTO `member_notification` (`id`, `notification_type`, `title`, `message`, `is_read`, `created_at`, `recipient_id`, `project_id`) VALUES
(1, NULL, NULL, 'Welcome anytime Ajumbutule', 0, '2025-03-06 12:17:36.241868', NULL, NULL),
(2, NULL, NULL, 'wecome', 1, '2025-03-06 12:17:56.611611', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_participation`
--

CREATE TABLE `member_participation` (
  `id` bigint(20) NOT NULL,
  `content` longtext DEFAULT NULL,
  `joined_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_participation`
--

INSERT INTO `member_participation` (`id`, `content`, `joined_at`, `is_active`, `project_id`, `user_id`) VALUES
(1, 'good', '2026-02-23 07:08:43.825185', 1, 38, 27),
(5, 'The project is not clerly showing the milstones, im curious', '2026-02-23 07:38:01.415471', 1, 34, 27),
(6, 'certisfied', '2026-02-23 08:03:52.925874', 1, 37, 25);

-- --------------------------------------------------------

--
-- Table structure for table `member_pdf`
--

CREATE TABLE `member_pdf` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `document` varchar(100) DEFAULT NULL,
  `uploaded_at` datetime(6) DEFAULT NULL,
  `project_title` varchar(255) DEFAULT NULL,
  `project_status` varchar(100) DEFAULT NULL,
  `implementing_agency` varchar(255) DEFAULT NULL,
  `pdf_file` varchar(100) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_pdf`
--

INSERT INTO `member_pdf` (`id`, `title`, `document`, `uploaded_at`, `project_title`, `project_status`, `implementing_agency`, `pdf_file`, `project_id`) VALUES
(1, NULL, NULL, '2025-03-06 07:22:37.888189', 'blas', NULL, 'iokl', NULL, NULL),
(2, NULL, NULL, '2025-03-06 07:22:37.888189', 'Express way', 'completed', 'national government', 'pdfs/expressway.jpg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_programfunding`
--

CREATE TABLE `member_programfunding` (
  `id` bigint(20) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `funding_source` varchar(255) NOT NULL,
  `date_funded` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_programimpact`
--

CREATE TABLE `member_programimpact` (
  `id` bigint(20) NOT NULL,
  `metric_name` varchar(255) NOT NULL,
  `metric_value` double NOT NULL,
  `measurement_date` date NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_progressreport`
--

CREATE TABLE `member_progressreport` (
  `id` bigint(20) NOT NULL,
  `description` longtext NOT NULL,
  `report_title` varchar(255) NOT NULL,
  `report_file` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_progressupdate`
--

CREATE TABLE `member_progressupdate` (
  `id` bigint(20) NOT NULL,
  `description` longtext NOT NULL,
  `date_reported` datetime(6) NOT NULL,
  `progress_percentage` int(11) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_project`
--

CREATE TABLE `member_project` (
  `id` bigint(20) NOT NULL,
  `project_title` varchar(100) DEFAULT NULL,
  `project_description` longtext DEFAULT NULL,
  `project_location` varchar(100) DEFAULT NULL,
  `implementing_agency` varchar(100) DEFAULT NULL,
  `project_Budgeting` decimal(12,2) DEFAULT NULL,
  `amount_spent` decimal(12,2) DEFAULT NULL,
  `images` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `beneficiaries` longtext DEFAULT NULL,
  `stakeholders` longtext DEFAULT NULL,
  `progress` longtext DEFAULT NULL,
  `project_status` varchar(10) NOT NULL,
  `impact` longtext DEFAULT NULL,
  `project_manager` varchar(100) DEFAULT NULL,
  `project_contractor` varchar(100) DEFAULT NULL,
  `contact_email` varchar(254) DEFAULT NULL,
  `progress_update` datetime(6) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_project`
--

INSERT INTO `member_project` (`id`, `project_title`, `project_description`, `project_location`, `implementing_agency`, `project_Budgeting`, `amount_spent`, `images`, `start_date`, `end_date`, `beneficiaries`, `stakeholders`, `progress`, `project_status`, `impact`, `project_manager`, `project_contractor`, `contact_email`, `progress_update`, `remarks`) VALUES
(1, 'Kisumu Highway', 'A perfect highway joining most counties promoting business opportunities', 'Kisumu', 'Governmental Agencies', '23000000.00', NULL, 'projects/dlock.jpg', '2026-04-22', '2026-06-11', 'citizens', 'agencies', '67', 'ongoing', 'good economic network', NULL, 'George Mbola', 'felixngwono@gmail.com', '2026-04-26 11:25:50.760102', '- fostering good economy'),
(11, 'Thika super highway', 'Repair and maintanance of Thika super highway', 'Thika', 'KeNHA', '9999999999.99', NULL, 'projects/thika.jpg', '2024-03-01', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Kisumu Port', 'Project extension of L.Victoria port has reached its completion stage.', 'Kisumu', 'National government', '147345646.00', NULL, 'projects/login.PNG', '2024-03-02', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'tree plantation farming', 'tree plantatiion farming in Nakuru county', 'kampi ya moto- Nakuru', 'National government', '34567890.00', NULL, 'projects/mau_mau.jpg', '2024-03-06', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'Menengai II Geothermal Power Station', 'Will be done along Menengai to boost power supply in Nakuru city', 'Menengai Crater, Nakuru County', 'national Government and the NGO\'s', '10000000.00', NULL, 'projects/im.jpg', '2025-12-06', '2027-12-06', NULL, NULL, NULL, 'upcoming', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'Street development in Dandora, Nairobi', 'The project in Dandora focuses on the implementation of a ‘model street’ in a low income neighbourhood in Nairobi. Previously a well-planned neighborhood, Dandora has gradually degenerated to almost slum status. The implementation site, a street in Dandora, was selected as it is an essential part of the ‘Must Seed’ strategy, a step by step process of making small interventions that have large impact in the community.', 'Dandora-Nairobi', 'Placemakers, KUWA, Dandora Transformation League (DTL)', '1654879.00', NULL, 'projects/dandora_9E3A1mg.jpg', '2024-03-07', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'Building of a Dam', 'Dam Description', 'Kisumu', 'National Government', '30000000.00', NULL, 'projects/pacho_7f3AtUZ.jpg', '2024-03-12', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(27, 'express way', 'Completion of expressway along Haile Sellasie avenue', 'Nairobi', 'National government', '34500000.00', NULL, 'projects/expressway_SwK9e6V.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'Irrigation Farming', 'The government is yet to initiate irrigation farming along the seven Folks dams of R.Tana', 'Mount Kenya region', 'National government', '4579867.00', NULL, 'projects/tana_river.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Kisumu Highway', 'Kisumu started as a small town called Kisuma. Grey due to the greate snaking metal rod of Jorochere', 'Kisumu', 'Nyong\'o government', '25895642.00', NULL, 'projects/dala.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'Northlands City', 'The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'Ruiru, Nairobi city', 'Governmental Agencies', '23000000.00', NULL, 'projects/thika_Ua6mF2X.jpg', '2024-03-12', '2024-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'Standard Gauge Railway', 'Construction of the Mombasa-Malaba standard gauge railway was launched by President Uhuru Kenyatta on November 28, 2013.\r\n\r\nPhase one of the project – from Mombasa to Nairobi was completed in 2017.', 'Mombasa', 'Mombasa county government', '34000000.00', NULL, 'projects/sgr.png', '2024-03-12', '2024-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(33, 'Mau Mau Road', 'Construction of a 540km road that seeks to honour the role of Mau Mau freedom fighters in the liberation of Kenya from colonialists is underway, offering three central Kenya counties a new artery into Nairobi.\r\n\r\nChristened Mau Mau Road, the highway starts at Gataka in Limuru, and then passes through Kamahindu and Kibichoi in Kiambu before negotiating its way through Kinyona in Kigumo and Ichichi in Murang’a.', 'Limuru, Nairobi', 'National government', '2121000000.00', NULL, 'projects/expressway.jpg', '2024-03-12', '2027-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 'Menengai II Geothermal Power Station', 'A 35 MW geothermal power plant under construction in the Menengai Crater, aimed at harnessing geothermal energy to boost Kenya\'s electricity supply.', 'Menengai Crater, Nakuru County', 'High; expected to be commissioned in 2025 to meet growing energy demands.', '20000000.00', NULL, 'projects/Architecture-Portfolio-Cover-1024x683.webp', '2025-02-19', '2025-03-06', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL),
(35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 'Expansion of Tana River', 'Due to frequent blockages of the river banks, the government  considered its improval', 'Tana River Machakos County', 'National government', '9999999999.99', NULL, 'projects/tana_river_Laq2K1W.jpg', '2024-03-07', '2025-03-12', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 'Nairobi Railway City', 'After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.', 'Nairobi', 'National government', '0.00', NULL, 'projects/sgr_saMexVe.png', '2025-03-13', '2028-02-12', 'Railway users', 'multi billionares', 'upcoming', 'upcoming', 'speeding the rate of transportation and reducing the trafficking in public roads', NULL, 'George Mbola', 'info@lapsset.go.ke', '2026-06-10 13:48:50.457266', 'poornproject management'),
(38, 'Affordable Housing', 'the government is set to build upto 10 floor affordable house to help common mwananchi access the basic needs', 'Mercy Njeri-Nakuru', 'National Government', '0.00', NULL, 'projects/house.jpg', '2026-02-27', '2031-05-16', '-common mwananchi\r\n- government', '-Government tycoons\r\n- president William Ruto', '', 'Delayed', 'reduction of overcrowding in the country', NULL, 'George Mbola', 'felixngwono@gmail.com', '0000-00-00 00:00:00.000000', '-this will impact on the reduction of slums in the country\r\n-clean environment'),
(39, 'Infrastructure and Energy', 'Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.', 'Siaya County', 'County Government', '0.00', NULL, 'projects/house_wMsNgUd.jpg', '2024-06-04', '2026-02-21', 'citizens', 'county government', '', 'completed', '- Ease of access of clean and free energy', NULL, 'George Mbola', 'felixngwono@gmail.com', '0000-00-00 00:00:00.000000', 'free and favourable energy');

-- --------------------------------------------------------

--
-- Table structure for table `member_projectdocument`
--

CREATE TABLE `member_projectdocument` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectexpense`
--

CREATE TABLE `member_projectexpense` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectreport`
--

CREATE TABLE `member_projectreport` (
  `id` bigint(20) NOT NULL,
  `report_file` varchar(100) NOT NULL,
  `report_date` datetime(6) NOT NULL,
  `report_title` varchar(255) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectrisk`
--

CREATE TABLE `member_projectrisk` (
  `id` bigint(20) NOT NULL,
  `risk_description` longtext DEFAULT NULL,
  `risk_level` varchar(20) NOT NULL,
  `mitigation_plan` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectstage`
--

CREATE TABLE `member_projectstage` (
  `id` bigint(20) NOT NULL,
  `stage_name` varchar(20) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `progress_percentage` decimal(5,2) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_projectstage`
--

INSERT INTO `member_projectstage` (`id`, `stage_name`, `description`, `start_date`, `end_date`, `progress_percentage`, `project_id`) VALUES
(1, 'construction', 'nghfdtygh', '2024-03-12', '2024-03-09', '60.00', 30);

-- --------------------------------------------------------

--
-- Table structure for table `member_projectupdate`
--

CREATE TABLE `member_projectupdate` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_project_division`
--

CREATE TABLE `member_project_division` (
  `id` bigint(20) NOT NULL,
  `project_name` varchar(1000) NOT NULL,
  `project_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_project_division`
--

INSERT INTO `member_project_division` (`id`, `project_name`, `project_type_id`) VALUES
(1, 'Ground Breaking', NULL),
(2, 'Tile Fittings', NULL),
(3, 'Land clearence', NULL),
(4, 'Initiation stage', NULL),
(5, 'Ground Breaking', NULL),
(7, 'nile irrigation', 29);

-- --------------------------------------------------------

--
-- Table structure for table `member_project_division_project_name`
--

CREATE TABLE `member_project_division_project_name` (
  `id` bigint(20) NOT NULL,
  `project_division_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_project_type`
--

CREATE TABLE `member_project_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_project_type`
--

INSERT INTO `member_project_type` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `created_by_id`) VALUES
(1, 'Highways', '', 0, NULL, NULL, NULL),
(2, 'Building/construction', '', 0, NULL, NULL, NULL),
(3, 'Traditional projects', '', 0, NULL, NULL, NULL),
(4, 'Agile Projects', '', 0, NULL, NULL, NULL),
(5, 'Agency Projects', '', 0, NULL, NULL, NULL),
(6, 'Remote Projects', '', 0, NULL, NULL, NULL),
(7, 'research project', '', 0, NULL, NULL, NULL),
(19, 'Agency Projects', '', 0, NULL, NULL, NULL),
(23, 'environmental factors', '', 0, NULL, NULL, NULL),
(27, 'environmental factors', '', 0, NULL, NULL, NULL),
(28, 'ongoing', '', 0, NULL, NULL, NULL),
(29, 'Farming', '', 0, NULL, NULL, NULL),
(30, 'music', '', 0, NULL, NULL, NULL),
(32, 'Agile Projects', '', 0, NULL, NULL, NULL),
(35, 'Traditional projects', '', 0, NULL, NULL, NULL),
(40, 'Building/construction', '', 0, NULL, NULL, NULL),
(67, 'music', '', 0, NULL, NULL, NULL),
(76, 'Farming', '', 0, NULL, NULL, NULL),
(77, 'research project', '', 0, NULL, NULL, NULL),
(89, 'ongoing', '', 0, NULL, NULL, NULL),
(90, 'Highways', '', 0, NULL, NULL, NULL),
(98, 'Remote Projects', '', 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_project_type_project_types`
--

CREATE TABLE `member_project_type_project_types` (
  `id` bigint(20) NOT NULL,
  `project_type_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_reportissue`
--

CREATE TABLE `member_reportissue` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `issue_description` longtext NOT NULL,
  `evidence` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `resolved` tinyint(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_reportissue`
--

INSERT INTO `member_reportissue` (`id`, `title`, `issue_description`, `evidence`, `created_at`, `resolved`, `status`, `project_id`, `user_id`) VALUES
(2, 'jytre', 'jghfdsfghj', 'issue_evidence/house.jpg', '2025-03-11 14:06:32.155449', 0, 'Pending', 24, 21),
(3, 'wqedf', 'asdfg', 'issue_evidence/sgr.png', '2025-03-11 14:37:45.210463', 1, 'Resolved', 31, 22);

-- --------------------------------------------------------

--
-- Table structure for table `member_stagereport`
--

CREATE TABLE `member_stagereport` (
  `id` bigint(20) NOT NULL,
  `description` longtext NOT NULL,
  `progress_percentage` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_stakeholder`
--

CREATE TABLE `member_stakeholder` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_details` longtext NOT NULL,
  `role_in_program` longtext NOT NULL,
  `program_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_team`
--

CREATE TABLE `member_team` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `facebook` varchar(200) DEFAULT NULL,
  `instagram` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `linkedin` varchar(200) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_team`
--

INSERT INTO `member_team` (`id`, `name`, `role`, `image`, `created_at`, `description`, `facebook`, `instagram`, `twitter`, `linkedin`, `whatsapp`) VALUES
(1, 'Shanty Page', 'web designer', 'team/dandora_9E3A1mg.jpg', '2026-02-15 12:31:29.817313', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Felix Odhiambo', 'Project Analyst', 'team/login.PNG', '2026-02-16 07:39:45.848005', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_tender`
--

CREATE TABLE `member_tender` (
  `id` bigint(20) NOT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `procurement_method` varchar(20) NOT NULL,
  `estimated_budget` decimal(15,2) DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `eligibility_criteria` longtext DEFAULT NULL,
  `evaluation_criteria` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `document` varchar(100) DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_tender`
--

INSERT INTO `member_tender` (`id`, `reference_number`, `description`, `procurement_method`, `estimated_budget`, `opening_date`, `closing_date`, `eligibility_criteria`, `evaluation_criteria`, `status`, `document`, `is_published`, `created_at`, `created_by_id`, `project_id`) VALUES
(1, 'Ref123we', 'Affordable housing around Manyatta Gonda', 'restricted', '56789765.00', '2026-04-22', '2029-06-28', 'edfghjkl', 'hsaertfg', 'draft', 'tenders/dlock.jpg', 0, '2026-04-28 05:41:12.276887', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_tenderapplication`
--

CREATE TABLE `member_tenderapplication` (
  `id` bigint(20) NOT NULL,
  `company_name` varchar(200) DEFAULT NULL,
  `company_email` varchar(254) DEFAULT NULL,
  `company_phone` varchar(20) DEFAULT NULL,
  `proposal_document` varchar(100) DEFAULT NULL,
  `bid_amount` decimal(15,2) DEFAULT NULL,
  `cover_letter` varchar(100) DEFAULT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `status` varchar(20) NOT NULL,
  `applicant_id` bigint(20) DEFAULT NULL,
  `tender_id` bigint(20) NOT NULL,
  `technical_score` float NOT NULL DEFAULT 0,
  `financial_score` float NOT NULL DEFAULT 0,
  `total_score` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_testimonial`
--

CREATE TABLE `member_testimonial` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_testimonial`
--

INSERT INTO `member_testimonial` (`id`, `name`, `content`, `phone_number`, `image`, `created_at`, `project_id`, `user_id`) VALUES
(1, 'Nicole Atieno', 'my mentor my role model', NULL, 'testimonials/02c92d479a634167955278c0bef5d671.jpg', '2026-04-26 11:27:07.890437', 1, NULL),
(2, 'Shanty Page', 'since the launching of this platform, im able to track on the farming processes in Perkerra', NULL, 'testimonials/Fel16.jpg', '2026-02-15 08:33:41.000000', 28, NULL),
(3, 'Angela Valdes', 'im happy with this project, the phases are clearly shown. Thanks Project Manager, programmer and designer', NULL, 'testimonials/Fel14.jpg', '2026-02-15 09:00:48.000000', 24, NULL),
(4, 'Betty Amanda', 'Amanda Mor', NULL, 'testimonials/logo.png', '2026-02-15 09:11:41.000000', 31, NULL),
(5, 'Nicole Atieno', '“This is a good platform where citizens can track government oversight.”', NULL, 'testimonials/solar.jpg', '2026-02-15 07:44:44.000000', 12, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_user`
--

CREATE TABLE `member_user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `bio` longtext DEFAULT NULL,
  `is_enduser` tinyint(1) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `profile` varchar(100) DEFAULT NULL,
  `updated` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_user`
--

INSERT INTO `member_user` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`, `username`, `name`, `role`, `bio`, `is_enduser`, `avatar`, `profile`, `updated`) VALUES
(1, 'pbkdf2_sha256$600000$eK4cX1QJxbLYev4itN2MFq$F0E87XnzWK5poO68PKyJ64MWukjctSF4HWmx4aML8yE=', '2026-06-09 12:32:02.866866', 1, '', '', 1, 1, '2026-04-26 11:11:12.503469', 'felixngwono@gmail.com', 'FelloMarley', 'Felix Odhiambo', 'developer', 'I\'m FelloMarley, the mastermind behind the government tracker website', 0, 'avatar.png', 'profiles/Fel14_9bkNTiv.jpg', '2026-04-26 11:19:11.324442'),
(2, 'pbkdf2_sha256$390000$TDORiaVNPtEXR4OUPLDiTC$LwK7MIK1UWZ52hhBoZcJ3fER0UWBAZ6bbpIYJ1fhfVE=', '2026-04-26 19:58:17.256715', 0, '', '', 0, 1, '2026-04-26 19:50:51.247921', 'nicole@gmail.com', 'Atieno NyarChula', 'Nicole Atieno', 'engineer', 'Im Nyachula, born to be a winner', 0, 'avatar.png', 'profiles/02c92d479a634167955278c0bef5d671_R0mYTV3.jpg', '2026-04-26 19:50:52.868190'),
(15, 'pbkdf2_sha256$600000$sdZXg14tgnO7xa9BZMRudV$15CmOFaWIpD5svoHyNtsQKA70oqKwIhFRoihCTrZTBo=', '2024-11-13 10:44:07.903587', 0, '', '', 0, 1, '2024-03-17 08:35:44.262524', 'omondi@gmail.com', 'Ajumbutule', 'Frank Omondi', 'citizen', 'Im Ajumbutule', 1, 'avatar.png', 'images/3006.webp', '2026-02-22 13:21:42.485592'),
(21, 'pbkdf2_sha256$390000$L3rjadbchaO0SpN9HBxF3S$7IwkCJCvSjH+A153Y3J+8W2hT03K8drd0wkQGjzV7iI=', '2026-02-15 09:24:48.995603', 1, '', '', 0, 1, '2024-03-18 21:04:19.576787', 'fellomarley@gmail.com', 'Fello', 'Felix Odhiambo', 'citizen', 'Im Marley', 0, 'avatar.png', 'images/chief_J9TcRuW.jpg', '2026-02-22 13:21:42.485592'),
(22, 'felixodhiambo@kabarak.ac.ke', NULL, 1, '', '', 1, 0, '2024-03-07 12:52:01.000000', NULL, 'StoryTeller', 'Felix Odhiambo', 'citizen', 'im Marley', 0, '10', 'avartor.jpg', '2026-02-22 13:21:42.485592'),
(23, 'pbkdf2_sha256$390000$WQOqv9km54x7scaodebVCd$HYGL9+bFmqvTtlw+RAE5YgIwulygM1B9Egut5CAJry0=', '2026-02-23 08:19:46.449107', 0, '', '', 0, 1, '2024-03-20 19:38:48.673003', 'vanessa@gmail.com', 'Vanessah', 'Toto Vanessah', 'citizen', 'Im Vanessah. The only Titan from the lake in the family of akina Fellix The StoryTeller', 1, 'avatar.png', 'profiles/tree.jpg', '2026-02-22 13:21:42.485592'),
(25, 'pbkdf2_sha256$390000$QCtLfFIyYQvtD9z4whkpmK$QSWeErI3jRNzVRw1BnuRCRDR23Sy3FCsF5Z74v2OLXo=', '2026-02-23 09:07:24.976027', 0, '', '', 0, 1, '2025-03-12 10:02:37.372369', 'assielo@gmail.com', 'assiello', 'Assiello Nomar', 'citizen', 'Assiello Norma', 1, 'avatar.png', 'profiles/solar.jpg', '2026-02-22 13:21:42.485592'),
(26, 'pbkdf2_sha256$390000$rvjkDxGKNzDBpOphsu5Rss$fBQTcWntdNp131fgkCqBTyd69P8/xm3kYdLvNG81S1Y=', '2026-04-28 05:57:02.225708', 0, '', '', 0, 1, '2026-02-15 09:22:02.825205', 'betty@gmail.com', 'Amanda', 'Betty Amanda', 'developer', 'im betty amanda', 0, 'avatar.png', 'profiles/038e478f9c094c01be86505e030c974d_DC7y9U9.jpg', '2026-02-22 13:21:42.485592'),
(27, 'pbkdf2_sha256$390000$ru4QbghiyfWrnOcUrlggSw$NhAXp11ikeE42Z4rNPpaCIlqUSLiYtRUevcWroYH/gU=', '2026-02-23 09:13:17.518974', 1, '', '', 1, 1, '2026-02-16 13:56:00.197953', 'felix@gmail.com', 'Odinga', 'Felix Odhiambo', 'developer', 'im felix odhiamo', 0, 'avatar.png', 'profiles/Fel14.jpg', '2026-02-22 13:21:42.485592'),
(29, 'pbkdf2_sha256$600000$BavP8B0es7pFn9ME210i3X$Xr3WxFnouS6cGR9C/AuHZbcAVlK6bncoXJ7WnfEhH9M=', '2026-06-08 08:29:15.187052', 1, '', '', 1, 1, '2026-06-08 08:28:37.288152', 'felix7@gmail.com', 'FelloMarley7', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-06-08 08:28:38.384166');

-- --------------------------------------------------------

--
-- Table structure for table `member_user_groups`
--

CREATE TABLE `member_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_user_user_permissions`
--

CREATE TABLE `member_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indexes for table `member_announcement`
--
ALTER TABLE `member_announcement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_auditlog`
--
ALTER TABLE `member_auditlog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_auditlog_project_id_7c6b0297_fk_member_project_id` (`project_id`),
  ADD KEY `member_auditlog_user_id_dc4bd04f_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_budget`
--
ALTER TABLE `member_budget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_budget_project_id_b627c00d_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_citizenevidence`
--
ALTER TABLE `member_citizenevidence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_citizenevidence_project_id_113de4c6_fk_member_project_id` (`project_id`),
  ADD KEY `member_citizeneviden_stage_id_4239d11e_fk_member_pr` (`stage_id`),
  ADD KEY `member_citizenevidence_user_id_afa2e230_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_citizensubmission`
--
ALTER TABLE `member_citizensubmission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_citizensubmission_user_id_abd57c8e_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_comment`
--
ALTER TABLE `member_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_comment_project_id_3fa8114d_fk_member_project_id` (`project_id`),
  ADD KEY `member_comment_user_id_51d0677f_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_contact`
--
ALTER TABLE `member_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_contractor`
--
ALTER TABLE `member_contractor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contractor_rating_project` (`project_id`);

--
-- Indexes for table `member_feedback`
--
ALTER TABLE `member_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_governmentrequest`
--
ALTER TABLE `member_governmentrequest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_governmentrequest_citizen_id_0e8ec8f8_fk_member_user_id` (`citizen_id`);

--
-- Indexes for table `member_media`
--
ALTER TABLE `member_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_media_project_id_b91ac4bd_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_milestone`
--
ALTER TABLE `member_milestone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_milestone_project_id_d936f2d8_fk_member_project_id` (`project_id`),
  ADD KEY `member_milestone_stage_id_25e95054_fk_member_projectstage_id` (`stage_id`);

--
-- Indexes for table `member_notification`
--
ALTER TABLE `member_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_notification_user_id_fc0e3f26_fk_member_user_id` (`recipient_id`),
  ADD KEY `member_notification_project_id_c3be49b0_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_participation`
--
ALTER TABLE `member_participation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_participation_project_id_654a0392_fk_member_project_id` (`project_id`),
  ADD KEY `member_participation_user_id_87e6bb26_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_pdf`
--
ALTER TABLE `member_pdf`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_pdf_project_id_3ae9bb6f_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_programfunding`
--
ALTER TABLE `member_programfunding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_programfunding_project_id_0c234922_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_programimpact`
--
ALTER TABLE `member_programimpact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_programimpact_project_id_233982f5_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_progressreport`
--
ALTER TABLE `member_progressreport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_progressreport_project_id_9c0c419e_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_progressupdate`
--
ALTER TABLE `member_progressupdate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_progressupdate_project_id_881833b1_fk_member_project_id` (`project_id`),
  ADD KEY `member_progressupdat_stage_id_f25b3d0b_fk_member_pr` (`stage_id`);

--
-- Indexes for table `member_project`
--
ALTER TABLE `member_project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectdocument_project_id_5926d0a7_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_projectexpense`
--
ALTER TABLE `member_projectexpense`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_projectreport`
--
ALTER TABLE `member_projectreport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectreport_project_id_bad07590_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_projectrisk`
--
ALTER TABLE `member_projectrisk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectrisk_project_id_7970b704_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectstage_project_id_cb598c4c_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_projectupdate`
--
ALTER TABLE `member_projectupdate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectupdate_project_id_acfbfe5f_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_project_divis_project_type_id_68de0c34_fk_member_pr` (`project_type_id`);

--
-- Indexes for table `member_project_division_project_name`
--
ALTER TABLE `member_project_division_project_name`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_project_division__project_division_id_proj_a1bb18a0_uniq` (`project_division_id`,`project_id`),
  ADD KEY `member_project_divis_project_id_f42ddc82_fk_member_pr` (`project_id`);

--
-- Indexes for table `member_project_type`
--
ALTER TABLE `member_project_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_project_type_created_by_id_4778b93e_fk_member_user_id` (`created_by_id`);

--
-- Indexes for table `member_project_type_project_types`
--
ALTER TABLE `member_project_type_project_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_project_type_proj_project_type_id_project__1f3749b1_uniq` (`project_type_id`,`project_id`),
  ADD KEY `member_project_type__project_id_e539db4a_fk_member_pr` (`project_id`);

--
-- Indexes for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_reportissue_project_id_f4f92cf2_fk_member_project_id` (`project_id`),
  ADD KEY `member_reportissue_user_id_8428b576_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_stagereport`
--
ALTER TABLE `member_stagereport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stagereport_project_id_2f86d019_fk_member_project_id` (`project_id`),
  ADD KEY `member_stagereport_stage_id_d929cb5b_fk_member_projectstage_id` (`stage_id`);

--
-- Indexes for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stakeholder_program_id_5aef0ac3_fk_member_project_id` (`program_id`);

--
-- Indexes for table `member_team`
--
ALTER TABLE `member_team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_tender`
--
ALTER TABLE `member_tender`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_number` (`reference_number`),
  ADD KEY `member_tender_created_by_id_e96f1036_fk_member_user_id` (`created_by_id`),
  ADD KEY `member_tender_project_id_eec6df9c_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_tenderapplication`
--
ALTER TABLE `member_tenderapplication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_tenderapplication_applicant_id_3915db1a_fk_member_user_id` (`applicant_id`),
  ADD KEY `member_tenderapplication_tender_id_b6b30ec7_fk_member_tender_id` (`tender_id`);

--
-- Indexes for table `member_testimonial`
--
ALTER TABLE `member_testimonial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_testimonial_project_id_92842831_fk_member_project_id` (`project_id`),
  ADD KEY `member_testimonial_user_id_65fb1b25_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_user`
--
ALTER TABLE `member_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `member_announcement`
--
ALTER TABLE `member_announcement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_auditlog`
--
ALTER TABLE `member_auditlog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_budget`
--
ALTER TABLE `member_budget`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_citizenevidence`
--
ALTER TABLE `member_citizenevidence`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_citizensubmission`
--
ALTER TABLE `member_citizensubmission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_comment`
--
ALTER TABLE `member_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_contact`
--
ALTER TABLE `member_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_contractor`
--
ALTER TABLE `member_contractor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_feedback`
--
ALTER TABLE `member_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_governmentrequest`
--
ALTER TABLE `member_governmentrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_media`
--
ALTER TABLE `member_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_milestone`
--
ALTER TABLE `member_milestone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_notification`
--
ALTER TABLE `member_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_participation`
--
ALTER TABLE `member_participation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_pdf`
--
ALTER TABLE `member_pdf`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_programfunding`
--
ALTER TABLE `member_programfunding`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_programimpact`
--
ALTER TABLE `member_programimpact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_progressreport`
--
ALTER TABLE `member_progressreport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_progressupdate`
--
ALTER TABLE `member_progressupdate`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_project`
--
ALTER TABLE `member_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectexpense`
--
ALTER TABLE `member_projectexpense`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectreport`
--
ALTER TABLE `member_projectreport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectrisk`
--
ALTER TABLE `member_projectrisk`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_projectupdate`
--
ALTER TABLE `member_projectupdate`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_project_division`
--
ALTER TABLE `member_project_division`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_project_division_project_name`
--
ALTER TABLE `member_project_division_project_name`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_project_type`
--
ALTER TABLE `member_project_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `member_project_type_project_types`
--
ALTER TABLE `member_project_type_project_types`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_stagereport`
--
ALTER TABLE `member_stagereport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_team`
--
ALTER TABLE `member_team`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_tender`
--
ALTER TABLE `member_tender`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_tenderapplication`
--
ALTER TABLE `member_tenderapplication`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_testimonial`
--
ALTER TABLE `member_testimonial`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `member_user`
--
ALTER TABLE `member_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

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
-- Constraints for table `member_auditlog`
--
ALTER TABLE `member_auditlog`
  ADD CONSTRAINT `member_auditlog_project_id_7c6b0297_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_auditlog_user_id_dc4bd04f_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_budget`
--
ALTER TABLE `member_budget`
  ADD CONSTRAINT `member_budget_project_id_b627c00d_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_citizenevidence`
--
ALTER TABLE `member_citizenevidence`
  ADD CONSTRAINT `member_citizeneviden_stage_id_4239d11e_fk_member_pr` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`),
  ADD CONSTRAINT `member_citizenevidence_project_id_113de4c6_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_citizenevidence_user_id_afa2e230_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_citizensubmission`
--
ALTER TABLE `member_citizensubmission`
  ADD CONSTRAINT `member_citizensubmission_user_id_abd57c8e_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_comment`
--
ALTER TABLE `member_comment`
  ADD CONSTRAINT `member_comment_project_id_3fa8114d_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_comment_user_id_51d0677f_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  ADD CONSTRAINT `fk_contractor_rating_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `member_governmentrequest`
--
ALTER TABLE `member_governmentrequest`
  ADD CONSTRAINT `member_governmentrequest_citizen_id_0e8ec8f8_fk_member_user_id` FOREIGN KEY (`citizen_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_media`
--
ALTER TABLE `member_media`
  ADD CONSTRAINT `member_media_project_id_b91ac4bd_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_milestone`
--
ALTER TABLE `member_milestone`
  ADD CONSTRAINT `member_milestone_project_id_d936f2d8_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_milestone_stage_id_25e95054_fk_member_projectstage_id` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`);

--
-- Constraints for table `member_notification`
--
ALTER TABLE `member_notification`
  ADD CONSTRAINT `member_notification_project_id_c3be49b0_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_notification_recipient_id_6a3177d9_fk_member_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_participation`
--
ALTER TABLE `member_participation`
  ADD CONSTRAINT `member_participation_project_id_654a0392_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_participation_user_id_87e6bb26_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_pdf`
--
ALTER TABLE `member_pdf`
  ADD CONSTRAINT `member_pdf_project_id_3ae9bb6f_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_programfunding`
--
ALTER TABLE `member_programfunding`
  ADD CONSTRAINT `member_programfunding_project_id_0c234922_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_programimpact`
--
ALTER TABLE `member_programimpact`
  ADD CONSTRAINT `member_programimpact_project_id_233982f5_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_progressreport`
--
ALTER TABLE `member_progressreport`
  ADD CONSTRAINT `member_progressreport_project_id_9c0c419e_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_progressupdate`
--
ALTER TABLE `member_progressupdate`
  ADD CONSTRAINT `member_progressupdat_stage_id_f25b3d0b_fk_member_pr` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`),
  ADD CONSTRAINT `member_progressupdate_project_id_881833b1_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  ADD CONSTRAINT `member_projectdocument_project_id_5926d0a7_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectreport`
--
ALTER TABLE `member_projectreport`
  ADD CONSTRAINT `member_projectreport_project_id_bad07590_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectrisk`
--
ALTER TABLE `member_projectrisk`
  ADD CONSTRAINT `member_projectrisk_project_id_7970b704_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  ADD CONSTRAINT `member_projectstage_project_id_cb598c4c_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectupdate`
--
ALTER TABLE `member_projectupdate`
  ADD CONSTRAINT `member_projectupdate_project_id_acfbfe5f_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD CONSTRAINT `member_project_divis_project_type_id_68de0c34_fk_member_pr` FOREIGN KEY (`project_type_id`) REFERENCES `member_project_type` (`id`);

--
-- Constraints for table `member_project_division_project_name`
--
ALTER TABLE `member_project_division_project_name`
  ADD CONSTRAINT `member_project_divis_project_division_id_bc956edc_fk_member_pr` FOREIGN KEY (`project_division_id`) REFERENCES `member_project_division` (`id`),
  ADD CONSTRAINT `member_project_divis_project_id_f42ddc82_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_project_type`
--
ALTER TABLE `member_project_type`
  ADD CONSTRAINT `member_project_type_created_by_id_4778b93e_fk_member_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_project_type_project_types`
--
ALTER TABLE `member_project_type_project_types`
  ADD CONSTRAINT `member_project_type__project_id_e539db4a_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_project_type__project_type_id_4abcf524_fk_member_pr` FOREIGN KEY (`project_type_id`) REFERENCES `member_project_type` (`id`);

--
-- Constraints for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  ADD CONSTRAINT `member_reportissue_project_id_f4f92cf2_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_reportissue_user_id_8428b576_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_stagereport`
--
ALTER TABLE `member_stagereport`
  ADD CONSTRAINT `member_stagereport_project_id_2f86d019_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_stagereport_stage_id_d929cb5b_fk_member_projectstage_id` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`);

--
-- Constraints for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  ADD CONSTRAINT `member_stakeholder_program_id_5aef0ac3_fk_member_project_id` FOREIGN KEY (`program_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_tender`
--
ALTER TABLE `member_tender`
  ADD CONSTRAINT `member_tender_created_by_id_e96f1036_fk_member_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_tender_project_id_eec6df9c_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_tenderapplication`
--
ALTER TABLE `member_tenderapplication`
  ADD CONSTRAINT `member_tenderapplication_applicant_id_3915db1a_fk_member_user_id` FOREIGN KEY (`applicant_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_tenderapplication_tender_id_b6b30ec7_fk_member_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `member_tender` (`id`);

--
-- Constraints for table `member_testimonial`
--
ALTER TABLE `member_testimonial`
  ADD CONSTRAINT `member_testimonial_project_id_92842831_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_testimonial_user_id_65fb1b25_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

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
