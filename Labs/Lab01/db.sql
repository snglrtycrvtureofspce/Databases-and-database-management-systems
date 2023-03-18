CREATE DATABASE company;

USE company;

CREATE TABLE products (
  product_id INT IDENTITY(1,1) PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  description VARCHAR(255),
  delivery_available BIT NOT NULL,
);

CREATE TABLE customers (
  customer_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  contact_person VARCHAR(50) NOT NULL
);

CREATE TABLE delievery (
  delievery_id INT IDENTITY(1,1) PRIMARY KEY,
  price DECIMAL(10, 2) NOT NULL,
  speed int NOT NULL,
);

CREATE TABLE orders (
  order_id INT IDENTITY(1,1) PRIMARY KEY,
  product_id INT NOT NULL,
  customer_id INT NOT NULL,
  delievery_id INT NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL,
  delivery_type VARCHAR(50),
  delivery_cost DECIMAL(10, 2),
  FOREIGN KEY (product_id) REFERENCES products(product_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (delievery_id) REFERENCES delievery(delievery_id)
);