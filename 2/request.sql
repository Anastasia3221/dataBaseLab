/*1. Вивести значення наступних колонок: номер, код, новинка, назва, ціна, сторінки*/
    SELECT number, cod, new, name, price, sides 
    FROM book; 

/*2. Вивести значення всіх колонок*/
SELECT number, cod, new, name, price, producer, sides, form, datee, circulation, topic, category 
FROM book; 

/*3. Вивести значення колонок в наступному порядку: код, назва, новинка, сторінки, ціна, номер*/
SELECT cod, name, new, sides, price, number 
FROM book; 

/*4. Вивести значення всіх колонок 10 перших рядків*/
SELECT *
FROM `book`
LIMIT 10;

/*5. Вивести значення всіх колонок 10% перших рядків*/

SET @a = (SELECT CAST(COUNT(*) / 10 AS UNSIGNED) from `book`);
PREPARE STMT FROM 'SELECT * FROM book LIMIT ?';
EXECUTE STMT USING @a;
SELECT DISTINCT producer FROM `book`;

/* 6. Вивести значення колонки код без повторення однакових кодів*/
SELECT * 
FROM `book` 
GROUP BY cod; 

/*8-Вивести всі книги новинки*/
SELECT * 
FROM `book`
WHERE new = 1; 

/*9-Вивести всі книги новинки з ціною від 20 до 30*/
SELECT * 
FROM `book` 
WHERE (new = 1) AND (price > 20 AND price < 30); 

/*10-Вивести всі книги новинки з ціною менше 20 і більше 30*/
SELECT * 
FROM `book` 
WHERE (new = 1) AND (price < 20 OR price > 30); 

/*11-Вивести всі книги з кількістю сторінок від 300 до 400 і з ціною більше 20 і менше 30*/
SELECT * 
FROM `book` 
WHERE (sides > 300 AND sides < 400) AND (price > 20 AND price < 30);	

/*12-Вивести всі книги видані взимку 2000 року*/
SELECT * 
FROM `book`
WHERE datee = '2000-01-01' AND datee = '2000-03-01'; 

/*13-Вивести книги видані в 1999, 2001, 2003, 2005 р*/
SELECT * FROM `book` 
WHERE YEAR(datee) = 1999
OR    YEAR(datee) = 2001
OR    YEAR(datee) = 2003
OR    YEAR(datee) = 2005;

/*14-Вивести книги назви яких починаються на літери А-К*/
SELECT * 
FROM `book` 
WHERE name LIKE 'А%' OR name LIKE 'К%'; 

/* 15- Вивести книги назви яких починаються на літери "АПП", видані в 2000 році з ціною до 20*/
SELECT * 
FROM `book` 
WHERE name LIKE 'Апп%' AND datee = '2000-01-01' AND datee = '2000-12-31' AND price < 20; 

/*16-Вивести книги назви яких починаються на літери "АПП", закінчуються на "е", видані в першій половині 2000 року*/
SELECT * 
FROM `book` 
WHERE name LIKE 'Апп%е' AND datee = '2000-01-01' AND datee = '2000-6-30'; 

/*17-Вивести книги, в назвах яких є слово Microsoft, але немає слова Windows*/
SELECT * 
FROM `book`
 WHERE name LIKE '%Microsoft%' AND NOT name LIKE '%Windows%'; 

/* 18-Вивести книги, в назвах яких присутня як мінімум одна цифра*/
SELECT *
FROM `book`
WHERE name REGEXP '[0-9]';

/*  19-Вивести книги, в назвах яких присутні не менше трьох цифр.*/
SELECT *
FROM `book`
WHERE name REGEXP '([0-9].*){3}';

/* 20-Вивести книги, в назвах яких присутній рівно п'ять цифр.*/
SELECT *
FROM `book`
WHERE name REGEXP '([0-9].*){5}' AND name NOT REGEXP '([0-9].*){6}';