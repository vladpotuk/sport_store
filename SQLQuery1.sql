CREATE DATABASE SportStore;
GO

-- Using the SportStore database
USE SportStore;
GO

-- Table for storing products information
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Quantity INT,
    Cost MONEY,
    Manufacturer NVARCHAR(100),
    SalePrice MONEY
);
GO

-- Table for storing employees information
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    HireDate DATE,
    Gender NVARCHAR(10),
    Salary MONEY
);
GO

-- Table for storing customers information
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
GO

-- Table for storing sales information
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    SalePrice MONEY,
    Quantity INT,
    SaleDate DATE,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);
GO

-- Trigger to insert sales information into the "History" table
CREATE TRIGGER InsertIntoHistory
ON Sales
AFTER INSERT
AS
BEGIN
    INSERT INTO History (SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
    SELECT SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID
    FROM inserted;
END;
GO

-- Trigger to prevent inserting existing customers
CREATE TRIGGER PreventDuplicateCustomers
ON Customers
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers c INNER JOIN inserted i ON c.FullName = i.FullName OR c.Email = i.Email)
    BEGIN
        RAISERROR ('Customer already exists!', 16, 1);
    END;
    ELSE
    BEGIN
        INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountPercentage, SubscribedToNewsletter)
        SELECT FullName, Email, Phone, Gender, OrderHistory, DiscountPercentage, SubscribedToNewsletter
        FROM inserted;
    END;
END;
GO

-- Trigger to prevent deleting existing customers
CREATE TRIGGER PreventDeleteCustomers
ON Customers
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('Deletion of existing customers is not allowed!', 16, 1);
END;
GO

-- Trigger to prevent deleting employees hired before 2015
CREATE TRIGGER PreventDeleteEmployees
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted WHERE HireDate < '2015-01-01')
    BEGIN
        RAISERROR ('Deletion of employees hired before 2015 is not allowed!', 16, 1);
    END;
    ELSE
    BEGIN
        DELETE FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM deleted);
    END;
END;
GO

-- Trigger to set discount percentage for new customers based on total purchase amount
CREATE TRIGGER SetDiscountForNewCustomers
ON Sales
AFTER INSERT
AS
BEGIN
    DECLARE @CustomerID INT;
    DECLARE @TotalPurchase MONEY;
    DECLARE @DiscountPercentage DECIMAL(5,2);

    SELECT @CustomerID = i.CustomerID
    FROM inserted i;

    SELECT @TotalPurchase = SUM(s.SalePrice * s.Quantity)
    FROM Sales s
    WHERE s.CustomerID = @CustomerID;

    IF @TotalPurchase > 50000
    BEGIN
        SET @DiscountPercentage = 15.00;
    END;
    ELSE
    BEGIN
        SET @DiscountPercentage = 0.00;
    END;

    UPDATE Customers
    SET DiscountPercentage = @DiscountPercentage
    WHERE CustomerID = @CustomerID;
END;
GO

-- Trigger to prevent adding products from specific manufacturers
CREATE TRIGGER PreventSpecificManufacturerProducts
ON Products
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Manufacturer = 'Спорт, сонце та штанга')
    BEGIN
        RAISERROR ('Adding products from specific manufacturer is not allowed!', 16, 1);
    END;
    ELSE
    BEGIN
        INSERT INTO Products (Name, Category, Quantity, Cost, Manufacturer, SalePrice)
        SELECT Name, Category, Quantity, Cost, Manufacturer, SalePrice
        FROM inserted;
    END;
END;
GO

-- Trigger to check product quantity during sale and insert into "Last Unit" table if only one unit left
CREATE TRIGGER CheckProductQuantity
ON Sales
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;

    SELECT @ProductID = i.ProductID,
           @Quantity = p.Quantity
    FROM inserted i
    INNER JOIN Products p ON i.ProductID = p.ProductID;

    IF @Quantity = 1
    BEGIN
        INSERT INTO LastUnit (ProductID, Name, Category, Quantity, Cost, Manufacturer, SalePrice)
        SELECT ProductID, Name, Category, Quantity, Cost, Manufacturer, SalePrice
        FROM Products
        WHERE ProductID = @ProductID;
    END;
END;
GO
