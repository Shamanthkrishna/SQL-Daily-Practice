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

-- Q20.

CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored')
);

INSERT INTO Ads (ad_id, user_id, action) VALUES
(1, 1, 'Clicked'),
(2, 2, 'Clicked'),
(3, 3, 'Viewed'),
(5, 5, 'Ignored'),
(1, 7, 'Ignored'),
(2, 7, 'Viewed'),
(3, 5, 'Clicked'),
(1, 4, 'Viewed'),
(2, 11, 'Viewed'),
(1, 2, 'Clicked');

SELECT 
	ad_id, 
    COUNT(CASE WHEN action = 'Clicked' THEN 1 END) AS Count_Click,
    COUNT(CASE WHEN action = 'Viewed' THEN 1 END) AS Count_View,
    ROUND(
		(COUNT(CASE WHEN action = 'Clicked' THEN 1 END) * 100) / 
		(COUNT(CASE WHEN action = 'Clicked' THEN 1 END) + COUNT(CASE WHEN action = 'Viewed' THEN 1 END)), 
        2
        ) as CTR
FROM ads
GROUP BY ad_id
ORDER BY CTR DESC, ad_id;

-- Q21.

CREATE TABLE Employee (
    employee_id INT,
    team_id INT
);
INSERT INTO Employee (employee_id, team_id) VALUES
(1, 8),
(2, 8),
(3, 8),
(4, 7),
(5, 9),
(6, 9);

SELECT 	employee_id, team_id, 
		COUNT(*) OVER (PARTITION BY team_id) AS team_size
FROM Employee
ORDER BY employee_id;

-- Q22.

-- Create the Countries table
CREATE TABLE Countries (
    country_id INT,
    country_name VARCHAR(255)
);

-- Create the Weather table
CREATE TABLE Weather (
    country_id INT,
    weather_state INT,
    day DATE
);

-- Insert data into Countries table
INSERT INTO Countries (country_id, country_name) VALUES
(2, 'USA'),
(3, 'Australia'),
(7, 'Peru'),
(5, 'China'),
(8, 'Morocco'),
(9, 'Spain');

-- Insert data into Weather table
INSERT INTO Weather (country_id, weather_state, day) VALUES
(2, 15, '2019-11-01'),
(2, 12, '2019-10-28'),
(2, 12, '2019-10-27'),
(3, -2, '2019-11-10'),
(3, 0, '2019-11-11'),
(3, 3, '2019-11-12'),
(5, 16, '2019-11-07'),
(5, 18, '2019-11-09'),
(5, 21, '2019-11-23'),
(7, 25, '2019-11-28'),
(7, 22, '2019-12-01'),
(7, 20, '2019-12-02'),
(8, 25, '2019-11-05'),
(8, 27, '2019-11-15'),
(8, 31, '2019-11-25'),
(9, 7, '2019-10-23'),
(9, 3, '2019-12-23');


SELECT c.country_name,
CASE
	WHEN AVG(w.weather_state*1.0) <= 15 THEN 'Cold'
	WHEN AVG(w.weather_state*1.0) >= 25 THEN 'Hot'
	ELSE 'Warm'
END AS weather_type
FROM Countries AS c
INNER JOIN Weather w ON c.country_id = w.country_id
WHERE w.day BETWEEN '2019-11-01' AND '2019-11-30'
GROUP BY c.country_id, c.country_name;

-- Q23.

create table if not exists Prices
(
product_id int,
start_date date,
end_date date,
price int,
constraint pk PRIMARY KEY (product_id, start_date, end_date)
);
insert into Prices VALUES
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

create table if not exists UnitsSold
(
product_id int,
purchase_date date,
units int
);
insert into UnitsSold VALUES
(1,'2019-02-25',100),
(1,'2019-03-01',15),
(2,'2019-02-10',200),
(2,'2019-03-22',30);

SELECT 	a.product_id,
		ROUND(SUM(price*units)/SUM(units), 2) AS AVG_PRICE
FROM unitssold a
JOIN prices b ON a.product_id = b.product_id AND purchase_date BETWEEN start_date AND end_date
GROUP BY a.product_id;