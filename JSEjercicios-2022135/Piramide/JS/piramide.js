var m = [];
var n,j,a;
function operacion(){
    a = edit1.value * 1;
    for(n=1;n<=a;n++){
        for(j=1;j<=a;j++){
            m[n*100+j] = 0;
        }
    }


for(n=1; n<=a; n++){
    m[(n*100)+1]=1;
}
for(n =1;n<=a;n++){
    for(j=1;j<=a;j++){
        m[(n*100)+j+101] = m[(n*100)+j]+m[(n*100)+j+1]
    }
}
for(n=1;n<=a;n++){
    document.write("<center>");
        for(j=a;j>=1;j--){
            if(m[(n*100)+j]==0){
                document.write("&nbsp;");
            }else{
                
                document.write("|  "+[m[(n*100)+j]]+"  |")
                document.write('')
            }
            
        }
        document.write("</center>")
}
}