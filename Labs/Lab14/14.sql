SELECT order_id[ID], [order_date][����]
FROM orders
WHERE [order_date] BETWEEN '2023-03-14' AND '2023-03-20'

SELECT customer_name[���], address[�����]
FROM customers
WHERE [address] IN ('��. ������, �.10, ��.5, ������')

SELECT product_name[������������ ������], price[����]
FROM products
WHERE [product_name] LIKE '%���%'

SELECT customer_name[���], address[�����], phone[����� ��������]
FROM customers
WHERE (address = '��. ������, �.10, ��.5, ������') AND (phone = '8 (916) 123-45-67')

SELECT customer_name[���]
FROM customers
WHERE (address = '��. ������, �.10, ��.5, ������') OR (phone = '8 (916) 123-45-67')

SELECT customer_name[���]
FROM customers
ORDER BY customer_name  DESC 

SELECT * FROM products
WHERE price BETWEEN 0 AND 100;

SELECT * FROM orders /* ������� ���� �������, ��������� � ������ ��� � �����-���������� */
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.address LIKE '%������%' OR customers.address LIKE '%�����-���������%';

SELECT * FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE customers.address NOT LIKE '%������%' AND customers.address NOT LIKE '%�����-���������%';

SELECT * FROM orders
WHERE delivery_type NOT LIKE '%���������%';