 /* неуникальный некластеризованный индекс  */
CREATE NONCLUSTERED INDEX IX_Customers_CustomerName
ON customers(customer_name);

CREATE UNIQUE NONCLUSTERED INDEX IX_Customers_Phone
ON customers(phone);

CREATE NONCLUSTERED INDEX IX_Products_ProductName /* ускорения поиска продуктов по их названию */
ON products(product_name);

CREATE NONCLUSTERED INDEX IX_Orders_ProductCustomer
ON orders(product_id, customer_id);

CREATE NONCLUSTERED INDEX IX_Orders_DeliveryType /* включает только заказы с доставкой "Курьерская доставка". */
ON orders(delivery_type)
WHERE delivery_type = N'Курьерская доставка'; /* фильтрованный индекс */

DROP INDEX IX_Customers_CustomerName
ON customers;

/*  */

DROP INDEX IX_Orders_DeliveryType
ON orders;

CREATE NONCLUSTERED INDEX IX_Orders_DeliveryType
ON orders(delivery_type)
INCLUDE (delivery_cost);






