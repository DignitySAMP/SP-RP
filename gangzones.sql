-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.11.0-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table fearandrespect.gangzones
CREATE TABLE IF NOT EXISTS `gangzones` (
  `gz_sqlid` int(11) NOT NULL AUTO_INCREMENT,
  `gz_min_x` float NOT NULL,
  `gz_min_y` float NOT NULL,
  `gz_max_x` float NOT NULL,
  `gz_max_y` float NOT NULL,
  `gz_faction` int(11) NOT NULL,
  `gz_contested` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gz_sqlid`)
) ENGINE=InnoDB AUTO_INCREMENT=836 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table fearandrespect.gangzones: ~834 rows (approximately)
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(1, 0, 0, 0, 0, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(2, 2485, -1676.5, 2549, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(3, 2037, -1676.5, 2101, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(4, 2421, -1676.5, 2485, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(5, 2101, -1676.5, 2165, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(6, 2165, -1676.5, 2229, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(7, 2229, -1676.5, 2293, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(8, 2293, -1676.5, 2357, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(9, 2357, -1676.5, 2421, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(10, 2485, -1804.5, 2549, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(11, 2037, -1740.5, 2101, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(12, 2101, -1740.5, 2165, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(13, 2165, -1740.5, 2229, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(14, 2229, -1740.5, 2293, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(15, 2293, -1740.5, 2357, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(16, 2357, -1740.5, 2421, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(17, 2421, -1740.5, 2485, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(18, 2421, -1868.5, 2485, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(19, 2037, -1804.5, 2101, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(20, 2101, -1804.5, 2165, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(21, 2165, -1804.5, 2229, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(22, 2229, -1804.5, 2293, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(23, 2293, -1804.5, 2357, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(24, 2357, -1804.5, 2421, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(25, 2421, -1804.5, 2485, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(26, 2485, -1868.5, 2549, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(27, 2421, -1932.5, 2485, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(28, 2485, -1996.5, 2549, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(29, 2485, -1932.5, 2549, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(30, 2037, -1868.5, 2101, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(31, 2101, -1868.5, 2165, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(32, 2165, -1868.5, 2229, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(33, 2229, -1868.5, 2293, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(34, 2293, -1868.5, 2357, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(35, 2357, -1868.5, 2421, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(36, 2037, -1932.5, 2101, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(37, 2101, -1932.5, 2165, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(38, 2165, -1932.5, 2229, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(39, 2229, -1932.5, 2293, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(40, 2293, -1932.5, 2357, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(41, 2357, -1932.5, 2421, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(42, 2037, -1996.5, 2101, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(43, 2101, -1996.5, 2165, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(44, 2165, -1996.5, 2229, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(45, 2229, -1996.5, 2293, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(46, 2293, -1996.5, 2357, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(47, 2357, -1996.5, 2421, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(48, 2421, -1996.5, 2485, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(49, 2624, -2041.5, 2688, -1977.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(50, 2688, -2041.5, 2752, -1977.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(51, 2752, -2041.5, 2816, -1977.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(52, 2624, -1849.5, 2852, -1657.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(53, 2752, -1913.5, 2816, -1849.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(54, 2688, -1913.5, 2752, -1849.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(55, 2624, -1913.5, 2688, -1849.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(56, 2752, -1977.5, 2816, -1913.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(57, 2688, -1977.5, 2752, -1913.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(58, 2624, -1977.5, 2688, -1913.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(59, 2037, -2060.5, 2101, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(60, 2485, -2060.5, 2549, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(61, 2421, -2060.5, 2485, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(62, 2357, -2060.5, 2421, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(63, 2293, -2188.5, 2357, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(64, 2293, -2124.5, 2357, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(65, 2293, -2060.5, 2357, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(66, 2229, -2188.5, 2293, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(67, 2229, -2124.5, 2293, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(68, 2229, -2060.5, 2293, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(69, 2165, -2188.5, 2229, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(70, 2165, -2124.5, 2229, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(71, 2165, -2060.5, 2229, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(72, 2101, -2188.5, 2165, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(73, 2101, -2124.5, 2165, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(74, 2101, -2060.5, 2165, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(75, 2037, -2188.5, 2101, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(76, 2037, -2124.5, 2101, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(77, 2485, -2188.5, 2549, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(78, 2421, -2188.5, 2485, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(79, 2485, -2124.5, 2549, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(80, 2421, -2124.5, 2485, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(81, 2357, -2188.5, 2421, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(82, 2357, -2124.5, 2421, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(83, 1909, -1740.5, 1973, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(84, 1909, -1676.5, 1973, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(85, 1973, -1740.5, 2037, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(86, 1973, -1676.5, 2037, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(87, 1845, -1612.5, 1929, -1523.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(88, 1973, -1996.5, 2037, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(89, 1909, -1996.5, 1973, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(90, 1909, -1932.5, 1973, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(91, 1973, -1932.5, 2037, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(92, 1973, -1868.5, 2037, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(93, 1973, -1804.5, 2037, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(94, 1909, -1868.5, 1973, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(95, 1909, -1804.5, 1973, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(96, 1845, -2124.5, 1909, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(97, 1845, -2188.5, 1909, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(98, 1909, -2188.5, 1973, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(99, 1973, -2188.5, 2037, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(100, 1973, -2124.5, 2037, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(101, 1909, -2124.5, 1973, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(102, 1909, -2060.5, 1973, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(103, 1973, -2060.5, 2037, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(104, 1717, -2124.5, 1781, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(105, 1781, -2124.5, 1845, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(106, 1781, -2188.5, 1845, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(107, 1845, -1676.5, 1909, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(108, 1845, -1740.5, 1909, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(109, 1845, -1804.5, 1909, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(110, 1845, -1868.5, 1909, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(111, 1845, -1932.5, 1909, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(112, 1845, -1996.5, 1909, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(113, 1845, -2060.5, 1909, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(114, 1781, -2060.5, 1845, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(115, 1717, -2060.5, 1781, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(116, 1653, -2060.5, 1717, -1996.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(117, 1717, -2188.5, 1781, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(118, 1653, -2188.5, 1717, -2124.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(119, 1653, -2124.5, 1717, -2060.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(120, 1781, -1868.5, 1845, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(121, 1781, -1804.5, 1845, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(122, 1717, -1804.5, 1781, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(123, 1781, -1740.5, 1845, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(124, 1717, -1740.5, 1781, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(125, 1717, -1676.5, 1781, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(126, 1781, -1676.5, 1845, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(127, 1589, -1804.5, 1653, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(128, 1589, -1868.5, 1653, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(129, 1653, -1676.5, 1717, -1612.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(130, 1653, -1740.5, 1717, -1676.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(131, 1653, -1804.5, 1717, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(132, 1653, -1868.5, 1717, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(133, 1717, -1868.5, 1781, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(134, 1717, -1932.5, 1781, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(135, 1653, -1932.5, 1717, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(136, 1589, -1932.5, 1653, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(137, 1525, -1932.5, 1589, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(138, 1525, -1868.5, 1589, -1804.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(139, 1525, -1804.5, 1589, -1740.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(140, 1781, -1932.5, 1845, -1868.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(141, 1781, -1996.5, 1845, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(142, 1717, -1996.5, 1781, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(143, 1653, -1996.5, 1717, -1932.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(144, 2752, -2105.5, 2816, -2041.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(145, 2688, -2105.5, 2752, -2041.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(146, 2688, -2169.5, 2752, -2105.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(147, 2624, -2169.5, 2688, -2105.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(148, 2624, -2105.5, 2688, -2041.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(149, 2752, -2169.5, 2816, -2105.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(150, 2549, -2078.5, 2624, -2026.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(151, 2549, -1959.5, 2624, -1907.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(152, 2549, -1763.5, 2624, -1711.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(153, 1929, -1612.5, 2013, -1523.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(154, 2013, -1612.5, 2097, -1523.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(155, 2097, -1612.5, 2199, -1545.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(156, 2101, -2252.5, 2165, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(157, 2229, -2380.5, 2293, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(158, 2229, -2316.5, 2293, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(159, 2229, -2252.5, 2293, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(160, 2165, -2380.5, 2229, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(161, 2165, -2316.5, 2229, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(162, 2165, -2252.5, 2229, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(163, 2101, -2380.5, 2165, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(164, 2101, -2316.5, 2165, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(165, 2293, -2252.5, 2357, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(166, 2293, -2316.5, 2357, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(167, 2293, -2380.5, 2357, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(168, 2229, -2700.5, 2293, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(169, 2229, -2636.5, 2293, -2572.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(170, 2229, -2572.5, 2293, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(171, 2229, -2508.5, 2293, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(172, 2229, -2444.5, 2293, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(173, 2101, -2700.5, 2165, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(174, 2165, -2700.5, 2229, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(175, 2165, -2636.5, 2229, -2572.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(176, 2165, -2572.5, 2229, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(177, 2165, -2508.5, 2229, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(178, 2165, -2444.5, 2229, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(179, 2421, -2316.5, 2485, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(180, 2485, -2252.5, 2549, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(181, 2421, -2252.5, 2485, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(182, 2357, -2380.5, 2421, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(183, 2357, -2316.5, 2421, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(184, 2357, -2252.5, 2421, -2188.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(185, 2549, -2380.5, 2613, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(186, 2741, -2297.5, 2805, -2233.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(187, 2677, -2297.5, 2741, -2233.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(188, 2613, -2297.5, 2677, -2233.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(189, 2549, -2297.5, 2613, -2233.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(190, 2741, -2233.5, 2805, -2169.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(191, 2677, -2233.5, 2741, -2169.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(192, 2613, -2233.5, 2677, -2169.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(193, 2549, -2234.5, 2613, -2170.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(194, 2485, -2380.5, 2549, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(195, 2421, -2380.5, 2485, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(196, 2485, -2316.5, 2549, -2252.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(197, 2613, -2444.5, 2677, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(198, 2677, -2444.5, 2741, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(199, 2741, -2444.5, 2805, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(200, 2805, -2444.5, 2869, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(201, 2805, -2380.5, 2869, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(202, 2741, -2380.5, 2805, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(203, 2677, -2380.5, 2741, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(204, 2613, -2380.5, 2677, -2316.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(205, 2741, -2572.5, 2805, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(206, 2805, -2572.5, 2869, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(207, 2805, -2508.5, 2869, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(208, 2741, -2508.5, 2805, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(209, 2677, -2508.5, 2741, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(210, 2613, -2508.5, 2677, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(211, 2549, -2508.5, 2613, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(212, 2485, -2508.5, 2549, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(213, 2421, -2508.5, 2485, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(214, 2357, -2508.5, 2421, -2444.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(215, 2357, -2444.5, 2421, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(216, 2421, -2444.5, 2485, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(217, 2485, -2444.5, 2549, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(218, 2549, -2444.5, 2613, -2380.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(219, 2357, -2572.5, 2421, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(220, 2663, -2572.5, 2741, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(221, 2421, -2700.5, 2485, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(222, 2357, -2700.5, 2421, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(223, 2485, -2636.5, 2549, -2572.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(224, 2421, -2636.5, 2485, -2572.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(225, 2357, -2636.5, 2421, -2572.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(226, 2485, -2573.5, 2569, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(227, 2421, -2572.5, 2485, -2508.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(228, 2485, -2700.5, 2549, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(229, 2293, -2700.5, 2357, -2636.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(230, 1717, -1436.5, 1781, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(231, 1717, -1372.5, 1781, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(232, 1845, -1372.5, 1909, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(233, 1845, -1436.5, 1909, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(234, 1781, -1436.5, 1845, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(235, 1781, -1308.5, 1845, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(236, 1781, -1244.5, 1845, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(237, 1781, -1180.5, 1845, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(238, 1781, -1116.5, 1845, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(239, 1717, -1116.5, 1781, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(240, 1717, -1180.5, 1781, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(241, 1717, -1244.5, 1781, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(242, 1717, -1308.5, 1781, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(243, 1973, -1244.5, 2037, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(244, 1781, -1372.5, 1845, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(245, 1973, -1308.5, 2037, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(246, 1973, -1372.5, 2037, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(247, 1973, -1436.5, 2037, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(248, 1909, -1436.5, 1973, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(249, 1909, -1372.5, 1973, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(250, 1909, -1308.5, 1973, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(251, 1909, -1244.5, 1973, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(252, 1909, -1180.5, 1973, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(253, 1909, -1116.5, 1973, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(254, 1845, -1116.5, 1909, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(255, 1845, -1180.5, 1909, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(256, 1845, -1244.5, 1909, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(257, 1845, -1308.5, 1909, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(258, 2037, -1116.5, 2101, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(259, 1973, -1116.5, 2037, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(260, 2037, -1180.5, 2101, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(261, 1973, -1180.5, 2037, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(262, 2037, -1244.5, 2101, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(263, 2037, -1308.5, 2101, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(264, 2037, -1372.5, 2101, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(265, 2037, -1436.5, 2101, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(266, 2037, -1500.5, 2101, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(267, 1973, -1500.5, 2037, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(268, 1909, -1500.5, 1973, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(269, 1845, -1500.5, 1909, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(270, 1781, -1500.5, 1845, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(271, 2101, -1116.5, 2165, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(272, 2101, -1052.5, 2165, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(273, 2101, -988.5, 2165, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(274, 2037, -988.5, 2101, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(275, 2037, -1052.5, 2101, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(276, 1973, -1052.5, 2037, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(277, 1973, -988.5, 2037, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(278, 1909, -988.5, 1973, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(279, 1909, -1052.5, 1973, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(280, 2165, -1436.5, 2229, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(281, 2229, -1372.5, 2293, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(282, 2165, -1372.5, 2229, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(283, 2229, -1308.5, 2293, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(284, 2165, -1308.5, 2229, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(285, 2229, -1244.5, 2293, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(286, 2165, -1244.5, 2229, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(287, 2229, -1180.5, 2293, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(288, 2165, -1180.5, 2229, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(289, 2229, -1116.5, 2293, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(290, 2229, -1052.5, 2293, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(291, 2165, -988.5, 2229, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(292, 2165, -1052.5, 2229, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(293, 2165, -1116.5, 2229, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(294, 2101, -1500.5, 2165, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(295, 2101, -1436.5, 2165, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(296, 2101, -1372.5, 2165, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(297, 2101, -1308.5, 2165, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(298, 2101, -1244.5, 2165, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(299, 2101, -1180.5, 2165, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(300, 2229, -1436.5, 2293, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(301, 2229, -1500.5, 2293, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(302, 2165, -1500.5, 2229, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(303, 2167, -1531.5, 2229, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(304, 2293, -1500.5, 2357, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(305, 2293, -1564.5, 2357, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(306, 2229, -1564.5, 2293, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(307, 2357, -1564.5, 2421, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(308, 2421, -1564.5, 2485, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(309, 2485, -1564.5, 2549, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(310, 2549, -1564.5, 2613, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(311, 2549, -1500.5, 2613, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(312, 2485, -1500.5, 2549, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(313, 2421, -1500.5, 2485, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(314, 2357, -1500.5, 2421, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(315, 2357, -1436.5, 2421, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(316, 2357, -1372.5, 2421, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(317, 2357, -1308.5, 2421, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(318, 2357, -1244.5, 2421, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(319, 2357, -1180.5, 2421, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(320, 2357, -1116.5, 2421, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(321, 2357, -1052.5, 2421, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(322, 2293, -1052.5, 2357, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(323, 2293, -1116.5, 2357, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(324, 2293, -1180.5, 2357, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(325, 2293, -1244.5, 2357, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(326, 2293, -1308.5, 2357, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(327, 2293, -1372.5, 2357, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(328, 2293, -1436.5, 2357, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(329, 2421, -1436.5, 2485, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(330, 2485, -1436.5, 2549, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(331, 2549, -1436.5, 2613, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(332, 2613, -1436.5, 2677, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(333, 2613, -1372.5, 2677, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(334, 2549, -1372.5, 2613, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(335, 2485, -1372.5, 2549, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(336, 2421, -1372.5, 2485, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(337, 2421, -1308.5, 2485, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(338, 2421, -1244.5, 2485, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(339, 2421, -1180.5, 2485, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(340, 2421, -1116.5, 2485, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(341, 2421, -1052.5, 2485, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(342, 2357, -988.5, 2421, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(343, 2421, -988.5, 2485, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(344, 2485, -988.5, 2549, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(345, 2549, -988.5, 2613, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(346, 2613, -988.5, 2677, -924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(347, 2613, -1052.5, 2677, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(348, 2549, -1052.5, 2613, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(349, 2485, -1052.5, 2549, -988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(350, 2485, -1116.5, 2549, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(351, 2485, -1180.5, 2549, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(352, 2485, -1244.5, 2549, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(353, 2485, -1308.5, 2549, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(354, 2549, -1308.5, 2613, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(355, 2613, -1308.5, 2677, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(356, 2613, -1244.5, 2677, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(357, 2613, -1180.5, 2677, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(358, 2613, -1116.5, 2677, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(359, 2549, -1116.5, 2613, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(360, 2549, -1180.5, 2613, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(361, 2549, -1244.5, 2613, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(362, 2677, -1244.5, 2741, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(363, 2677, -1180.5, 2741, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(364, 2677, -1116.5, 2741, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(365, 2741, -1116.5, 2805, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(366, 2805, -1116.5, 2869, -1052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(367, 2805, -1180.5, 2869, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(368, 2741, -1180.5, 2805, -1116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(369, 2741, -1244.5, 2805, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(370, 2805, -1244.5, 2869, -1180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(371, 2805, -1308.5, 2869, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(372, 2741, -1308.5, 2805, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(373, 2677, -1308.5, 2741, -1244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(374, 2677, -1372.5, 2741, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(375, 2677, -1436.5, 2741, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(376, 2741, -1436.5, 2805, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(377, 2741, -1372.5, 2805, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(378, 2805, -1372.5, 2869, -1308.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(379, 2805, -1436.5, 2869, -1372.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(380, 2805, -1500.5, 2869, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(381, 2741, -1500.5, 2805, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(382, 2677, -1500.5, 2741, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(383, 2613, -1500.5, 2677, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(384, 2613, -1564.5, 2677, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(385, 2677, -1564.5, 2741, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(386, 2741, -1564.5, 2805, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(387, 2805, -1564.5, 2869, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(388, 2805, -1628.5, 2869, -1564.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(389, 2741, -1628.5, 2805, -1564.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(390, 2677, -1628.5, 2741, -1564.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(391, 2613, -1628.5, 2677, -1564.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(392, 2613, -1657.5, 2869, -1628.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(393, 1055, -1924.5, 1119, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(394, 1119, -1924.5, 1183, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(395, 1183, -1924.5, 1247, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(396, 1247, -1924.5, 1311, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(397, 1311, -1924.5, 1375, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(398, 1375, -1924.5, 1439, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(399, 1439, -1924.5, 1503, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(400, 1439, -1988.5, 1503, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(401, 1439, -2052.5, 1503, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(402, 1439, -2116.5, 1503, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(403, 1375, -2116.5, 1439, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(404, 1247, -2052.5, 1311, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(405, 1247, -1988.5, 1311, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(406, 1311, -1988.5, 1375, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(407, 1311, -2052.5, 1375, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(408, 1311, -2116.5, 1375, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(409, 1375, -1988.5, 1439, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(410, 1375, -2052.5, 1439, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(411, 1247, -2116.5, 1311, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(412, 1183, -2116.5, 1247, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(413, 1183, -2052.5, 1247, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(414, 1183, -1988.5, 1247, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(415, 1119, -1988.5, 1183, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(416, 1055, -1988.5, 1119, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(417, 1183, -2180.5, 1247, -2116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(418, 1183, -2244.5, 1247, -2180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(419, 1183, -2308.5, 1247, -2244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(420, 1119, -2308.5, 1183, -2244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(421, 1055, -2308.5, 1119, -2244.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(422, 1055, -2244.5, 1119, -2180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(423, 991, -2244.5, 1055, -2180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(424, 991, -2180.5, 1055, -2116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(425, 991, -2116.5, 1055, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(426, 1055, -2116.5, 1119, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(427, 1055, -2180.5, 1119, -2116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(428, 1119, -2180.5, 1183, -2116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(429, 1119, -2244.5, 1183, -2180.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(430, 1119, -2116.5, 1183, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(431, 1119, -2052.5, 1183, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(432, 1055, -2052.5, 1119, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(433, 1247, -2180.5, 1311, -2116.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(434, 1311, -1860.5, 1375, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(435, 1311, -1796.5, 1375, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(436, 1375, -1796.5, 1439, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(437, 1375, -1860.5, 1439, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(438, 1247, -1796.5, 1311, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(439, 1247, -1860.5, 1311, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(440, 1311, -1732.5, 1375, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(441, 1311, -1668.5, 1375, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(442, 1311, -1604.5, 1375, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(443, 1311, -1540.5, 1375, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(444, 1247, -1540.5, 1311, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(445, 1247, -1604.5, 1311, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(446, 1247, -1668.5, 1311, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(447, 1247, -1732.5, 1311, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(448, 1183, -1732.5, 1247, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(449, 1119, -1732.5, 1183, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(450, 1055, -1732.5, 1119, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(451, 991, -1732.5, 1055, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(452, 991, -1796.5, 1055, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(453, 991, -1860.5, 1055, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(454, 1055, -1860.5, 1119, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(455, 1119, -1860.5, 1183, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(456, 1183, -1860.5, 1247, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(457, 1183, -1796.5, 1247, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(458, 1119, -1796.5, 1183, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(459, 1055, -1796.5, 1119, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(460, 991, -1668.5, 1055, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(461, 991, -1604.5, 1055, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(462, 991, -1540.5, 1055, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(463, 1055, -1540.5, 1119, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(464, 1119, -1540.5, 1183, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(465, 1183, -1540.5, 1247, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(466, 1183, -1604.5, 1247, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(467, 1119, -1604.5, 1183, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(468, 1055, -1604.5, 1119, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(469, 1055, -1668.5, 1119, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(470, 1119, -1668.5, 1183, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(471, 1183, -1668.5, 1247, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(472, 1311, -1476.5, 1375, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(473, 1247, -1476.5, 1311, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(474, 1183, -1476.5, 1247, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(475, 1119, -1476.5, 1183, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(476, 1055, -1476.5, 1119, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(477, 991, -1476.5, 1055, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(478, 991, -1412.5, 1055, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(479, 991, -1348.5, 1055, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(480, 991, -1284.5, 1055, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(481, 991, -1220.5, 1055, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(482, 991, -1156.5, 1055, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(483, 1055, -1156.5, 1119, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(484, 1119, -1156.5, 1183, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(485, 1183, -1156.5, 1247, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(486, 1247, -1156.5, 1311, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(487, 1247, -1220.5, 1311, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(488, 1247, -1284.5, 1311, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(489, 1247, -1348.5, 1311, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(490, 1247, -1412.5, 1311, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(491, 1183, -1412.5, 1247, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(492, 1119, -1412.5, 1183, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(493, 1055, -1412.5, 1119, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(494, 1055, -1348.5, 1119, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(495, 1055, -1284.5, 1119, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(496, 1055, -1220.5, 1119, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(497, 1119, -1220.5, 1183, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(498, 1183, -1220.5, 1247, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(499, 1183, -1284.5, 1247, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(500, 1119, -1284.5, 1183, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(501, 1119, -1348.5, 1183, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(502, 1183, -1348.5, 1247, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(503, 1311, -1412.5, 1375, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(504, 1375, -1412.5, 1439, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(505, 1375, -1476.5, 1439, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(506, 1439, -1476.5, 1503, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(507, 1439, -1412.5, 1503, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(508, 1503, -1412.5, 1567, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(509, 1503, -1476.5, 1567, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(510, 1567, -1476.5, 1631, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(511, 1567, -1412.5, 1631, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(512, 1567, -1348.5, 1631, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(513, 1631, -1348.5, 1695, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(514, 1631, -1412.5, 1695, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(515, 1631, -1476.5, 1695, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(516, 1567, -1540.5, 1631, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(517, 1503, -1540.5, 1567, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(518, 1439, -1540.5, 1503, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(519, 1439, -1604.5, 1503, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(520, 1503, -1604.5, 1567, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(521, 1567, -1604.5, 1631, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(522, 1631, -1604.5, 1695, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(523, 1695, -1564.5, 1759, -1500.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(524, 1695, -1500.5, 1759, -1436.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(525, 1631, -1540.5, 1695, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(526, 1695, -1604.5, 1759, -1564.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(527, 1503, -1348.5, 1567, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(528, 1439, -1348.5, 1503, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(529, 1375, -1348.5, 1439, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(530, 1375, -1284.5, 1439, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(531, 1439, -1284.5, 1503, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(532, 1311, -1348.5, 1375, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(533, 1311, -1284.5, 1375, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(534, 1311, -1220.5, 1375, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(535, 1311, -1156.5, 1375, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(536, 1375, -1156.5, 1439, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(537, 1439, -1156.5, 1503, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(538, 1503, -1156.5, 1567, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(539, 1375, -1220.5, 1439, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(540, 1439, -1220.5, 1503, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(541, 1503, -1220.5, 1567, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(542, 1567, -1220.5, 1631, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(543, 1631, -1220.5, 1695, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(544, 1631, -1284.5, 1695, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(545, 1567, -1284.5, 1631, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(546, 1503, -1284.5, 1567, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(547, 1503, -1092.5, 1567, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(548, 1439, -1092.5, 1503, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(549, 1375, -1092.5, 1439, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(550, 1311, -1092.5, 1375, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(551, 1247, -1092.5, 1311, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(552, 1183, -1092.5, 1247, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(553, 1119, -1092.5, 1183, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(554, 1055, -1092.5, 1119, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(555, 991, -1092.5, 1055, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(556, 991, -1028.5, 1055, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(557, 1055, -1028.5, 1119, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(558, 1119, -1028.5, 1183, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(559, 1183, -1028.5, 1247, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(560, 1247, -1028.5, 1311, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(561, 1311, -1028.5, 1375, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(562, 1375, -1028.5, 1439, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(563, 1439, -1028.5, 1503, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(564, 1439, -964.5, 1503, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(565, 1439, -1796.5, 1503, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(566, 1439, -1860.5, 1503, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(567, 1439, -900.5, 1503, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(568, 1439, -836.5, 1503, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(569, 1503, -836.5, 1567, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(570, 1503, -900.5, 1567, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(571, 1503, -772.5, 1567, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(572, 1439, -772.5, 1503, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(573, 1439, -708.5, 1503, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(574, 1503, -708.5, 1567, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(575, 1439, -644.5, 1503, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(576, 1375, -644.5, 1439, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(577, 1311, -644.5, 1375, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(578, 1247, -644.5, 1311, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(579, 1326, -580.5, 1414, -542.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(580, 1311, -708.5, 1375, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(581, 1375, -708.5, 1439, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(582, 1183, -644.5, 1247, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(583, 1119, -644.5, 1183, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(584, 1055, -644.5, 1119, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(585, 1119, -708.5, 1183, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(586, 1055, -708.5, 1119, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(587, 991, -708.5, 1055, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(588, 927, -708.5, 991, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(589, 863, -708.5, 927, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(590, 1119, -772.5, 1183, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(591, 1119, -836.5, 1183, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(592, 1055, -836.5, 1119, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(593, 991, -836.5, 1055, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(594, 927, -836.5, 991, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(595, 1055, -772.5, 1119, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(596, 991, -772.5, 1055, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(597, 927, -772.5, 991, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(598, 991, -644.5, 1055, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(599, 927, -644.5, 991, -580.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(600, 863, -772.5, 927, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(601, 863, -836.5, 927, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(602, 799, -836.5, 863, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(603, 799, -772.5, 863, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(604, 799, -708.5, 863, -644.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(605, 735, -772.5, 799, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(606, 735, -836.5, 799, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(607, 735, -900.5, 799, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(608, 799, -900.5, 863, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(609, 863, -900.5, 927, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(610, 927, -900.5, 991, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(611, 991, -900.5, 1055, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(612, 1055, -900.5, 1119, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(613, 1119, -900.5, 1183, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(614, 1119, -964.5, 1183, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(615, 1055, -964.5, 1119, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(616, 991, -964.5, 1055, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(617, 927, -964.5, 991, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(618, 863, -964.5, 927, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(619, 799, -964.5, 863, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(620, 1183, -836.5, 1247, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(621, 1247, -836.5, 1311, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(622, 1311, -836.5, 1375, -772.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(623, 1247, -772.5, 1311, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(624, 1183, -772.5, 1247, -708.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(625, 1183, -900.5, 1247, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(626, 1247, -900.5, 1311, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(627, 1311, -900.5, 1375, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(628, 1311, -964.5, 1375, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(629, 1247, -964.5, 1311, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(630, 1183, -964.5, 1247, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(631, 1375, -964.5, 1439, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(632, 1375, -900.5, 1439, -836.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(633, 927, -1860.5, 991, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(634, 927, -1924.5, 991, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(635, 863, -1924.5, 927, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(636, 799, -1924.5, 863, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(637, 799, -1988.5, 863, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(638, 799, -2052.5, 863, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(639, 799, -2116.5, 863, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(640, 799, -1860.5, 863, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(641, 863, -1860.5, 927, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(642, 735, -1860.5, 799, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(643, 671, -1860.5, 735, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(644, 607, -1860.5, 671, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(645, 543, -1860.5, 607, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(646, 479, -1860.5, 543, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(647, 415, -1860.5, 479, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(648, 351, -1860.5, 415, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(649, 351, -1924.5, 415, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(650, 415, -1924.5, 479, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(651, 479, -1924.5, 543, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(652, 543, -1924.5, 607, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(653, 607, -1924.5, 671, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(654, 671, -1924.5, 735, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(655, 735, -1924.5, 799, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(656, 351, -1988.5, 415, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(657, 351, -2052.5, 415, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(658, 351, -2116.5, 415, -2052.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(659, 287, -1924.5, 351, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(660, 223, -1924.5, 287, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(661, 159, -1924.5, 223, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(662, 95, -1924.5, 159, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(663, 95, -1988.5, 159, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(664, 159, -1988.5, 223, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(665, 95, -1860.5, 159, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(666, 159, -1860.5, 223, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(667, 223, -1860.5, 287, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(668, 287, -1860.5, 351, -1796.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(669, 95, -1796.5, 159, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(670, 159, -1796.5, 223, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(671, 223, -1796.5, 287, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(672, 287, -1796.5, 351, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(673, 351, -1796.5, 415, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(674, 415, -1796.5, 479, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(675, 479, -1796.5, 543, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(676, 543, -1796.5, 607, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(677, 607, -1796.5, 671, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(678, 671, -1796.5, 735, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(679, 735, -1796.5, 799, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(680, 799, -1796.5, 863, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(681, 799, -1732.5, 863, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(682, 799, -1668.5, 863, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(683, 799, -1604.5, 863, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(684, 735, -1604.5, 799, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(685, 671, -1604.5, 735, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(686, 607, -1604.5, 671, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(687, 607, -1668.5, 671, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(688, 607, -1732.5, 671, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(689, 671, -1732.5, 735, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(690, 671, -1668.5, 735, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(691, 735, -1668.5, 799, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(692, 735, -1732.5, 799, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(693, 863, -1796.5, 927, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(694, 927, -1796.5, 991, -1732.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(695, 927, -1732.5, 991, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(696, 863, -1732.5, 927, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(697, 863, -1668.5, 927, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(698, 863, -1604.5, 927, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(699, 927, -1604.5, 991, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(700, 927, -1668.5, 991, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(701, 927, -1540.5, 991, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(702, 927, -1476.5, 991, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(703, 863, -1476.5, 927, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(704, 863, -1540.5, 927, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(705, 799, -1540.5, 863, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(706, 799, -1476.5, 863, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(707, 735, -1476.5, 799, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(708, 671, -1476.5, 735, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(709, 607, -1476.5, 671, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(710, 607, -1540.5, 671, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(711, 671, -1540.5, 735, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(712, 735, -1540.5, 799, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(713, 543, -1540.5, 607, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(714, 543, -1604.5, 607, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(715, 543, -1668.5, 607, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(716, 543, -1732.5, 607, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(717, 415, -1668.5, 479, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(718, 479, -1668.5, 543, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(719, 351, -1668.5, 415, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(720, 287, -1668.5, 351, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(721, 351, -1732.5, 415, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(722, 415, -1732.5, 479, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(723, 479, -1732.5, 543, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(724, 287, -1732.5, 351, -1668.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(725, 223, -1668.5, 287, -1604.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(726, 223, -1604.5, 287, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(727, 287, -1604.5, 351, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(728, 351, -1604.5, 415, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(729, 415, -1604.5, 479, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(730, 479, -1604.5, 543, -1540.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(731, 479, -1540.5, 543, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(732, 415, -1540.5, 479, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(733, 351, -1540.5, 415, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(734, 287, -1540.5, 351, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(735, 223, -1540.5, 287, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(736, 223, -1476.5, 287, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(737, 287, -1476.5, 351, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(738, 351, -1476.5, 415, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(739, 415, -1476.5, 479, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(740, 479, -1476.5, 543, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(741, 543, -1476.5, 607, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(742, 159, -1476.5, 223, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(743, 95, -1476.5, 159, -1412.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(744, 95, -1540.5, 159, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(745, 159, -1540.5, 223, -1476.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(746, 95, -1412.5, 159, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(747, 95, -1348.5, 159, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(748, 159, -1348.5, 223, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(749, 159, -1412.5, 223, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(750, 223, -1412.5, 287, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(751, 223, -1348.5, 287, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(752, 287, -1348.5, 351, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(753, 287, -1412.5, 351, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(754, 351, -1348.5, 415, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(755, 351, -1284.5, 415, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(756, 415, -1284.5, 479, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(757, 415, -1348.5, 479, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(758, 479, -1284.5, 543, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(759, 479, -1348.5, 543, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(760, 543, -1348.5, 607, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(761, 607, -1348.5, 671, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(762, 607, -1412.5, 671, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(763, 543, -1412.5, 607, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(764, 479, -1412.5, 543, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(765, 415, -1412.5, 479, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(766, 351, -1412.5, 415, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(767, 159, -1284.5, 223, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(768, 159, -1220.5, 223, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(769, 223, -1220.5, 287, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(770, 287, -1220.5, 351, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(771, 287, -1284.5, 351, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(772, 223, -1284.5, 287, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(773, 223, -1156.5, 287, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(774, 287, -1156.5, 351, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(775, 351, -1156.5, 415, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(776, 415, -1156.5, 479, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(777, 479, -1156.5, 543, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(778, 543, -1156.5, 607, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(779, 607, -1156.5, 671, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(780, 607, -1220.5, 671, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(781, 607, -1284.5, 671, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(782, 543, -1284.5, 607, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(783, 543, -1220.5, 607, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(784, 479, -1220.5, 543, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(785, 415, -1220.5, 479, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(786, 351, -1220.5, 415, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(787, 543, -1092.5, 607, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(788, 479, -1092.5, 543, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(789, 415, -1092.5, 479, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(790, 351, -1092.5, 415, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(791, 607, -1092.5, 671, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(792, 607, -1028.5, 671, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(793, 671, -1028.5, 735, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(794, 735, -1028.5, 799, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(795, 735, -964.5, 799, -900.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(796, 735, -1092.5, 799, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(797, 735, -1156.5, 799, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(798, 735, -1220.5, 799, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(799, 735, -1284.5, 799, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(800, 735, -1348.5, 799, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(801, 735, -1412.5, 799, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(802, 671, -1412.5, 735, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(803, 671, -1348.5, 735, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(804, 671, -1284.5, 735, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(805, 671, -1220.5, 735, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(806, 671, -1156.5, 735, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(807, 671, -1092.5, 735, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(808, 799, -1092.5, 863, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(809, 863, -1092.5, 927, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(810, 927, -1092.5, 991, -1028.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(811, 927, -1028.5, 991, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(812, 863, -1028.5, 927, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(813, 799, -1028.5, 863, -964.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(814, 799, -1156.5, 863, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(815, 863, -1156.5, 927, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(816, 927, -1156.5, 991, -1092.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(817, 927, -1220.5, 991, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(818, 927, -1284.5, 991, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(819, 927, -1348.5, 991, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(820, 927, -1412.5, 991, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(821, 863, -1412.5, 927, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(822, 799, -1412.5, 863, -1348.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(823, 863, -1348.5, 927, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(824, 863, -1284.5, 927, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(825, 863, -1220.5, 927, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(826, 799, -1220.5, 863, -1156.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(827, 799, -1284.5, 863, -1220.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(828, 799, -1348.5, 863, -1284.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(829, 991, -1924.5, 1055, -1860.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(830, 991, -1988.5, 1055, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(831, 991, -2052.5, 1055, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(832, 927, -2052.5, 991, -1988.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(833, 927, -1988.5, 991, -1924.5, -1, 0);
INSERT INTO `gangzones` (`gz_sqlid`, `gz_min_x`, `gz_min_y`, `gz_max_x`, `gz_max_y`, `gz_faction`, `gz_contested`) VALUES
	(835, 2485, -1740.5, 2549, -1676.5, -1, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
