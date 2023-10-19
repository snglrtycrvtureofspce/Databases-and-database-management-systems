/* Вывести все заказы с информацией о товаре и заказчике */
SELECT o.order_id, p.product_name, c.customer_name
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
INNER JOIN customers c ON o.customer_id = c.customer_id;

/* Вывести информацию о заказах, включая товар, количество, только для заказов с доставкой */
SELECT p.product_name, o.quantity
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
INNER JOIN delivery d ON o.delivery_id = d.delivery_id
WHERE o.delivery_type <> 'Самовывоз';

/* Вывести список всех заказчиков, а также информацию о заказах, включая товар и количество, сгруппированных по заказчику */
SELECT c.customer_name, p.product_name, SUM(o.quantity) AS total_quantity
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name, p.product_name;

/* Вывести список всех заказов с информацией о товаре и доставке */
SELECT o.order_id, p.product_name
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id
LEFT JOIN delivery d ON o.delivery_id = d.delivery_id;

/* Вывести информацию о товарах, у которых цена превышает 200 рублей, и информацию о заказах, 
включая количество, связанных с этими товарами: */
SELECT p.product_name, o.quantity
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
LEFT JOIN delivery d ON o.delivery_id = d.delivery_id
WHERE p.price > 200;

/* Вывести список всех заказчиков и информацию о доставке */
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN delivery d ON o.delivery_id = d.delivery_id;

/* Вывести список всех заказов, сгруппированных по типу доставки и отсортированных по стоимости доставки в убывающем порядке */
SELECT o.order_id
FROM orders o
LEFT JOIN delivery d ON o.delivery_id = d.delivery_id
GROUP BY o.order_id
ORDER BY o.order_id DESC;

/*

1) Процесс явного объединения таблиц включает указание оператора JOIN и условия соединения для объединяемых таблиц. 
Это позволяет комбинировать строки из разных таблиц на основе совпадающих значений в указанных столбцах.
2) Для выполнения внешнего соединения таблиц используются операторы LEFT JOIN, RIGHT JOIN и FULL JOIN.
   LEFT JOIN возвращает все строки из левой таблицы и соответствующие строки из правой таблицы.
   RIGHT JOIN возвращает все строки из правой таблицы и соответствующие строки из левой таблицы.
   FULL JOIN возвращает все строки из обеих таблиц и соединяет их по условию.
3) Результатом операции CROSS JOIN является декартово произведение строк из двух таблиц. 
Это значит, что каждая строка из первой таблицы будет сочетаться с каждой строкой из второй таблицы, 
что приводит к возникновению всех возможных комбинаций строк.
4) Особенности использования оператора UNION:
   4.1) UNION используется для объединения результатов двух или более SELECT запросов, которые имеют одинаковое количество столбцов и совместимые типы данных.
   4.2) Результатом UNION является один набор уникальных строк, и дубликаты удаляются.
   4.3) Столбцы в результирующем наборе должны быть совместимыми по типам данных и в том же порядке.
   4.4) UNION ALL может быть использован, чтобы объединить результаты без удаления дубликатов, сохраняя все строки из каждого запроса.
   4.5) Количество столбцов и их имена должны быть одинаковыми для всех запросов в операции UNION.
   4.6) Порядок строк в результирующем наборе не гарантирован и может зависеть от реализации и оптимизатора запросов.

*/