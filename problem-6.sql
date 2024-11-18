
-- Function Definition for Problem-6
DELIMITER //

CREATE FUNCTION calculate_discount(p_customer_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE order_count INT;
    DECLARE discount_percentage INT;

    -- Count the number of completed orders for the customer
    SELECT COUNT(*) INTO order_count
    FROM Orders
    WHERE CustomerID = p_customer_id AND OStatus = 'Delivered';

    -- Determine discount percentage based on the number of orders
    IF order_count >= 10 THEN
        SET discount_percentage = 20; -- 20% discount for 10 or more orders
    ELSEIF order_count >= 5 THEN
        SET discount_percentage = 10; -- 10% discount for 5 to 9 orders
    ELSE
        SET discount_percentage = 0; -- No discount for less than 5 orders
    END IF;

    RETURN discount_percentage;
END //

DELIMITER ;

-- Query for Problem-6 
SELECT 
    c.CName AS CustomerName,
    COUNT(o.OrderID) AS NumberOfOrders,
    calculate_discount(c.CustomerID) AS DiscountPercentage
FROM 
    Customer c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID;
    
INSERT INTO Orders (OrderID, CustomerID, RestaurantID, OrderDate, OStatus, TotalPrice) VALUES
(6, 1, 1, '2023-10-01', 'Delivered', 25.00),
(7, 1, 2, '2023-10-02', 'Delivered', 30.00),
(8, 2, 1, '2023-10-03', 'Delivered', 20.00),
(9, 3, 3, '2023-10-04', 'Delivered', 15.00),
(10, 4, 4, '2023-10-05', 'Delivered', 10.00);

SELECT 
    CustomerID, 
    COUNT(*) AS DeliveredOrderCount
FROM 
    Orders
WHERE 
    OStatus = 'Delivered'
GROUP BY 
    CustomerID;
    
SELECT calculate_discount(1);  -- Replace 1 with a valid CustomerID that has delivered orders