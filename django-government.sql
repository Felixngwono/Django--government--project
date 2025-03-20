-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2025 at 03:37 PM
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
(52, 'Can view pdf', 12, 'view_pdf'),
(53, 'Can add notification', 13, 'add_notification'),
(54, 'Can change notification', 13, 'change_notification'),
(55, 'Can delete notification', 13, 'delete_notification'),
(56, 'Can view notification', 13, 'view_notification'),
(57, 'Can add milestone', 14, 'add_milestone'),
(58, 'Can change milestone', 14, 'change_milestone'),
(59, 'Can delete milestone', 14, 'delete_milestone'),
(60, 'Can view milestone', 14, 'view_milestone'),
(61, 'Can add media', 15, 'add_media'),
(62, 'Can change media', 15, 'change_media'),
(63, 'Can delete media', 15, 'delete_media'),
(64, 'Can view media', 15, 'view_media'),
(65, 'Can add budget', 16, 'add_budget'),
(66, 'Can change budget', 16, 'change_budget'),
(67, 'Can delete budget', 16, 'delete_budget'),
(68, 'Can view budget', 16, 'view_budget'),
(69, 'Can add audit log', 17, 'add_auditlog'),
(70, 'Can change audit log', 17, 'change_auditlog'),
(71, 'Can delete audit log', 17, 'delete_auditlog'),
(72, 'Can view audit log', 17, 'view_auditlog'),
(73, 'Can add project location', 18, 'add_projectlocation'),
(74, 'Can change project location', 18, 'change_projectlocation'),
(75, 'Can delete project location', 18, 'delete_projectlocation'),
(76, 'Can view project location', 18, 'view_projectlocation'),
(77, 'Can add report issue', 19, 'add_reportissue'),
(78, 'Can change report issue', 19, 'change_reportissue'),
(79, 'Can delete report issue', 19, 'delete_reportissue'),
(80, 'Can view report issue', 19, 'view_reportissue'),
(81, 'Can add comment', 20, 'add_comment'),
(82, 'Can change comment', 20, 'change_comment'),
(83, 'Can delete comment', 20, 'delete_comment'),
(84, 'Can view comment', 20, 'view_comment'),
(85, 'Can add tender', 21, 'add_tender'),
(86, 'Can change tender', 21, 'change_tender'),
(87, 'Can delete tender', 21, 'delete_tender'),
(88, 'Can view tender', 21, 'view_tender'),
(89, 'Can add progress report', 22, 'add_progressreport'),
(90, 'Can change progress report', 22, 'change_progressreport'),
(91, 'Can delete progress report', 22, 'delete_progressreport'),
(92, 'Can view progress report', 22, 'view_progressreport'),
(93, 'Can add stakeholder', 23, 'add_stakeholder'),
(94, 'Can change stakeholder', 23, 'change_stakeholder'),
(95, 'Can delete stakeholder', 23, 'delete_stakeholder'),
(96, 'Can view stakeholder', 23, 'view_stakeholder'),
(97, 'Can add program impact', 24, 'add_programimpact'),
(98, 'Can change program impact', 24, 'change_programimpact'),
(99, 'Can delete program impact', 24, 'delete_programimpact'),
(100, 'Can view program impact', 24, 'view_programimpact'),
(101, 'Can add program funding', 25, 'add_programfunding'),
(102, 'Can change program funding', 25, 'change_programfunding'),
(103, 'Can delete program funding', 25, 'delete_programfunding'),
(104, 'Can view program funding', 25, 'view_programfunding'),
(105, 'Can add project stage', 26, 'add_projectstage'),
(106, 'Can change project stage', 26, 'change_projectstage'),
(107, 'Can delete project stage', 26, 'delete_projectstage'),
(108, 'Can view project stage', 26, 'view_projectstage'),
(109, 'Can add progress update', 27, 'add_progressupdate'),
(110, 'Can change progress update', 27, 'change_progressupdate'),
(111, 'Can delete progress update', 27, 'delete_progressupdate'),
(112, 'Can view progress update', 27, 'view_progressupdate');

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
(17, 'member', 'auditlog'),
(16, 'member', 'budget'),
(20, 'member', 'comment'),
(7, 'member', 'contact'),
(8, 'member', 'feedback'),
(15, 'member', 'media'),
(14, 'member', 'milestone'),
(13, 'member', 'notification'),
(12, 'member', 'pdf'),
(25, 'member', 'programfunding'),
(24, 'member', 'programimpact'),
(22, 'member', 'progressreport'),
(27, 'member', 'progressupdate'),
(9, 'member', 'project'),
(18, 'member', 'projectlocation'),
(26, 'member', 'projectstage'),
(10, 'member', 'project_division'),
(11, 'member', 'project_type'),
(19, 'member', 'reportissue'),
(23, 'member', 'stakeholder'),
(21, 'member', 'tender'),
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
(58, 'member', '0010_pdf', '2024-03-26 08:08:21.702589'),
(59, 'member', '0011_alter_pdf_options_remove_pdf_end_date_and_more', '2024-08-25 09:16:31.843648'),
(60, 'member', '0012_auto_20250306_1022', '2025-03-06 07:22:53.841583'),
(61, 'member', '0013_rename_status_project_project_status', '2025-03-06 07:58:33.526420'),
(62, 'member', '0014_alter_project_project_status', '2025-03-06 08:41:24.865898'),
(63, 'member', '0015_remove_media_project', '2025-03-06 12:05:23.840433'),
(64, 'member', '0016_media_project', '2025-03-06 12:24:54.102620'),
(65, 'member', '0017_auto_20250306_1758', '2025-03-06 14:59:07.240020'),
(66, 'member', '0018_alter_user_is_superuser', '2025-03-06 15:00:45.579414'),
(67, 'member', '0019_auditlog_comment_progressreport_projectlocation_reportissue_tender', '2025-03-07 09:04:11.384233'),
(68, 'member', '0020_auto_20250307_1249', '2025-03-07 09:49:12.447613'),
(69, 'member', '0021_auto_20250311_1729', '2025-03-11 14:29:57.233969'),
(70, 'member', '0022_auto_20250311_1731', '2025-03-11 14:31:22.539515'),
(71, 'member', '0023_auto_20250311_2040', '2025-03-11 17:40:46.376555'),
(72, 'member', '0024_auto_20250312_1147', '2025-03-12 08:47:55.261684'),
(73, 'member', '0025_auto_20250312_1254', '2025-03-12 09:55:00.198665'),
(74, 'member', '0026_auto_20250312_1718', '2025-03-12 14:18:54.434961'),
(75, 'member', '0027_auto_20250312_1733', '2025-03-12 14:33:07.594690');

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
('0w2a0facvq76m7n09oimmx65jggvhlit', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tqykT:5RMTbPQ06T1pzLx1NmVBKM_H9GgBkofEDrQ-dkk_NEI', '2025-03-22 18:18:09.023173'),
('1j7cdcx4ufyn6vp5rkn1hjs4xydgj6ai', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tuU6L:dc8iwGgKCRSCRTZH1ASYEaho7zHmUIwK6sYgJPtuM0w', '2025-04-01 10:23:13.352163'),
('20e7lz7iio3wv6xl8vi7919rk67gif46', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tZPmw:4AjRMNU_C_UVitNYlem2JAAQZIfq1jfFLlkCLnwx3XE', '2025-02-02 07:32:06.345176'),
('2vt089yzk93g1jpe57uy09avc6k2uh3w', '.eJxVjMsOwiAURP-FtSGXt7h07zeQy4VK1UBS2pXx36VJF5rZnTkzbxZwW0vYel7CnNiFWXb6ZRHpmetepAfWe-PU6rrMke8KP9rOby3l1_Vw_w4K9jLW4MhokybplCNQWigCi96YLO10ttIJiOhU1NGDlJhADe7NiCBrPbDPF7SFNlM:1rhcPt:u0nI9VTPScEu_f0KIt3qoA0NruBXJG7sQAHQti-AwAo', '2024-03-19 21:33:41.747387'),
('38ite4aao6v0ts85eaub72eb877gkcl7', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tvGxo:qRgtrHJVMzCxAYPzp6hxoMTWmDbzf-dd5H4fsY0YO0I', '2025-04-03 14:33:40.112129'),
('44or4nmv3ixv7puvu1la3zpa5g7ozh8x', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tkoDm:Y0Au_Or_uIR4iqr2QVUlMZWGZnyPTEN-gsD4IHdJBpI', '2025-03-05 17:50:54.908126'),
('4chhsa9uotlsh1msgdf27gadn7kjsdnf', '.eJxVjMsOwiAUBf-FtSE8SqEu3fcbyOVykKqhSR8r47-bJl3odmYybxFp32rcVyxxyuIqtBOXX5iIn2iHyQ9q91ny3LZlSvJI5GlXOc4Zr9vZ_g0qrfX4mk4BHl1C0cUrgoE1xQZNSKkvnp3tXWBwYR1oYDjFFtYxVFY8iM8XLw85TA:1tBAr1:nFPqPljNhFQiJQqrDZIVtYzGeK_MzfAwEnq5WWZ3zlk', '2024-11-27 10:44:07.995680'),
('7cqcb4uyhxobtlq22seeqtfjt1p34tfu', '.eJxVjDEOwjAQBP_iGlm5I9gxJT1viHzeMw6gRIqTCvF3iJQC2p2ZfZk-rkvp16pzP8CcDZM5_I4S00PHjeAex9tk0zQu8yB2U-xOq71O0Odld_8OSqzlW7vMXloCeWRuHWmCo4aVQ-dDOMJnEsonkEPsRAlQp4kaoPPCic37AwhYOJM:1rqffS:ek80ZJ_IDnypSHsUAnP_WfJllTJZRdWPyIuTFXl3Ly0', '2024-04-13 20:51:10.482297'),
('ac1iqdnc9itb6edmyqjgyvtrkke6h6hk', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1s6usV:WBMXVtjVwkpH_ur4IuY9o4vXMteQEezmYN5Qske4K_Q', '2024-05-28 16:19:47.141825'),
('bez41nkz8t4mrr0f73q7sumv192z8dsi', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1sFJWI:6KNEbzRCEKY64WkpAfMlfuqHKvf1trqC2xjrq5XkUX8', '2024-06-20 20:15:34.466513'),
('bhr5zwl65707lgrv0jihhdhe9ndhb3gy', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tsMvz:O4NYZwQzfpO1h_7V-VgfZCuBs4-VgWJWR98ns_bu0M8', '2025-03-26 14:19:47.333607'),
('ejbsep4cmtyygxbrjqoakxyei26x9nsg', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tqzEE:FLXpmalKJETrDqWtrxLEJxBFIgxwx6Ee0oKDikkQ2n4', '2025-03-22 18:48:54.540699'),
('mjnnzpzonp4v3apw8cwo1lnl07h5ujmi', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tg05O:XqeOUj8mp89cYrAfcmCX4LsSY37h8jCKlIIsO98hQFI', '2025-02-20 11:30:22.700353'),
('nciqfgqr78fx9emb357tw63yt4dnnj96', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1shkMn:vUqKrLfh7O5JyFTTk1RDk05Eb4RvST7DlxzdBuWtn4E', '2024-09-07 06:35:17.662831'),
('osp0rcjfu925gu390k70vrbry9xohckx', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tdt4N:njJwSKKySCAID27oOJXjdm3ijNeaHwyDy4E02YmxKUY', '2025-02-14 15:36:35.327760'),
('pjvadvja7jynx5mgp9098rfuivn7uvn6', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tg0N4:eYsJf1GUNUuuNrXCESOukXNLgUQO0m69DkZZ0t6PBlo', '2025-02-20 11:48:38.401943'),
('qbjr8gfmpegyad9vfnb8c6n4gcght0sr', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1tJ2J3:Ik0Ip84zxApLJfvWFaFm0dJ2rWX7yXP_oEYjFLVe1bU', '2024-12-19 03:13:33.221493'),
('qrmofx88zu92r43gn3b1nc4jqebv7aqe', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tqykS:6IgrEMD_uX-dk515ADeCUPxDOXWc15IJSpCcYNybObs', '2025-03-22 18:18:08.805637'),
('qzbxhc6l1yx27yefgplrqdzu29gtlc5u', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1teABV:XtErjKHyUDzvPLt9TfQImZ0Z6zw57kDaKbomE0fqaSc', '2025-02-15 09:53:05.618967'),
('v249filfksnkujac1a8qaiffqknfnag3', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1tBtey:VKrjxw3n2uG9EB3hGIgcn5BhIN8MksVhxq70EDtivs0', '2024-11-29 10:34:40.157844'),
('v5fpx7u57jjnlhoeenh7nvwsa1en5ali', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tkp8F:v6rI3uD0vCCTwRXsJBh7Bt-bumWr7wMNuVXo_hjgiTs', '2025-03-05 18:49:15.726292'),
('vq8jx9u6g3jv0rkhvs7p2xrpruyetmaa', '.eJxVjDEOwjAQBP_iGlm5I9gxJT1viHzeMw6gRIqTCvF3iJQC2p2ZfZk-rkvp16pzP8CcDZM5_I4S00PHjeAex9tk0zQu8yB2U-xOq71O0Odld_8OSqzlW7vMXloCeWRuHWmCo4aVQ-dDOMJnEsonkEPsRAlQp4kaoPPCic37AwhYOJM:1rnaJD:lJfsWCpGXA3wipO1J-a77bDDCZKbaWWdVksZqSrTLmc', '2024-04-05 08:31:27.730193'),
('wffr3mdoi8zxvx8qt7925dbl2y84jm8i', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1te9Ju:Rsy8kkEgaju64NPajcpbWDIEwX2Os3gjGQdbADOHj24', '2025-02-15 08:57:42.264613'),
('x0rnllj5mr2z8xvz02zlcwtijoup9j89', '.eJxVjEEOwiAQRe_C2pABSgWX7nsGAsyMVA0kpV0Z765NutDtf-_9lwhxW0vYOi1hRnERWonT75hiflDdCd5jvTWZW12XOcldkQftcmpIz-vh_h2U2Mu3JrCEPEIC1KxIKQdkwbDzNBg1WmLHmjnBGdFZr_yQADBbSz4PYFC8PxC3ODM:1tqCMM:c5_Ry-eWkuyIMlCGX1KHtnYs0_86X9xsPDZ7Ud0UjqU', '2025-03-20 14:38:02.417957'),
('xex6sofii4qd1zdd62adh0rmw5p344nq', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1sQiCI:lHpcSjwW2hr43r0OYgqsl55tSyhA1v-ko7bSQyM8VR0', '2024-07-22 06:50:02.662253'),
('yuhw4u40yp7imkfmp1hjsmefrumsjy3k', '.eJxVjDsOwjAQBe_iGlk268-akj5nsNY_HEC2FCcV4u4QKQW0b2bei3na1uq3kRc_J3Zhip1-t0DxkdsO0p3arfPY27rMge8KP-jgU0_5eT3cv4NKo35rGUSRELGgLUUWI43TUWR0VljtSKsIINGBJaBkCBFUQE0SDbpAZ8XeH81wNv8:1reMYv:hpkdkwmRKxdr2tVLRqN6L_QOEpHjcL5ACviepinIcoQ', '2024-03-10 22:01:33.454716'),
('z6cgpk5lwu28infm4bhd4hdurbjg6jeh', '.eJxVjMEOwiAQRP-FsyFAoVs8eu83kIVdpGpoUtqT8d9tkx40c5v3Zt4i4LaWsDVewkTiKowWl98yYnpyPQg9sN5nmea6LlOUhyJP2uQ4E79up_t3ULCVfW1Be93ZnBMQqOyIBqTM2CkED-jY594plYy2CqDnCHs4IVFMfjAgPl8XdTjQ:1si9NS:QZXcK2OgxgqKVl2PCyXg7LUBl95AVRyKMjLevJhgVYA', '2024-09-08 09:17:38.636187');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_auditlog`
--

INSERT INTO `member_auditlog` (`id`, `action`, `timestamp`, `project_id`, `user_id`) VALUES
(1, 'needed', '2025-03-11 16:23:00.600672', 24, 21),
(2, 'resolved', '2025-03-11 16:24:49.664766', 12, 21),
(3, 'accountability', '2025-03-11 16:38:39.653715', 29, 22);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `name` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_comment`
--

INSERT INTO `member_comment` (`id`, `content`, `created_at`, `project_id`, `user_id`, `name`) VALUES
(1, 'nmbcfdtryujhnm', '2025-03-11 14:07:19.206947', 30, 21, 'Felix Odhiambo'),
(2, 'bncvgfhjm,', '2025-03-11 14:07:43.718312', 12, 23, 'Assiello Nomar');

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
(6, 'Frank Libe', 'libe@gmail.com', 'im frank libe and thanks for the service'),
(7, 'Argwings Kodhek', 'kodhek@gmail.com', 'good work');

-- --------------------------------------------------------

--
-- Table structure for table `member_feedback`
--

CREATE TABLE `member_feedback` (
  `id` bigint(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `feedback` longtext DEFAULT NULL,
  `full_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_feedback`
--

INSERT INTO `member_feedback` (`id`, `email`, `phone_number`, `feedback`, `full_name`) VALUES
(5, 'amanda@gmail.com', '798643789', 'Amanda Nyar Usonga penjo', NULL),
(6, 'young@gmail.com', '798564321', 'thanks for the service', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_milestone`
--

INSERT INTO `member_milestone` (`id`, `title`, `description`, `completion_date`, `progress_percentage`, `project_id`, `stage_id`) VALUES
(1, 'nbnm', 'nmjhmn', '2025-03-12', 87, 35, 1);

-- --------------------------------------------------------

--
-- Table structure for table `member_notification`
--

CREATE TABLE `member_notification` (
  `id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `recipient_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_notification`
--

INSERT INTO `member_notification` (`id`, `message`, `is_read`, `created_at`, `recipient_id`) VALUES
(1, 'Welcome anytime Ajumbutule', 0, '2025-03-06 12:17:36.241868', 15),
(2, 'wecome', 1, '2025-03-06 12:17:56.611611', 22);

-- --------------------------------------------------------

--
-- Table structure for table `member_pdf`
--

CREATE TABLE `member_pdf` (
  `id` bigint(20) NOT NULL,
  `project_title` varchar(255) DEFAULT NULL,
  `implementing_agency` varchar(255) DEFAULT NULL,
  `pdf_file` varchar(100) DEFAULT NULL,
  `project_status` varchar(100) DEFAULT NULL,
  `document` varchar(100) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `uploaded_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_pdf`
--

INSERT INTO `member_pdf` (`id`, `project_title`, `implementing_agency`, `pdf_file`, `project_status`, `document`, `project_id`, `title`, `uploaded_at`) VALUES
(1, 'blas', 'iokl', NULL, NULL, NULL, NULL, NULL, '2025-03-06 07:22:37.888189'),
(2, 'Express way', 'national government', 'pdfs/expressway.jpg', 'completed', NULL, NULL, NULL, '2025-03-06 07:22:37.888189');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member_programimpact`
--

CREATE TABLE `member_programimpact` (
  `id` bigint(20) NOT NULL,
  `metric_name` varchar(255) NOT NULL,
  `metric_value` double NOT NULL,
  `measurement_date` date NOT NULL,
  `program_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `division_id` bigint(20) DEFAULT NULL,
  `images` varchar(100) DEFAULT NULL,
  `project_Budgeting` varchar(15) DEFAULT NULL,
  `project_type_id` bigint(20) DEFAULT NULL,
  `project_status` varchar(10) NOT NULL,
  `beneficiaries` longtext DEFAULT NULL,
  `impact` longtext DEFAULT NULL,
  `progress` longtext DEFAULT NULL,
  `stakeholders` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_project`
--

INSERT INTO `member_project` (`id`, `project_title`, `project_description`, `project_location`, `implementing_agency`, `start_date`, `end_date`, `division_id`, `images`, `project_Budgeting`, `project_type_id`, `project_status`, `beneficiaries`, `impact`, `progress`, `stakeholders`) VALUES
(11, 'Thika super highway', 'Repair and maintanance of Thika super highway', 'Thika', 'KeNHA', '2024-03-01', '2024-03-09', 4, 'projects/thika.jpg', '87654323456.00', 1, 'ongoing', NULL, NULL, NULL, NULL),
(12, 'Kisumu Port', 'Project extension of L.Victoria port has reached its completion stage.', 'Kisumu', 'National government', '2024-03-02', '2024-03-09', 4, 'projects/login.PNG', '147345646.00', 2, 'ongoing', NULL, NULL, NULL, NULL),
(18, 'tree plantation farming', 'tree plantatiion farming in Nakuru county', 'kampi ya moto- Nakuru', 'National government', '2024-03-06', '2024-03-09', 3, 'projects/mau_mau.jpg', '34567890.00', 7, 'ongoing', NULL, NULL, NULL, NULL),
(22, 'Street development in Dandora, Nairobi', 'The project in Dandora focuses on the implementation of a ‘model street’ in a low income neighbourhood in Nairobi. Previously a well-planned neighborhood, Dandora has gradually degenerated to almost slum status. The implementation site, a street in Dandora, was selected as it is an essential part of the ‘Must Seed’ strategy, a step by step process of making small interventions that have large impact in the community.', 'Dandora-Nairobi', 'Placemakers, KUWA, Dandora Transformation League (DTL)', '2024-03-07', '2024-03-09', 4, 'projects/dandora_9E3A1mg.jpg', '1654879.00', 27, 'ongoing', NULL, NULL, NULL, NULL),
(24, 'Building of a Dam', 'Dam Description', 'Kisumu', 'National Government', '2024-03-12', '2024-03-09', 4, 'projects/pacho_7f3AtUZ.jpg', '30000000.00', 2, 'ongoing', NULL, NULL, NULL, NULL),
(27, 'express way', 'Completion of expressway along Haile Sellasie avenue', 'Nairobi', 'National government', '2024-03-08', '2024-03-09', 1, 'projects/expressway_SwK9e6V.jpg', '34500000.00', 1, 'ongoing', NULL, NULL, NULL, NULL),
(28, 'Irrigation Farming', 'The government is yet to initiate irrigation farming along the seven Folks dams of R.Tana', 'Mount Kenya region', 'National government', '2024-03-08', '2024-03-09', 7, 'projects/tana_river.jpg', '4579867.00', 29, 'ongoing', NULL, NULL, NULL, NULL),
(29, 'Kisumu Highway', 'Kisumu started as a small town called Kisuma. Grey due to the greate snaking metal rod of Jorochere', 'Kisumu', 'Nyong\'o government', '2024-03-08', '2024-03-09', 4, 'projects/dala.jpg', '25895642.00', 2, 'ongoing', NULL, NULL, NULL, NULL),
(30, 'Northlands City', 'The Kenyattas are undertaking a project that will culminate in 11,000-acre estate comprising residential and commercial units hosting about 250,000 people.', 'Ruiru, Nairobi city', 'Governmental Agencies', '2024-03-12', '2024-03-12', 4, 'projects/thika_Ua6mF2X.jpg', '23000000.00', 27, 'ongoing', NULL, NULL, NULL, NULL),
(31, 'Standard Gauge Railway', 'Construction of the Mombasa-Malaba standard gauge railway was launched by President Uhuru Kenyatta on November 28, 2013.\r\n\r\nPhase one of the project – from Mombasa to Nairobi was completed in 2017.', 'Mombasa', 'Mombasa county government', '2024-03-12', '2024-03-12', 4, 'projects/sgr.png', '34000000.00', 1, 'ongoing', NULL, NULL, NULL, NULL),
(33, 'Mau Mau Road', 'Construction of a 540km road that seeks to honour the role of Mau Mau freedom fighters in the liberation of Kenya from colonialists is underway, offering three central Kenya counties a new artery into Nairobi.\r\n\r\nChristened Mau Mau Road, the highway starts at Gataka in Limuru, and then passes through Kamahindu and Kibichoi in Kiambu before negotiating its way through Kinyona in Kigumo and Ichichi in Murang’a.', 'Limuru, Nairobi', 'National government', '2024-03-12', '2027-03-12', 5, 'projects/expressway.jpg', '2121000000.00', 1, 'ongoing', NULL, NULL, NULL, NULL),
(34, 'Menengai II Geothermal Power Station', 'A 35 MW geothermal power plant under construction in the Menengai Crater, aimed at harnessing geothermal energy to boost Kenya\'s electricity supply.', 'Menengai Crater, Nakuru County', 'High; expected to be commissioned in 2025 to meet growing energy demands.', '2025-02-19', '2025-03-06', 1, 'projects/Architecture-Portfolio-Cover-1024x683.webp', '20000000.00', 28, 'ongoing', NULL, NULL, NULL, NULL),
(35, 'Menengai II Geothermal Power Station', 'Will be done along Menengai to boost power supply in Nakuru city', 'Menengai Crater, Nakuru County', 'national Government and the NGO\'s', '2025-12-06', '2027-12-06', 4, 'projects/im.jpg', '10000000.00', 5, 'upcoming', NULL, NULL, NULL, NULL),
(36, 'Expansion of Tana River', 'Due to frequent blockages of the river banks, the government  considered its improval', 'Tana River Machakos County', 'National government', '2024-03-07', '2025-03-12', 5, 'projects/tana_river_Laq2K1W.jpg', '23456789876.00', 6, 'completed', NULL, NULL, NULL, NULL),
(37, 'Nairobi Railway City', 'After nearly a decade of waiting, groundbreaking has been held for the proposed Nairobi Railway City, which seeks to decongest the city centre.\r\n\r\nThe venture which was announced in 2010, involves the construction of a 425-acre urban development on the area between Haile Sellasie Avenue, Uhuru Highway and Bunyala Road – comprising transit stations, and residential and commercial buildings among other features.', 'Nairobi', 'National government', '2025-03-13', '2028-02-12', 4, 'projects/sgr_C3xUDYT.png', 'ksh.50 billion', 1, 'upcoming', 'Railway users', 'speeding the rate of transportation and reducing the trafficking in public roads', 'upcoming', 'multi billionares');

-- --------------------------------------------------------

--
-- Table structure for table `member_projectlocation`
--

CREATE TABLE `member_projectlocation` (
  `id` bigint(20) NOT NULL,
  `latitude` decimal(9,1) DEFAULT NULL,
  `longitude` decimal(9,1) DEFAULT NULL,
  `project_id` bigint(20) NOT NULL,
  `description` longtext DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_projectlocation`
--

INSERT INTO `member_projectlocation` (`id`, `latitude`, `longitude`, `project_id`, `description`, `name`) VALUES
(1, 56.0, 56.0, 35, 'wertfgyuhjk', 'Felix Odhiambo');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_projectstage`
--

INSERT INTO `member_projectstage` (`id`, `stage_name`, `description`, `start_date`, `end_date`, `progress_percentage`, `project_id`) VALUES
(1, 'construction', 'nghfdtygh', '2024-03-12', '2024-03-09', 60.00, 30);

-- --------------------------------------------------------

--
-- Table structure for table `member_project_division`
--

CREATE TABLE `member_project_division` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `project_type_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_project_division`
--

INSERT INTO `member_project_division` (`id`, `name`, `project_type_id`) VALUES
(1, 'Ground Breaking', NULL),
(2, 'Tile Fittings', NULL),
(3, 'Land clearence', NULL),
(4, 'Initiation stage', NULL),
(5, 'Ground Breaking', NULL),
(7, 'nile irrigation', 29);

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
(5, 'Agency Projects'),
(4, 'Agile Projects'),
(2, 'Building/construction'),
(27, 'environmental factors'),
(29, 'Farming'),
(1, 'Highways'),
(30, 'music'),
(28, 'ongoing'),
(6, 'Remote Projects'),
(7, 'research project'),
(3, 'Traditional projects');

-- --------------------------------------------------------

--
-- Table structure for table `member_reportissue`
--

CREATE TABLE `member_reportissue` (
  `id` bigint(20) NOT NULL,
  `issue_description` longtext NOT NULL,
  `evidence` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `resolved` tinyint(1) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_reportissue`
--

INSERT INTO `member_reportissue` (`id`, `issue_description`, `evidence`, `created_at`, `resolved`, `project_id`, `user_id`, `status`, `title`) VALUES
(2, 'jghfdsfghj', 'issue_evidence/house.jpg', '2025-03-11 14:06:32.155449', 0, 24, 21, 'Pending', 'jytre'),
(3, 'asdfg', 'issue_evidence/sgr.png', '2025-03-11 14:37:45.210463', 1, 31, 22, 'Resolved', 'wqedf');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `member_tender`
--

CREATE TABLE `member_tender` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `document` varchar(100) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_tender`
--

INSERT INTO `member_tender` (`id`, `title`, `description`, `opening_date`, `closing_date`, `document`, `project_id`) VALUES
(1, 'ddfgh', 'cxdfghj', '2025-02-27', '2025-04-04', 'tenders/house_wMsNgUd.jpg', 35);

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
  `name` varchar(50) DEFAULT NULL,
  `is_enduser` tinyint(1) NOT NULL,
  `profile` varchar(100) DEFAULT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_user`
--

INSERT INTO `member_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `avatar`, `bio`, `name`, `is_enduser`, `profile`, `role`) VALUES
(15, 'pbkdf2_sha256$600000$sdZXg14tgnO7xa9BZMRudV$15CmOFaWIpD5svoHyNtsQKA70oqKwIhFRoihCTrZTBo=', '2024-11-13 10:44:07.903587', 0, 'Ajumbutule', '', '', 'omondi@gamil.com', 0, 1, '2024-03-17 08:35:44.262524', 'avatar.png', 'Im Ajumbutule', 'Frank Omondi', 1, 'images/3006.webp', 'citizen'),
(21, 'pbkdf2_sha256$260000$pPfromenSO3OrO6DL9eLqU$Pb7sm6bvmNWnRjktKmbCzkFx0f6S/nzRhNIujJiA94Y=', '2025-03-20 14:33:40.045336', 1, 'FelloMarley', '', '', 'fellomarley@gmail.com', 0, 1, '2024-03-18 21:04:19.576787', 'avatar.png', 'Im Marley', 'Felix Odhiambo', 0, 'images/chief_J9TcRuW.jpg', 'citizen'),
(22, 'felixodhiambo@kabarak.ac.ke', NULL, 1, 'StoryTeller', '', '', NULL, 1, 0, '2024-03-07 12:52:01.000000', '10', 'im Marley', 'Felix Odhiambo', 0, 'avartor.jpg', 'citizen'),
(23, 'pbkdf2_sha256$600000$1iwabvH8yisaHvUbtgof7P$Q++M3cu6Moxh51jh9R4iISo0Jt4Ig18nDxqu3LKohfw=', '2024-08-22 08:40:23.079615', 0, 'Vanessah', '', '', 'vanessa@gmail.com', 0, 1, '2024-03-20 19:38:48.673003', 'avatar.png', 'Im Vanessah. The only Titan from the lake in the family of akina Fellix The StoryTeller', 'Toto Vanessah', 1, 'profile/amanda.jpg', 'citizen'),
(25, 'pbkdf2_sha256$260000$kxK8tsibyLuXYgHpcRRdUn$kAiu1DZTVk5cmIrnlr0sUGYpWIEzO3aQJXY/rJqlw2s=', '2025-03-12 10:02:56.418112', 0, 'assiello', '', '', 'assielo@gmail.com', 0, 1, '2025-03-12 10:02:37.372369', 'avatar.png', 'Assiello Norma', 'Assiello Nomar', 1, 'profiles/solar.jpg', 'citizen');

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
-- Indexes for table `member_feedback`
--
ALTER TABLE `member_feedback`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `member_notification_recipient_id_6a3177d9_fk_member_user_id` (`recipient_id`);

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
  ADD KEY `member_programimpact_program_id_ce4f8540_fk_member_project_id` (`program_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_project_division_id_ee0bd361_fk_member_pr` (`division_id`),
  ADD KEY `member_project_project_type_id_eea550f2_fk_member_pr` (`project_type_id`);

--
-- Indexes for table `member_projectlocation`
--
ALTER TABLE `member_projectlocation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `project_id` (`project_id`);

--
-- Indexes for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_projectstage_project_id_cb598c4c_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_project_divis_project_type_id_68de0c34_fk_member_pr` (`project_type_id`);

--
-- Indexes for table `member_project_type`
--
ALTER TABLE `member_project_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_project_type_name_ea352ba0_uniq` (`name`);

--
-- Indexes for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_reportissue_project_id_f4f92cf2_fk_member_project_id` (`project_id`),
  ADD KEY `member_reportissue_user_id_8428b576_fk_member_user_id` (`user_id`);

--
-- Indexes for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_stakeholder_program_id_5aef0ac3_fk_member_project_id` (`program_id`);

--
-- Indexes for table `member_tender`
--
ALTER TABLE `member_tender`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_tender_project_id_eec6df9c_fk_member_project_id` (`project_id`);

--
-- Indexes for table `member_user`
--
ALTER TABLE `member_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_user_username_6f2d3f39_uniq` (`username`),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `member_auditlog`
--
ALTER TABLE `member_auditlog`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_budget`
--
ALTER TABLE `member_budget`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_comment`
--
ALTER TABLE `member_comment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_contact`
--
ALTER TABLE `member_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_feedback`
--
ALTER TABLE `member_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `member_media`
--
ALTER TABLE `member_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `member_milestone`
--
ALTER TABLE `member_milestone`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_notification`
--
ALTER TABLE `member_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `member_projectlocation`
--
ALTER TABLE `member_projectlocation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_project_division`
--
ALTER TABLE `member_project_division`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_project_type`
--
ALTER TABLE `member_project_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member_tender`
--
ALTER TABLE `member_tender`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `member_user`
--
ALTER TABLE `member_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
-- Constraints for table `member_comment`
--
ALTER TABLE `member_comment`
  ADD CONSTRAINT `member_comment_project_id_3fa8114d_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_comment_user_id_51d0677f_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_notification_recipient_id_6a3177d9_fk_member_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `member_user` (`id`);

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
  ADD CONSTRAINT `member_programimpact_program_id_ce4f8540_fk_member_project_id` FOREIGN KEY (`program_id`) REFERENCES `member_project` (`id`);

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
-- Constraints for table `member_project`
--
ALTER TABLE `member_project`
  ADD CONSTRAINT `member_project_division_id_ee0bd361_fk_member_pr` FOREIGN KEY (`division_id`) REFERENCES `member_project_division` (`id`),
  ADD CONSTRAINT `member_project_project_type_id_eea550f2_fk_member_pr` FOREIGN KEY (`project_type_id`) REFERENCES `member_project_type` (`id`);

--
-- Constraints for table `member_projectlocation`
--
ALTER TABLE `member_projectlocation`
  ADD CONSTRAINT `member_projectlocation_project_id_b55d0611_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_projectstage`
--
ALTER TABLE `member_projectstage`
  ADD CONSTRAINT `member_projectstage_project_id_cb598c4c_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_project_division`
--
ALTER TABLE `member_project_division`
  ADD CONSTRAINT `member_project_divis_project_type_id_68de0c34_fk_member_pr` FOREIGN KEY (`project_type_id`) REFERENCES `member_project_type` (`id`);

--
-- Constraints for table `member_reportissue`
--
ALTER TABLE `member_reportissue`
  ADD CONSTRAINT `member_reportissue_project_id_f4f92cf2_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`),
  ADD CONSTRAINT `member_reportissue_user_id_8428b576_fk_member_user_id` FOREIGN KEY (`user_id`) REFERENCES `member_user` (`id`);

--
-- Constraints for table `member_stakeholder`
--
ALTER TABLE `member_stakeholder`
  ADD CONSTRAINT `member_stakeholder_program_id_5aef0ac3_fk_member_project_id` FOREIGN KEY (`program_id`) REFERENCES `member_project` (`id`);

--
-- Constraints for table `member_tender`
--
ALTER TABLE `member_tender`
  ADD CONSTRAINT `member_tender_project_id_eec6df9c_fk_member_project_id` FOREIGN KEY (`project_id`) REFERENCES `member_project` (`id`);

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
