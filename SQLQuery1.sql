-- Using the SportStore database
USE SportStore;
GO

-- Deleting all discontinued products from the Products table
DELETE FROM Products WHERE Discontinued = 1;
GO

-- Deleting all employees who left the company
DELETE FROM Employees WHERE EmploymentStatus = 'Left';
GO

-- Deleting all inactive customers who haven't made a purchase in the last year
DELETE FROM Customers WHERE LastPurchaseDate < DATEADD(YEAR, -1, GETDATE()) AND IsActive = 0;
GO

-- Deleting all sales made before 2023
DELETE FROM Sales WHERE SaleDate < '2023-01-01';
GO

-- Deleting all outdated records from the History table
DELETE FROM History WHERE SaleDate < DATEADD(MONTH, -6, GETDATE());
GO

-- Deleting all products with zero quantity left
DELETE FROM LastUnit WHERE Quantity = 0;
GO
