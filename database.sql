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



