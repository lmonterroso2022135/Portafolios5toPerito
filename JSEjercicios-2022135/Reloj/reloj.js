

function actualizarReloj() {
    var ahora = new Date();
    var horas = ahora.getHours();
    var minutos = ahora.getMinutes();
    var segundos = ahora.getSeconds();


    if (horas < 10) {
        horas = "0" + horas;
    }
    if (minutos < 10) {
        minutos = "0" + minutos;
    }
    if (segundos < 10) {
        segundos = "0" + segundos;
    }

    document.getElementById("reloj").innerHTML = horas + ":" + minutos + ":" + segundos;

    setTimeout(actualizarReloj, 1000);
}

window.onload = function () {
    actualizarReloj();
};


   
