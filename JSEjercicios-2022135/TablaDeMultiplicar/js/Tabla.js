
function Tabla(){
    let num = numero.value;
    ventana = window.open("","","");
    ventana.document.write("<h1 aling=center> Tabla de multiplicar de "+ num + "</h1>");
    for(j=1; j<11; j++){
        ventana.document.write(j + " * " + num + "=" + j * num);
        for(i=1; i<2; i++){
            ventana.document.write("<br>");
        } 
    }

}