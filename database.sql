use online_food_delivery;
CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  CName VARCHAR(255),
  Email VARCHAR(255),
  Phone VARCHAR(20),
  Address VARCHAR(255)
);

CREATE TABLE Restaurant (
  RestaurantID INT PRIMARY KEY,
  RName VARCHAR(255),
  Location VARCHAR(255),
  CuisineType VARCHAR(255),
  ContactNumber VARCHAR(20),
  Rating DECIMAL(2,1)
);

CREATE TABLE MenuItem (
  MenuItemID INT PRIMARY KEY,
  RestaurantID INT,
  MName VARCHAR(255),
  Descriptions VARCHAR(255),
  Availability BOOLEAN,
  Price DECIMAL(5,2),
  FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  RestaurantID INT,
  OrderDate DATE,
  OStatus VARCHAR(255),
  TotalPrice DECIMAL(5,2),
  FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
  FOREIGN KEY (RestaurantID) REFERENCES Restaurant (RestaurantID)
);


CREATE TABLE OrderItem (
  OrderItemID INT PRIMARY KEY,
  OrderID INT,
  MenuItemID INT,
  Quantity INT,
  Notes VARCHAR(255),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (MenuItemID) REFERENCES MenuItem (MenuItemID)
);

CREATE TABLE DeliveryPerson (
  DeliveryPersonID INT PRIMARY KEY,
  DName VARCHAR(255),
  PhoneNumber VARCHAR(20)
);

CREATE TABLE Delivery (
  DeliveryID INT PRIMARY KEY,
  OrderID INT,
  DeliveryPersonID INT,
  DeliveryStatus VARCHAR(255),
  DeliveryTime DATETIME,
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (DeliveryPersonID) REFERENCES DeliveryPerson(DeliveryPersonID)
);

CREATE TABLE Feedback (
  FeedbackID INT PRIMARY KEY,
  OrderID INT,
  FeedbackDate DATE,
  Rating DECIMAL(2,1),
  Review VARCHAR(255),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Customer (CustomerID, CName, Email, Phone, Address) VALUES
(1, 'Prapti Arali', 'praptiarali22@gmail.com', '1234567890', 'Address1'),
(2, 'Prayashi Verma', 'sss.prayashi@gmail.com', '2345678901', 'Address2'),
(3, 'Priyanka Kumari', 'swetapriya2612@gmail.com', '3456789012', 'Address3'),
(4, 'Praneetha Praveen Kalbhavi', 'praneethakalbhavi@gmail.com', '4567890123', 'Address4'),
(5, 'Anika P', 'anika@gmail.com', '5678901234', 'Address5');

INSERT INTO Restaurant (RestaurantID, RName, Location, CuisineType, ContactNumber, Rating) VALUES
(1, 'Meghana', 'Jayanagar', 'Indian', '9999999999', 2.5),
(2, 'White Lotus', 'Banashankari', 'Japanese', '8888888888', 3.7),
(3, 'Paakashala', 'Whitefield', 'American', '7777777777', 4.2),
(4, 'Halli Mane', 'Indranagar', 'Mexican', '6666666666', 4.8),
(5, 'CTR', 'Malleshwaram', 'Indian', '5555555555', 1);

INSERT INTO MenuItem (MenuItemID, RestaurantID, MName, Descriptions, Availability, Price) VALUES
(1, 1, 'Spaghetti Bolognese', 'Classic Italian pasta dish with meat sauce', TRUE, 12.99),
(2, 1, 'Margherita Pizza', 'Simple pizza with tomato, mozzarella, and basil', TRUE, 10.99),
(3, 2, 'California Roll', 'Sushi roll with crab, avocado, and cucumber', TRUE, 8.99),
(4, 2, 'Salmon Sashimi', 'Fresh salmon slices served with soy sauce', TRUE, 14.99),
(5, 3, 'Cheeseburger', 'Juicy beef burger with cheese, lettuce, and tomato', TRUE, 9.99);

INSERT INTO Orders (OrderID, CustomerID, RestaurantID, OrderDate, OStatus, TotalPrice) VALUES
(1, 1, 1, '2022-05-01', 'Delivered', 23.98),  
(2, 2, 2, '2023-10-02', 'Placed', 23.98),    
(3, 3, 3, '2021-08-03', 'In Progress', 9.99), 
(4, 4, 4, '2024-10-04', 'Delivered', 15.99),  
(5, 5, 5, '2023-07-05', 'Cancelled', 0.00);  

INSERT INTO OrderItem (OrderItemID, OrderID, MenuItemID, Quantity, Notes) VALUES
(1, 1, 1, 1, 'Extra cheese'),  
(2, 1, 2, 1, 'No basil'),      
(3, 2, 3, 2, 'Spicy'),         
(4, 3, 5, 1, 'Fresh'),         
(5, 4, 4, 1, 'No onions');     

INSERT INTO DeliveryPerson (DeliveryPersonID, DName, PhoneNumber) VALUES
(1, 'John M', '1234567899'),
(2, 'Ram Kumar', '1234567898'),
(3, 'Harish J', '1234567897'),
(4, 'Satwik S', '1234567896'),
(5, 'Tushar Singh', '1234567895');

INSERT INTO Delivery (DeliveryID, OrderID, DeliveryPersonID, DeliveryStatus, DeliveryTime) VALUES
(1, 1, 1, 'Delivered', '2022-05-01 12:30:00'),
(2, 2, 2, 'In Progress', '2023-10-02 13:00:00'),
(3, 3, 3, 'Pending', '2021-08-03 14:00:00'),
(4, 4, 4, 'Delivered', '2024-10-04 15:00:00'),
(5, 5, 5, 'Cancelled', '2023-07-05 16:00:00');

INSERT INTO Feedback (FeedbackID, OrderID, FeedbackDate, Rating, Review) VALUES
(1, 1, '2022-05-02', 5.0, 'Excellent food and service!'),
(2, 2, '2023-10-03', 4.0, 'Good sushi, but a bit pricey.'),
(3, 3, '2021-08-04', 3.5, 'Burger was okay, nothing special.'),
(4, 4, '2024-10-05', 4.5, 'Tacos were delicious! Will order again.'),
(5, 5, '2023-07-06', 2.0, 'Food was cold and delivery took too long.');

