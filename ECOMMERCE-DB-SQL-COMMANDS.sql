-- DB COMMANDS
create DATABASE ECOMMERCE;
-- DROP DATABASE ECOMMERCE;
SHOW DATABASES;
USE ECOMMERCE1;

-- TABLE COMMANDS
SHOW TABLES;

CREATE TABLE CUSTOMERS
(
CustomerID 				INT 			NOT NULL UNIQUE,
CustomerName 			VARCHAR(100),
ContactName				VARCHAR(100),
Address					VARCHAR(100),
City 					VARCHAR(100),
PostalCode 				INT,
Country 				VARCHAR(100),
PRIMARY KEY (CustomerID)
);

-- DROP TABLE CUSTOMERS; -- DELETES THE TABLE
-- DELETE FROM CUSTOMERS; -- DELETES ALL RECORDS BUT NOT TABLE
-- TRUNCATE TABLE CUSTOMERS; -- DELETES ALL RECORDS BUT NOT TABLE

ALTER TABLE CUSTOMERS
ADD MOBILE_NUM 		NUMERIC(10)  	 NOT NULL;

ALTER TABLE CUSTOMERS
DROP COLUMN MOBILE_NUM;

ALTER TABLE CUSTOMERS
MODIFY MOBILE_NUM NUMERIC(11)  	 NOT NULL DEFAULT 1020304050;

-- ALTER TABLE Orders
-- ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

-- ALTER TABLE Orders
-- DROP FOREIGN KEY FK_PersonOrder;

-- * MEANS ALL COLUMNS , WHERE CLAUSE IS CALLED ROW FILTER
-- ORDER BY MEANS RECORDS WILL BE IN EITHER INC OR DEC ORDER BASED ON THE COLUMN PROVIDED
-- GROUP BY CONDENSES OR GROUPS DIFF RECORDS INTO MULTIPLE SETS HAVING SIMILAR VALUES OF THE COLUMN PROVIDED
-- ALWAYS USE AGGREGATE FUN WITH GROUP BY CLAUSE
-- SUM, MIN, MAX, AVG, COUNT
SELECT customers.Country, count(customers.Country) AS COUNT_OF_COUNTRIES -- 6 SELCTS ROWS 
FROM CUSTOMERS -- 1 SOURCE OF DATA "CUSTOMERS"
WHERE customers.CustomerID > 102 -- 2
GROUP BY customers.Country -- 3 FORMS GROUPS OR SETS 
HAVING COUNT_OF_COUNTRIES >=1 -- 4 FILTERS GROUPS 
ORDER BY COUNT_OF_COUNTRIES DESC -- 5 ORDERS IN DESC BASED COUNTRY NAMES 
;

INSERT INTO CUSTOMERS
(
CustomerID,
CustomerName,
ContactName,
Address,
City,
PostalCode,
Country,
MOBILE_NUM
)
VALUES
(
110,
"vIVEK",
"VIVEK",
"MANJARI",
"PUNE",
412307,
"INDIA",
8149105354
);

INSERT INTO CUSTOMERS
(
CustomerID,
CustomerName,
ContactName,
Address,
City,
PostalCode,
Country
)
VALUES
(
102,
"RUTUJA KAMBLE",
"RUTUJA",
"MANJARI",
"PUNE",
412307,
"INDIA"
),
(
103,
"ANJALI JADHAV",
"ANJALI",
"DADAR",
"MUMBAI",
400014,
"INDIA"
),
(
104,
"SAKSHI KASBE",
"SAKSHI",
"PARK STREET",
"LONDON",
200201,
"UK"
),
(
105,
"PRATIK SHINDE",
"PRATIK",
"DUBAI",
"DUBAI",
3003001,
"UAE"
),
(
106,
"MAHESH K",
"MAHESH",
"LA",
"LA",
1001001,
"USA"
);

DROP TABLE CUSTOMERS;

UPDATE CUSTOMERS
SET CUSTOMERNAME="MAHESH KESKAR"
WHERE CUSTOMERID IN (106,103,102,104);

SELECT * FROM CUSTOMERS WHERE COUNTRY NOT IN ("INDIA", "USA");

SELECT * FROM CUSTOMERS WHERE CustomerID BETWEEN 103 AND 105;

SELECT * FROM CUSTOMERS WHERE CustomerID=103 OR CustomerID=105;

SELECT * FROM CUSTOMERS WHERE CustomerID > 103 AND CustomerID < 106;

SELECT * FROM CUSTOMERS WHERE CustomerID >= 103 AND CustomerID <= 106;

SELECT * FROM CUSTOMERS WHERE CustomerID != 103 AND CustomerID < 105;


CREATE TABLE Supplier (
SupplierID INT	NOT NULL,
SupplierName VARCHAR(100),
ContactName VARCHAR(100),
Address VARCHAR(100),
City VARCHAR(100),
PostalCode INT,
Country VARCHAR(100),
Phone LONG,
PRIMARY KEY(SupplierID)
);

ALTER TABLE supplier
MODIFY Phone VARCHAR(100);


INSERT INTO Supplier( SupplierID, SupplierName, ContactName, Address, City, PostalCode, Country, Phone)
VALUES ( 1, "FOX CON",	"Charlotte Cooper",	"49 Gilbert St.","Londona","EC1 4SD","UK", "(171) 555-2222");

SELECT * FROM Supplier;

DELETE FROM CUSTOMERS WHERE CUSTOMERID=101;

SELECT * FROM customers order by CustomerID DESC limit 4;

SELECT COUNT(*) AS COUNT FROM customers;
SELECT SUM(CustomerID) AS SUM FROM customers;
SELECT distinct(COUNTRY) AS DISTINCT_COUNTRIES FROM customers;

CREATE TABLE CATEGORIES
(
CategoryID INT NOT NULL,
CategoryName VARCHAR(100),
Description VARCHAR(100)
);

ALTER TABLE CATEGORIES
MODIFY CategoryID INT NOT NULL;

ALTER TABLE CATEGORIES
ADD PRIMARY KEY (CategoryID);

INSERT INTO CATEGORIES
(CategoryID,
CategoryName,
Description
)
values
(101,
"ELECTRONIC",
"FRIDGE, TV, WASH MACHINE ETC"
),
(
102,
"MOBILE",
"APPLE, ANDROID PHONES"
);

CREATE TABLE EMPLOYEES
(EmployeeID INT NOT NULL,
LastName VARCHAR(100),
FirstName VARCHAR(100),
BirthDate DATE,
Photo VARCHAR(100),
Notes VARCHAR(100),
PRIMARY KEY (EmployeeID)
);

INSERT INTO EMPLOYEES
(EmployeeID,	LastName,	FirstName,	BirthDate,	Photo,	Notes)
VALUES (1001, "SHARMA", "TOM", "1995-05-01", "TOM.PNG", "TOM HERE");

INSERT INTO EMPLOYEES
(EmployeeID,	LastName,	FirstName,	BirthDate,	Photo,	Notes)
VALUES (1002, "PATEL", "VISHAL", "1992-01-01", "VISHAL.PNG", "PATEL EVERYWHERE");


CREATE TABLE SHIPPERS
(ShipperID INT NOT NULL,
ShipperName VARCHAR(100),
Phone VARCHAR(100),
PRIMARY KEY (ShipperID)
);

INSERT INTO SHIPPERS
(ShipperID,	ShipperName,Phone)
VALUES (5000, "DELHIVERY","10101010101"),
(5001, "DROP SHIPPING", "102102102102"),
(5002, "SHIPROCKET", 103103103103);

CREATE TABLE ORDERS
(
OrderID INT NOT NULL,
CustomerID	INT NOT NULL,
EmployeeID	INT NOT NULL,
OrderDate	DATE,
ShipperID	INT NOT NULL,
PRIMARY KEY (OrderID),
FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
FOREIGN KEY (EmployeeID) REFERENCES employees(EmployeeID),
FOREIGN KEY (ShipperID) REFERENCES shippers(ShipperID)
);

-- Multiple rows insert in single command.
INSERT INTO ORDERS
(OrderID,	CustomerID,	EmployeeID,	OrderDate,	ShipperID)
VALUES (100011, 106, 1001, "2023-03-24", 5001), (100015, 104, 1000, "2023-03-24", 5002);


-- ################### JOINS ###############
-- JOINS --> JOIN THE ROWS FROM MULTIPLE TABLES BASED COMMON COLUMN(S)

-- 1. INNER JOIN -->  MATHCING RECORDS
SELECT ORDERS.OrderID, CUSTOMERS.CustomerName, ORDERS.OrderDate
FROM ORDERS INNER JOIN CUSTOMERS ON customers.CustomerID = ORDERS.CustomerID;

-- 2. LEFT JOIN --> MATCHING AND LEFT
SELECT ORDERS.OrderID, CUSTOMERS.CustomerName, ORDERS.OrderDate
FROM ORDERS LEFT JOIN CUSTOMERS ON customers.CustomerID = ORDERS.CustomerID;

-- 3. RIGHT JOIN --> MATCHING AND RIGHT
SELECT ORDERS.OrderID, CUSTOMERS.CustomerName, ORDERS.OrderDate
FROM ORDERS RIGHT JOIN CUSTOMERS ON customers.CustomerID = ORDERS.CustomerID;

-- 4. CROSS JOIN  --> ALL
SELECT ORDERS.OrderID, CUSTOMERS.CustomerName, ORDERS.OrderDate
FROM ORDERS CROSS JOIN CUSTOMERS;

-- 5. SELF JOIN
-- Q- Select all customers who belong to same city.

SELECT COUNT(*) FROM customers AS A, customers AS B; -- VERY SIMILAR TO CROSS JOIN BUT ONLY APPLIES ON SINGLE TABLE

SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City AS City1, B.City AS City2
FROM Customers AS A, Customers AS B
WHERE A.CustomerName <> B.CustomerName AND A.City = B.City;

-- ################### SQL Constraints ###############
-- 1. NOT NULL
-- 2. UNIQUE
-- 3. PRIMARY KEY
-- 4. FOREIGN KEY
-- 5. CHECK
-- 6. DEFAULT
-- 7. INDEX

-- CHECK CONSTRAINT EXAMPLE (PRIMARY KEY AND CHECK)
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int NOT NULL,
    PRIMARY KEY (ID),
    CHECK (Age >= 18)
);

ALTER TABLE PERSONS
ADD COLUMN COUNTRY VARCHAR(100) NOT NULL;

ALTER TABLE PERSONS
DROP COLUMN COUNTRY;

ALTER TABLE PERSONS
MODIFY COUNTRY VARCHAR(100) NOT NULL;

ALTER TABLE PERSONS
MODIFY COUNTRY VARCHAR(100) DEFAULT "INDIA";

INSERT INTO PERSONS
(ID, LastName, FirstName, Age)
VALUES (1, "GUPTA", "VIKRAM", 27);

SELECT * FROM PERSONS;

INSERT INTO PERSONS
(ID, LastName, FirstName, Age)
VALUES (2, "SAKSHI", "KASBE", 22);

INSERT INTO PERSONS
(ID, LastName, FirstName, Age)
VALUES (3, "SHINDE", "PRATIK", 23);

INSERT INTO PERSONS
(ID, LastName, FirstName, Age, COUNTRY)
VALUES (4, "KESKAR", "MAHESH", 24, "NZ");

INSERT INTO PERSONS
(ID, LastName, FirstName, COUNTRY)
VALUES (5, "JADHAV", "ANJALI", "NZ");

SELECT ID, FirstName, COUNTRY FROM PERSONS;

-- ################ INDEX ###############
-- The `CREATE INDEX` statement is used to create indexes in tables. Indexes are used to retrieve data from the database more quickly than otherwise.
-- The users cannot see the indexes, they are just used to speed up searches/queries.
-- Note: Updating a table with indexes takes more time than updating a table without (because the indexes also need an update). So, only create indexes on columns that will be frequently searched against.

CREATE INDEX CITIZEN
ON PERSONS (COUNTRY);

SELECT * FROM PERSONS USE INDEX (CITIZEN) WHERE COUNTRY="INDIA";

-- ############ UNION AND UNION ALL #############
-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- 1. Every SELECT statement within UNION must have the same number of columns
-- 2. The columns must also have similar data types
-- 3. The columns in every SELECT statement must also be in the same order

-- PRODUCES ONLY UNIQUE ELEMENTS
SELECT EmployeeID FROM employees
UNION
SELECT CustomerName FROM customers;

SELECT CustomerName FROM customers
UNION ALL
SELECT CustomerName FROM customers;


-- DISTINCT KEYWORD
SELECT COUNT(distinct( CITY)) FROM ecommerce.customers;

-- ###### GROUP BY AND HAVING CLAUSE #######
SELECT COUNT(CustomerID) AS COUNT_CUST, CITY FROM ecommerce.customers
GROUP BY CITY
HAVING COUNT_CUST >=1;

-- ##### LIKE OPERATOR  #####
-- '_' ANY SINGLE CHAR
-- '%' ANY NUMBER OF CHARS
SELECT * FROM customers WHERE CustomerName LIKE "_I%";

--- ####### Views ####### ---
-- 1. In SQL, a view is a virtual table based on the result-set of an SQL statement(SELECT STATEMENT).
-- 2. A view contains rows and columns, just like a real table. The fields in a view are fields from one
--  or more real tables in the database.
-- 3. You can add SQL statements and functions to a view and present the data as if the data were 
-- coming from one single table.

CREATE VIEW CUST_ID_CITY AS
SELECT CustomerID, CITY FROM customers;

CREATE VIEW CUST_ID_NAME_CITY AS
SELECT CustomerID, CustomerName, CITY FROM customers;

CREATE VIEW ORDER_CUSTOMER_VIEW AS
SELECT ORDERS.OrderID, CUSTOMERS.CustomerName, ORDERS.OrderDate
FROM ORDERS INNER JOIN CUSTOMERS ON customers.CustomerID = ORDERS.CustomerID;

-- ANY - ALL ## BELOW IS EXAMPLE NESTED/INNER QUERY
-- SELECT column_name(s)
-- FROM table_name
-- WHERE column_name operator ANY
--   (SELECT column_name
--   FROM table_name
--   WHERE condition);
SELECT * FROM customers 
WHERE CustomerID != ALL (SELECT CustomerID FROM customers WHERE CustomerID > 105);

-- LIMIT IS USED TO LIMIT NUMBER OF RECORDS IN SELECT STATEMENT
SELECT CustomerID FROM customers ORDER BY CustomerID DESC LIMIT 1; 

-- AGREGATE FUNCS
SELECT AVG(CustomerID) FROM customers; 
SELECT MIN(CustomerID) FROM customers; 
SELECT COUNT(CustomerID) FROM customers; 
SELECT MAX(CustomerID) FROM customers; 
SELECT SUM(CustomerID) FROM customers; 

CREATE TABLE TABLE1(NAME varchar(100));
INSERT INTO TABLE1 (NAME) VALUE ("VIKRAM");
CREATE TABLE TABLE2(NAME varchar(100));

-- COPY DATA FROM ONE TABLE TO ANOTHER TABLE USING `INSERT INTO SELECT` STATEMENT 
INSERT INTO TABLE2
SELECT * FROM TABLE1;

CREATE TABLE SUPPLIER
(
SupplierID INT NOT NULL,
SupplierName varchar(100), 
ContactName	varchar(100),
Address	varchar(100),
City varchar(100),
PostalCode	varchar(100),
Country	varchar(100),
Phone varchar(100)
);

ALTER TABLE SUPPLIER
ADD PRIMARY KEY (SupplierID);

INSERT INTO SUPPLIER 
(SupplierID,SupplierName,ContactName,Address,City,PostalCode,Country,Phone) 
VALUES(5000, "AMUL","AMUL","AHMEDABAD","AHMEDABAD", 1010101,"INDIA", 1212212);

INSERT INTO SUPPLIER 
(SupplierID,SupplierName,ContactName,Address,City,PostalCode,Country,Phone) 
VALUES(5001, "CHITALE","CHITALE","PUNE","PUNE", 1010102,"INDIA", 1212213);

INSERT INTO SUPPLIER 
(SupplierID,SupplierName,ContactName,Address,City,PostalCode,Country,Phone) 
VALUES(5002, "KATRAJ","KATRAJ","PUNE","PUNE", 1010103,"INDIA", 1212213);

INSERT INTO SUPPLIER 
(SupplierID,SupplierName,ContactName,Address,City,PostalCode,Country,Phone) 
VALUES(5003, "GOKUL","GOKUL","KOLHAPUR","KOLHAPUR", 1010104,"INDIA", 1212214);


CREATE TABLE PRODUCT
(ProductID	INT NOT NULL,
ProductName	VARCHAR(100),
SupplierID INT,
CategoryID	INT,
Unit INT,
Price INT,
PRIMARY KEY (ProductID),
FOREIGN KEY (SupplierID) REFERENCES supplier(SupplierID),
foreign key (CategoryID) references categories(CategoryID)
);

-- Example of mulit line comment 
/*
insert INTO PRODUCT
(ProductID,ProductName,SupplierID,CategoryID,Unit,Price)
VALUES(1, "MILK",5000,103,10,50);
*/
select * from product;


