-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 06, 2026 at 03:12 AM
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
-- Database: `databaseadmin`
--

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `movie_id`, `created_at`) VALUES
(40, 41, 1242501, '2026-01-22 14:59:54'),
(41, 41, 1306368, '2026-01-22 15:00:07'),
(42, 41, 1242898, '2026-01-22 15:54:02'),
(43, 54, 1168190, '2026-02-03 14:09:30'),
(45, 54, 803796, '2026-02-04 23:14:46'),
(48, 54, 83533, '2026-02-06 03:43:39'),
(49, 54, 1368166, '2026-02-06 03:46:09'),
(50, 54, 575264, '2026-02-06 03:47:28'),
(54, 54, 1198994, '2026-02-06 05:00:20'),
(55, 54, 1454741, '2026-02-06 05:00:23'),
(56, 54, 1116201, '2026-02-06 05:00:25'),
(69, 54, 1233413, '2026-02-06 05:52:20'),
(70, 56, 1168190, '2026-02-06 05:55:50'),
(71, 56, 1084242, '2026-02-06 05:55:57'),
(72, 54, 693134, '2026-02-06 06:16:23'),
(73, 54, 1271895, '2026-02-06 06:18:47'),
(77, 54, 1242898, '2026-02-06 06:31:26'),
(78, 54, 840464, '2026-02-06 06:31:38'),
(79, 54, 840464, '2026-02-06 06:32:26'),
(80, 54, 1084242, '2026-02-06 06:32:43'),
(103, 55, 912649, '2026-02-06 07:32:06'),
(104, 55, 980477, '2026-02-06 07:32:25'),
(107, 55, 263115, '2026-02-06 08:47:49'),
(108, 55, 458156, '2026-02-06 08:47:50');

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

CREATE TABLE `gender` (
  `id` int(3) NOT NULL,
  `sex` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`id`, `sex`) VALUES
(1, 'male'),
(2, 'female'),
(3, 'other');

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `id` int(11) NOT NULL,
  `tmdb_movie_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movie_genre`
--

CREATE TABLE `movie_genre` (
  `id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_genre`
--

INSERT INTO `movie_genre` (`id`, `movie_id`, `genre_id`, `created_at`) VALUES
(1, 1242501, 12, '2026-02-06 04:42:12'),
(2, 1242501, 18, '2026-02-06 04:42:12'),
(3, 1306368, 27, '2026-02-06 04:42:12'),
(4, 1306368, 53, '2026-02-06 04:42:12'),
(5, 1242898, 18, '2026-02-06 04:42:12'),
(6, 1084242, 16, '2026-02-06 06:28:30'),
(7, 1084242, 35, '2026-02-06 06:28:30'),
(8, 1084242, 12, '2026-02-06 06:28:30'),
(9, 1084242, 10751, '2026-02-06 06:28:30'),
(10, 1084242, 9648, '2026-02-06 06:28:30'),
(11, 1084242, 16, '2026-02-06 06:28:33'),
(12, 1084242, 35, '2026-02-06 06:28:33'),
(13, 1084242, 12, '2026-02-06 06:28:33'),
(14, 1084242, 10751, '2026-02-06 06:28:33'),
(15, 1084242, 9648, '2026-02-06 06:28:33'),
(16, 1084242, 16, '2026-02-06 06:30:40'),
(17, 1084242, 35, '2026-02-06 06:30:40'),
(18, 1084242, 12, '2026-02-06 06:30:40'),
(19, 1084242, 10751, '2026-02-06 06:30:40'),
(20, 1084242, 9648, '2026-02-06 06:30:40'),
(21, 9502, 16, '2026-02-06 06:46:58'),
(22, 9502, 10751, '2026-02-06 06:46:58'),
(23, 9502, 35, '2026-02-06 06:46:58'),
(24, 9502, 28, '2026-02-06 06:46:58'),
(25, 1234821, 878, '2026-02-06 06:53:02'),
(26, 1234821, 12, '2026-02-06 06:53:02'),
(27, 1234821, 28, '2026-02-06 06:53:02'),
(28, 24428, 878, '2026-02-06 06:53:54'),
(29, 24428, 28, '2026-02-06 06:53:54'),
(30, 24428, 12, '2026-02-06 06:53:54'),
(31, 1020696, 27, '2026-02-06 06:54:09'),
(32, 1020696, 53, '2026-02-06 06:54:09'),
(33, 31022, 27, '2026-02-06 06:54:11'),
(34, 31022, 80, '2026-02-06 06:54:11'),
(35, 396535, 27, '2026-02-06 06:54:20'),
(36, 396535, 53, '2026-02-06 06:54:20'),
(37, 396535, 28, '2026-02-06 06:54:20'),
(38, 396535, 12, '2026-02-06 06:54:20'),
(39, 28734, 27, '2026-02-06 06:54:24'),
(40, 28734, 28, '2026-02-06 06:54:24'),
(41, 28734, 18, '2026-02-06 06:54:24'),
(42, 28734, 53, '2026-02-06 06:54:24'),
(43, 176, 27, '2026-02-06 07:03:25'),
(44, 176, 9648, '2026-02-06 07:03:25'),
(45, 176, 80, '2026-02-06 07:03:25'),
(46, 1217602, 28, '2026-02-06 07:07:02'),
(47, 1217602, 80, '2026-02-06 07:07:02'),
(48, 1217602, 35, '2026-02-06 07:07:02'),
(49, 1217602, 53, '2026-02-06 07:07:02'),
(50, 1116201, 27, '2026-02-06 07:09:23'),
(51, 1116201, 878, '2026-02-06 07:09:23'),
(52, 1601243, 28, '2026-02-06 07:14:00'),
(53, 1601243, 80, '2026-02-06 07:14:00'),
(54, 1601243, 53, '2026-02-06 07:14:00'),
(55, 1930, 28, '2026-02-06 07:14:51'),
(56, 1930, 12, '2026-02-06 07:14:51'),
(57, 1930, 878, '2026-02-06 07:14:51'),
(58, 507086, 12, '2026-02-06 07:15:15'),
(59, 507086, 28, '2026-02-06 07:15:15'),
(60, 507086, 878, '2026-02-06 07:15:15'),
(61, 1601243, 28, '2026-02-06 07:15:25'),
(62, 1601243, 80, '2026-02-06 07:15:25'),
(63, 1601243, 53, '2026-02-06 07:15:25'),
(64, 155, 28, '2026-02-06 07:18:52'),
(65, 155, 80, '2026-02-06 07:18:52'),
(66, 155, 53, '2026-02-06 07:18:52'),
(67, 1271895, 28, '2026-02-06 07:28:34'),
(68, 1271895, 80, '2026-02-06 07:28:34'),
(69, 1271895, 10749, '2026-02-06 07:28:34'),
(70, 1168190, 28, '2026-02-06 07:28:38'),
(71, 1168190, 35, '2026-02-06 07:28:38'),
(72, 1168190, 80, '2026-02-06 07:28:38'),
(73, 1419406, 28, '2026-02-06 07:28:39'),
(74, 1419406, 80, '2026-02-06 07:28:39'),
(75, 1419406, 18, '2026-02-06 07:28:39'),
(76, 1419406, 53, '2026-02-06 07:28:39'),
(77, 1168190, 28, '2026-02-06 07:29:00'),
(78, 1168190, 35, '2026-02-06 07:29:00'),
(79, 1168190, 80, '2026-02-06 07:29:00'),
(80, 1168190, 28, '2026-02-06 07:29:55'),
(81, 1168190, 35, '2026-02-06 07:29:55'),
(82, 1168190, 80, '2026-02-06 07:29:55'),
(83, 299534, 12, '2026-02-06 07:31:32'),
(84, 299534, 878, '2026-02-06 07:31:32'),
(85, 299534, 28, '2026-02-06 07:31:33'),
(86, 912649, 28, '2026-02-06 07:32:06'),
(87, 912649, 878, '2026-02-06 07:32:06'),
(88, 912649, 12, '2026-02-06 07:32:06'),
(89, 980477, 16, '2026-02-06 07:32:25'),
(90, 980477, 14, '2026-02-06 07:32:25'),
(91, 980477, 12, '2026-02-06 07:32:25'),
(92, 980477, 28, '2026-02-06 07:32:25'),
(93, 263115, 28, '2026-02-06 08:47:49'),
(94, 263115, 18, '2026-02-06 08:47:49'),
(95, 263115, 878, '2026-02-06 08:47:49'),
(96, 458156, 28, '2026-02-06 08:47:51'),
(97, 458156, 53, '2026-02-06 08:47:51'),
(98, 458156, 80, '2026-02-06 08:47:51');

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `tmdb_genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`id`, `name`, `tmdb_genre_id`) VALUES
(1, 'Action', 28),
(2, 'Drama', 18),
(3, 'Comedy', 35),
(4, 'Horror', 27),
(5, 'Romance', 10749),
(6, 'Sci-Fi', 878),
(7, 'Fantasy', 14),
(8, 'Documentary', 99),
(9, 'Thriller', 53),
(10, 'Crime', 80),
(11, 'Adventure', 12),
(12, 'Animation', 16);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin','','') NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  `image` varchar(500) DEFAULT NULL,
  `gender` int(3) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `reset_otp` varchar(6) DEFAULT NULL,
  `reset_expires` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role`, `status`, `created_at`, `updated_at`, `image`, `gender`, `birthdate`, `age`, `reset_otp`, `reset_expires`) VALUES
(41, 'test1', 'test1@gmail.com', '$2b$10$WALRl3P4ZTWpV1Pe89GrsOCpgUWLv63wqCjAXUwfnHyeSgwBYnd7G', 'user', 1, '2025-12-21 16:27:52', '2025-12-21 16:27:52', NULL, 2, NULL, NULL, NULL, NULL),
(45, 'Peam', 'chisanupong-sr@rmutp.ac.th', '$2b$10$EeDs21fzsTv8LmXoWEKQEOP3rai0eGqWKRjY5pM61n06jTnCjmb5.', 'user', 1, '2026-01-14 11:32:36', '2026-01-14 11:32:36', NULL, 1, NULL, NULL, NULL, NULL),
(50, 'supanida', 'jankhiawsupanida@gmail.com', '$2b$10$p9.w1vsufiOYvb4cbr4BoeEJa0Zgj2pkx/p1BukiHH7z1BfeBoNDC', 'user', 1, '2026-01-19 14:01:00', '2026-01-19 14:01:00', NULL, 3, '2004-03-06', 21, NULL, NULL),
(52, '44', '55', '$2b$10$9aStuZdfgNfyZql.XpWy3eJsJOkQCqtB0U2wGXY0oJW.fTXb2TKyy', 'user', 1, '2026-01-20 13:24:33', '2026-01-20 13:24:33', NULL, 3, '2009-02-03', 16, NULL, NULL),
(53, 'test8', 'test8@gmail.com', '$2b$10$5GHEUO.LWTD3DddlSpa4Buiid./9MwI7q2abXVtziL5qliZHpk4WW', 'user', 1, '2026-01-28 16:15:35', '2026-01-28 16:15:35', NULL, 3, '2007-01-10', 19, NULL, NULL),
(54, 'test5', 'test5@gmail.com', '$2b$10$a8MeQ7X8ancqWo1s4RFOtuaN3G1kYSGIM3JGqHU1LrGfOTobmDM8.', 'user', 1, '2026-01-28 16:18:13', '2026-01-28 16:18:13', '/uploads/user-54-1770208723122.png', 1, '2010-02-03', 15, NULL, NULL),
(55, 'test6', 'test6@gmail.com', '$2b$10$RHwMuB5YgxM571QSIIEgreTCF74d9Ulrq5TZ9hGjfNCGnew1Z63h2', 'user', 1, '2026-02-05 13:20:47', '2026-02-05 13:20:47', NULL, 1, '0000-00-00', 19, NULL, NULL),
(56, 'test7', 'test7@gmail.com', '$2b$10$Ai/O3kvhc4XqYn6lEoYw3etOLrB.8./mYu0F81luWBvT5TZevhuT2', 'user', 1, '2026-02-06 05:53:19', '2026-02-06 05:53:19', NULL, 1, '0000-00-00', 17, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_movie_activity`
--

CREATE TABLE `user_movie_activity` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `action` enum('view','like') NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_tags`
--

CREATE TABLE `user_tags` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_tags`
--

INSERT INTO `user_tags` (`id`, `user_id`, `tag_id`, `created_at`) VALUES
(34, 45, 6, '2026-01-14 04:32:42'),
(35, 45, 9, '2026-01-14 04:32:42'),
(36, 45, 12, '2026-01-14 04:32:42'),
(49, 50, 2, '2026-01-19 07:01:06'),
(50, 50, 5, '2026-01-19 07:01:06'),
(51, 50, 8, '2026-01-19 07:01:06'),
(100, 41, 1, '2026-01-19 08:19:12'),
(101, 41, 8, '2026-01-19 08:19:12'),
(102, 41, 2, '2026-01-19 08:19:12'),
(106, 52, 2, '2026-01-20 06:50:48'),
(107, 52, 3, '2026-01-20 06:50:48'),
(108, 52, 11, '2026-01-20 06:50:48'),
(208, 55, 1, '2026-02-05 06:21:05'),
(209, 55, 4, '2026-02-05 06:21:05'),
(210, 55, 9, '2026-02-05 06:21:05'),
(211, 54, 1, '2026-02-05 17:49:52'),
(212, 54, 9, '2026-02-05 17:49:52'),
(213, 54, 6, '2026-02-05 17:49:52'),
(214, 56, 12, '2026-02-05 22:53:24'),
(215, 56, 11, '2026-02-05 22:53:24'),
(216, 56, 1, '2026-02-05 22:53:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movie_genre`
--
ALTER TABLE `movie_genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_ibfk_1` (`gender`);

--
-- Indexes for table `user_movie_activity`
--
ALTER TABLE `user_movie_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_tags`
--
ALTER TABLE `user_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_tag` (`user_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movie_genre`
--
ALTER TABLE `movie_genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `user_movie_activity`
--
ALTER TABLE `user_movie_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_tags`
--
ALTER TABLE `user_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`gender`) REFERENCES `gender` (`id`);

--
-- Constraints for table `user_movie_activity`
--
ALTER TABLE `user_movie_activity`
  ADD CONSTRAINT `user_movie_activity_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_tags`
--
ALTER TABLE `user_tags`
  ADD CONSTRAINT `user_tags_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
