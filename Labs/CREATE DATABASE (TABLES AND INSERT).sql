CREATE DATABASE company;

USE company;

/* Создание таблиц БД */
/* Товары */
CREATE TABLE products (
  product_id INT IDENTITY(1,1) PRIMARY KEY,
  product_name VARCHAR(50) NOT NULL UNIQUE,
  price DECIMAL(10, 2) NOT NULL,
  description VARCHAR(255) NOT NULL,
  delivery_available BIT NOT NULL CHECK (delivery_available IN (0,1))
);

/* Заказчики */
CREATE TABLE customers (
  customer_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL,
  address VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL UNIQUE,
  contact_person VARCHAR(50) NOT NULL
);

/* Доставка */
CREATE TABLE delievery (
  delievery_id INT IDENTITY(1,1) PRIMARY KEY,
  price DECIMAL(10, 2) NOT NULL,
  speed int NOT NULL CHECK (speed > 0)
);

/* Заказы */
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

/* Вставка данных в таблицы БД */
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
