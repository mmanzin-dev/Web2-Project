-- prikaz svih dostupnih kamera
SELECT camera_id, name, price, stock
FROM cameras
WHERE stock > 0;

-- prikaz objektiva koji su ispod ili 135 eura, silazno
SELECT lens_id, name, aperture, price, stock
FROM lenses
WHERE price <= 135
ORDER BY price DESC;

-- prikaz svih dostupnih bjeskalica
SELECT equipment_id, name, price, stock
FROM equipment
WHERE category = 'Bjeskalica' AND stock > 0;

-- prikaz svih filmova koji su ISO 400
SELECT film_id, name, price, stock
FROM films
WHERE name LIKE '% 400';

-- prikazuje narudzbe napravljene u posljednih 30 dana
SELECT order_id, order_date, status, total_amount
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

-- prikaz narudzbi i detalji o kupcu (inner join orders i customers)
SELECT o.order_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, o.order_date, o.status, o.total_amount
FROM orders o
         JOIN customers c ON o.customer_id = c.customer_id;

-- prikaz svih proizvoda koji pripadaju nekim narudzabama
SELECT oi.order_item_id, oi.order_id, oi.product_type,
       COALESCE(c.name, l.name, e.name, f.name) AS product_name,
       oi.quantity, oi.unit_price, oi.total_price
FROM order_items oi
         LEFT JOIN cameras c ON oi.product_type = 'Camera' AND oi.product_id = c.camera_id
         LEFT JOIN lenses l ON oi.product_type = 'Lens' AND oi.product_id = l.lens_id
         LEFT JOIN equipment e ON oi.product_type = 'equipment' AND oi.product_id = e.equipment_id
         LEFT JOIN films f ON oi.product_type = 'Film' AND oi.product_id = f.film_id;

-- prikaz broja narudzbi po kupcu
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(o.order_id) AS broj_narudzbi
FROM customers c
         LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- koliko je svaki kupac ukupno potrosio
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COALESCE(SUM(o.total_amount), 0) AS ukupna_potrosnja
FROM customers c
         LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- proizvodi koji imaju low stock
SELECT 'Camera' AS product_type, name, stock
FROM cameras
WHERE stock < 5
UNION ALL
SELECT 'Lens', name, stock
FROM lenses
WHERE stock < 5
UNION ALL
SELECT 'Equipment', name, stock
FROM equipment
WHERE stock < 5
UNION ALL
SELECT 'Film', name, stock
FROM films
WHERE stock < 5;
