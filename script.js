function submitForm() {
        // Aquí puedes agregar el código para enviar los datos capturados
        // Obtén los valores de los input y select
        var fechaLlegada = document.querySelector('.red input').value;
        var fechaSalida = document.querySelector('.blue input').value;
        var cantidadAdultos = document.querySelector('.green select').value;
        
        // Aquí puedes hacer algo con los datos, como enviarlos a través de una solicitud AJAX o procesarlos en el lado del cliente
        
        // Ejemplo de muestra en la consola del navegador
        console.log("Fecha de Llegada:", fechaLlegada);
        console.log("Fecha de Salida:", fechaSalida);
        console.log("Cantidad de Adultos:", cantidadAdultos);
    }