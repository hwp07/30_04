CREATE DATABASE mini_mart;

USE mini_mart;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255),
    customer_type ENUM('Normal', 'VIP') DEFAULT 'Normal'
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status ENUM('completed', 'cancelled') DEFAULT 'completed',
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    total_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE DATABASE mini_mart;

USE mini_mart;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address VARCHAR(255),
    customer_type ENUM('Normal', 'VIP') DEFAULT 'Normal'
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) CHECK (price > 0),
    stock INT CHECK (stock >= 0)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status ENUM('completed', 'cancelled') DEFAULT 'completed',
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),
    total_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

INSERT INTO
    customers (
        full_name,
        phone,
        address,
        customer_type
    )
VALUES (
        'Nguyen Van A',
        '0900000001',
        'Ha Noi',
        'VIP'
    ),
    (
        'Tran Thi B',
        '0900000002',
        'HCM',
        'Normal'
    ),
    (
        'Le Van C',
        '0900000003',
        'Da Nang',
        'VIP'
    ),
    (
        'Pham Thi D',
        '0900000004',
        'Hai Phong',
        'Normal'
    ),
    (
        'Hoang Van E',
        '0900000005',
        'Hue',
        'Normal'
    ),
    (
        'Do Thi F',
        '0900000006',
        'Can Tho',
        'Normal'
    ),
    (
        'Vu Van G',
        '0900000007',
        'Ninh Binh',
        'Normal'
    );

INSERT INTO
    products (
        product_name,
        category,
        price,
        stock
    )
VALUES ('Milk', 'Food', 20000, 50),
    ('Bread', 'Food', 10000, 30),
    ('Apple', 'Food', 15000, 20),
    (
        'Shampoo',
        'Cosmetic',
        80000,
        15
    ),
    ('Soap', 'Cosmetic', 20000, 40),
    (
        'Toothpaste',
        'Cosmetic',
        30000,
        25
    ),
    (
        'Notebook',
        'Stationery',
        10000,
        100
    ),
    (
        'Pen',
        'Stationery',
        5000,
        200
    ),
    (
        'Pencil',
        'Stationery',
        3000,
        0
    ),
    (
        'Eraser',
        'Stationery',
        2000,
        60
    );

INSERT INTO
    orders (
        customer_id,
        order_date,
        status
    )
VALUES (1, '2026-04-01', 'completed'),
    (2, '2026-04-02', 'completed'),
    (3, '2026-04-03', 'cancelled'),
    (4, '2026-04-04', 'completed'),
    (5, '2026-04-05', 'completed');

INSERT INTO
    order_details (
        order_id,
        product_id,
        quantity,
        total_price
    )
VALUES (1, 1, 2, 40000),
    (1, 2, 1, 10000),
    (1, 4, 1, 80000),
    (2, 3, 2, 30000),
    (2, 5, 1, 20000),
    (3, 6, 1, 30000),
    (3, 7, 2, 20000),
    (4, 8, 3, 15000),
    (4, 9, 1, 3000),
    (5, 1, 1, 20000),
    (5, 10, 2, 4000),
    (5, 2, 2, 20000);

UPDATE products SET stock = stock - 5 WHERE id = 1;

-- Nước giải khát
SELECT *
FROM products
WHERE
    category = 'Nước giải khát'
    AND price BETWEEN 10000 AND 50000
    AND stock > 0;

-- họ Nguyễn hoặc ở Hà Nội
SELECT *
FROM customers
WHERE
    full_name LIKE 'Nguyễn%'
    OR address = 'Hà Nội';

-- Danh sách tổng quan đơn hàng
SELECT o.id AS order_id, o.order_date, o.status, c.full_name
FROM orders o
    JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

--  Biên lai hóa đơn
SELECT c.full_name, o.order_date, p.product_name, od.quantity, p.price AS unit_price
FROM
    order_details od
    JOIN orders o ON od.order_id = o.id
    JOIN customers c ON o.customer_id = c.id
    JOIN products p ON od.product_id = p.id;

-- Khách hàng chưa từng mua hàng
SELECT *
FROM customers c
    LEFT JOIN orders o ON c.id = o.customer_id
WHERE
    o.id IS NULL;