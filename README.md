# FAN-RELATIONAL_DB-PROJECT1
Set up of project 1 of Relational database

Additional Constraints for the Projects Tables
• Categories Table
o Add a new column CategoryCode NUMBER(6,0)
▪ Unique Constraint
o CategoryName NOT NULL
o You can just add the columns to your existing script, in the real world
we’d use the ALTER TABLE command we saw last week to add the new
column
• Product Table
o Check constraints
▪ UnitPrice column greater than or equal to 0
▪ ReorderLevel greater than or equal to 0
▪ UnitsInStock greater than or equal to 0
▪ UnitsOnOrder greater than or equal to 0
o ProductName NOT NULL
• OrderDetails
o Check constraints
▪ Discount greater than or equal to 0 and less than or equal 1 (used
as a percentage, .05 = 5%)
▪ Quantity greater than 0
▪ UnitPrice greater than or equal to 0
o ProductID NOT NULL
o UnitPrice NOT NULL
o Quantity NOT NULL
o Discount NOT NULL
• Customers
o CompanyName NOT NULL
o Add a new column called Email VARCHAR2(50)
▪ Unique Constraint
• Employees
o Add a new columns SIN CHAR(9)
▪ Unique Constraint
o LastName NOT NULL
o FirstName NOT NULL
• Suppliers
o CompanyName NOT NULL
• Shippers
o CompanyName NOT NULL
By adding these to your script you should end up with 26 constraints (doesn’t include
the NOT NULL constraints) on your tables:
o 8 Primary Key
o 8 Foreign Key
o 3 Unique Key
o 7 Check
Table Creation Order
The order you create the tables in is important, some constraints (FK’s) rely on other
tables. To reduce errors, create the tables in this order:
1. customers
2. employees
3. shippers
4. suppliers
5. categories
6. orders
7. products
8. orderdetails
Inserting Data Rows
New rows can be added to a table using the INSERT command. If the actual data
values to be entered are provided, the data are listed in a VALUES clause. Unless data
for every column is provided and the data is listed in the same order as the data is
stored in the database table, a column list must be specified in the INSERT INTO
clause. In addition, a column must be ignored in an INSERT if a DEFAULT value
assignment is desired.
Here is an example to insert a row of data into the Shippers table in the Projects
database:
 INSERT INTO Shippers(ShipperID, CompanyName, Phone) VALUES
 (1, 'SPEEDY EXPRESS', '(503) 555-9831');
Also, remember, another technique to do an insert is to copy the data from an existing
table using a sub-query. With this technique, the VALUES clause is omitted, and the
sub query is inserted after the name of the destination table. In addition, the sub query
is not required to be enclosed in parentheses; we saw an example of this technique last
class.
There is a common script on FOL in the week 5 content area to load the tables in the
correct order.