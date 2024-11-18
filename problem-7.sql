DELIMITER //

CREATE TRIGGER prevent_incomplete_order_review
BEFORE INSERT ON Feedback
FOR EACH ROW
BEGIN
    DECLARE order_status VARCHAR(255);
    SELECT OStatus INTO order_status
    FROM Orders
    WHERE OrderID = NEW.OrderID;
    
    IF order_status <> 'Delivered' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reviews can only be submitted for completed orders.';
    END IF;
END//

DELIMITER ;