# Creation of Database that will hold the table 

CREATE DATABASE sales;

USE sales;

# Creation of table within the 'Sales' Database.
# Detailed Database Framework complete with definitive constraints
# Good table structure allows for ease of use for future users 
# I chose not to assign foreign keys as this is the only table in the database

CREATE TABLE
	salesRecords(
    `order_id` INT NOT NULL,
    `order_date` DATE NOT NULL,
    `status_of_order` VARCHAR(15) NOT NULL,
    `item_id` INT NOT NULL,
    `sku` VARCHAR(150) NOT NULL,
    `qty_ordered` INT NOT NULL,
    `price` DECIMAL(8,2) NOT NULL,
    `value_of_order` DECIMAL NOT NULL,
    `discount_amount` DECIMAL NOT NULL DEFAULT '0',
    `total` DECIMAL NOT NULL,
    `category` VARCHAR(150) NOT NULL,
    `payment_method` VARCHAR(25) NOT NULL,
    `bi_st` VARCHAR(25) NOT NULL,
    `cust_id` INT NOT NULL,
    `year_of_order` INT NOT NULL,
    `month_of_order` VARCHAR(8) NOT NULL,
    `ref_num` INT NOT NULL,
    `Name_Prefix` VARCHAR(8) NOT NULL,
    `First_Name` VARCHAR(50) NOT NULL,
    `Middile_Initial` VARCHAR(50) NOT NULL,
    `Last_Name` VARCHAR (50) NOT NULL,
    `Gender` CHAR(1) NOT NULL,
    `age` INT NOT NULL,
    `full_name` VARCHAR(100) NOT NULL,
    `Email` VARCHAR(100) NOT NULL,
    `Customer_Since` DATE NOT NULL,
    `SSN` VARCHAR(11) NOT NULL,
    `Phone_No` VARCHAR(20) NOT NULL,
    `Place_Name` VARCHAR(50) NOT NULL,
    `County` VARCHAR(50) NOT NULL,
    `City` VARCHAR(50) NOT NULL,
    `State` VARCHAR(2) NOT NULL,
    `Zip` INT NOT NULL,
    `Region` VARCHAR(50) NOT NULL,
    `User_Name` VARCHAR(50) NOT NULL,
    `Discount_percent` DECIMAL NOT NULL DEFAULT '0',
    PRIMARY KEY (order_id)
    );
    
    
# extraction of data, to complete this task I had to convert all column names in the excel file so it suited csv format, this 
# change would facilitate easy extraction of the data within the excel database, as csv files are easier to read than xlsx for MySQL
# changes made to the column name are as follows
# order_id,order_date,status_of_order,item_id,sku,qty_ordered,price,value_of_order,discount_amount,total,category,payment_method,bi_st,
# cust_id,year_of_order,month_of_order,ref_num,Name_Prefix,First_Name,Middle_Initial,Last_Name,Gender,age,full_name,Email,Customer_Since,
# SSN,Phone_No,Place_Name,County,City,State,Zip,Region,User_Name,Discount_Percent

# note - when importing data I received error - 
# Row import failed with error: ("Duplicate entry '100514434' for key 'salesrecords.PRIMARY'", 1062)
        
# After the data extraction from the CSV excel file was complete I began to query
# the data to check the dataset was clean and ready to be visualised in tableau.

# Full discount amount accross all orders
SELECT SUM(discount_amount)
FROM salesRecords;

# Calculating monthly sales report totals
SELECT year_of_order, month_of_order, SUM(total)
FROM salesRecords
GROUP BY year_of_order, month_of_order
ORDER BY year_of_order, month_of_order;

# Calculating running totals for each customer
SELECT cust_id, SUM(total)
FROM salesRecords
GROUP BY cust_id
ORDER BY SUM(total) DESC;

# Calculating average sales per state per month
SELECT State, month_of_order, AVG(total)
FROM salesRecords
GROUP BY State, month_of_order
ORDER BY State, month_of_order;

# Calculating best performing cities (sales)
SELECT City, SUM(total)
FROM salesRecords
GROUP BY City
ORDER BY SUM(total) DESC;