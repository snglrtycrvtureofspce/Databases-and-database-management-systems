/* ѕредставление с информацией о всех продуктах: */
CREATE VIEW all_products AS
SELECT product_id, product_name, price, description, delivery_available
FROM products;

/* ѕредставление с информацией о всех клиентах: */
CREATE VIEW all_customers AS
SELECT customer_id, customer_name, address, phone, contact_person
FROM customers;

/*ѕредставление с информацией о всех заказах: */
CREATE VIEW all_orders AS
SELECT order_id, products.product_name, customers.customer_name, orders.quantity, orders.order_date, orders.delivery_type, orders.delivery_cost
FROM orders
INNER JOIN products ON orders.product_id = products.product_id
INNER JOIN customers ON orders.customer_id = customers.customer_id;

/* ѕредставление с информацией о всех заказах, сделанных в определенную дату: */
CREATE VIEW orders_on_date AS
SELECT order_id, products.product_name, customers.customer_name, orders.quantity, orders.delivery_type, orders.delivery_cost
FROM orders
INNER JOIN products ON orders.product_id = products.product_id
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.order_date = '2023-04-08';

/* ѕредставление с информацией о всех клиентах, которые сделали заказы на определенный продукт: */
CREATE VIEW customers_for_product AS
SELECT DISTINCT customers.customer_id, customers.customer_name
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
INNER JOIN products ON orders.product_id = products.product_id
WHERE products.product_name = 'ћолоко';

/* ѕредставление с информацией о количестве заказов, сделанных каждым клиентом: */
CREATE VIEW order_count_per_customer AS
SELECT customers.customer_name, COUNT(orders.order_id) AS order_count
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name;

/* ѕредставление с информацией о количестве заказов, сделанных каждым клиентом на определенную дату: */
CREATE VIEW order_count_per_customer_on_date AS
SELECT customers.customer_name, COUNT(orders.order_id) AS order_count
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_date = '2023-04-08'
GROUP BY customers.customer_name;

/* ѕредставление с информацией о среднем количестве заказов на каждого клиента: */
CREATE VIEW average_order_count_per_customer AS
SELECT AVG(order_count) AS average_order_count
FROM (
  SELECT COUNT(orders.order_id) AS order_count
  FROM customers
  INNER JOIN orders ON customers.customer_id = orders.customer_id
  GROUP BY customers.customer_name
) AS order_counts;

/* ѕредставление с информацией о продуктах, стоимость которых меньше определенного значени€: */
CREATE VIEW products_under_price AS
SELECT *
FROM products
WHERE price < 100.00;

/* ѕредставление с информацией о средней стоимости продукта: */
CREATE VIEW average_product_price AS
SELECT AVG(price) AS average_price
FROM products;