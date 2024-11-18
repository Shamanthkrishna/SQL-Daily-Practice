-- Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
-- The CountryCode for America is USA.

SELECT * 
FROM city_table
WHERE COUNTRYCODE = 'USA' AND POPULATION > 100000;

-- Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
-- The CountryCode for America is USA.

SELECT NAME 
FROM city_table
WHERE COUNTRYCODE = 'USA' AND POPULATION > 120000;

-- Q3. Query all columns (attributes) for every row in the CITY table

SELECT *
FROM city_table;

-- Q4. Query all columns for a city in CITY with the ID 1661

SELECT *
FROM city_table
WHERE ID = 1661;

-- Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is
-- JPN.

SELECT *
FROM city_table
WHERE COUNTRYCODE = 'JPN';

-- Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is
-- JPN.

SELECT NAME
FROM city_table
WHERE COUNTRYCODE = 'JPN';

-- Q7. Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE FROM stationdata;

-- Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results
-- in any order, but exclude duplicates from the answer.

SELECT DISTINCT CITY city_name
FROM stationdata
WHERE ID % 2 = 0
ORDER BY CITY;

-- Q9. Find the difference between the total number of CITY entries in the table and the number of
-- distinct CITY entries in the table.

SELECT 	COUNT(CITY) AS TOTAL_NUMBER_CITIES, 
		COUNT(DISTINCT(CITY)) AS COUNT_OF_UNIQUE_CITIES, 
        (COUNT(CITY) - COUNT(DISTINCT(CITY))) AS DIFFERENCE_CITY_COUNT
FROM stationdata;

-- Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
-- respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
-- largest city, choose the one that comes first when ordered alphabetically

SELECT 	City, LENGTH(City) AS LONGEST_CITY_NAME
FROM stationdata
ORDER BY LONGEST_CITY_NAME DESC 
LIMIT 1;

SELECT	City, LENGTH(City) AS SHORTEST_CITY_NAME
FROM stationdata
ORDER BY SHORTEST_CITY_NAME LIMIT 1;

-- Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
-- cannot contain duplicates

SELECT DISTINCT City
FROM stationdata
WHERE 	lcase(City) LIKE "a%" OR
		lcase(City) LIKE "e%" OR
        lcase(City) LIKE "i%" OR
        lcase(City) LIKE "o%" OR
        lcase(City) LIKE "u%"
ORDER BY City; 

-- Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
-- contain duplicates.

SELECT DISTINCT City
FROM stationdata
WHERE 	lcase(City) LIKE "%a" OR
		lcase(City) LIKE "%e" OR
        lcase(City) LIKE "%i" OR
        lcase(City) LIKE "%o" OR
        lcase(City) LIKE "%u"
ORDER BY City; 

-- Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
-- contain duplicates.

SELECT DISTINCT City
FROM stationdata
WHERE 	lcase(City) NOT LIKE "a%" AND
		lcase(City) NOT LIKE "e%" AND
        lcase(City) NOT LIKE "i%" AND
        lcase(City) NOT LIKE "o%" AND
        lcase(City) NOT LIKE "u%"
ORDER BY City; 

-- Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
-- contain duplicates.

SELECT DISTINCT City
FROM stationdata
WHERE 	lcase(City) NOT LIKE "%a" AND
		lcase(City) NOT LIKE "%e" AND
        lcase(City) NOT LIKE "%i" AND
        lcase(City) NOT LIKE "%o" AND
        lcase(City) NOT LIKE "%u"
ORDER BY City; 

-- Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
-- with vowels. Your result cannot contain duplicates.

SELECT DISTINCT City
FROM stationdata
WHERE 	lcase(City) NOT LIKE "a%" AND
		lcase(City) NOT LIKE "e%" AND
        lcase(City) NOT LIKE "i%" AND
        lcase(City) NOT LIKE "o%" AND
        lcase(City) NOT LIKE "u%" AND
		lcase(City) NOT LIKE "%a" AND
		lcase(City) NOT LIKE "%e" AND
        lcase(City) NOT LIKE "%i" AND
        lcase(City) NOT LIKE "%o" AND
        lcase(City) NOT LIKE "%u"
ORDER BY City; 

-- OR

SELECT DISTINCT CITY 
FROM stationdata 
WHERE CITY not regexp '^[aeiou]' OR
city not regexp '[aeiou]$'
ORDER BY City;

-- Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
-- vowels. Your result cannot contain duplicates.

SELECT DISTINCT CITY 
FROM stationdata 
WHERE CITY not regexp '^[aeiou]' AND
city not regexp '[aeiou]$'
ORDER BY City;

-- Q17. Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
-- between 2019-01-01 and 2019-03-31 inclusive.
-- Return the result table in any order.
-- The query result format is in the following example

create table if not exists Product
(
product_id int NOT NULL,
product_name varchar(50),
unit_price int,
constraint pk PRIMARY KEY (product_id)
);
INSERT INTO Product (product_id, product_name, unit_price) 
VALUES 
    (1, 'S8', 1000),
    (2, 'G4', 800),
    (3, 'iPhone', 1400);


create table if not exists Sales
(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
constraint fk FOREIGN KEY (product_id) REFERENCES
Product(product_id)
);
INSERT INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price)
VALUES 
    (1, 1, 1, '2019-01-21', 2, 2000),
    (1, 2, 2, '2019-02-17', 1, 800),
    (2, 2, 3, '2019-06-02', 1, 800),
    (3, 3, 4, '2019-05-13', 2, 2800);


SELECT * FROM PRODUCT;
SELECT * FROM SALES;

SELECT product_id,
product_name
FROM Product
WHERE product_id NOT IN (	SELECT product_id
							FROM Sales
							WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31');
                            

-- Q18.
-- Table: Views
-- Column Name Type
-- article_id int
-- author_id int
-- viewer_id int
-- view_date date
-- There is no primary key for this table, it may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some
-- date.
-- Note that equal author_id and viewer_id indicate the same person.
-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.
-- The query result format is in the following example.

create table if not exists Views
(
article_id int,
author_id int,
viewer_id int,
view_date date
);
INSERT INTO Views (article_id, author_id, viewer_id, view_date)
VALUES
    (1, 3, 5, '2019-08-01'),
    (1, 3, 6, '2019-08-02'),
    (2, 7, 7, '2019-08-01'),
    (2, 7, 6, '2019-08-02'),
    (4, 7, 1, '2019-07-22'),
    (3, 4, 4, '2019-07-21'),
    (3, 4, 4, '2019-07-21');

SELECT DISTINCT author_id ID
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;

-- Q19.
-- Table: Delivery
-- Column Name Type
-- delivery_id int
-- customer_id int
-- order_date date
-- customer_pref_delivery_date date
-- delivery_id is the primary key of this table.
-- The table holds information about food delivery to customers that make orders at some date and
-- specify a preferred delivery date (on the same order date or after it).
-- If the customer's preferred delivery date is the same as the order date, then the order is called
-- immediately; otherwise, it is called scheduled.
-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
-- places.
-- The query result format is in the following example.
-- Input:
-- Delivery table:
-- delivery_id customer_id order_date
-- customer_pref_
-- delivery_date
-- 1 1 2019-08-01 2019-08-02
-- 2 5 2019-08-02 2019-08-02
-- 3 1 2019-08-11 2019-08-11
-- 4 3 2019-08-24 2019-08-26
-- 5 4 2019-08-21 2019-08-22
-- 6 2 2019-08-11 2019-08-13
-- Output:
-- immediate_percentage
-- 33.33
-- Explanation: The orders with delivery id 2 and 3 are immediate while the others are scheduled


CREATE TABLE Delivery (
    delivery_id INT,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) 
VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');
    
SELECT 
    ROUND(
        (SUM(CASE WHEN customer_pref_delivery_date = order_date THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2
    ) AS immediate_percentage
FROM 
    Delivery;

