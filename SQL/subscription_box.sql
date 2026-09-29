-- CIS 344 Project: Subscription Box Service Database

DROP DATABASE IF EXISTS subscription_box;
CREATE DATABASE subscription_box;
USE subscription_box;


CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) NOT NULL,
    phone       VARCHAR(20),
    address     VARCHAR(255) NOT NULL
);

CREATE TABLE Plan (
    plan_id   INT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    price     DECIMAL(8,2) NOT NULL,
    frequency VARCHAR(20) NOT NULL
);

CREATE TABLE Subscription (
    subscription_id INT PRIMARY KEY,
    customer_id     INT NOT NULL,
    plan_id         INT NOT NULL,
    start_date      DATE NOT NULL,
    status          VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (plan_id) REFERENCES Plan(plan_id)
);

CREATE TABLE Supplier (
    supplier_id   INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100)
);

CREATE TABLE Product (
    product_id   INT PRIMARY KEY,
    supplier_id  INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50),
    unit_cost    DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Shipment (
    shipment_id     INT PRIMARY KEY,
    subscription_id INT NOT NULL,
    ship_date       DATE NOT NULL,
    tracking_number VARCHAR(50),
    status          VARCHAR(20) NOT NULL,
    FOREIGN KEY (subscription_id) REFERENCES Subscription(subscription_id)
);

CREATE TABLE Shipment_Item (
    shipment_id INT NOT NULL,
    product_id  INT NOT NULL,
    quantity    INT NOT NULL,
    PRIMARY KEY (shipment_id, product_id),
    FOREIGN KEY (shipment_id) REFERENCES Shipment(shipment_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id      INT PRIMARY KEY,
    subscription_id INT NOT NULL,
    amount          DECIMAL(8,2) NOT NULL,
    payment_date    DATE NOT NULL,
    method          VARCHAR(20) NOT NULL,
    FOREIGN KEY (subscription_id) REFERENCES Subscription(subscription_id)
);


INSERT INTO Customer VALUES
(1, 'Maria', 'Lopez', 'maria.lopez@gmail.com', '718-555-0101', '123 Grand Concourse, Bronx, NY'),
(2, 'James', 'Carter', 'james.carter@gmail.com', '646-555-0102', '45 W 34th St, New York, NY'),
(3, 'Ana', 'Reyes', 'ana.reyes@gmail.com', '347-555-0103', '890 Fordham Rd, Bronx, NY');

INSERT INTO Plan VALUES
(1, 'Basic', 29.99, 'Monthly'),
(2, 'Premium', 49.99, 'Monthly');

INSERT INTO Subscription VALUES
(1, 1, 2, '2026-06-01', 'Active'),
(2, 2, 1, '2026-07-15', 'Active'),
(3, 3, 1, '2026-08-01', 'Paused');

INSERT INTO Supplier VALUES
(1, 'Fresh Farms Co', 'orders@freshfarms.com'),
(2, 'Snack Hub', 'sales@snackhub.com');

INSERT INTO Product VALUES
(1, 1, 'Organic Coffee', 'Food', 6.50),
(2, 1, 'Granola Mix', 'Food', 4.25),
(3, 2, 'Protein Bar', 'Snack', 1.75);

INSERT INTO Shipment VALUES
(1, 1, '2026-07-01', 'TRK1001', 'Delivered'),
(2, 1, '2026-08-01', 'TRK1002', 'Delivered'),
(3, 2, '2026-08-15', 'TRK1003', 'Shipped');

INSERT INTO Shipment_Item VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 4),
(3, 1, 1);

INSERT INTO Payment VALUES
(1, 1, 49.99, '2026-06-28', 'Credit Card'),
(2, 1, 49.99, '2026-07-28', 'Credit Card'),
(3, 2, 29.99, '2026-08-12', 'Debit Card');

UPDATE Subscription SET status = 'Active' WHERE subscription_id = 3;

UPDATE Shipment SET status = 'Delivered' WHERE shipment_id = 3;

DELETE FROM Shipment_Item WHERE shipment_id = 3 AND product_id = 1;

SELECT * FROM Customer;

SELECT * FROM Subscription WHERE status = 'Active';

SELECT Customer.first_name, Customer.last_name, Plan.plan_name
FROM Subscription
JOIN Customer ON Subscription.customer_id = Customer.customer_id
JOIN Plan ON Subscription.plan_id = Plan.plan_id;