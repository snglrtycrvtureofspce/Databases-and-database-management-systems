BEGIN TRANSACTION;
UPDATE products SET price = price * 1.4 WHERE product_id = 1;
INSERT INTO orders (product_id, customer_id, delivery_id, quantity, order_date, delivery_type, delivery_cost)
VALUES (1, 2, 5, 2, '2023-03-24', 'Курьерская доставка', 300.00);
COMMIT;

--
SET IMPLICIT_TRANSACTIONS OFF;
UPDATE products SET price = price * 1.5 WHERE product_id = 1;

--
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO products (product_name, price, description, delivery_available)
    VALUES
    ('Огурцы', 40.00, 'Сорт "Зеленый гигант"', 1),
    ('Помидоры', 60.00, 'Сорт "Большой брат"', 1);
    COMMIT TRANSACTION;
    SELECT * FROM products;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Произошла ошибка: ' + ERROR_MESSAGE();
END CATCH;