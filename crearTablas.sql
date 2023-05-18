CREATE DATABASE IF NOT EXISTS Hotel;

USE Hotel;

CREATE TABLE IF NOT EXISTS servicio(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS tipo_habitacion(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS habitacion(
    numero INT PRIMARY KEY, -- No incremental para tener numeros como 101, 202, 303 
    tipo_id INT,
    FOREIGN KEY (tipo_id)
        REFERENCES tipo_habitacion(id)
);

CREATE TABLE IF NOT EXISTS promocion_servicio(
    id INT PRIMARY KEY AUTO_INCREMENT,
    servicio_id INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (servicio_id)
        REFERENCES servicio(id)
);

CREATE TABLE IF NOT EXISTS promocion_habitacion(
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_id INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (tipo_id)
        REFERENCES tipo_habitacion(id)
);

CREATE TABLE IF NOT EXISTS usuario(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    --correo VARCHAR(100) NOT NULL,
    password VARCHAR(250) NOT NULL
);

CREATE TABLE IF NOT EXISTS contrato_servicio(
    usuario_id INT,
    servicio_id INT,
    PRIMARY KEY(usuario_id, servicio_id),
    fecha_compra DATE NOT NULL,
    fecha_inicio DATE NOT NULL,
    nombre_titular VARCHAR(250) NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (usuario_id)
        REFERENCES usuario(id),
    FOREIGN KEY (servicio_id)
        REFERENCES servicio(id)
);

CREATE TABLE IF NOT EXISTS reserva_habitacion(
    usuario_id INT,
    numero_habitacion INT,
    fecha_reservacion DATE,
    fecha_inicio DATE,
    fecha_fin DATE,
    PRIMARY KEY (usuario_id, numero_habitacion, fecha_reservacion, fecha_inicio),
    -- Un usuario puede reservar la misma habitacion muchas veces, puede hacer muchas reservaciones en un día y puede coincidir en que reserva la misma habitacion el mismo día, pero en diferentes noches. No se puede todo a la vez
    nombre_titular VARCHAR(250) NOT NULL,
    personas INT NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(usuario_id)
        REFERENCES usuario(id),
    FOREIGN KEY (numero_habitacion)
        REFERENCES habitacion(numero)
);

CREATE TABLE IF NOT EXISTS paquete(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(250) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS paquete_incluye(
    paquete_id INT,
    tipo_id INT,
    servicio_id INT,
    PRIMARY KEY(paquete_id, tipo_id, servicio_id),
    FOREIGN KEY (paquete_id)
        REFERENCES paquete(id),
    FOREIGN KEY (tipo_id)
        REFERENCES tipo_habitacion(id),
    FOREIGN KEY (servicio_id)
        REFERENCES servicio(id)
);

CREATE TABLE IF NOT EXISTS reserva_paquete(
    usuario_id INT,
    paquete_id INT,
    fecha_compra DATE,
    fecha_inicio DATE,
    PRIMARY KEY(usuario_id, paquete_id, fecha_compra, fecha_inicio),
    fecha_fin DATE,
    precio_compra DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (usuario_id)
        REFERENCES usuario(id),
    FOREIGN KEY (paquete_id)
        REFERENCES paquete(id)
);

