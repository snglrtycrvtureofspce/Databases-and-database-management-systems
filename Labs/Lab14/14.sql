SELECT order_id[ID], [order_date][Дата]
FROM orders
WHERE [order_date] BETWEEN '2023-03-14' AND '2023-03-20'

SELECT customer_name[ФИО], address[Адрес]
FROM customers
WHERE [address] IN ('ул. Ленина, д.10, кв.5, Москва')

SELECT product_name[Наименование товара], price[Цена]
FROM products
WHERE [product_name] LIKE '%Мол%'

SELECT customer_name[ФИО], address[Адрес], phone[Номер телефона]
FROM customers
WHERE (address = 'ул. Ленина, д.10, кв.5, Москва') AND (phone = '8 (916) 123-45-67')

SELECT customer_name[ФИО]
FROM customers
WHERE (address = 'ул. Ленина, д.10, кв.5, Москва') OR (phone = '8 (916) 123-45-67')

SELECT customer_name[ФИО]
FROM customers
ORDER BY customer_name  DESC 

SELECT * FROM products
WHERE price BETWEEN 0 AND 100;

SELECT * FROM orders /* выборка всех заказов, сделанных в Москве или в Санкт-Петербурге */
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.address LIKE '%Москва%' OR customers.address LIKE '%Санкт-Петербург%';

SELECT * FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.address NOT LIKE '%Москва%' AND customers.address NOT LIKE '%Санкт-Петербург%';

SELECT * FROM orders
WHERE delivery_type NOT LIKE '%Самовывоз%';