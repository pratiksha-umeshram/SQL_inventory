-- Create the INVENTORY database to store all tables related to the inventory management system.
CREATE DATABASE INVENTORY;

-- Switch to the INVENTORY database for further operations
USE INVENTORY;


-----CREATING TABLE FOR EACH COLUMNS NEEDED IN INVENTORY------

-- Create the SUPPLIER table to store information about suppliers
CREATE TABLE SUPPLIER 
(
SID CHAR(5),-- Supplier ID
SNAME VARCHAR(30),-- Supplier name
SADDR VARCHAR(50),-- Supplier address
SCITY VARCHAR(15),-- Supplier city
SPHONE CHAR(15),-- Supplier phone number
SEMAIL VARCHAR(30));-- Supplier email

-- View the content of the SUPPLIER table
SELECT * FROM SUPPLIER; 

-- Add NOT NULL constraint to SID, SNAME, and SADDR columns of the SUPPLIER table
ALTER TABLE SUPPLIER
ALTER COLUMN SID CHAR(5) NOT NULL;

ALTER TABLE SUPPLIER
ALTER COLUMN SNAME VARCHAR(30) NOT NULL;

ALTER TABLE SUPPLIER
ALTER COLUMN SADDR VARCHAR(50) NOT NULL;

ALTER TABLE SUPPLIER
ALTER COLUMN SID CHAR(5) NOT NULL;

-- Add default value 'DELHI' to the SCITY column of the SUPPLIER table
ALTER TABLE SUPPLIER
ADD CONSTRAINT S_CITY DEFAULT 'DELHI' FOR SCITY;

-- Add unique constraint to the SPHONE column of the SUPPLIER table to ensure phone numbers are unique
ALTER TABLE SUPPLIER
ADD UNIQUE (SPHONE);

-- Add primary key constraint to the SID column of the SUPPLIER table to ensure uniqueness of supplier IDs
ALTER TABLE SUPPLIER
ADD CONSTRAINT SPP PRIMARY KEY (SID);


-- Create the PRODUCTS table to store information about products and link them to suppliers using the SID column
CREATE TABLE PRODUCTS
(
PID CHAR(5),-- Product ID
PDES VARCHAR(50),-- Product description
PRICE INT,-- Product price
CATEGORY VARCHAR(5),-- Product category
SID CHAR(5)-- Supplier ID (Foreign Key)
);

-- View the content of the PRODUCTS table
SELECT * FROM PRODUCTS;  

-- Add NOT NULL constraint to PID and PDES columns of the PRODUCTS table
ALTER TABLE PRODUCTS
ALTER COLUMN PID CHAR(5) NOT NULL;

ALTER TABLE PRODUCTS
ALTER COLUMN PDES VARCHAR(50) NOT NULL;

-- Add check constraint to the PRICE column of the PRODUCTS table to ensure price is greater than 0
ALTER TABLE PRODUCTS
ADD CONSTRAINT P_PRICE CHECK (PRICE > 0.0);

-- Add check constraint to the CATEGORY column of the PRODUCTS table to ensure valid categories are selected
ALTER TABLE PRODUCTS
ADD CONSTRAINT CAT CHECK(CATEGORY IN ('IT' ,'HA', 'HC'));

-- Add foreign key constraint to the SID column of the PRODUCTS table to link products to suppliers
ALTER TABLE PRODUCTS
ADD FOREIGN KEY(SID) REFERENCES SUPPLIER(SID);

-- Add primary key constraint to the PID column of the PRODUCTS table to ensure uniqueness of product IDs
ALTER TABLE PRODUCTS
ADD PRIMARY KEY (PID);

-- Create the STOCKS table to track stock levels of each product
CREATE TABLE STOCKS
(
PID CHAR(5),-- Product ID (Foreign Key)
SQTY INT,-- Stock quantity
RQL INT,-- Reorder level
MOQ INT-- Minimum order quantity
);

-- View the content of the STOCKS table
SELECT * FROM STOCKS; 

-- Add foreign key constraint to the PID column of the STOCKS table to link stocks to products
ALTER TABLE STOCKS
ADD FOREIGN KEY (PID) REFERENCES PRODUCTS (PID);

-- Add check constraint to the SQTY column of the STOCKS table to ensure stock quantity is greater than or equal to 0
ALTER TABLE STOCKS
ADD CONSTRAINT STOCK_QTY CHECK (SQTY>=0);

-- Add check constraint to the RQL column of the STOCKS table to ensure reorder level is greater than 0
ALTER TABLE STOCKS
ADD CONSTRAINT REORDER CHECK (RQL>0);

-- Add check constraint to the MOQ column of the STOCKS table to ensure minimum order quantity is greater than or equal to 5
ALTER TABLE STOCKS
ADD CONSTRAINT MIN_QTY CHECK (MOQ>=5);

-- Create the CUSTOMER table to store information about customers
CREATE TABLE CUSTOMER
(
CID CHAR(5),-- Customer ID
CNAME VARCHAR(25), -- Customer name
CADDR VARCHAR(50), -- Customer address
CITY VARCHAR(15),-- Customer city
PHONE VARCHAR(15),-- Customer phone number
EMAIL VARCHAR(40),-- Customer email
DOB DATE  -- Customer date of birth
);

-- View the content of the CUSTOMER table
SELECT * FROM CUSTOMER; 

-- Add NOT NULL constraint to CID, CNAME, CADDR, CITY, PHONE, and EMAIL columns of the CUSTOMER table
ALTER TABLE CUSTOMER
ALTER COLUMN CID CHAR(5) NOT NULL;

ALTER TABLE CUSTOMER
ALTER COLUMN CNAME VARCHAR(25) NOT NULL;

ALTER TABLE CUSTOMER
ALTER COLUMN CADDR VARCHAR(50) NOT NULL;

ALTER TABLE CUSTOMER
ALTER COLUMN CITY VARCHAR(15) NOT NULL;

ALTER TABLE CUSTOMER
ALTER COLUMN PHONE VARCHAR(15) NOT NULL;

ALTER TABLE CUSTOMER
ALTER COLUMN EMAIL VARCHAR(40) NOT NULL;

-- Add check constraint to the DOB column of the CUSTOMER table to ensure birthdates are before '01-JAN-2000'
ALTER TABLE CUSTOMER
ADD CONSTRAINT BIRTHDATE CHECK(DOB < '01-JAN-2000');

-- Add primary key constraint to the CID column of the CUSTOMER table to ensure uniqueness of customer IDs
ALTER TABLE CUSTOMER
ADD CONSTRAINT CUS PRIMARY KEY (CID);

-- Create the ORDERS table to store information about customer orders
CREATE TABLE ORDERS
(
OID CHAR(5), -- Order ID
ODATE DATE, -- Order date
PID CHAR(5),-- Product ID (Foreign Key)
CID CHAR(5),-- Customer ID (Foreign Key)
OQTY INT-- Order quantity
);

-- View the content of the ORDERS table
SELECT * FROM ORDERS; 

-- Add foreign key constraint to the PID column of the ORDERS table to link orders to products
ALTER TABLE ORDERS
ADD FOREIGN KEY (PID) REFERENCES PRODUCTS(PID);

-- Add foreign key constraint to the CID column of the ORDERS table to link orders to customers
ALTER TABLE ORDERS
ADD FOREIGN KEY (CID) REFERENCES CUSTOMER(CID);

-- Add NOT NULL constraint to the OID column of the ORDERS table
ALTER TABLE ORDERS
ALTER COLUMN OID CHAR(5) NOT NULL;

-- Add primary key constraint to the OID column of the ORDERS table to ensure uniqueness of order IDs
ALTER TABLE ORDERS
ADD PRIMARY KEY(OID);


---------INSERTING THE DATA--------


INSERT INTO SUPPLIER (SID, SNAME, SADDR, SPHONE, SEMAIL)
VALUES
  ('S001', 'Johns Suppliers', '123 Main Street', '9876543210', 'john@google.com'),
  ('S002', 'Smith Enterprises', '456 Park Road', '9876543211', 'smith@yahoo.com'),
  ('S003', 'Raj Traders', '789 Gandhi Nagar', '9876543212', 'raj@google.com'),
  ('S004', 'Sharma Distributors', '321 ABC Lane', '9876543213', 'sharma@yahoo.com'),
  ('S005', 'Gupta Merchants', '654 XYZ Avenue', '9876543214', 'gupta@google.com'),
  ('S006', 'Verma Traders', '987 Park Lane', '9876543215', 'verma@yahoo.com'),
  ('S007', 'Patel Distributors', '456 Patel Road', '9876543216', 'patel@google.com'),
  ('S008', 'Kumar Enterprises', '789 Kumar Street', '9876543217', 'kumar@yahoo.com'),
  ('S009', 'Reddy Traders', '321 Reddy Avenue', '9876543218', 'reddy@google.com'),
  ('S010', 'Singh Merchants', '654 Singh Road', '9876543219', 'singh@yahoo.com');

  SELECT * FROM SUPPLIER; 

INSERT INTO PRODUCTS (PID, PDES, PRICE, CATEGORY,SID)
VALUES
  ('P001', 'Laptop', 1000, 'IT','S001'),
  ('P002', 'Refrigerator', 800, 'HA','S002'),
  ('P003', 'Stethoscope', 50, 'HC','S003'),
  ('P004', 'Desktop Computer', 1200, 'IT','S004'),
  ('P005', 'Air Conditioner', 1000, 'HA','S005'),
  ('P006', 'Surgical Mask', 1, 'HC','S006'),
  ('P007', 'Smartphone', 900, 'IT','S007'),
  ('P008', 'Washing Machine', 700, 'HA','S008'),
  ('P009', 'Blood Pressure Monitor', 80, 'HC','S009'),
  ('P010', 'Wireless Earbuds', 100, 'IT','S010');

   SELECT * FROM PRODUCTS; 

INSERT INTO STOCKS (PID, SQTY, RQL, MOQ)
VALUES
  ('P001', 100, 20, 50),
  ('P002', 50, 10, 30),
  ('P003', 200, 30, 60),
  ('P004', 75, 15, 40),
  ('P005', 150, 25, 70),
  ('P006', 80, 10, 30),
  ('P007', 120, 35, 80),
  ('P008', 90, 20, 50),
  ('P009', 60, 15, 40),
  ('P010', 180, 30, 70);

   SELECT * FROM STOCKS; 

INSERT INTO CUSTOMER (CID, CNAME, CADDR, CITY, PHONE, EMAIL, DOB)
VALUES
  ('C001', 'Rajesh Kumar', '123 Main Street', 'Delhi', '9876543210', 'rajesh@google.com', '1990-06-15'),
  ('C002', 'Priya Sharma', '456 Park Road', 'Mumbai', '9876543211', 'priya@yahoo.com', '1992-02-18'),
  ('C003', 'Amit Patel', '789 Gandhi Nagar', 'Ahmedabad', '9876543212', 'amit@google.com', '1985-09-25'),
  ('C004', 'Sneha Gupta', '321 MG Road', 'Kolkata', '9876543213', 'sneha@yahoo.com', '1998-12-10'),
  ('C005', 'Rahul Singh', '654 Lake Gardens', 'Chennai', '9876543214', 'rahul@google.com', '1994-07-05'),
  ('C006', 'Neha Verma', '87 Park Lane', 'Delhi', '9876543215', 'neha@yahoo.com', '1989-04-20'),
  ('C007', 'Vivek Shah', '456 Satellite Road', 'Ahmedabad', '9876543216', 'vivek@google.com', '1997-11-12'),
  ('C008', 'Pooja Reddy', '789 Kukatpally Main Road', 'Hyderabad', '9876543217', 'pooja@yahoo.com', '1993-08-27'),
  ('C009', 'Sanjay Kapoor', '321 Model Town', 'Delhi', '9876543218', 'sanjay@google.com', '1996-03-08'),
  ('C010', 'Meera Singhania', '654 Park Circus', 'Kolkata', '9876543219', 'meera@yahoo.com', '1995-10-31');

  SELECT * FROM CUSTOMER; 

INSERT INTO ORDERS (OID, ODATE, PID, CID, OQTY)
VALUES
  ('O001', '2023-05-01', 'P001', 'C001', 5),
  ('O002', '2023-05-02', 'P002', 'C002', 3),
  ('O003', '2023-05-03', 'P003', 'C003', 2),
  ('O004', '2023-05-04', 'P004', 'C004', 4),
  ('O005', '2023-05-05', 'P005', 'C005', 1),
  ('O006', '2023-05-06', 'P006', 'C006', 6),
  ('O007', '2023-05-07', 'P007', 'C007', 2),
  ('O008', '2023-05-08', 'P008', 'C008', 3),
  ('O009', '2023-05-09', 'P009', 'C009', 5),
  ('O010', '2023-05-10', 'P010', 'C010', 2);
 
  SELECT * FROM ORDERS;


-- Concatenate data based on the requirement to display relevant information
-- Join PRODUCTS and SUPPLIER tables to retrieve product and supplier details

SELECT P.PID, P.PDES, P.CATEGORY, S.SNAME, S.SCITY
FROM PRODUCTS P
INNER JOIN SUPPLIER S ON P.SID = S.SID;
 

SELECT ORDERS.OID, ORDERS.ODATE,CUSTOMER.CNAME,CUSTOMER.CADDR, CUSTOMER.PHONE,PRODUCTS.PDES,PRODUCTS.PRICE,ORDERS.OQTY
FROM ORDERS
INNER JOIN CUSTOMER
ON 
CUSTOMER.CID=CUSTOMER.CID
INNER JOIN PRODUCTS 
ON ORDERS.PID=PRODUCTS.PID;


----------CREATING AUTO GENERATED BILL-------

-- Join ORDERS, CUSTOMER, and PRODUCTS tables to create a view with order details, customer information, and product information
CREATE VIEW BILL AS
SELECT ORDERS.OID, ORDERS.ODATE, CUSTOMER.CNAME, CUSTOMER.CADDR, CUSTOMER.PHONE, PRODUCTS.PDES, PRODUCTS.PRICE, ORDERS.OQTY, (PRODUCTS.PRICE * ORDERS.OQTY) AS AMOUNT
FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.CID = CUSTOMER.CID
INNER JOIN PRODUCTS ON ORDERS.PID = PRODUCTS.PID;

SELECT * FROM BILL;


----------- The BILL view will display order information along with the customer name, address, phone, and product details, including the calculated order amount.

-- Creating procedures for easy insertion of data into the respective tables

-- Procedure to add a new supplier to the SUPPLIER table
CREATE PROCEDURE ADDSUPPLIER
	@SID CHAR(5),
	@SNAME VARCHAR(30),
	@SADDR VARCHAR(50),
	@SCITY VARCHAR(15),
	@SPHONE CHAR(15),
	@SEMAIL VARCHAR(30)

AS
BEGIN
-- Insert the new supplier details into the SUPPLIER table
	INSERT INTO SUPPLIER (SID, SNAME,SADDR,SCITY,SPHONE,SEMAIL)
	VALUES (@SID, @SNAME,@SADDR,@SCITY,@SPHONE,@SEMAIL);

	-- Return the newly inserted supplier details
	SELECT * FROM SUPPLIER WHERE SID = @SID;
END;

-- Execute the ADDSUPPLIER procedure to add a new supplier with specified details
EXEC ADDSUPPLIER 'S1001', 'AKASH MEHRA', '123 Main Street', 'DEHRADUN', '1234567890', 'akashm@GOOGLE.com';

-- Procedure to add a new product to the PRODUCTS table
CREATE PROCEDURE ADDPRODUCTS
	@PID CHAR(5),
	@PDES VARCHAR(50),
	@PRICE INT,
	@CATEGORY VARCHAR(5),
	@SID CHAR(5)
AS
BEGIN
	-- Insert the new product details into the PRODUCTS table
	INSERT INTO PRODUCTS(PID,PDES,PRICE,CATEGORY,SID)
	VALUES (@PID, @PDES,@PRICE,@CATEGORY,@SID);

	-- Return the newly inserted product details
	SELECT * FROM PRODUCTS WHERE PID = @PID;
END;

-- Procedure to add a new customer to the CUSTOMER table
CREATE PROCEDURE ADDCUS
	@CID CHAR(5),
	@CNAME VARCHAR(25),
	@CADDR VARCHAR(50),
	@CITY VARCHAR(15),
	@PHONE VARCHAR(15),
	@EMAIL VARCHAR(40),
	@DOB DATE
	AS
BEGIN
-- Insert the new customer details into the CUSTOMER table
	INSERT INTO CUSTOMER (CID,CNAME,CADDR,CITY,PHONE,EMAIL,DOB)
	VALUES (@CID,@CNAME,@CADDR,@CITY,@PHONE,@EMAIL,@DOB);

	-- Return the newly inserted customer details
	SELECT * FROM CUSTOMER WHERE CID = @CID;
END;

-- Procedure to add a new order to the ORDERS table
CREATE PROCEDURE ADDORER
	@OID CHAR(5),
	@ODATE DATE,
	@PID CHAR(5),
	@CID CHAR(5),
	@OQTY INT
	AS
BEGIN
-- Insert the new order details into the ORDERS table
	INSERT INTO ORDERS (OID,ODATE,PID,CID,OQTY)
	VALUES (@OID,@ODATE,@PID,@CID,@OQTY);

	-- Return the newly inserted order details
	SELECT * FROM ORDERS WHERE OID = @OID;
END;

-- Drop the previously created procedures ADDPRODUCTS, ADDCUS, ADDORDER, ADDSUPPLIER for modification
DROP PROCEDURE ADDPRODUCTS;
DROP PROCEDURE ADDCUS;
DROP PROCEDURE ADDORDER;
DROP PROCEDURE ADDSUPPLIER;


------CREATING AUTOMATIC UPDATION OF ID (ADVANCING THE ABOVE PROCEDURE)----


-- Creating a function to generate new IDs with a specified initial character and an incremental integer value
CREATE FUNCTION NEW_ID (@INITIAL_CHAR CHAR (1) , @I INT)
RETURNS CHAR(5)
AS
BEGIN
DECLARE @ID CHAR(5);

 -- Using a CASE statement to concatenate the initial character with the incremental integer value
SELECT @ID = CASE

	WHEN @I < 10 THEN CONCAT(@INITIAL_CHAR,'000',@I)
	WHEN @I < 100 THEN CONCAT(@INITIAL_CHAR,'00',@I)
	WHEN @I < 1000 THEN CONCAT(@INITIAL_CHAR,'0',@I)
	WHEN @I < 10000 THEN CONCAT(@INITIAL_CHAR,@I)
	ELSE 'NA'
END;

-- Returning the generated ID
RETURN @ID;
END;


-- Creating sequences to generate incremental integer values for each table's IDs
CREATE SEQUENCE PRODUCTSSEQ
AS INT
START WITH 11
INCREMENT BY 1;

CREATE SEQUENCE SUPPLIERSEQ
AS INT
START WITH 11
INCREMENT BY 1;

CREATE SEQUENCE CUSTOMERSSEQ
AS INT
START WITH 11
INCREMENT BY 1;

CREATE SEQUENCE ORDERSSEQ
AS INT
START WITH 11
INCREMENT BY 1;

-- Updating the ADDPRODUCTS procedure to use the NEW_ID function to generate the product ID
CREATE PROCEDURE ADDPRODUCTS
	@PDES VARCHAR(50),
	@PRICE INT,
	@CATEGORY VARCHAR(5),
	@SID CHAR(5)
AS
BEGIN
	DECLARE @I CHAR(5);
	-- Generating a new product ID using the NEW_ID function and the PRODUCTSSEQ sequence
	SET @I=DBO.NEW_ID('P', NEXT VALUE FOR PRODUCTSSEQ);

	-- Inserting the new product details with the generated ID into the PRODUCTS table
	INSERT INTO PRODUCTS VALUES (@I,@PDES,@PRICE,@CATEGORY,@SID);

	-- Returning the newly inserted product details
	SELECT * FROM PRODUCTS WHERE PID = @I;
END;

-- Updating the ADDSUPPLIER procedure to use the NEW_ID function to generate the supplier ID
CREATE PROCEDURE ADDSUPPLIER
	@SNAME VARCHAR(30),
	@SADDR VARCHAR(50),
	@SCITY VARCHAR(15),
	@SPHONE CHAR(15),
	@SEMAIL VARCHAR(30)
AS
BEGIN
	DECLARE @I CHAR(5);
	-- Generating a new supplier ID using the NEW_ID function and the SUPPLIERSEQ sequence
	SET @I =DBO.NEW_ID('S', NEXT VALUE FOR SUPPLIERSEQ);

	-- Inserting the new supplier details with the generated ID into the SUPPLIER table
	INSERT INTO SUPPLIER VALUES (@I, @SNAME,@SADDR,@SCITY,@SPHONE,@SEMAIL);

	 -- Returning the newly inserted supplier details
	SELECT * FROM SUPPLIER WHERE SID = @I;
END;

-- Updating the ADDCUS procedure to use the NEW_ID function to generate the customer ID
CREATE PROCEDURE ADDCUS
	@CNAME VARCHAR(25),
	@CADDR VARCHAR(50),
	@CITY VARCHAR(15),
	@PHONE VARCHAR(15),
	@EMAIL VARCHAR(40),
	@DOB DATE
	AS
BEGIN
	DECLARE @I CHAR(5);
	-- Generating a new customer ID using the NEW_ID function and the CUSTOMERSSEQ sequence
	SET @I =DBO.NEW_ID('C',NEXT VALUE FOR CUSTOMERSSEQ);

	-- Inserting the new customer details with the generated ID into the CUSTOMER table
	INSERT INTO CUSTOMER VALUES (@I,@CNAME,@CADDR,@CITY,@PHONE,@EMAIL,@DOB);

	-- Returning the newly inserted customer details
	SELECT * FROM CUSTOMER WHERE CID = @I;
END;

-- Updating the ADDORDER procedure to use the NEW_ID function to generate the order ID
CREATE PROCEDURE ADDORDER
	@ODATE DATE,
	@PID CHAR(5),
	@CID CHAR(5),
	@OQTY INT
	AS
BEGIN
	DECLARE @I CHAR (5);
	-- Generating a new order ID using the NEW_ID function and the ORDERSSEQ sequence
	SET @I = DBO.NEW_ID ('O', NEXT VALUE FOR ORDERSSEQ);
	-- Inserting the new order details with the generated ID into the ORDERS table
	INSERT INTO ORDERS VALUES (@I,@ODATE,@PID,@CID,@OQTY);

	 -- Returning the newly inserted order details
	SELECT * FROM ORDERS WHERE OID = @I;
END;

ADDCUS 'RAMESH SHUKLS', 'NAVEGAON ROAD', 'AMRAVATI', '9960676978', 'rameshs@gmail>com', '09-06-1997';

ADDORDER '2023-05-10', 'P002', 'C0011' , '4';


---------CREATING TRIGGERS FOR AUTOMATIC VALUE UPDATION IN DATA BASED ON ORDERS------------

-- Creating a trigger to automatically update the stock quantity when new orders are inserted
CREATE TRIGGER TR_FOR_ORDERS
ON ORDERS
FOR INSERT
AS
BEGIN
 -- Declare variables to store quantity required and quantity in stock
	DECLARE @QTYREQUIRED AS INT
	DECLARE @QTYINSTOCK AS INT
	
	 -- Get the quantity in stock for the product being ordered
	SET @QTYINSTOCK = (SELECT SQTY FROM STOCKS WHERE PID = (SELECT PID FROM INSERTED));
	-- Get the quantity required for the order
	SET @QTYREQUIRED = (SELECT OQTY FROM INSERTED);

	-- Check if there is sufficient quantity in stock to fulfill the order
	IF @QTYINSTOCK >= @QTYREQUIRED
	BEGIN
	-- If there is enough stock, update the stock quantity by deducting the ordered quantity
		UPDATE STOCKS SET SQTY = SQTY - @QTYREQUIRED
		WHERE PID = (SELECT PID FROM INSERTED);

		COMMIT;-- Commit the transaction
		PRINT('ORDER HAS BEEN ACCEPTED')
	END;
ELSE
	ROLLBACK;-- Rollback the transaction if there is insufficient stock
	PRINT('SORRY INSUUFICIENT QUANTITY IN STOCK OF THE PRODUCT YOU WISH TO ORDER. 
ORDER REJECTED!');
END;

-- Creating a trigger to automatically delete stock information when a product is deleted
CREATE TRIGGER TR_DEL_FROM_STOCK
ON PRODUCTS
FOR DELETE
AS
BEGIN
 -- Delete the corresponding stock information of the deleted product
	DELETE FROM STOCKS
	WHERE PID =(SELECT PID FROM DELETED);
END;

-- Creating a trigger to automatically update the stock quantity when an order is updated
CREATE TRIGGER TR_UPDATE_ORDER_IN_STOCKS
ON ORDERS
FOR UPDATE
AS
BEGIN
-- Declare variables to store old and new order quantities
	DECLARE @OLDQTY AS INT;
	DECLARE @NEWQTY AS INT;

	-- Get the old order quantity and new order quantity
	SET @OLDQTY = (SELECT OQTY FROM DELETED);
	SET @NEWQTY = (SELECT OQTY FROM INSERTED);

	-- Update the stock quantity by adjusting the difference between old and new order quantities
	UPDATE STOCKS SET SQTY = SQTY + @OLDQTY -@NEWQTY
	WHERE PID = (SELECT PID FROM INSERTED);
END;



-----------To place the order of products from supplier if the quantity is depleting ---------

-- Creating a new table to store purchase orders
CREATE TABLE PURCHASE_ORDERS (
    POID CHAR(5),
    PODATE DATE,
    PID CHAR(5),
    PQTY INT
);

-- Creating a new sequence to generate unique IDs for purchase orders
CREATE SEQUENCE PURCHASEORDERSEQ
    START WITH 1
    INCREMENT BY 1;

-- Creating a procedure to insert new purchase orders into the PURCHASE_ORDERS table
CREATE PROCEDURE PURCHASE_ORDER
	@PODATE DATE,
	@PID CHAR(5),
	@PQTY INT
	AS
BEGIN
-- Declare a variable to store the generated ID for the new purchase order
	DECLARE @I CHAR(5);
	-- Generate a new ID using the custom function NEW_ID and the PURCHASEORDERSEQ sequence
	SET @I =DBO.NEW_ID('R',NEXT VALUE FOR PURCHASEORDERSEQ);
	-- Insert the new purchase order into the PURCHASE_ORDERS table
	INSERT INTO PURCHASE_ORDERS VALUES (@I,@PODATE, @PID, @PQTY);

	-- Return the inserted purchase order by selecting from the PURCHASE_ORDERS table with the generated ID
	SELECT * FROM PURCHASE_ORDERS WHERE POID = @I;
END;

-- Creating a procedure to update the stock quantity of a product
CREATE PROCEDURE UpdateStock
    @PID CHAR(5),
    @PQTY INT,
    @RQL INT,
    @MOQ INT
AS
BEGIN
-- Check if the product already exists in the STOCKS table
    IF EXISTS (SELECT 1 FROM STOCKS WHERE PID = @PID)
    BEGIN
	-- If the product exists, update the stock quantity by adding the purchased quantity
        UPDATE STOCKS
        SET SQTY = SQTY + @PQTY
        WHERE PID = @PID;
    END;
	 -- If the product does not exist, you might want to handle the situation accordingly, perhaps by inserting a new stock entry.
END;
------------------------------------------------------------
----CONCLUSION OF THE INVENTORY---------

-- Conclusion:
-- In conclusion, the inventory management project has been successfully designed and implemented, offering a comprehensive solution for efficiently managing suppliers, products, stock levels, customer orders, and purchase orders. 

-- Database Design:
-- The project involves the creation of various tables, views, procedures, and triggers to ensure smooth and reliable operations. The database includes tables for suppliers, products, stocks, customers, and orders, each carefully designed with appropriate data types and constraints to maintain data integrity.

-- Supplier and Product Information:
-- Supplier information such as name, address, phone, and email is recorded in the SUPPLIER table. Products are classified based on their description, price, and category in the PRODUCTS table.

-- Stock Management:
-- Stock levels, including quantity available, reorder level, and minimum order quantity, are tracked in the STOCKS table. The UpdateStock procedure is used to automatically update stock quantities when new products are added or received.

-- Customer and Order Management:
-- Customer details, including name, address, phone, email, and date of birth, are stored in the CUSTOMER table, while customer orders are recorded in the ORDERS table, capturing the order date, product, and quantity. The Purchase_Order procedure is implemented to add new purchase orders.

-- Views:
-- To facilitate data retrieval and analysis, views such as BILL have been created, offering a consolidated view of customer orders and their total amounts.

-- Procedures:
-- The project incorporates procedures like ADDSUPPLIER, ADDPRODUCTS, ADDCUS, and ADDORDER for easy insertion of new data into respective tables. These procedures have been enhanced with the implementation of the NEW_ID function and sequences to automatically generate unique IDs for each new record, reducing manual input errors and ensuring data integrity.

-- Triggers:
-- Triggers have been introduced to enforce business rules. The TR_FOR_ORDERS trigger automatically updates the stock quantity when new orders are placed, ensuring that stock levels are adjusted accordingly. The TR_DEL_FROM_STOCK trigger deletes corresponding stock records when products are removed from the database, maintaining consistency between tables. The TR_UPDATE_ORDER_IN_STOCKS trigger updates stock quantities when order quantities are modified, preserving accurate stock data.

-- Overall Impact:
-- The inventory management project provides a robust and efficient solution to handle inventory-related operations, ensuring a seamless experience for suppliers, customers, and inventory managers. It enables real-time tracking of stock levels, simplifies the ordering process, and promotes better decision-making based on comprehensive and up-to-date information.


-- The successful implementation of this project contributes to streamlined inventory management, optimized stock control, and improved overall business performance.


-- Conclusion:
-----By using this structure, the inventory system can manage suppliers, products, stock levels, customer orders, and purchase orders. 
----It ensures that products are available in stock, tracks customer orders, and facilitates the replenishment of stock through purchase orders.-----