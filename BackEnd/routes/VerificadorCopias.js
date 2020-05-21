const { main } = require("./ReporteAst");
const { param } = require(".");

exports.reporteClaseCopia = function (Arbolito1, Arbolito2) {
  var reporte = "/*****************   REPORTE CLASES COPIA  *****************\\" + "\n";
  var sonCopia = true;
  var nombClase = "";
  var cont_main = 0;
  var cont_metodo = 0;
  var cont_funcion = 0;
  Arbolito1.forEach((element) => {
    if (element.Tipo == "Clase") {
      var claseCopia = buscarClaseAr2(Arbolito2, element.Nombre);
      nombClase = element.Nombre;
      if (claseCopia != null) {
        element.Contenido.forEach((contenidoAO) => {
          if (contenidoAO.Tipo == "Main") {
            var mainCopia = buscarMain(claseCopia.Contenido);
            //agregar variables
            if (mainCopia != null) {
              cont_main++;
            } else {
              sonCopia = false;
            }
          } else if (contenidoAO.Tipo == "Metodo") {
            var metodoCopia = buscarMetodo(
              claseCopia.Contenido,
              contenidoAO.Nombre,
              contenidoAO.Parametros
            );
            if (metodoCopia != null) {
              cont_metodo++;
            } else {
              sonCopia = false;
            }
          } else if (contenidoAO.Tipo == "Funcion") {
            var funcionCopia = buscarFuncion(
              claseCopia.Contenido,
              contenidoAO.Tipo_Retorno,
              contenidoAO.Nombre,
              contenidoAO.Parametros
            );
            if (funcionCopia != null) {
              cont_funcion++;
            } else {
              sonCopia = false;
            }
          }
        });
      } else {
        reporte += "xxxxxxxxxx  Archivos no coinciden xxxxxxxxxx\n";
        sonCopia = false;
      }
    }

    if (sonCopia == true) {
      reporte += "Archivos copia\nNombre Clase: " + nombClase + "\nN_Metodos: " + cont_metodo + "\nN_Funciones: " +cont_funcion+ "\nN_Main: " + cont_main + "\n\n";
    }
    cont_metodo = 0;
    cont_funcion = 0;
    cont_main = 0;
  });
  return reporte;
}

function buscarClaseAr2(Arbolito2, nombreCO) {
  var encontrado = null;
  Arbolito2.forEach((element) => {
    if (element.Tipo == "Clase") {
      if (element.Nombre == nombreCO) {
        encontrado = element;
      }
    }
  });
  return encontrado;
}

function buscarMain(Arbolito1) {
  var existeMain = null;
  Arbolito1.forEach((element) => {
    if (element.Tipo == "Main") {
      existeMain = element;
    }
  });
  return existeMain;
}

function buscarMetodo(Arbolito1, nombM, par) {
  var existeMetodo = null;
  Arbolito1.forEach((element) => {
    if (element.Tipo == "Metodo") {
      if (element.Nombre == nombM) {
        if (compararParametro(par, element.Parametros)) {
          existeMetodo = element;
        }
      }
    }
  });
  return existeMetodo;
}

function buscarFuncion(contenidoC, tipoR, nomF, par) {
  var funC = null;
  contenidoC.forEach((element) => {
    if (element.Tipo == "Funcion") {
      if (element.Tipo_Retorno == tipoR) {
        if (element.Nombre == nomF) {
          if (compararParametro(par, element.Parametros)) {
            funC = element;
          }
        }
      }
    }
  });
  return funC;
}

function compararParametro(parametrosO, parametrosC) {
  var iguales = true;
  if (parametrosO.lenght == parametrosC.lenght) {
    for (var i = 0; i < parametrosO.lenght; i++) {
      if (parametrosO[i].Tipo != parametrosC[i].Tipo) {
        iguales = false;
      }
      if (parametrosO[i].Nombre != parametrosC[i].Nombre) {
        iguales = false;
      }
    }
  }
  return iguales;
}


exports.reporteFuncionesCopia = function(Arbolito1, Arbolito2){
  var reporte = "/*****************   REPORTE FUNCIONES COPIA  *****************\\" + "\n";
  var nombClase = "";
  var nombFuncion = "";
  var nombMetodo = "";
  var parametrosReporte = "";
  var retorno = "";
  Arbolito1.forEach((element) => {
    if (element.Tipo == "Clase") {
      var claseCopia = buscarClaseAr2(Arbolito2, element.Nombre);
      nombClase = element.Nombre;
      if (claseCopia != null) {
        element.Contenido.forEach((contenidoAO) => {
          if (contenidoAO.Tipo == "Metodo") {
            var metodoCopia = buscarMetodo(
              claseCopia.Contenido,
              contenidoAO.Nombre,
              contenidoAO.Parametros
            );
            if (metodoCopia != null) {
              nombMetodo = contenidoAO.Nombre,
              parametrosReporte = contenidoAO.Parametros;
              reporte += "Nombre Clase: " + nombClase + "\nNombre Metodo: " + nombMetodo + "\nTipo Retorno: void" + "\nParametros: " + leerParametros(parametrosReporte) + "\n\n";
            }
          }else if (contenidoAO.Tipo == "Funcion") {
            var funcionCopia = buscarFuncion(
              claseCopia.Contenido,
              contenidoAO.Tipo_Retorno,
              contenidoAO.Nombre,
              contenidoAO.Parametros
            );
            if (funcionCopia != null) {
              retorno = contenidoAO.Tipo_Retorno;
              nombFuncion = contenidoAO.Nombre,
              parametrosReporte = contenidoAO.Parametros;
              reporte += "Nombre Clase: " + nombClase + "\nNombre Metodo: " + nombFuncion + "\nTipo Retorno: " + retorno + "\nParametros: " + leerParametros(parametrosReporte) + "\n";
            }
            
          }
        });
      } else {
        reporte += "xxxxxxxxxx  Funciones no coinciden xxxxxxxxxx";
      }
    }
  });
  return reporte;
} 

function leerParametros(par){
  var parametrosS = "";
  par.forEach(element =>{
    parametrosS += element.Tipo +" " + element.Nombre +" ";
  });
  return parametrosS;
}