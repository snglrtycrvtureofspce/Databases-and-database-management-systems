/* вставка нового клиента */
CREATE PROCEDURE InsertCustomer
@customer_name VARCHAR(50),
@address VARCHAR(100),
@phone VARCHAR(20),
@contact_person VARCHAR(50)
AS
INSERT INTO customers (customer_name, address, phone, contact_person)
VALUES (@customer_name, @address, @phone, @contact_person);

/* обновления информации о клиенте по его Id */
CREATE PROCEDURE UpdateCustomer
@customer_id INT,
@customer_name VARCHAR(50),
@address VARCHAR(100),
@phone VARCHAR(20),
@contact_person VARCHAR(50)
AS
UPDATE customers
SET
customer_name = @customer_name,
address = @address,
phone = @phone,
contact_person = @contact_person
WHERE customer_id = @customer_id;

/* удаление клиента */
CREATE PROCEDURE DeleteCustomer
@customer_id INT
AS
DELETE FROM customers
WHERE customer_id = @customer_id;

/* вставка нового продукта */
CREATE PROCEDURE InsertProduct
@product_name VARCHAR(50),
@price DECIMAL(10, 2),
@description VARCHAR(255),
@delivery_available BIT
AS
INSERT INTO products (product_name, price, description, delivery_available)
VALUES (@product_name, @price, @description, @delivery_available);

/* обновления информации о продукте */
CREATE PROCEDURE UpdateProduct
@product_id INT,
@product_name VARCHAR(50),
@price DECIMAL(10, 2),
@description VARCHAR(255),
@delivery_available BIT
AS
UPDATE products
SET
product_name = @product_name,
price = @price,
description = @description,
delivery_available = @delivery_available
WHERE product_id = @product_id;

/* удаления продукта */
CREATE PROCEDURE DeleteProduct
@product_id INT
AS
DELETE FROM products
WHERE product_id = @product_id;

/* возвращает список всех заказов */
CREATE PROCEDURE GetOrders
AS
SELECT o.order_id, p.product_name, c.customer_name, d.price AS delivery_price, o.quantity, o.order_date,
       o.delivery_type, o.delivery_cost
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN delivery d ON o.delivery_id = d.delivery_id;