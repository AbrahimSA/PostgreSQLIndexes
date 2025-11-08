-- 1️⃣ B-tree
SELECT run_benchmark('B-tree Range Query', 'B-tree',
    $$SELECT * FROM Orders WHERE OrderDate BETWEEN '2024-01-01' AND '2024-06-30'$$);

-- 2️⃣ Hash
SELECT run_benchmark('Email Equality', 'Hash',
    $$SELECT * FROM Customers WHERE Email = 'user150@example.com'$$);

-- 3️⃣ GIN Full-text
SELECT run_benchmark('Full-text Search', 'GIN',
    $$SELECT ProductID FROM Products WHERE to_tsvector('english', Description) @@ to_tsquery('product & 50')$$);

-- 4️⃣ BRIN
SELECT run_benchmark('Recent Orders (30d)', 'BRIN',
    $$SELECT * FROM Orders WHERE OrderDate > CURRENT_DATE - 30$$);

-- 5️⃣ Multi-column
SELECT run_benchmark('Orders by Customer+Date', 'Multi-column',
    $$SELECT * FROM Orders WHERE CustomerID = 10 AND OrderDate > '2024-01-01'$$);

-- 6️⃣ Partial Index
SELECT run_benchmark('High-Value Orders', 'Partial',
    $$SELECT * FROM Orders WHERE Total > 500$$);

-- 7️⃣ Expression Index
SELECT run_benchmark('Case-insensitive Email', 'Expression',
    $$SELECT * FROM Customers WHERE lower(Email) = lower('USER20@EXAMPLE.COM')$$);

-- 8️⃣ Covering Index
SELECT run_benchmark('Index-only Scan', 'Covering',
    $$SELECT OrderDate, Total FROM Orders WHERE OrderDate > '2024-01-01'$$);

-- 9️⃣ Combining Multiple Indexes
SELECT run_benchmark('Combined Index Filters', 'BitmapAnd',
    $$SELECT * FROM Orders WHERE CustomerID = 50 AND Total > 200$$);

-- 🔟 Collation-aware Search
SELECT run_benchmark('City Prefix Search', 'Operator Class',
    $$SELECT * FROM Customers WHERE City ILIKE 'new%'$$);
