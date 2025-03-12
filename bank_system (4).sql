-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2025 at 01:19 AM
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
(4, 'merline', 'merline@gmail.com', '677416290', '1982', 'savings', '2025-03-09 01:35:54', 'ACC346', 11, 500.00),
(7, 'papa', 'papa@example.com', '677670047', '1979', 'savings', '2025-03-09 20:21:37', 'ACC478', 10, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `clients_login`
--

CREATE TABLE `clients_login` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients_login`
--

INSERT INTO `clients_login` (`id`, `email`, `password_hash`) VALUES
(1, 'faithDjimene@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'),
(3, 'Fouthe@gmail.com', '$2y$10$/rlO5ykqF3UlOssn4WocC.N5YbzVF8j7gfuM7n5wETK8e4L.TYEPm'),
(4, 'eva@example.com', '$2y$10$DQOOEC7U2NS1hkJTToPFaOCkc5pIoNsFLix25im0lv3v5xSZpH67q'),
(5, 'arouan@example.com', '$2y$10$hgnphMv4HQh9vGqLwIhiquV8BH2c470pyOBMsXNDCmSYXfIA4GuSu'),
(6, 'papa@example.com', '$2y$10$EETbfeHG1a6XIjU8lUDo/uts04jlAXRdGnpAT.BWj2HEIwbQkGC0S'),
(7, 'merline@gmail.com', '$2y$10$KEEKApUtyl5CUVocfbEB4e1PXycAdHawePCNVAF/mtFvt2GUs6nci'),
(8, 'syrielle@example.com', '$2y$10$3JzVKkBku9sglNk.y07hMuTKikiCtPLx0Nu8MYcOV/K/SYJmEZK8O'),
(9, 'Lucas@example.com', '$2y$10$rdU/dKJBiumHw5rsexp5zummPjPiY2YfsZHVNOUWSWQzPxHnzQ1VG');

-- --------------------------------------------------------

--
-- Table structure for table `loan_requests`
--

CREATE TABLE `loan_requests` (
  `loan_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `loan_amount` decimal(15,2) NOT NULL,
  `loan_type` varchar(50) NOT NULL,
  `tenure` int(11) NOT NULL,
  `purpose` text DEFAULT NULL,
  `requested_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_requests`
--

INSERT INTO `loan_requests` (`loan_id`, `client_id`, `loan_amount`, `loan_type`, `tenure`, `purpose`, `requested_at`, `status`) VALUES
(1, 1, 10000.00, 'Personal', 12, 'Education', '2025-03-07 23:10:37', 'pending'),
(2, 2, 5000.00, 'Home', 24, 'Renovation', '2025-03-07 23:10:37', 'approved'),
(3, 4, 400.00, '0', 1, 'For food stuffs', '2025-03-10 06:46:18', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `client_id`, `message`, `sent_at`) VALUES
(1, 3, 'You have an account now. welcome in our company nice meeting you', '2025-02-28 22:17:01'),
(2, 1, 'hello your account have been created successsfully', '2025-02-28 23:04:22'),
(3, 4, 'You received a loan request from merline (Account No: ACC346).', '2025-03-10 06:46:19');

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
(9, 11, 'ACC346', 200.00, 'withdrawal', '2025-03-12', 'for transport', '2025-03-12 00:10:11', '');

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
(15, 'LUCAS', 'Lucas@example.com', '$2y$10$rdU/dKJBiumHw5rsexp5zummPjPiY2YfsZHVNOUWSWQzPxHnzQ1VG', '2025-03-09 14:22:46', 'client');

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
  ADD KEY `client_id` (`client_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `clients_login`
--
ALTER TABLE `clients_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `loan_requests`
--
ALTER TABLE `loan_requests`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
