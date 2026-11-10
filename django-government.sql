-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2026 at 06:17 AM
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
(236, 'Can view ai project analysis', 59, 'view_aiprojectanalysis'),
(237, 'Can add contractor_projects', 60, 'add_contractor_projects'),
(238, 'Can change contractor_projects', 60, 'change_contractor_projects'),
(239, 'Can delete contractor_projects', 60, 'delete_contractor_projects'),
(240, 'Can view contractor_projects', 60, 'view_contractor_projects'),
(241, 'Can add ai finding', 61, 'add_aifinding'),
(242, 'Can change ai finding', 61, 'change_aifinding'),
(243, 'Can delete ai finding', 61, 'delete_aifinding'),
(244, 'Can view ai finding', 61, 'view_aifinding'),
(245, 'Can add ai engine run', 62, 'add_aienginerun'),
(246, 'Can change ai engine run', 62, 'change_aienginerun'),
(247, 'Can delete ai engine run', 62, 'delete_aienginerun'),
(248, 'Can view ai engine run', 62, 'view_aienginerun'),
(249, 'Can add discussion topic', 63, 'add_discussiontopic'),
(250, 'Can change discussion topic', 63, 'change_discussiontopic'),
(251, 'Can delete discussion topic', 63, 'delete_discussiontopic'),
(252, 'Can view discussion topic', 63, 'view_discussiontopic'),
(253, 'Can add discussion reply', 64, 'add_discussionreply'),
(254, 'Can change discussion reply', 64, 'change_discussionreply'),
(255, 'Can delete discussion reply', 64, 'delete_discussionreply'),
(256, 'Can view discussion reply', 64, 'view_discussionreply'),
(257, 'Can add stage report image', 65, 'add_stagereportimage'),
(258, 'Can change stage report image', 65, 'change_stagereportimage'),
(259, 'Can delete stage report image', 65, 'delete_stagereportimage'),
(260, 'Can view stage report image', 65, 'view_stagereportimage'),
(261, 'Can add milestone stage evidence', 66, 'add_milestonestageevidence'),
(262, 'Can change milestone stage evidence', 66, 'change_milestonestageevidence'),
(263, 'Can delete milestone stage evidence', 66, 'delete_milestonestageevidence'),
(264, 'Can view milestone stage evidence', 66, 'view_milestonestageevidence'),
(265, 'Can add project status history', 67, 'add_projectstatushistory'),
(266, 'Can change project status history', 67, 'change_projectstatushistory'),
(267, 'Can delete project status history', 67, 'delete_projectstatushistory'),
(268, 'Can view project status history', 67, 'view_projectstatushistory'),
(269, 'Can add stage report attachment', 68, 'add_stagereportattachment'),
(270, 'Can change stage report attachment', 68, 'change_stagereportattachment'),
(271, 'Can delete stage report attachment', 68, 'delete_stagereportattachment'),
(272, 'Can view stage report attachment', 68, 'view_stagereportattachment'),
(273, 'Can add contractor payment request', 69, 'add_contractorpaymentrequest'),
(274, 'Can change contractor payment request', 69, 'change_contractorpaymentrequest'),
(275, 'Can delete contractor payment request', 69, 'delete_contractorpaymentrequest'),
(276, 'Can view contractor payment request', 69, 'view_contractorpaymentrequest'),
(277, 'Can add evidence response', 70, 'add_evidenceresponse'),
(278, 'Can change evidence response', 70, 'change_evidenceresponse'),
(279, 'Can delete evidence response', 70, 'delete_evidenceresponse'),
(280, 'Can view evidence response', 70, 'view_evidenceresponse');

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
(62, 'member', 'aienginerun'),
(61, 'member', 'aifinding'),
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
(69, 'member', 'contractorpaymentrequest'),
(36, 'member', 'contractorrating'),
(60, 'member', 'contractor_projects'),
(64, 'member', 'discussionreply'),
(63, 'member', 'discussiontopic'),
(48, 'member', 'district'),
(70, 'member', 'evidenceresponse'),
(10, 'member', 'feedback'),
(43, 'member', 'governmentrequest'),
(35, 'member', 'media'),
(34, 'member', 'milestone'),
(66, 'member', 'milestonestageevidence'),
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
(67, 'member', 'projectstatushistory'),
(54, 'member', 'projecttag'),
(21, 'member', 'projectupdate'),
(26, 'member', 'project_division'),
(25, 'member', 'project_type'),
(50, 'member', 'region'),
(20, 'member', 'reportissue'),
(19, 'member', 'stagereport'),
(68, 'member', 'stagereportattachment'),
(65, 'member', 'stagereportimage'),
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
(55, 'member', '0004_alter_governmentrequest_options_and_more', '2026-08-20 05:05:58.731783'),
(56, 'member', '0005_alter_project_project_status', '2026-08-21 07:03:42.941935'),
(57, 'member', '0006_contractor_projects', '2026-08-22 07:36:47.618400'),
(58, 'member', '0007_citizenevidence_category_citizenevidence_coordinates_and_more', '2026-09-01 05:08:22.390326'),
(59, 'member', '0008_restore_contractor_projects', '2026-09-04 11:25:59.502362'),
(60, 'member', '0009_restore_contractorrating_contractor', '2026-09-04 11:29:35.399712'),
(61, 'member', '0010_restore_stagereport_contractor', '2026-09-04 11:38:05.617803'),
(62, 'member', '0011_alter_aichatmessage_feedback_and_more', '2026-09-16 16:09:59.536482'),
(63, 'member', '0012_alter_aichatmessage_feedback_and_more', '2026-09-16 16:09:59.776642'),
(64, 'member', '0013_alter_aiissueassessment_model_and_more', '2026-09-16 16:10:00.347848'),
(65, 'member', '0014_community_discussion', '2026-09-18 00:25:14.765400'),
(66, 'member', '0015_remove_discussionreply_email_and_more', '2026-09-18 00:31:25.698926'),
(67, 'member', '0016_projectstage_completed_on_projectstage_status_and_more', '2026-09-23 17:28:37.547781'),
(68, 'member', '0017_alter_notification_notification_type', '2026-09-24 08:46:29.481541'),
(69, 'member', '0018_stagereport_stage_description_and_more', '2026-09-25 06:02:25.310266'),
(70, 'member', '0019_alter_user_email_milestonestageevidence', '2026-09-27 07:18:39.348982'),
(71, 'member', '0020_projectstatushistory', '2026-09-27 07:18:39.590639'),
(72, 'member', '0021_alter_projectstage_stage_name', '2026-10-05 17:48:16.905086'),
(73, 'member', '0022_contractor_dashboard_workflows', '2026-10-16 07:10:50.530269'),
(74, 'member', '0023_contractor_notifications', '2026-10-16 07:10:51.168650'),
(75, 'member', '0024_milestone_verification_comments_and_more', '2026-10-16 07:10:52.082537'),
(76, 'member', '0025_remove_citizenevidence_image_and_more', '2026-10-18 08:23:05.390065'),
(77, 'member', '0026_evidenceresponse', '2026-10-18 12:24:20.820992'),
(78, 'member', '0027_citizenevidence_agreed_at_and_more', '2026-10-18 14:26:47.032407');

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
('0kaviozxfh12v0ux92jzdwemwkegvrlt', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2SFS:RLhhGSYz5EK-AQVKvbyCervHygDWeBrHh23wKYqNg7s', '2026-09-18 11:38:22.553710'),
('0y38udb061r667efrjos06s1q6uwk3pi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZm1:nA7NA2c5qLh9zWMB6F_LEIkkKGw-Vt4AVRi60sao8bw', '2026-09-02 06:27:41.250488'),
('12aq1bboj3oo2qnghtbpfbfl76wwf4y9', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1xAM3v:Sm-kbfsmVVJNUBWtlLIud2a5a52rTn_X-UbHXW5QsPY', '2026-10-10 06:39:07.972205'),
('13rc1o2gyneg0mtf4gugknw1yoxa7y5o', '.eJxVjLsOwjAMAP_FM4rywCHpyM43VI7jkgJKpKadEP-OKnWA9e50bxhpW8u4dVnGOcMA1sPpFybip9Td5AfVe1Pc6rrMSe2JOmxXt5bldT3av0GhXmCAIFpHsZgceeNs5IzZWBGL7uxCnAwRo0t60j5qRgmEEiJfDDJh4gSfL_vUOCw:1wHbRO:LGNacgZMl7vjw_49bEdGhZ8Oa5c6e-iojCNxm55ELmU', '2026-05-12 05:57:02.230908'),
('1761rq5hfgqepwaiksd79qz71dt8ov84', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x9zW4:yFrH2qaOmZXiUcu7jVcntkYQTyEv-ylFfYhVcc_In90', '2026-10-09 06:34:40.706451'),
('1gi6y4xeflxim6fq6s4emj60al68j0ne', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdpj:l1HlU0aO0NzSD8nrEdodYnvYk_A7YEmOeHWggbu7-fY', '2026-08-16 21:34:59.877056'),
('1ptraz794ipt6kj6ej6ub8mkvw1jc3y9', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9gU4:67t3A1VyGBwjBLtCzPLORD-vGn76wrOwtXo-__0ESLU', '2026-10-08 10:15:20.964425'),
('2amalhbt6dzcywve3nij1tew3a3u75ju', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1xAMQr:B2Pu5IrMDeNwGm5ij2qELXang5m4amkcgxzdMMaf7p0', '2026-10-10 07:02:49.431230'),
('2hxwzypya56s01ktnw67koepi5kockd2', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pAw:4WvwP2GzNbt5ioCnLoYk4Mfu4ziMPxglLwomyXrZDZ0', '2026-10-03 07:07:54.725365'),
('36bagywf7huhhlwaxws76y9dtrwgjzi1', '.eJxVjDsOAiEUAO9CbQj_gKW9ZyDv8UBWDSTLbrXx7oZkC21nJnOwCPtW4z7yGhdiV2YMu_xChPTKbRp6Qnt0nnrb1gX5TPhpB793yu_b2f4NKow6v0l7FKBLcdmobLwMDouQtmhjXSqSMlnvCYJWkILFgFobJZRDCl449vkCDjM33w:1xC01e:P9oeFDYis3_vwWja4nTmf-_dCNM-_D4sokvargOYRDM', '2026-10-14 19:31:34.564223'),
('3wjbq12lcg8a36ht6qfqsd2sdjixlufg', '.eJxVjDEOgzAMAP_iuYqS2IHA2L1vQE5sGtoKJAJT1b9XSAztene6Nwy8b2XYq67DJNADBbj8wsT5qfNh5MHzfTF5mbd1SuZIzGmruS2ir-vZ_g0K1wI9jJY1eOetReRIDXl0alU6n1xEIuxGtZoocxZEiS35MaDDYJuEklr4fAHpUDdY:1xC023:kjOB-KSH_KIzw9-ZCUQ88NPDE4g21RNonZDsQrCdLcY', '2026-10-14 19:31:59.275518'),
('47rel4moxyndo69ep7yukfs2qmgsbar1', '.eJxVjEsOwiAUAO_C2pDHv7h03zOQBw-kamhS2pXx7oakC93OTObNAh57DUfPW1iIXZkCdvmFEdMzt2Hoge2-8rS2fVsiHwk_befzSvl1O9u_QcVex5cQbBZCC6OSK1bJSRckIxw4ZYv0XvgEhcBoklaT9ZOGiMaB1KRsZp8v3uY24A:1xHf3g:rYbvQeEYH1fWngG2Dds9rp6DdE1IPYwkC7ErAbEYnGY', '2026-10-30 10:21:04.012728'),
('4chryz93qoagvismdkd5tjb8ses0l3b3', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2lub:Bh4m9oz2bokqxllcNS_HHWiaflRI99N64nq0JBunFlM', '2026-09-19 08:38:09.762616'),
('4dnbieymj8lwx2bl75jh2luu6pyvsdla', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqcVi:8cBY20g_9b8HEeZBBP46a-A4qaVPLJ3OmE4uTDyQzbQ', '2026-08-16 20:10:14.904835'),
('55yu2xknap4xgqcbprn8g36epsxolvp0', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pEt:Wqx4jEBerr42DixFs6djQzmPvEItMbW9nnSElsX7V-4', '2026-10-03 07:11:59.649352'),
('5fw5ixcycdop9jkekqb8nr6s5jonvyoc', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9fby:v-vt8PjK9UhYwpuOzmf0tGFiBXGi8T521TKvcdzTz48', '2026-10-08 09:19:26.745163'),
('5odu0rerf6ffzpymq1ew9rwn25lde97u', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9g5B:7Z_JhS7CjeFzRiNP2IVLzDioeEdWDrMiLvKfFxwRt_k', '2026-10-08 09:49:37.506948'),
('5q6p769hrbhyh7esawk3q9d82v3b68g3', '.eJxVjMsOwiAQAP9lz4aUp2yP3vsNBNitVA0kpT0Z_9006UGvM5N5Q4j7VsLeeQ0LwQgKLr8sxfzkegh6xHpvIre6rUsSRyJO28XUiF-3s_0blNgLjIDJESnLzFKyZVYojUNpaZhTQjc7Y7y23qLiPHhil686Zp1QkTcaI3y-7OE37g:1wH5cP:Qw_bs23tzMx--7FMW7or8ZXZTIVFrmMeCNJRrKxhoCo', '2026-05-10 19:58:17.264025'),
('5rjty9cs0fibl6zuhpjeuwgj4l0t16kx', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9gCr:DlTTyrAiLJzYdG9PoVpxLe7tckMC8Y4VmA_5mnwmen8', '2026-10-08 09:57:33.310570'),
('5wjnrvh158xnfc2gub05u81odqrrsn1y', '.eJxVjDEOgzAMAP_iuYpiCAQYu_cNyHbshrYCicBU9e8VEkO73p3uDSPtWx73ous4JRggtHD5hUzy1Pkw6UHzfXGyzNs6sTsSd9ribkvS1_Vs_waZSoYBIrGYEGpEb522lXmWKphaaBCtlkQcq165qZvWAvUcMWCgDr0o9gifLzuiOLY:1xC01x:x-a_SyT5T3wUGS7gtJUhI6BgyPZ_kWtn54hLR9qYFWM', '2026-10-14 19:31:53.875042'),
('6ede6lc014tq1scbze0mtr7ufqnmetp3', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqe2v:0YkJhL7ye5CmKJPPy_IXLgpS_96eHBOpzXQbKGs7Nac', '2026-08-16 21:48:37.541021'),
('7a9gou1q5w5jlnch0tkxoizp3212oqn7', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x9Qw1:oPwfo-46UjZAhGwjHmJQ-6wrMNG533Nenyctn1BoSzY', '2026-10-07 17:39:09.060231'),
('7c8t9vnrpokvbo3tg72q54sci3yxw151', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZFv:p51IMIFv7seIXWaqVP4_tNwd4BSpHeP7Nx7NrvSy2Nw', '2026-09-02 05:54:31.534711'),
('825z0zzzx3h5luxvpbka5kubwquysl7a', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2kuC:qpQAqySrIKny6xtNJNUb6Vi0huT8jk8naGi5vIrtQjs', '2026-09-19 07:33:40.222540'),
('973u7oel3kzmeeehhi208dj1785rd6a4', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqe2H:e11C-lHallrBgr6ZX3KUPr8LYg_uBMZKP5cmzsGP4CY', '2026-08-16 21:47:57.868496'),
('9788vj1s9pzud7ze0p45uonhly2brmzi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZFZ:F0j0V51sfbZ0Y20WC2Rr7zsvSu5Wzn391M3k01Sn1rw', '2026-09-02 05:54:09.156151'),
('9lej5bly96vbj0cukqe3aoo0fljrssxm', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZl8:lHq7btVRaQ0zLnpYIrbHRwiF1GWvuN-C2kWTB4JdriE', '2026-09-02 06:26:46.826734'),
('9wum3rydvwbjr0wozu89qm7jh84kjzdh', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZUe:schSqkiWN9V7v_jOIC-Czn9zv-ghkzzp42-6OwyYeFo', '2026-09-02 06:09:44.739461'),
('anrzgryp5s60crr2ydh2rlmfup6j9to0', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdeh:3453TIh0v30gouuE1KVMXSRAPAi6sCQx7oZ5VEBvhME', '2026-08-16 21:23:35.994239'),
('apkdanvslg6nx6ewas6ocm48foqsxkoi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZO0:Vzd8alfWmA0z3wNrrHMiH_eRkGVLRjhUtfblL9VHGEU', '2026-09-02 06:02:52.008062'),
('blq8k6sk00cy6gzja1pvdqrbqus2taok', '.eJxVjMsKgzAQAP9lzyUkrpHVY-_9BtlH0tgWBaOn0n8vgof2OjPMG0betzLuNa3jZDBAE-HyC4X1mebD2IPn--J0mbd1Enck7rTV3RZLr-vZ_g0K1wIDqHjvpYs9RcKUI2Ev5hFDJrOu9STUE-XkNWHWoJgZpQ2BGZvWVOHzBQErOF8:1xIK3z:yaK5c97RqRRYOCnm_JhOAltjxcxvxCvzg5nHtvskqLw', '2026-11-01 06:08:07.686104'),
('bt62l6jflu9rac2wbujwx05h60jyimui', 'e30:1wpeNf:stQFfT0Dh5Bnqoa6LcoIL0g0wXuiqEV5jxNQinAkrso', '2026-08-14 03:57:55.913119'),
('bx9mzl8hmd6mwn946m9bf8zzbc4wx1yf', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wcRhm:i2IVeyEWWXm0NH6ysD9HwEGWWTD0XEUZUz_aLA8FCNY', '2026-07-08 17:48:06.015856'),
('c1wzhu1onal52usqs6ka19kl20hwgjj5', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdeY:B_rnwsCtXDyX_Ozxz-4z5PtLwLq7sieNfmpddB3aFHc', '2026-08-16 21:23:26.496860'),
('c8nmnymo2aqdbpbt0tz9ri6z9c1i2dmo', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9HM5:j4NISSTnizEWgnMxrLT_nLNz1x-8lCdMexrkKcJk1Mc', '2026-10-07 07:25:25.888612'),
('cayoi7buh1lg74l8czbqhbp7p4oysocl', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pBr:TO_pJ0ueJGRzwCeim1a1u0Syo_czNN13Hr5OSOwAQUM', '2026-10-03 07:08:51.150123'),
('ch33yz5ehqhegax2n3ic0v77wer1189x', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x9Qrc:90VOTND1n5lEKglvWB9dqUlWl626ONMZB-HMuSktXVY', '2026-10-07 17:34:36.674730'),
('d2kf9vb224zjekrsmy9g8qpr642k9fmg', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2XER:nsvrHXDaEewRPWFshplmne4QgOHViwVI0UWgWbB3Phc', '2026-09-18 16:57:39.473940'),
('dhia3jz5wuup0k5pm7vjfuyxxb65su5v', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pSx:kxspZiSmcuSkBtgQjA9pGRD0MHrZAlRshdVYjfBp8Ak', '2026-10-03 07:26:31.716536'),
('diwqtbltl6wi74chcf93ttqwpgjn8knb', '.eJxVjMsOwiAQAP-FsyEsjwIevfsNzbKsUjWQlPZk_HdD0oNeZybzFjPuW5n3zuu8ZHEWBsTpFyakJ9dh8gPrvUlqdVuXJEciD9vltWV-XY72b1Cwl_G9RXRMiBmMVimqKQP7YMmGpDAEjd6D92CtIwcasiPlaTJahWgCk_h8Af5rNzs:1xDvno:ceSi5dMX82PfIs2RaKlI0icwjAi2ufe7lGRJJ1LAqtg', '2026-10-20 03:25:16.910544'),
('e3zkbfoq0y5aarmoqn3pgknxey923l51', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pA7:3xgE_gnFtK9de91siSX_euMBjAAEPfXc7FMjX9GrYFw', '2026-10-03 07:07:03.701316'),
('e4mrvqdoq737xqufy9wtax58mt70e1y6', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2Vm8:TGAp6PdFbMq_1oCOWPKW2NVjHYhzqE8cenR_JhFw3ww', '2026-09-18 15:24:20.573916'),
('etlpl9bolg9udifv8izktz4vxkrsjj52', '.eJxVjMsOwiAQAP9lz4bAQgV69N5vaGCXtVUDSR8n47-bJj3odWYybxjTvk3jvpZlnBl6cAiXX5gTPUs9DD9SvTdFrW7LnNWRqNOuamhcXrez_RtMaZ2gh87GjIE9GenEJdTOdCSGUERbQikh0pV1LIihUBBtfXCSRbRhRu_h8wUQEThv:1xC01e:mLi97_UpTFPWEai7ny7d8MqoFsUHoUF1UFMOahPGc9c', '2026-10-14 19:31:34.660619'),
('f400vjkos7v9s3ve68al7p658c4b9g9s', '.eJxVjDEKwzAMAP-iuRjj2IqTsXvfYCRZbtKWBOJkKv17MWRo17vj3pDo2Kd0VN3SnGEE38HlFzLJU5dm8oOW-2pkXfZtZtMSc9pqbmvW1_Vs_wYT1QlGcBJDlCLseGCr3nfOIwnHiH3UBggDWiwu0oDelRLEDrnYLmivgeHzBQvAOBg:1xC01X:kWLrRkHp3xpQOGk7juhmyXWVj9JWN4t1j4JJpP2ghqo', '2026-10-14 19:31:27.540488'),
('fbxruaruso2v1lkj7z96rykrrrsx09pq', '.eJxVjMsOwiAQAP-FsyEsjwIevfsNzbKsUjWQlPZk_HdD0oNeZybzFjPuW5n3zuu8ZHEWBsTpFyakJ9dh8gPrvUlqdVuXJEciD9vltWV-XY72b1Cwl_G9RXRMiBmMVimqKQP7YMmGpDAEjd6D92CtIwcasiPlaTJahWgCk_h8Af5rNzs:1x9zL1:EQrqeGnwJec7FYLCvs0DXbDwhookanFNwUMToQPoOtA', '2026-10-09 06:23:15.481828'),
('fv35ifqzvht2b1dphixlkvtca1rne47a', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2aBA:RyTvD7TWv5f4aeP_nxRZCKN2k2dw87qgrlC96Efho3s', '2026-09-18 20:06:28.499742'),
('g8mm58it4xoy97giqk6ihvuyhxz14ywv', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pCq:x-qGvsXVsssQT_P61ASi0eeG0gTijgD6_9Ok9gRvby4', '2026-10-03 07:09:52.302698'),
('gnfp5g8pijj2tw9ekziyucrt80ruythj', '.eJxVjEEOwiAQAP-yZ0NgoRR79N43kAUWqRpISnsy_t006UGvM5N5g6d9K37vvPolwQRGweUXBopProdJD6r3JmKr27oEcSTitF3MLfHrdrZ_g0K9wARRYVbEmbJkti5FaxTqFAgzE0lURkZNA6HO7FBZdmGU7iol6dGiGeDzBTJ-OD4:1xAjM4:4pLIGo2mIe4fBATNfEMR6S7Oq5waEbhVJDuZLosHioM', '2026-10-11 07:31:24.511077'),
('gsef1bmupor5xw670mdq17iybtfguqpv', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdf4:0ncBQepBlDgo_IKh8NiDVw9SCkfVK27_LqkvzW89gmo', '2026-08-16 21:23:58.145761'),
('hkt54z1iwy5s6go2lu15iq01056kvatl', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2WtQ:zcc51fmwC4qBXhyj2LvOfY5KXYGcZCYO1vSJS2-xlMY', '2026-09-18 16:35:56.766694'),
('hunyzegqao0805c5nhk0btxzy2pbgimx', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2aAl:1JhjJYzQn_c3JKd0gVmhDXK1JByhZGx7X0E9cKdMnK8', '2026-09-18 20:06:03.002297'),
('iqdase4avwedjnurqx6f6k703hs24whh', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9g8i:TFgyyYTawhq0wAgMuc6Vtj08mN7reqzSISgEPcTazfw', '2026-10-08 09:53:16.730947'),
('jg3tgliztbqqhi98w4hg3vexfgs593j2', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1xAM49:xiA3I2VkDUyefxccXwQejOGJIu5ZPPyb9eC4Rl_FkV8', '2026-10-10 06:39:21.344650'),
('jhuslio9ua21bqexbzgurjzirxzh52eu', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2a4n:G7VNQcu26-pjmpe2Ce94D4w8JyIhbypDF11KpIhCGeY', '2026-09-18 19:59:53.743641'),
('jzp7dpu01tmkuhds97j41tnl0prgxutc', '.eJxVjDEOgzAMAP_iuYqcENOEsTtvQLHjFNoKJAJT1b9XSAztene6Nwxp38Zhr7oOU4YO_BUuv5CTPHU-TH6k-b4YWeZtndgciTltNf2S9XU727_BmOoIHWBhdNg6jUnFijSu2Mg2cyqOVD0SEmHbBM6FQiDBxgl651lzpDbC5wsVETf0:1xC023:zkUhbXxImd0VM_yRCF0xk0aCu3tgnufVh2cr224gzkY', '2026-10-14 19:31:59.242787'),
('k3nk63mldbodkjdv5of2gjbkfubzrnse', '.eJxVjMsOwiAQAP-FsyEsjwIevfsNzbKsUjWQlPZk_HdD0oNeZybzFjPuW5n3zuu8ZHEWBsTpFyakJ9dh8gPrvUlqdVuXJEciD9vltWV-XY72b1Cwl_G9RXRMiBmMVimqKQP7YMmGpDAEjd6D92CtIwcasiPlaTJahWgCk_h8Af5rNzs:1x9zW0:TP_jDhPGwAIoRyI-4GaGEbyXINUj61lVuOwzdX8MLnU', '2026-10-09 06:34:36.016821'),
('lix6axy51mvaar1a90piulf8b79cjoyz', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9gV3:PljScDmiXlqurgKK1gCjf_y781E2_ZIipLDJeggtUmc', '2026-10-08 10:16:21.296922'),
('lj4x0otrlw2jsatfnzyhwaliwp6vaatn', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWVjy:F1Q_e2DpAIoXRbbyq1kwQnBa0A4Zoxpd6oySv3tlmyY', '2026-06-22 08:53:50.029226'),
('mr8kc7bnx5t6vdczb87ghkofitfgs9p1', '.eJxVjMsOwiAQAP9lz4bQpWWhR-9-Q8OyIFUDSR8n47-bJj3odWYyb5jCvpVpX9MyzQIjGA-XX8ghPlM9jDxCvTcVW92WmdWRqNOu6tYkva5n-zcoYS0wguNOR5cpsaBgxl47Sl7YaaLOI3aaB69dbzFYTTI4yz4aw30cCE3O8PkC-Zw3VQ:1xAjKO:uyVMdS7cGZP6YWkP0jqmj0klWkOC5RI8gou7dNEGVfI', '2026-10-11 07:29:40.577574'),
('mwpa29g3toprc2agqu1fha32vjo71aut', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9HLM:gUqzXYBfNGbzVo1lLHYoETpJ4HAYJkUZ4QsRmOohQB0', '2026-10-07 07:24:40.515135'),
('n6f89setqq02t3pot4f14odqd0qdv3pv', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7p0p:G5nnzwdn4wUNU9Iw4DrP2LWlqNtpADeyYlhatcqXsG4', '2026-10-03 06:57:27.580274'),
('oc9fl01kbez8tu74oj0dc7qtxnn84dy3', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdnt:CvFkkTcstS4KW4lKNR2ixX3ZH-z3TLquLFScvfQKQNE', '2026-08-16 21:33:05.870138'),
('odbty7i4iqr4hkz5i6pnderkqh61vtt5', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdqF:MC3ASmlRDC3bVcvT_7E7dehLmxUBXT5fJ4VRG2Y3BHY', '2026-08-16 21:35:31.237470'),
('ohlymii1ijxvo9y5nxx483hj7am24d9l', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x9Qrt:U33L3bg2gczS-1wb9fUpad5czGrQgKYdYl3cdbs2KX4', '2026-10-07 17:34:53.924204'),
('ojnovp86l18dr3ghiygi4s7bx2r0wj83', '.eJxVjEEOwiAQAP-yZ0MKZYH26N03kIUFqRpISnsy_t006UGvM5N5g6d9K37vafULwwwSLr8sUHymegh-UL03EVvd1iWIIxGn7eLWOL2uZ_s3KNQLzGApWKmsy8rlacyDSWhGxahJG7ZDnDBozCqhZIvZIikpQ2AdnaZREsLnC84hN3I:1wGxWF:1uXwrAfLoeLh_dUFDU61Qr_uLhtqWslXqp3weNnNdro', '2026-05-10 11:19:23.081924'),
('oteepgwgeknhs5ymdtgp5sccevtdu4dy', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWsFm:dTpaW2sNHwAtoX3Z_VVwxrl-_ulcTZozkYPqg4dWPUs', '2026-06-23 08:56:10.831602'),
('pgfb0k1i75jxptb409cgg7erz35ol2cn', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7p0b:zXYctLU08OyOah_H40GQztFMszZaqHVFH2p-OCTm0bk', '2026-10-03 06:57:13.176559'),
('pkn9jch5jerrsnap26exvwv6oqjvoo63', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdko:s_eUfUBef8Q4P8FD0JecPIXIRwybm2hmrsmULHxRZtA', '2026-08-16 21:29:54.104784'),
('pt6wmwf306y5weg1ayd2qumt3cod61yi', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdmb:MXiDWXnVnDiTj4N5Omxv7NConT9btkbFoV6CEjhQ5XQ', '2026-08-16 21:31:45.605939'),
('qbnnxmj7wtnmfk32ameg290jckvtki92', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqcW6:pDqWT9bEw5bRf1nS5HP0CLeLFlw2Kq6suZ6LuZZBxls', '2026-08-16 20:10:38.534387'),
('qclz3l0agn7x7cvre48wracmrnz9uw1g', '.eJxVjMsOgjAQAP9lz6bpY9siR-98A9lttxY1kFA4Gf_dkHDQ68xk3jDSvtVxb7KOU4YeDFx-GVN6ynyI_KD5vqi0zNs6sToSddqmhiXL63a2f4NKrUIP4WqZUQoJYihRe7FCni266Axpg9EmS4TRidjOaWRvUgiCnNEV08HnC9-oN4o:1wWvcg:nmDSvfzeoLXxRAE-ovOecU1jEgogjWUx6J0tUvYmyqs', '2026-06-23 12:32:02.873818'),
('qel6kcgg9m42tbley5nr4jj7gksydow8', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9QOg:uohMzV7J28rxjDYV55RI7JUhtzglzFHK89mm6ISMalY', '2026-10-07 17:04:42.266088'),
('qmuxv5oyq66ppbvqgv6r7q5wfqsqd09k', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9fcG:N-ogCBMEhI-oFJQ5vUuQ6i5uCcsBUNKgoX_bT3xD63Q', '2026-10-08 09:19:44.278769'),
('qwc44x29divmfrmjb54urs14af3a3hvu', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2luw:yosnHYZvNqnr8ASxuaCulicwchHoivJtWPrlII4EDWE', '2026-09-19 08:38:30.024004'),
('r9jwzam2gmfsa9h3uw10o18z9sbiib87', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2XAf:TvT5i4Y9D_vmPhz95GMVkzS4XenlOGfAMV71xNYm-Uk', '2026-09-18 16:53:45.449760'),
('ri0kgcu9xv3ifhnv9ch5iaojihem3j1c', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pMO:phup-iiIKKgqUltv2fNC3cId-DUGDW84uzAcrr4PWgs', '2026-10-03 07:19:44.015402'),
('s0vadcosw9julv9ear7vzocufgeq5w55', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1x2krE:LubhTqv-_aID8HlxlJ3PcmGJTVl_7HMGkBn9s6XeBt8', '2026-09-19 07:30:36.157575'),
('s3fcv6mwkfe52dn3x1v5ov1yu1tfihrp', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pDx:-69f4cffN6hrsaXsHWAl9evkE7MqTuxoBha7pMm7_EI', '2026-10-03 07:11:01.342329'),
('s3xbxvnczjuha98uh6893nklrntd8sj2', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pYZ:2rEkO8ZPU51A36knZ4oyeXxhbU2wfFWPPfSg8cKNkcY', '2026-10-03 07:32:19.014629'),
('sqbo2ahd6y3qralhj8zxa54eo7809lti', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9gEI:JZUhHIF0Lt2k3c3R3LmH_UQLDuEHTSeu4DrXHGvE2b4', '2026-10-08 09:59:02.326315'),
('uilk3vibo3q9xlbcoaqzfcboalypfyw9', '.eJxVjMsOwiAQAP-FsyEsjwIevfsNzbKsUjWQlPZk_HdD0oNeZybzFjPuW5n3zuu8ZHEWBsTpFyakJ9dh8gPrvUlqdVuXJEciD9vltWV-XY72b1Cwl_G9RXRMiBmMVimqKQP7YMmGpDAEjd6D92CtIwcasiPlaTJahWgCk_h8Af5rNzs:1x9zLN:TkQMi1H9EEvCx2EvbHxv2u8O6mKRq5KqyEyrLzrW7Zk', '2026-10-09 06:23:37.393431'),
('ungx23ac97jaxzr48egsxqfpp1q93t39', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wwZGW:ihr2bZBdHNTG-erUOOf1B5oBlWNHqPhpr8qhGlg8xTo', '2026-09-02 05:55:08.201328'),
('v8q8fbhgvmwhzlnnff0719sidxnw78uy', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdtp:l5-lo5YzIWsSOP4YTu8PwQo7bUj3F6SX21P75m3350U', '2026-08-16 21:39:13.357412'),
('vyns2wx6dnek40tm8j6t4m0rezcyiaxh', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9g6h:RinHxxDPZJeHP1hgHmKghrNmNSdIQ0ibH24uAHe7AaM', '2026-10-08 09:51:11.795421'),
('w81swtum7942n93ih1gns7hzdko45svm', '.eJxVjDEOwjAMAP-SGUWhdlKHkZ03VE7s0AJqpaadEH9HkTrAene6txl438Zhr7oOk5iLQWdOvzBxfurcjDx4vi82L_O2Tsm2xB622tsi-roe7d9g5Dq2L5XC2GVCFXahqBOfKWrn--ghxUilYA5ACOSKQt-RYD4jBBbwHMznCxMhN_U:1xAjLc:MejSURU14DNKXelvnN_ykdy0G2n1zp6Lwwy3EmEogvo', '2026-10-11 07:30:56.039385'),
('wtacvbuobsxtj4f8c9qj98u4p3gblcmr', '.eJxVjDEOgzAMAP_iuYoCwU5g7N43IMc2hbYCicBU9e8VEkO73p3uDT3v29jvxdZ-UuigSXD5hZnlafNh9MHzfXGyzNs6ZXck7rTF3Ra11_Vs_wYjlxE6qDSiRw6SxaJmJFZP4kmoppBiskFaTIKWq7ZW8qjUYE1DosA5RIPPFxVqOBg:1xCA5s:VVRFb7qCANoaAi7Unzj50nj9NFVZORc6bOw4OBrAezI', '2026-10-15 06:16:36.138541'),
('ww1yrgz61yf466bxatxqfmuqdqf0a0lu', '.eJxVjMsOgkAMAP-lZ7OBtvuQo3e-gbTbRVADCY-T8d8NCQe9zkzmDZ3s29Dta1m60aAB8nD5hSr5WabD2EOm--zyPG3LqO5I3GlX185WXrez_RsMsg7QQNRcKGrAXkxRa69WiQTk5LGixMQUe4wx5JSr2pj4WjwScc0WCBN8vgamNwg:1x9QO5:hzoaG2RLPhnQonXT5SVqJkvb7wqJCJUmBpCvw2x3A0I', '2026-10-07 17:04:05.432685'),
('xmslh23pc9fp63xbmlrl594qqw1szycy', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1wqdir:60fC9EgTjsRwacceuMUwgKJmoaNKC9DrVpL-2qsqkks', '2026-08-16 21:27:53.239036'),
('z9h4kbgtiv652r0fugkgjtyjqxnh3rmm', '.eJxVjMsOwiAQAP-FsyEsjwIevfsNzbKsUjWQlPZk_HdD0oNeZybzFjPuW5n3zuu8ZHEWBsTpFyakJ9dh8gPrvUlqdVuXJEciD9vltWV-XY72b1Cwl_G9RXRMiBmMVimqKQP7YMmGpDAEjd6D92CtIwcasiPlaTJahWgCk_h8Af5rNzs:1xHwau:ZzbPgDG6teVBZf6SFKnDE-oFpduLXv63Ih59FnAXo0Q', '2026-10-31 05:04:32.458232'),
('zc9edt903rv7uj2uct9sb931ywhuwhy6', '.eJxVjEEKwyAQAP-y5yKszWrMsfe-QVZXa9qiEJNT6N9LIIf2OjPMDp63tfitp8XPAhMgXH5Z4PhK9RDy5PpoKra6LnNQR6JO29W9SXrfzvZvULgXmMA6LWHIlHTmMRJGRjRshdAyorCMqDNbZ7JmN-BgUiBKxlkidxUX4PMF7ik33g:1xAMEF:8RgBS-71hrUEFgCuhmaSPAajGGP0XXJsRTLoyDe175E', '2026-10-10 06:49:47.217923'),
('zl8d4ph4ld0r7438kdjeu6q7cgnth3mv', '.eJxVjLsOgkAQAP9la3M5buVYKe39BrKvE9RAwqMy_rshodB2ZjJv6Hhb-25bfO4GgxYQ4fQLhfXp427sweN9CjqN6zxI2JNw2CXcJvPX9Wj_Bj0vPbRQ55IqbQidzdQipUYriiLFHRnRNWZ1wZJEz5cqKzeJJNZk2YkKwecLLPs4-A:1x7pU5:KTB25g1L9kADaJV0FO-YsqcqLXZuqZ91RqZzUStw-cw', '2026-10-03 07:27:41.303903');

-- --------------------------------------------------------

--
-- Table structure for table `member_activity`
--

CREATE TABLE `member_activity` (
  `id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `activity_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_aichatmessage`
--

CREATE TABLE `member_aichatmessage` (
  `id` bigint(20) NOT NULL,
  `role` varchar(12) NOT NULL,
  `content` longtext NOT NULL,
  `model` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `session_id` bigint(20) NOT NULL,
  `tokens` int(11) DEFAULT NULL,
  `feedback` varchar(255) DEFAULT NULL
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
(26, 'assistant', '### ???? GovTracker AI Executive Portfolio Synthesis\n\nHere is the comprehensive real-time status overview of the government capital projects portfolio:\n\n#### ???? Portfolio Metrics & Pipeline Status:\n- **Total Tracked Projects**: **20**\n  - ???? **Ongoing**: 13 projects\n  - ???? **Delayed**: 1 projects\n  - ???? **Completed**: 2 projects\n  - ???? **Upcoming**: 2 projects\n\n#### ???? Financial Absorption Overview:\n- **Total Capital Allocation**: **KES 22,565,543,923.98**\n- **Disbursed Expenditure**: **KES 2,000,000.00** (0.01% utilization)\n- **Available Liquid Reserves**: **KES 22,563,543,923.98**\n\n#### ???? Procurement & Citizen Signals:\n- **Active Tenders**: 2 | **Submitted Bids**: 1\n- **Registered Contractors**: 1\n- **Citizen Issue Reports**: 2 total\n\nYou can ask me specific questions such as:\n• *\"Which projects are currently delayed?\"*\n• *\"What is the budget breakdown and spending?\"*\n• *\"Show contractor performance and blacklisted vendors.\"*\n• *\"List reported citizen issues and risks.\"*', 'govtracker-intelligence-v2', '2026-08-20 06:05:37.719145', 1, NULL, NULL),
(27, 'user', 't', '', '2026-09-04 11:47:57.319333', 5, NULL, NULL),
(28, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Menengai II Geothermal Power Station (ID: 20)\n- **Status**: `UPCOMING` | **Progress**: `0%`\n- **Capital Allocation**: KES 10,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Menengai Crater, Nakuru County | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Will be done along Menengai to boost power supply in Nakuru city\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Menengai II Geothermal Power Station (ID: 34)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 20,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Menengai Crater, Nakuru County | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: A 35 MW geothermal power plant under construction in the Menengai Crater, aimed at harnessing geothermal energy to boost Kenya\'s electricity supply.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.', 'govtracker-intelligence-v2', '2026-09-04 11:47:57.346634', 5, NULL, NULL),
(29, 'user', 'hello', '', '2026-09-04 11:48:13.550441', 6, NULL, NULL),
(30, 'assistant', '### ???? GovTracker AI Executive Portfolio Synthesis\n\nHere is the comprehensive real-time status overview of the government capital projects portfolio:\n\n#### ???? Portfolio Metrics & Pipeline Status:\n- **Total Tracked Projects**: **20**\n  - ???? **Ongoing**: 13 projects\n  - ???? **Delayed**: 1 projects\n  - ???? **Completed**: 2 projects\n  - ???? **Upcoming**: 2 projects\n\n#### ???? Financial Absorption Overview:\n- **Total Capital Allocation**: **KES 52,565,543,923.98**\n- **Disbursed Expenditure**: **KES 22,000,000.00** (0.04% utilization)\n- **Available Liquid Reserves**: **KES 52,543,543,923.98**\n\n#### ???? Procurement & Citizen Signals:\n- **Active Tenders**: 2 | **Submitted Bids**: 1\n- **Registered Contractors**: 1\n- **Citizen Issue Reports**: 2 total\n\nYou can ask me specific questions such as:\n• *\"Which projects are currently delayed?\"*\n• *\"What is the budget breakdown and spending?\"*\n• *\"Show contractor performance and blacklisted vendors.\"*\n• *\"List reported citizen issues and risks.\"*', 'govtracker-intelligence-v2', '2026-09-04 11:48:13.573739', 6, NULL, NULL),
(31, 'user', 'y', '', '2026-09-04 11:48:16.719158', 7, NULL, NULL),
(32, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Northlands City (ID: 30)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Ruiru, Nairobi city | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'govtracker-intelligence-v2', '2026-09-04 11:48:16.745015', 7, NULL, NULL),
(33, 'user', 'y', '', '2026-09-04 15:33:58.347110', 8, NULL, NULL),
(34, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Northlands City (ID: 30)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Ruiru, Nairobi city | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'govtracker-intelligence-v2', '2026-09-04 15:33:58.370065', 8, NULL, NULL),
(35, 'user', 'Give me a full executive breakdown of total capital budget and expenditure absorption', '', '2026-09-04 16:54:26.050748', 9, NULL, NULL),
(36, 'assistant', '### ???? Executive Portfolio Financial Assessment\n\n- **Total Authorized Allocation**: **KES 52,565,543,923.98**\n- **Total Disbursed Expenditure**: **KES 22,000,000.00**\n- **Unspent Liquid Reserves**: **KES 52,543,543,923.98**\n- **Overall Absorption Rate**: **0.04%**\n\n#### ???? Top Capital Allocation Commitments:\n• **Affordable Housing**: KES 30,000,000,000.00 budget (Spent: KES 20,000,000.00 / 0.1%)\n• **Thika super highway**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Expansion of Tana River**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Mau Mau Road**: KES 2,121,000,000.00 budget (Spent: KES 0.00 / 0.0%)\n• **Kisumu Port**: KES 147,345,646.00 budget (Spent: KES 0.00 / 0.0%)\n\n#### ???? Financial Guidance:\n• Absorption rate is at **0.04%**. Reserve capital remains solvent.\n• Ensure all disbursement requisitions undergo milestone verification before payment processing.', 'govtracker-intelligence-v2', '2026-09-04 16:54:26.082191', 9, NULL, NULL),
(37, 'user', 'Show contractor performance overview and blacklisted contractors', '', '2026-09-04 16:55:09.522732', 10, NULL, NULL),
(38, 'assistant', '### ???? Contractor Registry & Performance Overview\n\n- **Total Registered Contractors**: **1**\n- **Blacklisted Contractors**: **0**\n\n#### ???? Sample Registered Contractors:\n• **kabarak university** [???? Active] — Category: General | Phone: 0527318502\n\n**Action Note**: Blacklisted contractors are automatically barred from participating in public tenders.', 'govtracker-intelligence-v2', '2026-09-04 16:55:09.602298', 10, NULL, NULL),
(39, 'user', 'Give me a full executive breakdown of total capital budget and expenditure absorption', '', '2026-09-04 19:43:31.726490', 11, NULL, NULL),
(40, 'assistant', '### ???? Executive Portfolio Financial Assessment\n\n- **Total Authorized Allocation**: **KES 52,565,543,923.98**\n- **Total Disbursed Expenditure**: **KES 22,000,000.00**\n- **Unspent Liquid Reserves**: **KES 52,543,543,923.98**\n- **Overall Absorption Rate**: **0.04%**\n\n#### ???? Top Capital Allocation Commitments:\n• **Affordable Housing**: KES 30,000,000,000.00 budget (Spent: KES 20,000,000.00 / 0.1%)\n• **Thika super highway**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Expansion of Tana River**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Mau Mau Road**: KES 2,121,000,000.00 budget (Spent: KES 0.00 / 0.0%)\n• **Kisumu Port**: KES 147,345,646.00 budget (Spent: KES 0.00 / 0.0%)\n\n#### ???? Financial Guidance:\n• Absorption rate is at **0.04%**. Reserve capital remains solvent.\n• Ensure all disbursement requisitions undergo milestone verification before payment processing.', 'govtracker-intelligence-v2', '2026-09-04 19:43:31.771622', 11, NULL, NULL),
(41, 'user', 'u', '', '2026-09-04 19:43:41.945605', 11, NULL, NULL),
(42, 'assistant', '### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Affordable Housing (ID: 38)\n- **Status**: `DELAYED` | **Progress**: `0%`\n- **Capital Allocation**: KES 30,000,000,000.00 | **Disbursed**: KES 20,000,000.00 (0.1% absorption)\n- **Location**: Mercy Njeri-Nakuru | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: the government is set to build upto 10 floor affordable house to help common mwananchi access the basic needs\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Building of a Dam (ID: 24)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 30,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Dam Description\n\n---\n\n### ???? Project Deep-Dive: Standard Gauge Railway (ID: 31)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 34,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Mombasa | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Construction of the Mombasa-Malaba standard gauge railway was launched by President Uhuru Kenyatta on November 28, 2013.\r\n\r\nPhase one of the project – from Mombasa to Nairobi was completed in 2017.', 'govtracker-intelligence-v2', '2026-09-04 19:43:41.997244', 11, NULL, NULL),
(43, 'user', 'k', '', '2026-09-04 19:56:16.640553', 12, NULL, NULL),
(44, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 29)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 25,895,642.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Kisumu started as a small town called Kisuma. Grey due to the greate snaking metal rod of Jorochere\n\n---\n\n### ???? Project Deep-Dive: Kisumu Port (ID: 12)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 147,345,646.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Project extension of L.Victoria port has reached its completion stage.\n\n---\n\n### ???? Project Deep-Dive: Thika super highway (ID: 11)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 9,999,999,999.99 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Thika | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: Repair and maintanance of Thika super highway', 'govtracker-intelligence-v2', '2026-09-04 19:56:16.665724', 12, NULL, NULL),
(47, 'user', 'y', '', '2026-09-04 20:07:59.207181', 14, NULL, NULL),
(48, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Northlands City (ID: 30)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Ruiru, Nairobi city | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'govtracker-intelligence-v2', '2026-09-04 20:07:59.242479', 14, NULL, NULL),
(49, 'user', 'y', '', '2026-09-04 20:08:23.172499', 15, NULL, NULL),
(50, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Northlands City (ID: 30)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Ruiru, Nairobi city | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'govtracker-intelligence-v2', '2026-09-04 20:08:23.206668', 15, NULL, NULL),
(51, 'user', 'y', '', '2026-09-05 13:40:38.993145', 16, NULL, NULL),
(52, 'assistant', '### ???? Project Deep-Dive: Konza Smart City Phase II Development (ID: 40)\n- **Status**: `DRAFT` | **Progress**: `\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.%`\n- **Capital Allocation**: KES 56,000,000.00 | **Disbursed**: KES 1,000,000.00 (1.8% absorption)\n- **Location**: Konza, Machakos County | **Category**: N/A\n- **Contractor**: China State Construction Engineering Corporation\n- **Overview**: \"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.\n\n---\n\n### ???? Project Deep-Dive: Kisumu Highway (ID: 1)\n- **Status**: `ONGOING` | **Progress**: `67%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 1,000,000.00 (4.3% absorption)\n- **Location**: Kisumu | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: A perfect highway joining most counties promoting business opportunities\n\n---\n\n### ???? Project Deep-Dive: Nairobi Railway City (ID: 37)\n- **Status**: `UPCOMING` | **Progress**: `upcoming%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Nairobi | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.\n\n---\n\n### ???? Project Deep-Dive: Infrastructure and Energy (ID: 39)\n- **Status**: `COMPLETED` | **Progress**: `0%`\n- **Capital Allocation**: KES 0.00 | **Disbursed**: KES 0.00 (0% absorption)\n- **Location**: Siaya County | **Category**: N/A\n- **Contractor**: George Mbola\n- **Overview**: Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.\n\n---\n\n### ???? Project Deep-Dive: Northlands City (ID: 30)\n- **Status**: `ONGOING` | **Progress**: `0%`\n- **Capital Allocation**: KES 23,000,000.00 | **Disbursed**: KES 0.00 (0.0% absorption)\n- **Location**: Ruiru, Nairobi city | **Category**: N/A\n- **Contractor**: Unassigned\n- **Overview**: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'govtracker-intelligence-v2', '2026-09-05 13:40:39.049231', 16, NULL, NULL),
(53, 'user', 'is there any progress on this project', '', '2026-09-26 07:42:14.400460', 17, NULL, NULL),
(54, 'user', 'is there any progress on this project', '', '2026-09-26 07:46:18.548024', 18, NULL, NULL),
(55, 'assistant', '### 🏛 GovTracker AI Executive Portfolio Synthesis\n\nHere is the comprehensive real-time status overview of the government capital projects portfolio:\n\n#### 📊 Portfolio Metrics & Pipeline Status:\n- **Total Tracked Projects**: **21**\n  - 🔵 **Ongoing**: 5 projects\n  - 🔴 **Delayed**: 12 projects\n  - 🟢 **Completed**: 3 projects\n  - 🟡 **Upcoming**: 0 projects\n\n#### 💰 Financial Absorption Overview:\n- **Total Capital Allocation**: **KES 389,565,543,923.98**\n- **Disbursed Expenditure**: **KES 43,500,000.00** (0.01% utilization)\n- **Available Liquid Reserves**: **KES 389,522,043,923.98**\n\n#### 🛠 Procurement & Citizen Signals:\n- **Active Tenders**: 2 | **Submitted Bids**: 1\n- **Registered Contractors**: 1\n- **Citizen Issue Reports**: 5 total\n\nYou can ask me specific questions such as:\n• *\"Which projects are currently delayed?\"*\n• *\"What is the budget breakdown and spending?\"*\n• *\"Show contractor performance and blacklisted vendors.\"*\n• *\"List reported citizen issues and risks.\"*', 'govtracker-intelligence-v2', '2026-09-26 07:46:18.568873', 18, NULL, NULL),
(56, 'user', 'spendings', '', '2026-09-26 07:47:01.426435', 18, NULL, NULL),
(57, 'assistant', '### 📊 Executive Portfolio Financial Assessment\n\n- **Total Authorized Allocation**: **KES 389,565,543,923.98**\n- **Total Disbursed Expenditure**: **KES 43,500,000.00**\n- **Unspent Liquid Reserves**: **KES 389,522,043,923.98**\n- **Overall Absorption Rate**: **0.01%**\n\n#### 🏆 Top Capital Allocation Commitments:\n• **High Grand Falls Multipurpose Dam Project**: KES 337,000,000,000.00 budget (Spent: KES 20,500,000.00 / 0.0%)\n• **Affordable Housing**: KES 30,000,000,000.00 budget (Spent: KES 20,000,000.00 / 0.1%)\n• **Thika super highway**: KES 9,999,999,999.99 budget (Spent: KES 1,000,000.00 / 0.0%)\n• **Expansion of Tana River**: KES 9,999,999,999.99 budget (Spent: KES 0.00 / 0.0%)\n• **Mau Mau Road**: KES 2,121,000,000.00 budget (Spent: KES 0.00 / 0.0%)\n\n#### 💡 Financial Guidance:\n• Absorption rate is at **0.01%**. Reserve capital remains solvent.\n• Ensure all disbursement requisitions undergo milestone verification before payment processing.', 'govtracker-intelligence-v2', '2026-09-26 07:47:01.446890', 18, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_aichatsession`
--

CREATE TABLE `member_aichatsession` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
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
(4, 'h', '2026-08-20 06:04:13.334473', '2026-08-20 06:04:20.507207', 30, '{}'),
(5, 't', '2026-09-04 11:47:57.312492', '2026-09-04 11:47:57.352335', 30, '{}'),
(6, 'hello', '2026-09-04 11:48:13.543596', '2026-09-04 11:48:13.579383', 30, '{}'),
(7, 'y', '2026-09-04 11:48:16.715789', '2026-09-04 11:48:16.750048', 30, '{}'),
(8, 'y', '2026-09-04 15:33:58.340784', '2026-09-04 15:33:58.374028', 30, '{}'),
(9, 'Give me a full executive breakdown of total capital budget a', '2026-09-04 16:54:26.039067', '2026-09-04 16:54:26.085574', 1, '{}'),
(10, 'Show contractor performance overview and blacklisted contrac', '2026-09-04 16:55:09.504654', '2026-09-04 16:55:09.607782', 1, '{}'),
(11, 'Give me a full executive breakdown of total capital budget a', '2026-09-04 19:43:31.714669', '2026-09-04 19:43:31.775771', 1, '{}'),
(12, 'k', '2026-09-04 19:56:16.635036', '2026-09-04 19:56:16.670194', 1, '{}'),
(14, 'y', '2026-09-04 20:07:59.200305', '2026-09-04 20:07:59.249749', 1, '{}'),
(15, 'y', '2026-09-04 20:08:23.164846', '2026-09-04 20:08:23.213626', 1, '{}'),
(16, 'y', '2026-09-05 13:40:38.978284', '2026-09-05 13:40:39.058361', 1, '{}'),
(17, 'New Conversation', '2026-09-26 07:42:14.389987', '2026-09-26 07:42:14.390013', 31, '{}'),
(18, 'is there any progress on this project', '2026-09-26 07:46:18.544062', '2026-09-26 07:46:18.574259', 31, '{}');

-- --------------------------------------------------------

--
-- Table structure for table `member_aienginerun`
--

CREATE TABLE `member_aienginerun` (
  `id` bigint(20) NOT NULL,
  `projects_scanned` int(11) NOT NULL,
  `findings_created` int(11) NOT NULL,
  `findings_active` int(11) NOT NULL,
  `model` varchar(100) NOT NULL,
  `duration_ms` int(11) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_aifinding`
--

CREATE TABLE `member_aifinding` (
  `id` bigint(20) NOT NULL,
  `finding_code` varchar(20) DEFAULT NULL,
  `category` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL,
  `finding` longtext NOT NULL,
  `reason` longtext NOT NULL,
  `confidence` double NOT NULL,
  `severity` varchar(10) NOT NULL,
  `priority_score` double NOT NULL,
  `evidence` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`evidence`)),
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `status` varchar(255) NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `review_notes` longtext DEFAULT NULL,
  `model` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `contractor_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `reviewed_by_id` bigint(20) DEFAULT NULL,
  `tender_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_aiissueassessment`
--

CREATE TABLE `member_aiissueassessment` (
  `id` bigint(20) NOT NULL,
  `category` varchar(255) NOT NULL,
  `urgency` varchar(255) NOT NULL,
  `confidence` smallint(5) UNSIGNED NOT NULL CHECK (`confidence` >= 0),
  `summary` longtext NOT NULL,
  `recommended_action` longtext NOT NULL,
  `model` varchar(255) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `review_status` varchar(255) NOT NULL,
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

--
-- Dumping data for table `member_aiprojectanalysis`
--

INSERT INTO `member_aiprojectanalysis` (`id`, `analysis_type`, `summary`, `data`, `confidence`, `model`, `created_at`, `is_latest`, `project_id`) VALUES
(21, 'risk', 'Low delivery risk (30/100). One or more milestones are marked missed.', '{\"score\": 30, \"level\": \"low\", \"reasons\": [\"One or more milestones are marked missed.\"], \"schedule_delay_months\": 0, \"complaints\": 0, \"contractor\": {\"name\": \"Unassigned\", \"rating\": null, \"projects\": 0, \"delayed_projects\": 0}, \"financial_health\": 100, \"schedule_health\": 100, \"early_warnings\": [\"One or more milestones are overdue or marked missed.\"], \"recommendations\": [\"Continue routine milestone, expenditure, and evidence monitoring.\"]}', 70, 'govtracker-rules-v2', '2026-09-04 19:44:03.996184', 1, 35),
(22, 'completion', 'Completion cannot be estimated until progress or stage updates are recorded.', '{\"progress\": null, \"status\": \"unknown\", \"milestones_completed\": 0, \"milestones_total\": 1, \"predicted_completion\": null, \"schedule_delay_months\": 0}', 45, 'govtracker-rules-v2', '2026-09-04 19:44:03.999059', 1, 35),
(23, 'budget', 'KES 0.00 spent of KES 0.00 allocated (0.0% utilized).', '{\"budget\": 0.0, \"spent\": 0.0, \"remaining\": 0.0, \"utilization\": 0.0, \"anomaly_score\": 20, \"anomaly_level\": \"normal\", \"indicators\": [], \"physical_progress\": null, \"financial_health\": 100}', 45, 'govtracker-rules-v2', '2026-09-04 19:44:04.000379', 1, 35),
(24, 'performance', '0 of 1 milestones complete across 0 project stage(s).', '{\"milestones_completed\": 0, \"milestones_total\": 1, \"stages\": 0, \"average_stage_progress\": null, \"contractor\": {\"name\": \"Unassigned\", \"rating\": null, \"projects\": 0, \"delayed_projects\": 0}, \"contractor_score\": null}', 85, 'govtracker-rules-v2', '2026-09-04 19:44:04.001607', 1, 35),
(25, 'sentiment', 'Citizen sentiment signal is limited until public feedback and issue reports are linked to this project.', '{\"open_issues\": 0, \"feedback_count\": 0, \"citizen_satisfaction\": null, \"signal\": \"limited_data\"}', 40, 'govtracker-rules-v2', '2026-09-04 19:44:04.003115', 1, 35),
(41, 'risk', 'Low delivery risk (20/100). No major automated risk signals detected.', '{\"score\": 20, \"anomaly_score\": 20, \"level\": \"low\", \"reasons\": [], \"anomaly_indicators\": [], \"procurement_indicators\": [], \"data_integrity_flags\": [\"A similar project exists at the same recorded location and may require duplicate-record review.\"], \"duplicate_candidates\": [{\"project_id\": 34, \"project\": \"Menengai II Geothermal Power Station\", \"similarity\": 75.0}], \"schedule_delay_months\": 0, \"complaints\": 0, \"contractor\": {\"name\": \"Unassigned\", \"rating\": null, \"projects\": 0, \"delayed_projects\": 0}, \"financial_health\": 100, \"schedule_health\": 100, \"early_warnings\": [\"Project records contain a data-consistency signal requiring verification.\"], \"recommendations\": [\"Verify whether similar project records represent separate scopes or a duplicate entry.\", \"Reconcile the project status against milestones, payments, and completion evidence.\"], \"evidence_chain\": [\"Budget and expenditure records\", \"Milestone and stage records\", \"Project timeline\", \"Contractor records\", \"Citizen issue records\"], \"investigation\": {\"what_happened\": \"No major automated anomaly detected.\", \"why_unusual\": \"Observed values are within the available rules-based checks.\", \"what_to_check\": \"Payment certificates, variation orders, invoices, site evidence, and milestone approvals.\", \"priority\": \"low\"}}', 80, 'gpt-4o-mini', '2026-09-17 03:23:52.038448', 1, 20),
(42, 'completion', 'Completion cannot be estimated until progress or stage updates are recorded.', '{\"progress\": null, \"status\": \"upcoming\", \"milestones_completed\": 0, \"milestones_total\": 0, \"predicted_completion\": null, \"schedule_delay_months\": 0}', 45, 'gpt-4o-mini', '2026-09-17 03:23:52.040383', 1, 20),
(43, 'budget', 'KES 0.00 spent of KES 10,000,000.00 allocated (0.0% utilized).', '{\"budget\": 10000000.0, \"spent\": 0.0, \"remaining\": 10000000.0, \"utilization\": 0.0, \"anomaly_score\": 20, \"anomaly_level\": \"normal\", \"indicators\": [], \"physical_progress\": null, \"financial_health\": 100, \"budget_revisions\": 0, \"expenses_after_deadline\": 0}', 90, 'gpt-4o-mini', '2026-09-17 03:23:52.042158', 1, 20),
(44, 'performance', '0 of 0 milestones complete across 0 project stage(s).', '{\"milestones_completed\": 0, \"milestones_total\": 0, \"stages\": 0, \"average_stage_progress\": null, \"contractor\": {\"name\": \"Unassigned\", \"rating\": null, \"projects\": 0, \"delayed_projects\": 0}, \"contractor_score\": null, \"contractor_anomalies\": []}', 45, 'gpt-4o-mini', '2026-09-17 03:23:52.044971', 1, 20),
(45, 'sentiment', 'Citizen sentiment signal is limited until public feedback and issue reports are linked to this project.', '{\"open_issues\": 0, \"feedback_count\": 0, \"citizen_satisfaction\": null, \"signal\": \"limited_data\"}', 40, 'gpt-4o-mini', '2026-09-17 03:23:52.046756', 1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `member_aireportgeneration`
--

CREATE TABLE `member_aireportgeneration` (
  `id` bigint(20) NOT NULL,
  `report_type` varchar(255) NOT NULL,
  `prompt` longtext NOT NULL,
  `output` longtext NOT NULL,
  `status` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `requested_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_aireportgeneration`
--

INSERT INTO `member_aireportgeneration` (`id`, `report_type`, `prompt`, `output`, `status`, `model`, `created_at`, `project_id`, `requested_by_id`) VALUES
(2, 'executive_summary', '', 'Summary: Project: Expansion of Tana River. Status: completed. Description: Due to frequent blockages of the river banks, the government  considered its improval. Budget: 9999999999.99; Spent: 0; Utilization: 0.0%. Open issues: 0. Milestones completed: 0/0. Progress: No progress update recorded.\n\nRisk level: Medium (35/100).\n\nRecommended next step: review the project record and assign an accountable follow-up action.', 'generated', 'govtracker-rules-v1', '2026-09-04 15:38:46.312687', 36, 30),
(3, 'executive_summary', '', 'Summary: Project: express way. Status: ongoing. Description: Completion of expressway along Haile Sellasie avenue. Budget: 34500000.00; Spent: 0; Utilization: 0.0%. Open issues: 0. Milestones completed: 0/0. Progress: No progress update recorded.\n\nRisk level: Medium (35/100).\n\nRecommended next step: review the project record and assign an accountable follow-up action.', 'generated', 'govtracker-rules-v1', '2026-09-04 15:38:49.839601', 27, 30),
(4, 'executive_summary', '', 'Summary: Project: Northlands City. Status: ongoing. Description: The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.. Budget: 23000000.00; Spent: 0; Utilization: 0.0%. Open issues: 0. Milestones completed: 0/0. Progress: No progress update recorded.\n\nRisk level: Medium (35/100).\n\nRecommended next step: review the project record and assign an accountable follow-up action.', 'generated', 'govtracker-rules-v1', '2026-09-04 15:38:55.718787', 30, 30);

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
(6, 'quick_updated', '2026-08-20 04:20:43.718433', 35, 1, '{\"status\": \"in_progress\", \"progress\": 10}', '127.0.0.1', 'Milestone', 2),
(7, 'citizen_submission', '2026-08-21 06:57:59.748265', NULL, 1, '{\"title\": \"slow development\", \"category\": \"complaint\"}', '127.0.0.1', 'CitizenSubmission', 1),
(8, 'quick_updated', '2026-08-30 07:13:01.514980', 35, 1, '{\"status\": \"missed\", \"progress\": 10}', '127.0.0.1', 'Milestone', 2),
(9, 'quick_updated', '2026-08-30 07:13:26.386641', 35, 1, '{\"status\": \"missed\", \"progress\": 67}', '127.0.0.1', 'Milestone', 2),
(10, 'quick_updated', '2026-08-30 07:13:46.388515', 35, 1, '{\"status\": \"completed\", \"progress\": 90}', '127.0.0.1', 'Milestone', 1),
(11, 'quick_updated', '2026-08-30 07:14:04.020914', 35, 1, '{\"status\": \"completed\", \"progress\": 100}', '127.0.0.1', 'Milestone', 1),
(12, 'updated', '2026-08-30 07:16:23.099646', 24, 1, '{\"title\": \"Itare Dam Multipurpose Project\"}', '127.0.0.1', 'Milestone', 1),
(13, 'updated', '2026-09-01 16:54:23.616180', NULL, 1, '{\"name\": \"building  bridge initiated\"}', '127.0.0.1', 'Project_Division', 1),
(14, 'issue_reported', '2026-09-23 07:09:43.412828', 41, 1, '{}', '127.0.0.1', 'ReportIssue', 4),
(15, 'created', '2026-09-23 07:47:07.765829', 41, 1, '{\"title\": \"da project\", \"amount\": \"20000000\"}', '127.0.0.1', 'ProjectExpense', 3),
(16, 'created', '2026-09-23 08:00:32.472828', 41, 1, '{\"stage_name\": \"construction\"}', '127.0.0.1', 'ProjectStage', 3),
(17, 'issue_reported', '2026-09-23 08:02:56.391439', 41, 1, '{}', '127.0.0.1', 'ReportIssue', 5),
(18, 'updated', '2026-09-23 16:56:19.269578', 40, NULL, '{\"source\": \"auto\", \"old_status\": \"draft\", \"new_status\": \"delayed\"}', NULL, 'Project', 40),
(19, 'updated', '2026-09-23 16:56:19.291484', 1, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 1),
(20, 'updated', '2026-09-23 16:56:19.409165', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"Delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 38),
(21, 'updated', '2026-09-23 16:56:19.422782', 20, NULL, '{\"source\": \"auto\", \"old_status\": \"upcoming\", \"new_status\": \"ongoing\"}', NULL, 'Project', 20),
(22, 'updated', '2026-09-23 16:56:19.435510', 37, NULL, '{\"source\": \"auto\", \"old_status\": \"upcoming\", \"new_status\": \"ongoing\"}', NULL, 'Project', 37),
(23, 'updated', '2026-09-23 16:56:19.451862', 34, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 34),
(24, 'updated', '2026-09-23 16:56:19.465135', 24, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 24),
(25, 'updated', '2026-09-23 16:56:19.764420', 31, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 31),
(26, 'updated', '2026-09-23 16:56:19.788315', 27, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 27),
(27, 'updated', '2026-09-23 16:56:19.811817', 28, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 28),
(28, 'updated', '2026-09-23 16:56:19.848416', 22, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 22),
(29, 'updated', '2026-09-23 16:56:19.872788', 18, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 18),
(30, 'updated', '2026-09-23 16:56:19.891702', 12, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 12),
(31, 'updated', '2026-09-23 16:56:19.904962', 11, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 11),
(32, 'updated', '2026-09-23 16:56:19.917861', 35, NULL, '{\"source\": \"auto\", \"old_status\": \"\", \"new_status\": \"ongoing\"}', NULL, 'Project', 35),
(33, 'updated', '2026-09-23 16:56:19.924506', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(34, 'updated', '2026-09-23 16:56:19.931962', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(35, 'updated', '2026-09-23 17:00:57.603712', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 30),
(36, 'updated', '2026-09-23 17:00:57.739645', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 29),
(37, 'updated', '2026-09-23 17:02:20.460955', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(38, 'updated', '2026-09-23 17:02:20.472953', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(39, 'updated', '2026-09-23 17:04:42.392871', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 30),
(40, 'updated', '2026-09-23 17:04:42.434091', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 29),
(41, 'updated', '2026-09-23 17:15:14.933252', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(42, 'updated', '2026-09-23 17:15:14.938057', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(43, 'updated', '2026-09-23 17:16:19.883374', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 30),
(44, 'updated', '2026-09-23 17:16:19.913289', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 29),
(45, 'updated', '2026-09-23 17:16:35.138744', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(46, 'updated', '2026-09-23 17:16:35.149298', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(47, 'updated', '2026-09-23 17:17:15.220038', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 30),
(48, 'updated', '2026-09-23 17:17:15.278401', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 29),
(49, 'updated', '2026-09-23 17:18:20.146572', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(50, 'updated', '2026-09-23 17:18:20.153853', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(51, 'updated', '2026-09-23 17:18:44.886514', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 30),
(52, 'updated', '2026-09-23 17:18:44.913602', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 29),
(53, 'updated', '2026-09-23 17:24:51.485627', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(54, 'updated', '2026-09-23 17:24:51.493115', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(55, 'updated', '2026-09-23 17:27:01.220669', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 30),
(56, 'updated', '2026-09-23 17:27:01.248154', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"delayed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 29),
(57, 'updated', '2026-09-23 17:33:57.268051', 30, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 30),
(58, 'updated', '2026-09-23 17:33:57.309334', 29, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"delayed\"}', NULL, 'Project', 29),
(59, 'created', '2026-09-23 17:56:39.575220', 11, 1, '{\"title\": \"hgjhk\"}', '127.0.0.1', 'ProgressReport', 1),
(60, 'stage_status_changed', '2026-09-23 17:57:59.030927', 11, 1, '{\"status\": \"on_hold\"}', '127.0.0.1', 'ProjectStage', 15),
(61, 'created', '2026-09-24 08:40:15.997848', 11, 1, '{\"title\": \"tarmac and trucks\", \"amount\": \"1000000\"}', '127.0.0.1', 'ProjectExpense', 4),
(62, 'stage_status_changed', '2026-09-24 08:41:09.299387', 11, 1, '{\"status\": \"not_started\"}', '127.0.0.1', 'ProjectStage', 5),
(63, 'created', '2026-09-24 09:49:04.857230', 11, 1, '{\"title\": \"mnhg\"}', '127.0.0.1', 'ProgressReport', 2),
(64, 'stage_report_submitted', '2026-09-25 06:24:27.379266', NULL, 31, '{}', '127.0.0.1', 'StageReport', 1),
(65, 'created', '2026-09-25 06:37:23.519105', NULL, 31, '{\"title\": \"affordable housing\"}', '127.0.0.1', 'ProgressReport', 3),
(66, 'issue_reported', '2026-09-25 06:38:49.202373', NULL, 31, '{}', '127.0.0.1', 'ReportIssue', 6),
(67, 'created', '2026-09-25 06:47:57.990095', NULL, 31, '{\"title\": \"wallwall perimeter\"}', '127.0.0.1', 'ProgressReport', 4),
(68, 'stage_report_submitted', '2026-09-25 07:13:04.515528', NULL, 31, '{}', '127.0.0.1', 'StageReport', 2),
(69, 'created', '2026-09-25 08:26:45.869240', NULL, 31, '{\"title\": \"j nm\"}', '127.0.0.1', 'ProgressReport', 5),
(70, 'stage_status_changed', '2026-09-25 08:50:42.919589', NULL, 30, '{\"status\": \"not_started\"}', '127.0.0.1', 'ProjectStage', 18),
(71, 'created', '2026-09-26 06:45:07.985074', NULL, 31, '{\"title\": \"water and sanitatio\", \"reference_no\": \"REQ-7EDF23A1\"}', '127.0.0.1', 'GovernmentRequest', 2),
(72, 'responded_request', '2026-09-26 06:47:34.104293', NULL, 31, '{\"status\": \"in_progress\"}', '127.0.0.1', 'GovernmentRequest', 2),
(73, 'tender_application_submitted', '2026-09-27 06:08:49.780490', 31, 1, '{}', '127.0.0.1', 'TenderApplication', 2),
(74, 'tender_evaluated', '2026-09-27 06:26:00.800626', 31, 1, '{}', '127.0.0.1', 'Tender', 3),
(75, 'tender_evaluated', '2026-09-27 06:29:34.492714', 31, 1, '{}', '127.0.0.1', 'Tender', 3),
(76, 'tender_evaluated', '2026-09-27 06:29:47.636544', 31, 1, '{}', '127.0.0.1', 'Tender', 3),
(77, 'tender_evaluated', '2026-09-27 06:29:59.167868', 31, 1, '{}', '127.0.0.1', 'Tender', 3),
(78, 'updated', '2026-09-27 06:44:24.924909', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"upcoming\"}', NULL, 'Project', 42),
(79, 'tender_evaluated', '2026-09-27 06:45:07.574133', 31, 1, '{}', '127.0.0.1', 'Tender', 3),
(80, 'updated', '2026-09-27 07:18:17.828576', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"draft\", \"new_status\": \"upcoming\"}', NULL, 'Project', 43),
(81, 'updated', '2026-09-27 07:19:04.697391', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"draft\", \"new_status\": \"upcoming\"}', NULL, 'Project', 44),
(82, 'updated', '2026-09-27 07:19:04.708316', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"upcoming\", \"new_status\": \"ongoing\"}', NULL, 'Project', 44),
(83, 'updated', '2026-09-27 07:19:04.716267', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 44),
(84, 'updated', '2026-09-27 07:19:20.194738', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"draft\", \"new_status\": \"upcoming\"}', NULL, 'Project', 45),
(85, 'updated', '2026-09-27 07:19:20.203989', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"upcoming\", \"new_status\": \"ongoing\"}', NULL, 'Project', 45),
(86, 'updated', '2026-09-27 07:19:20.210744', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 45),
(87, 'updated', '2026-09-27 07:31:00.690920', NULL, 40, '{\"source\": \"assignee\", \"old_status\": \"upcoming\", \"new_status\": \"completed\"}', NULL, 'Project', 47),
(88, 'created', '2026-09-30 18:57:23.658418', 40, 1, '{\"title\": \"konza city\", \"amount\": \"20000\"}', '127.0.0.1', 'ProjectExpense', 5),
(89, 'issue_reported', '2026-09-30 18:59:21.132393', 40, 1, '{}', '127.0.0.1', 'ReportIssue', 7),
(90, 'updated', '2026-09-30 19:01:28.593447', NULL, 1, '{\"source\": \"assignee\", \"old_status\": \"ongoing\", \"new_status\": \"suspended\"}', NULL, 'Project', 38),
(91, 'deleted', '2026-09-30 19:31:59.609487', NULL, 45, '{\"title\": \"DelTest\"}', '127.0.0.1', 'Project', 50),
(92, 'deleted', '2026-09-30 19:39:34.978371', NULL, 1, '{\"name\": \"Division #5\"}', '127.0.0.1', 'Project_Division', 5),
(93, 'deleted', '2026-09-30 19:39:55.785083', NULL, 1, '{\"name\": \"Division #2\"}', '127.0.0.1', 'Project_Division', 2),
(94, 'deleted', '2026-09-30 19:40:07.246788', NULL, 1, '{\"name\": \"Division #3\"}', '127.0.0.1', 'Project_Division', 3),
(95, 'deleted', '2026-10-01 06:06:37.415527', NULL, 1, '{\"title\": \"DelTest\"}', '127.0.0.1', 'Project', 50),
(96, 'deleted', '2026-10-01 06:07:04.331177', NULL, 1, '{\"title\": \"DelTest\"}', '127.0.0.1', 'Project', 50),
(97, 'deleted', '2026-10-01 06:13:29.575731', NULL, 1, '{\"title\": \"DelTest\"}', '127.0.0.1', 'Project', 50),
(98, 'deleted', '2026-10-01 06:16:43.154710', NULL, NULL, '{\"title\": \"DelSmoke\"}', '127.0.0.1', 'Project', 51),
(99, 'deleted', '2026-10-01 06:16:44.440162', NULL, 1, '{\"title\": \"DelTest\"}', '127.0.0.1', 'Project', 49),
(100, 'deleted', '2026-10-01 06:38:52.234176', NULL, 1, '{\"title\": \"TrackFlowTest\"}', '127.0.0.1', 'Project', 46),
(101, 'deleted', '2026-10-01 06:39:03.038957', NULL, 1, '{\"title\": \"DelTest\"}', '127.0.0.1', 'Project', 50),
(102, 'deleted', '2026-10-01 06:39:14.476665', NULL, 1, '{\"title\": \"TrackFlowTest3\"}', '127.0.0.1', 'Project', 48),
(103, 'deleted', '2026-10-01 06:39:25.248480', NULL, 1, '{\"title\": \"TrackFlowTest2\"}', '127.0.0.1', 'Project', 47),
(104, 'deleted', '2026-10-01 06:39:36.750186', NULL, 1, '{\"title\": \"StatusFlowTest2\"}', '127.0.0.1', 'Project', 45),
(105, 'deleted', '2026-10-01 06:39:47.903681', NULL, 1, '{\"title\": \"StatusFlowTest\"}', '127.0.0.1', 'Project', 44),
(106, 'deleted', '2026-10-01 06:39:56.895724', NULL, 1, '{\"title\": \"StatusFlowTest\"}', '127.0.0.1', 'Project', 43),
(107, 'deleted', '2026-10-01 06:40:04.872050', NULL, 1, '{\"title\": \"AssignTest\"}', '127.0.0.1', 'Project', 42),
(108, 'stage_status_changed', '2026-10-01 11:18:04.498381', NULL, 1, '{\"status\": \"completed\"}', '127.0.0.1', 'ProjectStage', 16),
(109, 'stage_status_changed', '2026-10-01 11:18:56.950130', NULL, 1, '{\"status\": \"in_progress\"}', '127.0.0.1', 'ProjectStage', 17),
(110, 'stage_status_changed', '2026-10-01 11:19:08.111532', NULL, 1, '{\"status\": \"on_hold\"}', '127.0.0.1', 'ProjectStage', 19),
(111, 'updated', '2026-10-05 17:48:46.486139', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 52),
(112, 'updated', '2026-10-05 17:54:01.291597', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 52),
(113, 'updated', '2026-10-05 17:54:19.107489', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 53),
(114, 'updated', '2026-10-05 17:55:48.168982', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 53),
(115, 'updated', '2026-10-05 17:56:02.217901', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 54),
(116, 'updated', '2026-10-05 17:56:02.437126', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 54),
(117, 'updated', '2026-10-05 17:57:23.643350', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 55),
(118, 'updated', '2026-10-05 17:57:23.856060', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 55),
(119, 'updated', '2026-10-05 17:58:03.727982', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 56),
(120, 'updated', '2026-10-05 17:58:55.228136', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 57),
(121, 'updated', '2026-10-05 18:01:14.938389', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 58),
(122, 'updated', '2026-10-05 18:02:18.118326', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 59),
(123, 'updated', '2026-10-05 18:05:55.836890', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 60),
(124, 'updated', '2026-10-05 18:07:13.845749', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 61),
(125, 'updated', '2026-10-05 18:09:30.556505', NULL, NULL, '{\"source\": \"manual\", \"old_status\": \"completed\", \"new_status\": \"ongoing\"}', NULL, 'Project', 61),
(126, 'updated', '2026-10-05 18:09:57.627383', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 62),
(127, 'updated', '2026-10-05 18:15:56.494869', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 63),
(128, 'updated', '2026-10-05 18:16:55.254803', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 64),
(129, 'updated', '2026-10-05 18:18:05.344103', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 65),
(130, 'updated', '2026-10-05 18:18:45.583293', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 66),
(131, 'updated', '2026-10-05 18:24:18.073506', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 68),
(132, 'created', '2026-10-05 18:24:40.868481', NULL, 1, '{\"title\": \"affordable housing\"}', '127.0.0.1', 'ProgressReport', 6),
(133, 'updated', '2026-10-05 18:26:00.463014', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 69),
(134, 'updated', '2026-10-05 18:26:00.494084', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 69),
(135, 'updated', '2026-10-05 18:27:17.435360', 70, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 70),
(136, 'updated', '2026-10-05 18:27:17.472883', 70, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 70),
(137, 'updated', '2026-10-05 18:37:04.424427', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 71),
(138, 'updated', '2026-10-06 03:01:25.343882', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 75),
(139, 'job_progress_updated', '2026-10-06 03:25:16.950171', 70, 31, '{\"stage\": \"Site Clearance & Land Preparation\", \"progress\": 45}', '127.0.0.1', 'ProjectStage', 86),
(140, 'updated', '2026-10-06 03:32:31.112288', NULL, NULL, '{\"source\": \"auto\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 76),
(141, 'tender_evaluated', '2026-10-06 03:37:29.381275', 31, 1, '{}', '127.0.0.1', 'Tender', 3),
(142, 'tender_awarded', '2026-10-06 03:37:47.602387', 31, 1, '{\"application_id\": 2, \"contractor_id\": 2}', '127.0.0.1', 'Tender', 3),
(143, 'stage_report_submitted', '2026-10-06 03:41:49.686687', 70, 31, '{}', '127.0.0.1', 'StageReport', 3),
(144, 'created', '2026-10-16 06:25:24.285110', 70, 31, '{\"stage_name\": \"ground breking\"}', '127.0.0.1', 'ProjectStage', 93),
(145, 'deleted', '2026-10-16 09:20:59.544810', NULL, 1, '{\"title\": \"T2\"}', '127.0.0.1', 'Project', 72),
(146, 'deleted', '2026-10-16 09:21:13.600009', NULL, 1, '{\"title\": \"T\"}', '127.0.0.1', 'Project', 71),
(147, 'deleted', '2026-10-16 09:26:19.137002', NULL, 1, '{\"title\": \"MT\"}', '127.0.0.1', 'Project', 75),
(148, 'responded_request', '2026-10-16 09:54:39.101855', NULL, 31, '{\"status\": \"in_progress\"}', '127.0.0.1', 'GovernmentRequest', 2),
(149, 'responded_request', '2026-10-16 09:55:59.570732', NULL, 31, '{\"status\": \"resolved\"}', '127.0.0.1', 'GovernmentRequest', 2),
(150, 'closed_request', '2026-10-16 09:56:15.998015', NULL, 31, '{\"status\": \"closed\"}', '127.0.0.1', 'GovernmentRequest', 2),
(151, 'stage_report_updated', '2026-10-16 10:19:54.683268', 70, 31, '{\"before\": {\"stage_description\": \"building of perimeter walls\", \"description\": \"woking in progress\", \"location\": \"Kisumu county\", \"progress_percentage\": 26, \"delay_reason\": \"\", \"corrective_actions\": \"\"}, \"after\": {\"stage_description\": \"building of perimeter walls\", \"description\": \"working in progress\", \"location\": \"Kisumu county\", \"progress_percentage\": 26, \"delay_reason\": \"\", \"corrective_actions\": \"\"}, \"review_status\": \"pending\"}', '127.0.0.1', 'StageReport', 3),
(152, 'stage_report_submitted', '2026-10-17 05:30:03.383260', 70, 31, '{}', '127.0.0.1', 'StageReport', 4),
(153, 'quick_updated', '2026-10-17 05:58:44.638725', 70, 30, '{\"status\": \"in_progress\", \"progress\": 95}', '127.0.0.1', 'Milestone', 95),
(154, 'updated', '2026-10-17 06:46:06.557455', 37, 30, '{\"source\": \"assignee\", \"old_status\": \"ongoing\", \"new_status\": \"completed\"}', NULL, 'Project', 37),
(155, 'contractor_payment_request_submitted', '2026-10-17 07:11:21.523937', 70, 31, '{}', '127.0.0.1', 'ContractorPaymentRequest', 1),
(156, 'deleted', '2026-10-17 07:53:39.500388', 74, 30, '{\"stage_name\": \"planning\"}', '127.0.0.1', 'ProjectStage', 92);

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
(1, '56000000.00', '1020000.00', '2026-09-30 18:57:23.654663', 40, '2027', 'in process, will assess'),
(2, '23000000.00', '1000000.00', '2026-08-20 05:39:19.603196', 1, NULL, NULL),
(4, '337000000000.00', '20000000.00', '2026-09-23 07:47:07.762912', 41, NULL, NULL),
(5, '9999999999.99', '1000000.00', '2026-09-24 08:40:15.993940', 11, NULL, NULL);

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
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `verified_by_id` bigint(20) DEFAULT NULL,
  `category` varchar(30) NOT NULL,
  `coordinates` varchar(255) DEFAULT NULL,
  `evidence_type` varchar(20) NOT NULL,
  `notes` longtext DEFAULT NULL,
  `observed_at` date DEFAULT NULL,
  `severity` varchar(20) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `review_notes` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `verified_at` datetime(6) DEFAULT NULL,
  `agreed_at` datetime(6) DEFAULT NULL,
  `citizen_agreed` tinyint(1) NOT NULL,
  `official_agreed` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_citizenevidence`
--

INSERT INTO `member_citizenevidence` (`id`, `title`, `description`, `location`, `created_at`, `project_id`, `stage_id`, `user_id`, `verified_by_id`, `category`, `coordinates`, `evidence_type`, `notes`, `observed_at`, `severity`, `file`, `review_notes`, `status`, `verified_at`, `agreed_at`, `citizen_agreed`, `official_agreed`) VALUES
(1, 'fdgn', 'cvdxfg', ' cv', '2026-06-11 06:54:43.125873', 1, 1, 1, NULL, 'other', NULL, 'photo', NULL, NULL, 'moderate', NULL, NULL, 'pending', NULL, NULL, 0, 0),
(2, 'dam construction', 'dam construction', 'ol kalao', '2026-10-18 06:48:08.390695', 41, 40, 30, 30, 'infrastructure', NULL, 'photo', '', '2026-10-18', 'moderate', NULL, 'there is no clear proof. you can upload photo or video to support your evidence', 'rejected', '2026-10-18 14:16:42.593150', NULL, 0, 0),
(3, 'poor planning', 'poor planning', 'ol kalao - nakuru', '2026-10-18 14:58:15.743065', 41, 40, 25, 30, 'water', NULL, 'photo', '', '2026-10-18', 'moderate', 'citizen_evidence/2026/10/31e122f8e18f4fe785cfd010940aed30.jpg', 'i agree to this evience,, will resolve it in a few', 'verified', '2026-10-18 14:59:49.461468', NULL, 1, 0);

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

--
-- Dumping data for table `member_citizensubmission`
--

INSERT INTO `member_citizensubmission` (`id`, `title`, `message`, `category`, `status`, `created_at`, `user_id`, `attachment`, `project_id`, `response`, `updated_at`) VALUES
(1, 'slow development', 'Dandora requires accelerated development, particularly in road and street infrastructure, as the current conditions are not conducive to safe and efficient movement for residents.', 'complaint', 'pending', '2026-08-21 06:57:59.743443', 1, '', 22, NULL, '2026-08-21 06:57:59.743477');

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

INSERT INTO `member_contractor` (`id`, `name`, `company`, `phone`, `email`, `location`, `profile`, `blacklist_reason`, `category`, `is_blacklisted`, `registration_no`, `created_at`) VALUES
(1, 'kabarak university', 'kabarak university', '0527318502', 'felixngwono@gmail.com', 'National', '', NULL, NULL, 0, NULL, '2026-08-19 13:00:37'),
(2, 'Leti Amanda', 'Zedafrica', '0789456732', 'letiamanda@gmail.com', 'Nairobi', 'contractors/IMG_20240110_110807_TYrXCrw.jpg', NULL, 'Architecture', 0, 'EP20PD', '2026-09-27 06:03:08'),
(3, 'Marley Construction Ltd', 'Lety Amanda', '0700369300', 'jack@gmail.com', 'Nairobi', 'contractors/de.jfif', NULL, 'contractor', 0, 'nmy679bn', '2026-10-06 03:25:16');

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

--
-- Dumping data for table `member_contractordocument`
--

INSERT INTO `member_contractordocument` (`id`, `doc_type`, `file`, `expiry_date`, `uploaded_at`, `contractor_id`) VALUES
(1, 'registration', 'contractor_docs/dlock.jpg', '2026-10-17', '2026-10-17 07:08:02.897151', 3);

-- --------------------------------------------------------

--
-- Table structure for table `member_contractorpaymentrequest`
--

CREATE TABLE `member_contractorpaymentrequest` (
  `id` bigint(20) NOT NULL,
  `invoice_number` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `description` longtext NOT NULL,
  `invoice_file` varchar(100) NOT NULL,
  `supporting_document` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `reviewer_comments` longtext NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `contractor_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `reviewed_by_id` bigint(20) DEFAULT NULL,
  `submitted_by_id` bigint(20) DEFAULT NULL,
  `paid_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_contractorpaymentrequest`
--

INSERT INTO `member_contractorpaymentrequest` (`id`, `invoice_number`, `title`, `amount`, `description`, `invoice_file`, `supporting_document`, `status`, `reviewer_comments`, `reviewed_at`, `paid_at`, `created_at`, `updated_at`, `contractor_id`, `project_id`, `reviewed_by_id`, `submitted_by_id`, `paid_by_id`) VALUES
(1, 'cvyu789t', 'real estate', '34679087.00', 'on site', 'contractor_invoices/REAL_TIME_CHAT_APPLICATION.docx', 'contractor_invoices/supporting/students_record.xlsx', 'pending', '', NULL, NULL, '2026-10-17 07:11:21.517430', '2026-10-17 07:11:21.517467', 3, 70, NULL, 31, NULL);

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
  `rated_by_id` bigint(20) DEFAULT NULL,
  `contractor_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_contractor_projects`
--

CREATE TABLE `member_contractor_projects` (
  `id` bigint(20) NOT NULL,
  `contractor_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_contractor_projects`
--

INSERT INTO `member_contractor_projects` (`id`, `contractor_id`, `project_id`) VALUES
(3, 2, 31),
(2, 3, 70);

-- --------------------------------------------------------

--
-- Table structure for table `member_discussionreply`
--

CREATE TABLE `member_discussionreply` (
  `id` bigint(20) NOT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `topic_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_discussionreply`
--

INSERT INTO `member_discussionreply` (`id`, `content`, `created_at`, `author_id`, `topic_id`) VALUES
(1, 'yes', '2026-09-18 00:39:10.983299', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `member_discussiontopic`
--

CREATE TABLE `member_discussiontopic` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `tag` varchar(20) NOT NULL,
  `body` longtext DEFAULT NULL,
  `is_pinned` tinyint(1) NOT NULL,
  `is_closed` tinyint(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `author_id` bigint(20) NOT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_discussiontopic`
--

INSERT INTO `member_discussiontopic` (`id`, `title`, `tag`, `body`, `is_pinned`, `is_closed`, `created_at`, `author_id`, `project_id`) VALUES
(1, 'project', 'general', 'hey', 0, 0, '2026-09-18 00:36:33.208971', 1, 11);

-- --------------------------------------------------------

--
-- Table structure for table `member_district`
--

CREATE TABLE `member_district` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `region_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_district`
--

INSERT INTO `member_district` (`id`, `name`, `region_id`) VALUES
(1, 'Capital City', 1),
(2, 'Metro Central', 1),
(3, 'Riverside', 1),
(4, 'Harbor East', 2),
(5, 'Greenfield', 2),
(6, 'Lakeside', 2),
(13, 'Port West', 5),
(14, 'Uplands West', 5),
(15, 'Frontier West', 5),
(16, 'Nairobi', 6),
(17, 'Nyandarua', 1),
(18, 'Nyeri', 1),
(19, 'Kirinyaga', 1),
(20, 'Murang\'a', 1),
(21, 'Kiambu', 1),
(22, 'Mombasa', 7),
(23, 'Kwale', 7),
(24, 'Kilifi', 7),
(25, 'Tana River', 7),
(26, 'Lamu', 7),
(27, 'Taita Taveta', 7),
(28, 'Garissa', 8),
(29, 'Wajir', 8),
(30, 'Mandera', 8),
(31, 'Marsabit', 2),
(32, 'Isiolo', 2),
(33, 'Meru', 2),
(34, 'Tharaka-Nithi', 2),
(35, 'Embu', 2),
(36, 'Kitui', 2),
(37, 'Machakos', 2),
(38, 'Makueni', 2),
(39, 'Turkana', 9),
(40, 'West Pokot', 9),
(41, 'Samburu', 9),
(42, 'Trans Nzoia', 9),
(43, 'Uasin Gishu', 9),
(44, 'Elgeyo-Marakwet', 9),
(45, 'Nandi', 9),
(46, 'Baringo', 9),
(47, 'Laikipia', 9),
(48, 'Nakuru', 9),
(49, 'Narok', 9),
(50, 'Kajiado', 9),
(51, 'Kericho', 9),
(52, 'Bomet', 9),
(53, 'Kakamega', 5),
(54, 'Vihiga', 5),
(55, 'Bungoma', 5),
(56, 'Busia', 5),
(57, 'Siaya', 10),
(58, 'Kisumu', 10),
(59, 'Homa Bay', 10),
(60, 'Migori', 10),
(61, 'Kisii', 10),
(62, 'Nyamira', 10),
(63, 'Riverside', 11);

-- --------------------------------------------------------

--
-- Table structure for table `member_evidenceresponse`
--

CREATE TABLE `member_evidenceresponse` (
  `id` bigint(20) NOT NULL,
  `author_type` varchar(10) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `evidence_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_evidenceresponse`
--

INSERT INTO `member_evidenceresponse` (`id`, `author_type`, `message`, `created_at`, `evidence_id`, `user_id`) VALUES
(1, 'official', 'agreed', '2026-10-18 15:00:10.375455', 3, 30);

-- --------------------------------------------------------

--
-- Table structure for table `member_feedback`
--

CREATE TABLE `member_feedback` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `feedback` longtext DEFAULT NULL,
  `full_name` varchar(50) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_feedback`
--

INSERT INTO `member_feedback` (`id`, `created_at`, `email`, `feedback`, `full_name`, `phone_number`, `project_id`, `rating`) VALUES
(5, '2026-09-18 00:31:23.933132', NULL, NULL, NULL, NULL, NULL, NULL),
(6, '2026-09-18 00:31:23.933132', NULL, NULL, NULL, NULL, NULL, NULL),
(7, '2026-09-18 00:31:23.933132', NULL, NULL, NULL, NULL, NULL, NULL);

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
(1, 'qewr', 'qwer', 'infrastructure', 'qewr', '', 'pending', '2026-06-11 07:17:01.434909', '2026-06-11 07:17:01.434957', 1, NULL, NULL, NULL, 'medium', NULL, NULL, NULL),
(2, 'water and sanitatio', 'their is urgent need to install water to this community to combat water crisis', 'water', 'marsabit', 'requests/house_wMsNgUd.jpg', 'closed', '2026-09-26 06:45:07.981879', '2026-10-16 09:56:15.994353', 31, NULL, NULL, 'weve worked on it', 'urgent', 'REQ-7EDF23A1', '2026-10-16 09:55:59.566369', 31);

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
(2, 'project_media/-5069072835879741643_121.jpg', 'image', '2025-03-06 12:41:04.143274', NULL, NULL, NULL),
(4, 'project_media/IMG_20261004_155002.jpg', 'image', '2026-10-18 06:16:06.818942', 37, NULL, 30),
(6, 'project_media/Screenshot_2026-07-15_215242.png', 'image', '2026-10-18 19:36:15.847163', 41, NULL, 30),
(7, 'project_media/RamogiFM_RamogiFM___Twitter_YV2JIMr.mp4', 'video', '2026-10-18 19:41:19.795780', 41, NULL, 30);

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
  `status` varchar(20) NOT NULL,
  `verification_comments` longtext NOT NULL,
  `verification_status` varchar(20) NOT NULL,
  `verified_at` datetime(6) DEFAULT NULL,
  `verified_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_milestone`
--

INSERT INTO `member_milestone` (`id`, `title`, `description`, `completion_date`, `progress_percentage`, `project_id`, `stage_id`, `due_date`, `status`, `verification_comments`, `verification_status`, `verified_at`, `verified_by_id`) VALUES
(1, 'Itare Dam Multipurpose Project', '\"A multipurpose dam project intended to improve water supply \"\r\n        \"for Nakuru and surrounding areas.\"', '2025-03-12', 100, 24, NULL, '2026-08-16', 'completed', '', 'not_submitted', NULL, NULL),
(2, 'geothermal power project', 'power station installation', '2026-02-16', 67, 35, 1, NULL, 'missed', '', 'not_submitted', NULL, NULL),
(94, 'Land survey and beaconing completed', 'Land survey and beaconing completed', NULL, 20, 70, 86, '2026-03-09', 'in_progress', '', 'not_submitted', NULL, NULL),
(95, 'Demolition of old structures', 'Demolition of old structures', NULL, 95, 70, 86, '2026-04-08', 'in_progress', '', 'not_submitted', NULL, NULL),
(96, 'Site handed over to the main contractor', 'Site handed over to the main contractor', NULL, 99, 70, 86, '2026-05-08', 'in_progress', '', 'not_submitted', NULL, NULL),
(97, 'Excavation and blinding', 'Excavation and blinding', NULL, 35, 70, 87, '2026-06-07', 'in_progress', '', 'not_submitted', NULL, NULL),
(98, 'Reinforcement and column footing', 'Reinforcement and column footing', NULL, 60, 70, 87, '2026-07-07', 'in_progress', '', 'not_submitted', NULL, NULL),
(99, 'Ground floor slab casting', 'Ground floor slab casting', NULL, 80, 70, 87, '2026-08-06', 'in_progress', '', 'not_submitted', NULL, NULL),
(100, 'Walling to first floor', 'Walling to first floor', NULL, 45, 70, 88, '2026-09-05', 'in_progress', '', 'not_submitted', NULL, NULL),
(101, 'Roofing complete on 5 blocks', 'Roofing complete on 5 blocks', NULL, 99, 70, 88, '2026-10-05', 'in_progress', '', 'not_submitted', NULL, NULL),
(102, 'Plastering and internal finishes', 'Plastering and internal finishes', '2026-10-05', 100, 70, 89, '2026-10-05', 'completed', '', 'not_submitted', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_milestonestageevidence`
--

CREATE TABLE `member_milestonestageevidence` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `file_kind` varchar(10) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `milestone_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `stage_id` bigint(20) DEFAULT NULL,
  `uploaded_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(3, 'system', 'System Update', 'Your government project proposal has been submitted.', 1, '2026-08-20 06:21:59.831487', 1, NULL, NULL),
(4, 'issue', 'New project issue', 'cancelled project', 1, '2026-09-23 07:09:43.417673', 1, NULL, '/issues/4/'),
(5, 'issue', 'New project issue', 'dam project', 1, '2026-09-23 08:02:56.396196', 1, NULL, '/issues/5/'),
(6, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:30.847759', 1, NULL, '/project_details/40/?alert=overdue'),
(7, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.856974', 33, NULL, '/project_details/40/?alert=overdue'),
(8, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.861508', 35, NULL, '/project_details/40/?alert=overdue'),
(9, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.865345', 21, NULL, '/project_details/40/?alert=overdue'),
(10, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.869437', 22, NULL, '/project_details/40/?alert=overdue'),
(11, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.873627', 27, NULL, '/project_details/40/?alert=overdue'),
(12, 'deadline', 'Project overdue: Konza Smart City Phase II Development', 'Konza Smart City Phase II Development missed its deadline of 29 Jul 2026 and is 57 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.879048', 29, NULL, '/project_details/40/?alert=overdue'),
(13, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:30.902596', 1, NULL, '/project_details/1/?alert=overdue'),
(14, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.908791', 33, NULL, '/project_details/1/?alert=overdue'),
(15, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.914448', 35, NULL, '/project_details/1/?alert=overdue'),
(16, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.918062', 21, NULL, '/project_details/1/?alert=overdue'),
(17, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.922565', 22, NULL, '/project_details/1/?alert=overdue'),
(18, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.929215', 27, NULL, '/project_details/1/?alert=overdue'),
(19, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 11 Jun 2026 and is 105 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.933188', 29, NULL, '/project_details/1/?alert=overdue'),
(20, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:30.938279', 1, NULL, '/project_details/34/?alert=overdue'),
(21, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.943111', 33, NULL, '/project_details/34/?alert=overdue'),
(22, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.947241', 35, NULL, '/project_details/34/?alert=overdue'),
(23, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.951065', 21, NULL, '/project_details/34/?alert=overdue'),
(24, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.954910', 22, NULL, '/project_details/34/?alert=overdue'),
(25, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.958742', 27, NULL, '/project_details/34/?alert=overdue'),
(26, 'deadline', 'Project overdue: Menengai II Geothermal Power Station', 'Menengai II Geothermal Power Station missed its deadline of 06 Mar 2025 and is 567 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.964725', 29, NULL, '/project_details/34/?alert=overdue'),
(27, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:30.969804', 1, NULL, '/project_details/30/?alert=overdue'),
(28, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.973999', 33, NULL, '/project_details/30/?alert=overdue'),
(29, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.979395', 35, NULL, '/project_details/30/?alert=overdue'),
(30, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.982933', 21, NULL, '/project_details/30/?alert=overdue'),
(31, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.986265', 22, NULL, '/project_details/30/?alert=overdue'),
(32, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.991389', 27, NULL, '/project_details/30/?alert=overdue'),
(33, 'deadline', 'Project overdue: Northlands City', 'Northlands City missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:30.995843', 29, NULL, '/project_details/30/?alert=overdue'),
(34, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:30.999927', 1, NULL, '/project_details/31/?alert=overdue'),
(35, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.003031', 33, NULL, '/project_details/31/?alert=overdue'),
(36, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.006570', 35, NULL, '/project_details/31/?alert=overdue'),
(37, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.010872', 21, NULL, '/project_details/31/?alert=overdue'),
(38, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.014984', 22, NULL, '/project_details/31/?alert=overdue'),
(39, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.018170', 27, NULL, '/project_details/31/?alert=overdue'),
(40, 'deadline', 'Project overdue: Standard Gauge Railway', 'Standard Gauge Railway missed its deadline of 12 Mar 2024 and is 926 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.021454', 29, NULL, '/project_details/31/?alert=overdue'),
(41, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.026677', 1, NULL, '/project_details/27/?alert=overdue'),
(42, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.030798', 33, NULL, '/project_details/27/?alert=overdue'),
(43, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.035316', 35, NULL, '/project_details/27/?alert=overdue'),
(44, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.039151', 21, NULL, '/project_details/27/?alert=overdue'),
(45, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.044547', 22, NULL, '/project_details/27/?alert=overdue'),
(46, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.048761', 27, NULL, '/project_details/27/?alert=overdue'),
(47, 'deadline', 'Project overdue: express way', 'express way missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.052428', 29, NULL, '/project_details/27/?alert=overdue'),
(48, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.057181', 1, NULL, '/project_details/28/?alert=overdue'),
(49, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.062353', 33, NULL, '/project_details/28/?alert=overdue'),
(50, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.067202', 35, NULL, '/project_details/28/?alert=overdue'),
(51, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.071998', 21, NULL, '/project_details/28/?alert=overdue'),
(52, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.083468', 22, NULL, '/project_details/28/?alert=overdue'),
(53, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.088001', 27, NULL, '/project_details/28/?alert=overdue'),
(54, 'deadline', 'Project overdue: Irrigation Farming', 'Irrigation Farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.094019', 29, NULL, '/project_details/28/?alert=overdue'),
(55, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.100414', 1, NULL, '/project_details/29/?alert=overdue'),
(56, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.105999', 33, NULL, '/project_details/29/?alert=overdue'),
(57, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.113040', 35, NULL, '/project_details/29/?alert=overdue'),
(58, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.117329', 21, NULL, '/project_details/29/?alert=overdue'),
(59, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.121106', 22, NULL, '/project_details/29/?alert=overdue'),
(60, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.128739', 27, NULL, '/project_details/29/?alert=overdue'),
(61, 'deadline', 'Project overdue: Kisumu Highway', 'Kisumu Highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.144495', 29, NULL, '/project_details/29/?alert=overdue'),
(62, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.156999', 1, NULL, '/project_details/22/?alert=overdue'),
(63, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.162539', 33, NULL, '/project_details/22/?alert=overdue'),
(64, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.166739', 35, NULL, '/project_details/22/?alert=overdue'),
(65, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.171102', 21, NULL, '/project_details/22/?alert=overdue'),
(66, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.176028', 22, NULL, '/project_details/22/?alert=overdue'),
(67, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.180833', 27, NULL, '/project_details/22/?alert=overdue'),
(68, 'deadline', 'Project overdue: Street development in Dandora, Nairobi', 'Street development in Dandora, Nairobi missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.184973', 29, NULL, '/project_details/22/?alert=overdue'),
(69, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.190420', 1, NULL, '/project_details/18/?alert=overdue'),
(70, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.195737', 33, NULL, '/project_details/18/?alert=overdue'),
(71, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.199654', 35, NULL, '/project_details/18/?alert=overdue'),
(72, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.203786', 21, NULL, '/project_details/18/?alert=overdue'),
(73, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.207656', 22, NULL, '/project_details/18/?alert=overdue'),
(74, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.214527', 27, NULL, '/project_details/18/?alert=overdue'),
(75, 'deadline', 'Project overdue: tree plantation farming', 'tree plantation farming missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.218484', 29, NULL, '/project_details/18/?alert=overdue'),
(76, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.224395', 1, NULL, '/project_details/12/?alert=overdue'),
(77, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.230200', 33, NULL, '/project_details/12/?alert=overdue'),
(78, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.234751', 35, NULL, '/project_details/12/?alert=overdue'),
(79, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.239555', 21, NULL, '/project_details/12/?alert=overdue'),
(80, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.246284', 22, NULL, '/project_details/12/?alert=overdue'),
(81, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.250988', 27, NULL, '/project_details/12/?alert=overdue'),
(82, 'deadline', 'Project overdue: Kisumu Port', 'Kisumu Port missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.256701', 29, NULL, '/project_details/12/?alert=overdue'),
(83, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 1, '2026-09-24 09:19:31.263239', 1, NULL, '/project_details/11/?alert=overdue'),
(84, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.267561', 33, NULL, '/project_details/11/?alert=overdue'),
(85, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.272764', 35, NULL, '/project_details/11/?alert=overdue'),
(86, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.278082', 21, NULL, '/project_details/11/?alert=overdue'),
(87, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.283140', 22, NULL, '/project_details/11/?alert=overdue'),
(88, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.288215', 27, NULL, '/project_details/11/?alert=overdue'),
(89, 'deadline', 'Project overdue: Thika super highway', 'Thika super highway missed its deadline of 09 Mar 2024 and is 929 days overdue. Review the project immediately.', 0, '2026-09-24 09:19:31.294341', 29, NULL, '/project_details/11/?alert=overdue'),
(90, 'system', 'Request Response', 'An official response was posted for REQ-7EDF23A1.', 1, '2026-09-26 06:47:34.111754', 31, NULL, '/government-requests/2/'),
(91, 'tender', 'New tender application', 'zedafrica applied for ULGM123T.', 0, '2026-09-27 06:08:49.787989', 1, NULL, '/tenders/3/'),
(92, 'system', 'Project deleted', 'You deleted the project \"DelTest\" (#50).', 0, '2026-09-30 19:31:59.614295', 45, NULL, '/projectoverview/'),
(93, 'system', 'Project deleted', 'You deleted the project \"DelTest\" (#50).', 0, '2026-10-01 06:06:37.421355', 1, NULL, '/projectoverview/'),
(94, 'system', 'Project deleted', 'You deleted the project \"DelTest\" (#50).', 1, '2026-10-01 06:07:04.335316', 1, NULL, '/projectoverview/'),
(95, 'system', 'Project deleted', 'You deleted the project \"DelTest\" (#50).', 0, '2026-10-01 06:13:29.579640', 1, NULL, '/projectoverview/'),
(97, 'system', 'Project deleted', 'You deleted the project \"DelTest\" (#49).', 0, '2026-10-01 06:16:44.444414', 1, NULL, '/projectoverview/'),
(98, 'system', 'Project deleted', 'You deleted the project \"TrackFlowTest\" (#46).', 0, '2026-10-01 06:38:52.238477', 1, NULL, '/projectoverview/'),
(99, 'system', 'Project deleted', 'You deleted the project \"DelTest\" (#50).', 0, '2026-10-01 06:39:03.041864', 1, NULL, '/projectoverview/'),
(100, 'system', 'Project deleted', 'You deleted the project \"TrackFlowTest3\" (#48).', 0, '2026-10-01 06:39:14.479657', 1, NULL, '/projectoverview/'),
(101, 'system', 'Project deleted', 'You deleted the project \"TrackFlowTest2\" (#47).', 1, '2026-10-01 06:39:25.250786', 1, NULL, '/projectoverview/'),
(102, 'system', 'Project deleted', 'You deleted the project \"StatusFlowTest2\" (#45).', 0, '2026-10-01 06:39:36.752501', 1, NULL, '/projectoverview/'),
(103, 'system', 'Project deleted', 'You deleted the project \"StatusFlowTest\" (#44).', 0, '2026-10-01 06:39:47.906327', 1, NULL, '/projectoverview/'),
(104, 'system', 'Project deleted', 'You deleted the project \"StatusFlowTest\" (#43).', 0, '2026-10-01 06:39:56.898428', 1, NULL, '/projectoverview/'),
(105, 'system', 'Project deleted', 'You deleted the project \"AssignTest\" (#42).', 0, '2026-10-01 06:40:04.876601', 1, NULL, '/projectoverview/'),
(106, 'tender', 'Tender awarded', 'Congratulations! Your bid for ULGM123T has been awarded.', 1, '2026-10-06 03:37:47.608048', 1, NULL, '/track_application/'),
(107, 'system', 'Project deleted', 'You deleted the project \"T2\" (#72).', 0, '2026-10-16 09:20:59.559703', 1, NULL, '/projectoverview/'),
(108, 'system', 'Project deleted', 'You deleted the project \"T\" (#71).', 0, '2026-10-16 09:21:13.610274', 1, NULL, '/projectoverview/'),
(109, 'system', 'Project deleted', 'You deleted the project \"MT\" (#75).', 0, '2026-10-16 09:26:19.142059', 1, NULL, '/projectoverview/'),
(110, 'system', 'Request Response', 'An official response was posted for REQ-7EDF23A1.', 1, '2026-10-16 09:54:39.166288', 31, NULL, '/government-requests/2/'),
(111, 'system', 'Request Response', 'An official response was posted for REQ-7EDF23A1.', 1, '2026-10-16 09:55:59.577062', 31, NULL, '/government-requests/2/'),
(112, 'system', 'New response on your evidence report', 'An official responded to your evidence \"poor planning\": agreed', 0, '2026-10-18 15:00:10.378555', 25, NULL, '/citizen/evidence/3/');

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
(5, 'The project is not clerly showing the milstones, im curious', '2026-02-23 07:38:01.415471', 1, 34, 27),
(6, 'certisfied', '2026-02-23 08:03:52.925874', 1, 37, 25),
(7, 'good', '2026-08-19 05:19:00.116844', 1, 39, 30),
(8, 'not good at all', '2026-09-23 06:57:50.390296', 1, 34, 1);

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

--
-- Dumping data for table `member_progressreport`
--

INSERT INTO `member_progressreport` (`id`, `description`, `report_title`, `report_file`, `created_at`, `project_id`, `created_by_id`) VALUES
(1, 'hjm,', 'hgjhk', 'progress_reports/IMG_20231129_164813_1.jpg', '2026-09-23 17:56:39.570307', 11, 1),
(2, 'mhgbuyjh', 'mnhg', 'progress_reports/house_wMsNgUd.jpg', '2026-09-24 09:49:04.850837', 11, 1);

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

--
-- Dumping data for table `member_progressupdate`
--

INSERT INTO `member_progressupdate` (`id`, `description`, `date_reported`, `progress_percentage`, `project_id`, `stage_id`, `challenges`, `next_steps`, `reported_by_id`) VALUES
(97, 'Month 1 update: Surveyors finished beaconing the 12-acre site; fencing of the compound started.', '2026-03-08 21:00:00.000000', 2, 70, 86, NULL, NULL, 31),
(98, 'Month 2 update: Old farm structures demolished and debris cleared. Access road graded.', '2026-04-07 21:00:00.000000', 8, 70, 86, NULL, NULL, 31),
(99, 'Month 3 update: Site clearance 100% complete. The site was formally handed over to the contractor.', '2026-05-07 21:00:00.000000', 19, 70, 86, NULL, NULL, 31),
(100, 'Month 4 update: Foundation excavation started on Blocks A and B; blinding poured.', '2026-06-06 21:00:00.000000', 23, 70, 87, NULL, NULL, 31),
(101, 'Month 5 update: Reinforcement ongoing on Blocks A–D. Concrete batching plant commissioned on site.', '2026-07-06 21:00:00.000000', 30, 70, 87, NULL, NULL, 31),
(102, 'Month 6 update: Ground slabs for Blocks A and B cast; steel fixing started on Block C.', '2026-08-05 21:00:00.000000', 39, 70, 87, NULL, NULL, 31),
(103, 'Month 7 update: Walling to first floor level reached on Blocks A and B. Block B roof trusses delivered.', '2026-09-04 21:00:00.000000', 44, 70, 88, NULL, NULL, 31),
(104, 'Month 8 update: Roofing complete on five blocks. Plumbing and electrical first-fix started.', '2026-10-04 21:00:00.000000', 55, 70, 88, NULL, NULL, 31),
(105, 'Month 9 update: Plastering and tiling underway in Blocks A–C; painting started in Block A.', '2026-10-04 21:00:00.000000', 62, 70, 89, NULL, NULL, 31),
(106, 'Foundation pour started', '2026-10-06 03:25:16.927443', 45, 70, 86, NULL, NULL, 31),
(107, 'done', '2026-10-17 06:46:06.568604', 100, 37, NULL, NULL, NULL, 30);

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
(1, 'Kisumu Highway', 'A perfect highway joining most counties promoting business opportunities', 'Kisumu', 'Governmental Agencies', '23000000.00', '1000000.00', 'projects/dlock.jpg', '2026-04-22', '2026-06-11', 'citizens', 'agencies', '67', 'delayed', 'good economic network', NULL, 'George Mbola', 'felixngwono@gmail.com', '2026-08-20 05:39:19.593664', '- fostering good economy\n[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, '', '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', 'PRJ-4E95B81D', NULL, '2026-08-20 05:39:19.593687', 1, 1, NULL),
(11, 'Thika super highway', 'Repair and maintanance of Thika super highway', 'Thika', 'KeNHA', '9999999999.99', '1000000.00', 'projects/thika.jpg', '2024-03-01', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(12, 'Kisumu Port', 'Project extension of L.Victoria port has reached its completion stage.', 'Kisumu', 'National government', '147345646.00', NULL, 'projects/login.PNG', '2024-03-02', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 8, 1, NULL),
(18, 'tree plantation farming', 'tree plantatiion farming in Nakuru county', 'kampi ya moto- Nakuru', 'National government', '34567890.00', NULL, 'projects/mau_mau.jpg', '2024-03-06', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 6, 1, NULL),
(20, 'Menengai II Geothermal Power Station', 'Will be done along Menengai to boost power supply in Nakuru city', 'Menengai Crater, Nakuru County', 'national Government and the NGO\'s', '10000000.00', NULL, 'projects/im.jpg', '2025-12-06', '2027-12-06', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from upcoming to ongoing on 2026-09-23 16:56.', NULL, NULL, 20, 'Completion cannot be estimated until progress or stage updates are recorded.', NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 5, 1, NULL),
(22, 'Street development in Dandora, Nairobi', 'The project in Dandora focuses on the implementation of a ‘model street’ in a low income neighbourhood in Nairobi. Previously a well-planned neighborhood, Dandora has gradually degenerated to almost slum status. The implementation site, a street in Dandora, was selected as it is an essential part of the ‘Must Seed’ strategy, a step by step process of making small interventions that have large impact in the community.', 'Dandora-Nairobi', 'Placemakers, KUWA, Dandora Transformation League (DTL)', '1654879.00', NULL, 'projects/dandora_9E3A1mg.jpg', '2024-03-07', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 2, 1, NULL),
(24, 'Building of a Dam', 'Dam Description', 'Kisumu', 'National Government', '30000000.00', NULL, 'projects/pacho_7f3AtUZ.jpg', '2024-03-12', '2024-03-09', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to completed on 2026-09-23 16:56.', '2026-09-23', NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(27, 'express way', 'Completion of expressway along Haile Sellasie avenue', 'Nairobi', 'National government', '34500000.00', NULL, 'projects/expressway_SwK9e6V.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(28, 'Irrigation Farming', 'The government is yet to initiate irrigation farming along the seven Folks dams of R.Tana', 'Mount Kenya region', 'National government', '4579867.00', NULL, 'projects/tana_river.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 6, 1, NULL),
(29, 'Kisumu Highway', 'Kisumu started as a small town called Kisuma. Grey due to the greate snaking metal rod of Jorochere', 'Kisumu', 'Nyong\'o government', '25895642.00', NULL, 'projects/dala.jpg', '2024-03-08', '2024-03-09', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:00.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:02.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:04.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:15.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:16.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:16.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:17.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:18.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:18.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:24.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:27.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:33.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(30, 'Northlands City', 'The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'Ruiru, Nairobi city', 'Governmental Agencies', '23000000.00', NULL, 'projects/thika_Ua6mF2X.jpg', '2024-03-12', '2024-03-12', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:00.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:02.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:04.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:15.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:16.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:16.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:17.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:18.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:18.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:24.\n[Auto] Status changed from delayed to ongoing on 2026-09-23 17:27.\n[Auto] Status changed from ongoing to delayed on 2026-09-23 17:33.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 7, 1, NULL),
(31, 'Standard Gauge Railway', 'Construction of the Mombasa-Malaba standard gauge railway was launched by President Uhuru Kenyatta on November 28, 2013.\r\n\r\nPhase one of the project – from Mombasa to Nairobi was completed in 2017.', 'Mombasa', 'Mombasa county government', '34000000.00', NULL, 'projects/sgr.png', '2024-03-12', '2024-03-12', NULL, NULL, NULL, 'delayed', NULL, NULL, 'Zedafrica', NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(33, 'Mau Mau Road', 'Construction of a 540km road that seeks to honour the role of Mau Mau freedom fighters in the liberation of Kenya from colonialists is underway, offering three central Kenya counties a new artery into Nairobi.\r\n\r\nChristened Mau Mau Road, the highway starts at Gataka in Limuru, and then passes through Kamahindu and Kibichoi in Kiambu before negotiating its way through Kinyona in Kigumo and Ichichi in Murang’a.', 'Limuru, Nairobi', 'National government', '2121000000.00', NULL, 'projects/expressway.jpg', '2024-03-12', '2027-03-12', NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(34, 'Menengai II Geothermal Power Station', 'A 35 MW geothermal power plant under construction in the Menengai Crater, aimed at harnessing geothermal energy to boost Kenya\'s electricity supply.', 'Menengai Crater, Nakuru County', 'High; expected to be commissioned in 2025 to meet growing energy demands.', '20000000.00', NULL, 'projects/Architecture-Portfolio-Cover-1024x683.webp', '2025-02-19', '2025-03-06', NULL, NULL, NULL, 'delayed', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from ongoing to delayed on 2026-09-23 16:56.', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 5, 1, NULL),
(35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ongoing', NULL, NULL, NULL, NULL, NULL, '[Auto] Status changed from none to ongoing on 2026-09-23 16:56.', NULL, NULL, 30, 'Completion cannot be estimated until progress or stage updates are recorded.', NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(36, 'Expansion of Tana River', 'Due to frequent blockages of the river banks, the government  considered its improval', 'Tana River Machakos County', 'National government', '9999999999.99', NULL, 'projects/tana_river_Laq2K1W.jpg', '2024-03-07', '2025-03-12', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(37, 'Nairobi Railway City', 'After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.', 'Nairobi', 'National government', '0.00', NULL, 'projects/sgr_saMexVe.png', '2025-03-13', '2028-02-12', 'Railway users', 'multi billionares', 'upcoming', 'completed', 'speeding the rate of transportation and reducing the trafficking in public roads', NULL, 'George Mbola', 'info@lapsset.go.ke', '2026-06-10 13:48:50.457266', 'poornproject management\n[Auto] Status changed from upcoming to ongoing on 2026-09-23 16:56.\ndone', '2026-10-17', NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(39, 'Infrastructure and Energy', 'Magetta Island Solar Mini-grid: A 60-kilowatt solar project in Siaya County, operational as of September 2025, providing power to over 1,400 households and businesses.', 'Siaya County', 'County Government', '0.00', NULL, 'projects/house_wMsNgUd.jpg', '2024-06-04', '2026-02-21', 'citizens', 'county government', '', 'completed', '- Ease of access of clean and free energy', NULL, 'George Mbola', 'felixngwono@gmail.com', '0000-00-00 00:00:00.000000', 'free and favourable energy', NULL, NULL, NULL, NULL, NULL, '2026-08-02 17:06:05.935961', NULL, NULL, 0, 1, 'medium', NULL, NULL, '2026-08-02 17:06:06.680646', 1, 1, NULL),
(40, 'Konza Smart City Phase II Development', '\"Construction of roads, ICT infrastructure, utility services, \"\r\n        \"commercial buildings and residential facilities for Konza Smart City.', 'Konza, Machakos County', 'Konza Technopolis Development Authority (KoTDA)', '56000000.00', '1020000.00', 'projects/assignment-alukwe.jpeg', '2026-07-28', '2026-07-29', 'Residents of Machakos County, ICT companies, investors, \"\r\n        \"students, entrepreneurs and SMEs.', 'KoTDA, National Treasury, Ministry of ICT, Machakos County Government, \"\r\n        \"Private Investors, Local Communities.', '\"Road works completed (45%), ICT infrastructure completed (38%), \"\r\n        \"utility installations ongoing before suspension.', 'delayed', 'The project has attracted investors and improved supporting \"\r\n        \"infrastructure, but expected economic benefits have been delayed.', 'Eng. James Mwangi', 'China State Construction Engineering Corporation', 'info@konza.go.ke', '2026-08-20 05:37:30.195671', '\"Project suspended pending Treasury approval, contractor claims settlement, \"\r\n        \"and completion of an independent audit.\n[Auto] Status changed from draft to delayed on 2026-09-23 16:56.', '2026-08-03', '2026-08-27', 56, '\"AI analysis indicates that the project has been suspended because \"\r\n        \"of procurement reviews, delayed funding disbursement, and contractual disputes', 'projects/covers/assignment-alukwe.jpeg', '2026-08-02 21:13:49.935033', NULL, 'Government of Kenya and Public-Private Partnerships (PPP)', 0, 1, 'high', 'PRJ-KEN-2026-001', 'Ministry of Information, Communications and the Digital Economy', '2026-08-20 05:37:30.195712', 1, 1, NULL),
(41, 'High Grand Falls Multipurpose Dam Project', 'A proposed multipurpose dam project intended to support hydropower generation,\r\nirrigation and water supply. The project was subsequently cancelled following\r\ngovernment review of the project development process.', 'Tana River / Tharaka-Nithi region', 'National Government of Kenya', '337000000000.00', '20500000.00', 'projects/038e478f9c094c01be86505e030c974d_aHmL2Zl.jpg', '2026-09-18', '2026-10-10', 'Public Private Partnership', 'Public Private Partnership', '10%', 'cancelled', 'Public Private Partnership', 'Eng. James Mwangi', 'China State Construction Engineering Corporation', 'felixngwono@gmail.com', '2026-09-18 06:47:32.446778', 'Public Private Partnership', '2026-10-10', '2026-10-02', 9, 'Public Private Partnership', 'projects/covers/db34f6bb01614f8d96c65b36d8356f7f.jpg', '2026-09-18 06:47:32.446896', 1, 'Public Private Partnership', 0, 1, 'critical', 'GT-KEN-DAM-001', NULL, '2026-09-18 06:47:32.446955', 5, 19, NULL),
(70, 'Affordable Housing Program — Riverside Estate (500 Units)', 'A mixed-income affordable housing development delivering 500 residential units across 10 blocks, with community facilities, green spaces and a commercial strip. Targeted at low- and middle-income families on the housing waiting list. Funded through a blended public-private model and monitored publicly from ground-breaking to handover.', 'Riverside, Metropolitan', 'State Department of Housing', '450000000.00', '314500000.00', '', '2026-02-07', '2028-10-04', '500 low- and middle-income households', NULL, 'Plastering and tiling underway in Blocks A–C; painting started in Block A.', 'completed', NULL, 'Eng. A. Mwangi', 'Marley Construction Ltd', NULL, '2026-10-05 18:27:27.923562', '[Auto] Status changed from ongoing to completed on 2026-10-05 18:27.', '2026-10-05', NULL, NULL, NULL, '', '2026-10-05 18:26:46.622854', NULL, 'Blended (Treasury 60% / PPP 40%)', 1, 1, 'high', 'PRJ-171EF8C9', 'National Construction Authority', '2026-10-05 18:27:27.923578', NULL, 63, NULL),
(73, 'T2', NULL, NULL, NULL, NULL, NULL, '', '2099-01-01', NULL, NULL, NULL, NULL, 'upcoming', NULL, NULL, NULL, NULL, '2026-10-05 18:31:20.649692', NULL, NULL, NULL, NULL, NULL, '', '2026-10-05 18:31:20.649767', NULL, NULL, 0, 1, 'medium', 'PRJ-77F26DF2', NULL, '2026-10-05 18:31:20.649804', NULL, NULL, NULL),
(74, 'T2x', NULL, NULL, NULL, NULL, NULL, '', '2099-01-01', NULL, NULL, NULL, NULL, 'upcoming', NULL, NULL, NULL, NULL, '2026-10-05 18:31:30.706284', NULL, NULL, NULL, NULL, NULL, '', '2026-10-05 18:31:30.706367', NULL, NULL, 0, 1, 'medium', 'PRJ-6FDA587F', NULL, '2026-10-05 18:31:30.706402', NULL, NULL, NULL),
(77, 'Itare Dam Multipurpose Project', 'Construction of a multipurpose dam and associated water supply infrastructure intended to improve access to clean water for Nakuru City and surrounding communities. The project includes a 57-metre-high dam, a water treatment plant with a planned capacity of 100,000 cubic metres per day, and approximately 110 km of bulk water conveyance pipeline. Implementation has faced contractual disputes and prolonged delays.', 'Kuresoi, Nakuru County, Kenya', 'A multipurpose dam intended to supply water to Nakuru and surrounding areas. In October 2025, the Ministry of Water reported that the project had stalled at 32% completion while steps toward resuming', '34999999999.69', '45000000.00', 'projects/dfd.PNG', '2025-06-17', '2027-03-17', 'Residents of Nakuru City, Kuresoi North and South, \"\r\n        \"Molo, Njoro, and surrounding areas', 'Ministry of Water, Central Rift Valley Water Works \"\r\n        \"Development Agency, contractors, development partners, \"\r\n        \"and affected communities', '32%', 'stalled', '', NULL, NULL, 'felixngwono@gmail.com', '2026-10-17 11:03:27.868213', '', '2026-10-17', NULL, NULL, NULL, 'projects/covers/work_space.png', '2026-10-17 11:03:27.868267', 30, 'Government of Kenya and international financing arrangements; verify the current funding structure', 0, 1, 'critical', 'GOV-WTR-ITARE-001', 'Ministry of Water, Sanitation and Irrigation', '2026-10-17 11:03:27.868289', 2, 48, NULL),
(78, 'Rural Road Rehabilitation Project', 'Rehabilitation of rural access roads to improve \"\r\n            \"transport, market access, and connectivity \"\r\n            \"for surrounding communities.', 'Turkana County, Kenya', 'Relevant County Government', '63000000000.00', '43000000.00', '', '2024-03-21', '2028-02-03', 'Local residents, farmers, traders', 'County government, contractors, residents', '45%', 'ongoing', '', NULL, NULL, NULL, '2026-10-17 11:10:25.349716', '', '2028-02-03', NULL, NULL, NULL, '', '2026-10-17 11:10:25.349766', 30, 'Government development budget', 0, 1, 'high', 'PRJ-084C49CB', 'ministry of roads', '2026-10-17 11:10:25.349788', 1, 39, NULL),
(79, 'Public School Facilities Upgrade', 'Construction and rehabilitation of classrooms \"\r\n            \"and sanitation facilities to improve the \"\r\n            \"quality and safety of learning environments.', 'Kisumu County, Kenya', 'Relevant Education Authority', NULL, NULL, 'projects/Screenshot_16.png', NULL, NULL, 'School learners and teachers', 'Schools, parents, education officials', '0', 'upcoming', '', NULL, NULL, NULL, '2026-10-17 11:13:24.397161', '', NULL, NULL, NULL, NULL, '', '2026-10-17 11:13:24.397227', 30, 'Education development funding', 0, 1, 'medium', 'PRJ-3AE230BF', NULL, '2026-10-17 11:13:24.397256', 4, 58, NULL);

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

--
-- Dumping data for table `member_projectcategory`
--

INSERT INTO `member_projectcategory` (`id`, `name`, `description`, `icon`, `color`) VALUES
(1, 'Roads & Transport', 'Road construction, bridges and public transport infrastructure.', 'fa-road', '#3b82f6'),
(2, 'Water & Sanitation', 'Water supply, drainage and sanitation projects.', 'fa-droplet', '#06b6d4'),
(3, 'Health', 'Hospitals, clinics and public health facilities.', 'fa-hospital', '#ef4444'),
(4, 'Education', 'Schools, colleges and educational infrastructure.', 'fa-graduation-cap', '#8b5cf6'),
(5, 'Energy', 'Power generation, transmission and rural electrification.', 'fa-bolt', '#f59e0b'),
(6, 'Agriculture', 'Irrigation, farming support and food security programs.', 'fa-wheat-awn', '#22c55e'),
(7, 'Housing', 'Affordable housing and urban settlement projects.', 'fa-house', '#ec4899'),
(8, 'ICT', 'Digital infrastructure, connectivity and e-government.', 'fa-server', '#6366f1'),
(9, 'Environment', 'Conservation, forestry, waste management and climate resilience.', 'fa-leaf', '#10b981'),
(10, 'Trade & Markets', 'Markets, trade centres and commercial infrastructure.', 'fa-store', '#f97316'),
(11, 'Security', 'Police posts, courts and public safety facilities.', 'fa-shield-halved', '#64748b');

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
  `recorded_by_id` bigint(20) DEFAULT NULL,
  `budget_id` bigint(20) DEFAULT NULL,
  `stage_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_projectexpense`
--

INSERT INTO `member_projectexpense` (`id`, `title`, `category`, `amount`, `description`, `date`, `project_id`, `receipt`, `recorded_by_id`, `budget_id`, `stage_id`) VALUES
(1, 'tarmac', 'materials', '1000000.00', 'its over quoted', '2026-08-20', 1, 'receipts/Sure.docx', 30, NULL, NULL),
(3, 'da project', 'materials', '20000000.00', '', '2026-09-23', 41, '', 1, NULL, NULL),
(4, 'tarmac and trucks', 'equipment', '1000000.00', '', '2026-09-24', 11, '', 1, NULL, NULL),
(5, 'konza city', 'consultancy', '20000.00', '', '2026-09-30', 40, '', 1, NULL, NULL);

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
  `stage_name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `progress_percentage` decimal(5,2) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `order` int(10) UNSIGNED NOT NULL CHECK (`order` >= 0),
  `completed_on` date DEFAULT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_projectstage`
--

INSERT INTO `member_projectstage` (`id`, `stage_name`, `description`, `start_date`, `end_date`, `progress_percentage`, `project_id`, `is_current`, `order`, `completed_on`, `status`) VALUES
(1, 'construction', 'nghfdtygh', '2024-03-12', '2024-03-09', '60.00', 30, 0, 0, NULL, 'not_started'),
(2, 'construction', '10km done', '2026-08-06', '2027-01-29', '78.00', 29, 1, 12, NULL, 'not_started'),
(3, 'construction', 'dam will provide energy accross the country', '2026-09-22', '2027-01-30', '50.00', 41, 1, 2, NULL, 'not_started'),
(4, 'planning', NULL, NULL, NULL, '0.00', 11, 0, 1, NULL, 'not_started'),
(5, 'procurement', NULL, NULL, NULL, '0.00', 11, 0, 2, NULL, 'not_started'),
(6, 'site_clearance', NULL, NULL, NULL, '0.00', 11, 0, 3, NULL, 'not_started'),
(7, 'foundation', NULL, NULL, NULL, '0.00', 11, 0, 4, NULL, 'not_started'),
(8, 'superstructure', NULL, NULL, NULL, '0.00', 11, 0, 5, NULL, 'not_started'),
(9, 'finishing', NULL, NULL, NULL, '0.00', 11, 0, 6, NULL, 'not_started'),
(10, 'inspection', NULL, NULL, NULL, '0.00', 11, 0, 7, NULL, 'not_started'),
(11, 'construction', NULL, NULL, NULL, '0.00', 11, 0, 8, NULL, 'not_started'),
(12, 'completion', NULL, NULL, NULL, '0.00', 11, 0, 9, NULL, 'not_started'),
(13, 'monitoring', NULL, NULL, NULL, '0.00', 11, 0, 10, NULL, 'not_started'),
(14, 'handover', NULL, NULL, NULL, '0.00', 11, 0, 11, NULL, 'not_started'),
(15, 'others', NULL, NULL, NULL, '0.00', 11, 0, 12, NULL, 'on_hold'),
(28, 'planning', NULL, NULL, NULL, '0.00', 24, 0, 1, NULL, 'not_started'),
(29, 'procurement', NULL, NULL, NULL, '0.00', 24, 0, 2, NULL, 'not_started'),
(30, 'site_clearance', NULL, NULL, NULL, '0.00', 24, 0, 3, NULL, 'not_started'),
(31, 'foundation', NULL, NULL, NULL, '0.00', 24, 0, 4, NULL, 'not_started'),
(32, 'superstructure', NULL, NULL, NULL, '0.00', 24, 0, 5, NULL, 'not_started'),
(33, 'finishing', NULL, NULL, NULL, '0.00', 24, 0, 6, NULL, 'not_started'),
(34, 'inspection', NULL, NULL, NULL, '0.00', 24, 0, 7, NULL, 'not_started'),
(35, 'construction', NULL, NULL, NULL, '0.00', 24, 0, 8, NULL, 'not_started'),
(36, 'completion', NULL, NULL, NULL, '0.00', 24, 0, 9, NULL, 'not_started'),
(37, 'monitoring', NULL, NULL, NULL, '0.00', 24, 0, 10, NULL, 'not_started'),
(38, 'handover', NULL, NULL, NULL, '0.00', 24, 0, 11, NULL, 'not_started'),
(39, 'others', NULL, NULL, NULL, '0.00', 24, 0, 12, NULL, 'not_started'),
(40, 'planning', NULL, NULL, NULL, '0.00', 41, 0, 1, NULL, 'not_started'),
(41, 'procurement', NULL, NULL, NULL, '0.00', 41, 0, 2, NULL, 'not_started'),
(42, 'site_clearance', NULL, NULL, NULL, '0.00', 41, 0, 3, NULL, 'not_started'),
(43, 'foundation', NULL, NULL, NULL, '0.00', 41, 0, 4, NULL, 'not_started'),
(44, 'superstructure', NULL, NULL, NULL, '0.00', 41, 0, 5, NULL, 'not_started'),
(45, 'finishing', NULL, NULL, NULL, '0.00', 41, 0, 6, NULL, 'not_started'),
(46, 'inspection', NULL, NULL, NULL, '0.00', 41, 0, 7, NULL, 'not_started'),
(47, 'completion', NULL, NULL, NULL, '0.00', 41, 0, 9, NULL, 'not_started'),
(48, 'monitoring', NULL, NULL, NULL, '0.00', 41, 0, 10, NULL, 'not_started'),
(49, 'handover', NULL, NULL, NULL, '0.00', 41, 0, 11, NULL, 'not_started'),
(50, 'others', NULL, NULL, NULL, '0.00', 41, 0, 12, NULL, 'not_started'),
(86, 'Site Clearance & Land Preparation', NULL, '2026-02-07', '2026-05-08', '71.00', 70, 0, 1, NULL, 'in_progress'),
(87, 'Foundation & Substructure', NULL, '2026-05-08', '2026-08-06', '100.00', 70, 0, 4, NULL, 'completed'),
(88, 'Superstructure / Main Works', NULL, '2026-08-06', '2026-11-04', '100.00', 70, 0, 7, NULL, 'completed'),
(89, 'Finishing & Fittings', NULL, '2026-10-05', '2027-01-03', '100.00', 70, 0, 9, '2026-10-05', 'completed'),
(91, 'planning', NULL, NULL, NULL, '0.00', 73, 0, 0, NULL, 'not_started'),
(93, 'ground breking', 'ongoing/inprogress', '2026-10-17', '2026-10-30', '2.00', 70, 1, 10, NULL, 'in_progress'),
(94, 'planning', NULL, NULL, NULL, '0.00', 77, 0, 1, NULL, 'not_started'),
(95, 'procurement', NULL, NULL, NULL, '0.00', 77, 0, 2, NULL, 'not_started'),
(96, 'site_clearance', NULL, NULL, NULL, '0.00', 77, 0, 3, NULL, 'not_started'),
(97, 'foundation', NULL, NULL, NULL, '0.00', 77, 0, 4, NULL, 'not_started'),
(98, 'superstructure', NULL, NULL, NULL, '0.00', 77, 0, 5, NULL, 'not_started'),
(99, 'finishing', NULL, NULL, NULL, '0.00', 77, 0, 6, NULL, 'not_started'),
(100, 'inspection', NULL, NULL, NULL, '0.00', 77, 0, 7, NULL, 'not_started'),
(101, 'construction', NULL, NULL, NULL, '0.00', 77, 0, 8, NULL, 'not_started'),
(102, 'completion', NULL, NULL, NULL, '0.00', 77, 0, 9, NULL, 'not_started'),
(103, 'monitoring', NULL, NULL, NULL, '0.00', 77, 0, 10, NULL, 'not_started'),
(104, 'handover', NULL, NULL, NULL, '0.00', 77, 0, 11, NULL, 'not_started'),
(105, 'others', NULL, NULL, NULL, '0.00', 77, 0, 12, NULL, 'not_started'),
(106, 'planning', NULL, NULL, NULL, '0.00', 78, 0, 1, NULL, 'not_started'),
(107, 'procurement', NULL, NULL, NULL, '0.00', 78, 0, 2, NULL, 'not_started'),
(108, 'site_clearance', NULL, NULL, NULL, '0.00', 78, 0, 3, NULL, 'not_started'),
(109, 'foundation', NULL, NULL, NULL, '0.00', 78, 0, 4, NULL, 'not_started'),
(110, 'superstructure', NULL, NULL, NULL, '0.00', 78, 0, 5, NULL, 'not_started'),
(111, 'finishing', NULL, NULL, NULL, '0.00', 78, 0, 6, NULL, 'not_started'),
(112, 'inspection', NULL, NULL, NULL, '0.00', 78, 0, 7, NULL, 'not_started'),
(113, 'construction', NULL, NULL, NULL, '0.00', 78, 0, 8, NULL, 'not_started'),
(114, 'completion', NULL, NULL, NULL, '0.00', 78, 0, 9, NULL, 'not_started'),
(115, 'monitoring', NULL, NULL, NULL, '0.00', 78, 0, 10, NULL, 'not_started'),
(116, 'handover', NULL, NULL, NULL, '0.00', 78, 0, 11, NULL, 'not_started'),
(117, 'others', NULL, NULL, NULL, '0.00', 78, 0, 12, NULL, 'not_started'),
(118, 'planning', NULL, NULL, NULL, '0.00', 79, 0, 1, NULL, 'not_started'),
(119, 'procurement', NULL, NULL, NULL, '0.00', 79, 0, 2, NULL, 'not_started'),
(120, 'site_clearance', NULL, NULL, NULL, '0.00', 79, 0, 3, NULL, 'not_started'),
(121, 'foundation', NULL, NULL, NULL, '0.00', 79, 0, 4, NULL, 'not_started'),
(122, 'superstructure', NULL, NULL, NULL, '0.00', 79, 0, 5, NULL, 'not_started'),
(123, 'finishing', NULL, NULL, NULL, '0.00', 79, 0, 6, NULL, 'not_started'),
(124, 'inspection', NULL, NULL, NULL, '0.00', 79, 0, 7, NULL, 'not_started'),
(125, 'construction', NULL, NULL, NULL, '0.00', 79, 0, 8, NULL, 'not_started'),
(126, 'completion', NULL, NULL, NULL, '0.00', 79, 0, 9, NULL, 'not_started'),
(127, 'monitoring', NULL, NULL, NULL, '0.00', 79, 0, 10, NULL, 'not_started'),
(128, 'handover', NULL, NULL, NULL, '0.00', 79, 0, 11, NULL, 'not_started'),
(129, 'others', NULL, NULL, NULL, '0.00', 79, 0, 12, NULL, 'not_started');

-- --------------------------------------------------------

--
-- Table structure for table `member_projectstatushistory`
--

CREATE TABLE `member_projectstatushistory` (
  `id` bigint(20) NOT NULL,
  `from_status` varchar(20) DEFAULT NULL,
  `to_status` varchar(20) NOT NULL,
  `source` varchar(20) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `changed_at` datetime(6) NOT NULL,
  `changed_by_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_projectstatushistory`
--

INSERT INTO `member_projectstatushistory` (`id`, `from_status`, `to_status`, `source`, `note`, `changed_at`, `changed_by_id`, `project_id`) VALUES
(32, 'ongoing', 'completed', 'auto', NULL, '2026-10-05 18:27:17.438616', NULL, 70),
(33, 'ongoing', 'completed', 'auto', NULL, '2026-10-05 18:27:17.475969', NULL, 70),
(37, 'ongoing', 'completed', 'assignee', NULL, '2026-10-17 06:46:06.563445', 30, 37);

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
(1, 'Ground Breaking', 1, '20000000.00', 'TFD4QF1XD6', 'felixngwono@gmail.com', '+971527318502', '2026-08-20 04:35:20.558766', 'building of bridges accross the country', 'Eng Bob Marley', NULL, 'divisions/08372a7b9de64e97936b3a4ed6d7aa79.jpg', 1, 'building  bridge initiated', 'capital complex', '2026-09-01 16:54:23.605229'),
(4, 'Initiation stage', NULL, '0.00', NULL, NULL, NULL, '2026-08-20 04:35:20.558766', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2026-08-20 04:35:22.057113'),
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

--
-- Dumping data for table `member_project_division_project_name`
--

INSERT INTO `member_project_division_project_name` (`id`, `project_division_id`, `project_id`) VALUES
(1, 1, 1);

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

--
-- Dumping data for table `member_region`
--

INSERT INTO `member_region` (`id`, `name`, `code`) VALUES
(1, 'Central', 'CEN'),
(2, 'Eastern', 'EAS'),
(5, 'Western', 'WES'),
(6, 'Nairobi', 'NBO'),
(7, 'Coast', 'CST'),
(8, 'North Eastern', 'NEA'),
(9, 'Rift Valley', 'RVT'),
(10, 'Nyanza', 'NYZ'),
(11, 'Metropolitan', 'MET');

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
(3, 'wqedf', 'asdfg', 'issue_evidence/sgr.png', '2025-03-11 14:37:45.210463', 1, 'Resolved', 31, 22, NULL, NULL, 'moderate', '2026-08-02 17:06:08.484946'),
(4, 'cancelled project', 'the project lacked resources and could not continue as planned', 'issue_evidence/24_Jun_2025_1119_pm.txt', '2026-09-23 07:09:43.409662', 0, 'pending', 41, 1, NULL, NULL, 'moderate', '2026-09-23 07:09:43.409701'),
(5, 'dam project', 'the projct is slowly progressing. slow development less opportinities', '', '2026-09-23 08:02:56.385477', 0, 'pending', 41, 1, NULL, NULL, 'moderate', '2026-09-23 08:02:56.385507'),
(7, 'consultancy', 'their is no possible way consoltancy costs that much', '', '2026-09-30 18:59:21.127384', 0, 'pending', 40, 1, NULL, NULL, 'high', '2026-09-30 18:59:21.127414');

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
  `stage_id` bigint(20) DEFAULT NULL,
  `reported_by_id` bigint(20) DEFAULT NULL,
  `weather_conditions` varchar(100) DEFAULT NULL,
  `workforce_count` int(11) DEFAULT NULL,
  `contractor_id` bigint(20) DEFAULT NULL,
  `stage_description` varchar(255) DEFAULT NULL,
  `corrective_actions` longtext NOT NULL,
  `delay_reason` longtext NOT NULL,
  `review_status` varchar(20) NOT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `reviewed_by_id` bigint(20) DEFAULT NULL,
  `reviewer_comments` longtext NOT NULL,
  `supporting_document` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_stagereport`
--

INSERT INTO `member_stagereport` (`id`, `description`, `progress_percentage`, `location`, `photo`, `created_at`, `project_id`, `stage_id`, `reported_by_id`, `weather_conditions`, `workforce_count`, `contractor_id`, `stage_description`, `corrective_actions`, `delay_reason`, `review_status`, `reviewed_at`, `reviewed_by_id`, `reviewer_comments`, `supporting_document`) VALUES
(3, 'working in progress', 26, 'Kisumu county', '', '2026-10-06 03:41:49.670973', 70, NULL, 31, NULL, NULL, 3, 'building of perimeter walls', '', '', 'pending', NULL, NULL, '', ''),
(4, 'plastering and tilling', 100, 'Nairobi', '', '2026-10-17 05:30:03.368567', 70, NULL, 31, NULL, NULL, 3, 'plastering and tilling', '', '', 'pending', NULL, NULL, '', 'stage_reports/documents/REAL_TIME_CHAT_APPLICATION.docx');

-- --------------------------------------------------------

--
-- Table structure for table `member_stagereportattachment`
--

CREATE TABLE `member_stagereportattachment` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `report_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `member_stagereportimage`
--

CREATE TABLE `member_stagereportimage` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `report_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_stagereportimage`
--

INSERT INTO `member_stagereportimage` (`id`, `image`, `caption`, `uploaded_at`, `report_id`) VALUES
(7, 'stage_reports/gallery/08372a7b9de64e97936b3a4ed6d7aa79.jpg', NULL, '2026-10-06 03:41:49.676841', 3),
(8, 'stage_reports/gallery/house_wMsNgUd.jpg', NULL, '2026-10-06 03:41:49.682180', 3),
(9, 'stage_reports/gallery/banner-01.jpg', NULL, '2026-10-17 05:30:03.374387', 4);

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
(2, 'ULGM123R', 'im a contractor and i have experiences in constructing roads', 'restricted', NULL, '2026-06-27', '2026-09-10', 'kcse certificate', 'attaining all the credit scores', 'draft', 'tenders/login.png', 0, '2026-06-27 20:41:11.191406', NULL, 37, NULL, NULL, NULL, NULL),
(3, 'ULGM123T', 'extension of railway from kisumu to busia to link kenya and uganda', 'open', '60000000000.00', '2026-11-27', '2028-06-27', 'skills', 'skills', 'awarded', 'tenders/i.pdf', 0, '2026-09-27 06:07:39.302324', 1, 31, '40000000000.00', '2026-10-06', 2, 'railway'),
(4, 'TND-C972BF42', 'we are upgrading public schools to the best of our capacities', 'open', '3456000000.00', '2026-10-17', '2026-12-17', 'kenyan citizen', 'kenyan citizen', 'published', 'tenders/Doc1.docx', 0, '2026-10-17 11:21:57.037547', 30, 79, NULL, NULL, NULL, 'public schools');

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
(2, 'zedafrica', 'letiamanda@gmail.com', '078945636', 'tender_applications/24_Jun_2025_1119_pm.txt', '40000000000.00', 'tender_coverLetter/i.pdf', '2026-09-27 06:08:49.771820', 'awarded', 1, 3, 50, 100, 65, NULL, NULL, NULL, NULL);

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
  `verification_status` varchar(20) NOT NULL,
  `notifications_enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member_user`
--

INSERT INTO `member_user` (`id`, `password`, `last_login`, `is_superuser`, `first_name`, `last_name`, `is_staff`, `is_active`, `date_joined`, `email`, `username`, `name`, `role`, `bio`, `is_enduser`, `avatar`, `profile`, `updated`, `created_at`, `is_verified`, `last_login_ip`, `location`, `organization`, `phone_number`, `two_factor_enabled`, `verification_status`, `notifications_enabled`) VALUES
(1, 'pbkdf2_sha256$600000$eK4cX1QJxbLYev4itN2MFq$F0E87XnzWK5poO68PKyJ64MWukjctSF4HWmx4aML8yE=', '2026-10-16 09:20:24.398454', 1, '', '', 1, 1, '2026-04-26 11:11:12.503469', 'felixngwono@gmail.com', 'FelloMarley', 'Felix Odhiambo', 'developer', 'I\'m FelloMarley, the mastermind behind the government tracker website', 0, 'avatar.png', 'profiles/Fel14_9bkNTiv.jpg', '2026-04-26 11:19:11.324442', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(2, 'pbkdf2_sha256$600000$cqKSegYWCF6g3aPo0xWfG1$CUTU8ZplvpH5ztNNZvZlmztsSa8VaLDh0p1OOvGI5Dc=', '2026-10-06 03:25:12.147018', 0, '', '', 0, 1, '2026-04-26 19:50:51.247921', 'nicole@gmail.com', 'Atieno NyarChula', 'Nicole Atieno', 'engineer', 'Im Nyachula, born to be a winner', 0, 'avatar.png', 'profiles/02c92d479a634167955278c0bef5d671_R0mYTV3.jpg', '2026-10-06 03:24:29.351488', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(15, 'pbkdf2_sha256$600000$sdZXg14tgnO7xa9BZMRudV$15CmOFaWIpD5svoHyNtsQKA70oqKwIhFRoihCTrZTBo=', '2024-11-13 10:44:07.903587', 0, '', '', 0, 1, '2024-03-17 08:35:44.262524', 'omondi@gmail.com', 'Ajumbutule', 'Frank Omondi', 'citizen', 'Im Ajumbutule', 1, 'avatar.png', 'images/3006.webp', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(21, 'pbkdf2_sha256$390000$L3rjadbchaO0SpN9HBxF3S$7IwkCJCvSjH+A153Y3J+8W2hT03K8drd0wkQGjzV7iI=', '2026-02-15 09:24:48.995603', 1, '', '', 0, 1, '2024-03-18 21:04:19.576787', 'fellomarley@gmail.com', 'Fello', 'Felix Odhiambo', 'citizen', 'Im Marley', 0, 'avatar.png', 'images/chief_J9TcRuW.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(22, 'felixodhiambo@kabarak.ac.ke', NULL, 1, '', '', 1, 0, '2024-03-07 12:52:01.000000', 'True', 'StoryTeller', 'Felix Odhiambo', 'citizen', 'im Marley', 0, '10', 'avartor.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(23, 'pbkdf2_sha256$390000$WQOqv9km54x7scaodebVCd$HYGL9+bFmqvTtlw+RAE5YgIwulygM1B9Egut5CAJry0=', '2026-02-23 08:19:46.449107', 0, '', '', 0, 1, '2024-03-20 19:38:48.673003', 'vanessa@gmail.com', 'Vanessah', 'Toto Vanessah', 'citizen', 'Im Vanessah. The only Titan from the lake in the family of akina Fellix The StoryTeller', 1, 'avatar.png', 'profiles/tree.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(25, 'pbkdf2_sha256$600000$zC8XxCWVVHaIDirSaO2DHg$vCLGelFVlZ6/txAVi3Ua/Oe3qKqk3q8x8M10VTmQgjw=', '2026-10-18 06:08:07.681043', 0, '', '', 0, 1, '2025-03-12 10:02:37.372369', 'assielo@gmail.com', 'assiello', 'Assiello Nomar', 'citizen', 'Assiello Norma', 1, 'avatar.png', 'profiles/solar.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(26, 'pbkdf2_sha256$390000$rvjkDxGKNzDBpOphsu5Rss$fBQTcWntdNp131fgkCqBTyd69P8/xm3kYdLvNG81S1Y=', '2026-04-28 05:57:02.225708', 0, '', '', 0, 1, '2026-02-15 09:22:02.825205', 'betty@gmail.com', 'Amanda', 'Betty Amanda', 'developer', 'im betty amanda', 0, 'avatar.png', 'profiles/038e478f9c094c01be86505e030c974d_DC7y9U9.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(27, 'pbkdf2_sha256$390000$ru4QbghiyfWrnOcUrlggSw$NhAXp11ikeE42Z4rNPpaCIlqUSLiYtRUevcWroYH/gU=', '2026-02-23 09:13:17.518974', 1, '', '', 1, 1, '2026-02-16 13:56:00.197953', 'felix@gmail.com', 'Odinga', 'Felix Odhiambo', 'developer', 'im felix odhiamo', 0, 'avatar.png', 'profiles/Fel14.jpg', '2026-02-22 13:21:42.485592', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(29, 'pbkdf2_sha256$600000$BavP8B0es7pFn9ME210i3X$Xr3WxFnouS6cGR9C/AuHZbcAVlK6bncoXJ7WnfEhH9M=', '2026-09-27 06:47:35.241628', 1, '', '', 1, 1, '2026-06-08 08:28:37.288152', 'felix7@gmail.com', 'FelloMarley7', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-06-08 08:28:38.384166', '2026-08-02 17:06:09.730040', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(30, 'pbkdf2_sha256$600000$rKq0i4dBN2mlV9ieFGVZWb$q26b/wnHa7Vhjhc67nwKimAYHkGz6GuF2ptZ82DiC8Q=', '2026-10-16 10:21:04.010098', 0, '', '', 0, 1, '2026-08-16 07:49:35.828791', 'wanjiru@gmail.com', 'Mercy77', 'Mercy Wanjiru', 'official', 'Im Mercy working with HELB', 1, 'avatar.png', 'profiles/Maccheronis_Valley_View_Dam_Italy_03.jpg', '2026-08-20 18:41:08.828001', '2026-08-16 07:49:38.263163', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(31, 'pbkdf2_sha256$600000$YBVtNpt5oEcyu2EIkdtX3n$lXV1OxSnbbYUnOxHGoVpfYMWt6ACf6mDy6zA+bfiOhQ=', '2026-10-17 05:04:32.454746', 0, '', '', 0, 1, '2026-09-17 03:13:03.043614', 'jack@gmail.com', 'Jack', 'Jack Bauer', 'contractor', 'im jack the ontractor', 0, 'avatar.png', 'profiles/20230823_232505.jpg', '2026-10-17 07:09:28.373907', '2026-09-17 03:13:05.732019', 0, NULL, NULL, 'Lety Amanda', '0700369300', 0, 'unverified', 1),
(33, 'pbkdf2_sha256$600000$Xd2AKRSQhoimv9xLKev2AL$n40GwH7O2w7iDZPwXnm5/43Lr0tAg8VxbC7gWGm4sQs=', '2026-09-19 07:32:19.009780', 1, '', '', 1, 1, '2026-09-19 06:54:06.849226', 'qa_tester@example.com', 'qa_tester', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-19 06:54:08.184790', '2026-09-19 06:54:06.849709', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(35, '', '2026-09-24 10:16:21.293229', 1, '', '', 1, 1, '2026-09-23 07:24:40.488603', 'qa_style_check@example.com', 'qa_style_check', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-24 10:16:21.262392', '2026-09-23 07:24:40.489109', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(37, 'pbkdf2_sha256$600000$HAuGGzxJfDV4bsLDthaX5k$+ujJH6uiqTedinDpM5/dBS4pyZ9mvRPHkU4JcNXMbwo=', NULL, 0, '', '', 0, 1, '2026-09-27 06:42:01.620389', 'assign_test_a@x.com', 'assigntesta', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-27 06:42:03.743666', '2026-09-27 06:42:03.743706', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(38, 'pbkdf2_sha256$600000$8Op3Wjp6rUmk1R5uNnWxYf$kQbIQdaaUpMeMuBBfoYHyxByi8K+bbB3W2x92tq+Yuw=', NULL, 0, '', '', 0, 1, '2026-09-27 06:42:03.747149', 'assign_test_b@x.com', 'assigntestb', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-27 06:42:06.591589', '2026-09-27 06:42:06.591640', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(39, 'pbkdf2_sha256$600000$XfldIdpla4o0PVBpKQmzEz$/YvsIfUVZkisJSbxVTTn2wcMWihiNkw0WvW3cI8DgHQ=', '2026-09-27 07:29:40.574880', 0, '', '', 0, 1, '2026-09-27 07:29:39.056611', 'track_test@x.com', 'tracktest', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-27 07:29:40.533919', '2026-09-27 07:29:40.533970', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(40, 'pbkdf2_sha256$600000$Gky74mdKkTJ3UxIQnb2S90$NqP/uXISqoWy8IjYcPCzTbxIWngCexlnlu8x6KE1bVY=', '2026-09-27 07:30:56.034757', 0, '', '', 0, 1, '2026-09-27 07:30:54.462439', 'track_test2@x.com', 'tracktest2', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-27 07:30:55.998868', '2026-09-27 07:30:55.998895', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(41, 'pbkdf2_sha256$600000$Cy8FVQJe3GvDlVoWz2EYkj$9q41auxTpGH8FoJc/NQuBJNPhidBA0l7pmDB4Nd4IuQ=', '2026-09-27 07:31:24.508444', 0, '', '', 0, 1, '2026-09-27 07:31:22.966390', 'track_test3@x.com', 'tracktest3', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-27 07:31:24.477325', '2026-09-27 07:31:24.477353', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(42, 'pbkdf2_sha256$600000$QjvnCM6hKVYog8b4Cxd1yc$a6Y+WQDjDdEvGLlL9QjOTYO39l/Rzvbiy4GQLQHMdGU=', '2026-09-30 19:31:34.656939', 0, '', '', 0, 1, '2026-09-30 19:31:22.656604', 'adm2@test.com', 'adm2', NULL, 'admin', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-30 19:31:24.281029', '2026-09-30 19:31:24.281061', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(43, 'pbkdf2_sha256$600000$ONsUXLM3aheRAnDqInkfet$euFDotRqHC/LNEWnwVYqV5nkbuMP/LJ29Z8egIFWlxs=', '2026-09-30 19:31:27.537553', 0, '', '', 0, 1, '2026-09-30 19:31:24.284756', 'cit2@test.com', 'cit2', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-30 19:31:25.916841', '2026-09-30 19:31:25.916867', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(44, 'pbkdf2_sha256$600000$4oCb0SgTyR48gJLtkjy9Ut$TpgpgAcMtHj5O1/F2DY2lRhVhbVTcqod226WjjMbraw=', '2026-09-30 19:31:34.560065', 0, '', '', 0, 1, '2026-09-30 19:31:25.919580', 'off2@test.com', 'off2', NULL, 'official', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-30 19:31:27.494462', '2026-09-30 19:31:27.494504', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(45, 'pbkdf2_sha256$600000$ms57p8qO6tOYxRfc1E0T6A$St3qDpHpf46IbdVSpYROUNT2/0KTcnK3PVOyr3PBnf4=', '2026-09-30 19:31:59.271736', 0, '', '', 0, 1, '2026-09-30 19:31:49.760509', 'adm3@test.com', 'adm3', NULL, 'admin', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-30 19:31:51.174490', '2026-09-30 19:31:51.174517', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(46, 'pbkdf2_sha256$600000$vn1ALWWqYeiZgfTYU37zUm$sSaXQ9XWJv/ClXQxkn0lq1nSxdZPO5ihroBuuH+Pe4A=', '2026-09-30 19:31:53.871184', 0, '', '', 0, 1, '2026-09-30 19:31:51.177877', 'cit3@test.com', 'cit3', NULL, 'citizen', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-30 19:31:52.487149', '2026-09-30 19:31:52.487176', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1),
(47, 'pbkdf2_sha256$600000$fcsEBX95PSdWb1iWrLlONh$PJFmhN9l5eJ3GE4W6mbhlTWgH6CBcwbqlhUkw/6XeiE=', '2026-09-30 19:31:59.238899', 0, '', '', 0, 1, '2026-09-30 19:31:52.489696', 'off3@test.com', 'off3', NULL, 'official', NULL, 0, 'avatar.png', 'avatar.png', '2026-09-30 19:31:53.833622', '2026-09-30 19:31:53.833662', 0, NULL, NULL, NULL, NULL, 0, 'unverified', 1);

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
-- Indexes for table `member_activity`
--
ALTER TABLE `member_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_activity_project_id_67a37100_fk_member_project_id` (`project_id`);

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
-- Indexes for table `member_aienginerun`
--
ALTER TABLE `member_aienginerun`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_aienginerun_created_by_id_da41e578_fk_member_user_id` (`created_by_id`);

--
-- Indexes for table `member_aifinding`
--
ALTER TABLE `member_aifinding`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `finding_code` (`finding_code`),
  ADD KEY `member_aifinding_contractor_id_49b39741_fk_member_contractor_id` (`contractor_id`),
  ADD KEY `member_aifinding_project_id_7d80dc93_fk_member_project_id` (`project_id`),
  ADD KEY `member_aifinding_reviewed_by_id_11afc117_fk_member_user_id` (`reviewed_by_id`),
  ADD KEY `member_aifinding_tender_id_46abfda6_fk_member_tender_id` (`tender_id`);

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
  ADD KEY `member_citizenevidence_verified_by_id_5a754207_fk_member_user_id` (`verified_by_id`),
  ADD KEY `member_citizenevidence_status_448bfd8f` (`status`);

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
-- Indexes for table `member_contractorpaymentrequest`
--
ALTER TABLE `member_contractorpaymentrequest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_contractorpay_contractor_id_1dd12a40_fk_member_co` (`contractor_id`),
  ADD KEY `member_contractorpay_project_id_6a165d3e_fk_member_pr` (`project_id`),
  ADD KEY `member_contractorpay_reviewed_by_id_4aa5a2ac_fk_member_us` (`reviewed_by_id`),
  ADD KEY `member_contractorpay_submitted_by_id_b871902e_fk_member_us` (`submitted_by_id`),
  ADD KEY `member_contractorpaymentrequest_status_9cb81d7b` (`status`),
  ADD KEY `member_contractorpay_paid_by_id_003a78bb_fk_member_us` (`paid_by_id`);

--
-- Indexes for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contractor_rating_project` (`project_id`),
  ADD KEY `member_contractorrating_rated_by_id_a6b6aa3c_fk_member_user_id` (`rated_by_id`),
  ADD KEY `member_contractorrat_contractor_id_178933fa_fk_member_co` (`contractor_id`);

--
-- Indexes for table `member_contractor_projects`
--
ALTER TABLE `member_contractor_projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_contractor_projec_contractor_id_project_id_bc2bbd08_uniq` (`contractor_id`,`project_id`),
  ADD KEY `member_contractor_pr_project_id_d495a68e_fk_member_pr` (`project_id`);

--
-- Indexes for table `member_discussionreply`
--
ALTER TABLE `member_discussionreply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_discussionreply_author_id_9e874780_fk_member_user_id` (`author_id`),
  ADD KEY `member_discussionrep_topic_id_4e40fc9a_fk_member_di` (`topic_id`);

--
-- Indexes for table `member_discussiontopic`
--
ALTER TABLE `member_discussiontopic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_discussiontopic_author_id_51fd92ab_fk_member_user_id` (`author_id`),
  ADD KEY `member_discussiontopic_project_id_c63cb5a0_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_district`
--
ALTER TABLE `member_district`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_evidenceresponse`
--
ALTER TABLE `member_evidenceresponse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_evidencerespo_evidence_id_8805d217_fk_member_ci` (`evidence_id`),
  ADD KEY `member_evidenceresponse_user_id_1aa307d4_fk_member_user_id` (`user_id`);

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
  ADD KEY `member_milestone_stage_id_25e95054_fk_member_projectstage_id` (`stage_id`),
  ADD KEY `member_milestone_verified_by_id_75aed197_fk_member_user_id` (`verified_by_id`);

--
-- Indexes for table `member_milestonestageevidence`
--
ALTER TABLE `member_milestonestageevidence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_milestonestag_milestone_id_71bfea3c_fk_member_mi` (`milestone_id`),
  ADD KEY `member_milestonestag_project_id_c7f89164_fk_member_pr` (`project_id`),
  ADD KEY `member_milestonestag_stage_id_27ec20b9_fk_member_pr` (`stage_id`),
  ADD KEY `member_milestonestag_uploaded_by_id_3959bdeb_fk_member_us` (`uploaded_by_id`);

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
  ADD KEY `member_projectexpense_recorded_by_id_9520805a_fk_member_user_id` (`recorded_by_id`),
  ADD KEY `member_projectexpense_budget_id_cfa68fb5_fk_member_budget_id` (`budget_id`),
  ADD KEY `member_projectexpens_stage_id_501ce325_fk_member_pr` (`stage_id`);

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
  ADD KEY `member_projectstage_project_id_cb598c4c_fk_member_project_id` (`project_id`),
  ADD KEY `member_projectstage_status_badff40d` (`status`);

--
-- Indexes for table `member_projectstatushistory`
--
ALTER TABLE `member_projectstatushistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectstatus_changed_by_id_f54396e8_fk_member_us` (`changed_by_id`),
  ADD KEY `member_projectstatus_project_id_9d4df262_fk_member_pr` (`project_id`);

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
  ADD KEY `member_stagereport_reported_by_id_9ec68722_fk_member_user_id` (`reported_by_id`),
  ADD KEY `member_stagereport_contractor_id_f03a035e_fk_member_co` (`contractor_id`),
  ADD KEY `member_stagereport_reviewed_by_id_8b6c104a_fk_member_user_id` (`reviewed_by_id`),
  ADD KEY `member_stagereport_review_status_794cdf3a` (`review_status`);

--
-- Indexes for table `member_stagereportattachment`
--
ALTER TABLE `member_stagereportattachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stagereportat_report_id_406a5e39_fk_member_st` (`report_id`);

--
-- Indexes for table `member_stagereportimage`
--
ALTER TABLE `member_stagereportimage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stagereportim_report_id_71163095_fk_member_st` (`report_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=281;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `member_activity`
--
ALTER TABLE `member_activity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_aichatmessage`
--
ALTER TABLE `member_aichatmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `member_aichatsession`
--
ALTER TABLE `member_aichatsession`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `member_aienginerun`
--
ALTER TABLE `member_aienginerun`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_aifinding`
--
ALTER TABLE `member_aifinding`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_aiissueassessment`
--
ALTER TABLE `member_aiissueassessment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_aiprojectanalysis`
--
ALTER TABLE `member_aiprojectanalysis`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `member_aireportgeneration`
--
ALTER TABLE `member_aireportgeneration`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT for table `member_budget`
--
ALTER TABLE `member_budget`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `member_budgetrevision`
--
ALTER TABLE `member_budgetrevision`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_citizenevidence`
--
ALTER TABLE `member_citizenevidence`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_citizensubmission`
--
ALTER TABLE `member_citizensubmission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_contractordocument`
--
ALTER TABLE `member_contractordocument`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_contractorpaymentrequest`
--
ALTER TABLE `member_contractorpaymentrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_contractor_projects`
--
ALTER TABLE `member_contractor_projects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_discussionreply`
--
ALTER TABLE `member_discussionreply`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_discussiontopic`
--
ALTER TABLE `member_discussiontopic`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_district`
--
ALTER TABLE `member_district`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `member_evidenceresponse`
--
ALTER TABLE `member_evidenceresponse`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_feedback`
--
ALTER TABLE `member_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_governmentrequest`
--
ALTER TABLE `member_governmentrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_media`
--
ALTER TABLE `member_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_milestone`
--
ALTER TABLE `member_milestone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `member_milestonestageevidence`
--
ALTER TABLE `member_milestonestageevidence`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_notification`
--
ALTER TABLE `member_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `member_participation`
--
ALTER TABLE `member_participation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_progressupdate`
--
ALTER TABLE `member_progressupdate`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `member_project`
--
ALTER TABLE `member_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `member_projectcategory`
--
ALTER TABLE `member_projectcategory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `member_projectdocument`
--
ALTER TABLE `member_projectdocument`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_projectexpense`
--
ALTER TABLE `member_projectexpense`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `member_projectstatushistory`
--
ALTER TABLE `member_projectstatushistory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_stagereport`
--
ALTER TABLE `member_stagereport`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member_stagereportattachment`
--
ALTER TABLE `member_stagereportattachment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_stagereportimage`
--
ALTER TABLE `member_stagereportimage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `member_tenderapplication`
--
ALTER TABLE `member_tenderapplication`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

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
-- Constraints for table `member_activity`
--
ALTER TABLE `member_activity`
  ADD CONSTRAINT `member_activity_project_id_67a37100_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

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
-- Constraints for table `member_aienginerun`
--
ALTER TABLE `member_aienginerun`
  ADD CONSTRAINT `member_aienginerun_created_by_id_da41e578_fk_member_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_aifinding`
--
ALTER TABLE `member_aifinding`
  ADD CONSTRAINT `member_aifinding_contractor_id_49b39741_fk_member_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `member_contractor` (`id`),
  ADD CONSTRAINT `member_aifinding_project_id_7d80dc93_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_aifinding_reviewed_by_id_11afc117_fk_member_user_id` FOREIGN KEY (`reviewed_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_aifinding_tender_id_46abfda6_fk_member_tender_id` FOREIGN KEY (`tender_id`) REFERENCES `member_tender` (`id`);

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
-- Constraints for table `member_contractorpaymentrequest`
--
ALTER TABLE `member_contractorpaymentrequest`
  ADD CONSTRAINT `member_contractorpay_contractor_id_1dd12a40_fk_member_co` FOREIGN KEY (`contractor_id`) REFERENCES `member_contractor` (`id`),
  ADD CONSTRAINT `member_contractorpay_paid_by_id_003a78bb_fk_member_us` FOREIGN KEY (`paid_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_contractorpay_project_id_6a165d3e_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_contractorpay_reviewed_by_id_4aa5a2ac_fk_member_us` FOREIGN KEY (`reviewed_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_contractorpay_submitted_by_id_b871902e_fk_member_us` FOREIGN KEY (`submitted_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_contractorrating`
--
ALTER TABLE `member_contractorrating`
  ADD CONSTRAINT `fk_contractor_rating_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_contractorrat_contractor_id_178933fa_fk_member_co` FOREIGN KEY (`contractor_id`) REFERENCES `member_contractor` (`id`),
  ADD CONSTRAINT `member_contractorrating_rated_by_id_a6b6aa3c_fk_member_user_id` FOREIGN KEY (`rated_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_contractor_projects`
--
ALTER TABLE `member_contractor_projects`
  ADD CONSTRAINT `member_contractor_pr_contractor_id_3a48a997_fk_member_co` FOREIGN KEY (`contractor_id`) REFERENCES `member_contractor` (`id`),
  ADD CONSTRAINT `member_contractor_pr_project_id_d495a68e_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_discussionreply`
--
ALTER TABLE `member_discussionreply`
  ADD CONSTRAINT `member_discussionrep_topic_id_4e40fc9a_fk_member_di` FOREIGN KEY (`topic_id`) REFERENCES `member_discussiontopic` (`id`),
  ADD CONSTRAINT `member_discussionreply_author_id_9e874780_fk_member_user_id` FOREIGN KEY (`author_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_discussiontopic`
--
ALTER TABLE `member_discussiontopic`
  ADD CONSTRAINT `member_discussiontopic_author_id_51fd92ab_fk_member_user_id` FOREIGN KEY (`author_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_discussiontopic_project_id_c63cb5a0_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_evidenceresponse`
--
ALTER TABLE `member_evidenceresponse`
  ADD CONSTRAINT `member_evidencerespo_evidence_id_8805d217_fk_member_ci` FOREIGN KEY (`evidence_id`) REFERENCES `member_citizenevidence` (`id`),
  ADD CONSTRAINT `member_evidenceresponse_user_id_1aa307d4_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_milestone_stage_id_25e95054_fk_member_projectstage_id` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`),
  ADD CONSTRAINT `member_milestone_verified_by_id_75aed197_fk_member_user_id` FOREIGN KEY (`verified_by_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_milestonestageevidence`
--
ALTER TABLE `member_milestonestageevidence`
  ADD CONSTRAINT `member_milestonestag_milestone_id_71bfea3c_fk_member_mi` FOREIGN KEY (`milestone_id`) REFERENCES `member_milestone` (`id`),
  ADD CONSTRAINT `member_milestonestag_project_id_c7f89164_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_milestonestag_stage_id_27ec20b9_fk_member_pr` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`),
  ADD CONSTRAINT `member_milestonestag_uploaded_by_id_3959bdeb_fk_member_us` FOREIGN KEY (`uploaded_by_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_projectexpens_stage_id_501ce325_fk_member_pr` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`),
  ADD CONSTRAINT `member_projectexpense_budget_id_cfa68fb5_fk_member_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `member_budget` (`id`),
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
-- Constraints for table `member_projectstatushistory`
--
ALTER TABLE `member_projectstatushistory`
  ADD CONSTRAINT `member_projectstatus_changed_by_id_f54396e8_fk_member_us` FOREIGN KEY (`changed_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_projectstatus_project_id_9d4df262_fk_member_pr` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

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
  ADD CONSTRAINT `member_stagereport_contractor_id_f03a035e_fk_member_co` FOREIGN KEY (`contractor_id`) REFERENCES `member_contractor` (`id`),
  ADD CONSTRAINT `member_stagereport_project_id_2f86d019_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_stagereport_reported_by_id_9ec68722_fk_member_user_id` FOREIGN KEY (`reported_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_stagereport_reviewed_by_id_8b6c104a_fk_member_user_id` FOREIGN KEY (`reviewed_by_id`) REFERENCES `member_user` (`id`),
  ADD CONSTRAINT `member_stagereport_stage_id_d929cb5b_fk_member_projectstage_id` FOREIGN KEY (`stage_id`) REFERENCES `member_projectstage` (`id`);

--
-- Constraints for table `member_stagereportattachment`
--
ALTER TABLE `member_stagereportattachment`
  ADD CONSTRAINT `member_stagereportat_report_id_406a5e39_fk_member_st` FOREIGN KEY (`report_id`) REFERENCES `member_stagereport` (`id`);

--
-- Constraints for table `member_stagereportimage`
--
ALTER TABLE `member_stagereportimage`
  ADD CONSTRAINT `member_stagereportim_report_id_71163095_fk_member_st` FOREIGN KEY (`report_id`) REFERENCES `member_stagereport` (`id`);

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
