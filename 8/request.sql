/*Реалізувати набір тригерів, що реалізують такі ділові правила:
1.	Кількість тем може бути в діапазоні від 5 до 10.*/

DELIMITER $$

CREATE TRIGGER trig1 BEFORE INSERT ON topic
FOR EACH ROW
    IF (SELECT COUNT(*) FROM topic) > 10
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість більша 10';
    ELSEIF (select count(*) from topic) < 5
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість менша за 5';
END IF;
$$

DELIMITER ;

INSERT INTO topic(name) VALUE('example');

/*2.	Новинкою може бути тільки книга видана в поточному році.*/

CREATE TRIGGER trig2 BEFORE INSERT ON books
FOR EACH ROW

IF (books.new && YEAR(books.datee) != YEAR(NOW()))
THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Новинкою може бути лише книга видана в поточному році';
END IF


/*3.	Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $.*/

DELIMITER $$

CREATE TRIGGER trig3 BEFORE INSERT ON books
FOR EACH ROW

IF (
    (books.price > 10 AND books.pages < 100) OR
    (books.price > 20 AND books.pages < 200) OR
    (books.price > 30 AND books.pages < 300)
)
THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Несумісна ціна та кількість сторінок';
END IF

$$

DELIMITER ;

/*4.	Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.*/

DELIMITER $$

CREATE TRIGGER trig4 BEFORE INSERT ON books
FOR EACH ROW

IF (
    (books.id_publishing = 1 AND books.circulation < 5000) OR
    (books.id_publishing = 5 AND books.circulation < 1000)
)
THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Занадто мале значення circulation для вказаного видавництва';
END IF

$$

DELIMITER ;

/*5.	Книги з однаковим кодом повинні мати однакові дані.*/

DELIMITER $$

CREATE TRIGGER trig5 BEFORE INSERT ON books
FOR EACH ROW
BEGIN
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

/*6.	При спробі видалення книги видається інформація про кількість видалених рядків. Якщо користувач не "dbo", то видалення забороняється. */

DELIMITER $$

CREATE TRIGGER trig6 BEFORE DELETE ON books
FOR EACH ROW
BEGIN
    IF (REGEXP_SUBSTR(TRIM(CURRENT_USER()), '^[^\@]+') != 'root') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Лише користувачу dbo дозволено видаляти книги';
    ELSE
        SET @columnsCount = 0;

        SELECT count(*) INTO @columnsCount FROM information_schema.`COLUMNS`
        WHERE table_name = 'books' AND TABLE_SCHEMA = "labs";
    END IF;
END
$$

DELIMITER ;

/*7.	Користувач "dbo" не має права змінювати ціну книги.*/
DELIMITER $$

CREATE TRIGGER trig7 BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    IF (REGEXP_SUBSTR(TRIM(CURRENT_USER()), '^[^\@]+') = 'root' AND books.price != books.price) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Користувач не має права змінювати ціну книги';
    END IF;
END

$$

DELIMITER ;

/*8.	Видавництва ДМК і Еком підручники не видають.*/
DELIMITER $$

CREATE TRIGGER trig8 BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF ((books.id_publishing IN (6, 8)) AND books.id_category = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вказані видавництва не видають підручники';
    END IF;
END

$$

DELIMITER ;


/*9.	Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року.*/

DELIMITER $$

CREATE TRIGGER trig9 BEFORE INSERT ON books
FOR EACH ROW
BEGIN
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

/*10.	Видавництво BHV не випускає книги формату 60х88 / 16.*/
DELIMITER $$

CREATE TRIGGER trig10 BEFORE INSERT ON books
FOR EACH ROW
BEGIN
    IF (books.id_publishing = 1 AND books.format = 3) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вказане видавництво не видає кнниги в даному форматі';
    END IF;
END

$$

DELIMITER ;










