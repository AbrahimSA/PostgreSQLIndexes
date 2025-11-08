-- Common indexes for all tests
CREATE INDEX idx_orders_orderdate ON Orders(OrderDate);
CREATE INDEX idx_customers_email_hash ON Customers USING HASH(Email);
CREATE INDEX idx_products_desc_gin ON Products USING GIN (to_tsvector('english', Description));
CREATE INDEX idx_orders_date_brin ON Orders USING BRIN(OrderDate);
CREATE INDEX idx_orders_customer_date ON Orders(CustomerID, OrderDate);
CREATE INDEX idx_orders_highvalue ON Orders(Total) WHERE Total > 500;
CREATE INDEX idx_lower_email ON Customers ((lower(Email)));
CREATE INDEX idx_orders_covering ON Orders (OrderDate) INCLUDE (Total);
CREATE INDEX idx_customers_city_nocase ON Customers (City COLLATE "C" varchar_pattern_ops);
CREATE INDEX idx_orders_customerid ON Orders(CustomerID);
CREATE INDEX idx_orders_total ON Orders(Total);
ANALYZE;
