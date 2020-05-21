class Ast{
    constructor(){

    }

    recorrerArbol(nodo) {
        var cadena;
        
        cadena="<ul><li data-jstree='{ \"opened\" : true }'>"+ nodo.Identificador +"\n";

        nodo.Instrucciones.forEach(element => {
            //lamada recursiva
            //cadena+=this.recorrerArbol(element);
            //console.log(element);
            cadena+="<ul><li data-jstree='{ \"opened\" : true }'>"+ element.Identificador +"\n";
            cadena+="</li></ul>" + "\n";
        });
        //console.log("puerca2");
        //console.log(nodo.Instrucciones[0]);
        //console.log(nodo.Instrucciones[1]);
        
        
        //cadena+=nodo.Instrucciones[ +"\n";
        
        //nodo.Instrucciones.forEach(element => {
            //lamada recursiva
            //cadena+=this.recorrerArbol(element);

            
        //});

        cadena+="</li></ul>" + "\n";
        return cadena;
    }
}

module.exports = Ast;