INSERT INTO servicio (nombre, precio) VALUES
    ("Servicio de taxi del aeropuerto al hotel", 800), 
    ("Servicio de taxi del hotel al aeropuerto", 800),
    ("Tour de la ciudad", 1000);


INSERT INTO tipo_habitacion (nombre, precio) VALUES
    ('Sencillo', 1000),
    ('Doble', 1500),
    ('Superior', 2000);

INSERT INTO habitacion (numero, tipo_id) VALUES
    (101, 1), (102, 1), (103, 1), (104, 1), (105, 1), (106, 2), (107, 2), (108, 2), (109, 3), (110, 3),
    (201, 1), (202, 1), (203, 1), (204, 1), (205, 1), (206, 2), (207, 2), (208, 2), (209, 3), (210, 3),
    (301, 1), (302, 1), (303, 1), (304, 1), (305, 1), (306, 2), (307, 2), (308, 2), (309, 3), (310, 3),
    (401, 1), (402, 1), (403, 1), (404, 1), (405, 1), (406, 2), (407, 2), (408, 2), (409, 3), (410, 3);

-- Hay una promocion en habitaciones dobles durante el mes de mayo
INSERT INTO promocion_habitacion (tipo_id, fecha_inicio, fecha_fin) VALUES
    (2, "2023-05-01", "2023-05-31"),
    (2, '2022-01-01', '2022-01-10'),
    (1, '2022-02-15', '2022-02-25'),
    (3, '2022-03-05', '2022-03-15'),
    (2, '2022-04-10', '2022-04-20'),
    (1, '2022-05-25', '2022-06-05'),
    (3, '2022-07-01', '2022-07-10'),
    (2, '2022-08-15', '2022-08-25'),
    (1, '2022-09-10', '2022-09-20'),
    (3, '2022-10-05', '2022-10-15'),
    (2, '2022-11-20', '2022-11-30');

-- Hay una promocion en servicio de taxi de ida al aeropuerto durante mayo
INSERT INTO promocion_servicio (servicio_id, fecha_inicio, fecha_fin) VALUES
    (2, "2023-05-01", "2023-05-31"),
    (2, '2022-01-01', '2022-01-10'),
    (1, '2022-02-15', '2022-02-25'),
    (3, '2022-03-05', '2022-03-15'),
    (2, '2022-04-10', '2022-04-20'),
    (1, '2022-05-25', '2022-06-05'),
    (3, '2022-07-01', '2022-07-10'),
    (2, '2022-08-15', '2022-08-25'),
    (1, '2022-09-10', '2022-09-20'),
    (3, '2022-10-05', '2022-10-15'),
    (2, '2022-11-20', '2022-11-30');

INSERT INTO usuario (primer_nombre, segundo_nombre, apellido_paterno, apellido_materno, correo, password) VALUES
    ('John', 'Doe', 'Smith', 'Johnson', 'john.doe@example.com', 'AAA'),
    ('Jane', 'Doe', 'Brown', 'Davis', 'jane.doe@example.com', 'AAA'),
    ('Michael', 'Smith', 'Johnson', 'Williams', 'michael.smith@example.com', 'AAA'),
    ('Emily', 'Grace', 'Taylor', 'Anderson', 'emily.grace@example.com', 'AAA'),
    ('David', 'Robert', 'Clark', 'Harris', 'david.robert@example.com', 'AAA'),
    ('Sarah', 'Elizabeth', 'Thomas', 'Lewis', 'sarah.elizabeth@example.com', 'AAA'),
    ('Matthew', 'James', 'Martin', 'Walker', 'matthew.james@example.com', 'AAA'),
    ('Olivia', 'Sophia', 'Lee', 'Allen', 'olivia.sophia@example.com', 'AAA'),
    ('Andrew', 'Daniel', 'Young', 'Nelson', 'andrew.daniel@example.com', 'AAA'),
    ('Emma', 'Ava', 'Robinson', 'Baker', 'emma.ava@example.com', 'AAA'),
    ("Oscar", "Luciano", "Flores", "Leija", "oscar.floresl@udem.edu", "666");

INSERT INTO contrato_servicio (usuario_id, servicio_id, fecha_compra, fecha_inicio, nombre_titular, precio_compra) VALUES 
    (1, 1, '2023-01-09', '2023-01-10','John Doe', 800),
    (2, 3, '2023-01-11', '2023-02-10','Jane Smith', 1000),
    (3, 2, '2023-02-21', '2023-03-10', 'Michael Johnson', 800),
    (4, 1, '2023-02-07', '2023-04-10', 'Emily Davis', 800),
    (5, 3, '2023-03-06', '2023-05-10', 'David Harris', 1000),
    (6, 3, '2023-03-05', '2023-06-10', 'Sarah Lewis', 1000),
    (7, 3, '2023-04-23', '2023-07-10', 'Matthew Walker', 1000),
    (8, 2, '2023-04-12', '2023-08-10', 'Olivia Allen', 800),
    (9, 3, '2023-04-04', '2023-09-10', 'Andrew Nelson', 1000),
    (10, 1, '2023-04-15', '2023-10-10', 'Emma Baker', 800);

INSERT INTO reserva_habitacion (usuario_id, numero_habitacion, fecha_reservacion, fecha_inicio, fecha_fin, nombre_titular, personas, precio_compra) VALUES
    (1, '401', '2023-01-01', '2023-01-10', '2023-01-15', 'John Doe', 1, 1000),
    (2, '302', '2023-02-01', '2023-02-10', '2023-02-15', 'Jane Smith', 2, 1000),
    (3, '103', '2023-03-01', '2023-03-10', '2023-03-15', 'Michael Johnson', 1, 1000),
    (4, '204', '2023-04-01', '2023-04-10', '2023-04-15', 'Emily Davis', 2, 1000),
    (5, '105', '2023-05-01', '2023-05-10', '2023-05-15', 'David Harris', 1, 1000),
    (6, '206', '2023-06-01', '2023-06-10', '2023-06-15', 'Sarah Lewis', 2, 1500),
    (7, '107', '2023-07-01', '2023-07-10', '2023-07-15', 'Matthew Walker', 1, 1500),
    (8, '108', '2023-08-01', '2023-08-10', '2023-08-15', 'Olivia Allen', 2, 1500),
    (9, '409', '2023-09-01', '2023-09-10', '2023-09-15', 'Andrew Nelson', 1, 2000),
    (10, '310', '2023-10-01', '2023-10-10', '2023-10-15', 'Emma Baker', 2, 2000);

INSERT INTO paquete (nombre, precio) VALUES
    (1, 1500),
    (2, 2000);

INSERT INTO paquete_incluye(paquete_id, tipo_id, servicio_id) VALUES
    (1, 1, 1),
    (2, 3, 3);

INSERT INTO reserva_paquete(usuario_id, paquete_id, fecha_compra, fecha_inicio, fecha_fin, precio_compra) VALUES
    (11, 1, "2023-05-01", "2023-06-10", "2023-06-15", 1500);
