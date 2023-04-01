/*створення основної таблиці*/
CREATE TABLE books(
   N INT NOT NULL AUTO_INCREMENT,
   code INT NOT NULL,
   new boolean,
   name VARCHAR(255) NOT NULL,
   price FLOAT NOT NULL,
   id_publishing INT NOT NULL,
   pages INT NOT NULL,
   format VARCHAR(30) NOT NULL,
   datee DATE NOT NULL,
   circulation INT,
   id_topic INT NOT NULL,
   id_category INT NOT NULL,
   PRIMARY KEY(N)
); 

/*Створення допоміжних таблиць*/
CREATE TABLE category(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(300) NOT NULL
);

CREATE TABLE publishing(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(300) NOT NULL
);

CREATE TABLE topic(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(300) NOT NULL
);

INSERT INTO books(code, new, name, price, id_publishing, pages, format, datee, circulation, id_topic, id_category) VALUES
(5141, 0, 'Структуры данных и алгоритмы.', 37.80, 5, 384, '70х100/16', '2000-09-29', 5000, 1, 1),
(5127, 0, 'Автоматизация инженерно- графических работ', 11.58, 6, 256, '70х100/16', '2000-06-15', 5000, 1, 1),
(5110, 0, 'Аппаратные средства мультимедия. Видеосистема РС', 15.51, 1, 400, '70х100/16', '2000-07-24', 5000, 1, 6),
(5199,0, 'Железо IBM 2001. ', 30.07, 2, 368, '70х100/16', '2000-12-02', 5000, 1, 6),
(3851, 0, 'Защита информации и безопасность компьютерных систем', 26.00, 4, 480, '84х108/16', '1999-02-04', 5000, 1, 6),
(3932, 0, 'Как превратить персональный компьютер в измерительный комплекс', 7.65, 7, 144, '60х88/16', '1999-06-09', 5000, 1, 2),
(4713, 0, 'Plug- ins. Встраиваемые приложения для музыкальных программ', 11.41, 7, 144, '70х100/16', '2000-02-22', 5000, 1, 2),
(5217, 0, 'Windows МЕ. Новейшие версии программ', 16.57, 8, 320, '70х100/16', '2000-08-25', 5000, 2, 3),
(4829, 0, 'Windows 2000 Professional шаг за шагом с СD', 27.25, 9, 320, '70х100/16', '2000-04-28', 5000, 2, 3),
(5170, 0, 'Linux Русские версии', 24.43, 7, 346, '70х100/16', '2000-09-29', 5000, 2, 4),
(860, 0, 'Операционная система UNIX', 3.50, 1, 395, '84х100\16', '1997-05-05' , 5000, 2, 5),
(44, 0, 'Ответы на актуальные вопросы по OS/2 Warp', 5.00, 4, 352, '60х84/16', '1996-03-20', 5000, 2, 6),
(5176, 0, 'Windows Ме. Спутник пользователя', 12.79, 9, 306, '-', '2000-10-10', 5000, 2, 6),
(5462, 0, 'Язык программирования С++. Лекции и упражнения', 29.00, 4, 656, '84х108/16', '2000-12-12', 5000, 3, 7),
(4982, 0, 'Язык программирования С. Лекции и упражнения', 29.00, 4, 432, '84х108/16', '2000-07-12', 5000, 3, 7),
(4687, 0, 'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов', 17.60, 7, 240, '70х100/16', '2000-02-03', 5000, 3, 7);


INSERT INTO category (name) 
VALUES ('Підручники'), 
        ('Інші книги'), 
        ('Windows 2000'), 
        ('Linux'), 
        ('Unix'), 
        ('Інші операційні системи'), 
        ('C&C++');


INSERT INTO publishing (name) 
VALUES ('BHV С.-Петербург'), 
        ('МикроАрт'), 
        ('МикроАрт'), 
        ('DiaSoft'), 
        ('Вильямс'), 
        ('Питер'), 
        ('ДМК'), 
        ('Триумф'), 
        ('Русская редакция');

INSERT INTO topic (name)
        VALUES ('Використання ПК в цілому'), 
        ('Операційні системи'), 
        ('Програмування');




/*створення зовнішніх ключів для полів id_publishing, id_topic, id_category*/
ALTER TABLE books ADD FOREIGN KEY(id_publishing) REFERENCES publishing(id) ON DELETE CASCADE;
ALTER TABLE books ADD FOREIGN KEY(id_topic) REFERENCES topic(id) ON DELETE CASCADE;
ALTER TABLE books ADD FOREIGN KEY(id_category) REFERENCES category(id) ON DELETE CASCADE;
