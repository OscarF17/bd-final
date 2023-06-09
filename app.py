from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash 

from config import config


# Models:
from models.ModelUser import ModelUser

# Entities:
from models.entities.User import User

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'hotelAdmin'
app.config['MYSQL_PASSWORD'] = '666'
app.config['MYSQL_DB'] = 'hotel'
app.config['SECRET_KEY'] = 'B!1w8NAt1T^%kvhUI*S^'


db=MySQL(app)
login_manager_app = LoginManager(app)


@login_manager_app.user_loader
def load_user(id):
    return ModelUser.get_by_id(db, id)


@app.route('/')
def index():
        return redirect(url_for('login'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        user = User(0, request.form['username'], request.form['password'])
        logged_user = ModelUser.login(db, user)
        if logged_user != None:
            if logged_user.password:
                login_user(logged_user)
                return redirect(url_for('home'))
            else:
                flash("Invalid password...")
                return render_template('auth/login.html')
        else:
            flash("User not found...")
            return render_template('auth/login.html')
    else:
        return render_template('auth/login.html')

### RUTAS PARA LOGIN Y CUENTAS
@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('login'))

@app.route('/home')
@login_required
def home():
    return render_template('home.html')

@app.route('/miCuenta')
@login_required
def miCuenta():
    user_id = current_user.id
    cursor = db.connection.cursor()
    cursor.callproc('buscarReservacionesUsuario', [user_id])
    reservaciones = cursor.fetchall()
    cursor.nextset()
    cursor.connection.commit()
    cursor.close()
    return render_template('miCuenta.html', reservaciones = reservaciones)

@app.route('/actualizarInformacion', methods=['POST', 'GET'])
@login_required
def actualizarInformacion():
    if request.method == 'POST':
        user_id = current_user.id
        nombre = request.form['nombre']
        password = request.form['password']
        hash = generate_password_hash(password)
        cur = db.connection.cursor()
        cur.callproc('actualizarDatosUsuario', [user_id, nombre, hash])
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return redirect(url_for('miCuenta'))
    else:
        return "<h1>Acceso denegado</h1>"

### RUTAS RESERVACIONES HABITACIONES
@app.route('/reservas')
@login_required
def reservas():
    return render_template('reservas.html')

@app.route('/reservarHabitacion', methods=['GET', 'POST'])
@login_required
def reservarHabitacion():
    if request.method == 'POST':
        user_id = current_user.id
        fecha= request.form['fechaEntrada']
        dias = request.form['dias']
        tipo = request.form['tipo_cuarto']
        personas = request.form['cantidad_adultos']
        titular = request.form['titular']

        cur = db.connection.cursor()
        cur.callproc("verificarDisponibilidadSinOutput", [tipo, fecha, dias])
        disponibilidad = cur.fetchall()
        cur.nextset()
        if len(disponibilidad) > 0:
            cur.callproc("agregarReservacion", [user_id, tipo, fecha, dias, titular, personas])
            cur.nextset()
            cur.connection.commit()
            cur.close()
            return redirect(url_for('miCuenta'))

        else:
            cur.connection.commit()
            cur.close()
            return "No hay habitaciones disponibles en estas fechas"

@app.route('/paquetes')
@login_required
def paquetes():
    cur = db.connection.cursor()
    cur.callproc('obtenerDatosPaquetes')
    paquetes = cur.fetchall()
    numPaquetes = len(paquetes)
    cur.nextset()
    cur.connection.commit()
    cur.close()
    return render_template('paquetes.html', paquetes=paquetes, numPaquetes=numPaquetes)

@app.route('/reservarPaquete', methods=['POST', 'GET'])
@login_required
def reservarPaquete():
    if request.method == 'POST':
        user_id = current_user.id
        paquete_id = request.form['paqueteID']
        fecha_inicio = request.form['fechaReserva']
        dias = request.form['dias']
        cur = db.connection.cursor()
        cur.callproc('reservarPaquete', [user_id, paquete_id, fecha_inicio, dias])
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return redirect(url_for('miCuenta'))
    else:
        return "Error"


### RUTAS ADMIN
@app.route('/admin')
@login_required
def admin():
    if current_user.username == 'pato123':
        cur = db.connection.cursor()
        cur.callproc('obtenerDatosTipo')
        datos = cur.fetchall()
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return render_template('admin.html', datos=datos, numDatos=len(datos))
    else:
        return "<h1>Acceso denegado</h1>"

@app.route('/actualizarPrecios', methods=['POST','GET'])
@login_required
def actualizarPrecios():
    if current_user.username == 'pato123' and request.method == 'POST':
        tipo_id = request.form['id_tipo']
        nuevoPrecio = request.form['nuevoPrecio']
        cur = db.connection.cursor()
        cur.callproc('actualizarPrecioTipo', [tipo_id, nuevoPrecio])
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return redirect(url_for('admin')) 
    else:
        return "<h1>Acceso denegado</h1>"
    
@app.route('/serviciosAdmin')
@login_required
def serviciosAdmin():
    if current_user.username == 'pato123':
        cur = db.connection.cursor()
        cur.callproc('obtenerServicios')
        servicios = cur.fetchall()
        numServicios = len(servicios)
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return render_template('serviciosAdmin.html', servicios=servicios, numServicios=numServicios)
    else:
        return "<h1>Acceso denegado</h1>"
    
@app.route('/actualizarServicio', methods=['GET', 'POST'])
@login_required
def actualizarServicio():
    if current_user.username == 'pato123' and request.method == 'POST':
        cur = db.connection.cursor()
        servicio = request.form['idServicio']
        nuevoPrecio = request.form['nuevoPrecio']
        cur.callproc('actualizarServicio', [servicio, nuevoPrecio])
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return redirect(url_for('serviciosAdmin'))

@app.route('/reservasAdmin')
@login_required
def reservasAdmin():
    if current_user.username == 'pato123':
        cur = db.connection.cursor()
        cur.callproc('obtenerReservaciones')
        reservaciones = cur.fetchall()
        print(reservaciones)
        print(len(reservaciones))
        cur.nextset()
        cur.close()
        cur = db.connection.cursor()
        cur.callproc('obtenerReservasServicios')
        servicios = cur.fetchall()
        cur.nextset()
        print(servicios)
        print(len(servicios))
        cur.close()
        return render_template('reservasAdmin.html', reservaciones=reservaciones, servicios=servicios)
    else:
        return "<h1>Acceso denegado</h1>"


### RUTAS SERVICIOS
@app.route('/cenotes')
@login_required
def cenotes():
    return render_template('cenotes.html')


@app.route('/taxi')
@login_required
def taxi():
    return render_template('taxi.html')

@app.route('/bares')
@login_required
def bares():
    return render_template('bares.html')

@app.route('/comprarServicio/<string:servicio_id>', methods=['GET', 'POST'])
@login_required
def comprarServicio(servicio_id):
    if request.method == 'POST':
        servicio = int(servicio_id)
        user_id = current_user.id
        fecha_reserva = request.form['fechaReserva']
        hora = request.form['horario']
        cur = db.connection.cursor()
        cur.callproc('reservarServicio', [user_id, servicio_id, fecha_reserva, hora])
        cur.nextset()
        cur.connection.commit()
        cur.close()

        return redirect(url_for('miCuenta'))


    else:
        return "Error"

@app.route('/eliminarReservacion', methods=['GET', 'POST'])
@login_required
def eliminarReservacion():
    if request.method == 'POST':
        user_id = current_user.id
        numero = request.form['numero_habitacion']
        fecha_inicio = request.form['fecha_inicio']
        fecha_reservacion = request.form['fecha_reservacion']
        cur = db.connection.cursor()
        cur.callproc('borrarReservacion', [user_id, numero, fecha_reservacion, fecha_inicio])
        cur.nextset()
        cur.connection.commit()
        cur.close()
        return redirect(url_for('miCuenta')) 

    else:
        return "Error"

@app.route('/crearCuenta')
def crearCuenta():
    return render_template('crearCuenta.html')

@app.route('/guardarCuenta', methods=['GET', 'POST'])
def guardarCuenta():
    if request.method == 'POST':
        usuario = request.form['usuario']
        nombre = request.form['nombre']
        password = request.form['password']
        p_hash = generate_password_hash(password) 
        cur = db.connection.cursor()
        cur.callproc("crearUsuario", [usuario, nombre, p_hash])
        cur.nextset()        
        cur.connection.commit()
        cur.close()
        return redirect(url_for('login'))
    else:
        return "Error"

@app.route('/verificarDisponibilidad')
@login_required
def verificarDisponibilidad():
    cur = db.connection.cursor()
    tipo = 3
    fecha = "2023-06-10"
    dias = 10
    output = None
    cur.callproc("verificarDisponibilidadSinOutput", [tipo, fecha, dias])
    disponibilidad = cur.fetchall()
    cur.nextset()
    cur.connection.commit()
    cur.close()
    return "hola"

def status_401(error):
    return redirect(url_for('login'))


if __name__ =='__main__':
    app.config.from_object(config['development'])
    app.register_error_handler(401, status_401)
    app.run()
