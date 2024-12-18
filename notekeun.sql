-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2024 at 03:53 PM
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
-- Database: `notekeun`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `audio_path` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `description`, `category`, `image_path`, `audio_path`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Catatan Pertama', 'Deskripsi catatan pertama', 'Personal', 'sfhsj', 'skgsk', '2024-12-16 23:20:49', '2024-12-16 23:55:02', NULL),
(2, 'Catatan Kedua', 'Deskripsi catatan kedua', 'Work', NULL, NULL, '2024-12-16 23:20:49', '2024-12-18 07:29:42', '2024-12-18 07:29:42'),
(3, 'Catatan Ketiga', 'Deskripsi catatan ketiga', 'Study', NULL, NULL, '2024-12-16 23:20:49', '2024-12-18 04:39:21', '2024-12-18 04:39:21'),
(4, 'Catatan Baru', 'Deskripsi catatan baru', 'Work', 'http://example.com/image.jpg', NULL, '2024-12-18 04:55:02', '2024-12-18 07:41:30', '2024-12-18 07:41:30'),
(5, 'Catatan Diperbarui', 'Deskripsi yang telah diperbarui.', 'Work', 'http://example.com/new-image.jpg', NULL, '2024-12-18 05:09:15', '2024-12-18 05:16:17', '2024-12-18 05:16:17'),
(6, 'Catatan Diperbarui', 'Deskripsi yang diperbarui.', 'Personal', 'http://example.com/new-image.jpg', 'http://example.com/new-audio.mp3', '2024-12-18 06:11:40', '2024-12-18 06:44:30', '2024-12-18 06:44:30'),
(7, 'Catatan Diperbarui', 'Deskripsi catatan yang diperbarui', 'Personal', 'http://example.com/new-image.jpg', 'http://example.com/new-audio.mp3', '2024-12-18 09:57:18', '2024-12-18 10:10:19', '2024-12-18 10:10:19'),
(8, 'Catatan Diperbarui', 'Deskripsi catatan yang diperbarui', 'Personal', 'http://example.com/new-image.jpg', 'http://example.com/new-audio.mp3', '2024-12-18 11:25:21', '2024-12-18 11:25:48', '2024-12-18 11:25:48'),
(9, 'IQBAL GANTENG', 'Deskripsi catatan yang diperbarui', 'Personal', 'http://example.com/new-image.jpg', 'http://example.com/new-audio.mp3', '2024-12-18 11:27:24', '2024-12-18 11:27:53', '2024-12-18 11:27:53'),
(10, 'IQBAL GANTENG', 'Penulis artikel adalah orang atau individu yang bertindak dalam mengarang sebuah tulisan, menggabungkan beberapa kata menjadi kalimat yang menarik dan enak dibaca sehingga membuat pembaca dapat mengetahui apa yang tidak mereka ketahui sebelumnya. Sebuah artikel berasal dari pengalaman seseorang, imajinasi, pengetahuan umum atau penelitian ilmiah.', 'Personal', 'null', 'null', '2024-12-18 13:06:22', '2024-12-18 14:00:23', '2024-12-18 14:00:23'),
(11, 'IQBAL GANTENyehhrgrrurty5utyuG', 'Penulis artikel adalah orang atau individu yang bertindak dalam mengarang sebuah tulisan, menggabungkan beberapa kata menjadi kalimat yang menarik dan enak dibaca sehingga membuat pembaca dapat mengetahui apa yang tidak mereka ketahui sebelumnya. Sebuah artikel berasal dari pengalaman seseorang, imajinasi, pengetahuan umum atau penelitian ilmiah.', 'Personal', 'null', 'null', '2024-12-18 13:59:35', '2024-12-18 13:59:35', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
