/* длина строки */
SELECT customer_id, LEN(customer_name) AS name_length
FROM customers;

/* суммарную стоимость заказа для каждого заказчика */
SELECT customer_id, SUM(price * quantity) AS total_cost
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY customer_id;

/* название дня недели для всех заказов: */
SELECT DATENAME(weekday, order_date) AS day_of_week FROM orders;

/*  номер дня недели для всех заказов */
SELECT DATEPART(weekday, order_date) AS day_of_week_number FROM orders;

SELECT GETDATE();

SELECT TAN(45);

SELECT SQRT(16);

SELECT SQUARE(5);

SELECT RAND();

SELECT PI();

SELECT LOG(10);

SELECT ABS(-7);

SELECT ACOS(0.5);

SELECT ASCII('A');

SELECT DIFFERENCE('hello', 'holla');

SELECT LOWER('Hello World');

SELECT REPLACE('abcdefabc', 'abc', 'xyz');

SELECT REVERSE('Hello');

SELECT SUBSTRING('Hello World', 7, 5);

/* список товаров с округленной ценой */
SELECT product_name, ROUND(price, 0) AS rounded_price
FROM products;

/* имена и адреса всех заказчиков в нижнем регистре */
SELECT LOWER(customer_name) AS customer_name_lower, LOWER(address) AS address_lower FROM customers;

/* заменить символ '@' во всех телефонных номерах заказчиков на символ '-' */
SELECT REPLACE(phone, '@', '-') AS modified_phone FROM customers;

/* заказы, сделанные в последние 7 дней */
SELECT *
FROM orders
WHERE order_date >= DATEADD(day, -7, GETDATE());

/* заказы, сделанные в определенном месяце */
SELECT *
FROM orders
WHERE MONTH(order_date) = 3 AND YEAR(order_date) = 2023;

/*
1) Основные категории встроенных функций в SQL Server включают:
   1.1) Строковые функции: для обработки и манипуляции строковыми данными.
   1.2) Числовые функции: для выполнения математических операций и манипуляции числовыми данными.
   1.3) Дата/время функции: для работы с датами, временем и интервалами.
   1.4) Логические функции: для выполнения операций сравнения и логических операций.
   1.5) Агрегатные функции: для выполнения агрегатных операций (например, SUM, AVG, COUNT).

2) Строковая функция, которую можно использовать для поиска определенного символа в поле таблицы, называется CHARINDEX().

3) Функции для работы с числами используются для выполнения различных математических операций, обработки числовых значений, 
округления чисел, вычисления абсолютного значения, извлечения корня, генерации случайных чисел и т. д. 
Они позволяют манипулировать и анализировать числовые данные в базе данных.
4) Особенности использования функций для работы с датами и временем включают:
   4.1) Выполнение операций с датами и временем, таких как сравнение, вычитание, сложение и форматирование.
   4.2) Поддержка различных форматов даты и времени для ввода и вывода данных.
   4.3) Работа с различными временными зонами и часовыми поясами.
   4.4) Возможность извлечения компонентов даты и времени, таких как год, месяц, день, часы, минуты и секунды.

5) В функциях для работы с датами и временем можно использовать следующие временные интервалы:
   5.1) Годы (YEAR)
   5.2) Кварталы (QUARTER)
   5.3) Месяцы (MONTH)
   5.4) Недели (WEEK)
   5.5) Дни (DAY)
   5.6) Часы (HOUR)
   5.7) Минуты (MINUTE)
   5.8) Секунды (SECOND)
   5.9) Миллисекунды (MILLISECOND)
   5.10) Микросекунды (MICROSECOND)
   5.11) Наносекунды (NANOSECOND)
*/