CREATE DATABASE SportStore;

USE SportStore;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Quantity INT,
    Cost MONEY,
    Manufacturer NVARCHAR(100),
    SalePrice MONEY
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    SalePrice MONEY,
    Quantity INT,
    SaleDate DATE,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    HireDate DATE,
    Gender NVARCHAR(10),
    Salary MONEY
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Gender NVARCHAR(10),
    OrderHistory NVARCHAR(MAX),
    DiscountPercentage DECIMAL(5,2),
    SubscribedToNewsletter BIT
);
