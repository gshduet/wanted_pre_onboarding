-- MySQL dump 10.13  Distrib 8.0.28, for macos12.2 (arm64)
--
-- Host: localhost    Database: wanted
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `details`
--

DROP TABLE IF EXISTS `details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `supporter_count` int unsigned NOT NULL,
  `current_amount` decimal(10,2) NOT NULL,
  `achievment_rate` decimal(10,0) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  CONSTRAINT `details_product_id_489bc558_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `details_chk_1` CHECK ((`supporter_count` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `details`
--

LOCK TABLES `details` WRITE;
/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` VALUES (1,'2022-04-16 18:19:08.282355','2022-04-16 19:54:39.515183',15,300000.00,3,1),(2,'2022-04-17 07:26:07.790231','2022-04-17 07:27:48.392282',10,500000.00,5,5);
/*!40000 ALTER TABLE `details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'contenttypes','contenttype'),(6,'products','detail'),(5,'products','product'),(4,'products','supporter'),(2,'sessions','session'),(3,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-04-16 07:52:51.863651'),(2,'contenttypes','0002_remove_content_type_name','2022-04-16 07:52:51.893098'),(3,'users','0001_initial','2022-04-16 07:52:51.899869'),(4,'products','0001_initial','2022-04-16 07:52:51.947756'),(5,'sessions','0001_initial','2022-04-16 07:52:51.956886'),(6,'products','0002_rename_donator_supporter_remove_product_donators_and_more','2022-04-16 08:10:39.908340'),(7,'products','0003_alter_product_end_date','2022-04-16 09:01:49.798081'),(8,'products','0004_rename_funding_per_session_product_support_per_session','2022-04-16 17:09:20.064286'),(9,'products','0005_product_is_delete_supporter_is_delete','2022-04-16 17:12:19.602185'),(10,'products','0006_productdetail','2022-04-16 18:08:45.470655'),(11,'products','0007_rename_productdetail_detail_alter_product_delete_at_and_more','2022-04-16 18:51:52.661209'),(12,'products','0008_alter_detail_achievment_rate','2022-04-16 19:42:16.195305');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
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
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `title` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `context` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `target_amount` decimal(10,2) NOT NULL,
  `support_per_session` decimal(10,2) NOT NULL,
  `end_date` date NOT NULL,
  `delete_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_user_id_0be7171c_fk_users_id` (`user_id`),
  CONSTRAINT `products_user_id_0be7171c_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'2022-04-16 18:31:53.494816','2022-04-17 07:24:08.590176','test_product_01','uploading test v01',10000000.00,10000.00,'2022-06-30',NULL,1,0),(5,'2022-04-17 07:26:07.788408','2022-04-17 07:35:20.826935','test_product_05','uploading test v05',10000000.00,50000.00,'2022-06-30','2022-04-17 07:35:20.826813',43,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supporters`
--

DROP TABLE IF EXISTS `supporters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supporters` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `delete_at` datetime(6) DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `donators_product_id_0dbc8800_fk_products_id` (`product_id`),
  KEY `donators_user_id_ad86947d_fk_users_id` (`user_id`),
  CONSTRAINT `donators_product_id_0dbc8800_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `donators_user_id_ad86947d_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supporters`
--

LOCK TABLES `supporters` WRITE;
/*!40000 ALTER TABLE `supporters` DISABLE KEYS */;
INSERT INTO `supporters` VALUES (6,NULL,1,2,0),(7,NULL,1,2,0),(8,NULL,1,2,0),(9,NULL,1,2,0),(10,NULL,1,2,0),(11,'2022-04-16 18:56:00.902228',1,2,1),(13,'2022-04-16 18:55:41.074251',1,2,1),(14,NULL,1,2,0),(15,NULL,1,2,0),(16,NULL,1,2,0),(17,NULL,1,2,0),(18,NULL,1,2,0),(19,NULL,1,2,0),(20,NULL,1,2,0),(21,NULL,1,2,0),(22,NULL,1,2,0),(23,NULL,1,2,0),(24,'2022-04-17 07:35:20.829907',5,4,1),(25,'2022-04-17 07:35:20.831460',5,4,1),(26,'2022-04-17 07:35:20.833168',5,4,1),(27,'2022-04-17 07:35:20.834857',5,4,1),(28,'2022-04-17 07:35:20.836500',5,4,1),(29,'2022-04-17 07:35:20.838139',5,4,1),(30,'2022-04-17 07:35:20.840066',5,79,1),(31,'2022-04-17 07:35:20.841691',5,79,1),(32,'2022-04-17 07:35:20.842606',5,79,1),(33,'2022-04-17 07:35:20.843334',5,79,1);
/*!40000 ALTER TABLE `supporters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2022-04-16 08:52:20.788222','2022-04-16 08:52:20.789817','test_user_001','$2b$12$n8Pt4myYkAGmEJHbZl50qOut4LIadA71qrVXbE0JCN8pXkieOlEtq','test_user_001'),(2,'2022-04-16 08:52:24.227783','2022-04-16 08:52:24.227813','test_user_002','$2b$12$wN.ROV0Ul4e6nylfBvRjUOg923b1fw/AVUjTUjph2KtXxTBV8yZta','test_user_002'),(3,'2022-04-16 08:52:26.900439','2022-04-16 08:52:26.900465','test_user_003','$2b$12$z7r9ezH136dtsfEZSAYQ1.UByfUPczIS5gKTJTxyyjcb5.uyUEIVK','test_user_003'),(4,'2022-04-16 08:52:29.478458','2022-04-16 08:52:29.478492','test_user_004','$2b$12$Vu85ofLkj6.tDBAeN6WTFu2dgOapjXh77sHT/Rh2xdpsXst3Ar82O','test_user_004'),(5,'2022-04-16 08:52:32.201402','2022-04-16 08:52:32.201432','test_user_005','$2b$12$wSdQX6FCgtP60LAhK0UG2OA/Wy6JspGCdBxL7A.RxvkzoQadzQ5T6','test_user_005'),(6,'2022-04-16 08:52:35.369779','2022-04-16 08:52:35.369814','test_user_006','$2b$12$v1AQARDXjsgG6CsAg5Z06uXAmf6BVl/OiH0g.1GJmhEqnkxtQXE2y','test_user_006'),(7,'2022-04-16 08:52:38.568170','2022-04-16 08:52:38.568197','test_user_007','$2b$12$s0QXQuMkvBqaxk026zZDI.HjSLbPOy4QwkQ5hLxCN69TWHglcUX8i','test_user_007'),(8,'2022-04-16 08:52:41.292553','2022-04-16 08:52:41.292587','test_user_008','$2b$12$xhzGckbrVwE9XbrFPR6W3.byN1Q6ab8770cplIMz8tiFadCcmVbLq','test_user_008'),(9,'2022-04-16 08:52:44.168941','2022-04-16 08:52:44.168970','test_user_009','$2b$12$oWUEFBdty9YpkczbFw5GF.HT6UimKdvUcXzwJ56g48PcmRYaRTntm','test_user_009'),(10,'2022-04-16 08:52:48.118068','2022-04-16 08:52:48.118094','test_user_010','$2b$12$nh4mj.seYRdXJ6RAX1ZsT.dUdXJHHetuDuV2StTM42/rIh7p2TYIe','test_user_010'),(11,'2022-04-16 08:56:57.193717','2022-04-16 08:56:57.193884','test_user_011','$2b$12$31Yn8qL0ZxAAJdaI4EHtEuRTtklz6trlw/gS5I5ekFzZZQVYbAfYW','test_user_011'),(14,'2022-04-16 08:58:10.039449','2022-04-16 08:58:10.039486','test_user_012','$2b$12$pugSKlT/q4ROYcw9jyDgS.Y6NcB.qZhqKL4eB8dB3u3E8nE94BXd2','test_user_012'),(15,'2022-04-16 08:58:10.418236','2022-04-16 08:58:10.418274','test_user_013','$2b$12$jF94qMqg800zhKgrHYQ4tusBghwkQwdLcyEmDnCvY4I.6kDXLbf8K','test_user_013'),(16,'2022-04-16 08:58:10.797217','2022-04-16 08:58:10.797244','test_user_014','$2b$12$0nb/t34W82AlyLPSDqnFPupivY0gUc3ryfOGVbf8Ma8p8TWLRgC5m','test_user_014'),(17,'2022-04-16 08:58:11.175159','2022-04-16 08:58:11.175187','test_user_015','$2b$12$ncbgUTyvPwc4CAfOwsm8eerr.ndvZqMQuEhVyN.v/jYCMtK/lUPzi','test_user_015'),(18,'2022-04-16 08:58:11.553700','2022-04-16 08:58:11.553731','test_user_016','$2b$12$4dJ1kHjNzt45je/uwbZz5O5zlmEhXqRIp1dVZXo70Agud1iUzFs1q','test_user_016'),(19,'2022-04-16 08:58:11.932517','2022-04-16 08:58:11.932549','test_user_017','$2b$12$KLegiakrq.6Xt.9JSx13/OsJ8uh1PJn7C99xkfKaytkKZGHp2jw3u','test_user_017'),(20,'2022-04-16 08:58:12.311000','2022-04-16 08:58:12.311029','test_user_018','$2b$12$hk/CRV3mS2/EhHvk02kSpueCO86lur.FoPtcFPFutZgqb1Bbkxehi','test_user_018'),(21,'2022-04-16 08:58:12.689294','2022-04-16 08:58:12.689319','test_user_019','$2b$12$.kwjDVgZGiviOfJPuCkUj.ghnRo5JzY2s37T7Iy8XcE2rE2IeXFEG','test_user_019'),(22,'2022-04-16 08:58:13.067524','2022-04-16 08:58:13.067556','test_user_020','$2b$12$b/x9so1oKSb8CV/M65Ut3OzS/Hi7jYB.dA7Gx0KAHkwOw1V12Bld2','test_user_020'),(23,'2022-04-16 08:58:13.446609','2022-04-16 08:58:13.446639','test_user_021','$2b$12$R0UdrAGHACXuqJGs8eQD6e5.t9GoG.GihiJ3hStvYclU/oLbp2VYC','test_user_021'),(24,'2022-04-16 08:58:13.825143','2022-04-16 08:58:13.825179','test_user_022','$2b$12$Sc45gavNIsUVqDrSfINPgu4nAGCENfB5/lLbjKLeD5.SqNmv3OoUa','test_user_022'),(25,'2022-04-16 08:58:14.203625','2022-04-16 08:58:14.203659','test_user_023','$2b$12$qILct.KAdSVXWaGh6NyqZ.pv8ipIv3CSG8l1oZISYRlTWfha7aL5u','test_user_023'),(26,'2022-04-16 08:58:14.581595','2022-04-16 08:58:14.581616','test_user_024','$2b$12$Do586mMeISxpdAM5bhuJYeQ1qvWh00lRvI3kyF6CWUtaqR5whk5ji','test_user_024'),(27,'2022-04-16 08:58:14.960383','2022-04-16 08:58:14.960417','test_user_025','$2b$12$XSxncctzN2AZSjCCNE6V4e.0Y3ZCxJHI4iVmtreXVnKThO/VwkHqC','test_user_025'),(28,'2022-04-16 08:58:15.338938','2022-04-16 08:58:15.338970','test_user_026','$2b$12$jOg/SEKCSgqqnfr7vKWTYeGYKQJLYt5Fo5TmpcH8tq3OA046Hlx2u','test_user_026'),(29,'2022-04-16 08:58:15.717611','2022-04-16 08:58:15.717635','test_user_027','$2b$12$FQdkOe9mEPZvIqSPzYNQ8e.ge/SLFc.o1ch8WbBZwfSi.LxCW5.6a','test_user_027'),(30,'2022-04-16 08:58:16.095787','2022-04-16 08:58:16.095817','test_user_028','$2b$12$pUZXamk1T.WKzvdqDwGVTO7W6dpWQHvyb8qmWoODwYxi0W20mpGo6','test_user_028'),(31,'2022-04-16 08:58:16.474363','2022-04-16 08:58:16.474389','test_user_029','$2b$12$kmt83aOW3xAjEzgsnHrML.VIaO8.kGZUOOsDlYK/LUAaSG9zN.dwC','test_user_029'),(32,'2022-04-16 08:58:16.853179','2022-04-16 08:58:16.853204','test_user_030','$2b$12$6t8ShYN08zAlg4TC7s5xX.wvgl6akk/D1IoX5dhSyaBuLSPCgv2Qy','test_user_030'),(33,'2022-04-16 08:58:17.231612','2022-04-16 08:58:17.231630','test_user_031','$2b$12$ubVJ8/M.MWmKsnxsqZq8UO/.JmXTOHq7B6BUTNDgVSUMuOOglq1ja','test_user_031'),(34,'2022-04-16 08:58:17.609679','2022-04-16 08:58:17.609707','test_user_032','$2b$12$wTe3N8AjmxBmRx3GCkyp9enn7vMqTX8QJyqXNaXlTQxkmcCx8Am.m','test_user_032'),(35,'2022-04-16 08:58:17.988286','2022-04-16 08:58:17.988311','test_user_033','$2b$12$0J38I7hhaHEXRrDhg4sZBOdL0wkAWHfLoj0FiU63wtYEUNnYwfGc6','test_user_033'),(36,'2022-04-16 08:58:18.366686','2022-04-16 08:58:18.366712','test_user_034','$2b$12$gRrOSuJ/ZdLHYOL547lYSeMd3S7zYy4QX4pwlvmzE/KBmi2G447IG','test_user_034'),(37,'2022-04-16 08:58:18.745214','2022-04-16 08:58:18.745243','test_user_035','$2b$12$tJlaoUtUKlaxZjPDdjHIs.WK4HaVKddmp/YiqPY219GkPeK6IPlIu','test_user_035'),(38,'2022-04-16 08:58:19.123658','2022-04-16 08:58:19.123689','test_user_036','$2b$12$f5UtQ7AsoW2iD1p1mamtZ.SAGPNq/ijie8JMqYKUog09klUQC5pAK','test_user_036'),(39,'2022-04-16 08:58:19.502514','2022-04-16 08:58:19.502540','test_user_037','$2b$12$dTI/k8Zp/V5NfONFZN2J4.S4/KGBIHdWLL5VADpQWXtcvW46ipaFC','test_user_037'),(40,'2022-04-16 08:58:19.882899','2022-04-16 08:58:19.882929','test_user_038','$2b$12$eyLEXYXX9.g46UmhoAP7gey62x6ze2T5xaxTpk9B4AXTOHcEtu6A.','test_user_038'),(41,'2022-04-16 08:58:20.264731','2022-04-16 08:58:20.264756','test_user_039','$2b$12$ISg0yuVZu/w8pdS1aI21TegTJB/qkuVpaTjk8i79FOxeUotUS.tQO','test_user_039'),(42,'2022-04-16 08:58:20.643766','2022-04-16 08:58:20.643793','test_user_040','$2b$12$bwMg7sOdO11H2arkgo62eOcS7FdFbXpPCz2rkln5I36XRltH3y0oa','test_user_040'),(43,'2022-04-16 08:58:21.023338','2022-04-16 08:58:21.023372','test_user_041','$2b$12$H4EA7/Rbm5xvheaPMtZVkuZJugKy2T0JQWLJGkWcB.Yw6HGfD55XG','test_user_041'),(44,'2022-04-16 08:58:21.405376','2022-04-16 08:58:21.405410','test_user_042','$2b$12$IxxighODfGZNITcs7JmnyeV.yaZKcSvJLRYOCvzSiA/8Rw97iSjmK','test_user_042'),(45,'2022-04-16 08:58:21.784316','2022-04-16 08:58:21.784344','test_user_043','$2b$12$1J0XhZEWI9RLomm67j1bTexdHKozZwtYddKJNrcnjDEEEb76PvQXu','test_user_043'),(46,'2022-04-16 08:58:22.162788','2022-04-16 08:58:22.162822','test_user_044','$2b$12$kslv4LPMJIA.MGy7ykND2.oL5Rnz388f73uasLfB6wuBPb/vZXCze','test_user_044'),(47,'2022-04-16 08:58:22.541937','2022-04-16 08:58:22.541967','test_user_045','$2b$12$wMsii9MCAOND91rSvzmBputHh6s91G/qyrdfQ4Rw3IxlkjXlBcdUq','test_user_045'),(48,'2022-04-16 08:58:22.921332','2022-04-16 08:58:22.921366','test_user_046','$2b$12$K.EcxK2jXzxcOswfDR56/uwJTRxvdbuyvCI/eyrUZeIZrk108OXqS','test_user_046'),(49,'2022-04-16 08:58:23.300135','2022-04-16 08:58:23.300163','test_user_047','$2b$12$YdyqIUoBlNSFVRK8UjiWceGUUzA1Vq5l5lBEHmBBeDwBvyKrnfgfO','test_user_047'),(50,'2022-04-16 08:58:23.679060','2022-04-16 08:58:23.679087','test_user_048','$2b$12$3.CH6sc9IbhlIrMr.mwFoOuUyOspeU5WOXb8IQVkbxfMmRfjTWPBu','test_user_048'),(51,'2022-04-16 08:58:24.058456','2022-04-16 08:58:24.058487','test_user_049','$2b$12$XuE0uwObGYjCy9cHNb9.refXu8e0YtKhk6zLQvcDzrYS/83tWQeYu','test_user_049'),(52,'2022-04-16 08:58:24.437541','2022-04-16 08:58:24.437567','test_user_050','$2b$12$fbPIqYbpXRBOBJrKGcVYXO2mTsU7RsBpm8Yz5.nf7jmsRfgItsSB6','test_user_050'),(53,'2022-04-16 08:58:24.816824','2022-04-16 08:58:24.816849','test_user_051','$2b$12$RwVwdQeIjkxNkDEmJU6CY..7UhcWDQM8fu3i851be//andcONDHji','test_user_051'),(54,'2022-04-16 08:58:25.195498','2022-04-16 08:58:25.195524','test_user_052','$2b$12$MWdqhKPdp2F6Vl1i8TK14eJwoPUGgJPiwNWiK2.l4NLGggZoD2Rii','test_user_052'),(55,'2022-04-16 08:58:25.575529','2022-04-16 08:58:25.575554','test_user_053','$2b$12$v4Cho/gxvrKK.titfPFBU.BNUahE./97ejJsW8ce1URf4Pxmrwkfm','test_user_053'),(56,'2022-04-16 08:58:25.954075','2022-04-16 08:58:25.954097','test_user_054','$2b$12$QzWbhLJzIqR3XNONVKM6UebRKNfvGjh8wJ6h.Jz9faCYGHFiOOnnq','test_user_054'),(57,'2022-04-16 08:58:26.333689','2022-04-16 08:58:26.333724','test_user_055','$2b$12$HGVuo6lKUeJ51thLPuDBDeFTSGtCJoo0MwrHnvOX0wtfPqVwsDioq','test_user_055'),(58,'2022-04-16 08:58:26.712591','2022-04-16 08:58:26.712624','test_user_056','$2b$12$HRq75b4L0ardwqL/qhK9rO66nKlCwgWAqZgsA9E.Wh/54vw2SicPC','test_user_056'),(59,'2022-04-16 08:58:27.090962','2022-04-16 08:58:27.090985','test_user_057','$2b$12$hJug4lpXSrTXVWsAQDHzm.7a8uNemFKOjltm14VyRRWQB4qrSqfMa','test_user_057'),(60,'2022-04-16 08:58:27.469238','2022-04-16 08:58:27.469272','test_user_058','$2b$12$3WI8TOVtxnj8SGee4r9faOAeV30msdDeKitB5PJNhrj8DBTuQpKt6','test_user_058'),(61,'2022-04-16 08:58:27.847501','2022-04-16 08:58:27.847522','test_user_059','$2b$12$3MQ331KAcEdOz1iqQyaCUeATD7DCRDx7fLvYlW4rE6tpk78Ry481m','test_user_059'),(62,'2022-04-16 08:58:28.226669','2022-04-16 08:58:28.226699','test_user_060','$2b$12$pKAOm6Qk.yxkjYxbErGB0O9/jRxQzDw30tlxbbYL0zE2pa6b5Qq7C','test_user_060'),(63,'2022-04-16 08:58:28.604895','2022-04-16 08:58:28.604925','test_user_061','$2b$12$KTXvF6B4hptND1VaH3pcSOW6U7aGdaOotc4cy5.pEp9aidkqF1jnm','test_user_061'),(64,'2022-04-16 08:58:28.983067','2022-04-16 08:58:28.983094','test_user_062','$2b$12$gnSTW/.NRG09hVkIcG4MmebugKDb6519adLXPOQTxXVq/j5PJP3H2','test_user_062'),(65,'2022-04-16 08:58:29.361496','2022-04-16 08:58:29.361525','test_user_063','$2b$12$yHoby2MXvdHejvodLiv5iuczanvM5BhjfVu6gMLvHjmANPqaOp496','test_user_063'),(66,'2022-04-16 08:58:29.742031','2022-04-16 08:58:29.742064','test_user_064','$2b$12$bIyu6pQnHNsIg2EbJbvujOf0zoeIm73P8VlikqyuEtLzCiOFLYQkq','test_user_064'),(67,'2022-04-16 08:58:30.124074','2022-04-16 08:58:30.124104','test_user_065','$2b$12$vNS3ct8qwlfovREchVGExuDJPAmpwy.bZ.L8FkvKY2dnDL47Ez2oi','test_user_065'),(68,'2022-04-16 08:58:30.505343','2022-04-16 08:58:30.505367','test_user_066','$2b$12$xzpVoju0gO6x2QXdycyx7eSIskJU9O3Zh/H3dbA80WVBSV4qDFqL2','test_user_066'),(69,'2022-04-16 08:58:30.884419','2022-04-16 08:58:30.884442','test_user_067','$2b$12$JGYfJzjgm1exRflr1Pyxq.Iw4jCC9VNUyrYaeLhr4x/xHhZMn2QPC','test_user_067'),(70,'2022-04-16 08:58:31.263765','2022-04-16 08:58:31.263793','test_user_068','$2b$12$5KnV787tC/UAhHQDBaIVUud8o98HK0oq8a4Pkh/g8.3QmjCCtn5Jm','test_user_068'),(71,'2022-04-16 08:58:31.644585','2022-04-16 08:58:31.644622','test_user_069','$2b$12$S0e9xkGRXO.ei4yueaESfeQrzEuJd36SNMoKQcs.Dm8w5fWhRcXRe','test_user_069'),(72,'2022-04-16 08:58:32.024698','2022-04-16 08:58:32.024729','test_user_070','$2b$12$cHbyVlwJgvVlAeLrt/uAqOC2ViCV5P0PHG3BouJ9OIe3CnEoQ6z0u','test_user_070'),(73,'2022-04-16 08:58:32.403869','2022-04-16 08:58:32.403896','test_user_071','$2b$12$P5TOW9.xGJSJ9tYZeAq/luh81sN97qhfXTVFCGWqJCcMxisz9W.xW','test_user_071'),(74,'2022-04-16 08:58:32.784238','2022-04-16 08:58:32.784260','test_user_072','$2b$12$sZQxw/1EDOnWTjUOc.OZYu6imiJSCxfLLUoRlBlmUurfxdLEqES3i','test_user_072'),(75,'2022-04-16 08:58:33.162903','2022-04-16 08:58:33.162938','test_user_073','$2b$12$nq64OzUD.13T.szmsrSnO.dPQk4GtlEicxJ/iBPY/A56IDO0YGTrq','test_user_073'),(76,'2022-04-16 08:58:33.543887','2022-04-16 08:58:33.543921','test_user_074','$2b$12$blfERzCjzk2y2RxUyU4u/./X39UXBklAx.gD04mru/BwxrEPMfgxy','test_user_074'),(77,'2022-04-16 08:58:33.922516','2022-04-16 08:58:33.922539','test_user_075','$2b$12$yDKthowM.7d0VUU4KsNUbeOFhqM3qBzgrQoudvK3gTSnc6OYnWwTS','test_user_075'),(78,'2022-04-16 08:58:34.301748','2022-04-16 08:58:34.301777','test_user_076','$2b$12$SyfqL3jEeSM6og6SlHT14.sYZEnm8au1yhYcfuVBm1jGLJm6qHSZm','test_user_076'),(79,'2022-04-16 08:58:34.681533','2022-04-16 08:58:34.681562','test_user_077','$2b$12$x5fb1c9fhzHEYU13qg23YOgSdt5HHX67ZEZaDbTuUWg/5F6i/e47e','test_user_077'),(80,'2022-04-16 08:58:35.060443','2022-04-16 08:58:35.060472','test_user_078','$2b$12$BhZ2mWBDuI4aTlnKS2X9UOX34RKvff5qNJyw1iBWefYDvYJ9wlFpW','test_user_078'),(81,'2022-04-16 08:58:35.439557','2022-04-16 08:58:35.439586','test_user_079','$2b$12$RJ8jIcpXQFRLm244czWrdum4CdvStd7HJNBcXK/doik4yzO.apLhG','test_user_079'),(82,'2022-04-16 08:58:35.836791','2022-04-16 08:58:35.836818','test_user_080','$2b$12$As4B0G1rO49kJCyQW/DtI.ovsuQQKr/DyzpbxSLXl0GqtTFgpmVyC','test_user_080'),(83,'2022-04-16 08:58:36.215469','2022-04-16 08:58:36.215506','test_user_081','$2b$12$fugR49PzjtKpMXOoJE11mOYhWiZVqoAtgywhYrSggF./I54Kbh34y','test_user_081'),(84,'2022-04-16 08:58:36.594267','2022-04-16 08:58:36.594297','test_user_082','$2b$12$wsdYxDn/mRXvZULDFGHtte1aP.fpnfdTGmvJB2nd3wZGy3hauzwQ.','test_user_082'),(85,'2022-04-16 08:58:36.973251','2022-04-16 08:58:36.973279','test_user_083','$2b$12$Dx133FXt1NADPVMmkcbPU.aCxTybL2mCwj89L9I/qfuK7aPKDFPla','test_user_083'),(86,'2022-04-16 08:58:37.352870','2022-04-16 08:58:37.352903','test_user_084','$2b$12$Gzj.4o5gLHS3hp1ubGdsiOHlR3kSRy5Lis4Yo6X8DJzyIuGEYbT7K','test_user_084'),(87,'2022-04-16 08:58:37.731750','2022-04-16 08:58:37.731782','test_user_085','$2b$12$zvNavhgP47MV.Gi6qkFhDuU4C8mMm0jh2/0ngRd5pD.expfcIeBme','test_user_085'),(88,'2022-04-16 08:58:38.110193','2022-04-16 08:58:38.110218','test_user_086','$2b$12$iMk.6P3tKUp.JDUrwzcNQeDdJBFVZgtrspHMiAX7nUGEqhTD9PqEi','test_user_086'),(89,'2022-04-16 08:58:38.488437','2022-04-16 08:58:38.488459','test_user_087','$2b$12$sr/A.Ll31NNcY0GRWjZgpuVw3K.RzSI3.pGbuASyPgTvSGqihFxVC','test_user_087'),(90,'2022-04-16 08:58:38.866843','2022-04-16 08:58:38.866862','test_user_088','$2b$12$HjQ9JgQawtmN3Ab67BB5ZuNyUc76YFDqSJaR.YZ/Sz/5zq8s6JWwy','test_user_088'),(91,'2022-04-16 08:58:39.245314','2022-04-16 08:58:39.245333','test_user_089','$2b$12$iCrcg675awoexMjNJbN1Fuibv9RPzN4L/4hOqI9ZPmm4BRgiUkXlC','test_user_089'),(92,'2022-04-16 08:58:39.624425','2022-04-16 08:58:39.624453','test_user_090','$2b$12$MbT15qUuKweV1GyPqA318erXXp288X/DQZ3ZOEzojhzclZLWBC3aa','test_user_090'),(93,'2022-04-16 08:58:40.003153','2022-04-16 08:58:40.003180','test_user_091','$2b$12$st50n1KcKK6AoQbCH8Cgj.LzKwCR7auQL6MhqGbaltRjBftC.QHTi','test_user_091'),(94,'2022-04-16 08:58:40.381296','2022-04-16 08:58:40.381316','test_user_092','$2b$12$zHjfFB58E2yZvbviq5C1vu6ydA78U/QDWal8RfoFpQWKo0pIVKwhK','test_user_092'),(95,'2022-04-16 08:58:40.760517','2022-04-16 08:58:40.760550','test_user_093','$2b$12$w4JLNGc0IQ2cN0fma0.Cdu7GuD4CGPzcp/GDCYckPFcGTNu62b7Va','test_user_093'),(96,'2022-04-16 08:58:41.139934','2022-04-16 08:58:41.139966','test_user_094','$2b$12$M9E5fJadxOSjTQspoxlL7OFbrzHl7E7bEv1rJ.22wYliZ4cEjyfR.','test_user_094'),(97,'2022-04-16 08:58:41.518503','2022-04-16 08:58:41.518532','test_user_095','$2b$12$RYXAAMb6IH1w66dnZghWFOqZaYqJFqg27/GTFguG/iJ5fCPs78o9G','test_user_095'),(98,'2022-04-16 08:58:41.897252','2022-04-16 08:58:41.897279','test_user_096','$2b$12$o5vKRbQ/R3SvtK6lLsneu.AtE87nsGoY3KImxhs9Unkg8npd7Do6C','test_user_096'),(99,'2022-04-16 08:58:42.275837','2022-04-16 08:58:42.275864','test_user_097','$2b$12$gSpzPXoAb.WIEbAmP5aQaemzOlIxZIEyeEm3eAE.KXDIsuE0RJtKC','test_user_097'),(100,'2022-04-16 08:58:42.655699','2022-04-16 08:58:42.655733','test_user_098','$2b$12$g9ZBYwbyDV373/woKZ/Yde3IciQujVuDNvmu97TgJFnID2rPaXls2','test_user_098'),(101,'2022-04-16 08:58:43.034519','2022-04-16 08:58:43.034544','test_user_099','$2b$12$bhDZWXjJAFAaA2edTpUbMeqTcGBrUWojTBPMOUQ4NJ9f06HZMw4wO','test_user_099'),(102,'2022-04-16 08:58:43.412720','2022-04-16 08:58:43.412746','test_user_100','$2b$12$JrAMTVPw2zP6NdpzJxF10enpL.wNWjCwhqyGSmhFe2d7jFGL29Zo2','test_user_100'),(103,'2022-04-17 07:49:54.990028','2022-04-17 07:49:54.990062','test_user_101','$2b$12$geOngrRRnS5ADgvclLJ3W.ROmIk3RAmmQZYdfNo1HEhlw5rDGEmu2','test_user_101');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-17 23:53:20
