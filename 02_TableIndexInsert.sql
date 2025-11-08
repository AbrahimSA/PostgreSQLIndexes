-- ==========================================
-- SCHEMA & TABLES
-- ==========================================
DROP SCHEMA IF EXISTS ecommerce CASCADE;
CREATE SCHEMA ecommerce;
SET search_path TO ecommerce;

CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT,
    Email TEXT UNIQUE,
    City TEXT,
    SignupDate DATE DEFAULT CURRENT_DATE - (random() * 1000)::int
);

CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName TEXT,
    Category TEXT,
    Price NUMERIC(10,2),
    InStock INT,
    Description TEXT
);

CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    OrderDate DATE DEFAULT CURRENT_DATE - (random() * 365)::int,
    Total NUMERIC(10,2)
);

CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity INT,
    Price NUMERIC(10,2)
);

-- ==========================================
-- DATA POPULATION
-- ==========================================
INSERT INTO Customers (FirstName, LastName, Email, City)
SELECT 'First' || g, 'Last' || g, 'user' || g || '@example.com',
       CASE WHEN g % 5 = 0 THEN 'New York'
            WHEN g % 5 = 1 THEN 'Los Angeles'
            WHEN g % 5 = 2 THEN 'Chicago'
            WHEN g % 5 = 3 THEN 'Houston'
            ELSE 'Miami' END
FROM generate_series(1,300) AS g;

INSERT INTO Products (ProductName, Category, Price, InStock, Description)
SELECT 'Product ' || g,
       CASE WHEN g % 4 = 0 THEN 'Electronics'
            WHEN g % 4 = 1 THEN 'Clothing'
            WHEN g % 4 = 2 THEN 'Books'
            ELSE 'Home' END,
       (random() * 500)::numeric(10,2),
       (random() * 100)::int,
       'This is product ' || g
FROM generate_series(1,5000) AS g;

INSERT INTO Orders (CustomerID, OrderDate, Total)
SELECT (random() * 299 + 1)::int,
       CURRENT_DATE - ((random() * 365)::int),
       (random() * 1000)::numeric(10,2)
FROM generate_series(1,3000);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
SELECT (random() * 2999 + 1)::int,
       (random() * 4999 + 1)::int,
       (random() * 10 + 1)::int,
       (random() * 500)::numeric(10,2)
FROM generate_series(1,3000);

ANALYZE;
