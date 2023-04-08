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

INSERT INTO products (product_name, price, description, delivery_available)
VALUES
('Молоко', 80.00, 'Обезжиренное молоко', 1),
('Кефир', 70.00, 'Нежирный кефир', 1),
('Хлеб', 50.00, 'Ржаной хлеб', 1),
('Сыр', 250.00, 'Краснодарский сыр', 1),
('Яблоки', 120.00, 'Сорт "Антоновка"', 1),
('Мандарины', 180.00, 'Сорт "Тангерин"', 1),
('Картофель', 40.00, 'Новый урожай', 1),
('Морковь', 30.00, 'Свежая морковь', 1),
('Куриное филе', 200.00, 'Холодного копчения', 1),
('Свинина', 300.00, 'Мясо свинины', 1);

INSERT INTO customers (customer_name, address, phone, contact_person)
VALUES
('Иванова Ольга', 'ул. Ленина, д.10, кв.5, Москва', '8 (916) 123-45-67', 'Петров Петр'),
('Петров Алексей', 'ул. Мира, д.25, кв.2, Санкт-Петербург', '8 (921) 456-78-90', 'Сидоров Иван'),
('Кузнецова Елена', 'пр. Ленинградский, д.35, оф.7, Екатеринбург', '8 (912) 345-67-89', 'Смирнова Наталья'),
('Сидоров Игорь', 'ул. Комсомольская, д.20, кв.15, Нижний Новгород', '8 (904) 321-54-76', 'Кузнецова Елена'),
('Павлова Анастасия', 'ул. Кирова, д.12, кв.3, Владивосток', '8 (908) 765-43-21', 'Иванова Ольга'),
('Николаева Людмила', 'ул. Победы, д.8, кв.1, Казань', '8 (917) 654-32-10', 'Петров Алексей'),
('Козлов Дмитрий', 'ул. Советская, д.15, кв.12, Краснодар', '8 (918) 234-56-78', 'Сидоров Игорь'),
('Андреева Мария', 'ул. Пушкина, д.5, кв.7, Самара', '8 (917) 345-67-89', 'Кузнецова Елена'),
('Михайлов Иван', 'ул. Гагарина, д.30, кв.11, Уфа', '8 (912) 456-78-90', 'Павлова Анастасия'),
('Кузьмина Татьяна', 'ул. Маяковского, д.18, кв.6, Омск', '8 (913) 987-65-43', 'Николаева Людмила');

INSERT INTO delievery (price, speed)
VALUES
(500.00, 2),
(1000.00, 1),
(250.00, 3),
(700.00, 2),
(1500.00, 1),
(350.00, 3),
(800.00, 2),
(1200.00, 1),
(450.00, 3),
(900.00, 2);

INSERT INTO orders (product_id, customer_id, delievery_id, quantity, order_date, delivery_type, delivery_cost)
VALUES
(1, 3, 6, 3, '2023-03-22', 'Курьерская доставка', 350.00),
(5, 8, 2, 2, '2023-03-23', 'Самовывоз', 0.00),
(4, 4, 4, 1, '2023-03-21', 'Курьерская доставка', 700.00),
(9, 5, 9, 4, '2023-03-20', 'Почтовая доставка', 450.00),
(6, 9, 3, 1, '2023-03-19', 'Самовывоз', 0.00),
(2, 6, 7, 2, '2023-03-18', 'Курьерская доставка', 800.00),
(7, 1, 1, 5, '2023-03-17', 'Почтовая доставка', 1500.00),
(8, 2, 10, 1, '2023-03-16', 'Курьерская доставка', 1200.00),
(3, 7, 8, 3, '2023-03-15', 'Самовывоз', 0.00),
(10, 10, 5, 2, '2023-03-14', 'Курьерская доставка', 900.00);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

Представление с информацией о всех продуктах:
CREATE VIEW all_products AS
SELECT product_id, product_name, price, description, delivery_available
FROM products;

Представление с информацией о всех клиентах:
CREATE VIEW all_customers AS
SELECT customer_id, customer_name, address, phone, contact_person
FROM customers;

Представление с информацией о всех заказах:
CREATE VIEW all_orders AS
SELECT order_id, products.product_name, customers.customer_name, orders.quantity, orders.order_date, orders.delivery_type, orders.delivery_cost
FROM orders
INNER JOIN products ON orders.product_id = products.product_id
INNER JOIN customers ON orders.customer_id = customers.customer_id;

Представление с информацией о всех заказах, сделанных в определенную дату:
CREATE VIEW orders_on_date AS
SELECT order_id, products.product_name, customers.customer_name, orders.quantity, orders.delivery_type, orders.delivery_cost
FROM orders
INNER JOIN products ON orders.product_id = products.product_id
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.order_date = '2023-04-08';

Представление с информацией о всех клиентах, которые сделали заказы на определенный продукт:
CREATE VIEW customers_for_product AS
SELECT DISTINCT customers.customer_id, customers.customer_name
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN products ON orders.product_id = products.product_id
WHERE products.product_name = 'Молоко';

Представление с информацией о количестве заказов, сделанных каждым клиентом:
CREATE VIEW order_count_per_customer AS
SELECT customers.customer_name, COUNT(orders.order_id) AS order_count
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name;

Представление с информацией о количестве заказов, сделанных каждым клиентом на определенную дату:
CREATE VIEW order_count_per_customer_on_date AS
SELECT customers.customer_name, COUNT(orders.order_id) AS order_count
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_date = '2023-04-08'
GROUP BY customers.customer_name;

Представление с информацией о среднем количестве заказов на каждого клиента:
CREATE VIEW average_order_count_per_customer AS
SELECT AVG(order_count) AS average_order_count
FROM (
  SELECT COUNT(orders.order_id) AS order_count
  FROM customers
  INNER JOIN orders ON customers.customer_id = orders.customer_id
  GROUP BY customers.customer_name
) AS order_counts;

Представление с информацией о продуктах, стоимость которых меньше определенного значения:
CREATE VIEW products_under_price AS
SELECT *
FROM products
WHERE price < 100.00;

Представление с информацией о средней стоимости продукта:
CREATE VIEW average_product_price AS
SELECT AVG(price) AS average_price
FROM products;