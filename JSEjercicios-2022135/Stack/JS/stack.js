function stack(){
    this.data = new Array();
    this.sp =0;
    this.push= push;
    this.pop =pop;
    window.status ="Constructor";
}

function push(x){
    if(this.sp < 10)
        this.data[this.sp++] = x
    else
     alert("Limite del Stack alcanzado");
}

function pop(){
    if(this.sp > 0)
        return(this.data[-- this.sp])
    else
        alert("El Stack esta vacio")
}

var a = new stack();
    b= new stack();