USE SportStore;
GO

-- Inserting sample data into the Products table
INSERT INTO Products (Name, Category, Quantity, Cost, Manufacturer, SalePrice)
VALUES ('Running Shoes', 'Footwear', 50, 50.00, 'Nike', 100.00),
       ('Basketball', 'Sports Equipment', 30, 20.00, 'Adidas', 40.00),
       ('Tennis Racket', 'Sports Equipment', 20, 30.00, 'Wilson', 60.00);
GO

-- Inserting sample data into the Employees table
INSERT INTO Employees (FullName, Position, HireDate, Gender, Salary)
VALUES ('John Smith', 'Sales Manager', '2022-03-15', 'Male', 50000.00),
       ('Emily Johnson', 'Sales Associate', '2022-04-01', 'Female', 35000.00),
       ('Michael Williams', 'Store Manager', '2022-02-20', 'Male', 60000.00);
GO

-- Inserting sample data into the Customers table
INSERT INTO Customers (FullName, Email, Phone, Gender, OrderHistory, DiscountPercentage, SubscribedToNewsletter)
VALUES ('Alice Brown', 'alice@example.com', '123-456-7890', 'Female', 'Order history data...', 0.00, 1),
       ('Bob Green', 'bob@example.com', '987-654-3210', 'Male', 'Order history data...', 5.00, 0),
       ('Emma Davis', 'emma@example.com', '456-789-0123', 'Female', 'Order history data...', 10.00, 1);
GO

-- Inserting sample data into the Sales table
INSERT INTO Sales (ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
VALUES (1, 100.00, 2, '2024-04-01', 1, 1),
       (2, 40.00, 1, '2024-04-02', 2, 2),
       (3, 60.00, 3, '2024-04-03', 3, 3);
GO

-- Inserting sample data into the History table
INSERT INTO History (SaleID, ProductID, SalePrice, Quantity, SaleDate, EmployeeID, CustomerID)
VALUES (1, 1, 100.00, 2, '2024-04-01', 1, 1),
       (2, 2, 40.00, 1, '2024-04-02', 2, 2),
       (3, 3, 60.00, 3, '2024-04-03', 3, 3);
GO

-- Inserting sample data into the LastUnit table
INSERT INTO LastUnit (ProductID, Name, Category, Quantity, Cost, Manufacturer, SalePrice)
VALUES (1, 'Running Shoes', 'Footwear', 1, 50.00, 'Nike', 100.00),
       (2, 'Basketball', 'Sports Equipment', 2, 20.00, 'Adidas', 40.00),
       (3, 'Tennis Racket', 'Sports Equipment', 1, 30.00, 'Wilson', 60.00);
GO
