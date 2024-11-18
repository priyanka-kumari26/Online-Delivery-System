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
    IF order_count >= 6 THEN
        SET discount_percentage = 20; -- 20% discount for 6 or more orders
    ELSEIF order_count >= 3 THEN
        SET discount_percentage = 10; -- 10% discount for 3 to 5 orders
    ELSE
        SET discount_percentage = 0; -- No discount for less than 3 orders
    END IF;

    RETURN discount_percentage;
END //

DELIMITER ;

-- Inserting more data before running query
INSERT INTO Orders (OrderID, CustomerID, RestaurantID, OrderDate, OStatus, TotalPrice) VALUES
(6, 1, 1, '2023-10-01', 'Delivered', 25.00),
(7, 1, 2, '2023-10-02', 'Delivered', 30.00),
(8, 1, 1, '2023-10-03', 'Delivered', 20.00),
(9, 1, 3, '2023-10-04', 'Delivered', 15.00),
(10, 1, 4, '2023-10-05', 'Delivered', 10.00),
(11, 2, 1, '2023-10-06', 'Delivered', 25.00),
(12, 2, 2, '2023-10-07', 'Delivered', 30.00),
(13, 2, 3, '2023-10-08', 'Delivered', 20.00),
(14, 3, 4, '2023-10-09', 'Delivered', 15.00),
(15, 4, 5, '2023-10-10', 'Delivered', 10.00);

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