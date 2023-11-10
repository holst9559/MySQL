DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore;
USE bookstore;


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
    isbn varchar(255) PRIMARY KEY CHECK (isbn REGEXP '[0-9]{13}'),
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
    isbn VARCHAR(255),
    amount INT,
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES bookstore (id),
    FOREIGN KEY (isbn) REFERENCES book (isbn)
);

/*
INSERT INTO language (language)
VALUES ('English'),
       ('Swedish'),
       ('Polish');

INSERT INTO author (first_name, last_name, birth_date)
VALUES('George', 'Martin', 1948-09-20),
      ('J.R.R', 'Tolien', 1892-01-03),
      ('Andrzej', 'Sapkowski', 1948-06-21);

INSERT INTO book(isbn, title, language_id, price, publication_date, author_id)
VALUES('9780261102354', 'The Fellowship of the Ring', 1, 122, 1991-07-04, 2),
      ('9789113084909', 'Ringens Brödraskap', 2, 199, 2019-08-28, 2),
      ('9780006479888', 'Game of Thrones', 1, 127, 1997-04-01, 1),
      ('9789175031828', 'Game of thrones - Drakarnas dans', 2, 89, 2013-06-14, 1),
      ('9781473232273', 'Wiedzmin', 3, 99, 2007-06-01, 3),
      ('9781473235090', 'The Last Wish', 1, 99, 2021-12-16, 3);
*/




