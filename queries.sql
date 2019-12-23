CREATE TABLE customer (
cid int,
first_name varchar (20),
last_name varchar (25),
email varchar (80), 
address varchar (100),
status ENUM ('silver', 'gold', 'platinum'), 
silver_and_above boolean,
credit_limit int, 
PRIMARY KEY (cid)
);

CREATE TABLE credit_card (
card_number varchar (20),
sec_number varchar (4), 
owner_name varchar (45),
card_type varchar (40),
billing_address varchar (100),
exp_date varchar (5),
stored_flag boolean,
customer_id int, 
FOREIGN KEY (customer_id) REFERENCES customer (cid),
PRIMARY KEY (card_number)
);

CREATE TABLE ship_address (
cust_id int,
sa_name varchar (30),
street_number varchar (6),
street varchar (40),
zip varchar (6),
city varchar (25),
state varchar (3),
country varchar (40),
recepient_name varchar (45),
FOREIGN KEY (cust_id) REFERENCES customer (cid),
PRIMARY KEY (cust_id, sa_name)
);

CREATE TABLE cart (
cart_id int,
cid int,
sa_name varchar (30),
card_number varchar (20),
t_status ENUM ('bought', 'shipped', 'delivered', 'not_delivered'),
t_date date,
FOREIGN KEY (cid, sa_name) REFERENCES ship_address (cust_id, sa_name),
PRIMARY KEY (cart_id)
);

CREATE TABLE product (
product_id int,
p_name varchar (50),
p_price DECIMAL(13,2),
p_type varchar (20),
p_quantity int,
PRIMARY KEY (product_id)
);

CREATE TABLE offer_product (
product_id int,
offer_price DECIMAL(13,2),
FOREIGN KEY (product_id) REFERENCES product (product_id),
PRIMARY KEY (product_id)
);

CREATE TABLE appears_in ( 
cart_id int, 
product_id int, 
quantity int,
price_sold DECIMAL(13,2),
FOREIGN KEY (cart_id) REFERENCES cart (cart_id),
FOREIGN KEY (product_id) REFERENCES product (product_id),
PRIMARY KEY (cart_id, product_id)
);

CREATE TABLE computer (
product_id int,
cpu_type varchar (30),
FOREIGN KEY (product_id) REFERENCES product (product_id),
PRIMARY KEY (product_id)
);

CREATE TABLE printer (
product_id int,
resolution int,
printer_type varchar (20),
FOREIGN KEY (product_id) REFERENCES product (product_id),
PRIMARY KEY (product_id)
);

CREATE TABLE laptop (
product_id int,
cpu_type varchar (20),
battery_power varchar (25),
weight int,
FOREIGN KEY (product_id) REFERENCES product (product_id),
PRIMARY KEY (product_id)
);

INSERT INTO customer (cid, first_name, last_name, email, address, status, silver_and_above, credit_limit)
VALUES
(123456, 'John', 'Doe', 'johndoe@njit.edu', '123 Brook Ln, Hoboken, NJ', 'silver', true, 500),
(789101, 'Jess', 'Ham', 'jessham@njit.edu', '456 Brook Ln, Hoboken, NJ', 'gold', true, 600),
(112131, 'Joe', 'Wham', 'joewham@njit.edu', '789 Brook Ln, Hoboken, NJ', 'platinum', true, 700),
(415161, 'Chris', 'Chai', 'chrischai@njit.edu', '101 Brook Ln, Hoboken, NJ', 'platinum', true, 700),
(718192, 'Kim', 'Austin', 'kimaustin@njit.edu', '112 Brook Ln, Hoboken, NJ', 'gold', true, 600),
(021222, 'Lisa', 'Noelle', 'lisanoelle@njit.edu', '133 Brook Ln, Hoboken NJ', null, false, 0),
(021223, 'Jim', 'Walsh', 'jimwalsh@usc.edu', '131 Brook Ln, Hoboken, NJ', 'silver', true, 500),
(021224, 'Kelly', 'Taylor', 'ktaylor@ucla.edu', '131 Brook Ln, Hoboken, NJ', 'silver', true, 500),
(021225, 'Steve', 'Sanders', 'ssanders@usc.edu', '131 Brook Ln, Hoboken, NJ', 'silver', true, 500);

INSERT INTO credit_card (card_number, sec_number, owner_name, card_type, billing_address, exp_date, stored_flag, customer_id)
VALUES
('1234567891011123', 0000, 'John Doe', 'VISA', '123 Brook Ln, Hoboken, NJ', '01/20', true, 123456),
('2345678901112131', 1111, 'Jess Ham', 'AMEX', '456 Brook Ln, Hoboken, NJ', '02/20', false, 789101),
('3456789011121314', 2222, 'Joe Wham', 'VISA', '789 Brook Ln, Hoboken, NJ', '03/20', true, 112131),
('4567891234567890', 3333, 'Chris Chai', 'VISA', '101 Brook Ln, Hoboken, NJ', '04/20', false, 415161),
('5678998765432100', 4444, 'Kim Austin', 'DISCOVER', '112 Brook Ln, Hoboken, NJ', '05/20', true, 718192),
('0987654321123456', 5555, 'Lisa Noelle', 'VISA', '131 Brook Ln, Hoboken, NJ', '06/20', true, 021222);




INSERT INTO ship_address (cust_id, sa_name, street_number, street, zip, city, state, country, recepient_name)
VALUES 
(123456, 'Home', 333, 'Warren St', '07102', 'Newark', 'NJ', 'USA', 'Jennifer Lawrence'),
(789101, 'Office', 456, 'Brook Ln', '07601', 'Hackensack', 'NJ', 'USA', 'Jim Hams'), 
(112131, 'McDonalds', 789, 'Brook Ln', '07073', 'East Rutherford', 'NJ', 'USA', 'Will Burger'), 
(415161, 'Office', 101, 'Brook Ln', '07029', 'Harrison', 'NJ', 'USA', 'Tim Drake'), 
(718192, 'Other', 112, 'Brook Ln', '07029', 'Harrison', 'NJ', 'USA', 'Billy Austin'), 
(021222, 'Home', 135, 'Forest Rd', '27612', 'Raleigh', 'NC', 'USA', 'Lisa Noelle'),
(021223, 'School', 131, 'Brook Ln', '90210', 'Beverly Hills', 'CA', 'USA', 'Jim Walsh'), 
(021224, 'School', 132, 'Brook Ln', '90210', 'Beverly Hills', 'CA', 'USA', 'Kelly Taylor'), 
(021225, 'School', 133, 'Brook Ln', '90210', 'Beverly Hills', 'CA', 'USA', 'Steve Sanders');



INSERT INTO cart (cart_id, cid, sa_name, card_number, t_status, t_date)
VALUES
(111, 789101, 'Office', '2345678901112131', 'shipped', '2019-12-02'),
(112, 112131, 'McDonalds', '3456789011121314', 'delivered', '2019-12-09'),
(113, 415161, 'Office', '4567891234567890', 'delivered', '2019-12-08'),
(114, 718192, 'Other', '5678998765432100', 'bought', '2019-12-10'),
(115, 021223, 'School', '0987654321123456', 'not_delivered', '2019-12-11'),
(116, 021224, 'School', '0987654321123457', 'shipped', '2019-12-11'),
(117, 021225, 'School', '0987654321123458', 'shipped', '2019-12-06'), 
(118, 021222, 'Home', '0987654321123459', 'bought', '2019-12-09');

INSERT INTO product (product_id, p_name, p_price, p_type, p_quantity)
VALUES
(7479, 'Dell Premium PC', 1000, 'Dell', 5),
(8000, 'Dell PC', 900, 'Dell', 2),
(456, 'Dell laptop', 1120, 'Dell', 3),
(1122, 'Apple Macbook', 1500, 'Apple', 3),
(7456, 'Canon Inkjet', 100, 'Canon', 2),
(3345, 'Brother laser', 250, 'Brother', 2);

INSERT INTO offer_product (product_id, offer_price)
VALUES
(7479, null),
(8000, 850),
(456, 1000),
(1122, null),
(7456, 80),
(3345, null);

INSERT INTO appears_in (cart_id, product_id, quantity, price_sold)
VALUES
(111, 8000, 2, '733.88'),
(112, 456, 3, '500.00'),
(113, 456, 2, '200.00'),
(113, 1122, 4, '400.00'),
(114, 7456, 4, '800.00'),
(115, 3345, 2, '600.00'),
(115, 1122, 1, '400.00'), 
(116, 8000, 1, '733.88'),
(117, 7479, 1, '1054.90'),
(118, 7479, 1, '1054.90');

INSERT INTO computer (product_id, cpu_type) 
VALUES 
(7479, 'AMD'),
(8000, 'Intel Core-I7');

INSERT INTO printer (product_id, resolution, printer_type) 
VALUES 
(7456, 600, 'Inkjet'),
(3345, 300, 'laser');

INSERT INTO laptop (product_id, cpu_type, battery_power, weight) 
VALUES 
(456, 'Pentium', '2 hours', 4.5),
(1122, 'Apple', '5 hours', 4.0);


SELECT p_name, sold1 FROM
(SELECT p_name, SUM(quantity) AS sold1 FROM product
NATURAL JOIN cart NATURAL JOIN appears_in
WHERE t_date between '2019-12-05' and '2019-12-12'
GROUP BY product_id) b
WHERE sold1=
(SELECT MAX(sold) FROM (
SELECT SUM(quantity) AS sold FROM product 
NATURAL JOIN cart NATURAL JOIN appears_in
where t_date between '2019-12-05' and '2019-12-12'
group by product_id) a);


SELECT product_id FROM (
SELECT COUNT(*) AS customer_count1, product_id FROM (
SELECT 1, product_id FROM product NATURAL JOIN cart NATURAL JOIN appears_in
GROUP BY cid, product_id) a
GROUP BY product_id) b
WHERE customer_count1
=(SELECT MAX(customer_count) FROM (
SELECT COUNT(*) AS customer_count, product_id FROM (
SELECT 1, product_id FROM product NATURAL JOIN cart NATURAL JOIN appears_in
GROUP BY cid, product_id) a
GROUP BY product_id) b);

SELECT cid FROM 
(SELECT cid, SUM(price_sold) AS total
FROM cart NATURAL JOIN appears_in 
GROUP BY cid) a
ORDER BY total DESC
LIMIT 10;

select zip FROM ship_address LEFT JOIN cart ON ship_address.sa_name = cart.sa_name AND ship_address.cust_id = cart.cid AND t_date between '2019-12-01' and '2019-12-12'
GROUP BY zip ORDER BY COUNT(t_status) DESC LIMIT 5;

select p_type, AVG(price_sold) from product NATURAL JOIN appears_in NATURAL JOIN cart 
WHERE t_date between '2019-12-01' and '2019-12-12' AND (product_id IN (SELECT product_id FROM computer) OR product_id IN (SELECT product_id FROM laptop) OR product_id IN (SELECT product_id FROM printer))
GROUP BY p_type;
