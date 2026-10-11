CREATE DATABASE IF NOT EXISTS farmers_market_schema;
USE farmers_market_schema;


CREATE TABLE Markets (
    market_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    operating_hours VARCHAR(30) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,

    PRIMARY KEY (market_id)
);

CREATE TABLE Vendors (
    vendor_id INT NOT NULL AUTO_INCREMENT,
    business_name VARCHAR(100) NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(255) NOT NULL,

    PRIMARY KEY (vendor_id)
);

CREATE TABLE Market_Stalls (
    stall_id INT NOT NULL AUTO_INCREMENT,
    market_id INT NOT NULL,
    vendor_id INT,
    stall_number INT NOT NULL,

    PRIMARY KEY (stall_id),
    FOREIGN KEY (market_id) REFERENCES Markets(market_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id)
);


CREATE TABLE Products (
    product_id INT NOT NULL AUTO_INCREMENT ,
    vendor_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500) DEFAULT "No description given.",
    price DECIMAL(6, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category VARCHAR(50) NOT NULL,
       
    PRIMARY KEY (product_id),
    FOREIGN KEY (vendor_id) REFERENCES Vendors(vendor_id)
);

CREATE TABLE Orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    order_date DATETIME NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    status VARCHAR(25) NOT NULL,
    total_amount DECIMAL(6, 2) NOT NULL,

    PRIMARY KEY (order_id)
);

CREATE TABLE Order_Items (
    item_id INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL (6, 2) NOT NULL,

    PRIMARY KEY (item_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);