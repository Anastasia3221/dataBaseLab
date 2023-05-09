-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 21 2023 г., 18:16
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

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData` ()  BEGIN
    SELECT
        books.name, price, publishing.name AS publishing_name, format
    FROM
        books
    JOIN publishing ON books.id_publishing = publishing.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData15` ()  BEGIN
    SELECT DISTINCT NAME
FROM
    (
        (
        SELECT
            REGEXP_SUBSTR(TRIM(NAME),
            '^[^\\s]+') AS NAME
        FROM
            books
    )
UNION ALL
    (
    SELECT
        REGEXP_SUBSTR(TRIM(NAME),
        '^[^\\s]+') AS NAME
    FROM
        category
)
    ) NAMES
ORDER BY NAME
DESC
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData2` ()  BEGIN
    SELECT
        topic.name topic_name, category.name AS category_name, books.name AS book_name, publishing.name AS publishing_name
    FROM
        books
    JOIN publishing ON books.id_publishing = publishing.id
    JOIN topic ON books.id_topic = topic.id
    JOIN category ON books.id_category = category.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData3` (`pub_id` INT, `year_num` INT)  BEGIN
    SELECT
        *
    FROM
        books
    WHERE
        books.id_publishing = pub_id AND YEAR(datee) > year_num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData4` (`pub_id` INT, `year_num` INT)  BEGIN
    SELECT
        category.name AS category_name,
        SUM(pages) AS pages_count
    FROM
        books
    JOIN category ON books.id_category = category.id
    GROUP BY
        category
    ORDER BY
        pages_count ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBookData5` (`topic_id` INT, `category_id` INT, OUT `COUNT` INT)  BEGIN
    SELECT
        AVG(price)
    INTO COUNT
FROM
    books
WHERE
    books.topic = topic_id AND books.id_category = category_id ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `N` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `new` tinyint(1) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `id_publishing` int(11) NOT NULL,
  `pages` int(11) NOT NULL,
  `format` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datee` date NOT NULL,
  `circulation` int(11) DEFAULT NULL,
  `id_topic` int(11) NOT NULL,
  `id_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`N`, `code`, `new`, `name`, `price`, `id_publishing`, `pages`, `format`, `datee`, `circulation`, `id_topic`, `id_category`) VALUES
(1, 5141, 0, 'Структуры данных и алгоритмы.', 37.8, 5, 384, '70х100/16', '2000-09-29', 5000, 1, 1),
(2, 5127, 0, 'Автоматизация инженерно- графических работ', 11.58, 6, 256, '70х100/16', '2000-06-15', 5000, 1, 1),
(3, 5110, 0, 'Аппаратные средства мультимедия. Видеосистема РС', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 1, 6),
(4, 5199, 0, 'Железо IBM 2001. ', 30.07, 2, 368, '70х100/16', '2000-12-02', 5000, 1, 6),
(5, 3851, 0, 'Защита информации и безопасность компьютерных систем', 26, 4, 480, '84х108/16', '1999-02-04', 5000, 1, 6),
(6, 3932, 0, 'Как превратить персональный компьютер в измерительный комплекс', 7.65, 7, 144, '60х88/16', '1999-06-09', 5000, 1, 2),
(7, 4713, 0, 'Plug- ins. Встраиваемые приложения для музыкальных программ', 11.41, 7, 144, '70х100/16', '2000-02-22', 5000, 1, 2),
(8, 5217, 0, 'Windows МЕ. Новейшие версии программ', 16.57, 8, 320, '70х100/16', '2000-08-25', 5000, 2, 3),
(9, 4829, 0, 'Windows 2000 Professional шаг за шагом с СD', 27.25, 9, 320, '70х100/16', '2000-04-28', 5000, 2, 3),
(10, 5170, 0, 'Linux Русские версии', 24.43, 7, 346, '70х100/16', '2000-09-29', 5000, 2, 4),
(11, 860, 0, 'Операционная система UNIX', 3.5, 1, 395, '84х10016', '1997-05-05', 5000, 2, 5),
(12, 44, 0, 'Ответы на актуальные вопросы по OS/2 Warp', 5, 4, 352, '60х84/16', '1996-03-20', 5000, 2, 6),
(13, 5176, 0, 'Windows Ме. Спутник пользователя', 12.79, 9, 306, '-', '2000-10-10', 5000, 2, 6),
(14, 5462, 0, 'Язык программирования С++. Лекции и упражнения', 29, 4, 656, '84х108/16', '2000-12-12', 5000, 3, 7),
(15, 4982, 0, 'Язык программирования С. Лекции и упражнения', 29, 4, 432, '84х108/16', '2000-07-12', 5000, 3, 7),
(16, 4687, 0, 'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов', 17.6, 7, 240, '70х100/16', '2000-02-03', 5000, 3, 7);

--
-- Триггеры `books`
--
DELIMITER $$
CREATE TRIGGER `trig10` BEFORE INSERT ON `books` FOR EACH ROW BEGIN
    IF (books.id_publishing = 1 AND books.format = 3) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вказане видавництво не видає кнниги в даному форматі';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig3` BEFORE INSERT ON `books` FOR EACH ROW IF (
    (books.price > 10 AND books.pages < 100) OR
    (books.price > 20 AND books.pages < 200) OR
    (books.price > 30 AND books.pages < 300)
)
THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Несумісна ціна та кількість сторінок';
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig4` BEFORE INSERT ON `books` FOR EACH ROW IF (
    (books.id_publishing = 1 AND books.circulation < 5000) OR
    (books.id_publishing = 5 AND books.circulation < 1000)
)
THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Занадто мале значення circulation для вказаного видавництва';
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig5` BEFORE INSERT ON `books` FOR EACH ROW BEGIN
    SET @recordsCount = 0;
    SELECT COUNT(*) INTO @recordsCount
    FROM books
    WHERE code = NEW.code AND (
        -- n != NEW.n                          OR
        is_new != books.new                OR
        book_name != books.name          OR
        price != books.price                  OR
        publisher_id != books.id_publishing    OR
        pages_count != books.pages_count      OR
        format != books.format                OR
        date != books.datee                    OR
        circulation != books.circulation      OR
        theme != books.id_topic                  OR
        category != books.id_category
    );

    IF (@recordsCount != 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книги з однаоквим кодом мають мати однакові дані';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig6` BEFORE DELETE ON `books` FOR EACH ROW BEGIN
    IF (REGEXP_SUBSTR(TRIM(CURRENT_USER()), '^[^@]+') != 'root') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Лише користувачу dbo дозволено видаляти книги';
    ELSE
        SET @columnsCount = 0;

        SELECT count(*) INTO @columnsCount FROM information_schema.`COLUMNS`
        WHERE table_name = 'books' AND TABLE_SCHEMA = "labs";
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig7` BEFORE UPDATE ON `books` FOR EACH ROW BEGIN
    IF (REGEXP_SUBSTR(TRIM(CURRENT_USER()), '^[^@]+') = 'root' AND books.price != books.price) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Користувач не має права змінювати ціну книги';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig8` BEFORE INSERT ON `books` FOR EACH ROW BEGIN
    IF ((books.id_publishing IN (6, 8)) AND books.id_category = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вказані видавництва не видають підручники';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trig9` BEFORE INSERT ON `books` FOR EACH ROW BEGIN
    SET @publisher_novelties_count = 0;
    SELECT COUNT(*) INTO @publisher_novelties_count
    FROM books
    WHERE books.id_publishing = books.id_publishing AND books.new AND YEAR(NOW()) = YEAR(books.datee) AND MONTH(NOW()) = MONTH(books.datee);

    IF (books.new AND @publisher_novelties_count IS NOT NULL AND @publisher_novelties_count > 10) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво не може видати більше 10 новинок за місяць';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'Підручники'),
(2, 'Інші книги'),
(3, 'Windows 2000'),
(4, 'Linux'),
(5, 'Unix'),
(6, 'Інші операційні системи'),
(7, 'C&C++');

-- --------------------------------------------------------

--
-- Структура таблицы `publishing`
--

CREATE TABLE `publishing` (
  `id` int(11) NOT NULL,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `publishing`
--

INSERT INTO `publishing` (`id`, `name`) VALUES
(1, 'BHV С.-Петербург'),
(2, 'МикроАрт'),
(3, 'МикроАрт'),
(4, 'DiaSoft'),
(5, 'Вильямс'),
(6, 'Питер'),
(7, 'ДМК'),
(8, 'Триумф'),
(9, 'Русская редакция');

-- --------------------------------------------------------

--
-- Структура таблицы `topic`
--

CREATE TABLE `topic` (
  `id` int(11) NOT NULL,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `topic`
--

INSERT INTO `topic` (`id`, `name`) VALUES
(1, 'Використання ПК в цілому'),
(2, 'Операційні системи'),
(3, 'Програмування');

--
-- Триггеры `topic`
--
DELIMITER $$
CREATE TRIGGER `trig1` BEFORE INSERT ON `topic` FOR EACH ROW IF (SELECT COUNT(*) FROM topic) > 10
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість більша 10';
    ELSEIF (select count(*) from topic) < 5
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість менша за 5';
END IF
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`N`),
  ADD KEY `id_publishing` (`id_publishing`),
  ADD KEY `id_topic` (`id_topic`),
  ADD KEY `id_category` (`id_category`);

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `publishing`
--
ALTER TABLE `publishing`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `N` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `publishing`
--
ALTER TABLE `publishing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `topic`
--
ALTER TABLE `topic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`id_publishing`) REFERENCES `publishing` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_2` FOREIGN KEY (`id_topic`) REFERENCES `topic` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `books_ibfk_3` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
