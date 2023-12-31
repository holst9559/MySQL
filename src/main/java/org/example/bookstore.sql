DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;

DROP TABLE IF EXISTS language;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS bookstore;
DROP TABLE IF EXISTS inventory;

CREATE TABLE language
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    language VARCHAR(30) CHECK(language REGEXP '^[A-Za-z]+$')
);

CREATE TABLE author
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    birth_date DATE NOT NULL
);

CREATE TABLE book
(
    isbn VARCHAR(255) PRIMARY KEY CHECK (isbn REGEXP '[0-9]{13}'),
    title VARCHAR(255),
    language_id INT NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    publication_date DATE NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES author (id),
    FOREIGN KEY (language_id) REFERENCES language (id)
);

CREATE TABLE bookstore
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(255),
    city_name VARCHAR(60)
);

CREATE TABLE inventory
(
    store_id INT,
    isbn CHAR(13),
    amount INT,
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES bookstore (id),
    FOREIGN KEY (isbn) REFERENCES book (isbn)
);

START TRANSACTION;
INSERT INTO language (language)
VALUES ('English'),
       ('Swedish'),
       ('Polish');
COMMIT;

START TRANSACTION;
INSERT INTO author (first_name, last_name, birth_date)
VALUES('George', 'Martin', '1948-09-20'),
      ('J.R.R', 'Tolien', '1892-01-03'),
      ('Andrzej', 'Sapkowski', '1948-06-21');
COMMIT;

START TRANSACTION;
INSERT INTO book(isbn, title, language_id, price, publication_date, author_id)
VALUES('9780261102354', 'The Fellowship of the Ring', 1, 122, '1991-07-04', 2),
      ('9789113084909', 'Ringens Brödraskap', 2, 199, '2019-08-28', 2),
      ('9780006479888', 'Game of Thrones', 1, 127, '1997-04-01', 1),
      ('9789175031828', 'Game of thrones - Drakarnas dans', 2, 89, '2013-06-14', 1),
      ('9781473232273', 'Wiedzmin', 3, 99, '2007-06-01', 3),
      ('9781473235090', 'The Last Wish', 1, 99, '2021-12-16', 3);
COMMIT;

START TRANSACTION;
INSERT INTO bookstore (store_name, city_name)
VALUES('Ugglan', 'Skara'),
      ('Akademibokhandeln', 'Göteborg');
COMMIT;

START TRANSACTION;
INSERT INTO inventory (store_id, isbn, amount)
VALUES (1, '9780261102354', 20),
       (1, '9780006479888', 14),
       (1, '9781473235090', 10),
       (2, '9780261102354', 4),
       (2, '9789113084909', 14),
       (2, '9780006479888', 24),
       (2, '9789175031828', 40),
       (2, '9781473232273', 1),
       (2, '9781473235090', 12);
COMMIT;

CREATE VIEW total_author_book_value AS
SELECT CONCAT(author.first_name, ' ', author.last_name) as name,
       YEAR(current_date()) - YEAR(author.birth_date) as age,
       COUNT(DISTINCT book.title) as book_title_count,
       SUM(book.price * inventory.amount) as inventory_value
FROM author
    JOIN book ON author.id = book.author_id
    LEFT JOIN inventory on book.isbn = inventory.isbn
GROUP BY author_id;

CREATE USER 'web'@'%' IDENTIFIED BY 'password';
CREATE USER 'dev'@'%' IDENTIFIED BY 'password';

GRANT INSERT, UPDATE, DELETE, SELECT on bookstore.* TO 'web'@'%';
GRANT INSERT, UPDATE, DELETE, SELECT, CREATE, DROP on bookstore.* TO 'dev'@'%';