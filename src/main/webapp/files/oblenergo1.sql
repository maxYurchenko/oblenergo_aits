-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Лип 27 2015 р., 16:32
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
  `valid` int(1) NOT NULL DEFAULT '1',
  `date` varchar(25) NOT NULL,
  `clientId` varchar(250) NOT NULL,
  `uploader` varchar(250) NOT NULL,
  `parentId` int(25) NOT NULL,
  `size` int(50) DEFAULT NULL,
  `viewNum` int(25) DEFAULT NULL,
  `type` varchar(250) DEFAULT NULL,
  `keywords` varchar(250) DEFAULT NULL,
  `isDelete` int(11) NOT NULL DEFAULT '0',
  `access` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=40 ;

--
-- Дамп даних таблиці `docs`
--

INSERT INTO `docs` (`id`, `title`, `path`, `valid`, `date`, `clientId`, `uploader`, `parentId`, `size`, `viewNum`, `type`, `keywords`, `isDelete`, `access`) VALUES
(1, '', '', 1, '25/07/2015', '', '', 1, 1233431, 0, 'deoc', '', 1, ''),
(2, 'image 1', 'files/1.jpg', 0, '22.10.2015', 'NotValid', 'Alex', 1, 1233431, 0, 'deoc', '', 0, '24'),
(3, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'lorem ipsum', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(4, 'pdf 3', 'files/3.pdf', 0, '22.10.2015', 'test', 'Alex', 5, 1233431, 0, 'deoc', '', 0, ''),
(5, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'abc12', 'Alex', 5, 1233431, 0, 'deoc', '', 0, ''),
(6, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'qwerty', 'Alex', 5, 1233431, 0, 'deoc', '', 0, ''),
(7, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'lorem ipsum', 'Alex', 5, 1233431, 0, 'deoc', '', 1, ''),
(8, 'txt 1', 'files/1.txt', 0, '22.10.2015', 'test', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(9, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'test test', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(10, 'txt 2', 'files/2.txt', 0, '22.10.2015', 'qwerty 1234513', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(11, 'txt 3', 'files/3.txt', 1, '22.10.2015', 'abc12', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(12, 'image 1', 'files/1.jpg', 0, '22.10.2015', 'test test test', 'Alex', 1, 1233431, 0, 'deoc', '', 1, ''),
(13, 'image 2', 'files/2.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, '24'),
(14, 'image 3', 'files/3.jpg', 1, '27/07/2015', 'ghjkl', '', 1, 1233431, 0, 'deoc', '', 0, ''),
(15, 'image 1', 'files/1.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, '24'),
(16, 'image 1', 'files/1.jpg', 0, '22.10.2015', 'abc12', 'Alex', 2, 1233431, 0, 'deoc', '', 1, ''),
(17, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'abc12', 'Alex', 2, 1233431, 0, 'deoc', '', 0, '1'),
(18, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'test', 'Alex', 6, 1233431, 0, 'deoc', '', 0, ''),
(19, 'image 1', 'files/1.jpg', 0, '22.10.2015', 'abc12', 'Alex', 6, 1233431, 0, 'deoc', '', 0, ''),
(20, 'pdf 2', 'files/2.pdf', 1, '22.10.2015', 'lorem ipsum', 'Alex', 5, 1233431, 0, 'deoc', '', 0, ''),
(21, 'pdf 3', 'files/3.pdf', 1, '22.10.2015', 'test', 'Alex', 5, 1233431, 0, 'deoc', '', 1, ''),
(22, 'txt 1', 'files/1.txt', 0, '22.10.2015', 'test', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(23, 'image 1', 'files/1.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, '24'),
(24, 'txt 1', 'files/1.txt', 1, '22.10.2015', 'lorem ipsum', 'Alex', 3, 1233431, 0, 'deoc', '', 1, ''),
(25, 'image 2', 'files/2.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, '24'),
(26, 'image 1', 'files/1.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, '24'),
(27, 'image 1', 'files/1.jpg', 0, '22.10.2015', 'test test test', 'Alex', 1, 1233431, 0, 'deoc', '', 0, ''),
(28, 'image 2', 'files/2.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, ''),
(29, 'image 3', 'files/3.jpg', 1, '22.10.2015', 'ghjkl', 'Alex', 1, 1233431, 0, 'deoc', '', 0, ''),
(30, 'image 1', 'files/1.jpg', 1, '22.10.2015', 'test test test', 'Alex', 1, 1233431, 0, 'deoc', '', 0, ''),
(31, 'image 3', 'files/3.jpg', 1, '22.10.2015', 'ghjkl', 'Alex', 1, 1233431, 0, 'deoc', '', 0, ''),
(32, 'txt 3', 'files/3.txt', 1, '22.10.2015', 'abc12', 'Alex', 3, 1233431, 0, 'deoc', '', 0, ''),
(33, 'image 1', 'files/1.jpg', 1, '27/07/2015', 'abc12', '', 1, 1233431, 0, 'deoc', '', 0, ''),
(34, '2Test', 'files/oblenergo.sql', 1, '27/07/2015', '2Test', '', 1, NULL, NULL, NULL, NULL, 1, '24'),
(35, '2Test', 'files/oblenergo.sql', 1, '07/24/2015', '2Test', 'vasya', 5, NULL, NULL, NULL, NULL, 0, ''),
(36, 'ags', 'files/dump3.sql', 1, '07/24/2015', 'Test2', 'vasya', 3, NULL, NULL, NULL, NULL, 0, ''),
(38, 'ернчеогнадю', 'files/simple.html', 1, '25/07/2015', 'іварбп', 'vasya', 3, NULL, NULL, NULL, NULL, 0, ''),
(39, 'rtghjmkl', 'files/simple.html', 1, '25/07/2015', 'rtjk', 'vasya', 1, NULL, NULL, NULL, NULL, 0, '23,25');

-- --------------------------------------------------------

--
-- Структура таблиці `sections`
--

CREATE TABLE IF NOT EXISTS `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `parentId` int(11) NOT NULL,
  `isDelete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп даних таблиці `sections`
--

INSERT INTO `sections` (`id`, `title`, `parentId`, `isDelete`) VALUES
(1, 'Section 12', 0, 0),
(2, 'Section 2', 0, 0),
(3, 'іаріолнрп', 0, 0),
(4, 'Section 1.2', 1, 0),
(5, 'Section 1.1.1', 3, 0),
(6, 'Section 2.1', 2, 0),
(7, 'section4', 6, 0),
(8, 'yhjuyikul', 0, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Дамп даних таблиці `users`
--

INSERT INTO `users` (`id`, `name`, `pass`, `description`, `role`) VALUES
(7, 'ins', '1234', 'ins', 2),
(22, 'vasya', 'ivan', 'ytujyk,', 2),
(23, 'ivan', 'alex', 'ygujk', 0),
(24, 'rex', 'rex', 'rex', 0),
(25, 'asfsag', 'asgjha', 'asdhgfa', 0),
(26, 'aetyrskudti', 'ertugfd', 'rhtjyuk,', 0),
(27, 'rtyujgoi', 'ertyujkiol', '', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
