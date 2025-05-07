-- Base de datos para la óptica 
DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

-- Limpieza de tablas existentes
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS sales_periods;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS glasses;
DROP TABLE IF EXISTS brands;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS supplier;

-- Tabla de proveedores
CREATE TABLE supplier (
    supplier_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    street VARCHAR(150),
    street_number VARCHAR(20),
    floor VARCHAR(10),
    door VARCHAR(10),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50),
    phone VARCHAR(25),
    fax VARCHAR(25),
    nif CHAR(9)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de marcas
CREATE TABLE brands (
    brand_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    supplier_id INT(10),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de gafas
CREATE TABLE glasses (
    glasses_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    brand_id INT(10),
    prescription_right VARCHAR(50),
    prescription_left VARCHAR(50),
    frame_type ENUM('flotante', 'pasta', 'metálica'),
    frame_color VARCHAR(50),
    lens_color VARCHAR(50),
    price DECIMAL(8,2),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de clientes
CREATE TABLE client (
    client_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    street VARCHAR(150),
    street_number VARCHAR(20),
    floor VARCHAR(10),
    door VARCHAR(10),
    city VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50),
    phone_number VARCHAR(25),
    email VARCHAR(255),
    date_sign_in DATE,
    recommended_by_client_id INT(10),
    FOREIGN KEY (recommended_by_client_id) REFERENCES client(client_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de empleados
CREATE TABLE employees (
    employee_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla para períodos de ventas
CREATE TABLE sales_periods (
    period_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    period_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla de ventas
CREATE TABLE sales (
    sale_id INT(10) AUTO_INCREMENT PRIMARY KEY,
    glasses_id INT(10),
    client_id INT(10),
    employee_id INT(10),
    period_id INT(10),
    sale_timestamp TIMESTAMP,
    sale_price DECIMAL(8,2),
    FOREIGN KEY (glasses_id) REFERENCES glasses(glasses_id),
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (period_id) REFERENCES sales_periods(period_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertar datos de ejemplo
-- Proveedores
INSERT INTO supplier (name, street, street_number, floor, door, city, postal_code, country, phone, fax, nif) 
VALUES ('OptiVision', 'Calle Mayor', '23', '4', 'A', 'Barcelona', '08001', 'España', '934567890', '934567891', 'B12345678');

INSERT INTO supplier (name, street, street_number, floor, door, city, postal_code, country, phone, fax, nif) 
VALUES ('LuxGlasses', 'Avenida Diagonal', '456', '2', 'B', 'Barcelona', '08006', 'España', '935678901', '935678902', 'B87654321');

-- Marcas
INSERT INTO brands (name, supplier_id) VALUES ('Ray-Ban', 1);
INSERT INTO brands (name, supplier_id) VALUES ('Oakley', 1);
INSERT INTO brands (name, supplier_id) VALUES ('Prada', 2);

-- Gafas
INSERT INTO glasses (brand_id, prescription_right, prescription_left, frame_type, frame_color, lens_color, price) 
VALUES (1, '+1.50', '+1.75', 'metálica', 'negro', 'transparente', 150.00);

INSERT INTO glasses (brand_id, prescription_right, prescription_left, frame_type, frame_color, lens_color, price) 
VALUES (2, '-2.25', '-2.00', 'pasta', 'azul', 'gris', 175.50);

INSERT INTO glasses (brand_id, prescription_right, prescription_left, frame_type, frame_color, lens_color, price) 
VALUES (3, '+0.75', '+0.75', 'flotante', 'dorado', 'marrón', 225.00);

-- Clientes
INSERT INTO client (name, street, street_number, floor, door, city, postal_code, country, phone_number, email, date_sign_in, recommended_by_client_id) 
VALUES ('Ana García', 'Calle Provenza', '123', '1', '1', 'Barcelona', '08015', 'España', '666111222', 'ana@email.com', '2023-01-15', NULL);

INSERT INTO client (name, street, street_number, floor, door, city, postal_code, country, phone_number, email, date_sign_in, recommended_by_client_id) 
VALUES ('Carlos Martínez', 'Calle Mallorca', '45', '3', '2', 'Barcelona', '08013', 'España', '666333444', 'carlos@email.com', '2023-02-20', 1);

-- Empleados
INSERT INTO employees (first_name, last_name) VALUES ('Laura', 'Fernández');
INSERT INTO employees (first_name, last_name) VALUES ('Miguel', 'Sánchez');

-- Períodos de ventas
INSERT INTO sales_periods (period_name, start_date, end_date, description) 
VALUES ('Primer Trimestre 2024', '2024-01-01', '2024-03-31', 'Ventas del primer trimestre');

INSERT INTO sales_periods (period_name, start_date, end_date, description) 
VALUES ('Segundo Trimestre 2024', '2024-04-01', '2024-06-30', 'Ventas del segundo trimestre');

-- Ventas
INSERT INTO sales (glasses_id, client_id, employee_id, period_id, sale_timestamp, sale_price) 
VALUES (1, 1, 1, 1, '2024-01-10 10:30:00', 150.00);

INSERT INTO sales (glasses_id, client_id, employee_id, period_id, sale_timestamp, sale_price) 
VALUES (2, 1, 2, 1, '2024-02-15 16:45:00', 175.50);

INSERT INTO sales (glasses_id, client_id, employee_id, period_id, sale_timestamp, sale_price) 
VALUES (3, 2, 1, 1, '2024-03-20 12:15:00', 225.00);

-- Consultas requeridas

-- 1. Lista el total de compras de un cliente/a
-- SELECT c.name AS cliente, COUNT(s.sale_id) AS total_compras, SUM(s.sale_price) AS importe_total
-- FROM client c
-- JOIN sales s ON c.client_id = s.client_id
-- WHERE c.client_id = 1
-- GROUP BY c.client_id, c.name;

-- 2. Lista las distintas gafas que ha vendido un empleado durante un año
-- SELECT e.first_name, e.last_name, g.glasses_id, b.name AS marca, g.frame_type, g.frame_color, s.sale_timestamp
-- FROM employees e
-- JOIN sales s ON e.employee_id = s.employee_id
-- JOIN glasses g ON s.glasses_id = g.glasses_id
-- JOIN brands b ON g.brand_id = b.brand_id
-- WHERE e.employee_id = 1 
-- AND YEAR(s.sale_timestamp) = 2024
-- ORDER BY s.sale_timestamp;

-- 3. Lista a los diferentes proveedores que han suministrado gafas vendidas con éxito por la óptica
-- SELECT DISTINCT sup.supplier_id, sup.name AS proveedor, sup.nif
-- FROM supplier sup
-- JOIN brands b ON sup.supplier_id = b.supplier_id
-- JOIN glasses g ON b.brand_id = g.brand_id
-- JOIN sales s ON g.glasses_id = s.glasses_id
-- ORDER BY sup.name;