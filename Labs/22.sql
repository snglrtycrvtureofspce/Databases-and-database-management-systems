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

/* вычислит соимиость заказов */
CREATE TRIGGER CalculateOrderCost
ON orders
AFTER INSERT
AS
BEGIN
  UPDATE orders
  SET delivery_cost =
    (SELECT SUM(p.price * i.quantity)
     FROM inserted i
     INNER JOIN products p ON i.product_id = p.product_id)
  FROM orders o
  WHERE o.order_id IN (SELECT order_id FROM inserted);
END;

/* обновления стоимости заказа после вставки нового заказа */
CREATE TRIGGER UpdateTotalPriceOnInsert
ON orders
AFTER INSERT
AS
BEGIN
    UPDATE orders
    SET delivery_cost = (SELECT price FROM delivery WHERE delivery_id = inserted.delivery_id) * inserted.quantity
    FROM orders
    INNER JOIN inserted ON orders.order_id = inserted.order_id;
END;

/* обновляет стоимость заказа при изменениии колво товаров */
CREATE TRIGGER UpdateOrderCost
ON orders
AFTER UPDATE
AS
BEGIN
  UPDATE orders
  SET delivery_cost =
    (SELECT SUM(p.price * i.quantity)
     FROM inserted i
     INNER JOIN products p ON i.product_id = p.product_id)
  FROM orders o
  WHERE o.order_id IN (SELECT order_id FROM inserted);
END;

/* удаляет заказчиков при удалении клиента */
CREATE TRIGGER DeleteCustomerOrders
ON customers
AFTER DELETE
AS
BEGIN
  DELETE FROM orders
  WHERE customer_id IN (SELECT customer_id FROM deleted);
END;

/* обновления стоимости заказа после удаления */
CREATE TRIGGER UpdateTotalPriceOnDelete
ON orders
AFTER DELETE
AS
BEGIN
    UPDATE orders
    SET delivery_cost = (SELECT price FROM delivery WHERE delivery_id = deleted.delivery_id) * deleted.quantity
    FROM orders
    INNER JOIN deleted ON orders.order_id = deleted.order_id;
END;

/* индивидуальное задание */
DECLARE @x int
DECLARE @y float
SET @x = 10
IF(@x < 1.45)
	BEGIN
		SET @y = (POWER(@x,3.5)) + TAN(2 * @x)
		SELECT @x as Значение, @y as Результат
	END
ELSE IF(1.45 <= @x)
	BEGIN
		SET @y = (POWER(@x, 2) + POWER(exp(1), @x))
		SELECT @x as Значение, @y as Результат
	END