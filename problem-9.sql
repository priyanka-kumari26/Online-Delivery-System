-- Function Definition for Problem - 9
DELIMITER //

CREATE PROCEDURE get_order_details(IN p_customer_id INT, IN p_order_id INT)
BEGIN
    DECLARE total_amount DECIMAL(10, 2);
    DECLARE order_status VARCHAR(255);
    
    -- Check if the order exists for the given customer
    SELECT 
        o.OStatus,
        SUM(oi.Quantity * m.Price) INTO order_status, total_amount
    FROM 
        Orders o
    JOIN 
        OrderItem oi ON o.OrderID = oi.OrderID
    JOIN 
        MenuItem m ON oi.MenuItemID = m.MenuItemID
    WHERE 
        o.CustomerID = p_customer_id AND o.OrderID = p_order_id
    GROUP BY 
        o.OrderID;

    -- If no order is found, return a message
    IF order_status IS NULL THEN
        SELECT 'Order does not exist for the given customer ID and order ID.' AS Message;
    ELSE
        -- Return the order details
        SELECT 
            m.MName AS ItemName,
            oi.Quantity,
            m.Price,
            total_amount AS TotalAmount,
            order_status AS OrderStatus
        FROM 
            OrderItem oi
        JOIN 
            MenuItem m ON oi.MenuItemID = m.MenuItemID
        WHERE 
            oi.OrderID = p_order_id;
    END IF;
END //

DELIMITER ;

-- Query 1
CALL get_order_details(1, 1);

-- Query 2
CALL get_order_details(1, 4);