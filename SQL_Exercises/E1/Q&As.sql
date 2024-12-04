-- 1.1 Select the names of all the products in the store.
select name Name
from products;

-- 1.2 Select the names and the prices of all the products in the store.
select name, price
from products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
select name
from products
where price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
select *
from products
where price between 60 and 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, (price*100) price_in_cents
from products;

-- 1.6 Compute the average price of all the products.
select avg(price)
from products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(p.price) Average_Price_of_all_Products
from products p, manufacturers m
where p.Manufacturer = m.Code and m.code = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(1)
from products
where price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price
from products
where price >= 180
order by price desc, name;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
-- 1.11 Select the product name, price, and manufacturer name of all the products.
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
-- 1.15 Select the name and price of the cheapest product.
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
-- 1.18 Update the name of product 8 to "Laser Printer".
-- 1.19 Apply a 10% discount to all products.
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.