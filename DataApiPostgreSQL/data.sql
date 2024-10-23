-- Connect to the default database
-- \c postgres;

-- DROP DATABASE IF EXISTS bookshelf;

-- CREATE DATABASE bookshelf;

-- Connect to the new database
\c bookshelf;

-- Drop existing tables and sequence if they exist
DROP TABLE IF EXISTS books_authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP SEQUENCE IF EXISTS globalId;

-- Create a new sequence
CREATE SEQUENCE globalId
START 1000000
INCREMENT BY 1;

-- Create the books table
CREATE TABLE books (
    id INT PRIMARY KEY DEFAULT nextval('globalId'),
    title VARCHAR(1000) NOT NULL,
    year INT,
    pages INT
);

-- Create the authors table
CREATE TABLE authors (
    id INT PRIMARY KEY DEFAULT nextval('globalId'),
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    last_name VARCHAR(100) NOT NULL
);

-- Create the books_authors table
CREATE TABLE books_authors (
    author_id INT NOT NULL REFERENCES authors(id),
    book_id INT NOT NULL REFERENCES books(id),
    PRIMARY KEY (author_id, book_id)
);

-- Create a non-clustered index
CREATE INDEX ixnc1 ON books_authors(book_id, author_id);

-- Insert data into the authors table
INSERT INTO authors (id, first_name, middle_name, last_name) VALUES
    (1, 'Isaac', NULL, 'Asimov'),
    (2, 'Robert', 'A.', 'Heinlein'),
    (3, 'Robert', NULL, 'Silvenberg'),
    (4, 'Dan', NULL, 'Simmons'),
    (5, 'Davide', NULL, 'Mauri'),
    (6, 'Bob', NULL, 'Ward'),
    (7, 'Anna', NULL, 'Hoffman'),
    (8, 'Silvano', NULL, 'Coriani'),
    (9, 'Sanjay', NULL, 'Mishra'),
    (10, 'Jovan', NULL, 'Popovic');

-- Insert data into the books table
INSERT INTO books (id, title, year, pages) VALUES
    (1000, 'Prelude to Foundation', 1988, 403),
    (1001, 'Forward the Foundation', 1993, 417),
    (1002, 'Foundation', 1951, 255),
    (1003, 'Foundation and Empire', 1952, 247),
    (1004, 'Second Foundation', 1953, 210),
    (1005, 'Foundation''s Edge', 1982, 367),
    (1006, 'Foundation and Earth', 1986, 356),
    (1007, 'Nemesis', 1989, 386),
    (1008, 'Starship Troopers', NULL, NULL),
    (1009, 'Stranger in a Strange Land', NULL, NULL),
    (1010, 'Nightfall', NULL, NULL),
    (1011, 'Nightwings', NULL, NULL),
    (1012, 'Across a Billion Years', NULL, NULL),
    (1013, 'Hyperion', 1989, 482),
    (1014, 'The Fall of Hyperion', 1990, 517),
    (1015, 'Endymion', 1996, 441),
    (1016, 'The Rise of Endymion', 1997, 579),
    (1017, 'Practical Azure SQL Database for Modern Developers', 2020, 326),
    (1018, 'SQL Server 2019 Revealed: Including Big Data Clusters and Machine Learning', 2019, 444),
    (1019, 'Azure SQL Revealed: A Guide to the Cloud for SQL Server Professionals', 2020, 528),
    (1020, 'SQL Server 2022 Revealed: A Hybrid Data Platform Powered by Security, Performance, and Availability', 2022, 506);

-- Insert data into the books_authors table
INSERT INTO books_authors (author_id, book_id) VALUES
    (1, 1000),
    (1, 1001),
    (1, 1002),
    (1, 1003),
    (1, 1004),
    (1, 1005),
    (1, 1006),
    (1, 1007),
    (1, 1010),
    (2, 1008),
    (2, 1009),
    (2, 1011),
    (3, 1010),
    (3, 1012),
    (4, 1013),
    (4, 1014),
    (4, 1015),
    (4, 1016),
    (5, 1017),
    (6, 1018),
    (6, 1019),
    (6, 1020),
    (7, 1017),
    (8, 1017),
    (9, 1017),
    (10, 1017);

