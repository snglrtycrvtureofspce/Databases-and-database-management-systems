CREATE DATABASE company;

USE company;

CREATE TABLE products (
  product_id INT IDENTITY(1,1) PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL UNIQUE,
  price DECIMAL(10, 2) NOT NULL,
  description VARCHAR(255) NOT NULL,
  delivery_available BIT NOT NULL CHECK (delivery_available IN (0,1))
);

CREATE TABLE customers (
  customer_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL UNIQUE,
  contact_person VARCHAR(50) NOT NULL
);

CREATE TABLE delievery (
  delievery_id INT IDENTITY(1,1) PRIMARY KEY,
  price DECIMAL(10, 2) NOT NULL,
  speed int NOT NULL CHECK (speed > 0)
);

CREATE TABLE orders (
  order_id INT IDENTITY(1,1) PRIMARY KEY,
  product_id INT NOT NULL,
  customer_id INT NOT NULL,
  delievery_id INT NOT NULL,
  quantity INT NOT NULL CHECK (quantity > 0),
  order_date DATE NOT NULL,
  delivery_type VARCHAR(50) NOT NULL,
  delivery_cost DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (delievery_id) REFERENCES delievery(delievery_id) ON DELETE CASCADE ON UPDATE CASCADE
);
