SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

--Start Transaction A
INSERT INTO Orders (OrderID, CustomerID, RestaurantID, OrderDate, OStatus, TotalPrice)
-> VALUES (202, 1, 1, '2023-10-11', 'Pending', 500.00);

SELECT TotalPrice FROM Orders WHERE OrderID = 202; -- Should return 500.00

BEGIN; -- Start Transaction B

UPDATE Orders SET TotalPrice = TotalPrice + 200 WHERE OrderID = 202;

