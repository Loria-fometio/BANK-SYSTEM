-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2025 at 11:14 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `account_type` enum('savings','current') NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `account_type` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `account_number` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `first_name`, `email`, `phone`, `pincode`, `account_type`, `created_at`, `account_number`, `user_id`, `balance`) VALUES
(1, 'John Doe', 'john@example.com', '1234567890', '123456', 'Savings', '2025-03-07 23:10:27', 'ACC123', 1, 0.00),
(2, 'Jane Smith', 'jane@example.com', '0987654321', '654321', 'Current', '2025-03-07 23:10:27', 'ACC456', 1, 0.00),
(3, 'fouthe', 'Fouthe@gmail.com', '689006784', '17890', 'savings', '2025-03-08 17:36:45', 'ACC567', 2, 0.00),
(4, 'merline', 'merline@gmail.com', '677416290', '1982', 'savings', '2025-03-09 01:35:54', 'ACC346', 11, 5100.00),
(7, 'papa', 'papa@example.com', '677670047', '1979', 'savings', '2025-03-09 20:21:37', 'ACC478', 10, 6600.00),
(11, 'Grace Fongang', 'grace@gmail.com', '681201676', '02005', 'savings', '2025-03-20 14:00:30', 'ACC675', 21, 200.00),
(14, 'Jude', 'jude@example.com', '652818509', '11785', 'savings', '2025-03-21 14:10:27', 'ACC896', 24, 700.00),
(15, 'Jason', 'jason@example.com', '680367899', '2004', 'savings', '2025-03-21 23:27:56', 'ACC888', 25, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `clients_login`
--

CREATE TABLE `clients_login` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `password_reset_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients_login`
--

INSERT INTO `clients_login` (`id`, `email`, `password_hash`, `password_reset_token`, `password_reset_expires`) VALUES
(1, 'faithDjimene@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL),
(3, 'Fouthe@gmail.com', '$2y$10$y2G4E4O6zMdZoMGt5rGWVeapNxTjXUH5UgFbxci45Slhnqi6DGc6O', NULL, NULL),
(4, 'eva@example.com', '$2y$10$OWOUJ1t4alw6FFMx1vVYb.yHMK4ioVbp1z.FILS/N.yi4s4aoOWxS', NULL, NULL),
(5, 'arouan@example.com', '$2y$10$hgnphMv4HQh9vGqLwIhiquV8BH2c470pyOBMsXNDCmSYXfIA4GuSu', NULL, NULL),
(6, 'papa@example.com', '$2y$10$EETbfeHG1a6XIjU8lUDo/uts04jlAXRdGnpAT.BWj2HEIwbQkGC0S', NULL, NULL),
(7, 'merline@gmail.com', '$2y$10$KEEKApUtyl5CUVocfbEB4e1PXycAdHawePCNVAF/mtFvt2GUs6nci', NULL, NULL),
(8, 'syrielle@example.com', '$2y$10$3JzVKkBku9sglNk.y07hMuTKikiCtPLx0Nu8MYcOV/K/SYJmEZK8O', NULL, NULL),
(9, 'Lucas@example.com', '$2y$10$rdU/dKJBiumHw5rsexp5zummPjPiY2YfsZHVNOUWSWQzPxHnzQ1VG', NULL, NULL),
(10, 'chloe@gmail.com', '$2y$10$c3ZD24JgWLKwEYv4w9svFu5Z9kSLMZgq6sYFQ1ZuPKh4YpekrlC1W', NULL, NULL),
(11, 'Admin@gmail.com', '$2y$10$idKQBpJ9yZZEHximIIy.aOWIzG6JSAnhUswmjRcsCcTFC21tX232q', NULL, NULL),
(12, 'officer@example.com', '$2y$10$06mRVHpBy2iW0xQ52nfkYea4WNcsHc/EAOCLMkDGmLhlT7GqVvrga', NULL, NULL),
(13, 'Elah@example.com', '$2y$10$MzcC.F8qWpqiytdZxsDkcuYQDgP8xIW1LXXAXCxMpQc2IH6hGAZri', NULL, NULL),
(14, 'gracefongang63@gmail.com', '$2y$10$S.zFhghsIeLflflMwdasB.YLvTdtkeYgKskoU7IdORKHuAMtLSXsa', NULL, NULL),
(15, 'grace@gmail.com', '$2y$10$4Wlq6wPjhdpE9V/wJWHw7OrFogQ/axOUi6bjvCcR2HxWpjT/i5W76', NULL, NULL),
(16, 'joel@gmail.com', '$2y$10$tny6KMRl.N2xaRopJQSB1ef6OtLSJQEv0MvJ2nCyN1z9teYBTT.Bu', NULL, NULL),
(17, 'brondel@gmail.com', '$2y$10$YYw3drPqjv8EABrUIbinUe4S99JWM0nRfYtSvtoMXysNY7MIptXfu', NULL, NULL),
(18, 'jude@example.com', '$2y$10$XBsRCG7PtDot2gO5tTd8YObmCOfppMUedsDyOKsYE/WldnVLcSgTq', NULL, NULL),
(19, 'jason@example.com', '$2y$10$LasRV8IWAoP3j/.1teJ3Dusx0peU.Mybq5SvwD7QtzqgVJf3vjRze', NULL, NULL),
(20, 'rostand@example.com', '$2y$10$Y2NlkN2mWbprs2Pg0s2xFOihGErl/we0B6.zfhCDK4ybIvFQjXv3u', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_disbursements`
--

CREATE TABLE `loan_disbursements` (
  `disbursement_id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `account_number` varchar(10) NOT NULL,
  `disbursement_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','completed','failed') DEFAULT 'pending',
  `transaction_reference` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_requests`
--

CREATE TABLE `loan_requests` (
  `loan_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `loan_type` enum('personal','home','car','education') NOT NULL,
  `tenure` int(11) NOT NULL,
  `purpose` text DEFAULT NULL,
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT NULL,
  `repayment_date` date DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `amount_to_repay` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_requests`
--

INSERT INTO `loan_requests` (`loan_id`, `client_id`, `loan_amount`, `loan_type`, `tenure`, `purpose`, `requested_at`, `status`, `repayment_date`, `interest_rate`, `amount_to_repay`) VALUES
(1, 1, 10000.00, 'personal', 12, 'Education', '2025-03-07 23:10:37', 'pending', '2026-03-08', 10.00, 11000.00),
(2, 2, 5000.00, 'home', 24, 'Renovation', '2025-03-07 23:10:37', 'approved', '2027-03-08', 8.00, 5800.00),
(3, 4, 400.00, 'personal', 1, 'For food stuffs', '2025-03-10 06:46:18', 'approved', '2025-04-10', 10.00, 403.33),
(4, 4, 1000.00, 'home', 1, 'house rental', '2025-03-12 21:38:43', 'approved', '2025-04-12', 8.00, 1006.67),
(5, 7, 700.00, 'car', 1, 'For house construction', '2025-03-12 22:09:12', 'approved', '2025-04-12', 12.00, 707.00),
(6, 7, 6000.00, 'education', 5, 'To renew my car', '2025-03-12 22:22:12', 'pending', '2025-08-12', 5.00, 6125.00),
(7, 4, 400.00, 'personal', 1, 'For business management', '2025-03-13 13:26:28', 'approved', '2025-04-13', 10.00, 403.33),
(8, 4, 500.00, 'home', 1, 'House rental', '2025-03-13 13:44:05', 'approved', '2025-04-13', 8.00, 503.33),
(9, 4, 500.00, 'education', 1, 'For school furnitures', '2025-03-13 14:18:07', 'approved', '2025-04-13', 5.00, 502.08),
(10, 7, 5000.00, 'car', 1, 'Medical care', '2025-03-13 22:25:27', 'approved', '2025-04-13', 12.00, 5050.00),
(11, 7, 400.00, 'home', 1, 'For house purposes', '2025-03-13 22:43:18', 'approved', '2025-04-13', 8.00, 402.67),
(12, 7, 400.00, 'personal', 1, 'For me', '2025-03-13 22:50:34', 'approved', '2025-04-13', 10.00, 403.33),
(13, 4, 200.00, 'personal', 1, 'Pocket allowance', '2025-03-14 02:21:59', 'approved', '2025-04-14', 10.00, 201.67),
(14, 4, 100.00, 'personal', 1, 'Breakfast', '2025-03-18 05:32:23', 'approved', '2025-04-18', 10.00, 100.83),
(15, 4, 2000000.00, 'personal', 9, 'To pay university fee', '2025-03-18 21:30:31', 'rejected', NULL, NULL, NULL),
(16, 4, 600.00, 'personal', 1, 'To buy jewelres', '2025-03-20 04:38:59', 'approved', '2025-04-20', 10.00, 605.00),
(17, 4, 9999999999999.99, 'personal', 8, 'To build a house', '2025-03-20 04:39:35', 'rejected', NULL, NULL, NULL),
(18, 11, 200.00, 'personal', 1, 'for breakfast', '2025-03-20 15:07:38', 'approved', '2025-04-20', 10.00, 201.67),
(19, 12, 400.00, 'personal', 1, 'For breakfast', '2025-03-20 21:55:27', 'approved', '2025-04-20', 10.00, 403.33),
(20, 14, 700.00, 'personal', 1, 'For furnitures', '2025-03-21 14:13:21', 'approved', '2025-04-21', 10.00, 705.83),
(21, 16, 100.00, 'personal', 12, 'For travel', '2025-03-25 09:00:00', 'approved', '2026-03-25', 10.00, 110.00);

--
-- Triggers `loan_requests`
--
DELIMITER $$
CREATE TRIGGER `after_loan_approval` AFTER UPDATE ON `loan_requests` FOR EACH ROW BEGIN
    
    IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
        
        UPDATE clients
        SET balance = balance + NEW.loan_amount
        WHERE id = NEW.client_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `calculate_loan_details` BEFORE INSERT ON `loan_requests` FOR EACH ROW BEGIN
    
    IF NEW.status = 'rejected' THEN
        SET NEW.interest_rate = NULL;
        SET NEW.amount_to_repay = NULL;
        SET NEW.repayment_date = NULL;
    ELSE
        
        CASE NEW.loan_type
            WHEN 'personal' THEN SET NEW.interest_rate = 10.00;
            WHEN 'home' THEN SET NEW.interest_rate = 8.00;
            WHEN 'car' THEN SET NEW.interest_rate = 12.00;
            WHEN 'education' THEN SET NEW.interest_rate = 5.00;
            ELSE SET NEW.interest_rate = 0.00; 
        END CASE;

        
        SET NEW.amount_to_repay = NEW.loan_amount + (NEW.loan_amount * NEW.interest_rate / 100 * NEW.tenure / 12);

        
        SET NEW.repayment_date = DATE_ADD(NEW.requested_at, INTERVAL NEW.tenure MONTH);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `loan_requests_backup`
--

CREATE TABLE `loan_requests_backup` (
  `loan_id` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `loan_type` enum('personal','home','car','education') NOT NULL,
  `tenure` int(11) NOT NULL,
  `purpose` text DEFAULT NULL,
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT NULL,
  `repayment_date` date DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `amount_to_repay` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_requests_backup`
--

INSERT INTO `loan_requests_backup` (`loan_id`, `client_id`, `loan_amount`, `loan_type`, `tenure`, `purpose`, `requested_at`, `status`, `repayment_date`, `interest_rate`, `amount_to_repay`) VALUES
(1, 1, 10000.00, 'personal', 12, 'Education', '2025-03-07 23:10:37', 'pending', '2026-03-08', 10.00, 11000.00),
(2, 2, 5000.00, 'home', 24, 'Renovation', '2025-03-07 23:10:37', 'approved', '2027-03-08', 8.00, 5800.00),
(3, 4, 400.00, 'personal', 1, 'For food stuffs', '2025-03-10 06:46:18', 'approved', '2025-04-10', 10.00, 403.33),
(4, 4, 1000.00, 'home', 1, 'house rental', '2025-03-12 21:38:43', 'approved', '2025-04-12', 8.00, 1006.67),
(5, 7, 700.00, 'car', 1, 'For house construction', '2025-03-12 22:09:12', 'approved', '2025-04-12', 12.00, 707.00),
(6, 7, 6000.00, 'education', 5, 'To renew my car', '2025-03-12 22:22:12', 'pending', '2025-08-12', 5.00, 6125.00),
(7, 4, 400.00, 'personal', 1, 'For business management', '2025-03-13 13:26:28', 'approved', '2025-04-13', 10.00, 403.33),
(8, 4, 500.00, 'home', 1, 'House rental', '2025-03-13 13:44:05', 'approved', '2025-04-13', 8.00, 503.33),
(9, 4, 500.00, 'education', 1, 'For school furnitures', '2025-03-13 14:18:07', 'approved', '2025-04-13', 5.00, 502.08),
(10, 7, 5000.00, 'car', 1, 'Medical care', '2025-03-13 22:25:27', 'approved', '2025-04-13', 12.00, 5050.00),
(11, 7, 400.00, 'home', 1, 'For house purposes', '2025-03-13 22:43:18', 'approved', '2025-04-13', 8.00, 402.67),
(12, 7, 400.00, 'personal', 1, 'For me', '2025-03-13 22:50:34', 'approved', '2025-04-13', 10.00, 403.33),
(13, 4, 200.00, 'personal', 1, 'Pocket allowance', '2025-03-14 02:21:59', 'approved', '2025-04-14', 10.00, 201.67),
(14, 4, 100.00, 'personal', 1, 'Breakfast', '2025-03-18 05:32:23', 'approved', '2025-04-18', 10.00, 100.83),
(15, 4, 2000000.00, 'personal', 9, 'To pay university fee', '2025-03-18 21:30:31', 'rejected', '2025-12-18', 10.00, 2150000.00),
(16, 4, 600.00, 'personal', 1, 'To buy jewelres', '2025-03-20 04:38:59', 'approved', '2025-04-20', 10.00, 605.00),
(17, 4, 9999999999999.99, 'personal', 8, 'To build a house', '2025-03-20 04:39:35', 'rejected', '2025-11-20', 10.00, 9999999999999.99),
(18, 11, 200.00, 'personal', 1, 'for breakfast', '2025-03-20 15:07:38', 'approved', '2025-04-20', 10.00, 201.67),
(19, 12, 400.00, 'personal', 1, 'For breakfast', '2025-03-20 21:55:27', 'approved', '2025-04-20', 10.00, 403.33),
(20, 14, 700.00, 'personal', 1, 'For furnitures', '2025-03-21 14:13:21', 'approved', '2025-04-21', 10.00, 705.83),
(21, 16, 100.00, 'personal', 12, 'For travel', '2025-03-25 09:00:00', 'approved', '2026-03-25', 10.00, 110.00);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` varchar(20) NOT NULL DEFAULT 'general',
  `loan_request_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `client_id`, `message`, `sent_at`, `type`, `loan_request_id`) VALUES
(1, 3, 'You have an account now. welcome in our company nice meeting you', '2025-02-28 22:17:01', 'general', NULL),
(2, 1, 'hello your account have been created successsfully', '2025-02-28 23:04:22', 'general', NULL),
(3, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-10 06:46:19', 'general', NULL),
(4, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-12 21:38:43', 'general', NULL),
(5, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-12 21:38:43', 'general', NULL),
(6, 7, 'Dear papa, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-12 22:09:12', 'general', NULL),
(7, 7, 'You received a loan request from papa (Account No: ACC478).', '2025-03-12 22:09:13', 'general', NULL),
(8, 7, 'Dear papa, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-12 22:22:13', 'general', NULL),
(9, 7, 'You received a loan request from papa (Account No: ACC478).', '2025-03-12 22:22:13', 'general', NULL),
(10, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-13 13:26:28', 'general', NULL),
(11, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-13 13:26:28', 'general', NULL),
(12, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-13 13:44:06', 'general', NULL),
(13, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-13 13:44:06', 'general', NULL),
(14, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-13 14:18:07', 'general', NULL),
(15, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-13 14:18:07', 'general', NULL),
(16, 7, 'Dear papa, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-13 22:25:28', 'general', NULL),
(17, 7, 'You received a loan request from papa (Account No: ACC478).', '2025-03-13 22:25:28', 'general', NULL),
(18, 7, 'Dear papa, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-13 22:43:19', 'general', NULL),
(19, 7, 'You received a loan request from papa (Account No: ACC478).', '2025-03-13 22:43:19', 'general', NULL),
(20, 7, 'Dear papa, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-13 22:50:34', 'general', NULL),
(21, 7, 'You received a loan request from papa (Account No: ACC478).', '2025-03-13 22:50:35', 'general', NULL),
(22, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-14 02:21:59', 'general', NULL),
(23, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-14 02:22:00', 'general', NULL),
(24, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-18 05:32:23', 'general', NULL),
(25, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-18 05:32:23', 'general', NULL),
(26, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-18 21:30:31', 'general', NULL),
(27, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-18 21:30:32', 'general', NULL),
(28, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-20 04:38:59', 'general', NULL),
(29, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-20 04:38:59', 'general', NULL),
(30, 4, 'Dear merline, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-20 04:39:35', 'general', NULL),
(31, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-20 04:39:35', 'general', NULL),
(32, 11, 'Dear Grace Fongang, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-20 15:07:38', 'general', NULL),
(33, 11, 'You received a loan request from Grace Fongang (Account No: ACC675).', '2025-03-20 15:07:38', 'general', NULL),
(34, 12, 'Dear Monsieur Godwin, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-20 21:55:27', 'general', NULL),
(35, 12, 'You received a loan request from Monsieur Godwin (Account No: ACC460).', '2025-03-20 21:55:27', 'general', NULL),
(36, 14, 'Dear Jude, your loan request has been submitted successfully. We will review your request and notify you of the status shortly.', '2025-03-21 14:13:21', 'general', NULL),
(37, 14, 'You received a loan request from Jude (Account No: ACC896).', '2025-03-21 14:13:21', 'general', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('deposit','withdrawal','transfer') NOT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `receiver_account_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `account_number`, `amount`, `transaction_type`, `date`, `description`, `created_at`, `receiver_account_number`) VALUES
(2, 1, 'ACC346', 600.00, 'transfer', '2025-03-09', 'for constructions', '2025-03-09 21:40:51', 'ACC456'),
(3, 1, 'ACC346', 700.00, 'deposit', '2025-03-09', 'for savings', '2025-03-09 21:44:37', ''),
(4, 1, 'ACC346', 500.00, 'deposit', '2025-03-09', 'for savings', '2025-03-09 21:57:18', ''),
(5, 1, 'ACC346', 400.00, 'deposit', '2025-03-10', 'for pocket allowance', '2025-03-10 05:57:51', ''),
(6, 1, 'ACC789', 500.00, 'deposit', '2025-03-10', 'for buying fod stuffs\r\n', '2025-03-10 15:38:23', ''),
(8, 11, 'ACC346', 700.00, 'deposit', '2025-03-12', 'for food', '2025-03-12 00:09:17', ''),
(9, 11, 'ACC346', 200.00, 'withdrawal', '2025-03-12', 'for transport', '2025-03-12 00:10:11', ''),
(10, 11, 'ACC346', 100.00, 'transfer', '2025-03-13', 'For help', '2025-03-13 07:00:33', 'ACC478'),
(12, 1, 'ACC346', 15000.00, 'deposit', '2025-03-19', 'large deposit', '2025-03-19 00:16:05', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_type` varchar(50) DEFAULT 'client'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `created_at`, `user_type`) VALUES
(1, 'FOMETIO GLORIA', 'gloriafometio2@gmail.com', '$2y$10$MM76nVktTGzoZaKKTHFuwOdkJT8XP0x9/UqehOSTkUs3Ud44OtjbC', '2025-03-08 15:52:53', 'client'),
(2, 'fouthe', 'Fouthe@gmail.com', '$2y$10$0y/Av9es3hV/WRheXnfA9OhvQnVEzGk8FyIhArAgmrhTnBL3LZ0hi', '2025-03-08 16:06:10', 'client'),
(5, 'merline lontsie', 'merline@example.com', '$2y$10$q7f0KgiKO2XpydgNY0y6xOal1kB8pWKZakqN5CoKvTkPBC24e8PSa', '2025-03-09 00:10:36', 'client'),
(10, 'papa', 'papa@example.com', '$2y$10$EETbfeHG1a6XIjU8lUDo/uts04jlAXRdGnpAT.BWj2HEIwbQkGC0S', '2025-03-09 00:49:22', 'client'),
(11, 'merline lontsie', 'merline@gmail.com', '$2y$10$KEEKApUtyl5CUVocfbEB4e1PXycAdHawePCNVAF/mtFvt2GUs6nci', '2025-03-09 01:28:22', 'client'),
(12, 'Syrielle lutresse', 'syrielle@example.com', '$2y$10$3JzVKkBku9sglNk.y07hMuTKikiCtPLx0Nu8MYcOV/K/SYJmEZK8O', '2025-03-09 14:18:43', 'client'),
(15, 'LUCAS', 'Lucas@example.com', '$2y$10$rdU/dKJBiumHw5rsexp5zummPjPiY2YfsZHVNOUWSWQzPxHnzQ1VG', '2025-03-09 14:22:46', 'client'),
(16, 'Chloe', 'chloe@gmail.com', '$2y$10$c3ZD24JgWLKwEYv4w9svFu5Z9kSLMZgq6sYFQ1ZuPKh4YpekrlC1W', '2025-03-12 14:14:59', 'client'),
(17, 'Gloria', 'Admin@gmail.com', '$2y$10$idKQBpJ9yZZEHximIIy.aOWIzG6JSAnhUswmjRcsCcTFC21tX232q', '2025-03-17 21:28:28', 'client'),
(18, 'Officer', 'officer@example.com', '$2y$10$06mRVHpBy2iW0xQ52nfkYea4WNcsHc/EAOCLMkDGmLhlT7GqVvrga', '2025-03-17 21:28:54', 'client'),
(19, 'Elah satsa', 'Elah@example.com', '$2y$10$lj6zC0JFAgz1dLK6pp9s0.DYT4Cxqj/GX/Ls6So.WhJViBKcZMv/O', '2025-03-18 14:16:35', 'client'),
(20, 'Grace Fongang', 'gracefongang63@gmail.com', '$2y$10$S.zFhghsIeLflflMwdasB.YLvTdtkeYgKskoU7IdORKHuAMtLSXsa', '2025-03-20 13:49:47', 'client'),
(21, 'Grace fongang', 'grace@gmail.com', '$2y$10$4Wlq6wPjhdpE9V/wJWHw7OrFogQ/axOUi6bjvCcR2HxWpjT/i5W76', '2025-03-20 13:58:07', 'client'),
(22, 'Joel', 'joel@gmail.com', '$2y$10$tny6KMRl.N2xaRopJQSB1ef6OtLSJQEv0MvJ2nCyN1z9teYBTT.Bu', '2025-03-20 15:35:15', 'client'),
(23, 'Monsieur Godwin', 'brondel@gmail.com', '$2y$10$YYw3drPqjv8EABrUIbinUe4S99JWM0nRfYtSvtoMXysNY7MIptXfu', '2025-03-20 21:51:55', 'client'),
(24, 'Jude', 'jude@example.com', '$2y$10$hc3XvxF0PINrftGsAa/GzetuB/s4X//npaQ7FikBCI1Wadkwk1cMi', '2025-03-21 14:06:06', 'client'),
(25, 'Jason', 'jason@example.com', '$2y$10$KV78dzcrDquHF/RhLGuEtepU.w4zgh1xinoyRyvfi4ueZUKvhhK2.', '2025-03-21 23:12:29', 'client'),
(26, 'Rostand', 'rostand@example.com', '$2y$10$Y2NlkN2mWbprs2Pg0s2xFOihGErl/we0B6.zfhCDK4ybIvFQjXv3u', '2025-03-22 00:21:51', 'client');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `fk_clients_users` (`user_id`);

--
-- Indexes for table `clients_login`
--
ALTER TABLE `clients_login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `loan_disbursements`
--
ALTER TABLE `loan_disbursements`
  ADD PRIMARY KEY (`disbursement_id`),
  ADD KEY `loan_id` (`loan_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `fk_loan_disbursements_user` (`user_id`);

--
-- Indexes for table `loan_requests`
--
ALTER TABLE `loan_requests`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `fk_loan_request` (`loan_request_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `clients_login`
--
ALTER TABLE `clients_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `loan_disbursements`
--
ALTER TABLE `loan_disbursements`
  MODIFY `disbursement_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan_requests`
--
ALTER TABLE `loan_requests`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `fk_clients_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `loan_disbursements`
--
ALTER TABLE `loan_disbursements`
  ADD CONSTRAINT `fk_loan_disbursements_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `loan_disbursements_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan_requests` (`loan_id`),
  ADD CONSTRAINT `loan_disbursements_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_loan_request` FOREIGN KEY (`loan_request_id`) REFERENCES `loan_requests` (`loan_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
