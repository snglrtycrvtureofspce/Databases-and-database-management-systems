UPDATE products
SET price = 1200.00
WHERE product_id = 1;

UPDATE products
SET description = 'Ноутбук Lenovo IdeaPad 5 - отличное решение для игр и развлечений!'
WHERE product_name = 'Ноутбук Lenovo';

DELETE FROM orders
WHERE order_id = 5;

DELETE FROM orders
WHERE order_date = DATEADD(day, -1, GETDATE()); /* вчера */

TRUNCATE TABLE orders;

UPDATE orders
SET delivery_cost = delivery_cost + 1000.00
WHERE customer_id = 3;