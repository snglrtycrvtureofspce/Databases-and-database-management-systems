/* Изменить тип данных столбца в таблице products с DECIMAL(10,2) на DECIMAL(12,2): */
ALTER TABLE products (
    ALTER COLUMN price DECIMAL(12,2);
    )

/* Удалить столбец contact_person из таблицы customers */
ALTER TABLE customers (
    DROP COLUMN contact_person;
    )

/* Добавить столбец email типа VARCHAR(50) в таблицу customers */
ALTER TABLE customers (
    ADD email VARCHAR(50);
    )

/* Добавить ограничение CHECK на столбец delivery_type таблицы orders, чтобы он мог принимать только значения "standard" или "express" */
ALTER TABLE orders (
    ADD CONSTRAINT chk_delivery_type CHECK (delivery_type IN ('standard', 'express'));
    )

/* Удалить таблицу orders: */
DROP TABLE orders;

/* Удалить ограничение FOREIGN KEY на столбец delievery_id таблицы orders:
ALTER TABLE orders (
    DROP CONSTRAINT FK_orders_delievery;
    )

/* Изменить тип данных столбца speed в таблице delievery с INT на TINYINT: */
ALTER TABLE delievery (
    ALTER COLUMN speed TINYINT;
    )

/* Добавить уникальное ограничение на столбец email в таблице customers: */
ALTER TABLE customers (
    ADD CONSTRAINT unq_email UNIQUE (email);
    )

/* Добавить внешнее ограничение FOREIGN KEY на столбец customer_id таблицы orders, связывающее его с таблицей customers */
ALTER TABLE orders (
    ADD CONSTRAINT FK_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
    )

/* Добавить таблицу order_details с двумя столбцами: order_id типа INT и product_count типа INT, и связать ее с таблицей orders */
CREATE TABLE order_details (
    order_id INT NOT NULL,
    product_count INT NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE
    );