-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: bookstore
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `biography` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'J.K. Rowling','British author, best known for the Harry Potter series.','1965-07-31'),(2,'George R.R. Martin','American novelist and short-story writer, screenwriter, and television producer.','1948-09-20'),(3,'J.R.R. Tolkien','English writer, poet, philologist, and academic, author of The Hobbit and The Lord of the Rings.','1892-01-03'),(4,'Stephen King','American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels.','1947-09-21'),(5,'Agatha Christie','English writer known for her sixty-six detective novels.','1890-09-15'),(6,'Dan Brown','American author best known for his thriller novels, including the Robert Langdon novels.','1964-06-22'),(7,'Isaac Asimov','American writer and professor of biochemistry, known for his works of science fiction and popular science.','1920-01-02'),(8,'Arthur Conan Doyle','British writer best known for his detective fiction featuring the character Sherlock Holmes.','1859-05-22'),(9,'Leo Tolstoy','Russian writer who is regarded as one of the greatest authors of all time.','1828-09-09'),(10,'Mark Twain','American writer, humorist, entrepreneur, publisher, and lecturer.','1835-11-30');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `book_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `publication_date` date DEFAULT NULL,
  `stock_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `author_id` (`author_id`),
  KEY `publisher_id` (`publisher_id`),
  KEY `category_id` (`category_id`),
  KEY `fk_books_stock` (`stock_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`),
  CONSTRAINT `books_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`),
  CONSTRAINT `books_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_books_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Harry Potter and the Philosopher\'s Stone',1,6,1,'9780747532699',19.99,'1997-06-26',1),(2,'A Game of Thrones',2,1,1,'9780553103540',22.99,'1996-08-06',2),(3,'The Hobbit',3,1,1,'9780007118359',15.99,'1937-09-21',3),(4,'The Shining',4,2,6,'9780385121675',18.99,'1977-01-28',4),(5,'Murder on the Orient Express',5,3,3,'9780007119318',14.99,'1934-01-01',5),(6,'The Da Vinci Code',6,4,4,'9780385504201',21.99,'2003-03-18',6),(7,'Foundation',7,2,2,'9780553293357',16.99,'1951-06-01',7),(8,'Sherlock Holmes: The Complete Novels and Stories',8,5,3,'9780553212419',25.99,'1930-01-01',8),(9,'War and Peace',9,9,7,'9780199232765',30.99,'1869-01-01',9),(10,'The Adventures of Huckleberry Finn',10,10,7,'9780486280615',12.99,'1884-12-10',10);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Fantasy','Books that contain magical or supernatural elements that do not exist in the real world.'),(2,'Science Fiction','Books that are based on speculative or imaginative concepts such as futuristic settings.'),(3,'Mystery','Books that focus on the solving of a crime or unraveling secrets.'),(4,'Thriller','Books that are characterized by fast pacing, frequent action, and resourceful heroes.'),(5,'Romance','Books that place their primary focus on the relationship and romantic love between two people.'),(6,'Horror','Books intended to, or have the capacity to frighten, scare, or startle readers.'),(7,'Historical','Books that are set in the past and based on historical events.'),(8,'Biography','Books that provide a detailed description of a person\'s life.'),(9,'Self-Help','Books designed to help readers solve personal problems.'),(10,'Non-Fiction','Books that are based on facts and real events.');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John Doe','john.doe@example.com','1234567890','123 Main St, Anytown, USA'),(2,'Jane Smith','jane.smith@example.com','0987654321','456 Elm St, Othertown, USA'),(3,'Alice Johnson','alice.johnson@example.com','1112223333','789 Maple St, Sometown, USA'),(4,'Bob Brown','bob.brown@example.com','4445556666','321 Oak St, Anycity, USA'),(5,'Charlie Davis','charlie.davis@example.com','7778889999','654 Pine St, Othercity, USA'),(6,'Eve White','eve.white@example.com','0001112222','987 Cedar St, Somecity, USA'),(7,'Frank Harris','frank.harris@example.com','3334445555','123 Spruce St, Anyville, USA'),(8,'Grace Lee','grace.lee@example.com','6667778888','456 Birch St, Otherville, USA'),(9,'Hank Walker','hank.walker@example.com','9990001111','789 Ash St, Someville, USA'),(10,'Ivy Young','ivy.young@example.com','2223334444','321 Fir St, Anyburg, USA');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderdetails` (
  `order_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id` (`order_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,1,1,19.99),(2,1,3,2,15.99),(3,1,6,3,21.99),(4,1,1,1,19.99),(5,1,2,1,19.99),(6,2,3,1,22.99),(7,3,4,1,18.99),(8,3,5,1,11.99),(9,4,6,1,21.99),(10,5,7,1,16.99),(11,6,8,1,25.99),(12,7,9,1,30.99),(13,8,10,1,12.99);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER calculate_order_total
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    

    SET total = NEW.quantity * NEW.price;
    
  
    UPDATE Orders
    SET total_amount = total_amount + total
    WHERE order_id = NEW.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER update_stock_after_order_detail
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE change_amount INT;
    DECLARE book_id_temp INT;
    

    SELECT NEW.book_id, NEW.quantity INTO book_id_temp, change_amount;
    

    IF (SELECT COUNT(*) FROM Stock WHERE book_id = book_id_temp) > 0 THEN
        UPDATE Stock
        SET quantity_available = quantity_available - change_amount
        WHERE book_id = book_id_temp;
    ELSE
        INSERT INTO Stock (book_id, quantity_available)
        VALUES (book_id_temp, -change_amount); 
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `orderdetailsview`
--

DROP TABLE IF EXISTS `orderdetailsview`;
/*!50001 DROP VIEW IF EXISTS `orderdetailsview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `orderdetailsview` AS SELECT
 1 AS `order_id`,
  1 AS `customer_name`,
  1 AS `book_title`,
  1 AS `quantity`,
  1 AS `price`,
  1 AS `subtotal`,
  1 AS `total_amount` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2024-01-10',157.92),(2,1,'2024-01-10',62.97),(3,2,'2024-01-12',53.97),(4,3,'2024-01-15',52.97),(5,4,'2024-01-18',35.98),(6,5,'2024-01-20',40.98),(7,6,'2024-01-22',52.98),(8,7,'2024-01-25',29.98),(9,8,'2024-01-28',25.99),(10,9,'2024-01-30',30.99),(11,10,'2024-02-01',12.99);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publishers` (
  `publisher_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (1,'Penguin Random House','1745 Broadway, New York, NY 10019, USA','contact@penguinrandomhouse.com'),(2,'HarperCollins','195 Broadway, New York, NY 10007, USA','contact@harpercollins.com'),(3,'Simon & Schuster','1230 Avenue of the Americas, New York, NY 10020, USA','contact@simonandschuster.com'),(4,'Hachette Livre','58 Rue Jean Bleuzen, 92170 Vanves, France','contact@hachette.com'),(5,'Macmillan Publishers','120 Broadway, New York, NY 10271, USA','contact@macmillan.com'),(6,'Scholastic','557 Broadway, New York, NY 10012, USA','contact@scholastic.com'),(7,'Houghton Mifflin Harcourt','125 High Street, Boston, MA 02110, USA','contact@hmhco.com'),(8,'Pearson','80 Strand, London WC2R 0RL, United Kingdom','contact@pearson.com'),(9,'Wiley','111 River Street, Hoboken, NJ 07030, USA','contact@wiley.com'),(10,'Springer','Tiergartenstra?e 17, 69121 Heidelberg, Germany','contact@springer.com');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) DEFAULT NULL,
  `quantity_available` int(11) NOT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,99),(2,2,79),(3,3,149),(4,4,59),(5,5,119),(6,6,86),(7,7,109),(8,8,74),(9,9,84),(10,10,129);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `orderdetailsview`
--

/*!50001 DROP VIEW IF EXISTS `orderdetailsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orderdetailsview` AS select `o`.`order_id` AS `order_id`,`c`.`name` AS `customer_name`,`b`.`title` AS `book_title`,`od`.`quantity` AS `quantity`,`b`.`price` AS `price`,`od`.`quantity` * `b`.`price` AS `subtotal`,`o`.`total_amount` AS `total_amount` from (((`orders` `o` join `customers` `c` on(`o`.`customer_id` = `c`.`customer_id`)) join `orderdetails` `od` on(`o`.`order_id` = `od`.`order_id`)) join `books` `b` on(`od`.`book_id` = `b`.`book_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-23 15:38:05
