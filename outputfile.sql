-- MariaDB dump 10.19  Distrib 10.5.21-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: quantum_gpt_db
-- ------------------------------------------------------
-- Server version	10.5.21-MariaDB-0+deb11u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add user comment',7,'add_usercomment'),(26,'Can change user comment',7,'change_usercomment'),(27,'Can delete user comment',7,'delete_usercomment'),(28,'Can view user comment',7,'view_usercomment'),(29,'Can add comment_c',8,'add_comment_c'),(30,'Can change comment_c',8,'change_comment_c'),(31,'Can delete comment_c',8,'delete_comment_c'),(32,'Can view comment_c',8,'view_comment_c'),(33,'Can add chat session',9,'add_chatsession'),(34,'Can change chat session',9,'change_chatsession'),(35,'Can delete chat session',9,'delete_chatsession'),(36,'Can view chat session',9,'view_chatsession'),(37,'Can add message',10,'add_message'),(38,'Can change message',10,'change_message'),(39,'Can delete message',10,'delete_message'),(40,'Can view message',10,'view_message'),(41,'Can add post',11,'add_post'),(42,'Can change post',11,'change_post'),(43,'Can delete post',11,'delete_post'),(44,'Can view post',11,'view_post'),(45,'Can add comment',12,'add_comment'),(46,'Can change comment',12,'change_comment'),(47,'Can delete comment',12,'delete_comment'),(48,'Can view comment',12,'view_comment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_quantum_a` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_quantum_a` FOREIGN KEY (`user_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'quantum_accounts','customuser'),(8,'quantum_app','comment_c'),(7,'quantum_app','usercomment'),(9,'quantum_chat','chatsession'),(10,'quantum_chat','message'),(12,'q_blog','comment'),(11,'q_blog','post'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-09-17 02:54:33.614034'),(2,'contenttypes','0002_remove_content_type_name','2023-09-17 02:54:33.651284'),(3,'auth','0001_initial','2023-09-17 02:54:33.812887'),(4,'auth','0002_alter_permission_name_max_length','2023-09-17 02:54:33.851187'),(5,'auth','0003_alter_user_email_max_length','2023-09-17 02:54:33.859693'),(6,'auth','0004_alter_user_username_opts','2023-09-17 02:54:33.866748'),(7,'auth','0005_alter_user_last_login_null','2023-09-17 02:54:33.874951'),(8,'auth','0006_require_contenttypes_0002','2023-09-17 02:54:33.877649'),(9,'auth','0007_alter_validators_add_error_messages','2023-09-17 02:54:33.884279'),(10,'auth','0008_alter_user_username_max_length','2023-09-17 02:54:33.890627'),(11,'auth','0009_alter_user_last_name_max_length','2023-09-17 02:54:33.896768'),(12,'auth','0010_alter_group_name_max_length','2023-09-17 02:54:33.910126'),(13,'auth','0011_update_proxy_permissions','2023-09-17 02:54:33.916750'),(14,'auth','0012_alter_user_first_name_max_length','2023-09-17 02:54:33.924809'),(15,'quantum_accounts','0001_initial','2023-09-17 02:54:34.093933'),(16,'admin','0001_initial','2023-09-17 02:54:34.183885'),(17,'admin','0002_logentry_remove_auto_add','2023-09-17 02:54:34.193112'),(18,'admin','0003_logentry_add_action_flag_choices','2023-09-17 02:54:34.201761'),(19,'quantum_accounts','0002_customuser_comments_made_customuser_question_asked_and_more','2023-09-17 02:54:34.255898'),(20,'quantum_app','0001_initial','2023-09-17 02:54:34.269284'),(21,'sessions','0001_initial','2023-09-17 02:54:34.293490'),(22,'quantum_app','0002_usercomment_question','2023-09-21 07:20:36.687476'),(23,'quantum_accounts','0003_customuser_experience_customuser_teleporter','2023-09-28 21:00:48.953979'),(24,'quantum_app','0003_usercomment_correctness','2023-09-28 21:00:48.970104'),(25,'quantum_app','0004_usercomment_modeltype','2023-09-28 21:00:48.984908'),(27,'quantum_app','0006_auto_20231001_1749','2023-10-01 17:52:17.304047'),(28,'quantum_app','0005_remove_usercomment_username_usercomment_user_id','2023-10-03 06:52:39.638754'),(29,'quantum_app','0006_usercomment_followup_alter_usercomment_correctness_and_more','2023-10-03 07:04:19.391768'),(30,'quantum_app','0007_rename_user_id_comment_c_user','2023-10-03 07:04:19.492208'),(31,'quantum_app','0008_rename_user_id_usercomment_user','2023-10-03 07:04:19.558708'),(32,'quantum_accounts','0004_customuser_following','2023-10-11 20:23:50.623190'),(33,'quantum_chat','0001_initial','2023-10-17 20:44:05.102246'),(34,'quantum_chat','0002_chatsession_title_alter_chatsession_owner','2023-10-17 20:44:05.229290'),(35,'quantum_chat','0003_chatsession_updated_at','2023-10-20 19:54:19.605372'),(36,'q_blog','0001_initial','2023-11-12 03:59:17.840737'),(37,'q_blog','0002_remove_comment_name_remove_post_image_postimage','2023-11-12 03:59:17.935027'),(38,'q_blog','0003_alter_post_content','2023-11-12 03:59:17.951356'),(39,'q_blog','0004_delete_postimage','2023-11-12 03:59:17.960526');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('06tyfrbtbix96mlrj82al3yd4kh9r6dh','.eJxVjMsOwiAQRf-FtSGVx3Rw6d5vIDADUjWQlHZl_HfbpAvdnnPufQsf1qX4tafZTywuQqM4_cIY6JnqbvgR6r1JanWZpyj3RB62y1vj9Loe7d9BCb1sa2eJABkNKow5GjsAkSbOACqj1kpZYAKHSUUOZrTObHiMOrnBnAHF5wsJNTei:1r3RBF:bGmtt7TwDkNFyz4oOWNMNRM3YFGsHtmHwlwGqGRki3c','2023-11-30 01:28:29.845561'),('0ailb5s7v2r1na3oxmtvin99oberkf8m','.eJxVjDsOwjAQBe_iGlnxJv5R0nMGy7te4wCypTipEHeHSCmgfTPzXiLEbS1h67yEOYmzUFacfkeM9OC6k3SP9dYktbouM8pdkQft8toSPy-H-3dQYi_f2mo_gTMDARiCTOwzGgXDqEY3KeuNSdFpZNQe0VPM2gKOiclBNilr8f4A7Sw4Gw:1qpAfJ:JZQZ0Yk-eFNTyjrHvCosSFiwW_GBQA7__rC-OZgI4ck','2023-10-21 17:00:33.431029'),('0hkdpohr39yc9168w8emjbm6hlhi16b8','.eJxVjDsOwjAQBe_iGlnBf1PS5wzWrneNA8iR4qRC3B0ipYD2zcx7iQTbWtPWeUkTiYvw4vS7IeQHtx3QHdptlnlu6zKh3BV50C7Hmfh5Pdy_gwq9fmttFFqw3gwcMjiHDgMQRPRMXHQsxoeoVTZFK4ocosWYVYDhXDRp48T7A_SlOCA:1qjLy9:fXKzL9QJFUoeYpiSu39j-1qZJZSAmGHVqd8NkGFRqUk','2023-10-05 15:51:57.563577'),('0z5asmzk8pasmznrlrstrt5l39mclzfu','.eJxVjDsOwjAQBe_iGlnxJv5R0nMGy7te4wCypTipEHeHSCmgfTPzXiLEbS1h67yEOYmzUFacfkeM9OC6k3SP9dYktbouM8pdkQft8toSPy-H-3dQYi_f2mo_gTMDARiCTOwzGgXDqEY3KeuNSdFpZNQe0VPM2gKOiclBNilr8f4A7Sw4Gw:1qjVlo:IGBU5WVkePjdYzubilwEKHp-JIxmJC48wiQMcuDIsYg','2023-10-06 02:19:52.535630'),('1duqne4kh6quvkx2aiqjspfiue1vr73f','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qjM9c:vrrcosN2W_uCUzbSb8lyyeJAMsit-J2t0C6HamJTBT0','2023-10-05 16:03:48.446596'),('1t5tc9x6ej43j63cs2eb0l3b5ofx2t7x','.eJxVjDsOwjAQBe_iGlm2119Kes5gObsbHECOFCcV4u4QKQW0b2beS-SyrTVvnZc8kTgLo8TpdxwKPrjthO6l3WaJc1uXaZC7Ig_a5XUmfl4O9--gll6_deRkLKNCSC4YhYpMSS4SQfRqtDpq8KO2zhhfwDmMyAQhaNQAHBKK9wflEjcY:1qrZLQ:K-417K11hNLtsF2yQs7EBvDGpH_tWvVmRbav3P89Aik','2023-10-28 07:45:56.566456'),('1ylki3ua9ullfimg63hcma7pro7ovhli','.eJxVjEEOwiAQRe_C2hAqlEGX7j0DmWEGqRpISrsy3l2bdKHb_977LxVxXUpcu8xxYnVWTh1-N8L0kLoBvmO9NZ1aXeaJ9KbonXZ9bSzPy-7-HRTs5VvbAW0mHskBjywAYuiYB8_GUYYsp-wBrQtAHAgSURBjCa3h7JEJ1fsDDvw5fQ:1r13Wc:SIsjKn1xjIfEnPsd5yPpFUC92MGWhpln2sjnUKir1Vo','2023-11-23 11:48:42.832258'),('28g4jbzxk3riuero9yd9z7rkyrl5j1ez','.eJxVjDsOwjAQBe_iGlnOxl9Kes5gbbxrHEC2FCcV4u4QKQW0b2beS0Tc1hK3zkucSZzF6MTpd5wwPbjuhO5Yb02mVtdlnuSuyIN2eW3Ez8vh_h0U7OVb62TJg-eQFKnkzegCK2MzuAEosDY5BzQJrFEY1OAyEjsYNXnPrMGL9wf_kTfH:1r2trM:nd6d-e4zbpj6DhrCONTm8JTDLADZoBYwOi8hCtZhsxY','2023-11-28 13:53:44.031597'),('2sh0pfom5te7o6l2y1gst14lvsz8sfby','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1r2mAI:nVBeDrv6gwvNBNuEOb0K_rXK-CvzboTSQTy-uwFYlis','2023-11-28 05:40:46.668183'),('32vhfboua1ljgvzwkmn6ytcc8hxsqb8b','.eJxVjEEOwiAQRe_C2pBCh4Iu3fcMZJhhpGpoUtqV8e7apAvd_vfef6mI21ri1vISJ1YX5dTpd0tIj1x3wHest1nTXNdlSnpX9EGbHmfOz-vh_h0UbOVbD-RFxPsueGvFDr0InImABkeGIDCSEXFosgsJc5fAAnTEtjfMfUL1_gD78Ti6:1qi7qt:0QkrwqMacgHXIZN0_UWcgJiT8Dqe52veLkX_z52H-g0','2023-10-02 06:35:23.655926'),('3y33mn0cvvkhlblst5mxknq3zme45gcy','.eJxVjEEOwiAQRe_C2hBgClKX7nsGAjODVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnERAOL0O6aID647oXustyax1XWZk9wVedAup0b8vB7u30GJvXxrnzQ5cGiNgWw48phzVqgsa9KDUdoBGqsGBYb4PDo7WA9AnogwkWbx_gD-tjf1:1r15g1:6BNozN_gWOONsOGz5EMRrAsO7ol8nvY-WZt-Nsr1fu0','2023-11-23 14:06:33.434003'),('3zds36sx6qc7ss8042il6s0a1pjs8jxh','.eJxVjMsOwiAQRf-FtSE8B3Dpvt9AZgClaiAp7cr479qkC93ec859sYjbWuM2yhLnzM5Ms9PvRpgepe0g37HdOk-9rctMfFf4QQefei7Py-H-HVQc9VsrDVmaIIV2RF7Iq7YUsjDCWMAECYIBQuFs9sErZ0F7CqRkIIlWC2DvD61ENlA:1qhxIA:6iPRqx-ymdnKWcUiOXw0-gTxHlQlMoI_dvIQ0Q1WApc','2023-10-01 19:18:50.697582'),('4kup5ksgnb58npcztnuga9aotu8atk34','.eJxVjEEOwiAQRe_C2hAqlEGX7j0DmWEGqRpISrsy3l2bdKHb_977LxVxXUpcu8xxYnVWTh1-N8L0kLoBvmO9NZ1aXeaJ9KbonXZ9bSzPy-7-HRTs5VvbAW0mHskBjywAYuiYB8_GUYYsp-wBrQtAHAgSURBjCa3h7JEJ1fsDDvw5fQ:1qpfBp:Eq2PIoSDSEnOAY63u-uoKFkZPLdV_8XbU-qp3FAwJT8','2023-10-23 01:36:09.603961'),('57axuj7tslxy8p5lxrcgqn4wqripkauf','.eJxVjDsOwyAQRO9CHSHM16RM7zOgXViCkwgkY1dR7h5bcpFMOe_NvFmAbS1h67SEObErU5pdfkuE-KR6kPSAem88trouM_JD4SftfGqJXrfT_Tso0Mu-9sl7a7PAaBw477yUZIxUFqxFN2Qkipr2QJZRoHRjEkY4EQdKo1aWfb4NoThJ:1r1Jgx:9oBcVk1PFIBbSys4OV2oEsoYtXE8KNvt-dXykoSbsDc','2023-11-24 05:04:27.950739'),('6e47ca3a8ipvfsgi7cn5e0xlsvk6e9r5','.eJxVjMsOwiAQRf-FtSEDM0hx6b7fQBgeUjU0Ke3K-O_apAvd3nPOfQkftrX6refFT0lcxFmcfjcO8ZHbDtI9tNss49zWZWK5K_KgXY5zys_r4f4d1NDrtwaTEZMZLGEpTOSIASAVg0iGHBiGqAgsO63QlMERZmVBRwiFSLN4fwCzFTZw:1qif34:0yBUww02jTs-olcQO_QaEEdHrAYsoJIovaDmRk-zYOs','2023-10-03 18:02:10.567727'),('76lke4onsyw0firs09np3wsbzmtjuhda','.eJxVjEEOwiAQRe_C2pBSQBiX7nsGMgODVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERXpx-N8L44LqDdMd6azK2ui4zyV2RB-1yaomf18P9OyjYy7d2oEZOFgnO4KxSTKjz4C0Ym5iyBsCMEJHZI2sENkMyxnlFeQQLXrw_9mg4XA:1qjN5y:XsCajriU0yAOQB2DAwv8F0eJHbI6oDf7qNF_MImu_ww','2023-10-05 17:04:06.225949'),('7cr1tiva0l5t4jx8x2sv9u7r2y553qqy','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qhtTF:rv0lFdHVTZa6SVvfDlwXMTaa5fbSKgSMA_dLduYUKbw','2023-10-01 15:14:01.780530'),('7knm6diisyycx5ehzyo4y8gx63991c9b','.eJxVjEEOgjAQRe_StWnowJTi0r1nIDOdqUVNSSisjHdXEha6_e-9_zIjbWset6rLOIk5Gwfm9DsyxYeWncidym22cS7rMrHdFXvQaq-z6PNyuH8HmWr-1uzQYWjQI1IA37SqDOxdG1PUASRxF6RX6D1AhDQQBSHRThIiQ-PM-wP8MThY:1qjPRV:mQ1Bs-JWkbUveMPPfo5K3Mw7g-NepMpIWiYCwkvOauc','2023-10-05 19:34:29.722090'),('89o4wtcwfmpv0rvfddn65tjagdbqp4e2','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qiigh:tDZimApYBdEs9gNM19dqoHPnyssCZifvFRyo36yDWPY','2023-10-03 21:55:19.255370'),('8eivngdmccmfj2d9u9l4qghfyvrppdlk','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qyDpA:XlPcLLsg53uDpYo0TJDGnKltiEfT4Ilk-t5bTw_zqkI','2023-11-15 16:12:08.372633'),('8gb8f5lmxcuql7hyib075s3j5fgdggq2','.eJxVjDsOwjAQBe_iGlnxJv5R0nMGy7te4wCypTipEHeHSCmgfTPzXiLEbS1h67yEOYmzUFacfkeM9OC6k3SP9dYktbouM8pdkQft8toSPy-H-3dQYi_f2mo_gTMDARiCTOwzGgXDqEY3KeuNSdFpZNQe0VPM2gKOiclBNilr8f4A7Sw4Gw:1qupa9:GjPRanbDBPFDDWPKyJlfyRnqEi5-h2rbPSgjbSCZUAI','2023-11-06 07:42:37.234157'),('8sxx19xb4oxezgzyoilnhw9c81an9v47','.eJxVjEkOgkAUBe_Sa9P5DD3o0j1nIH8U1EBCw8p4dyVhodtXVe_letzWod-KLv0o7uKqxp1-R0J-6LQTueN0mz3P07qM5HfFH7T4bhZ9Xg_372DAMnxrwEqzpoaNKCYJEZqWkQ1CXVdoxJKhhaSpNjRIGcRa1ZDBYsjhTO79ASFmOJA:1qjPS2:_9wpPfoP0ShMytUFrHCu00QbCrCFRKcBLI9qhLprkgU','2023-10-05 19:35:02.707077'),('ap9hftpvc70ku8jtgz0pqhlowlv1x4u1','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1r21du:wASwExu824h9KDHKKp4FzD9RK2J0x8rdU1-2hRAHK9s','2023-11-26 04:00:14.073560'),('bktjq7hilr9oi9gfblef2m5bz1ifjxp1','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qm1Hz:mZstrp5t8MXLUuGOsUToRl8fP0BaqBKLyyTHqeNzcXg','2023-10-13 00:23:27.517585'),('c51gfhn8uqp2to6l7jy6nkbfjxbc2q0s','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qsrlo:WBxoDBmL9vJi3etu5XZyeZaML_QzwR3CUkKEj0KOnh4','2023-10-31 21:38:32.589697'),('ccwlrrridxd98baqblwa99fepxzm6xjs','.eJxVjEEOwiAQRe_C2hAqlEGX7j0DmWEGqRpISrsy3l2bdKHb_977LxVxXUpcu8xxYnVWTh1-N8L0kLoBvmO9NZ1aXeaJ9KbonXZ9bSzPy-7-HRTs5VvbAW0mHskBjywAYuiYB8_GUYYsp-wBrQtAHAgSURBjCa3h7JEJ1fsDDvw5fQ:1r22Yo:2c5VS2LOtbjn_gVNPvOBzkHF0v3jFtXiQZdGb3Fra5M','2023-11-26 04:59:02.815186'),('e0qnu33nd79w61onhbilv25vzhq8ntng','.eJxVjEsOwjAMRO-SNYpI3TgpS_acoXJshxZQIvWzQtydVuoCZjnvzbxNT-sy9OusUz-KuRiH5vRbJuKnlp3Ig8q9Wq5lmcZkd8UedLa3Kvq6Hu7fwUDzsK2zh7OoIDTCHlvsWBG77CCza5UUGCDl4LdEQY1d5BCcIyby2sRgPl8V2DhR:1qjPZF:oEHJh4d2_7VweiGfcPD4WycUpZ3584nJupUV5Y9P9fo','2023-10-05 19:42:29.490645'),('ecwnoxbmf5kcoz4vcczf6qlm4ayrfyz6','.eJxVjDsOwjAQBe_iGllZJ2vLlPScwdofOIASKZ8q4u4QKQW0b2be5gqtSy3rbFPp1Z0doDv9jkzytGEn-qDhPnoZh2Xq2e-KP-jsr6Pa63K4fweV5vqts6SYM0eLISlwbpTBKGiDppgymmFASS0bMUBqUG7BAoh0HeSWknt_ABE6ODU:1qjPWh:8MRYnxQSfy1wzUyEo_oxB0aQcAIYuPIqoyA4g3ugXYo','2023-10-05 19:39:51.238405'),('f6p6r2kgzmq5l6sbdqoualqcg3iuay9h','.eJxVjMsOwiAQRf-FtSFAebp07zeQgRmkaiAp7cr479qkC93ec859sQjbWuM2aIkzsjOTmp1-xwT5QW0neId26zz3ti5z4rvCDzr4tSM9L4f7d1Bh1G-tJhk0KFcmXZRJKhvIRfsALtmghCOkYItMwjoUQbtg0FDxfsIiSOnM3h_5Xzft:1qjPSH:v18gg-pT8OTD_b8ckDopKY765BFU1Aa0WsyPLShnYQo','2023-10-05 19:35:17.081246'),('f8xiaceqbzh5nqxbz074nirupjnrtoea','.eJxVjDsOwjAQBe_iGlm2119Kes5gObsbHECOFCcV4u4QKQW0b2beS-SyrTVvnZc8kTgLo8TpdxwKPrjthO6l3WaJc1uXaZC7Ig_a5XUmfl4O9--gll6_deRkLKNCSC4YhYpMSS4SQfRqtDpq8KO2zhhfwDmMyAQhaNQAHBKK9wflEjcY:1qm7Qq:-a_8kG4l1wKownes6NHOUX5bvcLhSeWvpf3h3DSL9cs','2023-10-13 06:57:00.008556'),('fbikciu3iugtput34d6u8gju20oci591','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1r3RYt:Nm5O7yXgyiOC80UpjlhuNFSPCVcSvMNY8HrDydQM3Mw','2023-11-30 01:52:55.153688'),('fxwxtay3rfpp193m4ce3fskwkw97pkeb','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qif5m:JU8IObVGYnvyTdkL_HKUEpkIKtUKnZDu9Sh9sre00Os','2023-10-03 18:04:58.720519'),('g35f7htvkx2m4l8c3kgx5sws3xnvwket','.eJxVjDsOwyAQBe9CHSF-xkvK9D4DYhcITiKQjF1FuXuE5CJp38y8N_Ph2Is_etr8GtmVSWCX3xEDPVMdJD5CvTdOre7binwo_KSdLy2m1-10_w5K6GXUCNZSUtZNhoAkgJYOJp2iymBVRqHzjJSkQGlcEBodRS0EGnQwq8w-XwL5N-I:1qwUBf:oruuBJ4ogOydcZSY70x0rPkg3ZrG-2YiaGT4gS9u__g','2023-11-10 21:16:11.614659'),('gmtuegkkf45knmw3f6ot6bbxun9yk4hr','.eJxVjDsOwjAQRO_iGlnGf1PScwZrvbvBAeRIcVIh7k4ipYBuNO_NvEWGdal57TznkcRFaCtOv2UBfHLbCT2g3SeJU1vmschdkQft8jYRv66H-3dQoddtDcUliiY6RijG2OCJcfDJDcp5yyEwA-qk9RYVRxvOxoFFQqMwJY_i8wUadjhQ:1qqG0e:5xoxopfYgDVcr78hT2rNIUa9bywa12hwm9Z_2bSKr0E','2023-10-24 16:55:04.875030'),('gspo0bqez9xdnc5mzqwxyflq45nt4h6k','.eJxVjEEOgyAURO_CuiEIqNBl956B8PlDtW0kEV01vXs1cdGuJpn3Zt4ixG0dw1axhInFVTSNuPyWFNMT80H4Eed7kanM6zKRPBR50iqHwnjdTvfvYIx13Ne21cZmBnmNDtomylAqdWya3vmYWsdMIOKUO4JC9k5nOOzRw6goPl80sTmS:1qjPRM:j2Et5KZzQ-0xNbQS8w0YsRljqYPUyU7R2IYVvzzAcvI','2023-10-05 19:34:20.223910'),('htl07tu3igslku79dcvpuwfr1jynalh7','.eJxVjEEOwiAQRe_C2hAqlEGX7j0DmWEGqRpISrsy3l2bdKHb_977LxVxXUpcu8xxYnVWTh1-N8L0kLoBvmO9NZ1aXeaJ9KbonXZ9bSzPy-7-HRTs5VvbAW0mHskBjywAYuiYB8_GUYYsp-wBrQtAHAgSURBjCa3h7JEJ1fsDDvw5fQ:1qi1CM:mvF00CunIR0olp5Y5bx8O629TDkP4sBPiSV6GFQbzWE','2023-10-01 23:29:06.104543'),('jfwukd4rzsrwqzelxcr38l41sfkne3ek','.eJxVjDsOwjAQBe_iGlm2119Kes5gObsbHECOFCcV4u4QKQW0b2beS-SyrTVvnZc8kTgLo8TpdxwKPrjthO6l3WaJc1uXaZC7Ig_a5XUmfl4O9--gll6_deRkLKNCSC4YhYpMSS4SQfRqtDpq8KO2zhhfwDmMyAQhaNQAHBKK9wflEjcY:1qyTMX:Z9UnwU5T0BRlJawQZfbPIXj6ryToVWT42VPhrBeFpZk','2023-11-16 08:47:37.948896'),('jjez0jeamr64men0y74dddtx4qiqyu82','.eJxVjEEOwiAQRe_C2hCGlg64dO8ZCMxMbdVAUtqV8e7apAvd_vfef6mYtnWKW5MlzqzOyoI6_Y450UPKTvieyq1qqmVd5qx3RR-06WtleV4O9-9gSm361tnnPjtEF6Bj5_shhQyOXB-ALSB4a9CYrhuRSQyyiAQLBINJQDSien8A4LM3bQ:1qoKWo:We0RnVtwF18Hy5ZptbQbQE9PAf_YcoNuicRRQf61U-0','2023-10-19 09:20:18.671018'),('k57tgy3jharsmjbk2dki7v6cuky9o2ld','.eJxVjDsOwjAQBe_iGlle_-JQ0nMGa3dt4wBypDipEHeHSCmgfTPzXiLitta49bzEKYmz0OL0uxHyI7cdpDu22yx5busykdwVedAur3PKz8vh_h1U7PVbB0tkCmVvyqhZ2UGRs-BQwZgMBPCWCTgHPQQHmBw7zIW0Y0Xg2STx_gDbqzfn:1qhu7m:DBc6VpYW62yfxU0Ah7rguwGS5V-dqEpmuy1e5H-xAAE','2023-10-01 15:55:54.253932'),('ke7wi7v8gzrs5d8lfmbc7sn8snmlsu9z','.eJxVjEEOwiAQRe_C2hAqlEGX7j0DmWEGqRpISrsy3l2bdKHb_977LxVxXUpcu8xxYnVWTh1-N8L0kLoBvmO9NZ1aXeaJ9KbonXZ9bSzPy-7-HRTs5VvbAW0mHskBjywAYuiYB8_GUYYsp-wBrQtAHAgSURBjCa3h7JEJ1fsDDvw5fQ:1qjFZe:W8gO0s2enC5mUG3H0d4YDqYdNchFHgEF1HuiVgGsn8c','2023-10-05 09:02:14.488814'),('kflzm7pf4zlcq3sb3nfzwxygxul1scy7','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qtdnX:ML1uQ338kod0ndB2WX5DYhuzM7saB5TM1Ufl0cB9CPk','2023-11-03 00:55:31.131185'),('kha4wpsan5xfvjoqkkbdikz7ykjhhx02','.eJxVjDsOwjAQBe_iGlnBf1PS5wzWrneNA8iR4qRC3B0ipYD2zcx7iQTbWtPWeUkTiYvw4vS7IeQHtx3QHdptlnlu6zKh3BV50C7Hmfh5Pdy_gwq9fmttFFqw3gwcMjiHDgMQRPRMXHQsxoeoVTZFK4ocosWYVYDhXDRp48T7A_SlOCA:1qjSim:2qEdo3NUaucCf2W7EblJPrE1PmzvgiK1Eg_fFnG5BcU','2023-10-05 23:04:32.709375'),('kndkrq5pafsckpkgxom4eclbv4iuotj7','.eJxVjDsOwyAQBe9CHSF-xkvK9D4DYhcITiKQjF1FuXuE5CJp38y8N_Ph2Is_etr8GtmVSWCX3xEDPVMdJD5CvTdOre7binwo_KSdLy2m1-10_w5K6GXUCNZSUtZNhoAkgJYOJp2iymBVRqHzjJSkQGlcEBodRS0EGnQwq8w-XwL5N-I:1qjmPP:aH52vS2gC83gW2tp5BGnuOjqhOchOQX7jNUYSVJylnU','2023-10-06 20:05:51.144752'),('kpzmq71weghrpc9hy5x3grq4xns7g79b','.eJxVjDEOwjAMRe-SGUW4Th3CyM4ZKjuOaQG1UtNOiLtDpQ6w_vfef7mO16Xv1lrmblB3dg26w-8onB9l3IjeebxNPk_jMg_iN8XvtPrrpOV52d2_g55r_63DiZQMiyFEbCRbSLklRimttmAMCBxIIcUjklkk06KSDEyAIYp7fwAUHDjI:1qpV4B:tYR8EHmxuWWJQsnr3VuVZ2mBPzgqK_OGSafTv_Mo7Jk','2023-10-22 14:47:35.345480'),('mdf49b6mo4kiywjteuuet1xxvy2pdux9','.eJxVjEEOwiAQRe_C2pABZgBduu8ZCAxUqoYmpV0Z765NutDtf-_9lwhxW2vYelnClMVFIIjT75giP0rbSb7Hdpslz21dpiR3RR60y2HO5Xk93L-DGnv91sYDmRRVIWuVZQeJNDoqbIFtdow6kya0yjvAUY0evXEJmQBcNuck3h_W1jay:1r3ScT:uCZ0UITep6knnyXVL5hEXo0xxcOumT8Ssm9Ki1hJ9io','2023-11-30 03:00:41.553093'),('mrrgbsyzmr0kyuxmraq5ynscpisxi0xy','.eJxVjMsOwiAQRf-FtSE8HGhduu83kIEZpGogKe3K-O_apAvd3nPOfYmA21rC1nkJM4mLMCBOv2PE9OC6E7pjvTWZWl2XOcpdkQftcmrEz-vh_h0U7OVbs2Nt3AARkBKMKVrMUSufz2ytAzBAZJTxXis0iERslUcYlWWVvR3E-wMQjjfx:1qqiYB:JveXPOYfzPGQeEzLmr-zEv502EhycHeC4lpGuMjfr-0','2023-10-25 23:23:35.469860'),('myq7qq8fwxzk08vv17t3l243pbipxdvh','.eJxVjEEOwiAQRe_C2hCmTCm4dO8ZCDCDVA0kpV0Z765NutDtf-_9l_BhW4vfOi9-JnEWWonT7xhDenDdCd1DvTWZWl2XOcpdkQft8tqIn5fD_TsooZdvHXBgyxEZNQYEM1kmgsQEEEcEx5lUMjlORFrZnNhEHjVl5wzCAFm8PyjQOPc:1quwud:8wv86xaghdXd8tmEFH5yZ91elk_BhUFiLdfJiMAf_MI','2023-11-06 15:32:15.543011'),('nh2c33nh5d3udz76fbdhvw5ebq7laclg','.eJxVjM0OwiAQhN-FsyGAlB-P3n0GsuwuUjU0Ke3J-O62SQ96m8z3zbxFgnWpae08p5HERZydOP2WGfDJbSf0gHafJE5tmccsd0UetMvbRPy6Hu7fQYVet3VxxqBTOfiIGjXY4LwKWwZHbChrtpoUUSw-hEyaqSganPGDjTGgEp8vCrA4GA:1r2n0W:GV7IrwMaq_qC46_9Kr562IaHzdcZ1QFLDlwrUm3qM5k','2023-11-28 06:34:44.394011'),('nz24uxsxx4mp0fliozovzp8zxpf6s1fz','.eJxVjEEOwiAQRe_C2hAKlOm4dN8zkIEZpWpoUtqV8e7apAvd_vfef6lI21ri1mSJE6uzcqhOv2Oi_JC6E75Tvc06z3VdpqR3RR-06XFmeV4O9--gUCvfWsR6GFxnBI1FC54dONtfQ0ZKvcumo-CJJIgBkxgoWYaACTPQgODU-wPxTTex:1r3RmH:rutLRU-aGRfKk4vOI_mY2Ej6NVpCUVpPO7bcOjRKyAA','2023-11-30 02:06:45.007298'),('pa4ebrhnlosec7nmb5updhvxoj629dpv','.eJxVjMsOwiAQRf-FtSE8SkGX7vsNZJgZpGogKe3K-O_apAvd3nPOfYkI21ri1nmJM4mLMEacfscE-OC6E7pDvTWJra7LnOSuyIN2OTXi5_Vw_w4K9PKtAxlPYz5jwhFdHoCCZjAWEiYFLhjNrK0btFdM1qsclHMMlK03mRnF-wMtzTkZ:1qpELd:Bb9GzJn4cFoQpoAR0zzOUzrYhnCisZFBLC8g3vD6u7M','2023-10-21 20:56:29.753907'),('pkjc1ttnam9crgg565y8yx3frho91s5g','.eJxVjDsOwjAQBe_iGllJ8JeSnjNE67drHECJFCcV4u7IUgpoZ0bzViPtWxn3Kus4sbqovlOnX5gIT5mb4QfN90Vjmbd1Srol-rBV3xaW1_Vo_waFamlfRAkuA_mcyfokHn3qQ7BIgET2xrhBYJk4MBy7CLERPphBjM-d-nwBRCc5dQ:1qjP3f:AZ_OF6DGbcxop5QzavJ_tOUxG1dTEELuroO9n-rujq4','2023-10-05 19:09:51.323004'),('pthpdsrlpvn12pjjf6lvwvfqy0klivwr','.eJxVjEEOwiAQRe_C2pBSQBiX7nsGMgODVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERXpx-N8L44LqDdMd6azK2ui4zyV2RB-1yaomf18P9OyjYy7d2oEZOFgnO4KxSTKjz4C0Ym5iyBsCMEJHZI2sENkMyxnlFeQQLXrw_9mg4XA:1qss9G:Se49nMxByXWsTTD-TNN8fMkCeZp2rZLtwEtW7KGYvR4','2023-10-31 22:02:46.813665'),('qlw6ebsc5en0r7m2t58vnhnmkgtncpca','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qniBr:JXl1WdFFjcqLw23_oHKYz6KOYS5g7CP0wjW362D07H4','2023-10-17 16:24:07.306554'),('rsk7lhc8096k5tj6aaxp3wrkg9brojoe','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qoYJ8:V_GVm-UsaylNpEpshzvdv9pX21ILVOADyO1vNVsjBd4','2023-10-20 00:03:06.195356'),('sb31wl7931jaq9mpwwsly10zwh78ymv7','.eJxVjEEOwiAQRe_C2pBSQBiX7nsGMgODVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERXpx-N8L44LqDdMd6azK2ui4zyV2RB-1yaomf18P9OyjYy7d2oEZOFgnO4KxSTKjz4C0Ym5iyBsCMEJHZI2sENkMyxnlFeQQLXrw_9mg4XA:1r2yc3:rSrTbZZTG8S8gbguRCxpuqlp9GIeIYG4FJmG5kIIPMc','2023-11-28 18:58:15.828580'),('tmcge1rm4tmagkdpm6mh0v7wgrye2sgd','.eJxVjDsOwjAQBe_iGlkhsr02JT1niN6u1ySAYimfKuLuECkFtG9m3mY6rEvfrbNO3ZDNxbRkTr8jQ5467iQ_MN6rlTou08B2V-xBZ3urWV_Xw_076DH335oIXuA4q6gGSedIEVJiSMmxjx4qngs4JkIEh8zqGKWhhnxqoeb9AUX6OaQ:1qssM5:WH5a15tViuFN6MVTc9sizYfCLmOQZQCLFfLJF3QcOIk','2023-10-31 22:16:01.818611'),('uygaez553nr17l3qdwb21j9tecdaidhx','.eJxVjMsOwiAQRf-FtSFAebp07zeQYQakaiAp7cr479qkC93ec859sQjbWuM28hJnYmemLDv9jgnwkdtO6A7t1jn2ti5z4rvCDzr4tVN-Xg7376DCqN8avQBJUpeAxqOwsmiYPJIwxQVr_ERGCmXIgksAUvusXPJBW7JZO-PY-wP_JzeG:1qsbGy:Fad4DEGoGfalAqFDiwOz0XQ2XfDGcRakCjlAcRywyEw','2023-10-31 04:01:36.161352'),('wahyffn7plckdsz3ho2w7393v5fqq5ie','.eJxVjDsOwyAQRO9CHSHzW0zK9D4DWlgITiKQjF1FuXtsyUVSjTTvzbyZx20tfutp8TOxK3Ps8tsFjM9UD0APrPfGY6vrMgd-KPyknU-N0ut2un8HBXvZ1wF0VCMlh5GszVIMBrIZZXAaImXMICWSjAoN7QHKGZUHDWiFEATEPl_9BTg2:1qjOco:LDpRO6efxiBbfgvQo8GJNbnm7VW4aTAiKYBpXVOpgl0','2023-10-05 18:42:06.499083'),('wg1kde4g1ztyyqv2vgvuw6jgniqn49pc','.eJxVjMsOwiAUBf-FtSEgoODSvd_QXO5DqgaS0q6M_26bdKHbMzPnrQZY5jIsnadhJHVRVh1-twz45LoBekC9N42tztOY9abonXZ9a8Sv6-7-HRToZa2FmREjBHGCcuSzGMoQEUl8wMQugLGWjMOYyAQfTT6too_BReMpqc8XOwE5Kg:1qjFAV:dKEeb7_3AqDscIHoRoLH8ViYNCdhm_6p21PwEzXx2Hs','2023-10-05 08:36:15.263048'),('wq3c7nk5vg687z5w3msdgiijc0fyq5iz','.eJxVjMsOwiAQRf-FtSEMU2hx6d5vIAMzSNW0SR8r478rSRe6veec-1KR9q3GfZUljqzOCq06_Y6J8kOmRvhO023WeZ62ZUy6Kfqgq77OLM_L4f4dVFrrtxYmG0L2vvSeCQgZLbtOeoRUPBTxYgbsBszGWgAJZKDZ4tB1Bki9PxHuN8Y:1qxGLD:-m7kTY52rsnJOhywUtG6127CacbReEFR9PhDTt9DDKw','2023-11-13 00:41:15.622577'),('ww0vru4ky3jr18jilwm5c2pevdu3y0k3','.eJxVjEEOwiAQRe_C2pDCUIZx6d4zEBhAqoYmpV0Z765NutDtf-_9l_BhW6vfel78lMRZKBKn3zEGfuS2k3QP7TZLntu6TFHuijxol9c55eflcP8Oauj1W0NJnAe2upAig2hUZCyEkWIxOAbmQlk7zaCsNaNL4MBaCoNDBQaieH8AE6w3mg:1qlzBM:3abnLRMd_nj8zbvcnquvBBvE8yygk_p5GTph_cngWRY','2023-10-12 22:08:28.077534'),('xrf3x51if3ylcu9dggfcpno8h8p3a8yv','.eJxVjDsOwjAQBe_iGlnxJv5R0nMGy7te4wCypTipEHeHSCmgfTPzXiLEbS1h67yEOYmzUFacfkeM9OC6k3SP9dYktbouM8pdkQft8toSPy-H-3dQYi_f2mo_gTMDARiCTOwzGgXDqEY3KeuNSdFpZNQe0VPM2gKOiclBNilr8f4A7Sw4Gw:1qjViJ:GYTOlLQ8KTGPgolzWmjANQCUZvRDB0bGFE72tAlDvWo','2023-10-06 02:16:15.472936'),('yrkojore0nyxb3i55ssfma3jr3rwwjco','.eJxVjMsOwiAQRf-FtSE8Bqa4dO83EGBAqgaS0q6M_65NutDtPefcF_NhW6vfRl78TOzMtGGn3zGG9MhtJ3QP7dZ56m1d5sh3hR908Gun_Lwc7t9BDaN-64xogEyWqIub0DmXTBJRKCNAKSuLsGRAAJEulhApKLQRCOQUNVBk7w_knDdV:1r2g5p:ZEBJNOtEJ5ohtYg5CWlw8rkDqHrVk7CamHJZTWdh40o','2023-11-27 23:11:45.936584'),('zjt2p2j8ncw1cz1a9z8ix87eae66su21','.eJxVjEEOwiAQRe_C2pAWKAMu3fcMZGCmUjWQlHZlvLtt0oVu_3vvv0XAbc1ha7yEmcRVKC8uv2PE9ORyEHpguVeZalmXOcpDkSdtcqzEr9vp_h1kbHmvGSNMnVIDaugYyQ26j6gjWdI9GkZnySFa5xNYBtDGgJ8gEmnaKYjPFyVbONA:1qtx8B:G370Hm1n4fCB_6bPQWbfWCQaxROOl7wySjJFh6r44VE','2023-11-03 21:34:07.159333'),('zjxeg7c781qi8cp4js7r14s2di2oihky','.eJxVjEEOwiAQRe_C2hCglGFcuvcMBJipVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWxovT75hifnDdCd1jvTWZW12XOcldkQft8tqIn5fD_TsosZdvzWyYCaxiR6Mzg0ePSBATZzCOLKQUkbKDYcpeE46ISiWlJw1swTrx_gAiTDgv:1qt8d1:ATt-GQsDroTY1gymPW4HUcMlDBgqpCCD5SUWKEVGZX8','2023-11-01 15:38:35.370995');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `q_blog_comment`
--

DROP TABLE IF EXISTS `q_blog_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `q_blog_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `q_blog_comment_author_id_d7a6e016_fk_quantum_a` (`author_id`),
  KEY `q_blog_comment_post_id_78cacd39_fk_q_blog_post_id` (`post_id`),
  CONSTRAINT `q_blog_comment_author_id_d7a6e016_fk_quantum_a` FOREIGN KEY (`author_id`) REFERENCES `quantum_accounts_customuser` (`id`),
  CONSTRAINT `q_blog_comment_post_id_78cacd39_fk_q_blog_post_id` FOREIGN KEY (`post_id`) REFERENCES `q_blog_post` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `q_blog_comment`
--

LOCK TABLES `q_blog_comment` WRITE;
/*!40000 ALTER TABLE `q_blog_comment` DISABLE KEYS */;
INSERT INTO `q_blog_comment` VALUES (1,'Hello this is Mike, the author of this article','2023-11-13 23:12:22.438791',1,2),(2,'Hi, this is Mike, the author of this article. Please feel free to connect with me by clicking on my username. After following me you can include me in a chat session. Please let me know if you have any suggestions or need help with publishing an article.','2023-11-14 02:39:37.065833',1,3);
/*!40000 ALTER TABLE `q_blog_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `q_blog_post`
--

DROP TABLE IF EXISTS `q_blog_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `q_blog_post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `q_blog_post_author_id_216c41fc_fk_quantum_accounts_customuser_id` (`author_id`),
  CONSTRAINT `q_blog_post_author_id_216c41fc_fk_quantum_accounts_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `q_blog_post`
--

LOCK TABLES `q_blog_post` WRITE;
/*!40000 ALTER TABLE `q_blog_post` DISABLE KEYS */;
INSERT INTO `q_blog_post` VALUES (2,'A Prompt Engineering Experiment in Quantum Physics','<p>In the realm of quantum, LLMs such as gpt-4 suffer from hallucinations, logic mistakes, and incorrect conclusions when answering questions. Since gpt-4 usually formats its response in a professional and convincing manner, these mistakes made by gpt-4 can be especially misleading to users. One proposed solution to deal with this problem is through prompt engineering.</p>\r\n\r\n<p>In this experiment, we would like to investigate the effect of prompt engineering on the performance of gpt-4 in answering quantum-related questions. Our contributions are as follows:</p>\r\n\r\n<ol>\r\n	<li>We introduce an evaluation metric to evaluate the logic robustness and correctness of the response</li>\r\n	<li>We compare the results of 4 different levels of prompt-engineered response</li>\r\n	<li>We compare manual evaluation with two different techniques of automated evaluation</li>\r\n</ol>\r\n\r\n<p><strong>The Evaluation Method:</strong></p>\r\n\r\n<p>Evaluating the performance of LLM has been the subject of much research. Existing evaluation methods are categorized into manual subjective evaluation and automatic objective evaluation. It is important to note that each type of evaluation has its own limitations. Manual subjective evaluations are expensive to perform and often subject to varying standards, and automatic evaluation often fails to generate conclusive insights through their evaluation methods [1]. Existing automated evaluation includes BiLingual Evaluation Understudy (BLEU) [2], BERTScore[3], and LLM Eval [4] focus extensively on capturing the semantic behavior of LLMs. While these works are inspiring, our focus is on evaluating the robustness and correctness of the answer rather than semantic relevance. Therefore we propose the following grading metric:</p>\r\n\r\n<ol>\r\n	<li>3 points to the conclusion (deduct all if not relevant or incorrect, partial if partially correct)</li>\r\n	<li>4 points to logic and reasoning (deduct 2 for each inconsistency, deduct 1 for each minor mistake)</li>\r\n	<li>3 points to hallucination (deduct 1 for each wrong statement in the answer)</li>\r\n</ol>\r\n\r\n<p>We approach grading in three different ways. The first approach is manual grading (manual), in which the order of answers to each question is shuffled to reduce bias (so the grader does not know which response is the result of which technique). The grader then compares the response with the sample answer to grade. The second approach is automatic (auto_1), where we provide gpt-4 with an answer and rubric, and prompt get-4 for grading in a zero-shot manner. The third approach is also automatic (auto_2), but gpt-4 is now prompted to generate an answer based on the sample answer first, and then use its answer as the key to grade the response. In this way, the grader keeps a better version of its own response as the benchmark (assume the quality of the response is directly and positively correlated to the relevance and correctness of the prompt).</p>\r\n\r\n<p>The responses to each question are generated by gpt-4 in four different flavors. Aside from the one with no hint, we have three prompts with hints of different levels of relevance. The unrelated hints are hints about a difficult quantum-related topic, but may not be relevant to the question at all. The vague hints are hints that are relevant to the topic of the question, but not directly related to what the question is asking. For example, if a question is about the variational principle, a vague hint can be a solution to a different problem related to the variational principle, or some knowledge and calculation about the variational principle in general. The insightful hint is a hint that is relevant to the question. These can be a suggestion on the methodology of the answer, or a solution to a similar or related problem. It has been shown in previous studies that the manual chain of thought is an effective strategy, the hypothesis is that the the performance of gpt-4 is directly related to the relevance of the hint (assume correct) in the prompt [5].</p>\r\n\r\n<p><strong>Dataset</strong></p>\r\n\r\n<p>I gather questions from different chapters of Introduction to Quantum Mechanics (3rd Edition) by David J. Griffiths, Darrell F. Schroeter. I reformatted the questions and handpicked different hints for each question. There are a total of 10 questions, 30 hints, and 10 answers.</p>\r\n\r\n<p><strong>Results</strong></p>\r\n\r\n<p>The results are shown in the following figures. We have two tables showing the mean and standard deviation of grading. We also have two figures. The top one is the score distribution for different hints and different types of grading, and the bottom one is a plot for the mean score under different types of grading.&nbsp;</p>\r\n\r\n<table align=\"left\" border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:400px\">\r\n	<caption>Mean Score for Different Hints and Grading</caption>\r\n	<tbody>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>No_hint</td>\r\n			<td>Unrelevant</td>\r\n			<td>Vague</td>\r\n			<td>Insightful</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Manual</td>\r\n			<td>7.5</td>\r\n			<td>7.9</td>\r\n			<td>7.9</td>\r\n			<td>8.4</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Auto_1</td>\r\n			<td>6.6</td>\r\n			<td>6.8</td>\r\n			<td>6.6</td>\r\n			<td>7.4</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Auto_2</td>\r\n			<td>6.4</td>\r\n			<td>7.0</td>\r\n			<td>6.6</td>\r\n			<td>7.6</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:400px\">\r\n	<caption>Standard Deviation&nbsp;for Different Hints and Grading</caption>\r\n	<tbody>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>No_hint</td>\r\n			<td>Unrelevant</td>\r\n			<td>Vague</td>\r\n			<td>Insightful</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Manual</td>\r\n			<td>1.69</td>\r\n			<td>1.70</td>\r\n			<td>1.97</td>\r\n			<td>1.69</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Auto_1</td>\r\n			<td>1.69</td>\r\n			<td>1.17</td>\r\n			<td>2.11</td>\r\n			<td>1.91</td>\r\n		</tr>\r\n		<tr>\r\n			<td>Auto_2</td>\r\n			<td>1.85</td>\r\n			<td>1.34</td>\r\n			<td>2.11</td>\r\n			<td>1.43</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p><img alt=\"\" src=\"https://drive.google.com/file/d/1IaTmsmKwNfDmofsWe7jv3zl-JQBuNH4z/view?usp=sharing\" /><img alt=\"\" src=\"https://drive.google.com/uc?export=view&amp;id=1eCPwwQYqjS8vLXQqEFhbCkyvKgbkmNNB\" style=\"border-style:solid; border-width:1px; float:left; height:500px; margin-bottom:20px; margin-top:20px; width:600px\" /><img alt=\"\" src=\"https://drive.google.com/uc?export=view&amp;id=1EuoB0q3s2GIiVaXIQVOH6z9yeWsJSS7T\" style=\"border-style:solid; border-width:1px; float:left; height:360px; margin-bottom:20px; margin-top:20px; width:600px\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Conclusion</strong></p>\r\n\r\n<p>The auto_1 grading and auto_2 grading are statistically similar. However, the manual grading is statistically different from both of them. The consensus among all three gradings is as follows: 1. insightful hints improve performance in terms of mean score significantly. 2. No_hint has the worst performance in terms of mean score. The performance difference between unrelated_hint and vague_hint is more controversial.&nbsp;</p>\r\n\r\n<p>Our results suggest that highly relevant hints improve the performance of gpt-4 significantly in answering quantum-related questions, and performance under some correct hints is at least as good as no_hint. This supports our initial hypothesis. Our result also suggests that unrelated_hint is at least as good as vague hint in terms of mean score performance. This behavior is not predicted by our hypothesis as vague_hints are meant to be more relevant than unrelated_hints. One possible explanation is that the human perception of relevance may not be completely aligned with the model. So a hint that looks relevant and helpful to me may not be helpful to gpt-4 in some cases.&nbsp;</p>\r\n\r\n<p><strong>Limitations and Future Research</strong></p>\r\n\r\n<p>1. The dataset is small, future research can work on expanding the dataset with more questions, hints, and answers.</p>\r\n\r\n<p>2. Future research can investigate the effect of including multiple hints of different types and correctness</p>\r\n\r\n<p>3. Future research can develop an auto-grader with&nbsp;a few-shot approach by utilizing&nbsp;a manual or even automatic chain of thoughts.</p>\r\n\r\n<p>4. Future research can investigate the misalignment between the perceived helpfulness of hints by humans and by models.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Code Availability:</strong></p>\r\n\r\n<p>https://github.com/mikelixiang88/quantum_grader</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Reference:&nbsp;</strong></p>\r\n\r\n<p>[1] Chen B, Zhang Z, Langren&eacute; N, Zhu S. Unleashing the potential of prompt engineering in Large Language Models: a comprehensive review. In: arXiv preprint arXiv:2310.14735v2; 2023.</p>\r\n\r\n<p>[2] Papineni K, Roukos S, Ward T, Zhu WJ. BLEU: a method for automatic evaluation of machine translation. In: Proceedings of the 40th Annual Meeting on Association for Computational Linguistics; 2002. p. 311&ndash;318.&nbsp;</p>\r\n\r\n<p>[3] Zhang T, Kishore V, Wu F, Weinberger KQ, Artzi Y. BERTScore: evaluating text generation with BERT. In: International Conference on Learning Representations; 2020.&nbsp;</p>\r\n\r\n<p>[4] Lin YT, Chen YN. LLM-eval: unified multi-dimensional automatic evaluation for open-domain conversations with large language models; 2023. ArXiv:2305.13711.&nbsp;</p>\r\n\r\n<p>[5] Jason Wei, Xuezhi Wang, and Dale Schuurmans. 2022. Chain-of-thought prompting elicits reasoning in large language models. Advances in Neural Information Processing Systems, 35:24824&ndash;24837.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>','2023-11-13 00:26:20.776157',1),(3,'A Comment Feedback Loop Architecture for Prompt Engineering','<p>In the <a href=\"https://www.quantumgpt.science/blog/2/\">previous article</a>, we present an experiment that shows highly relevant prompts can improve the performance of gpt-4 on quantum-related questions. Now the time has come to introduce the motivation and architecture of quantum-gpt. I am going to introduce a unique architecture and invite you to participate in an experiment.&nbsp;</p>\r\n\r\n<p>As you may have noticed, there are a few ways to make contributions. You can comment in the comment section of this article. You can comment on the response of quantum-gpt in the app section and have other users participate in a discussion (discussion section) on the response. And last but not least, you can chat with other users in the chat section.</p>\r\n\r\n<p>Your comments are going to be distilled and included in the prompt to quantum-gpt. However, we want to make sure that the comments we include are relevant and of good quality. Therefore, each comment is assigned a score with two components, relevance and credibility. Relevance score is evaluated by extracting keywords, applying labels, and using word2vec. And credibility score is directly related to the time of comment, the popularity of the comment, and your experience level. Experience can be gained in three ways:</p>\r\n\r\n<p>1. Through prior (if you send an email and tell me that you are a quantum professor, I will give you a lot of experience score)</p>\r\n\r\n<p>2. Through using the app and making comments (the more you are experienced with our product, the more credible your comments are)</p>\r\n\r\n<p>3. By being cited or endorsed by other credible users in their comments, a small proportion of their credibility is passed along (another graph).</p>\r\n\r\n<p>Detailed diagrams showing the interactions between entities are shown below:</p>\r\n\r\n<p><img alt=\"\" src=\"https://drive.google.com/uc?export=view&amp;id=1WSLQAyE90kKu4nyPcVHNkCjqcCzNhqqK\" style=\"height:332px; width:600px\" /></p>\r\n\r\n<p>In the above diagram, there is a prompt engineering algorithm block. The design for the prompt engineering algorithm is shown below (for simplicity we only show three comments, and credibility is associated with the user making the comment):</p>\r\n\r\n<p><img alt=\"\" src=\"https://drive.google.com/uc?export=view&amp;id=1niAMN2fCFKGCzpBOv1JAo85_Y4rgpUhM\" style=\"height:626px; width:600px\" /></p>\r\n\r\n<p>Last but not least, I would like to present a graph of user interactions and the credibility system. For simplicity we just include two users, each user writes a comment and the second user cites the first user&#39;s comment. The graph is shown below:</p>\r\n\r\n<p><img alt=\"\" src=\"https://drive.google.com/uc?export=view&amp;id=15caj9aAWOhQMj0QB6BjVEV9hZLWdQu40\" style=\"height:407px; width:600px\" /></p>\r\n\r\n<p>The update score calculator takes the result of the sentiment analysis, and the credibility of user2 to calculate an update score for user1&#39;s credibility. And then user1&#39;s credibility is updated accordingly.</p>\r\n\r\n<p>After learning more about our architecture, we would like to invite you to do a few things to contribute to our effort. Here are some actions you can take to contribute:&nbsp;</p>\r\n\r\n<p>1. If you identify a mistake made in the response, please comment in detail</p>\r\n\r\n<p>2. If you have a comment on the comments of the users, please explicitly cite the discussion/blog and user in the comment</p>\r\n\r\n<p>3. We will not utilize any data from the chat unless it explicitly cites a discussion or a blog, citing in the chat is another channel to provide feedback to us</p>\r\n\r\n<p>4. If you have an interesting topic that inspires discussion, please do not hesitate to write an article (the article will be displayed on your profile and we are going to give you lots of credibility after review)</p>\r\n\r\n<p>5. Invite your colleague to use. The website is&nbsp;<a href=\"http://www.quantumgpt.science\">www.quantumgpt.science</a>. You can also invite them to scan the QR code on your account page to connect with you.</p>\r\n\r\n<p>6. Please let us know if you are an expert (you can either send an email to xiang@quantumgpt.science or use the teleporter on the account page to introduce yourself)</p>\r\n\r\n<p>7. Please explicitly cite other discussions/articles/comments if relevant.</p>\r\n\r\n<p>&nbsp;</p>','2023-11-14 02:37:18.762260',1);
/*!40000 ALTER TABLE `q_blog_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_accounts_customuser`
--

DROP TABLE IF EXISTS `quantum_accounts_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_accounts_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `comments_made` int(11) NOT NULL,
  `question_asked` int(11) NOT NULL,
  `question_token` int(11) NOT NULL,
  `experience` int(11) NOT NULL,
  `teleporter` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_accounts_customuser`
--

LOCK TABLES `quantum_accounts_customuser` WRITE;
/*!40000 ALTER TABLE `quantum_accounts_customuser` DISABLE KEYS */;
INSERT INTO `quantum_accounts_customuser` VALUES (1,'pbkdf2_sha256$600000$Fao5PNMuY8gnHtKF37WNSj$CP3c8TNF3ry/4QYapNszyaosVBgD/OMG6/ostnIKiQw=','2023-11-16 01:52:55.150766',0,'mikelixiang','','','limike@usc.edu',0,1,'2023-09-17 15:14:01.299406',14,41,159,131,'Hello, this is Mike Li, the founder of QuantumGPT. Feel free to email me at: xiang@quantumgpt.science.'),(2,'pbkdf2_sha256$600000$GPVrjegHkHnaasuVATARxn$NBB6HB6XDdoqQ2JIsfY9AFh/2F/wH/sqMxcvnN4Hc30=','2023-09-17 15:55:54.250207',0,'haoranta','','','haoranta@usc.edu',0,1,'2023-09-17 15:55:53.788731',0,0,20,0,'The teleporter is empty'),(3,'pbkdf2_sha256$600000$nGJcMC2g68SwkBPIaw7DC3$8wLznimkh0zlrED1WLm8beK7aF85Wx1xD2Y1oVJJ2sM=','2023-09-17 19:18:50.694312',0,'louis','','','sruiesblack@gmail.com',0,1,'2023-09-17 19:18:50.229365',0,1,19,0,'The teleporter is empty'),(4,'pbkdf2_sha256$600000$BwTR8WVEmddfSGiPDo2kOr$DqMoHIPJgdtwiMiay0PnFArT/PF4orPYK6S+3wXcD5M=','2023-11-12 04:59:02.811569',0,'Christineli','','','2671484210@qq.com',0,1,'2023-09-17 23:29:05.646764',4,21,71,31,'The teleporter is empty'),(5,'pbkdf2_sha256$600000$49rsScxEtD2kOZeuiWa0f4$Wo2/k1ojmt2vSkVhE5AwYSe6SbtzR6W4cYJwVFKGKik=','2023-09-18 06:35:23.652884',0,'fionazhang888','','','mengfeizhang888@gmail.com',0,1,'2023-09-18 06:35:23.197018',0,1,19,0,'The teleporter is empty'),(6,'pbkdf2_sha256$600000$NjObVBKUoD4TlTLKQQdx5o$5eVgyRpoDk8O0sHayuEz6jE0JbZVZtYiOgNz9LzavHc=','2023-09-19 18:02:10.564385',0,'shaas','','','shaas@usc.edu',0,1,'2023-09-19 18:02:10.085803',0,0,20,0,'The teleporter is empty'),(7,'pbkdf2_sha256$600000$zHppcY6ASIhYmkOESsp5zd$WaA5ooBNRbodC/ByNMdkko1cccjjKKeM/DMFr+X6Q/8=','2023-09-21 23:04:32.706506',0,'julie','','','jyshi1107@gmail.com',0,1,'2023-09-21 15:51:57.105534',1,3,37,0,'The teleporter is empty'),(8,'pbkdf2_sha256$600000$LTWis4K3r4ZKZcHWch3yyM$0FiPPzVDh+8yg7wpnU8uDKfR0A//pPdizFN/cCz/M3k=','2023-11-14 18:58:15.824728',0,'shaas@usc.edu','','','shaas@usc.edu',0,1,'2023-09-21 17:04:05.771333',6,23,117,2,'The teleporter is empty'),(9,'pbkdf2_sha256$600000$NplYuwBBdWdiyor7MzxIDH$jEDVj21PCMbJYBkMVPhcnHdqGXrJDtUTdgPNL6VwrhA=','2023-09-21 18:42:06.496205',0,'tanlily','','','tanlily@usc.edu',0,1,'2023-09-21 18:42:06.041192',0,1,19,0,'The teleporter is empty'),(10,'pbkdf2_sha256$600000$678uGwOUIoPz956D4dKO05$lPHMEdoevMAwlIQKd4BQ3olKHHhTakkVzoIWB81cjZo=','2023-09-21 19:09:51.320478',0,'testuser123','','','cefixe2139@bookspre.com',0,1,'2023-09-21 19:09:50.868792',0,16,4,0,'The teleporter is empty'),(11,'pbkdf2_sha256$600000$Oy3hs92PPiJqFnKL5Vz3FZ$MPIn0uE8uk5zI2EgZLzQ6tGudEmPLBdO9C+ZEw4EzSA=','2023-09-21 19:34:20.221592',0,'fiowwn','','','yanliwen@marshall.usc.edu',0,1,'2023-09-21 19:34:19.768923',0,3,17,0,'The teleporter is empty'),(12,'pbkdf2_sha256$600000$2Kwcfi80mBSzRsTDKy0QIb$/2d007FdgF0Bh+UzR2nJu3sCvngRPYE9G8lile4q0tA=','2023-09-21 19:34:29.719334',0,'porlando','','','porlando@usc.edu',0,1,'2023-09-21 19:34:29.267442',0,2,18,0,'The teleporter is empty'),(13,'pbkdf2_sha256$600000$akkyUhKBOka81et99cFIjf$lcDLhvN4vWtoem68l6hawyJapxTeD4cy0ILMmCmm0/8=','2023-09-21 19:35:02.704269',0,'rlcourtn','','','raycourtneyjr@gmail.com',0,1,'2023-09-21 19:35:02.248528',0,1,19,0,'The teleporter is empty'),(14,'pbkdf2_sha256$600000$JPwH89d96IpnX6ePQ15Bb1$CLifZKeLSpxc7/C+hWME2OkJo3O2KCHa/eM9CUmRLzs=','2023-09-21 19:35:17.076593',0,'lolauscnow','','','seller.couch@gmail.com',0,1,'2023-09-21 19:35:16.618145',0,0,20,0,'The teleporter is empty'),(15,'pbkdf2_sha256$600000$N6bZrrdcUIvKuKy86Hj11c$Ai4dlVWsKm004w9VOHZdskO+hMfCEKKrzG4q2j6g0wM=','2023-09-21 19:39:51.235565',0,'guako','','','tzuyuko@marshall.usc.edu',0,1,'2023-09-21 19:39:50.783120',0,4,16,0,'The teleporter is empty'),(16,'pbkdf2_sha256$600000$P5caHWRc3gfn9FOwyYvEfS$bC7FJqkAZ18OLW4ovDMX50QZOEwDJeq9fixKc4wjixY=','2023-09-21 19:42:29.486553',0,'qingmao9911','','','qingmao@usc.edu',0,1,'2023-09-21 19:42:29.036201',0,1,19,0,'The teleporter is empty'),(17,'pbkdf2_sha256$600000$8HUoGX8tlpiQ3BWuNnnhI6$F5tIXGdAWULh6LLMJNdrfB0elcO7lr5eqCsDUqwOrBo=','2023-10-23 07:42:37.229005',0,'haorantang','','','haoranta@usc.edu',0,1,'2023-09-22 02:16:15.010433',0,11,9,9,'The teleporter is empty'),(18,'pbkdf2_sha256$600000$Xf9S6RlbKzVsKXQirGm7Nn$0AawHMntZipMgb/o0r7r9kg7cWXUjE/t2Fve3vO84xU=','2023-10-27 21:16:11.608924',0,'Aminbana','','','banayeea@usc.edu',0,1,'2023-09-22 20:04:30.560461',0,2,18,0,'The teleporter is empty'),(19,'pbkdf2_sha256$600000$nmNQZttZiC8SIXjisC2KHW$cnuHs888hEQPMk+S3ECBgmOaMSxBX6oZPH6zEKwczME=','2023-09-28 22:08:28.070816',0,'LouisWoolley123','','','sruiesblack@gmail.com',0,1,'2023-09-28 22:08:27.613510',0,3,9,3,'The teleporter is empty'),(20,'pbkdf2_sha256$600000$15kycZMv4lHMjcydBNRp5D$A+qx6MKBjbNYbu4DjEcGY0pAitppw9reV0LZ6ldnV/U=','2023-11-02 08:47:37.943309',0,'sc','','','siqichen2001@gmail.com',0,1,'2023-09-29 06:56:59.544580',0,7,193,7,'The teleporter is empty'),(21,'pbkdf2_sha256$600000$qS4nxQp4FZhe5ZQJsVVljG$I6d3AnyIw4J342/BmxwWDMeuK5nsDrX/4uwgiA4Axmc=','2023-10-05 09:20:18.665310',0,'owaisishtiaq','','','owaisishtiaq15@gmail.com',0,1,'2023-10-05 09:20:18.199788',0,3,5,3,'The teleporter is empty'),(22,'pbkdf2_sha256$600000$8eR8sBiVq1IHnRJapIQei1$rY3ScQPm3t5QDGnHqxfVoyaH+MyDkuMpCVQZOmxl0Ig=','2023-10-07 20:56:29.751261',0,'MZippy','','','mattstein5236@gmail.com',0,1,'2023-10-07 20:56:14.566335',0,6,185,6,'The teleporter is empty'),(23,'pbkdf2_sha256$600000$tRZFq1P4t1Ux27wpwiJXUw$do1xrDkSHz8luq/4iPJiTh5Qn/PUVTuTJ1KdfYf0/nM=','2023-10-08 14:47:35.337276',0,'ahad.siddike','','','ahad.siddiki25@gmail.com',0,1,'2023-10-08 14:47:34.802641',0,1,15,1,'The teleporter is empty'),(24,'pbkdf2_sha256$600000$sP03kQxfI2peWKOoe9dVUn$qS3BCeObNoWXhmyFBl3vv7KRrT5khUlfaRbB5y7Mlus=','2023-10-10 16:55:04.870837',0,'sdafdsafd','','','hycrichard724qq@gmail.com',0,1,'2023-10-10 16:55:04.409299',0,2,10,2,'The teleporter is empty'),(25,'pbkdf2_sha256$600000$SvQNnSErI4lx4bCXnYQff6$1iCKC/lbtlsq47ovE/XNC7o9JvxBmkscYYc3tvTkQqs=','2023-10-11 23:23:35.467333',0,'momercad','','','momercad@usc.edu',0,1,'2023-10-11 23:23:35.027939',0,0,20,0,'The teleporter is empty'),(26,'pbkdf2_sha256$600000$WueXp6VZWMXlU1Z4uQ72ZV$EKtvcb/ikJwdieJyiPASRqzg5oodrGtNwpACc3fQptE=','2023-10-17 04:01:36.157979',0,'billyhoho','','','aagamva@gmail.com',0,1,'2023-10-17 04:01:35.690150',2,2,50,22,'The teleporter is empty'),(27,'pbkdf2_sha256$600000$RnPRssM6sfYG0lbRzcGskr$o7JWF28kzX/xZAHgsNE+UOFH1rUvgmw3y2ynbz/0Zzs=','2023-10-17 22:16:01.815910',0,'forever.haohao@gmail.com','','','forever.haohao@gmail.com',0,1,'2023-10-17 22:16:01.369148',0,0,20,0,'The teleporter is empty'),(28,'pbkdf2_sha256$600000$MuowjE4bLds8oCwSrEqYHi$RHW6SClTzUO5xoz9DFBsS9iyxIcG6+LI71giEmq2P74=','2023-10-18 15:38:35.366956',0,'larrywan','','','larrywan@usc.edu',0,1,'2023-10-18 15:38:34.923469',0,2,10,2,'The teleporter is empty'),(29,'pbkdf2_sha256$600000$fYpsfb9c3izcPQKWjijOAR$pfFdp5QRwW1mEf32ZWpsTb618Wz4l1wB8RFdWEf3JHQ=','2023-10-20 21:34:07.155831',0,'HX555','','','457845846@qq.com',0,1,'2023-10-20 21:34:06.711244',0,2,10,2,'The teleporter is empty'),(30,'pbkdf2_sha256$600000$Inc3qzK6b0gWkSZWN1nhcy$QtdfwXWiW/QyOpn6WLyvq2pmzSPXg0p60FUu76JpMxc=','2023-10-23 15:32:15.539889',0,'fipalapa','','','wanqing020@gmail.com',0,1,'2023-10-23 15:32:15.071674',0,1,19,1,'The teleporter is empty'),(31,'pbkdf2_sha256$600000$KMjqX3zNm40w7yJsb8clDf$NM2fbSePmwx24wdRzFHAtNbBG0yWQaNjzhAJqmw3wKA=','2023-10-30 00:40:34.519470',0,'Alice','','','binghongcha233@gmail.com',0,1,'2023-10-30 00:40:34.046119',0,0,20,0,'The teleporter is empty'),(32,'pbkdf2_sha256$600000$GbuEAE3IYfxJ4wMfE3D9DU$mcqf8f4CW3J09DJoym1o85rTl+bX/T3OE084zigsxAE=','2023-10-30 00:41:15.617987',0,'Bruce','','','1139996534@qq.com',0,1,'2023-10-30 00:41:15.173971',0,1,19,1,'The teleporter is empty'),(33,'pbkdf2_sha256$600000$Gfe1kCCNq1KzgfHERxjJJs$xAv4ln4QeZgJqyYkWl5w45MkiPKopBf2a4Cfn4kvS10=','2023-11-09 14:06:33.429973',0,'totsugekipower','','','totsugekipower@gmail.com',0,1,'2023-11-09 14:06:32.961001',0,2,18,2,'The teleporter is empty'),(34,'pbkdf2_sha256$600000$iXNrES9zqdiFurHVTTf2Mm$bgXDw8Phhuzk6xvvOnFvL3JvkFOsvKEtfUK+8F3uCbc=','2023-11-10 05:04:27.944726',0,'UJEoTaMNcdsQ','','','info@007strategies.com',0,1,'2023-11-10 05:04:27.491018',0,0,20,0,'The teleporter is empty'),(35,'pbkdf2_sha256$600000$JQlCPB6C74lhQc7s0HEuSj$TI1g5POHnO46NieixfwjNtCuAdjsIBQOPouXOpqf0vA=','2023-11-13 23:11:45.933222',0,'maravi','','','maravi@usc.edu',0,1,'2023-11-13 23:11:45.475286',0,4,12,4,'The teleporter is empty'),(36,'pbkdf2_sha256$600000$xDVwu3I9uWzDuNCgLIhQ7n$HtEaGxenp1nNmMNn50GOIPOWLYIfQkzVTf4hn2c16o4=','2023-11-14 06:34:44.390986',0,'Lizzy','','','LizzyChen@outlook.com',0,1,'2023-11-14 06:34:43.945257',0,0,20,0,'The teleporter is empty'),(37,'pbkdf2_sha256$600000$Z9Yqq7nPg5Tpx6jwWn7EXc$EWAXMs3/2hU6qrRmYmPZSNGnFwbOsQXTFUkOxrcdBhE=','2023-11-14 13:53:44.028323',0,'nkBqObSLxy','','','verobonnin92@gmail.com',0,1,'2023-11-14 13:53:43.588653',0,0,20,0,'The teleporter is empty'),(38,'pbkdf2_sha256$600000$oK8O0WXDaksgIr9vcmzjMS$8uRdrEUvIKOBZkExW+fe3Q7a3wCk8oh5l3bhW6FAjjE=','2023-11-16 01:28:29.842783',0,'marcinabram','','','mjabram@usc.edu',0,1,'2023-11-16 01:28:29.394864',0,0,20,0,'The teleporter is empty'),(39,'pbkdf2_sha256$600000$JM8T0i1zCyqBG172LZGRSX$8vat8fKvX/fWzQz1XvkhayC9gRZ183BJ0CI0AuMNogU=','2023-11-16 02:06:45.004807',0,'louis9875','','','sruiesblack@gmail.com',0,1,'2023-11-16 02:06:44.567767',0,0,20,0,'The teleporter is empty'),(40,'pbkdf2_sha256$600000$3NFTDLId9x09lCGaafjLmj$7ctrc41kZx+OA1FVXk6FKAqKQduZO2xNp8arJKl6AHM=','2023-11-16 03:00:41.550468',0,'MljAjkWIjMUR','','','rmkexel@msn.com',0,1,'2023-11-16 03:00:41.113674',0,0,20,0,'The teleporter is empty');
/*!40000 ALTER TABLE `quantum_accounts_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_accounts_customuser_following`
--

DROP TABLE IF EXISTS `quantum_accounts_customuser_following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_accounts_customuser_following` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_customuser_id` bigint(20) NOT NULL,
  `to_customuser_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantum_accounts_customu_from_customuser_id_to_cu_76c0c291_uniq` (`from_customuser_id`,`to_customuser_id`),
  KEY `quantum_accounts_cus_to_customuser_id_182c56f4_fk_quantum_a` (`to_customuser_id`),
  CONSTRAINT `quantum_accounts_cus_from_customuser_id_504a3259_fk_quantum_a` FOREIGN KEY (`from_customuser_id`) REFERENCES `quantum_accounts_customuser` (`id`),
  CONSTRAINT `quantum_accounts_cus_to_customuser_id_182c56f4_fk_quantum_a` FOREIGN KEY (`to_customuser_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_accounts_customuser_following`
--

LOCK TABLES `quantum_accounts_customuser_following` WRITE;
/*!40000 ALTER TABLE `quantum_accounts_customuser_following` DISABLE KEYS */;
INSERT INTO `quantum_accounts_customuser_following` VALUES (2,1,1),(7,1,4),(6,1,8),(11,1,26),(10,1,27),(14,1,28),(17,1,29),(19,1,30),(5,8,1),(15,17,1),(8,27,1),(12,28,1),(16,29,1),(18,30,1),(20,35,1);
/*!40000 ALTER TABLE `quantum_accounts_customuser_following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_accounts_customuser_groups`
--

DROP TABLE IF EXISTS `quantum_accounts_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_accounts_customuser_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantum_accounts_customu_customuser_id_group_id_2226849a_uniq` (`customuser_id`,`group_id`),
  KEY `quantum_accounts_cus_group_id_476d96fc_fk_auth_grou` (`group_id`),
  CONSTRAINT `quantum_accounts_cus_customuser_id_364abecd_fk_quantum_a` FOREIGN KEY (`customuser_id`) REFERENCES `quantum_accounts_customuser` (`id`),
  CONSTRAINT `quantum_accounts_cus_group_id_476d96fc_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_accounts_customuser_groups`
--

LOCK TABLES `quantum_accounts_customuser_groups` WRITE;
/*!40000 ALTER TABLE `quantum_accounts_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `quantum_accounts_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_accounts_customuser_user_permissions`
--

DROP TABLE IF EXISTS `quantum_accounts_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_accounts_customuser_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantum_accounts_customu_customuser_id_permission_80af0fc6_uniq` (`customuser_id`,`permission_id`),
  KEY `quantum_accounts_cus_permission_id_7388ae24_fk_auth_perm` (`permission_id`),
  CONSTRAINT `quantum_accounts_cus_customuser_id_7bfcc8bb_fk_quantum_a` FOREIGN KEY (`customuser_id`) REFERENCES `quantum_accounts_customuser` (`id`),
  CONSTRAINT `quantum_accounts_cus_permission_id_7388ae24_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_accounts_customuser_user_permissions`
--

LOCK TABLES `quantum_accounts_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `quantum_accounts_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `quantum_accounts_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_app_comment_c`
--

DROP TABLE IF EXISTS `quantum_app_comment_c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_app_comment_c` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `discussion_id_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quantum_app_comment__discussion_id_id_396b18cc_fk_quantum_a` (`discussion_id_id`),
  KEY `quantum_app_comment__user_id_004ee7dc_fk_quantum_a` (`user_id`),
  CONSTRAINT `quantum_app_comment__discussion_id_id_396b18cc_fk_quantum_a` FOREIGN KEY (`discussion_id_id`) REFERENCES `quantum_app_usercomment` (`id`),
  CONSTRAINT `quantum_app_comment__user_id_004ee7dc_fk_quantum_a` FOREIGN KEY (`user_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_app_comment_c`
--

LOCK TABLES `quantum_app_comment_c` WRITE;
/*!40000 ALTER TABLE `quantum_app_comment_c` DISABLE KEYS */;
INSERT INTO `quantum_app_comment_c` VALUES (2,'Thank you. Please let me know if you have any further suggestions','2023-10-03 23:03:33.676971',16,1),(3,'The comment is legitimate. It would be better if we address limitation','2023-10-06 01:07:40.840122',21,1),(4,'Yes the answer to this question is indeed C','2023-11-18 02:25:50.654668',20,1);
/*!40000 ALTER TABLE `quantum_app_comment_c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_app_usercomment`
--

DROP TABLE IF EXISTS `quantum_app_usercomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_app_usercomment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `response` longtext NOT NULL,
  `comment` longtext NOT NULL,
  `question` longtext NOT NULL,
  `correctness` varchar(15) NOT NULL,
  `modelType` varchar(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `followup` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quantum_app_usercomment_user_id_id_27fbbb2f` (`user_id`),
  CONSTRAINT `quantum_app_usercomm_user_id_a7434499_fk_quantum_a` FOREIGN KEY (`user_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_app_usercomment`
--

LOCK TABLES `quantum_app_usercomment` WRITE;
/*!40000 ALTER TABLE `quantum_app_usercomment` DISABLE KEYS */;
INSERT INTO `quantum_app_usercomment` VALUES (16,'uantumGPT has several advantages:\n\n1. It can provide accurate and detailed explanations of complex quantum physics concepts in a way that\'s easy to understand.\n2. It can answer a wide range of questions related to quantum physics, from basic principles to advanced topics.\n3. It can help students, researchers, and anyone interested in quantum physics to learn and understand the subject more effectively.\n4. It\'s available 24/7, making it a convenient and accessible learning resource.\n\nThe founder of QuantumGPT is Xiang\'s team. They developed this tool in September 2023, using the ChatGPT API and prompt engineering. This team is dedicated to making quantum physics more accessible and understandable to a wider audience.','glad to know this tool is not only for quantum physists, but also accessible for person who is interest in quantum physics','what is the advantage of quantumgpt? who is the founder','correct','GPT4',4,1),(19,'In the Bohr model, the energy of an electron in the nth orbit is given by the formula:\n\nE_n = -13.6 / n^2 eV\n\nwhere n is the principal quantum number. \n\nSo, the energy of the electron in the n = 1 orbit (E1) is -13.6 eV and in the n = 4 orbit (E4) is -13.6 / 4^2 eV = -13.6 / 16 eV.\n\nThe ratio of E4 to E1 is therefore (-13.6 / 16) / -13.6 = 1 / 16.\n\nSo, the new energy of the electron when it jumps from the n = 1 orbit to the n = 4 orbit is E1/16. \n\nTherefore, the answer is (B) E1/16.','GPT-4 gets this correct','In the Bohr model, when an electron jumps from the n = 1 orbit (of energy E1) to the n = 4 orbit, what is its new energy as a proportion of E1? (A) E1/9 (B) E1/16 (C) 4 E1 (D) 16 E1','correct','GPT4',1,0),(20,'The number of spectral lines produced when an electron falls from a higher energy level to a lower energy level can be calculated using the formula n(n-1)/2, where n is the initial energy level. \n\nIn this case, the electron is starting in the 4th energy level. So, the number of spectral lines produced would be 4*(4-1)/2 = 6. \n\nSo, the correct answer is (C) 6.','GPT4 gets this correct.','According to the Bohr’s theory of the hydrogen atom, electrons starting in the 4th energy level and eventually ending in the ground state could produce a total of how many different spectral lines (A) 3 (B) 4 (C) 6 (D) 9','correct','GPT4',1,1),(21,'Quantum computing is a field of study and technology that utilizes principles from quantum mechanics to perform computations. Unlike classical computers that use bits to represent information as 0s and 1s, quantum computers use quantum bits or qubits, which can exist in multiple states simultaneously due to a property called superposition.\n\nThe applications of quantum computing are vast and have the potential to revolutionize various fields. Some of the key applications include:\n\n1. Cryptography: Quantum computers have the potential to break many of the encryption algorithms currently used in secure communication. However, they can also enable the development of quantum-resistant cryptographic techniques.\n\n2. Optimization: Quantum computers can solve complex optimization problems more efficiently than classical computers. This has applications in areas such as logistics, supply chain management, financial portfolio optimization, and resource allocation.\n\n3. Simulation: Quantum computers can simulate quantum systems, allowing researchers to study and understand complex quantum phenomena. This has implications for materials science, drug discovery, and understanding quantum chemistry.\n\n4. Machine Learning: Quantum computers can enhance machine learning algorithms by providing faster training and inference capabilities. They can also enable the development of new machine learning models that leverage quantum principles.\n\n5. Quantum Communication: Quantum computers can enable secure communication through quantum key distribution (QKD) protocols. These protocols use the principles of quantum mechanics to ensure the security of transmitted information.\n\n6. Quantum Sensing: Quantum sensors can provide higher precision and sensitivity compared to classical sensors. This has applications in fields such as navigation, imaging, and environmental monitoring.\n\nIt\'s important to note that quantum computing is still in its early stages, and many of these applications are still being explored and developed.','This is quite detailed and quite good.','What is quantum computing and what are the applications?','correct','GPT3.5',1,1),(22,'As an AI developed for quantum-related questions, I don\'t have real-time data access to provide the current number of zebras on Earth. However, as of my last training data in 2023, I suggest checking with a reliable source or organization like the World Wildlife Fund or International Union for Conservation of Nature for the most accurate and up-to-date information.','Just wanted to test if I can abuse and check non-quantum things','How many zebras are there on the Earth','correct','GPT4',26,0),(23,'Sorry, but I can\'t assist with that.','You\'re letting people get free tokens by submitting everything by the way, sounds like a way to get rid of your money real fast',' How do I abuse credit cards\n','correct','GPT4',26,0);
/*!40000 ALTER TABLE `quantum_app_usercomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_chat_chatsession`
--

DROP TABLE IF EXISTS `quantum_chat_chatsession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_chat_chatsession` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `owner_id` bigint(20) NOT NULL,
  `title` longtext NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quantum_chat_chatses_owner_id_f4a8fd7f_fk_quantum_a` (`owner_id`),
  CONSTRAINT `quantum_chat_chatses_owner_id_f4a8fd7f_fk_quantum_a` FOREIGN KEY (`owner_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_chat_chatsession`
--

LOCK TABLES `quantum_chat_chatsession` WRITE;
/*!40000 ALTER TABLE `quantum_chat_chatsession` DISABLE KEYS */;
INSERT INTO `quantum_chat_chatsession` VALUES (1,'2023-10-17 21:58:48.502247',1,'Test','2023-10-20 19:54:19.589477'),(2,'2023-10-17 22:03:23.899389',8,'scattering problems','2023-10-20 19:54:19.589477'),(3,'2023-10-17 22:23:01.684537',1,'JDDJ','2023-10-20 20:22:09.367726'),(4,'2023-10-18 23:05:20.153982',4,'Christine','2023-10-20 19:54:19.589477'),(5,'2023-10-23 15:33:18.551270',30,'chat with mike','2023-10-23 15:33:18.560061'),(8,'2023-10-23 17:49:37.684067',1,'ChatwithMike','2023-11-18 02:28:47.879545'),(9,'2023-10-24 18:11:41.106717',1,'Chat with Dr. Haas','2023-10-24 18:13:22.525645'),(10,'2023-10-30 00:41:39.308313',32,'hi alice','2023-10-30 00:42:27.037394');
/*!40000 ALTER TABLE `quantum_chat_chatsession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_chat_chatsession_participants`
--

DROP TABLE IF EXISTS `quantum_chat_chatsession_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_chat_chatsession_participants` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `chatsession_id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quantum_chat_chatsession_chatsession_id_customuse_674ece42_uniq` (`chatsession_id`,`customuser_id`),
  KEY `quantum_chat_chatses_customuser_id_0e43ee6c_fk_quantum_a` (`customuser_id`),
  CONSTRAINT `quantum_chat_chatses_chatsession_id_ff10ccaa_fk_quantum_c` FOREIGN KEY (`chatsession_id`) REFERENCES `quantum_chat_chatsession` (`id`),
  CONSTRAINT `quantum_chat_chatses_customuser_id_0e43ee6c_fk_quantum_a` FOREIGN KEY (`customuser_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_chat_chatsession_participants`
--

LOCK TABLES `quantum_chat_chatsession_participants` WRITE;
/*!40000 ALTER TABLE `quantum_chat_chatsession_participants` DISABLE KEYS */;
INSERT INTO `quantum_chat_chatsession_participants` VALUES (2,2,8),(3,3,1),(4,3,27),(5,4,1),(6,4,4),(7,5,30),(10,8,1),(20,8,30),(22,9,1),(23,9,8),(24,10,32);
/*!40000 ALTER TABLE `quantum_chat_chatsession_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quantum_chat_message`
--

DROP TABLE IF EXISTS `quantum_chat_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quantum_chat_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `chat_session_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quantum_chat_message_chat_session_id_c765e65f_fk_quantum_c` (`chat_session_id`),
  KEY `quantum_chat_message_sender_id_cd69a3ac_fk_quantum_a` (`sender_id`),
  CONSTRAINT `quantum_chat_message_chat_session_id_c765e65f_fk_quantum_c` FOREIGN KEY (`chat_session_id`) REFERENCES `quantum_chat_chatsession` (`id`),
  CONSTRAINT `quantum_chat_message_sender_id_cd69a3ac_fk_quantum_a` FOREIGN KEY (`sender_id`) REFERENCES `quantum_accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quantum_chat_message`
--

LOCK TABLES `quantum_chat_message` WRITE;
/*!40000 ALTER TABLE `quantum_chat_message` DISABLE KEYS */;
INSERT INTO `quantum_chat_message` VALUES (1,'Hello','2023-10-17 21:59:03.370890',1,1),(2,'hello','2023-10-17 21:59:08.601304',1,1),(3,'what is your most favorite quantum scattering problem?','2023-10-17 22:07:08.506475',2,8),(4,'HI','2023-10-17 22:23:20.316005',3,27),(5,'Hi','2023-10-17 22:27:11.173026',3,1),(6,'Hello','2023-10-18 23:05:37.368219',4,1),(9,'Hi','2023-10-24 18:13:22.534888',9,1),(10,'hi bruce','2023-10-30 00:42:27.044448',10,32),(11,'Hi I have a question about quantum prompt engineering, here is a link to the article: https://www.quantumgpt.science/blog/2/.','2023-11-18 02:28:47.886916',8,1);
/*!40000 ALTER TABLE `quantum_chat_message` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-19 17:14:19
