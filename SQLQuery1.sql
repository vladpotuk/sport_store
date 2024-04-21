USE SportStore;
GO

-- Retrieve all products in the "Running Shoes" category
SELECT * FROM Products WHERE Category = 'Running Shoes';
GO

-- Retrieve all employees hired after January 1, 2018
SELECT * FROM Employees WHERE HireDate > '2018-01-01';
GO

-- Retrieve all customers who subscribed to the newsletter
SELECT * FROM Customers WHERE SubscribedToNewsletter = 1;
GO

-- Retrieve all sales made by employee with ID 101
SELECT * FROM Sales WHERE EmployeeID = 101;
GO

-- Retrieve sales history for the past year
SELECT * FROM History WHERE SaleDate >= DATEADD(YEAR, -1, GETDATE());
GO

-- Retrieve products with only two units left
SELECT * FROM LastUnit WHERE Quantity = 2;
GO
