-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Лип 22 2015 р., 19:48
-- Версія сервера: 5.5.44-0ubuntu0.14.04.1
-- Версія PHP: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База даних: `oblenergo`
--

-- --------------------------------------------------------

--
-- Структура таблиці `docs`
--

CREATE TABLE IF NOT EXISTS `docs` (
  `id` int(25) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `path` varchar(250) NOT NULL,
  `valid` int(1) NOT NULL,
  `date` varchar(25) NOT NULL,
  `clientId` varchar(250) NOT NULL,
  `uploader` varchar(250) NOT NULL,
  `parentId` int(25) NOT NULL,
  `size` int(50) NOT NULL,
  `viewNum` int(25) NOT NULL,
  `type` varchar(250) NOT NULL,
  `keywords` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;

--
-- Дамп даних таблиці `docs`
--

INSERT INTO `docs` (`id`, `title`, `path`, `valid`, `date`, `clientId`, `uploader`, `parentId`, `size`, `viewNum`, `type`, `keywords`) VALUES
(1, 'pdf 1', 'files/1.pdf', 1, '22.10.2015', 'qwerty15', 'Alex', 5, 1233431, 0, 'deoc', ''),
(2, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(3, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'lorem ipsum', 'Alex', 3, 1233431, 0, 'deoc', ''),
(4, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'test', 'Alex', 5, 1233431, 0, 'deoc', ''),
(5, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'abc12', 'Alex', 5, 1233431, 0, 'deoc', ''),
(6, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'qwerty', 'Alex', 5, 1233431, 0, 'deoc', ''),
(7, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'lorem ipsum', 'Alex', 5, 1233431, 0, 'deoc', ''),
(8, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'test', 'Alex', 3, 1233431, 0, 'deoc', ''),
(9, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'test test', 'Alex', 3, 1233431, 0, 'deoc', ''),
(10, 'txt 2', 'files/2.txt', 1, '22.10.2015', 'qwerty 1234513', 'Alex', 3, 1233431, 0, 'deoc', ''),
(11, 'txt 3', 'files/3.txt', 1, '22.10.2015', 'abc12', 'Alex', 3, 1233431, 0, 'deoc', ''),
(12, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'test test test', 'Alex', 1, 1233431, 0, 'deoc', ''),
(13, 'image 2', 'files/2.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(14, 'image 3', 'files/3.jpg', 1, '22.10.2015', 'ghjkl', 'Alex', 1, 1233431, 0, 'deoc', ''),
(15, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(16, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 2, 1233431, 0, 'deoc', ''),
(17, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'abc12', 'Alex', 2, 1233431, 0, 'deoc', ''),
(18, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'test', 'Alex', 6, 1233431, 0, 'deoc', ''),
(19, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 6, 1233431, 0, 'deoc', ''),
(20, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'lorem ipsum', 'Alex', 5, 1233431, 0, 'deoc', ''),
(21, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'test', 'Alex', 5, 1233431, 0, 'deoc', ''),
(22, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'test', 'Alex', 3, 1233431, 0, 'deoc', ''),
(23, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(24, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'lorem ipsum', 'Alex', 3, 1233431, 0, 'deoc', ''),
(25, 'image 2', 'files/2.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(26, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(27, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'test test test', 'Alex', 1, 1233431, 0, 'deoc', ''),
(28, 'image 2', 'files/2.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', ''),
(29, 'image 3', 'files/3.jpg', 1, '22.10.2015', 'ghjkl', 'Alex', 1, 1233431, 0, 'deoc', ''),
(30, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'test test test', 'Alex', 1, 1233431, 0, 'deoc', ''),
(31, 'image 3', 'files/3.jpg', 1, '22.10.2015', 'ghjkl', 'Alex', 1, 1233431, 0, 'deoc', ''),
(32, 'txt 3', 'files/3.txt', 1, '22.10.2015', 'abc12', 'Alex', 3, 1233431, 0, 'deoc', ''),
(33, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'abc12', 'Alex', 1, 1233431, 0, 'deoc', '');

-- --------------------------------------------------------

--
-- Структура таблиці `sections`
--

CREATE TABLE IF NOT EXISTS `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `parentId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп даних таблиці `sections`
--

INSERT INTO `sections` (`id`, `title`, `parentId`) VALUES
(1, 'Section 1', 0),
(2, 'Section 2', 0),
(3, 'Section 1.1', 1),
(4, 'Section 1.2', 1),
(5, 'Section 1.1.1', 3),
(6, 'Section 2.1', 2);

-- --------------------------------------------------------

--
-- Структура таблиці `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `pass` varchar(25) NOT NULL,
  `description` varchar(250) NOT NULL,
  `role` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп даних таблиці `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `description`, `role`) VALUES
(1, 'vasya', 'ivan', '', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
