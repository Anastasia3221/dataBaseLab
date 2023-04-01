/*Вивести статистику: загальна кількість всіх книг, їх вартість, їх середню вартість, мінімальну і максимальну ціну*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_, 
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_ FROM `book`;

/*Вивести загальну кількість всіх книг без урахування книг з непроставленою ціною*/
SELECT COUNT(*) FROM `book` WHERE price is not NULL;

/*Вивести статистику (див. 1) для книг новинка / не новинка*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_, 
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_,
    new AS isNew FROM `book` GROUP BY new;

/*Вивести статистику (див. 1) для книг за кожним роком видання*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_, 
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_, 
    datee AS DATE_ FROM `book` GROUP BY year(datee);

/*Змінити п.4, виключивши з статистики книги з ціною від 10 до 20*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_,
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_, 
    datee AS DATE_ FROM `book` WHERE (price>=10) and (price<=20) GROUP BY year(datee);
    
/*Змінити п.4. Відсортувати статистику по спадаючій кількості.*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_, 
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_, 
    datee AS DATE_ FROM `book` GROUP BY year(datee) ORDER BY COUNT_ DESC;
    
/*Вивести статистику: загальна кількість і вартість книг по першій букві її назви*/
SELECT COUNT(*),
    COUNT(price),
    left(name,1) AS FIRSTLETTER FROM `book` 
    GROUP BY FIRSTLETTER;
    
/*Змінити п. 9 так щоб до складу статистики потрапили дані з роками більшими за 2000.*/
SELECT COUNT(*),
	COUNT(price),
	left(name, 1) AS FIRSTLETTER FROM `book` WHERE year(datee) >=2000
    GROUP BY FIRSTLETTER;
   
/*Змінити п. 10. Відсортувати статистику по спадаючій перших букв назви.*/
SELECT COUNT(*),
	COUNT(price),
	left(name, 1) AS FIRSTLETTER FROM `book` WHERE year(datee) >=2000
    GROUP by FIRSTLETTER
	ORDER BY FIRSTLETTER DESC;

/*Вивести статистику (див. 1) по кожному місяцю кожного року.*/
SELECT COUNT(*) AS COUNT_, 
	SUM(price) AS SUM_, 
	AVG(price) AS AVG_, 
	MIN(price) AS MIN_, 
	MAX(price) AS MAX_, 
	MONTH(datee) AS MONTH_, 
	YEAR(datee) AS YEAR_ FROM book
	GROUP BY MONTH_;

/*Змінити п. 12 так щоб до складу статистики не увійшли дані з незаповненими датами.*/
SELECT COUNT(*) AS COUNT_, 
	SUM(price) AS SUM_, 
	AVG(price) AS AVG_, 
	MIN(price) AS MIN_, 
	MAX(price) AS MAX_, 
	MONTH(datee) AS MONTH_, 
	YEAR(datee) AS YEAR_ FROM book WHERE datee is NOT NULL
	GROUP BY MONTH_;
	
/*Змінити п. 12. Фільтр по спадаючій року і зростанню місяця.*/
SELECT COUNT(*) AS COUNT_, 
	SUM(price) AS SUM_, 
	AVG(price) AS AVG_, 
	MIN(price) AS MIN_, 
	MAX(price) AS MAX_, 
	MONTH(datee) AS MONTH_, 
	YEAR(datee) AS YEAR_ FROM book
	GROUP BY MONTH(datee), YEAR(datee)
	ORDER BY MONTH(datee) DESC, YEAR(datee) ASC;

/*Вивести статистику для книг новинка / не новинка: загальна ціна, загальна ціна в грн. / Євро / руб. Колонкам запиту дати назви за змістом.*/
SELECT COUNT(*),
    SUM(price) AS SUM_, 
    price*36.9 AS UAH,
    price*1.08 AS EUR, 
    new AS NEW FROM `book` GROUP BY NEW
	
/*Змінити п. 15 так щоб виводилася округлена до цілого числа (дол. / Грн. / Євро / руб.) Ціна.*/
SELECT COUNT(*),
    SUM(price) AS SUM_, 
    ROUND (price*36.9, 0) AS UAH,
    ROUND (price*1.08, 0) AS EUR, 
    new AS NEW FROM `book` GROUP BY NEW	
	    
/*	Вивести статистику (див. 1) по видавництвах.*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_, 
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_,
    producer AS PRODUCER FROM `book` GROUP BY PRODUCER;
	
/*Вивести статистику (див. 1) за категоріями, темами і видавництвами. Фільтр по видавництвам, темах, категоріям.*/
SELECT COUNT(*) AS COUNT_, 
    SUM(price) AS SUM_, 
    AVG(price) AS AVG_,
    MIN(price) AS MIN_, 
    MAX(price) AS MAX_, 
    producer,topic,category FROM `book` 
    GROUP BY producer, topic
    ORDER BY producer,topic,category;	
	
/*Вивести список видавництв, у яких округлена до цілого ціна однієї сторінки більше 10 копійок. */
SELECT producer FROM book WHERE ROUND(price/sides)>0.10	