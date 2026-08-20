-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2026 at 08:16 PM
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
(176, 'Can view new model', 44, 'view_newmodel'),
(177, 'Can add ai issue assessment', 45, 'add_aiissueassessment'),
(178, 'Can change ai issue assessment', 45, 'change_aiissueassessment'),
(179, 'Can delete ai issue assessment', 45, 'delete_aiissueassessment'),
(180, 'Can view ai issue assessment', 45, 'view_aiissueassessment'),
(181, 'Can add ai chat session', 46, 'add_aichatsession'),
(182, 'Can change ai chat session', 46, 'change_aichatsession'),
(183, 'Can delete ai chat session', 46, 'delete_aichatsession'),
(184, 'Can view ai chat session', 46, 'view_aichatsession'),
(185, 'Can add ai chat message', 47, 'add_aichatmessage'),
(186, 'Can change ai chat message', 47, 'change_aichatmessage'),
(187, 'Can delete ai chat message', 47, 'delete_aichatmessage'),
(188, 'Can view ai chat message', 47, 'view_aichatmessage'),
(189, 'Can add district', 48, 'add_district'),
(190, 'Can change district', 48, 'change_district'),
(191, 'Can delete district', 48, 'delete_district'),
(192, 'Can view district', 48, 'view_district'),
(193, 'Can add project category', 49, 'add_projectcategory'),
(194, 'Can change project category', 49, 'change_projectcategory'),
(195, 'Can delete project category', 49, 'delete_projectcategory'),
(196, 'Can view project category', 49, 'view_projectcategory'),
(197, 'Can add region', 50, 'add_region'),
(198, 'Can change region', 50, 'change_region'),
(199, 'Can delete region', 50, 'delete_region'),
(200, 'Can view region', 50, 'view_region'),
(201, 'Can add user permission group', 51, 'add_userpermissiongroup'),
(202, 'Can change user permission group', 51, 'change_userpermissiongroup'),
(203, 'Can delete user permission group', 51, 'delete_userpermissiongroup'),
(204, 'Can view user permission group', 51, 'view_userpermissiongroup'),
(205, 'Can add user activity', 52, 'add_useractivity'),
(206, 'Can change user activity', 52, 'change_useractivity'),
(207, 'Can delete user activity', 52, 'delete_useractivity'),
(208, 'Can view user activity', 52, 'view_useractivity'),
(209, 'Can add tender evaluation criteria', 53, 'add_tenderevaluationcriteria'),
(210, 'Can change tender evaluation criteria', 53, 'change_tenderevaluationcriteria'),
(211, 'Can delete tender evaluation criteria', 53, 'delete_tenderevaluationcriteria'),
(212, 'Can view tender evaluation criteria', 53, 'view_tenderevaluationcriteria'),
(213, 'Can add project tag', 54, 'add_projecttag'),
(214, 'Can change project tag', 54, 'change_projecttag'),
(215, 'Can delete project tag', 54, 'delete_projecttag'),
(216, 'Can view project tag', 54, 'view_projecttag'),
(217, 'Can add contractor document', 55, 'add_contractordocument'),
(218, 'Can change contractor document', 55, 'change_contractordocument'),
(219, 'Can delete contractor document', 55, 'delete_contractordocument'),
(220, 'Can view contractor document', 55, 'view_contractordocument'),
(221, 'Can add budget revision', 56, 'add_budgetrevision'),
(222, 'Can change budget revision', 56, 'change_budgetrevision'),
(223, 'Can delete budget revision', 56, 'delete_budgetrevision'),
(224, 'Can view budget revision', 56, 'view_budgetrevision'),
(225, 'Can add ai search log', 57, 'add_aisearchlog'),
(226, 'Can change ai search log', 57, 'change_aisearchlog'),
(227, 'Can delete ai search log', 57, 'delete_aisearchlog'),
(228, 'Can view ai search log', 57, 'view_aisearchlog'),
(229, 'Can add ai report generation', 58, 'add_aireportgeneration'),
(230, 'Can change ai report generation', 58, 'change_aireportgeneration'),
(231, 'Can delete ai report generation', 58, 'delete_aireportgeneration'),
(232, 'Can view ai report generation', 58, 'view_aireportgeneration'),
(233, 'Can add ai project analysis', 59, 'add_aiprojectanalysis'),
(234, 'Can change ai project analysis', 59, 'change_aiprojectanalysis'),
(235, 'Can delete ai project analysis', 59, 'delete_aiprojectanalysis'),
(236, 'Can view ai project analysis', 59, 'view_aiprojectanalysis');

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
(47, 'member', 'aichatmessage'),
(46, 'member', 'aichatsession'),
(45, 'member', 'aiissueassessment'),
(59, 'member', 'aiprojectanalysis'),
(58, 'member', 'aireportgeneration'),
(57, 'member', 'aisearchlog'),
(7, 'member', 'announcement'),
(41, 'member', 'auditlog'),
(40, 'member', 'budget'),
(56, 'member', 'budgetrevision'),
(39, 'member', 'citizenevidence'),
(38, 'member', 'citizensubmission'),
(37, 'member', 'comment'),
(8, 'member', 'contact'),
(9, 'member', 'contractor'),
(55, 'member', 'contractordocument'),
(36, 'member', 'contractorrating'),
(48, 'member', 'district'),
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
(49, 'member', 'projectcategory'),
(24, 'member', 'projectdocument'),
(12, 'member', 'projectexpense'),
(23, 'member', 'projectreport'),
(22, 'member', 'projectrisk'),
(13, 'member', 'projectstage'),
(54, 'member', 'projecttag'),
(21, 'member', 'projectupdate'),
(26, 'member', 'project_division'),
(25, 'member', 'project_type'),
(50, 'member', 'region'),
(20, 'member', 'reportissue'),
(19, 'member', 'stagereport'),
(18, 'member', 'stakeholder'),
(14, 'member', 'team'),
(15, 'member', 'tender'),
(17, 'member', 'tenderapplication'),
(53, 'member', 'tenderevaluationcriteria'),
(16, 'member', 'testimonial'),
(6, 'member', 'user'),
(52, 'member', 'useractivity'),
(51, 'member', 'userpermissiongroup'),
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
(49, 'member', '0004_contractor_contractorrating_contractor_and_more', '2026-06-16 07:03:29.021251'),
(50, 'member', '0002_alter_contractor_projects_aiissueassessment_and_more', '2026-07-30 19:58:30.271259'),
(51, 'member', '0002_project_schema_repair', '2026-08-02 19:41:09.455816'),
(52, 'member', '0003_testimonial_experience', '2026-08-02 21:47:40.477027'),
(53, 'member', '0002_alter_tenderapplication_proposal_document', '2026-08-19 12:01:19.024373'),
(54, 'member', '0003_alter_project_division_options_and_more', '2026-08-20 04:35:22.376249'),
(55, 'member', '0004_alter_governmentrequest_options_and_more', '2026-08-20 05:05:58.731783');

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
('0y38udb061r667efrjos06s1q6uwk3pi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZm1:nA7NA2c5qLh9zWMB6F_LEIkkKGw-Vt4AVRi60sao8bw', '2026-09-02 06:27:41.250488'),
('13rc1o2gyneg0mtf4gugknw1yoxa7y5o', '.eJxVjLsOwjAMAP_FM4rywCHpyM43VI7jkgJKpKadEP-OKnWA9e50bxhpW8u4dVnGOcMA1sPpFybip9Td5AfVe1Pc6rrMSe2JOmxXt5bldT3av0GhXmCAIFpHsZgceeNs5IzZWBGL7uxCnAwRo0t60j5qRgmEEiJfDDJh4gSfL_vUOCw:1wHbRO:LGNacgZMl7vjw_49bEdGhZ8Oa5c6e-iojCNxm55ELmU', '2026-05-12 05:57:02.230908'),
('1gi6y4xeflxim6fq6s4emj60al68j0ne', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdpj:l1HlU0aO0NzSD8nrEdodYnvYk_A7YEmOeHWggbu7-fY', '2026-08-16 21:34:59.877056'),
('4dnbieymj8lwx2bl75jh2luu6pyvsdla', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqcVi:8cBY20g_9b8HEeZBBP46a-A4qaVPLJ3OmE4uTDyQzbQ', '2026-08-16 20:10:14.904835'),
('5q6p769hrbhyh7esawk3q9d82v3b68g3', '.eJxVjMsOwiAQAP9lz4aUp2yP3vsNBNitVA0kpT0Z_9006UGvM5N5Q4j7VsLeeQ0LwQgKLr8sxfzkegh6xHpvIre6rUsSRyJO28XUiF-3s_0blNgLjIDJESnLzFKyZVYojUNpaZhTQjc7Y7y23qLiPHhil686Zp1QkTcaI3y-7OE37g:1wH5cP:Qw_bs23tzMx--7FMW7or8ZXZTIVFrmMeCNJRrKxhoCo', '2026-05-10 19:58:17.264025'),
('6ede6lc014tq1scbze0mtr7ufqnmetp3', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqe2v:0YkJhL7ye5CmKJPPy_IXLgpS_96eHBOpzXQbKGs7Nac', '2026-08-16 21:48:37.541021'),
('7c8t9vnrpokvbo3tg72q54sci3yxw151', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZFv:p51IMIFv7seIXWaqVP4_tNwd4BSpHeP7Nx7NrvSy2Nw', '2026-09-02 05:54:31.534711'),
('973u7oel3kzmeeehhi208dj1785rd6a4', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqe2H:e11C-lHallrBgr6ZX3KUPr8LYg_uBMZKP5cmzsGP4CY', '2026-08-16 21:47:57.868496'),
('9788vj1s9pzud7ze0p45uonhly2brmzi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZFZ:F0j0V51sfbZ0Y20WC2Rr7zsvSu5Wzn391M3k01Sn1rw', '2026-09-02 05:54:09.156151'),
('9lej5bly96vbj0cukqe3aoo0fljrssxm', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZl8:lHq7btVRaQ0zLnpYIrbHRwiF1GWvuN-C2kWTB4JdriE', '2026-09-02 06:26:46.826734'),
('9wum3rydvwbjr0wozu89qm7jh84kjzdh', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZUe:schSqkiWN9V7v_jOIC-Czn9zv-ghkzzp42-6OwyYeFo', '2026-09-02 06:09:44.739461'),
('anrzgryp5s60crr2ydh2rlmfup6j9to0', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdeh:3453TIh0v30gouuE1KVMXSRAPAi6sCQx7oZ5VEBvhME', '2026-08-16 21:23:35.994239'),
('apkdanvslg6nx6ewas6ocm48foqsxkoi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZO0:Vzd8alfWmA0z3wNrrHMiH_eRkGVLRjhUtfblL9VHGEU', '2026-09-02 06:02:52.008062'),
('bt62l6jflu9rac2wbujwx05h60jyimui', 'e30:1wpeNf:stQFfT0Dh5Bnqoa6LcoIL0g0wXuiqEV5jxNQinAkrso', '2026-08-14 03:57:55.913119'),
('bx9mzl8hmd6mwn946m9bf8zzbc4wx1yf', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wcRhm:i2IVeyEWWXm0NH6ysD9HwEGWWTD0XEUZUz_aLA8FCNY', '2026-07-08 17:48:06.015856'),
('c1wzhu1onal52usqs6ka19kl20hwgjj5', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdeY:B_rnwsCtXDyX_Ozxz-4z5PtLwLq7sieNfmpddB3aFHc', '2026-08-16 21:23:26.496860'),
('gsef1bmupor5xw670mdq17iybtfguqpv', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdf4:0ncBQepBlDgo_IKh8NiDVw9SCkfVK27_LqkvzW89gmo', '2026-08-16 21:23:58.145761'),
('h0tsipc9x3yohyh94f6xrq32amz46avf', '.eJxVjEsOwiAUAO_C2pDHv7h03zOQBw-kamhS2pXx7oakC93OTObNAh57DUfPW1iIXZkCdvmFEdMzt2Hoge2-8rS2fVsiHwk_befzSvl1O9u_QcVex5cQbBZCC6OSK1bJSRckIxw4ZYv0XvgEhcBoklaT9ZOGiMaB1KRsZp8v3uY24A:1wwvJk:Wmgt_EyQ1e3sgIXSTyA2lFfnQgm2DE1QGAJFvNVNoZY', '2026-09-03 05:27:56.730267'),
('lj4x0otrlw2jsatfnzyhwaliwp6vaatn', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWVjy:F1Q_e2DpAIoXRbbyq1kwQnBa0A4Zoxpd6oySv3tlmyY', '2026-06-22 08:53:50.029226'),
('oc9fl01kbez8tu74oj0dc7qtxnn84dy3', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdnt:CvFkkTcstS4KW4lKNR2ixX3ZH-z3TLquLFScvfQKQNE', '2026-08-16 21:33:05.870138'),
('odbty7i4iqr4hkz5i6pnderkqh61vtt5', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdqF:MC3ASmlRDC3bVcvT_7E7dehLmxUBXT5fJ4VRG2Y3BHY', '2026-08-16 21:35:31.237470'),
('ojnovp86l18dr3ghiygi4s7bx2r0wj83', '.eJxVjEEOwiAQAP-yZ0MKZYH26N03kIUFqRpISnsy_t006UGvM5N5g6d9K37vafULwwwSLr8sUHymegh-UL03EVvd1iWIIxGn7eLWOL2uZ_s3KNQLzGApWKmsy8rlacyDSWhGxahJG7ZDnDBozCqhZIvZIikpQ2AdnaZREsLnC84hN3I:1wGxWF:1uXwrAfLoeLh_dUFDU61Qr_uLhtqWslXqp3weNnNdro', '2026-05-10 11:19:23.081924'),
('oteepgwgeknhs5ymdtgp5sccevtdu4dy', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWsFm:dTpaW2sNHwAtoX3Z_VVwxrl-_ulcTZozkYPqg4dWPUs', '2026-06-23 08:56:10.831602'),
('pkn9jch5jerrsnap26exvwv6oqjvoo63', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdko:s_eUfUBef8Q4P8FD0JecPIXIRwybm2hmrsmULHxRZtA', '2026-08-16 21:29:54.104784'),
('pt6wmwf306y5weg1ayd2qumt3cod61yi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdmb:MXiDWXnVnDiTj4N5Omxv7NConT9btkbFoV6CEjhQ5XQ', '2026-08-16 21:31:45.605939'),
('qbnnxmj7wtnmfk32ameg290jckvtki92', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqcW6:pDqWT9bEw5bRf1nS5HP0CLeLFlw2Kq6suZ6LuZZBxls', '2026-08-16 20:10:38.534387'),
('qclz3l0agn7x7cvre48wracmrnz9uw1g', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWvcg:nmDSvfzeoLXxRAE-ovOecU1jEgogjWUx6J0tUvYmyqs', '2026-06-23 12:32:02.873818'),
('ungx23ac97jaxzr48egsxqfpp1q93t39', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZGW:ihr2bZBdHNTG-erUOOf1B5oBlWNHqPhpr8qhGlg8xTo', '2026-09-02 05:55:08.201328'),
('v8q8fbhgvmwhzlnnff0719sidxnw78uy', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdtp:l5-lo5YzIWsSOP4YTu8PwQo7bUj3F6SX21P75m3350U', '2026-08-16 21:39:13.357412'),
('xmslh23pc9fp63xbmlrl594qqw1szycy', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdir:60fC9EgTjsRwacceuMUwgKJmoaNKC9DrVpL-2qsqkks', '2026-08-16 21:27:53.239036');

-- --------------------------------------------------------

--
-- Table structure for table `member_aichatmessage`
--

CREATE TABLE `member_aichatmessage` (
  `id` bigint(20) NOT NULL,
  `role` varchar(12) NOT NULL,
  `content` longtext NOT NULL,
  `model` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `session_id` bigint(20) NOT NULL,
  `tokens` int(11) DEFAULT NULL,
  `feedback` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_aichatmessage`
--

INSERT INTO `member_aichatmessage` (`id`, `role`, `content`, `model`, `created_at`, `session_id`, `tokens`, `feedback`) VALUES
(1, 'user', 'hello', '', '2026-07-31 03:50:21.736078', 1, NULL, NULL),
(2, 'assistant', 'Portfolio: 19 projects — 13 ongoing, 2 upcoming, 2 completed, and 1 delayed. Budget utilization is 0.0%. Ask about project status, delayed work, or budget utilisation for more detail.', '', '2026-07-31 03:50:21.753755', 1, NULL, NULL),
(3, 'user', 'status', '', '2026-07-31 03:50:44.914038', 1, NULL, NULL),
(4, 'assistant', 'Portfolio: 19 projects — 13 ongoing, 2 upcoming, 2 completed, and 1 delayed. Budget utilization is 0.0%.', '', '2026-07-31 03:50:44.920778', 1, NULL, NULL),
(5, 'user', 'delayed', '', '2026-07-31 03:50:59.608540', 1, NULL, NULL),
(6, 'assistant', '1 project(s) are recorded as delayed. Please review the dashboard\'s project records for their current recovery actions.', '', '2026-07-31 03:50:59.617579', 1, NULL, NULL),
(7, 'user', 'Give me a full executive breakdown of all delayed projects and budget status', '', '2026-08-20 06:00:38.185405', 1, NULL, NULL),
(8, 'assistant', 'The tracked portfolio budget is KES 22,565,543,923.98; KES 2,000,000.00 has been recorded as spent (0.01% utilization).', 'govtracker-rules-v1', '2026-08-20 06:00:49.008607', 1, NULL, NULL),
(9, 'user', 'Give me a full executive breakdown of all delayed projects and budget status', '', '2026-08-20 06:03:00.152903', 1, NULL, NULL),
(10, 'assistant', '### ⚠️ Executive Breakdown: 1 Delayed Capital Project(s)\n\nThere are **1 project(s)** currently experiencing timeline delays, representing a combined financial commitment of **KES 0.00** (KES 0.00 disbursed).\n\n#### ???? Specific Delayed Projects & Status:\n• **Affordable Housing** (ID: 38)\n  - **Category**: Infrastructure | **Location**: Mercy Njeri-Nakuru\n  - **Progress**: 0% | **Budget**: KES 0.00 | **Spent**: KES 0.00 (0% utilized)\n  - **Assigned Contractor**: George Mbola\n\n#### ???? Recommended Strategic Directives:\n1. **Contractor Accountability Review**: Issue formal notices to assigned contractors with progress < 50%.\n2. **Site Inspection Triage**: Mobilize field officers to audit delayed project sites.\n3. **Budget Reallocation Safeguard**: Freeze unspent disbursements until recovery plans are approved.', 'govtracker-intelligence-v2', '2026-08-20 06:03:09.954545', 1, NULL, NULL),
(11, 'user', 'Give me a full executive breakdown of all delayed projects and budget status', '', '2026-08-20 06:03:24.585220', 1, NULL, NULL),
(12, 'assistant', '### ⚠️ Executive Breakdown: 1 Delayed Capital Project(s)\n\nThere are **1 project(s)** currently experiencing timeline delays, representing a combined financial commitment of **KES 0.00** (KES 0.00 disbursed).\n\n#### ???? Specific Delayed Projects & Status:\n• **Affordable Housing** (ID: 38)\n  - **Category**: Infrastructure | **Location**: Mercy Njeri-Nakuru\n  - **Progress**: 0% | **Budget**: KES 0.00 | **Spent**: KES 0.00 (0% utilized)\n  - **Assigned Contractor**: George Mbola\n\n#### ???? Recommended Strategic Directives:\n1. **Contractor Accountability Review**: Issue formal notices to assigned contractors with progress < 50%.\n2. **Site Inspection Triage**: Mobilize field officers to audit delayed project sites.\n3. **Budget Reallocation Safeguard**: Freeze unspent disbursements until recovery plans are approved.', 'govtracker-intelligence-v2', '2026-08-20 06:03:33.944816', 1, NULL, NULL),
(13, 'user', 'h', '', '2026-08-20 06:04:13.345187', 4, NULL, NULL),
(14, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Affordable Housing (ID: 38)\n- **Status**: `DELAYED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Mercy Njeri-Nakuru | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: the government is set to build upto 10 floor affordable house to help common mwananchi access the basic needs\n\n---\n\n### ???? Project Deep-Dive: Menengai II Geothermal Power Station (ID: 20)\n- **Status**: `UPCOMING` | **Progress**: `0%`\n- **Capital Allocation**: KES 10,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Menengai Crater, Nakuru County | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Will be done along Menengai to boost power supply in Nakuru city\n\n---\n\n### ???? Project Deep-Dive: Menengai II Geothermal Power Station (ID: 34)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 20,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Menengai Crater, Nakuru County | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: A 35 MW geothermal power plant under construction in the Menengai Crater, aimed at harnessing geothermal energy to boost Kenya\'s electricity supply.', 'govtracker-intelligence-v2', '2026-08-20 06:04:20.500186', 4, NULL, NULL),
(15, 'user', 'y', '', '2026-08-20 06:05:00.050561', 4, NULL, NULL),
(16, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Northlands City (ID: 30)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Ruiru, Nairobi city | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'govtracker-intelligence-v2', '2026-08-20 06:05:05.179815', 4, NULL, NULL),
(17, 'user', 'budget allocation', '', '2026-08-20 06:05:09.822508', 1, NULL, NULL),
(18, 'assistant', '### ???? Executive Portfolio Financial Assessment\n\n- **Total Authorized Allocation**: **KES 22,565,543,923.98**\n- **Total Disbursed Expenditure**: **KES 2,000,000.00**\n- **Unspent Liquid Reserves**: **KES 22,563,543,923.98**\n- **Overall Absorption Rate**: **0.01%**\n\n#### ???? Top Capital Allocation Commitments:\n• **Thika super highway**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Expansion of Tana River**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Mau Mau Road**: KES 2,121,000,000.00 budget (Spent: KES 0.00 / 0.0%)\n• **Kisumu Port**: KES 147,345,646.00 budget (Spent: KES 0.00 / 0.0%)\n• **Konza Smart City Phase II Development**: KES 56,000,000.00 budget (Spent: KES 1,000,000.00 / 1.8%)\n\n#### ???? Financial Guidance:\n• Absorption rate is at **0.01%**. Reserve capital remains solvent.\n• Ensure all disbursement requisitions undergo milestone verification before payment processing.', 'govtracker-intelligence-v2', '2026-08-20 06:05:19.822017', 1, NULL, NULL),
(19, 'user', 'contractor list', '', '2026-08-20 06:05:19.828310', 1, NULL, NULL),
(20, 'assistant', '### ???? Contractor Registry & Performance Overview\n\n- **Total Registered Contractors**: **1**\n- **Blacklisted Contractors**: **0**\n\n#### ???? Sample Registered Contractors:\n• **kabarak university** [???? Active] — Category: General | Phone: 0527318502\n\n**Action Note**: Blacklisted contractors are automatically barred from participating in public tenders.', 'govtracker-intelligence-v2', '2026-08-20 06:05:25.937053', 1, NULL, NULL),
(21, 'user', 'issues reported', '', '2026-08-20 06:05:25.949129', 1, NULL, NULL),
(22, 'user', 'Give me a full executive breakdown of total capital budget and expenditure absorption', '', '2026-08-20 06:05:25.965039', 4, NULL, NULL),
(23, 'assistant', '### ???? Executive Portfolio Financial Assessment\n\n- **Total Authorized Allocation**: **KES 22,565,543,923.98**\n- **Total Disbursed Expenditure**: **KES 2,000,000.00**\n- **Unspent Liquid Reserves**: **KES 22,563,543,923.98**\n- **Overall Absorption Rate**: **0.01%**\n\n#### ???? Top Capital Allocation Commitments:\n• **Thika super highway**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Expansion of Tana River**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Mau Mau Road**: KES 2,121,000,000.00 budget (Spent: KES 0.00 / 0.0%)\n• **Kisumu Port**: KES 147,345,646.00 budget (Spent: KES 0.00 / 0.0%)\n• **Konza Smart City Phase II Development**: KES 56,000,000.00 budget (Spent: KES 1,000,000.00 / 1.8%)\n\n#### ???? Financial Guidance:\n• Absorption rate is at **0.01%**. Reserve capital remains solvent.\n• Ensure all disbursement requisitions undergo milestone verification before payment processing.', 'govtracker-intelligence-v2', '2026-08-20 06:05:31.058558', 4, NULL, NULL),
(24, 'assistant', '### ???? Citizen Issue & Risk Intelligence Triage\n\n- **Total Reported Citizen Issues**: **2**\n- **Unresolved / Pending Triage**: **1**\n\n#### ⚠️ Recent Reported Signals:\n• **Issue #3** on *Standard Gauge Railway*: \"wqedf\" (Severity: `MODERATE` | Status: `Resolved`) \n• **Issue #2** on *Building of a Dam*: \"jytre\" (Severity: `MODERATE` | Status: `Pending`) \n\n**Triage Action Plan**: Review unresolved issues on the AI Issue Dashboard to assign responsible officers.', 'govtracker-intelligence-v2', '2026-08-20 06:05:31.343877', 1, NULL, NULL),
(25, 'user', 'general overview', '', '2026-08-20 06:05:31.350515', 1, NULL, NULL),
(26, 'assistant', '### ???? GovTracker AI Executive Portfolio Synthesis\n\nHere is the comprehensive real-time status overview of the government capital projects portfolio:\n\n#### ???? Portfolio Metrics & Pipeline Status:\n- **Total Tracked Projects**: **20**\n  - ???? **Ongoing**: 13 projects\n  - ???? **Delayed**: 1 projects\n  - ???? **Completed**: 2 projects\n  - ???? **Upcoming**: 2 projects\n\n#### ???? Financial Absorption Overview:\n- **Total Capital Allocation**: **KES 22,565,543,923.98**\n- **Disbursed Expenditure**: **KES 2,000,000.00** (0.01% utilization)\n- **Available Liquid Reserves**: **KES 22,563,543,923.98**\n\n#### ???? Procurement & Citizen Signals:\n- **Active Tenders**: 2 | **Submitted Bids**: 1\n- **Registered Contractors**: 1\n- **Citizen Issue Reports**: 2 total\n\nYou can ask me specific questions such as:\n• *\"Which projects are currently delayed?\"*\n• *\"What is the budget breakdown and spending?\"*\n• *\"Show contractor performance and blacklisted vendors.\"*\n• *\"List reported citizen issues and risks.\"*', 'govtracker-intelligence-v2', '2026-08-20 06:05:37.719145', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_aichatsession`
--

CREATE TABLE `member_aichatsession` (
  `id` bigint(20) NOT NULL,
  `title` varchar(120) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`context`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_aichatsession`
--

INSERT INTO `member_aichatsession` (`id`, `title`, `created_at`, `updated_at`, `user_id`, `context`) VALUES
(1, 'hello', '2026-07-30 19:58:52.528385', '2026-07-31 03:50:59.621623', 1, NULL),
(2, 'New Conversation', '2026-08-20 05:58:35.572139', '2026-08-20 05:58:35.572171', 30, '{}'),
(3, 'New Conversation', '2026-08-20 05:58:46.402828', '2026-08-20 05:58:46.402863', 30, '{}'),
(4, 'h', '2026-08-20 06:04:13.334473', '2026-08-20 06:04:20.507207', 30, '{}');

-- --------------------------------------------------------

--
-- Table structure for table `member_aiissueassessment`
--

CREATE TABLE `member_aiissueassessment` (
  `id` bigint(20) NOT NULL,
  `category` varchar(50) NOT NULL,
  `urgency` varchar(20) NOT NULL,
  `confidence` smallint(5) UNSIGNED NOT NULL CHECK (`confidence` >= 0),
  `summary` longtext NOT NULL,
  `recommended_action` longtext NOT NULL,
  `model` varchar(100) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `review_status` varchar(20) NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `issue_id` bigint(20) NOT NULL,
  `reviewed_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_aiissueassessment`
--

INSERT INTO `member_aiissueassessment` (`id`, `category`, `urgency`, `confidence`, `summary`, `recommended_action`, `model`, `provider`, `review_status`, `reviewed_at`, `created_at`, `issue_id`, `reviewed_by_id`) VALUES
(1, 'other', 'low', 45, 'The report for Standard Gauge Railway is classified as other with low urgency based on the reported details.', 'Review the report, confirm the details, and schedule follow-up action.', 'govtracker-rules-v1', 'heuristic', 'rejected', NULL, '2026-08-20 05:51:57.773650', 3, NULL),
(2, 'other', 'low', 45, 'The report for Building of a Dam is classified as other with low urgency based on the reported details.', 'Review the report, confirm the details, and schedule follow-up action.', 'govtracker-rules-v1', 'heuristic', 'pending', NULL, '2026-08-20 05:52:34.707159', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_aiprojectanalysis`
--

CREATE TABLE `member_aiprojectanalysis` (
  `id` bigint(20) NOT NULL,
  `analysis_type` varchar(20) NOT NULL,
  `summary` longtext NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `confidence` double NOT NULL,
  `model` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_latest` tinyint(1) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_aireportgeneration`
--

CREATE TABLE `member_aireportgeneration` (
  `id` bigint(20) NOT NULL,
  `report_type` varchar(50) NOT NULL,
  `prompt` longtext NOT NULL,
  `output` longtext NOT NULL,
  `status` varchar(20) NOT NULL,
  `model` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `requested_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_aireportgeneration`
--

INSERT INTO `member_aireportgeneration` (`id`, `report_type`, `prompt`, `output`, `status`, `model`, `created_at`, `project_id`, `requested_by_id`) VALUES
(1, 'executive_summary', '', 'Summary: Project: Affordable Housing. Status: Delayed. Description: the government is set to build upto 10 floor affordable house to help common mwananchi access the basic needs. Budget: 0; Spent: 0; Utilization: 0%. Open issues: 0. Milestones completed: 0/0. Progress: No progress update recorded.\n\nRisk level: Medium (55/100).\n\nRecommended next step: review the project record and assign an accountable follow-up action.', 'generated', 'govtracker-rules-v1', '2026-08-20 05:53:00.812984', 38, 30);

-- --------------------------------------------------------

--
-- Table structure for table `member_aisearchlog`
--

CREATE TABLE `member_aisearchlog` (
  `id` bigint(20) NOT NULL,
  `query` longtext NOT NULL,
  `results` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`results`)),
  `model` varchar(100) NOT NULL,
  `latency_ms` int(11) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_announcement`
--

CREATE TABLE `member_announcement` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `level` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `target_roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`target_roles`))
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
  `user_id` bigint(20) DEFAULT NULL,
  `changes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`changes`)),
  `ip_address` char(39) DEFAULT NULL,
  `model_name` varchar(100) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_auditlog`
--

INSERT INTO `member_auditlog` (`id`, `action`, `timestamp`, `project_id`, `user_id`, `changes`, `ip_address`, `model_name`, `object_id`) VALUES
(1, 'tender_application_submitted', '2026-08-19 13:00:37.703075', NULL, 1, '{}', '127.0.0.1', 'TenderApplication', 1),
(2, 'tender_awarded', '2026-08-19 13:01:03.283064', NULL, 1, '{\"application_id\": 1, \"contractor_id\": 1}', '127.0.0.1', 'Tender', 1),
(3, 'valuating exteme finnce usage in this project', '2026-08-19 14:07:12.970231', 12, NULL, '{\"notes\": \"must be brought to book\"}', NULL, NULL, NULL),
(4, 'quick_updated', '2026-08-19 17:21:55.360866', 35, 1, '{\"status\": \"in_progress\", \"progress\": 90}', '127.0.0.1', 'Milestone', 1),
(5, 'created', '2026-08-20 04:16:16.224228', 29, 1, '{\"stage_name\": \"construction\"}', '127.0.0.1', 'ProjectStage', 2),
(6, 'quick_updated', '2026-08-20 04:20:43.718433', 35, 1, '{\"status\": \"in_progress\", \"progress\": 10}', '127.0.0.1', 'Milestone', 2);

-- --------------------------------------------------------

--
-- Table structure for table `member_budget`
--

CREATE TABLE `member_budget` (
  `id` bigint(20) NOT NULL,
  `allocated_amount` decimal(15,2) NOT NULL,
  `spent_amount` decimal(15,2) NOT NULL,
  `last_updated` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `fiscal_year` varchar(10) DEFAULT NULL,
  `notes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_budget`
--

INSERT INTO `member_budget` (`id`, `allocated_amount`, `spent_amount`, `last_updated`, `project_id`, `fiscal_year`, `notes`) VALUES
(1, '56000000.00', '1000000.00', '2026-08-20 05:37:30.190303', 40, '2027', 'in process, will assess'),
(2, '23000000.00', '1000000.00', '2026-08-20 05:39:19.603196', 1, NULL, NULL),
(3, '30000000000.00', '20000000.00', '2026-08-20 07:38:54.221735', 38, '2027', 'allocated');

-- --------------------------------------------------------

--
-- Table structure for table `member_budgetrevision`
--

CREATE TABLE `member_budgetrevision` (
  `id` bigint(20) NOT NULL,
  `old_amount` decimal(15,2) NOT NULL,
  `new_amount` decimal(15,2) NOT NULL,
  `reason` longtext NOT NULL,
  `revised_at` datetime(6) NOT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `budget_id` bigint(20) NOT NULL
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
  `user_id` bigint(20) NOT NULL,
  `verified_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_citizenevidence`
--

INSERT INTO `member_citizenevidence` (`id`, `title`, `description`, `location`, `image`, `is_verified`, `created_at`, `project_id`, `stage_id`, `user_id`, `verified_by_id`) VALUES
(1, 'fdgn', 'cvdxfg', ' cv', '', 0, '2026-06-11 06:54:43.125873', 1, 1, 1, NULL);

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
  `user_id` bigint(20) NOT NULL,
  `attachment` varchar(100) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `response` longtext DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_comment`
--

CREATE TABLE `member_comment` (
  `id` bigint(20) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `is_flagged` tinyint(1) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_contact`
--

CREATE TABLE `member_contact` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_replied` tinyint(1) NOT NULL,
  `subject` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_contact`
--

INSERT INTO `member_contact` (`id`, `name`, `email`, `message`, `created_at`, `is_replied`, `subject`) VALUES
(2, 'Toto Lavender', 'wodinga@gmail.com', 'nmbgv', '2026-08-02 17:06:04.173277', 0, NULL),
(3, 'Victoria Amanda', 'lavender@gmail.com', 'ergyujiopmk', '2026-08-02 17:06:04.173277', 0, NULL),
(4, 'Toto Vanessah', 'vanessa@gmail.com', 'thanks', '2026-08-02 17:06:04.173277', 0, NULL),
(5, 'Toto Lavender', 'oketchmichael7@gmail.com', 'vgdfsaz', '2026-08-02 17:06:04.173277', 0, NULL),
(6, 'Frank Libe', 'libe@gmail.com', 'im frank libe and thanks for the service', '2026-08-02 17:06:04.173277', 0, NULL),
(7, 'Argwings Kodhek', 'kodhek@gmail.com', 'good work', '2026-08-02 17:06:04.173277', 0, NULL),
(8, 'Test User', 'test@example.com', 'Test message body', '2026-08-19 06:09:45.823490', 0, 'Test Subject');

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
  `profile` varchar(100) DEFAULT NULL,
  `blacklist_reason` longtext DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `is_blacklisted` tinyint(1) NOT NULL,
  `registration_no` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_contractor`
--

INSERT INTO `member_contractor` (`id`, `name`, `contractor_id`, `company`, `phone`, `email`, `location`, `profile`, `blacklist_reason`, `category`, `is_blacklisted`, `registration_no`, `created_at`) VALUES
(1, 'kabarak university', 0, 'kabarak university', '0527318502', 'felixngwono@gmail.com', 'National', '', NULL, NULL, 0, NULL, '2026-08-19 13:00:37');

-- --------------------------------------------------------

--
-- Table structure for table `member_contractordocument`
--

CREATE TABLE `member_contractordocument` (
  `id` bigint(20) NOT NULL,
  `doc_type` varchar(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `contractor_id` bigint(20) NOT NULL
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
  `comment` text DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `rated_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_district`
--

CREATE TABLE `member_district` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `region_id` bigint(20) NOT NULL
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
  `feedback` longtext DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_feedback`
--

INSERT INTO `member_feedback` (`id`, `full_name`, `email`, `phone_number`, `feedback`, `created_at`, `project_id`, `rating`) VALUES
(5, 'Nicole Amanda', 'amanda@gmail.com', '798643789', 'Amanda Nyar Usonga penjo', '2026-08-02 17:06:04.569716', NULL, NULL),
(6, 'Lan Young', 'young@gmail.com', '798564321', 'thanks for the service', '2026-08-02 17:06:04.569716', NULL, NULL),
(7, 'Frank Omondi', 'omond@gmail.com', '0527318502', 'good servicing, you helping the people of your own land', '2026-08-10 18:38:05.733759', NULL, NULL);

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
  `citizen_id` bigint(20) NOT NULL,
  `ai_category_suggestion` varchar(50) DEFAULT NULL,
  `assigned_to_id` bigint(20) DEFAULT NULL,
  `official_response` longtext DEFAULT NULL,
  `priority` varchar(20) NOT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  `responded_at` datetime(6) DEFAULT NULL,
  `responded_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_governmentrequest`
--

INSERT INTO `member_governmentrequest` (`id`, `title`, `description`, `category`, `location`, `image`, `status`, `created_at`, `updated_at`, `citizen_id`, `ai_category_suggestion`, `assigned_to_id`, `official_response`, `priority`, `reference_no`, `responded_at`, `responded_by_id`) VALUES
(1, 'qewr', 'qwer', 'infrastructure', 'qewr', '', 'pending', '2026-06-11 07:17:01.434909', '2026-06-11 07:17:01.434957', 1, NULL, NULL, NULL, 'medium', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_media`
--

CREATE TABLE `member_media` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `media_type` varchar(10) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `uploaded_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_media`
--

INSERT INTO `member_media` (`id`, `file`, `media_type`, `uploaded_at`, `project_id`, `caption`, `uploaded_by_id`) VALUES
(1, 'project_media/RamogiFM_RamogiFM___Twitter.mp4', 'video', '2025-03-06 12:05:42.502636', NULL, NULL, NULL),
(2, 'project_media/-5069072835879741643_121.jpg', 'image', '2025-03-06 12:41:04.143274', NULL, NULL, NULL);

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
  `stage_id` bigint(20) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_milestone`
--

INSERT INTO `member_milestone` (`id`, `title`, `description`, `completion_date`, `progress_percentage`, `project_id`, `stage_id`, `due_date`, `status`) VALUES
(1, 'nbnm', 'nmjhmn', '2025-03-12', 90, 35, 1, NULL, 'in_progress'),
(2, 'geothermal power project', 'power station installation', '2026-02-16', 10, 35, 1, NULL, 'in_progress');

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
  `project_id` bigint(20) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_notification`
--

INSERT INTO `member_notification` (`id`, `notification_type`, `title`, `message`, `is_read`, `created_at`, `recipient_id`, `project_id`, `link`) VALUES
(1, NULL, NULL, 'Welcome anytime Ajumbutule', 0, '2025-03-06 12:17:36.241868', NULL, NULL, NULL),
(2, NULL, NULL, 'wecome', 1, '2025-03-06 12:17:56.611611', NULL, NULL, NULL),
(3, 'system', 'System Update', 'Your government project proposal has been submitted.', 0, '2026-08-20 06:21:59.831487', 1, NULL, NULL);

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
(6, 'certisfied', '2026-02-23 08:03:52.925874', 1, 37, 25),
(7, 'good', '2026-08-19 05:19:00.116844', 1, 39, 30);

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
  `amount` decimal(15,2) NOT NULL,
  `funding_source` varchar(255) NOT NULL,
  `date_funded` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `funding_type` varchar(50) NOT NULL,
  `reference` varchar(100) DEFAULT NULL
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
  `project_id` bigint(20) NOT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL
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
  `project_id` bigint(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL
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
  `stage_id` bigint(20) DEFAULT NULL,
  `challenges` longtext DEFAULT NULL,
  `next_steps` longtext DEFAULT NULL,
  `reported_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_project`
--

CREATE TABLE `member_project` (
  `id` bigint(20) NOT NULL,
  `project_title` varchar(200) DEFAULT NULL,
  `project_description` longtext DEFAULT NULL,
  `project_location` varchar(200) DEFAULT NULL,
  `implementing_agency` varchar(200) DEFAULT NULL,
  `project_Budgeting` decimal(15,2) DEFAULT NULL,
  `amount_spent` decimal(15,2) DEFAULT NULL,
  `images` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `beneficiaries` longtext DEFAULT NULL,
  `stakeholders` longtext DEFAULT NULL,
  `progress` longtext DEFAULT NULL,
  `project_status` varchar(20) DEFAULT NULL,
  `impact` longtext DEFAULT NULL,
  `project_manager` varchar(100) DEFAULT NULL,
  `project_contractor` varchar(100) DEFAULT NULL,
  `contact_email` varchar(254) DEFAULT NULL,
  `progress_update` datetime(6) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `actual_end_date` date DEFAULT NULL,
  `ai_completion_estimate` date DEFAULT NULL,
  `ai_risk_score` double DEFAULT NULL,
  `ai_summary` longtext DEFAULT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `funding_source` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `priority` varchar(10) NOT NULL,
  `reference_code` varchar(50) DEFAULT NULL,
  `supervising_agency` varchar(200) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `district_id` bigint(20) DEFAULT NULL,
  `project_division_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_project`
--

INSERT INTO `member_project` (`id`, `project_title`, `project_description`, `project_location`, `implementing_agency`, `project_Budgeting`, `amount_spent`, `images`, `start_date`, `end_date`, `beneficiaries`, `stakeholders`, `progress`, `project_status`, `impact`, `project_manager`, `project_contractor`, `contact_email`, `progress_update`, `remarks`, `actual_end_date`, `ai_completion_estimate`, `ai_risk_score`, `ai_summary`, `cover_image`, `created_at`, `created_by_id`, `funding_source`, `is_featured`, `is_public`, `priority`, `reference_code`, `supervising_agency`, `updated_at`, `category_id`, `district_id`, `project_division_id`) VALUES
(1, 'Kisumu Highway', 'A perfect highway joining most counties promoting business opportunities', 'Kisumu', 'Governmental Agencies', '23000000.00', '1000000.00', 'projects/dlock.jpg', '2026-04-22', '2026-06-11', 'citizens', 'agencies', '67', 'ongoing', 'good economic network', NULL, 'George Mbola', 'felixngwono@gmail.com', '2026-08-20 05:39:19.593664', '- fostering good economy', NULL, NULL, NULL, NULL, '', '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', 'PRJ-4E95B81D', NULL, '2026-08-20 05:39:19.593687', NULL, NULL, NULL),
(11, 'Thika super highway', 'Repair and maintanance of Thika super highway', 'Thika', 'KeNHA', '9999999999.99', NULL, 'projects/thika.jpg', '2024-03-01', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(12, 'Kisumu Port', 'Project extension of L.Victoria port has reached its completion stage.', 'Kisumu', 'National government', '147345646.00', NULL, 'projects/login.PNG', '2024-03-02', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(18, 'tree plantation farming', 'tree plantatiion farming in Nakuru county', 'kampi ya moto- Nakuru', 'National government', '34567890.00', NULL, 'projects/mau_mau.jpg', '2024-03-06', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(20, 'Menengai II Geothermal Power Station', 'Will be done along Menengai to boost power supply in Nakuru city', 'Menengai Crater, Nakuru County', 'national Government and the NGO\'s', '10000000.00', NULL, 'projects/im.jpg', '2025-12-06', '2027-12-06', NULL, NULL, NULL, 'upcoming', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(22, 'Street development in Dandora, Nairobi', 'The project in Dandora focuses on the implementation of a ‘model street’ in a low income neighbourhood in Nairobi. Previously a well-planned neighborhood, Dandora has gradually degenerated to almost slum status. The implementation site, a street in Dandora, was selected as it is an essential part of the ‘Must Seed’ strategy, a step by step process of making small interventions that have large impact in the community.', 'Dandora-Nairobi', 'Placemakers, KUWA, Dandora Transformation League (DTL)', '1654879.00', NULL, 'projects/dandora_9E3A1mg.jpg', '2024-03-07', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(24, 'Building of a Dam', 'Dam Description', 'Kisumu', 'National Government', '30000000.00', NULL, 'projects/pacho_7f3AtUZ.jpg', '2024-03-12', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(27, 'express way', 'Completion of expressway along Haile Sellasie avenue', 'Nairobi', 'National government', '34500000.00', NULL, 'projects/expressway_SwK9e6V.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(28, 'Irrigation Farming', 'The government is yet to initiate irrigation farming along the seven Folks dams of R.Tana', 'Mount Kenya region', 'National government', '4579867.00', NULL, 'projects/tana_river.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(29, 'Kisumu Highway', 'Kisumu started as a small town called Kisuma. Grey due to the greate snaking metal rod of Jorochere', 'Kisumu', 'Nyong\'o government', '25895642.00', NULL, 'projects/dala.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(30, 'Northlands City', 'The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'Ruiru, Nairobi city', 'Governmental Agencies', '23000000.00', NULL, 'projects/thika_Ua6mF2X.jpg', '2024-03-12', '2024-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(31, 'Standard Gauge Railway', 'Construction of the Mombasa-Malaba standard gauge railway was launched by President Uhuru Kenyatta on November 28, 2013.\r\n\r\nPhase one of the project – from Mombasa to Nairobi was completed in 2017.', 'Mombasa', 'Mombasa county government', '34000000.00', NULL, 'projects/sgr.png', '2024-03-12', '2024-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(33, 'Mau Mau Road', 'Construction of a 540km road that seeks to honour the role of Mau Mau freedom fighters in the liberation of Kenya from colonialists is underway, offering three central Kenya counties a new artery into Nairobi.\r\n\r\nChristened Mau Mau Road, the highway starts at Gataka in Limuru, and then passes through Kamahindu and Kibichoi in Kiambu before negotiating its way through Kinyona in Kigumo and Ichichi in Murang’a.', 'Limuru, Nairobi', 'National government', '2121000000.00', NULL, 'projects/expressway.jpg', '2024-03-12', '2027-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(34, 'Menengai II Geothermal Power Station', 'A 35 MW geothermal power plant under construction in the Menengai Crater, aimed at harnessing geothermal energy to boost Kenya\'s electricity supply.', 'Menengai Crater, Nakuru County', 'High; expected to be commissioned in 2025 to meet growing energy demands.', '20000000.00', NULL, 'projects/Architecture-Portfolio-Cover-1024x683.webp', '2025-02-19', '2025-03-06', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(36, 'Expansion of Tana River', 'Due to frequent blockages of the river banks, the government  considered its improval', 'Tana River Machakos County', 'National government', '9999999999.99', NULL, 'projects/tana_river_Laq2K1W.jpg', '2024-03-07', '2025-03-12', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(37, 'Nairobi Railway City', 'After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.', 'Nairobi', 'National government', '0.00', NULL, 'projects/sgr_saMexVe.png', '2025-03-13', '2028-02-12', 'Railway users', 'multi billionares', 'upcoming', 'upcoming', 'speeding the rate of transportation and reducing the trafficking in public roads', NULL, 'George Mbola', 'info@lapsset.go.ke', '2026-06-10 13:48:50.457266', 'poornproject management', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(38, 'Affordable Housing', 'the government is set to build upto 10 floor affordable house to help common mwananchi access the basic needs', 'Mercy Njeri-Nakuru', 'National Government', '30000000000.00', '20000000.00', 'projects/house.jpg', '2026-02-27', '2031-05-16', '-common mwananchi\r\n- government', '-Government tycoons\r\n- president William Ruto', '', 'Delayed', 'reduction of overcrowding in the country', NULL, 'George Mbola', 'felixngwono@gmail.com', '2026-08-20 07:38:54.224497', '-this will impact on the reduction of slums in the country\r\n-clean environment', NULL, NULL, NULL, NULL, '', '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', 'PRJ-D4FB8489', NULL, '2026-08-20 07:38:54.224519', NULL, NULL, NULL),
(39, 'Infrastructure and Energy', 'Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.', 'Siaya County', 'County Government', '0.00', NULL, 'projects/house_wMsNgUd.jpg', '2024-06-04', '2026-02-21', 'citizens', 'county government', '', 'completed', '- Ease of access of clean and free energy', NULL, 'George Mbola', 'felixngwono@gmail.com', '0000-00-00 00:00:00.000000', 'free and favourable energy', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', NULL, NULL, NULL),
(40, 'Konza Smart City Phase II Development', '\"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.', 'Konza, Machakos County', 'Konza Technopolis Development Authority (KoTDA)', '56000000.00', '1000000.00', 'projects/assignment-alukwe.jpeg', '2026-07-28', '2026-07-29', 'Residents of Machakos County, ICT companies, investors, \"\r\n        \"students, entrepreneurs and SMEs.', 'KoTDA, National Treasury, Ministry of ICT, Machakos County Government, \"\r\n        \"Private Investors, Local Communities.', '\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.', 'draft', 'The project has attracted investors and improved supporting \"\r\n        \"infrastructure, but expected economic benefits have been delayed.', 'Eng. James Mwangi', 'China State Construction Engineering Corporation', 'info@konza.go.ke', '2026-08-20 05:37:30.195671', '\"Project suspended pending Treasury approval, contractor claims settlement, \"\r\n        \"and completion of an independent audit.', '2026-08-03', '2026-08-27', 56, '\"AI analysis indicates that the project has been suspended because \"\r\n        \"of procurement reviews, delayed funding disbursement, and contractual disputes', 'projects/covers/assignment-alukwe.jpeg', '2026-08-02 21:13:49.935033', NULL, 'Government of Kenya and Public-Private Partnerships (PPP)', 0, 1, 'high', 'PRJ-KEN-2026-001', 'Ministry of Information, Communications and the Digital Economy', '2026-08-20 05:37:30.195712', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_projectcategory`
--

CREATE TABLE `member_projectcategory` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `icon` varchar(50) NOT NULL,
  `color` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectdocument`
--

CREATE TABLE `member_projectdocument` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `category` varchar(20) NOT NULL,
  `uploaded_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectexpense`
--

CREATE TABLE `member_projectexpense` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `date` date DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `receipt` varchar(100) DEFAULT NULL,
  `recorded_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_projectexpense`
--

INSERT INTO `member_projectexpense` (`id`, `title`, `category`, `amount`, `description`, `date`, `project_id`, `receipt`, `recorded_by_id`) VALUES
(1, 'tarmac', 'materials', '1000000.00', 'its over quoted', '2026-08-20', 1, 'receipts/Sure.docx', 30);

-- --------------------------------------------------------

--
-- Table structure for table `member_projectreport`
--

CREATE TABLE `member_projectreport` (
  `id` bigint(20) NOT NULL,
  `report_file` varchar(100) NOT NULL,
  `report_date` datetime(6) NOT NULL,
  `report_title` varchar(255) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `prepared_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectrisk`
--

CREATE TABLE `member_projectrisk` (
  `id` bigint(20) NOT NULL,
  `risk_description` longtext DEFAULT NULL,
  `risk_level` varchar(10) NOT NULL,
  `mitigation_plan` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `impact_rating` varchar(10) DEFAULT NULL,
  `likelihood` varchar(10) DEFAULT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_projectstage`
--

CREATE TABLE `member_projectstage` (
  `id` bigint(20) NOT NULL,
  `stage_name` varchar(30) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `progress_percentage` decimal(5,2) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `order` int(10) UNSIGNED NOT NULL CHECK (`order` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_projectstage`
--

INSERT INTO `member_projectstage` (`id`, `stage_name`, `description`, `start_date`, `end_date`, `progress_percentage`, `project_id`, `is_current`, `order`) VALUES
(1, 'construction', 'nghfdtygh', '2024-03-12', '2024-03-09', '60.00', 30, 0, 0),
(2, 'construction', '10km done', '2026-08-06', '2027-01-29', '78.00', 29, 1, 12);

-- --------------------------------------------------------

--
-- Table structure for table `member_projecttag`
--

CREATE TABLE `member_projecttag` (
  `id` bigint(20) NOT NULL,
  `tag` varchar(50) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `project_id` bigint(20) NOT NULL,
  `posted_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_project_division`
--

CREATE TABLE `member_project_division` (
  `id` bigint(20) NOT NULL,
  `project_name` varchar(1000) NOT NULL,
  `project_type_id` bigint(20) DEFAULT NULL,
  `allocated_budget` decimal(15,2) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `contact_email` varchar(254) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `head_of_division` varchar(150) DEFAULT NULL,
  `head_user_id` bigint(20) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `office_location` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_project_division`
--

INSERT INTO `member_project_division` (`id`, `project_name`, `project_type_id`, `allocated_budget`, `code`, `contact_email`, `contact_phone`, `created_at`, `description`, `head_of_division`, `head_user_id`, `image`, `is_active`, `name`, `office_location`, `updated_at`) VALUES
(1, 'Ground Breaking', NULL, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113'),
(2, 'Tile Fittings', NULL, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113'),
(3, 'Land clearence', NULL, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113'),
(4, 'Initiation stage', NULL, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113'),
(5, 'Ground Breaking', NULL, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113'),
(7, 'nile irrigation', 29, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113');

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
-- Table structure for table `member_region`
--

CREATE TABLE `member_region` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) NOT NULL
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
  `user_id` bigint(20) DEFAULT NULL,
  `resolution_notes` longtext DEFAULT NULL,
  `resolved_by_id` bigint(20) DEFAULT NULL,
  `severity` varchar(10) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_reportissue`
--

INSERT INTO `member_reportissue` (`id`, `title`, `issue_description`, `evidence`, `created_at`, `resolved`, `status`, `project_id`, `user_id`, `resolution_notes`, `resolved_by_id`, `severity`, `updated_at`) VALUES
(2, 'jytre', 'jghfdsfghj', 'issue_evidence/house.jpg', '2025-03-11 14:06:32.155449', 0, 'Pending', 24, 21, NULL, NULL, 'moderate', '2026-08-02 17:06:08.484946'),
(3, 'wqedf', 'asdfg', 'issue_evidence/sgr.png', '2025-03-11 14:37:45.210463', 1, 'Resolved', 31, 22, NULL, NULL, 'moderate', '2026-08-02 17:06:08.484946');

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
  `stage_id` bigint(20) NOT NULL,
  `reported_by_id` bigint(20) DEFAULT NULL,
  `weather_conditions` varchar(100) DEFAULT NULL,
  `workforce_count` int(11) DEFAULT NULL
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
  `organization` varchar(255) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL
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
(1, 'Shanty Page', 'web designer', 'team/02c92d479a634167955278c0bef5d671.jpg', '2026-02-15 12:31:29.817313', 'im shanty page and a web designer', 'https://www.facebook.com/francisodhiambo.com', 'https://www.instagram.com/@nicoleatieno.com', 'https://www.facebook.com/francisodhiambo.', 'https://www.facebook.com/@nicoleatieno.com', '+254700456700'),
(3, 'Felix Odhiambo', 'Programmer', 'team/3E0D6A3A6E21709C14D076FCD8665602C654C9A8.jpg', '2026-02-16 07:39:45.848005', 'im Felix Odhiambo, a computer scientist majorl in the fiield of programming', 'https://www.facebook.com/@nicoleatieno.com', 'https://www.instagram.com/@nicoleatieno.com', 'https://www.facebook.com/francisodhiambo.', 'https://www.linkedin.com/@nicoleatieno.com', '+2547896543245'),
(5, 'Jane Omondi', 'Project Analyst', 'team/IMG-20250724-WA0011.jpg', '2026-08-20 04:28:14.323787', 'im jane, the project analyst at Filpex Agency', 'https://www.facebook.com/@jane.com', 'https://www.instagram.com/@jane.com', 'https://www.facebook.com/jane.com', 'https://www.linkedin.com/@jane.com', NULL);

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
  `project_id` bigint(20) DEFAULT NULL,
  `award_amount` decimal(15,2) DEFAULT NULL,
  `award_date` date DEFAULT NULL,
  `awarded_to_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_tender`
--

INSERT INTO `member_tender` (`id`, `reference_number`, `description`, `procurement_method`, `estimated_budget`, `opening_date`, `closing_date`, `eligibility_criteria`, `evaluation_criteria`, `status`, `document`, `is_published`, `created_at`, `created_by_id`, `project_id`, `award_amount`, `award_date`, `awarded_to_id`, `title`) VALUES
(1, 'Ref123we', 'Affordable housing around Manyatta Gonda', 'restricted', '56789765.00', '2026-04-22', '2029-06-28', 'edfghjkl', 'hsaertfg', 'awarded', 'tenders/dlock.jpg', 0, '2026-04-28 05:41:12.276887', NULL, NULL, '45000000.00', '2026-08-19', 1, NULL),
(2, 'ULGM123R', 'im a contractor and i have experiences in constructing roads', 'restricted', NULL, '2026-06-27', '2026-09-10', 'kcse certificate', 'attaining all the credit scores', 'draft', 'tenders/login.png', 0, '2026-06-27 20:41:11.191406', NULL, 37, NULL, NULL, NULL, NULL);

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
  `total_score` float NOT NULL DEFAULT 0,
  `ai_financial_assessment` longtext DEFAULT NULL,
  `ai_recommendation` varchar(50) DEFAULT NULL,
  `ai_technical_assessment` longtext DEFAULT NULL,
  `evaluator_notes` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_tenderapplication`
--

INSERT INTO `member_tenderapplication` (`id`, `company_name`, `company_email`, `company_phone`, `proposal_document`, `bid_amount`, `cover_letter`, `submitted_at`, `status`, `applicant_id`, `tender_id`, `technical_score`, `financial_score`, `total_score`, `ai_financial_assessment`, `ai_recommendation`, `ai_technical_assessment`, `evaluator_notes`) VALUES
(1, 'kabarak university', 'felixngwono@gmail.com', '0527318502', 'tender_applications/students_record.xlsx', '45000000.00', 'tender_coverLetter/Untitled_Diagram.drawio', '2026-08-19 13:00:37.689662', 'awarded', 1, 1, 0, 0, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_tenderevaluationcriteria`
--

CREATE TABLE `member_tenderevaluationcriteria` (
  `id` bigint(20) NOT NULL,
  `criterion` varchar(255) NOT NULL,
  `weight` double NOT NULL,
  `description` longtext NOT NULL,
  `tender_id` bigint(20) NOT NULL
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
  `user_id` bigint(20) DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `rating` smallint(5) UNSIGNED NOT NULL CHECK (`rating` >= 0),
  `is_featured` tinyint(1) NOT NULL,
  `moderation_note` longtext NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_testimonial`
--

INSERT INTO `member_testimonial` (`id`, `name`, `content`, `phone_number`, `image`, `created_at`, `project_id`, `user_id`, `is_approved`, `rating`, `is_featured`, `moderation_note`, `updated_at`) VALUES
(1, 'Nicole Atieno', 'my mentor my role model', NULL, 'testimonials/02c92d479a634167955278c0bef5d671.jpg', '2026-04-26 11:27:07.890437', 1, NULL, 0, 5, 0, '', '2026-08-02 21:47:40.451676'),
(2, 'Shanty Page', 'since the launching of this platform, im able to track on the farming processes in Perkerra', NULL, 'testimonials/Fel16.jpg', '2026-02-15 08:33:41.000000', 28, NULL, 0, 5, 0, '', '2026-08-02 21:47:40.451676'),
(3, 'Angela Valdes', 'im happy with this project, the phases are clearly shown. Thanks Project Manager, programmer and designer', NULL, 'testimonials/Fel14.jpg', '2026-02-15 09:00:48.000000', 24, NULL, 0, 5, 0, '', '2026-08-02 21:47:40.451676'),
(4, 'Betty Amanda', 'Amanda Mor', NULL, 'testimonials/logo.png', '2026-02-15 09:11:41.000000', 31, NULL, 0, 5, 0, '', '2026-08-02 21:47:40.451676'),
(5, 'Nicole Atieno', '“This is a good platform where citizens can track government oversight.”', NULL, 'testimonials/solar.jpg', '2026-02-15 07:44:44.000000', 12, NULL, 0, 5, 0, '', '2026-08-02 21:47:40.451676');

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
  `email` varchar(254) NOT NULL,
  `username` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `bio` longtext DEFAULT NULL,
  `is_enduser` tinyint(1) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `profile` varchar(100) DEFAULT NULL,
  `updated` datetime(6) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `last_login_ip` char(39) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `two_factor_enabled` tinyint(1) NOT NULL,
  `verification_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_user`
--

INSERT INTO `member_user` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`, `username`, `name`, `role`, `bio`, `is_enduser`, `avatar`, `profile`, `updated`, `created_at`, `is_verified`, `last_login_ip`, `location`, `organization`, `phone_number`, `two_factor_enabled`, `verification_status`) VALUES
(1, 'pbkdf2_sha256$600000$eK4cX1QJxbLYev4itN2MFq$F0E87XnzWK5poO68PKyJ64MWukjctSF4HWmx4aML8yE=', '2026-08-19 06:27:41.247804', 1, '', '', 1, 1, '2026-04-26 11:11:12.503469', 'felixngwono@gmail.com', 'FelloMarley', 'Felix Odhiambo', 'developer', 'I\'m FelloMarley, the mastermind behind the government tracker website', 0, 'avatar.png', 'profiles/Fel14_9bkNTiv.jpg', '2026-04-26 11:19:11.324442', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(2, 'pbkdf2_sha256$390000$TDORiaVNPtEXR4OUPLDiTC$LwK7MIK1UWZ52hhBoZcJ3fER0UWBAZ6bbpIYJ1fhfVE=', '2026-04-26 19:58:17.256715', 0, '', '', 0, 1, '2026-04-26 19:50:51.247921', 'nicole@gmail.com', 'Atieno NyarChula', 'Nicole Atieno', 'engineer', 'Im Nyachula, born to be a winner', 0, 'avatar.png', 'profiles/02c92d479a634167955278c0bef5d671_R0mYTV3.jpg', '2026-04-26 19:50:52.868190', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(15, 'pbkdf2_sha256$600000$sdZXg14tgnO7xa9BZMRudV$15CmOFaWIpD5svoHyNtsQKA70oqKwIhFRoihCTrZTBo=', '2024-11-13 10:44:07.903587', 0, '', '', 0, 1, '2024-03-17 08:35:44.262524', 'omondi@gmail.com', 'Ajumbutule', 'Frank Omondi', 'citizen', 'Im Ajumbutule', 1, 'avatar.png', 'images/3006.webp', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(21, 'pbkdf2_sha256$390000$L3rjadbchaO0SpN9HBxF3S$7IwkCJCvSjH+A153Y3J+8W2hT03K8drd0wkQGjzV7iI=', '2026-02-15 09:24:48.995603', 1, '', '', 0, 1, '2024-03-18 21:04:19.576787', 'fellomarley@gmail.com', 'Fello', 'Felix Odhiambo', 'citizen', 'Im Marley', 0, 'avatar.png', 'images/chief_J9TcRuW.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(22, 'felixodhiambo@kabarak.ac.ke', NULL, 1, '', '', 1, 0, '2024-03-07 12:52:01.000000', 'True', 'StoryTeller', 'Felix Odhiambo', 'citizen', 'im Marley', 0, '10', 'avartor.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(23, 'pbkdf2_sha256$390000$WQOqv9km54x7scaodebVCd$HYGL9+bFmqvTtlw+RAE5YgIwulygM1B9Egut5CAJry0=', '2026-02-23 08:19:46.449107', 0, '', '', 0, 1, '2024-03-20 19:38:48.673003', 'vanessa@gmail.com', 'Vanessah', 'Toto Vanessah', 'citizen', 'Im Vanessah. The only Titan from the lake in the family of akina Fellix The StoryTeller', 1, 'avatar.png', 'profiles/tree.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(25, 'pbkdf2_sha256$390000$QCtLfFIyYQvtD9z4whkpmK$QSWeErI3jRNzVRw1BnuRCRDR23Sy3FCsF5Z74v2OLXo=', '2026-02-23 09:07:24.976027', 0, '', '', 0, 1, '2025-03-12 10:02:37.372369', 'assielo@gmail.com', 'assiello', 'Assiello Nomar', 'citizen', 'Assiello Norma', 1, 'avatar.png', 'profiles/solar.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(26, 'pbkdf2_sha256$390000$rvjkDxGKNzDBpOphsu5Rss$fBQTcWntdNp131fgkCqBTyd69P8/xm3kYdLvNG81S1Y=', '2026-04-28 05:57:02.225708', 0, '', '', 0, 1, '2026-02-15 09:22:02.825205', 'betty@gmail.com', 'Amanda', 'Betty Amanda', 'developer', 'im betty amanda', 0, 'avatar.png', 'profiles/038e478f9c094c01be86505e030c974d_DC7y9U9.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(27, 'pbkdf2_sha256$390000$ru4QbghiyfWrnOcUrlggSw$NhAXp11ikeE42Z4rNPpaCIlqUSLiYtRUevcWroYH/gU=', '2026-02-23 09:13:17.518974', 1, '', '', 1, 1, '2026-02-16 13:56:00.197953', 'felix@gmail.com', 'Odinga', 'Felix Odhiambo', 'developer', 'im felix odhiamo', 0, 'avatar.png', 'profiles/Fel14.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(29, 'pbkdf2_sha256$600000$BavP8B0es7pFn9ME210i3X$Xr3WxFnouS6cGR9C/AuHZbcAVlK6bncoXJ7WnfEhH9M=', '2026-06-08 08:29:15.187052', 1, '', '', 1, 1, '2026-06-08 08:28:37.288152', 'felix7@gmail.com', 'FelloMarley7', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-06-08 08:28:38.384166', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified'),
(30, 'pbkdf2_sha256$600000$rKq0i4dBN2mlV9ieFGVZWb$q26b/wnHa7Vhjhc67nwKimAYHkGz6GuF2ptZ82DiC8Q=', '2026-08-20 05:27:56.720850', 0, '', '', 0, 1, '2026-08-16 07:49:35.828791', 'wanjiru@gmail.com', 'Mercy77', 'Mercy Wanjiru', 'official', 'Im Mercy working with HELB', 1, 'avatar.png', 'profiles/Maccheronis_Valley_View_Dam_Italy_03.jpg', '2026-08-16 07:49:38.263116', '2026-08-16 07:49:38.263163', 0, NULL, NULL, NULL, NULL, 0, 'unverified');

-- --------------------------------------------------------

--
-- Table structure for table `member_useractivity`
--

CREATE TABLE `member_useractivity` (
  `id` bigint(20) NOT NULL,
  `action` varchar(20) NOT NULL,
  `description` varchar(500) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_userpermissiongroup`
--

CREATE TABLE `member_userpermissiongroup` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`permissions`)),
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indexes for table `member_aichatmessage`
--
ALTER TABLE `member_aichatmessage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_aichatmessage_session_id_cfccf3e1_fk_member_ai` (`session_id`);

--
-- Indexes for table `member_aichatsession`
--
ALTER TABLE `member_aichatsession`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_aichatsession_user_id_351ab447_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_aiissueassessment`
--
ALTER TABLE `member_aiissueassessment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_aiissueassess_issue_id_f8efd15a_fk_member_re` (`issue_id`),
  ADD KEY `member_aiissueassess_reviewed_by_id_6409d7ad_fk_member_us` (`reviewed_by_id`);

--
-- Indexes for table `member_aiprojectanalysis`
--
ALTER TABLE `member_aiprojectanalysis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_aireportgeneration`
--
ALTER TABLE `member_aireportgeneration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_aisearchlog`
--
ALTER TABLE `member_aisearchlog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_announcement`
--
ALTER TABLE `member_announcement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_announcement_created_by_id_0c5ba019_fk_member_user_id` (`created_by_id`);

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
-- Indexes for table `member_budgetrevision`
--
ALTER TABLE `member_budgetrevision`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_citizenevidence`
--
ALTER TABLE `member_citizenevidence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_citizenevidence_project_id_113de4c6_fk_member_project_id` (`project_id`),
  ADD KEY `member_citizeneviden_stage_id_4239d11e_fk_member_pr` (`stage_id`),
  ADD KEY `member_citizenevidence_user_id_afa2e230_fk_member_user_id` (`user_id`),
  ADD KEY `member_citizenevidence_verified_by_id_5a754207_fk_member_user_id` (`verified_by_id`);

--
-- Indexes for table `member_citizensubmission`
--
ALTER TABLE `member_citizensubmission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_citizensubmission_user_id_abd57c8e_fk_member_user_id` (`user_id`),
  ADD KEY `member_citizensubmis_project_id_f79857c0_fk_member_pr` (`project_id`);

--
-- Indexes for table `member_comment`
--
ALTER TABLE `member_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_comment_project_id_3fa8114d_fk_member_project_id` (`project_id`),
  ADD KEY `member_comment_user_id_51d0677f_fk_member_user_id` (`user_id`),
  ADD KEY `member_comment_parent_id_ffa34bef_fk_member_comment_id` (`parent_id`);

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
-- Indexes for table `member_contractordocument`
--
ALTER TABLE `member_contractordocument`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contractor_rating_project` (`project_id`),
  ADD KEY `member_contractorrating_rated_by_id_a6b6aa3c_fk_member_user_id` (`rated_by_id`);

--
-- Indexes for table `member_district`
--
ALTER TABLE `member_district`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_feedback`
--
ALTER TABLE `member_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_feedback_project_id_716ce9e3_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_governmentrequest`
--
ALTER TABLE `member_governmentrequest`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_no` (`reference_no`),
  ADD KEY `member_governmentrequest_citizen_id_0e8ec8f8_fk_member_user_id` (`citizen_id`),
  ADD KEY `member_governmentreq_assigned_to_id_92671ada_fk_member_us` (`assigned_to_id`),
  ADD KEY `member_governmentreq_responded_by_id_23c9c32c_fk_member_us` (`responded_by_id`);

--
-- Indexes for table `member_media`
--
ALTER TABLE `member_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_media_project_id_b91ac4bd_fk_member_project_id` (`project_id`),
  ADD KEY `member_media_uploaded_by_id_d26ed8dd_fk_member_user_id` (`uploaded_by_id`);

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
  ADD KEY `member_progressreport_project_id_9c0c419e_fk_member_project_id` (`project_id`),
  ADD KEY `member_progressreport_created_by_id_b1f419d5_fk_member_user_id` (`created_by_id`);

--
-- Indexes for table `member_progressupdate`
--
ALTER TABLE `member_progressupdate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_progressupdate_project_id_881833b1_fk_member_project_id` (`project_id`),
  ADD KEY `member_progressupdat_stage_id_f25b3d0b_fk_member_pr` (`stage_id`),
  ADD KEY `member_progressupdate_reported_by_id_fa7a7674_fk_member_user_id` (`reported_by_id`);

--
-- Indexes for table `member_project`
--
ALTER TABLE `member_project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_code` (`reference_code`),
  ADD KEY `member_project_created_by_id_7c1552d2_fk_member_user_id` (`created_by_id`),
  ADD KEY `member_project_category_id_1fedb6ef_fk_member_projectcategory_id` (`category_id`),
  ADD KEY `member_project_district_id_cfa349e8_fk_member_district_id` (`district_id`),
  ADD KEY `member_project_project_division_id_aa8bed68_fk_member_pr` (`project_division_id`);

--
-- Indexes for table `member_projectcategory`
--
ALTER TABLE `member_projectcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectdocument_project_id_5926d0a7_fk_member_project_id` (`project_id`),
  ADD KEY `member_projectdocument_uploaded_by_id_bb3bf02c_fk_member_user_id` (`uploaded_by_id`);

--
-- Indexes for table `member_projectexpense`
--
ALTER TABLE `member_projectexpense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectexpense_project_id_1270713e_fk_member_project_id` (`project_id`),
  ADD KEY `member_projectexpense_recorded_by_id_9520805a_fk_member_user_id` (`recorded_by_id`);

--
-- Indexes for table `member_projectreport`
--
ALTER TABLE `member_projectreport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectreport_project_id_bad07590_fk_member_project_id` (`project_id`),
  ADD KEY `member_projectreport_prepared_by_id_a5ce8371_fk_member_user_id` (`prepared_by_id`);

--
-- Indexes for table `member_projectrisk`
--
ALTER TABLE `member_projectrisk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectrisk_project_id_7970b704_fk_member_project_id` (`project_id`),
  ADD KEY `member_projectrisk_owner_id_6b750a4e_fk_member_user_id` (`owner_id`);

--
-- Indexes for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectstage_project_id_cb598c4c_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_projecttag`
--
ALTER TABLE `member_projecttag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_projectupdate`
--
ALTER TABLE `member_projectupdate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectupdate_project_id_acfbfe5f_fk_member_project_id` (`project_id`),
  ADD KEY `member_projectupdate_posted_by_id_22ea96b4_fk_member_user_id` (`posted_by_id`);

--
-- Indexes for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `member_project_divis_project_type_id_68de0c34_fk_member_pr` (`project_type_id`),
  ADD KEY `member_project_division_head_user_id_9ba7c3ea_fk_member_user_id` (`head_user_id`);

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
-- Indexes for table `member_region`
--
ALTER TABLE `member_region`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_reportissue_project_id_f4f92cf2_fk_member_project_id` (`project_id`),
  ADD KEY `member_reportissue_user_id_8428b576_fk_member_user_id` (`user_id`),
  ADD KEY `member_reportissue_resolved_by_id_d3cf28b8_fk_member_user_id` (`resolved_by_id`);

--
-- Indexes for table `member_stagereport`
--
ALTER TABLE `member_stagereport`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stagereport_project_id_2f86d019_fk_member_project_id` (`project_id`),
  ADD KEY `member_stagereport_stage_id_d929cb5b_fk_member_projectstage_id` (`stage_id`),
  ADD KEY `member_stagereport_reported_by_id_9ec68722_fk_member_user_id` (`reported_by_id`);

--
-- Indexes for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stakeholder_project_id_d5505ab5_fk_member_project_id` (`project_id`);

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
  ADD KEY `member_tender_project_id_eec6df9c_fk_member_project_id` (`project_id`),
  ADD KEY `member_tender_awarded_to_id_c4c311c2_fk_member_contractor_id` (`awarded_to_id`);

--
-- Indexes for table `member_tenderapplication`
--
ALTER TABLE `member_tenderapplication`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_tenderapplication_applicant_id_3915db1a_fk_member_user_id` (`applicant_id`),
  ADD KEY `member_tenderapplication_tender_id_b6b30ec7_fk_member_tender_id` (`tender_id`);

--
-- Indexes for table `member_tenderevaluationcriteria`
--
ALTER TABLE `member_tenderevaluationcriteria`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `member_useractivity`
--
ALTER TABLE `member_useractivity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_userpermissiongroup`
--
ALTER TABLE `member_userpermissiongroup`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `member_aichatmessage`
--
ALTER TABLE `member_aichatmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `member_aichatsession`
--
ALTER TABLE `member_aichatsession`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member_aiissueassessment`
--
ALTER TABLE `member_aiissueassessment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_aiprojectanalysis`
--
ALTER TABLE `member_aiprojectanalysis`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_aireportgeneration`
--
ALTER TABLE `member_aireportgeneration`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_aisearchlog`
--
ALTER TABLE `member_aisearchlog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_announcement`
--
ALTER TABLE `member_announcement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_auditlog`
--
ALTER TABLE `member_auditlog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_budget`
--
ALTER TABLE `member_budget`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_budgetrevision`
--
ALTER TABLE `member_budgetrevision`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `member_contractor`
--
ALTER TABLE `member_contractor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_contractordocument`
--
ALTER TABLE `member_contractordocument`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_district`
--
ALTER TABLE `member_district`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_feedback`
--
ALTER TABLE `member_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_participation`
--
ALTER TABLE `member_participation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `member_projectcategory`
--
ALTER TABLE `member_projectcategory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectexpense`
--
ALTER TABLE `member_projectexpense`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_projecttag`
--
ALTER TABLE `member_projecttag`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `member_region`
--
ALTER TABLE `member_region`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `member_tender`
--
ALTER TABLE `member_tender`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_tenderapplication`
--
ALTER TABLE `member_tenderapplication`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_tenderevaluationcriteria`
--
ALTER TABLE `member_tenderevaluationcriteria`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `member_useractivity`
--
ALTER TABLE `member_useractivity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_userpermissiongroup`
--
ALTER TABLE `member_userpermissiongroup`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
-- Constraints for table `member_aichatmessage`
--
ALTER TABLE `member_aichatmessage`
  ADD CONSTRAINT `member_aichatmessage_session_id_cfccf3e1_fk_member_ai` FOREIGN KEY (`session_id`) REFERENCES `member_aichatsession` (`id`);

--
-- Constraints for table `member_aichatsession`
--
ALTER TABLE `member_aichatsession`
  ADD CONSTRAINT `member_aichatsession_user_id_351ab447_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_aiissueassessment`
--
ALTER TABLE `member_aiissueassessment`
  ADD CONSTRAINT `member_aiissueassess_issue_id_f8efd15a_fk_member_re` FOREIGN KEY (`issue_id`) REFERENCES `member_reportissue` (`id`),
  ADD CONSTRAINT `member_aiissueassess_reviewed_by_id_6409d7ad_fk_member_us` FOREIGN KEY (`reviewed_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_announcement`
--
ALTER TABLE `member_announcement`
  ADD CONSTRAINT `member_announcement_created_by_id_0c5ba019_fk_member_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_citizenevidence_user_id_afa2e230_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_citizenevidence_verified_by_id_5a754207_fk_member_user_id` FOREIGN KEY (`verified_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_citizensubmission`
--
ALTER TABLE `member_citizensubmission`
  ADD CONSTRAINT `member_citizensubmis_project_id_f79857c0_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_citizensubmission_user_id_abd57c8e_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_comment`
--
ALTER TABLE `member_comment`
  ADD CONSTRAINT `member_comment_parent_id_ffa34bef_fk_member_comment_id` FOREIGN KEY (`parent_id`) REFERENCES `member_comment` (`id`),
  ADD CONSTRAINT `member_comment_project_id_3fa8114d_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_comment_user_id_51d0677f_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  ADD CONSTRAINT `fk_contractor_rating_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_contractorrating_rated_by_id_a6b6aa3c_fk_member_user_id` FOREIGN KEY (`rated_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_feedback`
--
ALTER TABLE `member_feedback`
  ADD CONSTRAINT `member_feedback_project_id_716ce9e3_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_governmentrequest`
--
ALTER TABLE `member_governmentrequest`
  ADD CONSTRAINT `member_governmentreq_assigned_to_id_92671ada_fk_member_us` FOREIGN KEY (`assigned_to_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_governmentreq_responded_by_id_23c9c32c_fk_member_us` FOREIGN KEY (`responded_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_governmentrequest_citizen_id_0e8ec8f8_fk_member_user_id` FOREIGN KEY (`citizen_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_media`
--
ALTER TABLE `member_media`
  ADD CONSTRAINT `member_media_project_id_b91ac4bd_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_media_uploaded_by_id_d26ed8dd_fk_member_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_progressreport_created_by_id_b1f419d5_fk_member_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_progressreport_project_id_9c0c419e_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_progressupdate`
--
ALTER TABLE `member_progressupdate`
  ADD CONSTRAINT `member_progressupdat_stage_id_f25b3d0b_fk_member_pr` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`),
  ADD CONSTRAINT `member_progressupdate_project_id_881833b1_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_progressupdate_reported_by_id_fa7a7674_fk_member_user_id` FOREIGN KEY (`reported_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_project`
--
ALTER TABLE `member_project`
  ADD CONSTRAINT `member_project_category_id_1fedb6ef_fk_member_projectcategory_id` FOREIGN KEY (`category_id`) REFERENCES `member_projectcategory` (`id`),
  ADD CONSTRAINT `member_project_created_by_id_7c1552d2_fk_member_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_project_district_id_cfa349e8_fk_member_district_id` FOREIGN KEY (`district_id`) REFERENCES `member_district` (`id`),
  ADD CONSTRAINT `member_project_project_division_id_aa8bed68_fk_member_pr` FOREIGN KEY (`project_division_id`) REFERENCES `member_project_division` (`id`);

--
-- Constraints for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  ADD CONSTRAINT `member_projectdocument_project_id_5926d0a7_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_projectdocument_uploaded_by_id_bb3bf02c_fk_member_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_projectexpense`
--
ALTER TABLE `member_projectexpense`
  ADD CONSTRAINT `member_projectexpense_project_id_1270713e_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_projectexpense_recorded_by_id_9520805a_fk_member_user_id` FOREIGN KEY (`recorded_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_projectreport`
--
ALTER TABLE `member_projectreport`
  ADD CONSTRAINT `member_projectreport_prepared_by_id_a5ce8371_fk_member_user_id` FOREIGN KEY (`prepared_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_projectreport_project_id_bad07590_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectrisk`
--
ALTER TABLE `member_projectrisk`
  ADD CONSTRAINT `member_projectrisk_owner_id_6b750a4e_fk_member_user_id` FOREIGN KEY (`owner_id`) REFERENCES `member_user` (`id`),
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
  ADD CONSTRAINT `member_projectupdate_posted_by_id_22ea96b4_fk_member_user_id` FOREIGN KEY (`posted_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_projectupdate_project_id_acfbfe5f_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD CONSTRAINT `member_project_divis_project_type_id_68de0c34_fk_member_pr` FOREIGN KEY (`project_type_id`) REFERENCES `member_project_type` (`id`),
  ADD CONSTRAINT `member_project_division_head_user_id_9ba7c3ea_fk_member_user_id` FOREIGN KEY (`head_user_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_reportissue_resolved_by_id_d3cf28b8_fk_member_user_id` FOREIGN KEY (`resolved_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_reportissue_user_id_8428b576_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_stagereport`
--
ALTER TABLE `member_stagereport`
  ADD CONSTRAINT `member_stagereport_project_id_2f86d019_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_stagereport_reported_by_id_9ec68722_fk_member_user_id` FOREIGN KEY (`reported_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_stagereport_stage_id_d929cb5b_fk_member_projectstage_id` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`);

--
-- Constraints for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  ADD CONSTRAINT `member_stakeholder_project_id_d5505ab5_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_tender`
--
ALTER TABLE `member_tender`
  ADD CONSTRAINT `member_tender_awarded_to_id_c4c311c2_fk_member_contractor_id` FOREIGN KEY (`awarded_to_id`) REFERENCES `member_contractor` (`id`),
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
