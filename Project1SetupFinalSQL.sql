-- Customers table
DROP TABLE Customers CASCADE CONSTRAINTS;
CREATE TABLE Customers
(
    CustomerId CHAR(5),
    CompanyName VARCHAR2(40) NOT NULL,
    ContactName VARCHAR2(30),
    ContactTitle VARCHAR2(30),
    Address VARCHAR2(60),
    City VARCHAR2(15),  
    Region VARCHAR2(15),
    PostalCode VARCHAR2(10),
    Country VARCHAR2(15),
    Phone VARCHAR2(24),
    Fax VARCHAR2(24),
    Email VARCHAR2(50),
    CONSTRAINT Customers_CustomerId_pk PRIMARY KEY (CustomerId),
    CONSTRAINT Customers_Email_UK UNIQUE(Email)
);

-- Employees table 
DROP TABLE Employees CASCADE CONSTRAINTS;
CREATE TABLE Employees
(
    EmployeeId NUMBER(8,0),
    LastName VARCHAR2(20) NOT NULL,
    FirstName VARCHAR2(10) NOT NULL,
    Title VARCHAR2(30),
    TitleOfCourtesy VARCHAR2(25),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR2(60),
    City VARCHAR2(15),  
    Region VARCHAR2(15),
    PostalCode VARCHAR2(10),
    Country VARCHAR2(15),
    HomePhone VARCHAR2(24),
    Extension VARCHAR2(4),
    Notes VARCHAR2(600),
    ReportsTo NUMBER(8,0),
    PhotoPath VARCHAR2(255),
    SIN CHAR(9),
    CONSTRAINT Employees_EmployeeId_pk PRIMARY KEY (EmployeeId),
    CONSTRAINT Employees_SIN_UK UNIQUE(SIN),
    CONSTRAINT Employees_Employees_fk FOREIGN KEY (ReportsTo) REFERENCES Employees(EmployeeId)
);

-- Shippers table
DROP TABLE Shippers CASCADE CONSTRAINTS;
CREATE TABLE Shippers
(
    ShipperId NUMBER(8,0),
    CompanyName VARCHAR2(40) NOT NULL, 
    Phone VARCHAR2(24),
    CONSTRAINT Shippers_ShipperId_pk PRIMARY KEY (ShipperId)
);

-- Suppliers table
DROP TABLE Suppliers CASCADE CONSTRAINTS;
CREATE TABLE Suppliers
(
    SupplierId NUMBER(8,0),
    CompanyName VARCHAR2(40) NOT NULL,
    ContactName VARCHAR2(30),
    ContactTitle VARCHAR2(30),
    Address VARCHAR2(60),
    City VARCHAR2(15),
    Region VARCHAR2(15),
    PostalCode VARCHAR2(10),
    Country VARCHAR2(15),
    Phone VARCHAR2(24),
    Fax VARCHAR2(24),
    HomePage VARCHAR2(200),
    CONSTRAINT Suppliers_SupplierId_pk PRIMARY KEY (SupplierId)
);

-- Categories table
DROP TABLE Categories CASCADE CONSTRAINTS;
CREATE TABLE Categories
(
    CategoryId NUMBER(8,0),
    CategoryName VARCHAR2(15) NOT NULL,
    CategoryCode NUMBER(6,0),
    Description VARCHAR2(300),
    CONSTRAINT Categories_CategoryId_pk PRIMARY KEY (CategoryId),
    CONSTRAINT Categories_CategoryCode_UK UNIQUE(CategoryCode)
);

-- Orders table 
DROP TABLE Orders CASCADE CONSTRAINTS;
CREATE TABLE Orders
(
    OrderId NUMBER(8,0),
    CustomerId CHAR(5),
    EmployeeId NUMBER(8,0),
    TerritoryId VARCHAR2(20),
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia NUMBER (8,0),
    Freight NUMBER (8,2),
    ShipName VARCHAR2(40),
    ShipAddress VARCHAR2(60),
    ShipCity VARCHAR2(15),
    ShipRegion VARCHAR2(15),
    ShipPostalCode VARCHAR2(10),
    ShipCountry VARCHAR2(15),
    CONSTRAINT Orders_OrderId_pk PRIMARY KEY (OrderId),
    CONSTRAINT Orders_Customers_fk FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerID),
    CONSTRAINT Orders_Employees_fk FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId),
    CONSTRAINT Orders_Shippers_fk FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperId)
);

-- Products table 
DROP TABLE Products CASCADE CONSTRAINTS;
CREATE TABLE Products
(
    ProductId NUMBER(8,0),
    ProductName VARCHAR2(40) NOT NULL,
    SupplierId NUMBER(8,0),
    CategoryId NUMBER(8,0),
    QuantityPerUnit VARCHAR2(20),
    UnitPrice NUMBER(8,2),
    UnitsInStock NUMBER(6,0),
    UnitsOnOrder NUMBER(6,0),
    ReorderLevel NUMBER(6,0),
    Discontinued NUMBER(1,0) NOT NULL,
    CONSTRAINT Products_ProductId_pk PRIMARY KEY (ProductId),
    CONSTRAINT Products_UnitPrice_CK CHECK(UnitPrice >= 0),
    CONSTRAINT Products_ReorderLevel_CK CHECK(ReorderLevel >= 0),
    CONSTRAINT Products_UnitsInStock_CK CHECK(UnitsInStock >= 0),
    CONSTRAINT Products_UnitsOnOrder_CK CHECK(UnitsOnOrder >= 0),
    CONSTRAINT Products_Suppliers_fk FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId),
    CONSTRAINT Products_Categories_fk FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- Order Details table 
DROP TABLE OrderDetails CASCADE CONSTRAINTS;
CREATE TABLE OrderDetails
(
    OrderId NUMBER(8,0),
    ProductId NUMBER(8,0) NOT NULL,
    UnitPrice NUMBER(8,2) NOT NULL,
    Quantity NUMBER(6,0) NOT NULL,
    Discount NUMBER(2,2) NOT NULL,
    CONSTRAINT OrderDetails_OrderId_ProductId_pk PRIMARY KEY (OrderId, ProductId),
    CONSTRAINT OrderDetails_Discount_CK CHECK(Discount >= 0 AND Discount <= 1),
    CONSTRAINT OrderDetails_Quantity_CK CHECK(Quantity > 0),
    CONSTRAINT OrderDetails_UnitPrice_CK CHECK(UnitPrice >= 0),
    CONSTRAINT OrderDetails_Orders_fk FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT OrderDetails_Products_fk FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);