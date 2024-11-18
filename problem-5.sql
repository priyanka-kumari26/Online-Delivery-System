WITH RECURSIVE CustomerOrders AS (
   SELECT
     CustomerID,
     RestaurantID,
     1 AS OrderCount
   FROM Orders
   UNION ALL
   SELECT
     co.CustomerID,
     o.RestaurantID,
     co.OrderCount + 1
   FROM CustomerOrders co
   JOIN (
     SELECT
       CustomerID,
       RestaurantID,
       OrderID,
       ROW_NUMBER() OVER (PARTITION BY CustomerID, RestaurantID ORDER BY OrderID) AS OrderCount
     FROM Orders
   ) o
     ON co.CustomerID = o.CustomerID AND co.RestaurantID = o.RestaurantID AND co.OrderCount = o.OrderCount - 1
)
SELECT
  CustomerID,
  COUNT(DISTINCT RestaurantID) AS UniqueRestaurants
FROM CustomerOrders
GROUP BY
  CustomerID;