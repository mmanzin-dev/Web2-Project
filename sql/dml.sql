DELIMITER $$

-- get_customers_by_city procedure
CREATE PROCEDURE get_customers_by_city(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE city_name VARCHAR(100);
    SELECT JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.city')) INTO city_name;

    SELECT JSON_ARRAYAGG(
                   JSON_OBJECT(
                           'customer_id', customer_id,
                           'first_name', first_name,
                           'last_name', last_name,
                           'city', city
                   )
           ) INTO json_out
    FROM customers
    WHERE city = city_name;

    IF json_out IS NULL THEN
        SET json_out = JSON_ARRAY();
    END IF;
END$$

-- get_orders_by_status procedure
CREATE PROCEDURE get_orders_by_status(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE status_val VARCHAR(20);
    SELECT JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.status')) INTO status_val;

    SELECT JSON_ARRAYAGG(
                   JSON_OBJECT(
                           'order_id', order_id,
                           'customer_id', customer_id,
                           'status', status,
                           'order_date', DATE_FORMAT(order_date, '%Y-%m-%d')
                   )
           ) INTO json_out
    FROM orders
    WHERE status = status_val;

    IF json_out IS NULL THEN
        SET json_out = JSON_ARRAY();
    END IF;
END$$

-- get_products_by_price_range procedure
CREATE PROCEDURE get_products_by_price_range(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE min_price DECIMAL(10,2);
    DECLARE max_price DECIMAL(10,2);

    SELECT JSON_EXTRACT(json_in, '$.min_price'), JSON_EXTRACT(json_in, '$.max_price')
    INTO min_price, max_price;

    SELECT JSON_ARRAYAGG(
                   JSON_OBJECT(
                           'product_id', product_id,
                           'name', name,
                           'price', price
                   )
           ) INTO json_out FROM (
                                    SELECT camera_id AS product_id, name, price FROM cameras
                                    WHERE price BETWEEN min_price AND max_price
                                    UNION ALL
                                    SELECT lens_id AS product_id, name, price FROM lenses
                                    WHERE price BETWEEN min_price AND max_price
                                    UNION ALL
                                    SELECT equipment_id AS product_id, name, price FROM equipment
                                    WHERE price BETWEEN min_price AND max_price
                                    UNION ALL
                                    SELECT film_id AS product_id, name, price FROM films
                                    WHERE price BETWEEN min_price AND max_price
                                ) AS combined;

    IF json_out IS NULL THEN
        SET json_out = JSON_ARRAY();
    END IF;
END$$

-- insert_customer procedure
CREATE PROCEDURE insert_customer(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE first_name VARCHAR(50);
    DECLARE last_name VARCHAR(50);
    DECLARE email VARCHAR(100);
    DECLARE passwd VARCHAR(100);
    DECLARE address VARCHAR(200);
    DECLARE city VARCHAR(50);
    DECLARE zip VARCHAR(10);

    SELECT JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.first_name')),
           JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.last_name')),
           JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.email')),
           JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.password')),
           JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.address')),
           JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.city')),
           JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.zip'))
    INTO first_name, last_name, email, passwd, address, city, zip;

    INSERT INTO customers (first_name, last_name, email, password, address, city, zip)
    VALUES (first_name, last_name, email, passwd, address, city, zip);

    SET json_out = JSON_OBJECT('message', 'Kupac uspješno dodan');
END$$

-- update_order_status procedure
CREATE PROCEDURE update_order_status(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE order_id_val INT;
    DECLARE status_val VARCHAR(20);

    SELECT JSON_EXTRACT(json_in, '$.order_id'), JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.status'))
    INTO order_id_val, status_val;

    UPDATE orders SET status = status_val WHERE order_id = order_id_val;

    SET json_out = JSON_OBJECT('message', 'Status narudžbe uspješno ažuriran');
END$$

-- delete_product procedure
CREATE PROCEDURE delete_product(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE product_id_val INT;
    DECLARE product_type_val VARCHAR(20);

    SELECT JSON_EXTRACT(json_in, '$.product_id'), JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.product_type'))
    INTO product_id_val, product_type_val;

    CASE product_type_val
        WHEN 'Camera' THEN
            DELETE FROM cameras WHERE camera_id = product_id_val;
        WHEN 'Lens' THEN
            DELETE FROM lenses WHERE lens_id = product_id_val;
        WHEN 'Equipment' THEN
            DELETE FROM equipment WHERE equipment_id = product_id_val;
        WHEN 'Film' THEN
            DELETE FROM films WHERE film_id = product_id_val;
        ELSE
            SET json_out = JSON_OBJECT('h_message', 'Nepoznat tip proizvoda', 'h_errcod', 97);
            RETURN;
        END CASE;

    SET json_out = JSON_OBJECT('message', 'Proizvod uspješno obrisan');
END$$

DELIMITER ;