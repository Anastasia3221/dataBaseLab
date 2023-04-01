-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 21 2023 г., 17:43
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `librarydb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `book`
--

CREATE TABLE `book` (
  `number` int(11) NOT NULL,
  `cod` int(11) NOT NULL,
  `new` tinyint(1) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `producer` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sides` int(11) NOT NULL,
  `form` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datee` date NOT NULL,
  `circulation` int(11) NOT NULL,
  `topic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `book`
--

INSERT INTO `book` (`number`, `cod`, `new`, `name`, `price`, `producer`, `sides`, `form`, `datee`, `circulation`, `topic`, `category`) VALUES
(203, 44, 0, 'Відповіді на актуальні запитання щодо OS/2 Warp', 5, 'DiaSoft', 352, '60х84/16', '1996-03-20', 5000, 'Видавнича група BHV', 'Інші операційні системи'),
(222, 235, 0, 'Інформаційні системи і структури даних', 17.6, 'ДМК', 240, '70x100/16', '2000-03-02', 5000, 'Програмування', 'C&C++'),
(191, 860, 0, 'Операційна система UNIX', 3.5, 'Видавнича група BHV', 395, '84х10016', '1997-05-05', 5000, 'Операційні системи', 'Unix'),
(111, 2874, 1, 'Äèü', 32, 'ß', 1, '?', '2021-01-04', 1, 'äîàäíî ïî äèü', 'äàÿ äèü'),
(112, 2875, 1, 'Äèü 2', 35, 'ß', 1, '?', '2021-01-04', 1, 'äîàäíî ïî äèü 2', 'äàÿ äèü 2'),
(50, 3851, 1, 'Захист інформації та безпека компютерних систем', 26, 'DiaSoft', 480, '84х108/16', '1999-02-04', 5000, 'Використання ПК в цілому', 'Захист і безпека ПК'),
(58, 3932, 0, 'Як перетворити персональний компютерна вимірювальний комплекс', 7.65, 'ДМК', 144, '60х88/16', '1999-06-09', 5000, 'Використання ПК в цілому', 'Інші книги'),
(220, 4687, 0, 'Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів', 17.6, 'ДМК', 240, '70х100/16', '2000-02-03', 5000, 'Програмування', 'C&C++'),
(59, 4713, 0, 'Plug-ins. Додаткові програми для музичних програм', 11.41, 'ДМК', 144, '70х100/16', '2000-02-22', 5000, 'Використання ПК в цілому', 'Інші книги'),
(176, 4829, 0, 'Windows 2000 Professional крок за кроком з СD', 27.25, 'Эком', 320, '70х100/16', '2000-04-28', 5000, 'Операційні системи', 'Windows 2000'),
(210, 4982, 0, 'Язык программирования С. Лекции и упражнения', 29, 'DiaSoft', 432, '84х108/16', '2000-07-12', 5000, 'Програмування', 'C&C++'),
(8, 4985, 0, 'Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид.', 18.9, 'Вільямс', 288, '70х100/16', '2000-07-07', 5000, 'Використання ПК в цілому', 'Підручники'),
(31, 5110, 0, 'Апаратні засоби мультимедіа. Відеосистема РС', 15.51, 'Видавнича група BHV', 400, '70х100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
(2, 5111, 0, 'Апаратні засоби мультимедіа. Відеосистема РС', 15.51, 'Видавнича група BHV', 400, '70х100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Підручники'),
(20, 5127, 1, 'Автоматизація інженерно-графічних робіт', 11.58, 'Видавнича група BHV', 256, '70х100/16', '2000-06-15', 5000, 'Використання ПК в цілому', 'Підручники'),
(9, 5141, 0, 'Структури даних та алгоритми', 37.8, 'Вільямс', 384, '70х100/16', '2000-09-29', 5000, 'Використання ПК в цілому', 'Підручники'),
(188, 5170, 0, 'Linux версії', 24.43, 'ДМК', 346, '70х100/16', '2000-09-29', 5000, 'Операційні системи', 'Linux'),
(206, 5176, 0, 'Windows Ме. Супутник користувача ', 12.79, 'Видавнича група BHV', 306, '-', '2000-10-10', 5000, 'Операційні системи', 'Інші операційні системи'),
(46, 5199, 0, 'Залізо IBM 2001. ', 30.07, 'МикроАрт', 368, '70х100/16', '2000-12-02', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
(175, 5217, 0, 'Windows МЕ.  Найновіші версії програм', 16.57, 'Триумф', 320, '70х100/16', '2000-08-25', 5000, 'Операційні системи', 'Windows 2000'),
(209, 5462, 0, 'Мова програмування С++. Лекції та вправи', 29, 'DiaSoft', 656, '84х108/16', '2000-12-12', 5000, 'Програмування', 'C&C++');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`cod`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
