USE SportStore;
GO

-- Creating the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Quantity INT,
    Price MONEY
);
GO

-- Creating the EmployeeArchive table for archiving employees
CREATE TABLE EmployeeArchive (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    HireDate DATE,
    Gender NVARCHAR(10),
    Salary MONEY
);
GO


-- Creating the Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    HireDate DATE,
    Gender NVARCHAR(10),
    Salary MONEY
);
GO

-- Creating a trigger to move information of a deleted employee to the EmployeeArchive table
CREATE TRIGGER MoveEmployeeToArchive
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeArchive (EmployeeID, FullName, Position, HireDate, Gender, Salary)
    SELECT EmployeeID, FullName, Position, HireDate, Gender, Salary
    FROM deleted;
END;
GO

-- Creating a trigger to prevent adding a new seller if the number of existing sellers is greater than 6
CREATE TRIGGER PreventAddingSeller
ON Employees
AFTER INSERT
AS
BEGIN
    DECLARE @SellerCount INT;
    SELECT @SellerCount = COUNT(*) FROM Employees WHERE Position = 'Seller';

    IF @SellerCount > 6
    BEGIN
        RAISERROR ('Cannot add new seller. Maximum seller limit reached.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Inserting some sample data for demonstration purposes
INSERT INTO Products (Name, Quantity, Price)
VALUES ('Running Shoes', 10, 50.00),
       ('Basketball', 5, 25.00);
GO

INSERT INTO Employees (FullName, Position, HireDate, Gender, Salary)
VALUES ('John Doe', 'Manager', '2023-01-15', 'Male', 60000.00),
       ('Jane Smith', 'Seller', '2023-02-20', 'Female', 40000.00);
GO
