/* Изменить цену на продукт с идентификатором 1 на 10%: */
DECLARE @price DECIMAL(10,2);
SET @price = (SELECT price FROM products WHERE product_id = 1);
UPDATE products SET price = @price * 1.1 WHERE product_id = 1;

/* Проверка существования таблицы в БД */
IF EXISTS(SELECT * FROM sys.tables WHERE name = 'customers')
BEGIN
    PRINT 'Таблица customers существует в базе данных'
END
ELSE
BEGIN
    PRINT 'Таблица customers не существует в базе данных'
END

/*  */
DECLARE @product_id INT = 1

IF EXISTS(SELECT * FROM products WHERE product_id = @product_id)
BEGIN
    UPDATE products SET price = price * 0.9 WHERE product_id = @product_id
    PRINT 'Цена товара успешно снижена на 10%'
END
ELSE
BEGIN
    PRINT 'Товар не найден'
END

/*  */
DECLARE @min_price DECIMAL(10,2)
SET @min_price = 1000.00

SELECT * FROM products WHERE price >= @min_price

/*  */
DECLARE @customer_name VARCHAR(50) = 'Иванова Ольга'

BEGIN
    SELECT * FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE customer_name = @customer_name)
    SELECT * FROM delievery WHERE delievery_id IN (SELECT delievery_id FROM orders WHERE customer_id = (SELECT customer_id FROM customers WHERE customer_name = @customer_name))
END


/*  */
DECLARE @i INT = 1

WHILE (@i <= 10)
BEGIN
    PRINT 'Значение переменной i: ' + CAST(@i AS VARCHAR)
    SET @i = @i + 1
END


/*  */
DECLARE @i INT = 1

WHILE (1=1)
BEGIN
    PRINT 'Значение переменной i: ' + CAST(@i AS VARCHAR)
    SET @i = @i + 1
    
    IF @i > 10
        BREAK
END


/*  */
DECLARE @i INT = 1

WHILE (@i <= 10)
BEGIN
    IF @i = 5
    BEGIN
        SET @i = @i + 1
        CONTINUE
    END
    
    PRINT 'Значение переменной i: ' + CAST(@i AS VARCHAR)
    SET @i = @i + 1
END


/* Добавление столбца с наименованием товара и указанием статуса его наличия на складе */
SELECT 
    p.product_name, 
    o.quantity, 
    o.order_date,
    CASE 
        WHEN p.delivery_available = 1 THEN 'В наличии' 
        ELSE 'Отсутствует на складе' 
    END AS product_availability
FROM 
    orders o
    JOIN products p ON o.product_id = p.product_id


/* Добавление столбца с указанием типа доставки и итоговой стоимости доставки */
SELECT 
    o.order_id, 
    o.order_date, 
    o.quantity, 
    d.speed AS delivery_speed, 
    d.price AS delivery_price,
    o.delivery_type,
    CASE 
        WHEN o.delivery_type = 'Курьерская доставка' THEN d.price 
        WHEN o.delivery_type = 'Самовывоз' THEN 0 
        ELSE d.price * 0.5 
    END AS total_delivery_cost
FROM 
    orders o
    JOIN delievery d ON o.delievery_id = d.delievery_id
