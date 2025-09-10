DELIMITER $$

-- Validate customer existence: OUT 1 = exists, 0 = not
CREATE PROCEDURE validate_customer(IN p_customer_id INT, OUT is_valid INT)
BEGIN
    SELECT COUNT(*) INTO is_valid FROM customers WHERE customer_id = p_customer_id;
    SET is_valid = IF(is_valid = 1, 1, 0);
END$$

-- Validate stock availability: OUT 1 = enough stock, 0 = not or unknown product
CREATE PROCEDURE validate_stock(IN p_product_type VARCHAR(50), IN p_product_id INT, IN p_quantity INT, OUT is_valid INT)
BEGIN
    DECLARE stock INT DEFAULT 0;

    CASE p_product_type
        WHEN 'Camera' THEN SELECT stock INTO stock FROM cameras WHERE camera_id = p_product_id;
        WHEN 'Lens' THEN SELECT stock INTO stock FROM lenses WHERE lens_id = p_product_id;
        WHEN 'Equipment' THEN SELECT stock INTO stock FROM equipment WHERE equipment_id = p_product_id;
        WHEN 'Film' THEN SELECT stock INTO stock FROM films WHERE film_id = p_product_id;
        ELSE
            SET is_valid = 0;
            RETURN;
        END CASE;

    SET is_valid = IF(stock >= p_quantity, 1, 0);
END$$

-- Validate order status validity: OUT 1 = valid, 0 = invalid
CREATE PROCEDURE validate_order_status(IN p_status VARCHAR(50), OUT is_valid INT)
BEGIN
    SET is_valid = IF(p_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'), 1, 0);
END$$

-- p_test procedure (simple example)
CREATE PROCEDURE p_test(INOUT json_in JSON)
BEGIN
    SET json_in = JSON_SET(json_in, '$.pozdrav', 'Hello World!');
END$$

-- p_login procedure with JSON IN/OUT
CREATE PROCEDURE p_login(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE username VARCHAR(100);
    DECLARE passwd VARCHAR(100);
    DECLARE cnt INT;

    SET username = JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.username'));
    SET passwd = JSON_UNQUOTE(JSON_EXTRACT(json_in, '$.password'));

    IF username IS NULL OR passwd IS NULL THEN
        SET json_out = JSON_OBJECT('h_message', 'Molimo unesite korisničko ime i zaporku', 'h_errcod', 101);
        RETURN;
    END IF;

    SELECT COUNT(*) INTO cnt FROM customers WHERE email = username AND password = passwd;

    IF cnt = 0 THEN
        SET json_out = JSON_OBJECT('h_message', 'Nepoznato korisničko ime ili zaporka', 'h_errcod', 96);
        RETURN;
    ELSEIF cnt > 1 THEN
        SET json_out = JSON_OBJECT('h_message', 'Molimo javite se u Informatiku', 'h_errcod', 42);
        RETURN;
    END IF;

    SELECT JSON_OBJECT(
                   'customer_id', customer_id,
                   'first_name', first_name,
                   'last_name', last_name,
                   'email', email,
                   'city', city,
                   'address', address,
                   'zip', zip
           ) INTO json_out
    FROM customers
    WHERE email = username AND password = passwd;
END$$

-- Removed p_zupanije procedure completely since table does not exist

-- p_get_products: gather all product types into JSON array
CREATE PROCEDURE p_get_products(INOUT json_in JSON)
BEGIN
    DECLARE products JSON;

    SELECT JSON_ARRAYAGG(prod) INTO products FROM (
                                                      SELECT JSON_OBJECT('type', 'Camera', 'id', camera_id, 'name', name, 'price', price) AS prod FROM cameras
                                                      UNION ALL
                                                      SELECT JSON_OBJECT('type', 'Lens', 'id', lens_id, 'name', name, 'price', price) FROM lenses
                                                      UNION ALL
                                                      SELECT JSON_OBJECT('type', 'Equipment', 'id', equipment_id, 'name', name, 'price', price) FROM equipment
                                                      UNION ALL
                                                      SELECT JSON_OBJECT('type', 'Film', 'id', film_id, 'name', name, 'price', price) FROM films
                                                  ) AS products_table;

    SET json_in = JSON_SET(json_in, '$.products', IFNULL(products, JSON_ARRAY()));
END$$

-- p_create_order: create order and insert items, validating customer and stock
CREATE PROCEDURE p_create_order(IN json_in JSON, OUT json_out JSON)
BEGIN
    DECLARE customer_id INT;
    DECLARE order_id INT;
    DECLARE items JSON;
    DECLARE items_len INT;
    DECLARE i INT DEFAULT 0;
    DECLARE product_type VARCHAR(50);
    DECLARE product_id INT;
    DECLARE quantity INT;
    DECLARE unit_price DECIMAL(10,2);
    DECLARE valid_customer INT;
    DECLARE valid_stock INT;

    SET customer_id = JSON_EXTRACT(json_in, '$.customer_id');
    CALL validate_customer(customer_id, valid_customer);
    IF valid_customer = 0 THEN
        SET json_out = JSON_OBJECT('h_message', 'Nevažeći ID kupca', 'h_errcod', 400);
        RETURN;
    END IF;

    INSERT INTO orders (customer_id, order_date, status, total_amount)
    VALUES (customer_id, NOW(), 'Pending', 0);
    SET order_id = LAST_INSERT_ID();

    SET items = JSON_EXTRACT(json_in, '$.items');
    SET items_len = JSON_LENGTH(items);

    WHILE i < items_len DO
            SET product_type = JSON_UNQUOTE(JSON_EXTRACT(items, CONCAT('$[', i, '].product_type')));
            SET product_id = JSON_EXTRACT(items, CONCAT('$[', i, '].product_id'));
            SET quantity = JSON_EXTRACT(items, CONCAT('$[', i, '].quantity'));
            SET unit_price = JSON_EXTRACT(items, CONCAT('$[', i, '].unit_price'));

            CALL validate_stock(product_type, product_id, quantity, valid_stock);
            IF valid_stock = 0 THEN
                SET json_out = JSON_OBJECT('h_message', 'Nedovoljna zaliha za proizvod', 'h_errcod', 401);
                RETURN;
            END IF;

            INSERT INTO order_items(order_id, product_type, product_id, quantity, unit_price, total_price)
            VALUES (order_id, product_type, product_id, quantity, unit_price, unit_price * quantity);

            SET i = i + 1;
        END WHILE;

    SET json_out = JSON_OBJECT('order_id', order_id);
END$$

-- Router procedure that dispatches based on JSON input/output
CREATE PROCEDURE p_main(IN p_in JSON, OUT p_out JSON)
BEGIN
    DECLARE l_procedura VARCHAR(40);

    SET l_procedura = JSON_UNQUOTE(JSON_EXTRACT(p_in, '$.procedura'));

    CASE l_procedura
        WHEN 'p_login' THEN CALL p_login(p_in, p_out);
        WHEN 'p_test' THEN CALL p_test(p_in);
        WHEN 'p_get_products' THEN CALL p_get_products(p_in);
        WHEN 'p_create_order' THEN CALL p_create_order(p_in, p_out);
        ELSE
            SET p_out = JSON_OBJECT('h_message', CONCAT('Nepoznata metoda ', l_procedura), 'h_errcod', 997);
        END CASE;
END$$

DELIMITER ;
