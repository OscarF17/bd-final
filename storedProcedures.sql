DELIMITER ..
CREATE PROCEDURE crearUsuario(
    IN inUsername VARCHAR(50),
    IN inNombre VARCHAR(200),
    IN inPassword VARCHAR(250)
)
BEGIN
    INSERT INTO usuario (username, nombre, password) VALUES
        (inUsername, inNombre, inPassword);
END ..
DELIMITER ;

DELIMITER ..
CREATE PROCEDURE buscarReservacionesUsuario(
    IN inUser_id INT 
)
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = CURDATE(); -- Obtener la fecha actual

    -- Regresar todo para tener los datos listos
    SELECT * FROM reserva_habitacion, habitacion, tipo_habitacion WHERE
        reserva_habitacion.usuario_id = inUser_id
        AND reserva_habitacion.numero_habitacion = habitacion.numero
        AND habitacion.tipo_id = tipo_habitacion.id
        AND fecha_inicio > currentDate; -- Filtrar por fecha de inicio posterior a la fecha actual
END ..
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borrarReservacion(
    IN in_usuario_id INT,
    IN in_numero_habitacion INT,
    IN in_fecha_reservacion DATE,
    IN in_fecha_inicio DATE
)
BEGIN
    DELETE FROM reserva_habitacion
    WHERE usuario_id = in_usuario_id
    AND numero_habitacion = in_numero_habitacion
    AND fecha_reservacion = in_fecha_reservacion
    AND fecha_inicio = in_fecha_inicio;
END //
DELIMITER ;

DELIMITER //    
CREATE PROCEDURE verificarDisponibilidad(
    IN tipo_habitacion_id INT,
    IN fecha_inicio DATE,
    IN duracion INT,
    OUT num INT
)
BEGIN
    DECLARE fecha_fin DATE;
    
    -- Calcular la fecha de fin sumando la duración a la fecha de inicio
    SET fecha_fin = DATE_ADD(fecha_inicio, INTERVAL duracion DAY);

    -- Buscar una habitación disponible y obtener su número
    SELECT h.numero INTO num
    FROM habitacion h
    WHERE h.tipo_id = tipo_habitacion_id
        AND NOT EXISTS (
            SELECT 1
            FROM reserva_habitacion r
            WHERE r.numero_habitacion = h.numero
                AND (
                    (r.fecha_inicio <= fecha_fin AND r.fecha_fin >= fecha_inicio)
                    OR (r.fecha_inicio <= fecha_inicio AND r.fecha_fin >= fecha_fin)
                    OR (r.fecha_inicio >= fecha_inicio AND r.fecha_fin <= fecha_fin)
                )
        )
    LIMIT 1;
    
END //
DELIMITER ;

DELIMITER //    
CREATE PROCEDURE verificarDisponibilidadSinOutput(
    IN tipo_habitacion_id INT,
    IN fecha_inicio DATE,
    IN duracion INT
)
BEGIN
    DECLARE fecha_fin DATE;
    
    -- Calcular la fecha de fin sumando la duración a la fecha de inicio
    SET fecha_fin = DATE_ADD(fecha_inicio, INTERVAL duracion DAY);

    -- Buscar una habitación disponible y obtener su número
    SELECT h.numero 
    FROM habitacion h
    WHERE h.tipo_id = tipo_habitacion_id
        AND NOT EXISTS (
            SELECT 1
            FROM reserva_habitacion r
            WHERE r.numero_habitacion = h.numero
                AND (
                    (r.fecha_inicio <= fecha_fin AND r.fecha_fin >= fecha_inicio)
                    OR (r.fecha_inicio <= fecha_inicio AND r.fecha_fin >= fecha_fin)
                    OR (r.fecha_inicio >= fecha_inicio AND r.fecha_fin <= fecha_fin)
                )
        );
    
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE agregarReservacion(
    IN usuario_id INT,
    IN tipo_habitacion_id INT,
    IN fecha_ingresada DATE,
    IN dias INT,
    IN nombre_titular VARCHAR(250),
    IN personas INT
)
BEGIN
    DECLARE fecha_reservacion DATE;
    DECLARE fecha_fin DATE;
    DECLARE precioH DECIMAL(10,2);
    DECLARE numero_habitacion_reservar INT;
    DECLARE precio_compra DECIMAL(10,2);
    
    -- Obtener la fecha de reservación actual
    SET fecha_reservacion = CURDATE();
    
    -- Calcular la fecha de inicio y fecha de fin basado en el número de días
    SET fecha_fin = DATE_ADD(fecha_ingresada, INTERVAL dias - 1 DAY);
    -- Calcular el precio de compra
    SET precioH = (SELECT precio FROM tipo_habitacion WHERE tipo_habitacion.id = tipo_habitacion_id);
    SET precio_compra = dias * (precioH + personas * 200);

    -- Llamar al procedimiento verificarDisponibilidad para obtener una habitación disponible
    CALL verificarDisponibilidad(tipo_habitacion_id, fecha_ingresada, dias, numero_habitacion_reservar);
    SELECT numero_habitacion_reservar;

    -- Insertar la nueva reservación
    INSERT INTO reserva_habitacion (usuario_id, numero_habitacion, fecha_reservacion, fecha_inicio, fecha_fin, nombre_titular, personas, precio_compra)
    VALUES (usuario_id, numero_habitacion_reservar, fecha_reservacion, fecha_ingresada, fecha_fin, nombre_titular, personas, precio_compra);
    
END //
DELIMITER ;


DELIMITER ..
CREATE PROCEDURE obtenerDatosTipo(
)
BEGIN
    SELECT * FROM tipo_habitacion;
END ..
DELIMITER ;


DELIMITER ..
CREATE PROCEDURE actualizarPrecioTipo(
    IN tipo INT,
    IN nuevo_precio DECIMAL(10,2)
)
BEGIN
    UPDATE tipo_habitacion SET precio=nuevo_precio WHERE id = tipo;
END ..
DELIMITER ;

DELIMITER ..
CREATE PROCEDURE actualizarDatosUsuario(
    IN usuario_id INT,
    IN nuevo_nombre VARCHAR(200),
    IN pass VARCHAR(250)
)
BEGIN
    UPDATE usuario SET nombre=nuevo_nombre, password=pass WHERE id=usuario_id;
END ..
DELIMITER ;

DELIMITER ..
CREATE PROCEDURE reservarServicio(
    IN user_id INT,
    IN servicio INT,
    IN fecha DATE,
    IN horario TIME
)
BEGIN
    DECLARE fecha_actual DATE;
    DECLARE p DECIMAL(10,2); 
    SET fecha_actual = CURDATE(); -- Obtener la fecha actual
    SET p = (SELECT precio FROM servicio WHERE id = servicio);
    INSERT INTO contrato_servicio 
    (usuario_id, servicio_id, fecha_compra, fecha_inicio, hora, precio_compra) VALUES
    (user_id, servicio, fecha_actual, fecha, horario, p);
END ..
DELIMITER ;

DELIMITER ..
CREATE PROCEDURE obtenerDatosPaquetes(
)
BEGIN
    SELECT * FROM paquete;
END..
DELIMITER ;

DELIMITER ..
CREATE PROCEDURE reservarPaquete(
    IN user_id INT,
    IN pid INT,
    IN fecha DATE,
    IN dias INT
)
BEGIN
    DECLARE currentDate DATE;
    DECLARE p DECIMAL(10,2);
    DECLARE fecha2 DATE;

    SET currentDate = CURDATE();
    SET p = (SELECT precio FROM paquete WHERE id = pid);
    SET fecha2 = DATE_ADD(fecha, INTERVAL dias DAY);
    INSERT INTO reserva_paquete (usuario_id, paquete_id, fecha_compra, fecha_inicio, fecha_fin, precio_compra) VALUES
    (user_id, pid, currentDate, fecha, fecha2, p);
END ..
DELIMITER ;

