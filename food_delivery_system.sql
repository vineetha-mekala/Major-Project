CREATE DATABASE  IF NOT EXISTS `food_delivery_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `food_delivery_system`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: food_delivery_system
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL,
  `building_name` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `pin_code` varchar(6) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(30) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Building 1','MG Road','560001','Bangalore','Karnataka'),(2,'Building 2','Park Street','700001','Kolkata','West Bengal'),(3,'Building 3','Lalbagh Road','560004','Bangalore','Karnataka'),(4,'Building 4','Bandra Kurla Complex','400051','Mumbai','Maharashtra'),(5,'Building 5','Park Street','700016','Kolkata','West Bengal'),(6,'Building 6','Dhole Patil Road','411001','Pune','Maharashtra'),(7,'Building 7','Anna Salai','600002','Chennai','Tamil Nadu'),(8,'Building 8','Connaught Place','110001','New Delhi','Delhi'),(9,'Building 9','Richmond Road','560025','Bangalore','Karnataka'),(10,'Building 10','Park Street','700071','Kolkata','West Bengal'),(11,'Building 11','Juhu Tara Road','400049','Mumbai','Maharashtra'),(12,'Building 12','Park Street','700017','Kolkata','West Bengal'),(13,'Building 13','MG Road','560001','Bangalore','Karnataka'),(14,'Building 14','Linking Road','400054','Mumbai','Maharashtra'),(15,'Building 15','Park Street','700019','Kolkata','West Bengal'),(16,'Building 16','Residency Road','560025','Bangalore','Karnataka'),(17,'Building 17','Mount Road','600002','Chennai','Tamil Nadu'),(18,'Building 18','Hill Road','400050','Mumbai','Maharashtra'),(19,'Building 19','Gariahat Road','700029','Kolkata','West Bengal'),(20,'Building 20','Magarpatta City','411028','Pune','Maharashtra'),(21,'Building 21','Koramangala','560034','Bangalore','Karnataka'),(22,'Building 22','Salt Lake City','700091','Kolkata','West Bengal'),(23,'Building 23','Nungambakkam High Road','600034','Chennai','Tamil Nadu'),(24,'Building 24','Andheri Kurla Road','400059','Mumbai','Maharashtra'),(25,'Building 25','Dalhousie Square','700001','Kolkata','West Bengal'),(26,'Building 26','Koregaon Park','411001','Pune','Maharashtra'),(27,'Building 27','Indiranagar','560038','Bangalore','Karnataka'),(28,'Building 28','Park Street','700021','Kolkata','West Bengal'),(29,'Building 29','T Nagar','600017','Chennai','Tamil Nadu'),(30,'Building 30','Malabar Hill','400006','Mumbai','Maharashtra'),(31,'No 15, ','Gandhi Nagar','600008','Chennai','Tamil Nadu');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address`
--

DROP TABLE IF EXISTS `customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_address` (
  `customer_id` int NOT NULL,
  `address_id` int NOT NULL,
  KEY `customer_id` (`customer_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `Customer_Address_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `Customer_Address_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_address`
--

LOCK TABLES `customer_address` WRITE;
/*!40000 ALTER TABLE `customer_address` DISABLE KEYS */;
INSERT INTO `customer_address` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,31);
/*!40000 ALTER TABLE `customer_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `dob` date DEFAULT NULL,
  `age` int DEFAULT NULL,
  `contact_details` json DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Rajesh','Kumar','Sharma','1980-05-10',41,'{\"email\": \"rajesh.sharma@example.com\", \"phone\": \"9876543210\"}','password1'),(2,'Anjali','Raj','Singh','1995-08-21',26,'{\"email\": \"anjali.singh@example.com\", \"phone\": \"8765432109\"}','password2'),(3,'Amit','Kumar','Patel','1988-03-15',33,'{\"email\": \"amit.patel@example.com\", \"phone\": \"7654321098\"}','password3'),(4,'Priya',NULL,'Gupta','1992-11-25',29,'{\"email\": \"priya.gupta@example.com\", \"phone\": \"6543210987\"}','password4'),(5,'Manoj','Kumar','Yadav','1982-07-08',39,'{\"email\": \"manoj.yadav@example.com\", \"phone\": \"5432109876\"}','password5'),(6,'Deepika',NULL,'Mishra','1987-09-18',34,'{\"email\": \"deepika.mishra@example.com\", \"phone\": \"4321098765\"}','password6'),(7,'Rahul',NULL,'Verma','1990-02-22',31,'{\"email\": \"rahul.verma@example.com\", \"phone\": \"3210987654\"}','password7'),(8,'Sneha',NULL,'Rajput','1984-04-12',37,'{\"email\": \"sneha.rajput@example.com\", \"phone\": \"2109876543\"}','password8'),(9,'Ajay','Singh','Chauhan','1998-06-30',23,'{\"email\": \"ajay.chauhan@example.com\", \"phone\": \"1098765432\"}','password9'),(10,'Ananya',NULL,'Sharma','1994-10-05',27,'{\"email\": \"ananya.sharma@example.com\", \"phone\": \"0987654321\"}','password10'),(11,'Vikram','Singh','Rathore','1986-12-04',35,'{\"email\": \"vikram.rathore@example.com\", \"phone\": \"9876543210\"}','password11'),(12,'Neha',NULL,'Yadav','1991-03-28',30,'{\"email\": \"neha.yadav@example.com\", \"phone\": \"8765432109\"}','password12'),(13,'Rakesh','Kumar','Sharma','1989-08-15',32,'{\"email\": \"rakesh.sharma@example.com\", \"phone\": \"7654321098\"}','password13'),(14,'Pooja',NULL,'Gupta','1993-05-20',28,'{\"email\": \"pooja.gupta@example.com\", \"phone\": \"6543210987\"}','password14'),(15,'Vijay',NULL,'Yadav','1983-09-10',38,'{\"email\": \"vijay.yadav@example.com\", \"phone\": \"5432109876\"}','password15'),(16,'Rahul',' ','Ram','2001-06-05',23,'{\"email\": \"rahul.ram@example.com\", \"phone\": \"9645824567\"}','password16');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `order_id` int NOT NULL,
  `agent_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `delivery_review` varchar(50) DEFAULT NULL,
  `delivery_rating` int DEFAULT NULL,
  `delivery_charges` decimal(10,2) NOT NULL,
  `pickup_time` datetime NOT NULL,
  `delivery_time` datetime NOT NULL,
  `delivery_status` varchar(50) NOT NULL,
  `tip` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_id` (`order_id`),
  KEY `agent_id` (`agent_id`),
  CONSTRAINT `Delivery_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `Delivery_ibfk_2` FOREIGN KEY (`agent_id`) REFERENCES `delivery_agent` (`agent_id`),
  CONSTRAINT `CHK_delivery_rating_range` CHECK (((`delivery_rating` >= 0) and (`delivery_rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,1,1,1,'Good service',4,5.00,'2024-02-14 12:00:00','2024-02-14 12:30:00','Delivered',2.50),(2,1,2,2,'Prompt delivery',5,4.50,'2024-02-14 13:15:00','2024-02-14 13:45:00','Delivered',3.00),(3,1,3,3,'Excellent service',3,6.00,'2024-02-14 11:45:00','2024-02-14 12:15:00','Delivered',4.00),(4,1,4,4,'N/A',4,7.00,'2024-02-14 14:30:00','2024-02-14 15:00:00','On the way',3.50),(5,5,5,5,'Friendly delivery person',4,5.50,'2024-02-14 16:00:00','2024-02-14 16:30:00','Delivered',2.00),(6,6,6,6,'Great experience',2,6.50,'2024-02-14 17:15:00','2024-02-14 17:45:00','Delivered',3.00),(7,7,7,7,'Polite and efficient',4,7.50,'2024-02-14 18:30:00','2024-02-14 19:00:00','Delivered',2.50),(8,8,8,8,'Satisfactory service',1,5.50,'2024-02-14 20:00:00','2024-02-14 20:30:00','Delivered',3.50),(9,9,9,9,'Satisfactory service',1,6.00,'2024-02-14 21:00:00','2024-02-14 20:30:00','Delivered',3.50),(10,10,10,10,'Satisfactory service',2,8.00,'2024-02-14 20:30:00','2024-02-14 20:30:00','Delivered',3.50),(11,11,11,11,'Satisfactory service',3,7.50,'2024-02-14 21:30:00','2024-02-14 20:30:00','Delivered',3.50),(12,12,12,12,'Satisfactory service',4,8.50,'2024-02-14 19:30:00','2024-02-14 20:30:00','Delivered',3.50),(13,13,13,13,'Satisfactory service',5,9.50,'2024-02-14 21:20:00','2024-02-14 20:30:00','Delivered',3.50),(14,14,14,14,'Satisfactory service',3,8.00,'2024-02-14 20:10:00','2024-02-14 20:30:00','Delivered',3.50),(15,15,15,15,'Satisfactory service',4,7.00,'2024-02-14 23:10:00','2024-02-14 20:30:00','On the way',3.50),(16,14,1,2,'',5,3.00,'2025-04-26 15:50:48','2025-04-26 16:20:48','On the way',3.00),(17,10,1,3,'',4,9.00,'2025-04-27 17:03:08','2025-04-27 17:33:08','Placed',1.00),(18,1,1,3,'',4,2.00,'2025-04-27 17:07:44','2025-04-27 17:37:44','On the way',3.00),(19,13,1,3,'',1,2.00,'2025-04-27 17:09:18','2025-04-27 17:39:18','Placed',5.00),(20,6,1,3,'',1,4.00,'2025-04-27 17:13:09','2025-04-27 17:43:09','Placed',1.00),(21,2,1,3,'',4,8.00,'2025-04-27 17:17:44','2025-04-27 17:47:44','Placed',5.00),(22,10,1,3,'',2,8.00,'2025-04-27 17:30:33','2025-04-27 18:00:33','Placed',1.00),(23,15,1,3,'',1,8.00,'2025-04-27 17:41:09','2025-04-27 18:11:09','Placed',3.00),(24,1,1,6,'',4,2.00,'2025-04-27 18:02:15','2025-04-27 18:32:15','Placed',2.00),(25,11,1,6,'',2,9.00,'2025-04-27 18:20:43','2025-04-27 18:50:43','Placed',2.00),(26,1,1,3,'',4,3.00,'2025-04-27 18:37:12','2025-04-27 19:07:12','Delivered',4.00),(27,11,1,6,'',1,6.00,'2025-04-27 18:55:38','2025-04-27 19:25:38','Placed',2.00),(28,5,1,6,'',4,9.00,'2025-04-27 19:13:54','2025-04-27 19:43:54','Placed',1.00),(29,4,1,3,'',3,3.00,'2025-04-27 21:23:00','2025-04-27 21:53:00','Placed',2.00),(30,6,2,8,'',1,1.00,'2025-04-28 01:28:48','2025-04-28 01:58:48','Placed',5.00),(31,5,2,8,'',2,4.00,'2025-04-28 01:29:10','2025-04-28 01:59:10','Placed',5.00),(32,1,2,8,'',5,9.00,'2025-04-28 01:29:11','2025-04-28 01:59:11','Placed',2.00),(33,12,2,8,'',5,7.00,'2025-04-28 01:29:16','2025-04-28 01:59:16','Placed',3.00),(34,8,2,6,'',5,8.00,'2025-04-28 01:36:22','2025-04-28 02:06:22','Placed',2.00),(35,1,2,6,'',2,6.00,'2025-04-28 01:57:58','2025-04-28 02:27:58','On the way',5.00),(36,6,2,6,'',3,9.00,'2025-04-28 02:03:25','2025-04-28 02:33:25','Placed',1.00),(37,2,2,3,'',4,2.00,'2025-04-28 02:15:30','2025-04-28 02:45:30','Placed',2.00),(38,1,2,3,'',1,3.00,'2025-04-28 02:26:24','2025-04-28 02:56:24','Placed',2.00),(39,4,2,3,'',5,5.00,'2025-04-28 02:27:10','2025-04-28 02:57:10','Placed',3.00),(40,5,2,3,'',3,9.00,'2025-04-28 02:29:24','2025-04-28 02:59:24','Placed',3.00),(41,10,2,3,'',5,7.00,'2025-04-28 02:37:21','2025-04-28 03:07:21','Placed',2.00),(42,10,2,3,'',5,1.00,'2025-04-28 02:37:31','2025-04-28 03:07:31','Placed',5.00),(43,8,2,3,'',4,1.00,'2025-04-28 02:37:32','2025-04-28 03:07:32','Placed',3.00),(44,9,2,3,'',1,3.00,'2025-04-28 02:37:33','2025-04-28 03:07:33','Placed',4.00),(45,13,2,3,'',1,5.00,'2025-04-28 02:48:54','2025-04-28 03:18:54','Placed',4.00),(46,15,2,3,'',3,5.00,'2025-04-28 02:49:44','2025-04-28 03:19:44','Placed',4.00),(47,12,2,3,'',3,8.00,'2025-04-28 02:52:01','2025-04-28 03:22:01','Placed',5.00),(48,3,2,3,'',4,1.00,'2025-04-28 02:52:34','2025-04-28 03:22:34','Placed',3.00),(49,6,2,3,'',4,9.00,'2025-04-28 02:56:31','2025-04-28 03:26:31','Placed',5.00),(50,16,2,3,'',3,8.00,'2025-04-28 02:58:47','2025-04-28 03:28:47','Placed',5.00),(51,10,2,3,'',3,5.00,'2025-04-28 03:02:37','2025-04-28 03:32:37','Placed',5.00),(52,13,2,3,'',2,5.00,'2025-04-28 03:03:08','2025-04-28 03:33:08','Placed',3.00),(53,15,2,3,'',3,5.00,'2025-04-28 03:03:09','2025-04-28 03:33:09','Placed',4.00),(54,9,2,3,'',3,3.00,'2025-04-28 03:03:10','2025-04-28 03:33:10','Placed',3.00),(55,5,2,3,'',2,8.00,'2025-04-28 03:03:24','2025-04-28 03:33:24','Placed',2.00),(56,8,2,3,'',4,3.00,'2025-04-28 03:03:34','2025-04-28 03:33:34','Placed',5.00),(57,7,2,3,'',2,6.00,'2025-04-28 03:03:35','2025-04-28 03:33:35','Placed',1.00),(58,4,2,3,'',4,5.00,'2025-04-28 09:22:03','2025-04-28 09:52:03','Placed',5.00),(59,14,2,3,'',3,7.00,'2025-04-28 09:23:13','2025-04-28 09:53:13','Placed',1.00),(60,13,2,3,'',4,2.00,'2025-04-28 09:35:29','2025-04-28 10:05:29','Placed',4.00),(61,1,2,3,'',1,8.00,'2025-04-28 09:40:45','2025-04-28 10:10:45','Placed',1.00),(62,14,2,3,'',2,7.00,'2025-04-28 09:41:40','2025-04-28 10:11:40','Placed',5.00),(63,5,2,3,'',4,9.00,'2025-04-28 09:44:35','2025-04-28 10:14:35','Placed',4.00),(64,3,2,3,'',1,1.00,'2025-04-28 09:45:31','2025-04-28 10:15:31','Placed',2.00),(65,9,2,3,'',4,2.00,'2025-04-28 09:45:33','2025-04-28 10:15:33','Placed',2.00),(66,12,2,3,'',5,9.00,'2025-04-28 09:46:06','2025-04-28 10:16:06','Placed',4.00),(67,10,2,3,'',3,2.00,'2025-04-28 09:46:11','2025-04-28 10:16:11','Placed',5.00),(68,6,2,3,'',1,2.00,'2025-04-28 09:50:00','2025-04-28 10:20:00','Placed',2.00),(69,13,2,3,'',3,4.00,'2025-04-28 09:50:17','2025-04-28 10:20:17','Placed',3.00),(70,7,2,3,'',5,4.00,'2025-04-28 09:51:05','2025-04-28 10:21:05','Placed',3.00),(71,1,2,3,'',4,4.00,'2025-04-28 09:51:06','2025-04-28 10:21:06','Placed',4.00),(72,14,2,3,'',3,7.00,'2025-04-28 09:51:07','2025-04-28 10:21:07','Placed',2.00),(73,3,2,3,'',1,1.00,'2025-04-28 09:52:11','2025-04-28 10:22:11','Placed',1.00),(74,14,2,3,'',5,3.00,'2025-04-28 09:52:17','2025-04-28 10:22:17','Placed',1.00),(75,13,2,3,'',2,5.00,'2025-04-28 09:52:41','2025-04-28 10:22:41','Placed',3.00),(76,4,2,3,'',2,2.00,'2025-04-28 09:54:04','2025-04-28 10:24:04','Placed',1.00),(77,9,2,3,'',5,7.00,'2025-04-28 09:54:05','2025-04-28 10:24:05','Placed',4.00),(78,7,2,3,'',1,1.00,'2025-04-28 09:54:05','2025-04-28 10:24:05','Placed',1.00),(79,6,2,3,'',2,9.00,'2025-04-28 09:54:32','2025-04-28 10:24:32','Placed',2.00),(80,5,2,3,'',4,9.00,'2025-04-28 09:54:33','2025-04-28 10:24:33','Placed',2.00),(81,13,2,3,'',4,3.00,'2025-04-28 09:54:33','2025-04-28 10:24:33','Placed',4.00),(82,9,2,3,'',4,8.00,'2025-04-28 09:54:34','2025-04-28 10:24:34','Placed',4.00),(83,15,2,3,'',4,3.00,'2025-04-28 09:54:40','2025-04-28 10:24:40','Placed',4.00),(84,1,2,3,'',2,6.00,'2025-04-28 09:54:50','2025-04-28 10:24:50','Placed',1.00),(85,15,2,3,'',2,8.00,'2025-04-28 09:54:57','2025-04-28 10:24:57','Placed',2.00),(86,7,2,3,'',1,4.00,'2025-04-28 09:55:25','2025-04-28 10:25:25','Placed',2.00),(87,11,2,3,'',2,5.00,'2025-04-28 09:55:42','2025-04-28 10:25:42','Placed',2.00),(88,11,2,3,'',1,8.00,'2025-04-28 09:58:17','2025-04-28 10:28:17','Placed',2.00),(89,1,2,3,'',3,1.00,'2025-04-28 09:59:00','2025-04-28 10:29:00','Placed',2.00),(90,16,2,3,'',2,7.00,'2025-04-28 09:59:30','2025-04-28 10:29:30','Placed',1.00),(91,13,2,3,'',3,6.00,'2025-04-28 10:01:14','2025-04-28 10:31:14','Placed',1.00),(92,3,2,3,'',2,6.00,'2025-04-28 10:02:47','2025-04-28 10:32:47','Placed',4.00),(93,5,2,3,'',3,7.00,'2025-04-28 10:03:28','2025-04-28 10:33:28','Placed',1.00),(94,10,2,3,'',2,8.00,'2025-04-28 10:04:32','2025-04-28 10:34:32','Placed',3.00),(95,9,2,3,'',1,7.00,'2025-04-28 10:04:55','2025-04-28 10:34:55','Placed',1.00),(96,13,2,3,'',2,4.00,'2025-04-28 10:06:18','2025-04-28 10:36:18','Placed',4.00),(97,7,2,3,'',2,9.00,'2025-04-28 10:06:20','2025-04-28 10:36:20','Placed',4.00),(98,6,2,3,'',5,1.00,'2025-04-28 10:06:49','2025-04-28 10:36:49','Placed',3.00),(99,1,2,3,'',5,6.00,'2025-04-28 10:07:32','2025-04-28 10:37:32','Placed',1.00),(100,5,2,3,'',3,2.00,'2025-04-28 10:08:29','2025-04-28 10:38:29','Placed',5.00),(101,12,2,3,'',1,5.00,'2025-04-28 10:09:20','2025-04-28 10:39:20','Placed',5.00),(102,16,2,3,'',1,7.00,'2025-04-28 10:09:45','2025-04-28 10:39:45','Placed',5.00),(103,1,2,3,'',4,2.00,'2025-04-28 10:10:01','2025-04-28 10:40:01','Placed',2.00),(104,2,2,3,'',4,8.00,'2025-04-28 10:10:48','2025-04-28 10:40:48','Placed',3.00),(105,13,2,3,'',1,9.00,'2025-04-28 10:11:02','2025-04-28 10:41:02','Placed',4.00),(106,6,2,3,'',2,3.00,'2025-04-28 10:11:13','2025-04-28 10:41:13','Placed',5.00),(107,3,2,3,'',2,3.00,'2025-04-28 10:11:44','2025-04-28 10:41:44','Placed',4.00),(108,7,2,3,'',3,7.00,'2025-04-28 10:12:45','2025-04-28 10:42:45','Placed',3.00),(109,7,2,3,'',2,4.00,'2025-04-28 10:12:57','2025-04-28 10:42:57','Placed',1.00),(110,12,2,3,'',2,6.00,'2025-04-28 10:13:09','2025-04-28 10:43:09','Placed',2.00),(111,2,2,3,'',3,5.00,'2025-04-28 10:13:11','2025-04-28 10:43:11','Placed',1.00),(112,15,2,3,'',1,2.00,'2025-04-28 10:13:57','2025-04-28 10:43:57','Placed',1.00),(113,5,2,3,'',2,3.00,'2025-04-28 10:14:29','2025-04-28 10:44:29','Placed',4.00),(114,10,2,3,'',4,6.00,'2025-04-28 10:14:46','2025-04-28 10:44:46','Placed',1.00),(115,5,2,3,'',2,1.00,'2025-04-28 10:15:00','2025-04-28 10:45:00','Placed',5.00),(116,6,2,3,'',1,5.00,'2025-04-28 10:15:12','2025-04-28 10:45:12','Placed',4.00),(117,15,2,3,'',3,4.00,'2025-04-28 10:15:17','2025-04-28 10:45:17','Placed',4.00),(118,15,2,3,'',2,8.00,'2025-04-28 10:15:53','2025-04-28 10:45:53','Placed',1.00),(119,6,2,3,'',1,5.00,'2025-04-28 10:16:11','2025-04-28 10:46:11','Placed',5.00),(120,12,2,3,'',4,8.00,'2025-04-28 10:16:22','2025-04-28 10:46:22','Placed',1.00),(121,4,2,3,'',5,6.00,'2025-04-28 10:17:35','2025-04-28 10:47:35','Placed',5.00),(122,12,2,3,'',2,6.00,'2025-04-28 10:19:16','2025-04-28 10:49:16','Placed',2.00),(123,2,2,3,'',3,3.00,'2025-04-28 10:20:34','2025-04-28 10:50:34','Placed',1.00),(124,9,2,3,'',1,8.00,'2025-04-28 10:20:55','2025-04-28 10:50:55','Placed',4.00),(125,6,2,3,'',2,2.00,'2025-04-28 10:20:56','2025-04-28 10:50:56','Placed',1.00),(126,12,2,3,'',3,1.00,'2025-04-28 10:21:46','2025-04-28 10:51:46','Placed',2.00),(127,5,2,3,'',2,7.00,'2025-04-28 10:22:30','2025-04-28 10:52:30','Placed',4.00),(128,5,2,3,'',2,3.00,'2025-04-28 10:23:30','2025-04-28 10:53:30','Placed',1.00),(129,7,2,3,'',4,6.00,'2025-04-28 10:23:44','2025-04-28 10:53:44','Placed',3.00),(130,2,2,3,'',2,3.00,'2025-04-28 10:24:28','2025-04-28 10:54:28','Placed',1.00),(131,15,2,3,'',5,9.00,'2025-04-28 10:24:50','2025-04-28 10:54:50','Placed',5.00),(132,11,2,3,'',1,2.00,'2025-04-28 10:26:40','2025-04-28 10:56:40','Placed',4.00),(133,11,1,1,'',2,6.00,'2025-04-29 01:45:56','2025-04-29 02:15:56','Placed',2.00);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_agent`
--

DROP TABLE IF EXISTS `delivery_agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_agent` (
  `agent_id` int NOT NULL,
  `vehicle_number` varchar(20) NOT NULL,
  `agent_name` varchar(50) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `location` varchar(100) NOT NULL,
  `license_id` varchar(20) NOT NULL,
  `availability` tinyint(1) NOT NULL,
  `password` varchar(50) NOT NULL,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`agent_id`),
  UNIQUE KEY `vehicle_number` (`vehicle_number`),
  UNIQUE KEY `phone_num` (`phone_num`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `license_id` (`license_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_agent`
--

LOCK TABLES `delivery_agent` WRITE;
/*!40000 ALTER TABLE `delivery_agent` DISABLE KEYS */;
INSERT INTO `delivery_agent` VALUES (1,'KA01AB1234','Rahul Kumar','+91 9876543210','rahul.kumar@example.com','Bangalore','DL123456',1,'password1','2000-07-10'),(2,'WB02CD5678','Priya Sharma','+91 8765432109','priya.sharma@example.com','Kolkata','DL238567',1,'password2',NULL),(3,'MH03EF9012','Amit Patel','+91 7654321098','amit.patel@example.com','Mumbai','DL945678',1,'password3',NULL),(4,'TN04GH3456','Sneha Rajput','+91 6543210987','sneha.rajput@example.com','Chennai','DL456789',0,'password4',NULL),(5,'DL05IJ7890','Rakesh Sharma','+91 5432109876','rakesh.sharma@example.com','Delhi','DL564890',1,'password5',NULL),(6,'KA06KL1234','Anjali Singh','+91 4321098765','anjali.singh@example.com','Bangalore','DL678901',1,'password6',NULL),(7,'WB07MN5678','Manoj Yadav','+91 3210987654','manoj.yadav@example.com','Kolkata','DL789012',0,'password7',NULL),(8,'MH08OP9012','Deepika Mishra','+91 2109876543','deepika.mishra@example.com','Mumbai','DL890123',1,'password8',NULL),(9,'TN09QR3456','Vikram Rathore','+91 1098765432','vikram.rathore@example.com','Chennai','DL901234',1,'password9',NULL),(10,'DL10ST7890','Pooja Gupta','+91 0987654321','pooja.gupta@example.com','Delhi','DL012345',1,'password10',NULL),(11,'KA11UV1234','Ajay Chauhan','+91 8876543250','ajay.chauhan@example.com','Bangalore','DL123457',1,'password11',NULL),(12,'WB12WX5678','Ananya Sharma','+91 7765432109','ananya.sharma@example.com','Kolkata','DL234567',0,'password12',NULL),(13,'MH13YZ9012','Neha Yadav','+91 8654361098','neha.yadav@example.com','Mumbai','DL345678',1,'password13',NULL),(14,'TN14AB3456','Rajesh Verma','+91 5543210987','rajesh.verma@example.com','Chennai','DL556789',1,'password14',NULL),(15,'DL15CD7890','Suresh Kumar','+91 4432109876','suresh.kumar@example.com','Delhi','DL567890',1,'password15',NULL),(16,'TN18BE4785','Ganesh  Patel','+91 7845213256','ganesh.patel@example.com','Chennai','TN789012',1,'password16',NULL),(17,'TN18BA3894','bharth   Patel','8576425120','bharathpatel@gmail.com','Hyderabad','TN789238',1,'password17','2002-02-27');
/*!40000 ALTER TABLE `delivery_agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `fat` int NOT NULL,
  `protein` int NOT NULL,
  `carbs` int NOT NULL,
  `calories` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'Butter Chicken',22,34,9,360),(2,'Chicken Tikka Masala',23,20,12,330),(3,'Chicken Korma',20,25,10,332),(4,'Chicken Biryani',12,20,50,435),(5,'Lamb Rogan Josh',25,30,8,415),(6,'Tandoori Chicken',7,25,2,165),(7,'Mutton Curry',22,28,10,391),(8,'Fish Curry',10,22,5,200),(9,'Paneer Butter Masala',25,15,15,350),(10,'Palak Paneer',10,10,8,150),(11,'Chole Bhature',18,11,60,450),(12,'Rajma Chawal',6,12,55,325),(13,'Pani Puri',10,3,15,180),(14,'Bhel Puri',12,5,40,285),(15,'Medu Vada',4,3,15,100),(16,'Dosa',2,3,26,133),(17,'Idli',0,4,27,130),(18,'Masala Dosa',6,7,77,387),(19,'Sambar',2,3,20,110),(20,'Rasam',1,2,15,75),(21,'Avial',12,3,10,150),(22,'Bisi Bele Bath',2,6,40,200),(23,'Vada',4,4,20,125),(24,'Rava Dosa',6,4,24,160),(25,'Poha',3,6,52,270),(26,'Upma',6,4,38,220),(27,'Lemon Rice',4,4,40,200),(28,'Pongal',6,8,50,300),(29,'Bisibele Bath',7,9,60,350),(30,'Appam',7,2,22,160),(31,'Puttu',1,4,33,150),(32,'Vangi Bath',6,6,50,280),(33,'Puliyodarai',7,6,70,350),(34,'Tamarind Rice',8,7,80,400),(35,'Curd Rice',5,3,30,180),(36,'Ragi Mudde',2,5,26,137),(37,'Chicken Fried Rice',15,20,40,400),(38,'Aloo Tikki',5,2,15,70),(39,'Mutton Biryani',20,25,60,500),(40,'Chicken Shawarma',15,25,30,350),(41,'Ghee Rice',15,5,50,400),(42,'Veg Pulao',10,5,45,250),(43,'Chicken Lollipop',15,20,5,250),(44,'Mutton Curry',20,20,15,400),(45,'Veg Manchurian',15,5,25,250),(46,'Chicken Kebab',10,15,5,150),(47,'Bhindi Masala',10,5,15,150),(48,'Veg Fried Rice',10,5,35,250),(49,'Prawn Masala',15,20,10,250),(50,'Gajar Halwa',10,5,45,250),(51,'Biryani',25,40,112,833),(52,'Omelette',14,15,2,194),(53,'Omelette',14,15,2,194),(54,'Omelette',14,15,2,194),(55,'Omelette',14,15,2,194),(56,'Omelette',14,15,2,194),(57,'Omelette',14,15,2,194);
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_date`
--

DROP TABLE IF EXISTS `food_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_date` (
  `food_id` int NOT NULL,
  `log_date_id` int NOT NULL,
  PRIMARY KEY (`food_id`,`log_date_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_date`
--

LOCK TABLES `food_date` WRITE;
/*!40000 ALTER TABLE `food_date` DISABLE KEYS */;
INSERT INTO `food_date` VALUES (7,22),(9,20),(18,19),(21,20),(39,19);
/*!40000 ALTER TABLE `food_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_item`
--

DROP TABLE IF EXISTS `food_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_item` (
  `item_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `item_price` decimal(10,2) NOT NULL,
  `item_rating` decimal(3,2) DEFAULT NULL,
  `vegetarian` tinyint(1) NOT NULL,
  `photo_url` varchar(2000) DEFAULT NULL,
  `image` blob,
  `availability` tinyint(1) NOT NULL,
  `order_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `Food_Item_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_item`
--

LOCK TABLES `food_item` WRITE;
/*!40000 ALTER TABLE `food_item` DISABLE KEYS */;
INSERT INTO `food_item` VALUES (1,1,'Paneer Tikka','Starter',250.00,4.50,0,'https://t4.ftcdn.net/jpg/04/75/65/21/360_F_475652107_Sx73qgHWljGylX5KRyDFeE46ftX0A4EE.jpg',NULL,1,50),(2,2,'Chicken Biryani','Main Course',300.00,4.20,0,'https://www.cubesnjuliennes.com/wp-content/uploads/2020/07/Chicken-Biryani-Recipe.jpg',NULL,1,70),(3,3,'Butter Chicken','Main Course',350.00,4.28,0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN2jh7DvoLtDyDF6cigDHFrSMs5zMpaXRelA&s',NULL,1,66),(4,4,'Masala Dosa','Breakfast',100.00,4.60,1,'https://example.com/masala_dosa.jpg',NULL,1,80),(5,5,'Mutton Rogan Josh','Main Course',400.00,4.40,0,'https://example.com/mutton_rogan_josh.jpg',NULL,1,45),(6,6,'Fish Curry','Main Course',320.00,4.13,0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSR5bv5CUtCfSyCjiwS29HyMoq0FfaCTGxX1A&s',NULL,1,59),(7,7,'Thali','Combo Meal',200.00,4.70,1,'https://example.com/thali.jpg',NULL,1,65),(8,8,'Chole Bhature','Breakfast',120.00,4.20,1,'https://example.com/chole_bhature.jpg',NULL,1,40),(9,9,'Rosogolla','Dessert',50.00,4.80,1,'https://example.com/rosogolla.jpg',NULL,1,90),(10,10,'Hyderabadi Chicken Dum Biryani','Main Course',380.00,4.50,0,'https://example.com/hyderabadi_chicken_dum_biryani.jpg',NULL,1,75),(11,11,'Appam with Stew','Breakfast',150.00,4.30,1,'https://example.com/appam_with_stew.jpg',NULL,1,30),(12,12,'Misal Pav','Snack',80.00,4.70,1,'https://example.com/misal_pav.jpg',NULL,1,85),(13,13,'Prawn Balchao','Main Course',350.00,4.40,0,'https://example.com/prawn_balchao.jpg',NULL,1,65),(14,14,'Dhansak','Main Course',300.00,4.60,0,'https://example.com/dhansak.jpg',NULL,1,55),(15,15,'Assamese Thali','Combo Meal',220.00,4.50,1,'https://example.com/assamese_thali.jpg',NULL,1,70),(16,1,'Chicken Tikka','Starter',270.00,4.40,0,'https://t4.ftcdn.net/jpg/02/42/39/29/360_F_242392945_5Xc5VjsBFUMFR3ZZdQV1FL6LgB0XIvhD.jpg',NULL,1,40),(17,1,'Vegetable Biryani','Main Course',220.00,4.20,1,'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/09/veg-biryani-vegetable-biryani.webp',NULL,1,61),(18,1,'Dal Makhani','Main Course',200.00,4.50,1,'https://www.funfoodfrolic.com/wp-content/uploads/2023/04/Dal-Makhani-Blog.jpg',NULL,1,55),(19,1,'Gulab Jamun','Dessert',80.00,4.60,1,'https://media.istockphoto.com/id/163064596/photo/gulab-jamun.jpg?s=612x612&w=0&k=20&c=JvJ4AAs-N5pRzzRmVg1lG0talC3QoUt0ZGiO1NKz-kQ=',NULL,1,70),(20,1,'Aloo Paratha','Breakfast',120.00,4.30,1,'https://thumbs.dreamstime.com/b/aloo-paratha-indian-potato-stuffed-flatbread-butter-top-served-fresh-sweet-lassi-chutney-pickle-selective-focus-lassie-164213775.jpg',NULL,1,45),(21,2,'Veg Pulao','Main Course',180.00,4.10,1,'https://example.com/veg_pulao.jpg',NULL,1,50),(22,2,'Egg Curry','Main Course',250.00,4.30,0,'https://example.com/egg_curry.jpg',NULL,1,65),(23,2,'Fish Fry','Starter',280.00,4.20,0,'https://example.com/fish_fry.jpg',NULL,1,55),(24,2,'Prawn Pulao','Main Course',320.00,4.40,0,'https://example.com/prawn_pulao.jpg',NULL,1,75),(25,2,'Raita','Side Dish',60.00,4.50,1,'https://example.com/raita.jpg',NULL,1,36),(26,3,'Palak Paneer','Main Course',230.00,4.41,1,'https://example.com/palak_paneer.jpg',NULL,1,71),(27,3,'Veg Manchurian','Starter',200.00,4.20,1,'https://example.com/veg_manchurian.jpg',NULL,1,130),(28,3,'Pav Bhaji','Snack',150.00,4.50,1,'https://example.com/pav_bhaji.jpg',NULL,1,70),(29,3,'Rasgulla','Dessert',70.00,4.30,1,'https://example.com/rasgulla.jpg',NULL,1,42),(30,3,'Vegetable Soup','Starter',100.00,4.60,1,'https://example.com/vegetable_soup.jpg',NULL,1,56),(31,4,'Idli','Breakfast',60.00,4.20,1,'https://example.com/idli.jpg',NULL,1,30),(32,4,'Vada','Breakfast',50.00,4.00,1,'https://example.com/vada.jpg',NULL,1,25),(33,4,'Plain Dosa','Breakfast',70.00,4.40,1,'https://example.com/plain_dosa.jpg',NULL,1,35),(34,4,'Medu Vada','Breakfast',60.00,4.30,1,'https://example.com/medu_vada.jpg',NULL,1,40),(35,4,'Filter Coffee','Beverage',40.00,4.50,1,'https://example.com/filter_coffee.jpg',NULL,1,20),(36,5,'Chicken Curry','Main Course',280.00,4.10,0,'https://example.com/chicken_curry.jpg',NULL,1,50),(37,5,'Chapati','Main Course',20.00,4.00,1,'https://example.com/chapati.jpg',NULL,1,60),(38,5,'Fish Fry','Starter',250.00,4.30,0,'https://example.com/fish_fry_2.jpg',NULL,1,70),(39,5,'Prawn Curry','Main Course',300.00,4.20,0,'https://example.com/prawn_curry.jpg',NULL,1,45),(40,5,'Kheer','Dessert',100.00,4.50,1,'https://example.com/kheer.jpg',NULL,1,55),(41,6,'Paneer Butter Masala','Main Course',220.00,4.40,1,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrLBVEe6r1T0g-ZwoAeKUzAzQn5ot126jyKg&s',NULL,1,61),(42,6,'Jeera Rice','Main Course',120.00,4.20,1,'https://example.com/jeera_rice.jpg',NULL,1,71),(43,6,'Chicken 65','Starter',250.00,4.50,0,'https://example.com/chicken_65.jpg',NULL,1,45),(44,6,'Gajar Halwa','Dessert',150.00,4.30,1,'https://example.com/gajar_halwa.jpg',NULL,1,55),(45,6,'Masala Papad','Starter',80.00,4.10,1,'https://example.com/masala_papad.jpg',NULL,1,36),(46,7,'Rajma Chawal','Main Course',180.00,4.20,1,'https://example.com/rajma_chawal.jpg',NULL,1,50),(47,7,'Chole Kulche','Breakfast',100.00,4.10,1,'https://example.com/chole_kulche.jpg',NULL,1,60),(48,7,'Aloo Tikki','Snack',70.00,4.30,1,'https://www.indianveggiedelight.com/wp-content/uploads/2023/07/aloo-tikki-featured.jpg',NULL,1,70),(49,7,'Gulab Jamun','Dessert',80.00,4.50,1,'https://media.istockphoto.com/id/163064596/photo/gulab-jamun.jpg?s=612x612&w=0&k=20&c=JvJ4AAs-N5pRzzRmVg1lG0talC3QoUt0ZGiO1NKz-kQ=',NULL,1,45),(50,7,'Lassi','Beverage',50.00,4.40,1,'https://example.com/lassi.jpg',NULL,1,55),(51,8,'Rasam','Soup',90.00,4.10,1,'https://example.com/rasam.jpg',NULL,1,64),(52,8,'Paneer Paratha','Breakfast',100.00,4.20,1,'https://example.com/paneer_paratha.jpg',NULL,1,70),(53,8,'Papad','Side Dish',30.00,4.00,1,'https://example.com/papad.jpg',NULL,1,50),(54,8,'Thums Up','Beverage',40.00,4.30,1,'https://example.com/thums_up.jpg',NULL,1,45),(55,8,'Gajar Matar','Main Course',150.00,4.40,1,'https://example.com/gajar_matar.jpg',NULL,1,55),(56,9,'Puliyodharai','Main Course',200.00,4.30,1,'https://example.com/puliyodharai.jpg',NULL,1,40),(57,9,'Sambar','Soup',100.00,4.40,1,'https://example.com/sambar.jpg',NULL,1,45),(58,9,'Paniyaram','Snack',120.00,4.50,1,'https://example.com/paniyaram.jpg',NULL,1,50),(59,9,'Masala Chai','Beverage',60.00,4.20,1,'https://example.com/masala_chai.jpg',NULL,1,60),(60,9,'Kaju Katli','Dessert',180.00,4.60,1,'https://example.com/kaju_katli.jpg',NULL,1,55),(61,10,'Maggi','Snack',50.00,4.00,1,'https://example.com/maggi.jpg',NULL,1,50),(62,10,'Veg Roll','Snack',60.00,4.20,1,'https://example.com/veg_roll.jpg',NULL,1,40),(63,10,'Egg Fried Rice','Main Course',120.00,4.30,0,'https://example.com/egg_fried_rice.jpg',NULL,1,60),(64,10,'Chicken Noodles','Main Course',140.00,4.10,0,'https://example.com/chicken_noodles.jpg',NULL,1,45),(65,10,'Cold Coffee','Beverage',80.00,4.50,1,'https://example.com/cold_coffee.jpg',NULL,1,55),(66,11,'Chicken Lollipop','Starter',200.00,4.40,0,'https://example.com/chicken_lollipop.jpg',NULL,1,40),(67,11,'Egg Bhurji','Breakfast',100.00,4.20,0,'https://example.com/egg_bhurji.jpg',NULL,1,60),(68,11,'Pav Vada','Snack',120.00,4.50,1,'https://example.com/pav_vada.jpg',NULL,1,70),(69,11,'Rumali Roti','Bread',50.00,4.30,1,'https://example.com/rumali_roti.jpg',NULL,1,45),(70,11,'Tandoori Chicken','Starter',250.00,4.60,0,'https://example.com/tandoori_chicken.jpg',NULL,1,55),(71,12,'Dhokla','Snack',60.00,4.20,1,'https://example.com/dhokla.jpg',NULL,1,30),(72,12,'Samosa','Snack',40.00,4.10,1,'https://example.com/samosa.jpg',NULL,1,25),(73,12,'Pakora','Snack',50.00,4.30,1,'https://example.com/pakora.jpg',NULL,1,35),(74,12,'Aloo Tikki Chaat','Snack',70.00,4.40,1,'https://sinfullyspicy.com/wp-content/uploads/2023/03/1-1.jpg',NULL,1,40),(75,12,'Kachori','Snack',60.00,4.00,1,'https://example.com/kachori.jpg',NULL,1,20),(76,13,'Momo','Snack',80.00,4.30,1,'https://example.com/momo.jpg',NULL,1,50),(77,13,'Thukpa','Main Course',120.00,4.20,1,'https://example.com/thukpa.jpg',NULL,1,60),(78,13,'Pork Curry','Main Course',200.00,4.40,0,'https://example.com/pork_curry.jpg',NULL,1,70),(79,13,'Sel Roti','Snack',50.00,4.50,1,'https://example.com/sel_roti.jpg',NULL,1,45),(80,13,'Gundruk','Side Dish',80.00,4.10,1,'https://example.com/gundruk.jpg',NULL,1,35),(81,14,'Momo','Snack',100.00,4.30,1,'https://example.com/momo_2.jpg',NULL,1,40),(82,14,'Thukpa','Main Course',150.00,4.20,1,'https://example.com/thukpa_2.jpg',NULL,1,45),(83,14,'Pork Curry','Main Course',250.00,4.40,0,'https://example.com/pork_curry_2.jpg',NULL,1,55),(84,14,'Sel Roti','Snack',60.00,4.50,1,'https://example.com/sel_roti_2.jpg',NULL,1,50),(85,14,'Gundruk','Side Dish',90.00,4.10,1,'https://example.com/gundruk_2.jpg',NULL,1,60),(86,15,'Pakhala Bhata','Main Course',100.00,4.20,1,'https://example.com/pakhala_bhata.jpg',NULL,1,50),(87,15,'Dahi Baingan','Main Course',120.00,4.00,1,'https://example.com/dahi_baingan.jpg',NULL,1,55),(88,15,'Chenna Poda','Dessert',80.00,4.40,1,'https://example.com/chenna_poda.jpg',NULL,1,60),(89,15,'Pani Pitha','Snack',70.00,4.30,1,'https://example.com/pani_pitha.jpg',NULL,1,65),(90,15,'Khaja','Dessert',90.00,4.50,1,'https://example.com/khaja.jpg',NULL,1,70),(91,11,'Kerala parota & beef fry','Main Course',270.00,0.00,0,'https://as2.ftcdn.net/jpg/04/87/51/17/1000_F_487511720_bP3XSrMn9imliCY1f0CjimSxsRWgpewt.jpg',NULL,1,0);
/*!40000 ALTER TABLE `food_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_date`
--

DROP TABLE IF EXISTS `log_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_date` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entry_date` date NOT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entry` (`entry_date`,`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_date`
--

LOCK TABLES `log_date` WRITE;
/*!40000 ALTER TABLE `log_date` DISABLE KEYS */;
INSERT INTO `log_date` VALUES (22,'2025-04-29',1),(21,'2025-05-01',1),(19,'2025-05-01',2),(23,'2025-05-02',1),(20,'2025-05-05',2);
/*!40000 ALTER TABLE `log_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_items`
--

DROP TABLE IF EXISTS `ordered_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordered_items` (
  `order_id` int NOT NULL,
  `item_id` int NOT NULL,
  `item_quantity` int NOT NULL,
  `item_rating` decimal(3,2) DEFAULT NULL,
  `item_review` varchar(50) DEFAULT NULL,
  `notes` varchar(100) DEFAULT NULL,
  `photo_url` varchar(2000) DEFAULT NULL,
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `Ordered_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `Ordered_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `food_item` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `CHK_item_rating_range` CHECK (((`item_rating` >= 0) and (`item_rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_items`
--

LOCK TABLES `ordered_items` WRITE;
/*!40000 ALTER TABLE `ordered_items` DISABLE KEYS */;
INSERT INTO `ordered_items` VALUES (1,1,2,4.50,'Excellent dish','Extra spicy please',NULL),(1,3,1,4.20,'Good',NULL,NULL),(2,5,3,4.80,'Absolutely delicious!','No onions please',NULL),(2,8,2,NULL,NULL,NULL,NULL),(3,10,1,4.50,'Loved it!',NULL,NULL),(3,12,2,4.60,'Great taste','Extra sauce on the side',NULL),(4,4,2,NULL,NULL,'Extra crispy dosa',NULL),(4,7,1,4.70,'Wonderful Thali',NULL,NULL),(5,9,1,4.90,'Best dessert ever!',NULL,NULL),(5,11,3,4.30,'Nice combination',NULL,NULL),(6,2,1,4.40,'Tasty biryani',NULL,NULL),(6,6,1,4.10,'Good curry',NULL,NULL),(7,13,2,4.50,'Spicy and flavorful',NULL,NULL),(7,15,1,4.60,'Delicious',NULL,NULL),(8,14,1,4.70,'Authentic taste',NULL,NULL),(16,25,1,4.00,NULL,'',NULL),(17,29,1,4.00,NULL,'',NULL),(18,26,1,4.00,NULL,'',NULL),(19,30,1,4.00,NULL,'',NULL),(20,3,1,4.00,NULL,'',NULL),(21,3,1,4.00,NULL,'',NULL),(22,3,1,4.00,NULL,'',NULL),(23,3,1,4.00,NULL,'',NULL),(24,6,1,4.00,NULL,'',NULL),(25,45,1,4.00,NULL,'',NULL),(26,29,1,4.00,NULL,'',NULL),(27,41,1,4.00,NULL,'',NULL),(28,42,1,4.00,NULL,'',NULL),(29,3,1,4.00,NULL,'super',NULL),(30,51,1,4.00,NULL,'',NULL),(31,51,1,4.00,NULL,'',NULL),(32,51,1,4.00,NULL,'',NULL),(33,51,1,4.00,NULL,'',NULL),(34,6,1,4.00,NULL,'',NULL),(35,6,1,4.00,NULL,'Delicous',NULL),(36,6,1,4.00,NULL,'good',NULL),(37,3,1,4.00,NULL,'',NULL),(38,26,1,4.00,NULL,'',NULL),(39,26,1,4.00,NULL,'',NULL),(40,26,1,4.00,NULL,'',NULL),(41,26,1,4.00,NULL,'',NULL),(42,26,1,4.00,NULL,'',NULL),(43,26,1,4.00,NULL,'',NULL),(44,26,1,4.00,NULL,'',NULL),(45,26,1,4.00,NULL,'',NULL),(46,26,1,4.00,NULL,'',NULL),(47,26,1,4.00,NULL,'',NULL),(48,27,1,4.00,NULL,'',NULL),(49,27,1,4.00,NULL,'',NULL),(50,27,1,4.00,NULL,'',NULL),(51,27,1,4.00,NULL,'',NULL),(52,27,1,4.00,NULL,'',NULL),(53,27,1,4.00,NULL,'',NULL),(54,27,1,4.00,NULL,'',NULL),(55,27,1,4.00,NULL,'',NULL),(56,27,1,4.00,NULL,'',NULL),(57,27,1,4.00,NULL,'',NULL),(58,27,1,4.00,NULL,'',NULL),(59,27,1,4.00,NULL,'',NULL),(60,27,1,4.00,NULL,'',NULL),(61,27,1,4.00,NULL,'',NULL),(62,27,1,4.00,NULL,'',NULL),(63,27,1,4.00,NULL,'',NULL),(64,27,1,4.00,NULL,'',NULL),(65,27,1,4.00,NULL,'',NULL),(66,27,1,4.00,NULL,'',NULL),(67,27,1,4.00,NULL,'',NULL),(68,27,1,4.00,NULL,'',NULL),(69,27,1,4.00,NULL,'',NULL),(70,27,1,4.00,NULL,'',NULL),(71,27,1,4.00,NULL,'',NULL),(72,27,1,4.00,NULL,'',NULL),(73,27,1,4.00,NULL,'',NULL),(74,27,1,4.00,NULL,'',NULL),(75,27,1,4.00,NULL,'',NULL),(76,27,1,4.00,NULL,'',NULL),(77,27,1,4.00,NULL,'',NULL),(78,27,1,4.00,NULL,'',NULL),(79,27,1,4.00,NULL,'',NULL),(80,27,1,4.00,NULL,'',NULL),(81,27,1,4.00,NULL,'',NULL),(82,27,1,4.00,NULL,'',NULL),(83,27,1,4.00,NULL,'',NULL),(84,27,1,4.00,NULL,'',NULL),(85,27,1,4.00,NULL,'',NULL),(86,27,1,4.00,NULL,'',NULL),(87,27,1,4.00,NULL,'',NULL),(88,27,1,4.00,NULL,'',NULL),(89,27,1,4.00,NULL,'',NULL),(90,27,1,4.00,NULL,'',NULL),(91,27,1,4.00,NULL,'',NULL),(92,27,1,4.00,NULL,'',NULL),(93,27,1,4.00,NULL,'',NULL),(94,27,1,4.00,NULL,'',NULL),(95,27,1,4.00,NULL,'',NULL),(96,27,1,4.00,NULL,'',NULL),(97,27,1,4.00,NULL,'',NULL),(98,27,1,4.00,NULL,'',NULL),(99,27,1,4.00,NULL,'',NULL),(100,27,1,4.00,NULL,'',NULL),(101,27,1,4.00,NULL,'',NULL),(102,27,1,4.00,NULL,'',NULL),(103,27,1,4.00,NULL,'',NULL),(104,27,1,4.00,NULL,'',NULL),(105,27,1,4.00,NULL,'',NULL),(106,27,1,4.00,NULL,'',NULL),(107,27,1,4.00,NULL,'',NULL),(108,27,1,4.00,NULL,'',NULL),(109,27,1,4.00,NULL,'',NULL),(110,27,1,4.00,NULL,'',NULL),(111,27,1,4.00,NULL,'',NULL),(112,27,1,4.00,NULL,'',NULL),(113,27,1,4.00,NULL,'',NULL),(114,27,1,4.00,NULL,'',NULL),(115,27,1,4.00,NULL,'',NULL),(116,27,1,4.00,NULL,'',NULL),(117,27,1,4.00,NULL,'',NULL),(118,27,1,4.00,NULL,'',NULL),(119,27,1,4.00,NULL,'',NULL),(120,27,1,4.00,NULL,'',NULL),(121,27,1,4.00,NULL,'',NULL),(122,27,1,4.00,NULL,'',NULL),(123,27,1,4.00,NULL,'',NULL),(124,27,1,4.00,NULL,'',NULL),(125,27,1,4.00,NULL,'',NULL),(126,27,1,4.00,NULL,'',NULL),(127,27,1,4.00,NULL,'',NULL),(128,27,1,4.00,NULL,'',NULL),(129,27,1,4.00,NULL,'',NULL),(130,27,1,4.00,NULL,'',NULL),(131,27,1,4.00,NULL,'',NULL),(132,27,1,4.00,NULL,'',NULL),(133,17,1,4.00,NULL,'Add More Vegetable',NULL);
/*!40000 ALTER TABLE `ordered_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `Payment_id` int NOT NULL,
  `order_status` enum('Delivered','Processing','Pending') NOT NULL,
  `placed_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `Payment_id` (`Payment_id`),
  CONSTRAINT `Orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  CONSTRAINT `Orders_ibfk_2` FOREIGN KEY (`Payment_id`) REFERENCES `payment` (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,1,'Delivered','2025-04-10 14:36:41',850.00),(2,2,2,2,'Delivered','2025-04-10 14:36:41',1440.00),(3,3,3,3,'Delivered','2025-04-10 14:36:41',540.00),(4,4,4,4,'Delivered','2025-04-10 14:36:41',400.00),(5,5,5,5,'Delivered','2025-04-10 14:36:41',500.00),(6,6,6,6,'Delivered','2025-04-10 14:36:41',620.00),(7,7,7,7,'Delivered','2025-04-10 14:36:41',920.00),(8,8,8,8,'Delivered','2025-04-10 14:36:41',300.00),(9,9,9,9,'Delivered','2025-04-10 14:36:41',300.00),(10,10,10,10,'Delivered','2025-04-10 14:36:41',300.00),(11,11,11,11,'Delivered','2025-04-10 14:36:41',300.00),(12,12,12,12,'Delivered','2025-04-10 14:36:41',300.00),(13,13,13,13,'Delivered','2025-04-10 14:36:41',300.00),(14,14,14,14,'Delivered','2025-04-10 14:36:41',300.00),(15,15,15,15,'Processing','2025-04-10 14:36:41',300.00),(16,1,2,16,'Processing','2025-04-26 10:20:48',60.00),(17,1,3,17,'Processing','2025-04-27 11:33:08',70.00),(18,1,3,18,'Processing','2025-04-27 11:37:44',230.00),(19,1,3,19,'Processing','2025-04-27 11:39:18',100.00),(20,1,3,20,'Processing','2025-04-27 11:43:09',350.00),(21,1,3,21,'Processing','2025-04-27 11:47:44',350.00),(22,1,3,22,'Processing','2025-04-27 12:00:33',350.00),(23,1,3,23,'Processing','2025-04-27 12:11:09',350.00),(24,1,6,24,'Processing','2025-04-27 12:32:15',320.00),(25,1,6,25,'Processing','2025-04-27 12:50:43',80.00),(26,1,3,26,'Processing','2025-04-27 13:07:12',70.00),(27,1,6,27,'Processing','2025-04-27 13:25:38',220.00),(28,1,6,28,'Processing','2025-04-27 13:43:54',120.00),(29,1,3,29,'Processing','2025-04-27 15:53:00',350.00),(30,2,8,30,'Processing','2025-04-27 19:58:48',90.00),(31,2,8,31,'Processing','2025-04-27 19:59:10',90.00),(32,2,8,32,'Processing','2025-04-27 19:59:11',90.00),(33,2,8,33,'Processing','2025-04-27 19:59:16',90.00),(34,2,6,34,'Processing','2025-04-27 20:06:22',320.00),(35,2,6,35,'Processing','2025-04-27 20:27:58',320.00),(36,2,6,36,'Processing','2025-04-27 20:33:25',320.00),(37,2,3,37,'Processing','2025-04-27 20:45:30',350.00),(38,2,3,38,'Processing','2025-04-27 20:56:24',230.00),(39,2,3,39,'Processing','2025-04-27 20:57:10',230.00),(40,2,3,40,'Processing','2025-04-27 20:59:24',230.00),(41,2,3,41,'Processing','2025-04-27 21:07:21',230.00),(42,2,3,42,'Processing','2025-04-27 21:07:31',230.00),(43,2,3,43,'Processing','2025-04-27 21:07:32',230.00),(44,2,3,44,'Processing','2025-04-27 21:07:33',230.00),(45,2,3,45,'Processing','2025-04-27 21:18:54',230.00),(46,2,3,46,'Processing','2025-04-27 21:19:44',230.00),(47,2,3,47,'Processing','2025-04-27 21:22:01',230.00),(48,2,3,48,'Processing','2025-04-27 21:22:34',200.00),(49,2,3,49,'Processing','2025-04-27 21:26:31',200.00),(50,2,3,50,'Processing','2025-04-27 21:28:47',200.00),(51,2,3,51,'Processing','2025-04-27 21:32:37',200.00),(52,2,3,52,'Processing','2025-04-27 21:33:08',200.00),(53,2,3,53,'Processing','2025-04-27 21:33:09',200.00),(54,2,3,54,'Processing','2025-04-27 21:33:10',200.00),(55,2,3,55,'Processing','2025-04-27 21:33:24',200.00),(56,2,3,56,'Processing','2025-04-27 21:33:34',200.00),(57,2,3,57,'Processing','2025-04-27 21:33:35',200.00),(58,2,3,58,'Processing','2025-04-28 03:52:03',200.00),(59,2,3,59,'Processing','2025-04-28 03:53:13',200.00),(60,2,3,60,'Processing','2025-04-28 04:05:29',200.00),(61,2,3,61,'Processing','2025-04-28 04:10:45',200.00),(62,2,3,62,'Processing','2025-04-28 04:11:40',200.00),(63,2,3,63,'Processing','2025-04-28 04:14:35',200.00),(64,2,3,64,'Processing','2025-04-28 04:15:31',200.00),(65,2,3,65,'Processing','2025-04-28 04:15:33',200.00),(66,2,3,66,'Processing','2025-04-28 04:16:06',200.00),(67,2,3,67,'Processing','2025-04-28 04:16:11',200.00),(68,2,3,68,'Processing','2025-04-28 04:20:00',200.00),(69,2,3,69,'Processing','2025-04-28 04:20:17',200.00),(70,2,3,70,'Processing','2025-04-28 04:21:05',200.00),(71,2,3,71,'Processing','2025-04-28 04:21:06',200.00),(72,2,3,72,'Processing','2025-04-28 04:21:07',200.00),(73,2,3,73,'Processing','2025-04-28 04:22:11',200.00),(74,2,3,74,'Processing','2025-04-28 04:22:17',200.00),(75,2,3,75,'Processing','2025-04-28 04:22:41',200.00),(76,2,3,76,'Processing','2025-04-28 04:24:04',200.00),(77,2,3,77,'Processing','2025-04-28 04:24:05',200.00),(78,2,3,78,'Processing','2025-04-28 04:24:05',200.00),(79,2,3,79,'Processing','2025-04-28 04:24:32',200.00),(80,2,3,80,'Processing','2025-04-28 04:24:33',200.00),(81,2,3,81,'Processing','2025-04-28 04:24:33',200.00),(82,2,3,82,'Processing','2025-04-28 04:24:34',200.00),(83,2,3,83,'Processing','2025-04-28 04:24:40',200.00),(84,2,3,84,'Processing','2025-04-28 04:24:50',200.00),(85,2,3,85,'Processing','2025-04-28 04:24:57',200.00),(86,2,3,86,'Processing','2025-04-28 04:25:25',200.00),(87,2,3,87,'Processing','2025-04-28 04:25:42',200.00),(88,2,3,88,'Processing','2025-04-28 04:28:17',200.00),(89,2,3,89,'Processing','2025-04-28 04:29:00',200.00),(90,2,3,90,'Processing','2025-04-28 04:29:30',200.00),(91,2,3,91,'Processing','2025-04-28 04:31:14',200.00),(92,2,3,92,'Processing','2025-04-28 04:32:47',200.00),(93,2,3,93,'Processing','2025-04-28 04:33:28',200.00),(94,2,3,94,'Processing','2025-04-28 04:34:32',200.00),(95,2,3,95,'Processing','2025-04-28 04:34:55',200.00),(96,2,3,96,'Processing','2025-04-28 04:36:18',200.00),(97,2,3,97,'Processing','2025-04-28 04:36:20',200.00),(98,2,3,98,'Processing','2025-04-28 04:36:49',200.00),(99,2,3,99,'Processing','2025-04-28 04:37:32',200.00),(100,2,3,100,'Processing','2025-04-28 04:38:29',200.00),(101,2,3,101,'Processing','2025-04-28 04:39:20',200.00),(102,2,3,102,'Processing','2025-04-28 04:39:45',200.00),(103,2,3,103,'Processing','2025-04-28 04:40:01',200.00),(104,2,3,104,'Processing','2025-04-28 04:40:48',200.00),(105,2,3,105,'Processing','2025-04-28 04:41:02',200.00),(106,2,3,106,'Processing','2025-04-28 04:41:13',200.00),(107,2,3,107,'Processing','2025-04-28 04:41:44',200.00),(108,2,3,108,'Processing','2025-04-28 04:42:45',200.00),(109,2,3,109,'Processing','2025-04-28 04:42:57',200.00),(110,2,3,110,'Processing','2025-04-28 04:43:09',200.00),(111,2,3,111,'Processing','2025-04-28 04:43:11',200.00),(112,2,3,112,'Processing','2025-04-28 04:43:57',200.00),(113,2,3,113,'Processing','2025-04-28 04:44:29',200.00),(114,2,3,114,'Processing','2025-04-28 04:44:46',200.00),(115,2,3,115,'Processing','2025-04-28 04:45:00',200.00),(116,2,3,116,'Processing','2025-04-28 04:45:12',200.00),(117,2,3,117,'Processing','2025-04-28 04:45:17',200.00),(118,2,3,118,'Processing','2025-04-28 04:45:53',200.00),(119,2,3,119,'Processing','2025-04-28 04:46:11',200.00),(120,2,3,120,'Processing','2025-04-28 04:46:22',200.00),(121,2,3,121,'Processing','2025-04-28 04:47:35',200.00),(122,2,3,122,'Processing','2025-04-28 04:49:16',200.00),(123,2,3,123,'Processing','2025-04-28 04:50:34',200.00),(124,2,3,124,'Processing','2025-04-28 04:50:55',200.00),(125,2,3,125,'Processing','2025-04-28 04:50:56',200.00),(126,2,3,126,'Processing','2025-04-28 04:51:46',200.00),(127,2,3,127,'Processing','2025-04-28 04:52:30',200.00),(128,2,3,128,'Processing','2025-04-28 04:53:30',200.00),(129,2,3,129,'Processing','2025-04-28 04:53:44',200.00),(130,2,3,130,'Processing','2025-04-28 04:54:28',200.00),(131,2,3,131,'Processing','2025-04-28 04:54:50',200.00),(132,2,3,132,'Processing','2025-04-28 04:56:40',200.00),(133,1,1,133,'Processing','2025-04-28 20:15:56',220.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `payment_status` enum('Successful','Failed','Pending') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'Credit Card','Successful',50.00,'2025-04-10 14:36:41'),(2,'Debit Card','Successful',30.50,'2025-04-10 14:36:41'),(3,'UPI','Failed',25.75,'2025-04-10 14:36:41'),(4,'Credit Card','Successful',40.00,'2025-04-10 14:36:41'),(5,'Cash','Pending',55.25,'2025-04-10 14:36:41'),(6,'PayPal','Successful',70.00,'2025-04-10 14:36:41'),(7,'Debit Card','Failed',20.00,'2025-04-10 14:36:41'),(8,'Credit Card','Successful',45.50,'2025-04-10 14:36:41'),(9,'UPI','Successful',35.75,'2025-04-10 14:36:41'),(10,'Cash','Pending',60.25,'2025-04-10 14:36:41'),(11,'PayPal','Failed',80.00,'2025-04-10 14:36:41'),(12,'Credit Card','Successful',55.50,'2025-04-10 14:36:41'),(13,'Debit Card','Successful',15.75,'2025-04-10 14:36:41'),(14,'UPI','Failed',30.00,'2025-04-10 14:36:41'),(15,'Cash','Successful',65.25,'2025-04-10 14:36:41'),(16,'cash','Successful',60.00,'2025-04-26 10:20:48'),(17,'cash','Successful',70.00,'2025-04-27 11:33:08'),(18,'cash','Successful',230.00,'2025-04-27 11:37:44'),(19,'upi','Successful',100.00,'2025-04-27 11:39:18'),(20,'upi','Successful',350.00,'2025-04-27 11:43:09'),(21,'cash','Successful',350.00,'2025-04-27 11:47:44'),(22,'cash','Successful',350.00,'2025-04-27 12:00:33'),(23,'cash','Successful',350.00,'2025-04-27 12:11:09'),(24,'cash','Successful',320.00,'2025-04-27 12:32:15'),(25,'cash','Successful',80.00,'2025-04-27 12:50:43'),(26,'cash','Successful',70.00,'2025-04-27 13:07:12'),(27,'cash','Successful',220.00,'2025-04-27 13:25:38'),(28,'cash','Successful',120.00,'2025-04-27 13:43:54'),(29,'cash','Successful',350.00,'2025-04-27 15:53:00'),(30,'cash','Successful',90.00,'2025-04-27 19:58:48'),(31,'cash','Successful',90.00,'2025-04-27 19:59:10'),(32,'cash','Successful',90.00,'2025-04-27 19:59:11'),(33,'cash','Successful',90.00,'2025-04-27 19:59:16'),(34,'upi','Successful',320.00,'2025-04-27 20:06:22'),(35,'upi','Successful',320.00,'2025-04-27 20:27:58'),(36,'upi','Successful',320.00,'2025-04-27 20:33:25'),(37,'upi','Successful',350.00,'2025-04-27 20:45:30'),(38,'upi','Successful',230.00,'2025-04-27 20:56:24'),(39,'upi','Successful',230.00,'2025-04-27 20:57:10'),(40,'upi','Successful',230.00,'2025-04-27 20:59:24'),(41,'upi','Successful',230.00,'2025-04-27 21:07:21'),(42,'upi','Successful',230.00,'2025-04-27 21:07:31'),(43,'upi','Successful',230.00,'2025-04-27 21:07:32'),(44,'upi','Successful',230.00,'2025-04-27 21:07:33'),(45,'upi','Successful',230.00,'2025-04-27 21:18:54'),(46,'upi','Successful',230.00,'2025-04-27 21:19:44'),(47,'upi','Successful',230.00,'2025-04-27 21:22:01'),(48,'cash','Successful',200.00,'2025-04-27 21:22:34'),(49,'cash','Successful',200.00,'2025-04-27 21:26:31'),(50,'cash','Successful',200.00,'2025-04-27 21:28:47'),(51,'cash','Successful',200.00,'2025-04-27 21:32:37'),(52,'cash','Successful',200.00,'2025-04-27 21:33:08'),(53,'cash','Successful',200.00,'2025-04-27 21:33:09'),(54,'cash','Successful',200.00,'2025-04-27 21:33:10'),(55,'cash','Successful',200.00,'2025-04-27 21:33:24'),(56,'cash','Successful',200.00,'2025-04-27 21:33:34'),(57,'cash','Successful',200.00,'2025-04-27 21:33:35'),(58,'cash','Successful',200.00,'2025-04-28 03:52:03'),(59,'cash','Successful',200.00,'2025-04-28 03:53:13'),(60,'cash','Successful',200.00,'2025-04-28 04:05:29'),(61,'cash','Successful',200.00,'2025-04-28 04:10:45'),(62,'cash','Successful',200.00,'2025-04-28 04:11:40'),(63,'cash','Successful',200.00,'2025-04-28 04:14:35'),(64,'cash','Successful',200.00,'2025-04-28 04:15:31'),(65,'cash','Successful',200.00,'2025-04-28 04:15:33'),(66,'cash','Successful',200.00,'2025-04-28 04:16:06'),(67,'cash','Successful',200.00,'2025-04-28 04:16:11'),(68,'cash','Successful',200.00,'2025-04-28 04:20:00'),(69,'cash','Successful',200.00,'2025-04-28 04:20:17'),(70,'cash','Successful',200.00,'2025-04-28 04:21:05'),(71,'cash','Successful',200.00,'2025-04-28 04:21:06'),(72,'cash','Successful',200.00,'2025-04-28 04:21:07'),(73,'cash','Successful',200.00,'2025-04-28 04:22:11'),(74,'cash','Successful',200.00,'2025-04-28 04:22:17'),(75,'cash','Successful',200.00,'2025-04-28 04:22:41'),(76,'cash','Successful',200.00,'2025-04-28 04:24:04'),(77,'cash','Successful',200.00,'2025-04-28 04:24:05'),(78,'cash','Successful',200.00,'2025-04-28 04:24:05'),(79,'cash','Successful',200.00,'2025-04-28 04:24:32'),(80,'cash','Successful',200.00,'2025-04-28 04:24:33'),(81,'cash','Successful',200.00,'2025-04-28 04:24:33'),(82,'cash','Successful',200.00,'2025-04-28 04:24:34'),(83,'cash','Successful',200.00,'2025-04-28 04:24:40'),(84,'cash','Successful',200.00,'2025-04-28 04:24:50'),(85,'cash','Successful',200.00,'2025-04-28 04:24:57'),(86,'cash','Successful',200.00,'2025-04-28 04:25:25'),(87,'cash','Successful',200.00,'2025-04-28 04:25:42'),(88,'cash','Successful',200.00,'2025-04-28 04:28:17'),(89,'cash','Successful',200.00,'2025-04-28 04:29:00'),(90,'cash','Successful',200.00,'2025-04-28 04:29:30'),(91,'cash','Successful',200.00,'2025-04-28 04:31:14'),(92,'cash','Successful',200.00,'2025-04-28 04:32:47'),(93,'cash','Successful',200.00,'2025-04-28 04:33:28'),(94,'cash','Successful',200.00,'2025-04-28 04:34:32'),(95,'cash','Successful',200.00,'2025-04-28 04:34:55'),(96,'cash','Successful',200.00,'2025-04-28 04:36:18'),(97,'cash','Successful',200.00,'2025-04-28 04:36:20'),(98,'cash','Successful',200.00,'2025-04-28 04:36:49'),(99,'cash','Successful',200.00,'2025-04-28 04:37:32'),(100,'cash','Successful',200.00,'2025-04-28 04:38:29'),(101,'cash','Successful',200.00,'2025-04-28 04:39:20'),(102,'cash','Successful',200.00,'2025-04-28 04:39:45'),(103,'cash','Successful',200.00,'2025-04-28 04:40:01'),(104,'cash','Successful',200.00,'2025-04-28 04:40:48'),(105,'cash','Successful',200.00,'2025-04-28 04:41:02'),(106,'cash','Successful',200.00,'2025-04-28 04:41:13'),(107,'cash','Successful',200.00,'2025-04-28 04:41:44'),(108,'cash','Successful',200.00,'2025-04-28 04:42:45'),(109,'cash','Successful',200.00,'2025-04-28 04:42:57'),(110,'cash','Successful',200.00,'2025-04-28 04:43:09'),(111,'cash','Successful',200.00,'2025-04-28 04:43:11'),(112,'cash','Successful',200.00,'2025-04-28 04:43:57'),(113,'cash','Successful',200.00,'2025-04-28 04:44:29'),(114,'cash','Successful',200.00,'2025-04-28 04:44:46'),(115,'cash','Successful',200.00,'2025-04-28 04:45:00'),(116,'cash','Successful',200.00,'2025-04-28 04:45:12'),(117,'cash','Successful',200.00,'2025-04-28 04:45:17'),(118,'cash','Successful',200.00,'2025-04-28 04:45:53'),(119,'cash','Successful',200.00,'2025-04-28 04:46:11'),(120,'cash','Successful',200.00,'2025-04-28 04:46:22'),(121,'cash','Successful',200.00,'2025-04-28 04:47:35'),(122,'cash','Successful',200.00,'2025-04-28 04:49:16'),(123,'cash','Successful',200.00,'2025-04-28 04:50:34'),(124,'cash','Successful',200.00,'2025-04-28 04:50:55'),(125,'cash','Successful',200.00,'2025-04-28 04:50:56'),(126,'cash','Successful',200.00,'2025-04-28 04:51:46'),(127,'cash','Successful',200.00,'2025-04-28 04:52:30'),(128,'cash','Successful',200.00,'2025-04-28 04:53:30'),(129,'cash','Successful',200.00,'2025-04-28 04:53:44'),(130,'cash','Successful',200.00,'2025-04-28 04:54:28'),(131,'cash','Successful',200.00,'2025-04-28 04:54:50'),(132,'cash','Successful',200.00,'2025-04-28 04:56:40'),(133,'upi','Successful',220.00,'2025-04-28 20:15:56');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `password` varchar(50) NOT NULL,
  `restaurant_id` int NOT NULL,
  `restaurant_name` varchar(100) NOT NULL,
  `cuisine_type` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `timings` varchar(50) NOT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `account_no` varchar(30) DEFAULT NULL,
  `IFSC_code` varchar(25) DEFAULT NULL,
  `bank_name` varchar(50) DEFAULT NULL,
  `balance_earned` int DEFAULT NULL,
  `review` varchar(1000) DEFAULT NULL,
  `editing_menu` int DEFAULT '0',
  `resphoto_url` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES ('password1',1,'Taj Mahal Restaurant','Indian','tajmahal@example.com','+91 9876543210','10:00 AM - 10:00 PM',4.50,'1234567890123456789','INDB0000001','Indian Bank',872,'Amamzing food!; Loved it; Will visit again',0,'https://seeklogo.com/images/T/tajmahal-restaurant-logo-CDD385DD3C-seeklogo.com.png'),('password2',2,'Spice Garden','Indian','spicegarden@example.com','+91 8765432109','11:00 AM - 11:00 PM',4.20,'9876543210123456789','BOIN0000002','Bank of India',150,'Very hot stuff; Very spicy',0,'https://i0.wp.com/www.spicegardenrestaurant.com/wp-content/uploads/2018/03/spicegarden_logo.jpg?fit=250%2C249&ssl=1'),('password3',3,'Punjabi Dhaba','North Indian','punjabidhaba@example.com','+91 7654321098','12:00 PM - 10:30 PM',4.02,'0123456789012345678','AXIS0000003','Axis Bank',2241,'Good spicy food; Very good refreshments; super; yummy; Super',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8Zu-GgXvTmyOJ3pcX4uoptXoe8sMbVLKHraRt30T-riK2gFMAsYeRuYjc-gN7r49JK1g&usqp=CAU'),('password4',4,'Southern Spice','South Indian','southernspice@example.com','+91 6543210987','11:30 AM - 11:30 PM',4.40,'5432109876543210123','KOTA0000004','Kotak Mahindra Bank',40,'very good ambience; perfect for first date',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTeS_Lv5sV7QCLSok0g4PVHE9FnvBsL-onZA&s'),('password5',5,'The Mughal Feast','Mughlai','mughalfeast@example.com','+91 5432109876','12:00 PM - 10:00 PM',4.70,'2345678901234567890','HDFC0000005','HDFC Bank',50,'Amamzing music and hygeine; will definetly come again',1,'https://ondcresources.blob.core.windows.net/images/658e9233c43b29098ed0daf0/thumb_2023_12_26_16_44_15_mr.png'),('password6',6,'Coastal Curry House','Coastal','coastalcurry@example.com','+91 4321098765','11:00 AM - 10:30 PM',4.34,'7890123456789012345','YESB0000006','Yes Bank',232,'karioke; Amazing cook; super; super; super; super',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST60dwTmP4xdItycxIpPwzwutVu6U2hLb2Mw&s'),('password7',7,'Rajasthani Delight','Rajasthani','rajasthanidelight@example.com','+91 3210987654','12:30 PM - 11:00 PM',4.60,'1012345678901234567','IDFB0000007','IDFC First Bank',92,'100% would recommend; Will come again',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREPong5isgo-MwYk8PrXSXnWR5LABqgEG3WkxeMwPxaDP_UOUMtLI8q6mz29VHwhwEk8I&usqp=CAU'),('password8',8,'Gujarati Thali','Gujarati','gujaratithali@example.com','+91 2109876543','11:00 AM - 10:00 PM',4.10,'4567890123456789012','RBLB0000008','RBL Bank',66,'lovely food; Super; Super',0,'https://www.basundigujaratithali.com/img/logo.png'),('password9',9,'Bengali Bhavan','Bengali','bengalibhavan@example.com','+91 1098765432','12:00 PM - 10:30 PM',4.80,'8901234567890123456','INDB0000009','IndusInd Bank',30,'Very good non-vegetarian option; Nice refreshements',1,'https://pbs.twimg.com/profile_images/1215826258124132352/u9ScZ6MC_400x400.jpg'),('password10',10,'Hyderabadi Biryani House','Hyderabadi','hyderabadibiryani@example.com\"','+91 0987654321','11:30 AM - 11:00 PM',4.50,'3456789012345678901','SCBL0000010','Standard Chartered Bank',30,'Nice Food; Nice Staff',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmJHtY_-4EKDmOCQHSwoIsd-G5bcBDWGitA&s'),('password11',11,'Kerala Cuisine Corner','Kerala','keralacuisine@example.com','+91 9876543210','12:00 PM - 10:00 PM',4.20,'2345609876543210123','HSBC0000011','HSBC India',30,'Good for family; Good Culture',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuWnAIp0TtoQL6ivAeF0EE1V5L-oJ9PjfNunFPyF1zqhD9kZhTwG9afXuMTKu4XD3CNEY&usqp=CAU'),('password12',12,'Maharashtrian Delicacies','Maharashtrian','maharashtriandelicacies@example.com','+91 8765432109','11:00 AM - 10:30 PM',4.70,'7890101234567890123','BARO0000012','Bank of Baroda',30,'Definetly coming back again; Loved it',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkwD2f7mStWB2Ty8GuvpIy-4DD-o833FG5SQ&s'),('password13',13,'Goan Flavors','Goan','goanflavors@example.com','+91 7654321098','12:30 PM - 11:00 PM',4.40,'1234509876543210123','CENB0000013','Central Bank of India',30,'Nice staff; Good cook',1,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5dUetUOyRgklcwloJhnqupqIHlOXA6E3u6ifLX1Y2tHhwwcu4BzvkH6B6ofyDMm_ZgNI&usqp=CAU'),('password14',14,'Parsi Paradise','Parsi','parsiparadise@example.com','+91 6543210987','11:00 AM - 10:00 PM',4.60,'5678901234567890123','PUNB0000014','Punjab National Bank',30,'Tipped extra; Very good service',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ7eH1qHaOjeYYJ2wAJCpYNViSvesMZakSJw&s'),('password15',15,'Assamese Aroma','Assamese','assamesearoma@example.com','+91 5432109876','12:00 PM - 10:30 PM',4.30,'9012345678901234567','MAHB0000015','Bank of Maharashtra',30,'Kind staff; Good Cook',0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfjD40_LaESFoAC_Nnl-vXIxi4TLQ2eSf3JQ&s');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_address`
--

DROP TABLE IF EXISTS `restaurant_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_address` (
  `restaurant_id` int NOT NULL,
  `address_id` int NOT NULL,
  KEY `restaurant_id` (`restaurant_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `Restaurant_Address_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE,
  CONSTRAINT `Restaurant_Address_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_address`
--

LOCK TABLES `restaurant_address` WRITE;
/*!40000 ALTER TABLE `restaurant_address` DISABLE KEYS */;
INSERT INTO `restaurant_address` VALUES (1,16),(2,17),(3,18),(4,19),(5,20),(6,21),(7,22),(8,23),(9,24),(10,25),(11,26),(12,27),(13,28),(14,29),(15,30);
/*!40000 ALTER TABLE `restaurant_address` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-02 17:41:14
