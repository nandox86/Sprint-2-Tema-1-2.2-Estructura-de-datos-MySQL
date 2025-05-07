--base de datos para la pizzería 
DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

--Limpieza 
DROP TABLE IF EXISTS delivery_details;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS pizza_categories;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS clients;

-- tabla de clientes
CREATE TABLE clients (
    client_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de tiendas
CREATE TABLE stores (
    store_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- tabla de empleados
CREATE TABLE employees (
    employee_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nif VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role ENUM('cocinero', 'repartidor') NOT NULL,
    store_id INT(10) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de categorías de pizzas
CREATE TABLE pizza_categories (
    category_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de productos
CREATE TABLE products (
    product_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image VARCHAR(255),
    price DECIMAL(8,2) NOT NULL,
    type ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
    category_id INT(10) NULL,
    FOREIGN KEY (category_id) REFERENCES pizza_categories(category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de pedidos
CREATE TABLE orders (
    order_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    client_id INT(10) NOT NULL,
    order_datetime DATETIME NOT NULL,
    delivery_type ENUM('domicilio', 'tienda') NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    store_id INT(10) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de detalles de pedidos
CREATE TABLE order_items (
    order_item_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    order_id INT(10) NOT NULL,
    product_id INT(10) NOT NULL,
    quantity INT(5) NOT NULL,
    item_price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de detalles de entrega a domicilio
CREATE TABLE delivery_details (
    delivery_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    order_id INT(10) NOT NULL,
    delivery_employee_id INT(10) NOT NULL,
    delivery_datetime DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (delivery_employee_id) REFERENCES employees(employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertar datos de ejemplos

-- clientes
INSERT INTO clients (name, last_name, address, postal_code, city, state, phone) 
VALUES ('Carlos', 'Rodríguez', 'Av. Francisco de Miranda, Res. El Rosal', '1060', 'Caracas', 'Distrito Capital', '0414-1234567');

INSERT INTO clients (name, last_name, address, postal_code, city, state, phone) 
VALUES ('María', 'González', 'Calle Urdaneta, Quinta Santa Inés', '2103', 'Maracaibo', 'Zulia', '0424-7654321');

INSERT INTO clients (name, last_name, address, postal_code, city, state, phone) 
VALUES ('José', 'Hernández', 'Av. Bolívar, Edif. Las Américas', '3001', 'Valencia', 'Carabobo', '0416-9876543');

INSERT INTO clients (name, last_name, address, postal_code, city, state, phone) 
VALUES ('Ana', 'Pérez', 'Calle Sucre, Res. El Paraíso', '6001', 'Barquisimeto', 'Lara', '0412-3456789');

--Tiendas
INSERT INTO stores (address, postal_code, city, state) 
VALUES ('Av. Libertador, C.C. Sambil', '1060', 'Caracas', 'Distrito Capital');

INSERT INTO stores (address, postal_code, city, state) 
VALUES ('Av. 5 de Julio, C.C. Lago Mall', '2103', 'Maracaibo', 'Zulia');

INSERT INTO stores (address, postal_code, city, state) 
VALUES ('Av. Bolívar Norte, C.C. Metrópolis', '3001', 'Valencia', 'Carabobo');

--empleados
INSERT INTO employees (name, last_name, nif, phone, role, store_id) 
VALUES ('Pedro', 'Martínez', 'V-12345678', '0414-1112233', 'cocinero', 1);

INSERT INTO employees (name, last_name, nif, phone, role, store_id) 
VALUES ('Luisa', 'Fernández', 'V-23456789', '0424-2223344', 'repartidor', 1);

INSERT INTO employees (name, last_name, nif, phone, role, store_id) 
VALUES ('Miguel', 'Sánchez', 'V-34567890', '0416-3334455', 'cocinero', 2);

INSERT INTO employees (name, last_name, nif, phone, role, store_id) 
VALUES ('Carmen', 'López', 'V-45678901', '0412-4445566', 'repartidor', 2);

INSERT INTO employees (name, last_name, nif, phone, role, store_id) 
VALUES ('Juan', 'Díaz', 'V-56789012', '0414-5556677', 'cocinero', 3);

INSERT INTO employees (name, last_name, nif, phone, role, store_id) 
VALUES ('Laura', 'Gómez', 'V-67890123', '0424-6667788', 'repartidor', 3);

-- Categorías de pizzas
INSERT INTO pizza_categories (name) VALUES ('Tradicionales');
INSERT INTO pizza_categories (name) VALUES ('Gourmet');
INSERT INTO pizza_categories (name) VALUES ('Venezolanas');
INSERT INTO pizza_categories (name) VALUES ('Vegetarianas');

-- Productos
--pizzas
INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Pizza Margarita', 'Salsa de tomate, mozzarella y albahaca', 'margarita.jpg', 12.99, 'pizza', 1);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Pizza Pepperoni', 'Salsa de tomate, mozzarella y pepperoni', 'pepperoni.jpg', 14.99, 'pizza', 1);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Pizza Cuatro Quesos', 'Mozzarella, gorgonzola, parmesano y gouda', 'cuatro_quesos.jpg', 16.99, 'pizza', 2);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Pizza Pabellón', 'Carne mechada, plátano maduro, caraotas negras y queso', 'pabellon.jpg', 18.99, 'pizza', 3);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Pizza Vegetariana', 'Pimentón, cebolla, champiñones, aceitunas y maíz', 'vegetariana.jpg', 15.99, 'pizza', 4);

-- Hamburguesas
INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Hamburguesa Clásica', 'Carne, queso, lechuga, tomate y salsa especial', 'hamburguesa_clasica.jpg', 9.99, 'hamburguesa', NULL);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Hamburguesa Doble', 'Doble carne, doble queso, bacon, lechuga y tomate', 'hamburguesa_doble.jpg', 12.99, 'hamburguesa', NULL);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Hamburguesa Criolla', 'Carne, queso, aguacate, plátano frito y salsa de ajo', 'hamburguesa_criolla.jpg', 11.99, 'hamburguesa', NULL);

--Bebidas
INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Refresco Cola', 'Refresco de cola 500ml', 'refresco_cola.jpg', 2.50, 'bebida', NULL);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Jugo de Parchita', 'Jugo natural de parchita 500ml', 'jugo_parchita.jpg', 3.50, 'bebida', NULL);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Malta', 'Malta 355ml', 'malta.jpg', 2.00, 'bebida', NULL);

INSERT INTO products (name, description, image, price, type, category_id) 
VALUES ('Agua Mineral', 'Agua mineral 500ml', 'agua.jpg', 1.50, 'bebida', NULL);

-- Pedidos
INSERT INTO orders (client_id, order_datetime, delivery_type, total_price, store_id) 
VALUES (1, '2024-05-01 13:30:00', 'domicilio', 31.48, 1);

INSERT INTO orders (client_id, order_datetime, delivery_type, total_price, store_id) 
VALUES (2, '2024-05-02 19:45:00', 'tienda', 18.99, 2);

INSERT INTO orders (client_id, order_datetime, delivery_type, total_price, store_id) 
VALUES (3, '2024-05-03 20:15:00', 'domicilio', 26.98, 3);

INSERT INTO orders (client_id, order_datetime, delivery_type, total_price, store_id) 
VALUES (4, '2024-05-04 14:00:00', 'domicilio', 22.49, 1);

INSERT INTO orders (client_id, order_datetime, delivery_type, total_price, store_id) 
VALUES (1, '2024-05-05 21:30:00', 'tienda', 35.97, 1);

--detalles de pedidos
INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (1, 1, 1, 12.99);  -- Pizza Margarita

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (1, 9, 2, 2.50);   -- 2 Refrescos Cola

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (1, 11, 1, 2.00);  -- 1 Malta

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (1, 12, 1, 1.50);  -- 1 Agua Mineral

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (2, 4, 1, 18.99);  -- Pizza Pabellón

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (3, 2, 1, 14.99);  -- Pizza Pepperoni

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (3, 9, 2, 2.50);   -- 2 Refrescos Cola

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (3, 10, 2, 3.50);  -- 2 Jugos de Parchita

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (4, 6, 1, 9.99);   -- Hamburguesa Clásica

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (4, 9, 1, 2.50);   -- 1 Refresco Cola

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (4, 10, 1, 3.50);  -- 1 Jugo de Parchita

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (5, 3, 1, 16.99);  -- Pizza Cuatro Quesos

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (5, 8, 1, 11.99);  -- Hamburguesa Criolla

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (5, 9, 2, 2.50);   -- 2 Refrescos Cola

INSERT INTO order_items (order_id, product_id, quantity, item_price) 
VALUES (5, 11, 1, 2.00);  -- 1 Malta

-- Detalles de entrega a domicilio
INSERT INTO delivery_details (order_id, delivery_employee_id, delivery_datetime) 
VALUES (1, 2, '2024-05-01 14:15:00');  -- Entrega por Luisa Fernández

INSERT INTO delivery_details (order_id, delivery_employee_id, delivery_datetime) 
VALUES (3, 6, '2024-05-03 21:00:00');  -- Entrega por Laura Gómez

INSERT INTO delivery_details (order_id, delivery_employee_id, delivery_datetime) 
VALUES (4, 2, '2024-05-04 14:45:00');  -- Entrega por Luisa Fernández

-- Consultas requeridas

-- 1. Lista cuántos productos de tipo "Bebidas" se han vendido en una determinada localidad
-- SELECT s.city, SUM(oi.quantity) AS total_bebidas_vendidas
-- FROM order_items oi
-- JOIN products p ON oi.product_id = p.product_id
-- JOIN orders o ON oi.order_id = o.order_id
-- JOIN stores s ON o.store_id = s.store_id
-- WHERE p.type = 'bebida' AND s.city = 'Caracas'
-- GROUP BY s.city;

-- 2. Lista cuántos pedidos ha efectuado un determinado empleado/a
-- SELECT CONCAT(e.name, ' ', e.last_name) AS empleado, COUNT(dd.delivery_id) AS total_pedidos_entregados
-- FROM employees e
-- LEFT JOIN delivery_details dd ON e.employee_id = dd.delivery_employee_id
-- WHERE e.employee_id = 2
-- GROUP BY e.employee_id, e.name, e.last_name;