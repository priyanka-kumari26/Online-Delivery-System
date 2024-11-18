CREATE TABLE FederatedOrders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    OStatus VARCHAR(255),
    TotalPrice DECIMAL(5,2)
) ENGINE=FEDERATED
CONNECTION='mysql://remote_user3:priya12@10.30.201.70:3306/online_food_delivery/Orders';