ALTER TABLE table_order_items
    DROP FOREIGN KEY table_order_items_fk1;

DROP TABLE IF EXISTS table_order_items;
DROP TABLE IF EXISTS table_orders;
DROP TABLE IF EXISTS table_customers;
DROP TABLE IF EXISTS table_cameras;
DROP TABLE IF EXISTS table_lenses;
DROP TABLE IF EXISTS table_equipment;
DROP TABLE IF EXISTS table_films;

CREATE TABLE table_cameras
(
    camera_id   INT AUTO_INCREMENT PRIMARY KEY              NOT NULL,
    image_url   VARCHAR(200),
    category    VARCHAR(50),
    name        VARCHAR(100)                                NOT NULL,
    price       DECIMAL(10, 2)                              NOT NULL,
    stock       INT DEFAULT 0                               NOT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP          NOT NULL,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

CREATE TABLE table_lenses
(
    lens_id     INT AUTO_INCREMENT PRIMARY KEY              NOT NULL,
    image_url   VARCHAR(200),
    category    VARCHAR(50),
    aperture    VARCHAR(50)                                 NOT NULL,
    name        VARCHAR(100)                                NOT NULL,
    price       DECIMAL(10, 2)                              NOT NULL,
    stock       INT DEFAULT 0                               NOT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP          NOT NULL,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

CREATE TABLE table_equipment
(
    table_equipment_id INT AUTO_INCREMENT PRIMARY KEY       NOT NULL,
    image_url   VARCHAR(200),
    category    VARCHAR(50),
    name        VARCHAR(100)                                NOT NULL,
    price       DECIMAL(10, 2)                              NOT NULL,
    stock       INT DEFAULT 0                               NOT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP          NOT NULL,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

CREATE TABLE table_films
(
    film_id     INT AUTO_INCREMENT PRIMARY KEY              NOT NULL,
    image_url   VARCHAR(200),
    category    VARCHAR(50),
    name        VARCHAR(100)                                NOT NULL,
    price       DECIMAL(10, 2)                              NOT NULL,
    stock       INT DEFAULT 0                               NOT NULL,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP          NOT NULL,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

CREATE TABLE table_customers
(
    customer_id INT AUTO_INCREMENT PRIMARY KEY              NOT NULL,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    email       VARCHAR(100)                                NOT NULL UNIQUE,
    password    VARCHAR(100)                                NOT NULL,
    address     VARCHAR(200),
    city        VARCHAR(50),
    zip         VARCHAR(10),
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP          NOT NULL,
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

CREATE TABLE table_orders
(
    order_id         INT AUTO_INCREMENT PRIMARY KEY         NOT NULL,
    customer_id      INT                                    NOT NULL,
    order_date       DATETIME                               NOT NULL,
    status           VARCHAR(20)                            NOT NULL,
    total_amount     DECIMAL(10, 2)                         NOT NULL,
    shipping_address VARCHAR(200),
    payment_method   VARCHAR(30),
    created_at       DATETIME DEFAULT CURRENT_TIMESTAMP     NOT NULL,
    updated_at       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

CREATE TABLE table_order_items
(
    order_item_id INT AUTO_INCREMENT PRIMARY KEY            NOT NULL,
    order_id      INT                                       NOT NULL,
    product_type  VARCHAR(20)                               NOT NULL,
    product_id    INT                                       NOT NULL,
    quantity      INT                                       NOT NULL,
    unit_price    DECIMAL(10, 2)                            NOT NULL,
    total_price   DECIMAL(10, 2)                            NOT NULL,
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP        NOT NULL,
    updated_at    DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

-- indexes
CREATE INDEX idx_orders_customer_id 
    ON table_orders(customer_id);

CREATE INDEX idx_items_order_id 
    ON table_order_items(order_id);

CREATE INDEX idx_items_product 
    ON table_order_items(product_type, product_id);

CREATE INDEX idx_cameras_stock 
    ON table_cameras(stock);

CREATE INDEX idx_lenses_price 
    ON table_lenses(price);

CREATE INDEX idx_equipment_category_stock 
    ON table_equipment(category, stock);

CREATE INDEX idx_orders_order_date 
    ON table_orders(order_date);

-- constraints
ALTER TABLE table_cameras
    ADD CONSTRAINT ck_priceC CHECK (price > 0);
ALTER TABLE table_cameras
    ADD CONSTRAINT ck_stockC CHECK (stock >= 0);

ALTER TABLE table_lenses
    ADD CONSTRAINT ck_priceL CHECK (price > 0);
ALTER TABLE table_lenses
    ADD CONSTRAINT ck_stockL CHECK (stock >= 0);

ALTER TABLE table_equipment
    ADD CONSTRAINT ck_priceE CHECK (price > 0);
ALTER TABLE table_equipment
    ADD CONSTRAINT ck_stockE CHECK (stock >= 0);

ALTER TABLE table_films
    ADD CONSTRAINT ck_priceF CHECK (price > 0);
ALTER TABLE table_films
    ADD CONSTRAINT ck_stockF CHECK (stock >= 0);

ALTER TABLE table_orders
    ADD CONSTRAINT table_orders_fk1 FOREIGN KEY (customer_id) REFERENCES table_customers (customer_id);
ALTER TABLE table_orders
    ADD CONSTRAINT ck_table_orders_status
        CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'));
ALTER TABLE table_orders
    ADD CONSTRAINT ck_total_amount
        CHECK (total_amount >= 0);

ALTER TABLE table_order_items
    ADD CONSTRAINT table_order_items_fk1 FOREIGN KEY (order_id) REFERENCES table_orders (order_id) ON DELETE CASCADE;
ALTER TABLE table_order_items
    ADD CONSTRAINT ck_table_order_items_quantity
        CHECK (quantity > 0);
ALTER TABLE table_order_items
    ADD CONSTRAINT ck_table_order_items_unit_price
        CHECK (unit_price >= 0);
ALTER TABLE table_order_items
    ADD CONSTRAINT ck_table_order_items_total_price
        CHECK (total_price >= 0);
ALTER TABLE table_order_items
    ADD CONSTRAINT ck_table_order_items_product_type
        CHECK (product_type IN ('Camera', 'Lens', 'Film', 'table_equipment'));