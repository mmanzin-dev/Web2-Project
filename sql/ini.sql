SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS cameras;
DROP TABLE IF EXISTS lenses;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS films;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE cameras (
                         camera_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                         image_url VARCHAR(200),
                         category VARCHAR(50),
                         name VARCHAR(100) NOT NULL,
                         price DECIMAL(10,2) NOT NULL,
                         stock INT NOT NULL DEFAULT 0,
                         created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         updated_at DATETIME NULL DEFAULT NULL,
                         PRIMARY KEY (camera_id),
                         CONSTRAINT ck_priceC CHECK (price > 0),
                         CONSTRAINT ck_stockC CHECK (stock >= 0)
);

CREATE TABLE lenses (
                        lens_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                        image_url VARCHAR(200),
                        category VARCHAR(50),
                        aperture VARCHAR(50) NOT NULL,
                        name VARCHAR(100) NOT NULL,
                        price DECIMAL(10,2) NOT NULL,
                        stock INT NOT NULL DEFAULT 0,
                        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME NULL DEFAULT NULL,
                        PRIMARY KEY (lens_id),
                        CONSTRAINT ck_priceL CHECK (price > 0),
                        CONSTRAINT ck_stockL CHECK (stock >= 0)
);

CREATE TABLE equipment (
                           equipment_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                           image_url VARCHAR(200),
                           category VARCHAR(50),
                           name VARCHAR(100) NOT NULL,
                           price DECIMAL(10,2) NOT NULL,
                           stock INT NOT NULL DEFAULT 0,
                           created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           updated_at DATETIME NULL DEFAULT NULL,
                           PRIMARY KEY (equipment_id),
                           CONSTRAINT ck_priceE CHECK (price > 0),
                           CONSTRAINT ck_stockE CHECK (stock >= 0)
);

CREATE TABLE films (
                       film_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                       image_url VARCHAR(200),
                       category VARCHAR(50),
                       name VARCHAR(100) NOT NULL,
                       price DECIMAL(10,2) NOT NULL,
                       stock INT NOT NULL DEFAULT 0,
                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at DATETIME NULL DEFAULT NULL,
                       PRIMARY KEY (film_id),
                       CONSTRAINT ck_priceF CHECK (price > 0),
                       CONSTRAINT ck_stockF CHECK (stock >= 0)
);

CREATE TABLE customers (
                           customer_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                           first_name VARCHAR(50),
                           last_name VARCHAR(50),
                           email VARCHAR(100) NOT NULL UNIQUE,
                           password VARCHAR(100) NOT NULL,
                           address VARCHAR(200),
                           city VARCHAR(50),
                           zip VARCHAR(10),
                           created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           updated_at DATETIME NULL DEFAULT NULL,
                           PRIMARY KEY (customer_id)
);

CREATE TABLE orders (
                        order_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                        customer_id INT NOT NULL,
                        order_date DATETIME NOT NULL,
                        status VARCHAR(20) NOT NULL,
                        total_amount DECIMAL(10,2) NOT NULL,
                        shipping_address VARCHAR(200),
                        payment_method VARCHAR(30),
                        created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME NULL DEFAULT NULL,
                        PRIMARY KEY (order_id),
                        CONSTRAINT orders_fk1 FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
                        CONSTRAINT ck_orders_status CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
                        CONSTRAINT ck_total_amount CHECK (total_amount >= 0)
);

CREATE TABLE order_items (
                             order_item_id INT NOT NULL AUTO_INCREMENT UNIQUE,
                             order_id INT NOT NULL,
                             product_type VARCHAR(20) NOT NULL,
                             product_id INT NOT NULL,
                             quantity INT NOT NULL,
                             unit_price DECIMAL(10,2) NOT NULL,
                             total_price DECIMAL(10,2) NOT NULL,
                             created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             updated_at DATETIME NULL DEFAULT NULL,
                             PRIMARY KEY (order_item_id),
                             CONSTRAINT order_items_fk1 FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
                             CONSTRAINT ck_order_items_quantity CHECK (quantity > 0),
                             CONSTRAINT ck_order_items_unit_price CHECK (unit_price >= 0),
                             CONSTRAINT ck_order_items_total_price CHECK (total_price >= 0),
                             CONSTRAINT ck_order_items_product_type CHECK (product_type IN ('Camera', 'Lens', 'Film', 'equipment'))
);

DELIMITER $$

CREATE TRIGGER cameras_before_update
    BEFORE UPDATE ON cameras
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER lenses_before_update
    BEFORE UPDATE ON lenses
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER films_before_update
    BEFORE UPDATE ON films
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER equipment_before_update
    BEFORE UPDATE ON equipment
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER customers_before_update
    BEFORE UPDATE ON customers
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER orders_before_update
    BEFORE UPDATE ON orders
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER order_items_before_update
    BEFORE UPDATE ON order_items
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;