Pasos para la correcta ejecucion de la vista web


1. Crear una carpeta donde se almacenara el proyecto

2. Descromprimir el archivo hotel.zip dentro de la carpeta

3. Acceder mediante el cmd o consola a la carpeta del proyecto

4. Ejecutar el siguiente comando en la consola
	pip install -r requirements.txt
	
	Esto instalara todos los servicios y aplicaciones necesarias para el correcto funcionamiento del proyecto

5. Acceder a mysql utilizando el root
	mysql -u root -p

6. Crear la bd hotel
	CREATE DATABASE Hotel;

7. Crear el usuario adminHotel con contraseña y darle los permisos sobre la bd
	CREATE USER 'hotelAdmin'@'localhost' IDENTIFIED BY '666';
	GRANT ALL PRIVILEGES ON Hotel.* TO 'hotelAdmin'@'localhost';
	FLUSH PRIVILEGES;

8. Salir de mysql e importar el dump y los stores procedures
	mysql -u root -p Hotel < dump.sql

	mysql -u root -p Hotel < storedProcedures.sql

9. Ejecutar el proyecto con

	python app.py 
	

