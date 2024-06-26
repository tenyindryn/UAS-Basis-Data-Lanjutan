-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2024 at 01:09 PM
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
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `author_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `biography` text DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `name`, `biography`, `date_of_birth`) VALUES
(1, 'J.K. Rowling', 'British author, best known for the Harry Potter series.', '1965-07-31'),
(2, 'George R.R. Martin', 'American novelist and short-story writer, screenwriter, and television producer.', '1948-09-20'),
(3, 'J.R.R. Tolkien', 'English writer, poet, philologist, and academic, author of The Hobbit and The Lord of the Rings.', '1892-01-03'),
(4, 'Stephen King', 'American author of horror, supernatural fiction, suspense, crime, science-fiction, and fantasy novels.', '1947-09-21'),
(5, 'Agatha Christie', 'English writer known for her sixty-six detective novels.', '1890-09-15'),
(6, 'Dan Brown', 'American author best known for his thriller novels, including the Robert Langdon novels.', '1964-06-22'),
(7, 'Isaac Asimov', 'American writer and professor of biochemistry, known for his works of science fiction and popular science.', '1920-01-02'),
(8, 'Arthur Conan Doyle', 'British writer best known for his detective fiction featuring the character Sherlock Holmes.', '1859-05-22'),
(9, 'Leo Tolstoy', 'Russian writer who is regarded as one of the greatest authors of all time.', '1828-09-09'),
(10, 'Mark Twain', 'American writer, humorist, entrepreneur, publisher, and lecturer.', '1835-11-30');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `publication_date` date DEFAULT NULL,
  `stock_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `author_id`, `publisher_id`, `category_id`, `isbn`, `price`, `publication_date`, `stock_id`) VALUES
(1, 'Harry Potter and the Philosopher\'s Stone', 1, 6, 1, '9780747532699', 19.99, '1997-06-26', 1),
(2, 'A Game of Thrones', 2, 1, 1, '9780553103540', 22.99, '1996-08-06', 2),
(3, 'The Hobbit', 3, 1, 1, '9780007118359', 15.99, '1937-09-21', 3),
(4, 'The Shining', 4, 2, 6, '9780385121675', 18.99, '1977-01-28', 4),
(5, 'Murder on the Orient Express', 5, 3, 3, '9780007119318', 14.99, '1934-01-01', 5),
(6, 'The Da Vinci Code', 6, 4, 4, '9780385504201', 21.99, '2003-03-18', 6),
(7, 'Foundation', 7, 2, 2, '9780553293357', 16.99, '1951-06-01', 7),
(8, 'Sherlock Holmes: The Complete Novels and Stories', 8, 5, 3, '9780553212419', 25.99, '1930-01-01', 8),
(9, 'War and Peace', 9, 9, 7, '9780199232765', 30.99, '1869-01-01', 9),
(10, 'The Adventures of Huckleberry Finn', 10, 10, 7, '9780486280615', 12.99, '1884-12-10', 10);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`) VALUES
(1, 'Fantasy', 'Books that contain magical or supernatural elements that do not exist in the real world.'),
(2, 'Science Fiction', 'Books that are based on speculative or imaginative concepts such as futuristic settings.'),
(3, 'Mystery', 'Books that focus on the solving of a crime or unraveling secrets.'),
(4, 'Thriller', 'Books that are characterized by fast pacing, frequent action, and resourceful heroes.'),
(5, 'Romance', 'Books that place their primary focus on the relationship and romantic love between two people.'),
(6, 'Horror', 'Books intended to, or have the capacity to frighten, scare, or startle readers.'),
(7, 'Historical', 'Books that are set in the past and based on historical events.'),
(8, 'Biography', 'Books that provide a detailed description of a person\'s life.'),
(9, 'Self-Help', 'Books designed to help readers solve personal problems.'),
(10, 'Non-Fiction', 'Books that are based on facts and real events.');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `email`, `phone`, `address`) VALUES
(1, 'John Doe', 'john.doe@example.com', '1234567890', '123 Main St, Anytown, USA'),
(2, 'Jane Smith', 'jane.smith@example.com', '0987654321', '456 Elm St, Othertown, USA'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '1112223333', '789 Maple St, Sometown, USA'),
(4, 'Bob Brown', 'bob.brown@example.com', '4445556666', '321 Oak St, Anycity, USA'),
(5, 'Charlie Davis', 'charlie.davis@example.com', '7778889999', '654 Pine St, Othercity, USA'),
(6, 'Eve White', 'eve.white@example.com', '0001112222', '987 Cedar St, Somecity, USA'),
(7, 'Frank Harris', 'frank.harris@example.com', '3334445555', '123 Spruce St, Anyville, USA'),
(8, 'Grace Lee', 'grace.lee@example.com', '6667778888', '456 Birch St, Otherville, USA'),
(9, 'Hank Walker', 'hank.walker@example.com', '9990001111', '789 Ash St, Someville, USA'),
(10, 'Ivy Young', 'ivy.young@example.com', '2223334444', '321 Fir St, Anyburg, USA');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `book_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`order_detail_id`, `order_id`, `book_id`, `quantity`, `price`) VALUES
(1, 1, 1, 1, 19.99),
(2, 1, 3, 2, 15.99),
(3, 1, 6, 3, 21.99),
(4, 1, 1, 1, 19.99),
(5, 1, 2, 1, 19.99),
(6, 2, 3, 1, 22.99),
(7, 3, 4, 1, 18.99),
(8, 3, 5, 1, 11.99),
(9, 4, 6, 1, 21.99),
(10, 5, 7, 1, 16.99),
(11, 6, 8, 1, 25.99),
(12, 7, 9, 1, 30.99),
(13, 8, 10, 1, 12.99);

--
-- Triggers `orderdetails`
--
DELIMITER $$
CREATE TRIGGER `calculate_order_total` AFTER INSERT ON `orderdetails` FOR EACH ROW BEGIN
    DECLARE total DECIMAL(10, 2);
    

    SET total = NEW.quantity * NEW.price;
    
  
    UPDATE Orders
    SET total_amount = total_amount + total
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_stock_after_order_detail` AFTER INSERT ON `orderdetails` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `orderdetailsview`
-- (See below for the actual view)
--
CREATE TABLE `orderdetailsview` (
`order_id` int(11)
,`customer_name` varchar(255)
,`book_title` varchar(255)
,`quantity` int(11)
,`price` decimal(10,2)
,`subtotal` decimal(20,2)
,`total_amount` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`) VALUES
(1, 1, '2024-01-10', 157.92),
(2, 1, '2024-01-10', 62.97),
(3, 2, '2024-01-12', 53.97),
(4, 3, '2024-01-15', 52.97),
(5, 4, '2024-01-18', 35.98),
(6, 5, '2024-01-20', 40.98),
(7, 6, '2024-01-22', 52.98),
(8, 7, '2024-01-25', 29.98),
(9, 8, '2024-01-28', 25.99),
(10, 9, '2024-01-30', 30.99),
(11, 10, '2024-02-01', 12.99);

-- --------------------------------------------------------

--
-- Table structure for table `publishers`
--

CREATE TABLE `publishers` (
  `publisher_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publishers`
--

INSERT INTO `publishers` (`publisher_id`, `name`, `address`, `contact`) VALUES
(1, 'Penguin Random House', '1745 Broadway, New York, NY 10019, USA', 'contact@penguinrandomhouse.com'),
(2, 'HarperCollins', '195 Broadway, New York, NY 10007, USA', 'contact@harpercollins.com'),
(3, 'Simon & Schuster', '1230 Avenue of the Americas, New York, NY 10020, USA', 'contact@simonandschuster.com'),
(4, 'Hachette Livre', '58 Rue Jean Bleuzen, 92170 Vanves, France', 'contact@hachette.com'),
(5, 'Macmillan Publishers', '120 Broadway, New York, NY 10271, USA', 'contact@macmillan.com'),
(6, 'Scholastic', '557 Broadway, New York, NY 10012, USA', 'contact@scholastic.com'),
(7, 'Houghton Mifflin Harcourt', '125 High Street, Boston, MA 02110, USA', 'contact@hmhco.com'),
(8, 'Pearson', '80 Strand, London WC2R 0RL, United Kingdom', 'contact@pearson.com'),
(9, 'Wiley', '111 River Street, Hoboken, NJ 07030, USA', 'contact@wiley.com'),
(10, 'Springer', 'Tiergartenstra?e 17, 69121 Heidelberg, Germany', 'contact@springer.com');

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `quantity_available` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`stock_id`, `book_id`, `quantity_available`) VALUES
(1, 1, 99),
(2, 2, 79),
(3, 3, 149),
(4, 4, 59),
(5, 5, 119),
(6, 6, 86),
(7, 7, 109),
(8, 8, 74),
(9, 9, 84),
(10, 10, 129);

-- --------------------------------------------------------

--
-- Structure for view `orderdetailsview`
--
DROP TABLE IF EXISTS `orderdetailsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orderdetailsview`  AS SELECT `o`.`order_id` AS `order_id`, `c`.`name` AS `customer_name`, `b`.`title` AS `book_title`, `od`.`quantity` AS `quantity`, `b`.`price` AS `price`, `od`.`quantity`* `b`.`price` AS `subtotal`, `o`.`total_amount` AS `total_amount` FROM (((`orders` `o` join `customers` `c` on(`o`.`customer_id` = `c`.`customer_id`)) join `orderdetails` `od` on(`o`.`order_id` = `od`.`order_id`)) join `books` `b` on(`od`.`book_id` = `b`.`book_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `publisher_id` (`publisher_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `fk_books_stock` (`stock_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`publisher_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`stock_id`),
  ADD KEY `book_id` (`book_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `author_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `publishers`
--
ALTER TABLE `publishers`
  MODIFY `publisher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `stock_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`),
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`),
  ADD CONSTRAINT `books_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `fk_books_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`);

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
