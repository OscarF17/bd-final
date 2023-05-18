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
