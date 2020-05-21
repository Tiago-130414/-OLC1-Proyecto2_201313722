const { text } = require("express")

const TIPO = {
    INT:                'Entero',
    DOUBLE:             'Decimal',
    CHAR:               'Caracter',
    BOOLEAN:            'Logico',
    STRING:             'Cadena',
    IDENTIFICADOR:      'Identificador',
    FUNCION:            'Funcion'
}

const TIPO_OPERACION = {
// OPERACIONES ARITMETICAS    
    SUMA:               'Operacion_Suma',
    RESTA:              'Operacion_Resta',
    MULTIPLICACION:     'Operacion_Multiplicacion',
    DIVISION:           'Operacion_Division',
    POTENCIA:           'Operacion_Potencia',
    MODULO:             'Operacion_Modulo',
    NEGATIVO:           'Operacion_Negativo',
    INCREMENTO:         'Operacion_Incremento',
    DECREMENTO:         'Operacion_Decremento',
// OPERACIONES RELACIONALES
    MAYOR_IGUAL_QUE:   'Operacion_MayorIgualQue',
    MENOR_IGUAL_QUE:   'Operacion_MenorIgualQue',
    IGUAL_IGUAL:       'Operacion_IgualIgual',
    DISTINTO:          'Operacion_Distinto',
    MENOR_QUE:         'Operacion_MenorQue',
    MAYOR_QUE:         'Operacion_MayorQue',
// OPERADORES RELACIONALES
    NOT:               'Operacion_Not',
    AND:               'Operacion_And',
    OR:                'Operacion_Or'
}

const TIPO_INSTRUCCION = {
    IMPRIMIR:       'Instruccion_Imprimir',
    IMPRIMIR_LN:    'Instruccion_ImprimirLN', 
    IF:             'Instruccion_If',
    ELSE_IF:        'Instruccion_ElseIf',
    ELSE:           'Instruccion_Else',
    SWITCH:         'Instruccion_Switch',
    DO_WHILE:       'Instruccion_Do',
    WHILE:          'Instruccion_While',
    FOR:            'Instruccion_For',
    DECLARACION:    'Instruccion_Declaracion',
    ASIGNACION:     'Instruccion_Asignacion',
    IMPORT:         'Instruccion_Import',
    CLASE:          'Instruccion_clase',
    DEFAULT:        'Instruccion_Default',
    CASE:           'Instruccion_Case',
    BREAK:          'Instruccion_Break', 
    CONTINUE:       'Instruccion_Continue',
    RETURN:         'Instruccion_Return',
    MAIN:           'Instruccion_Main',
    METODO:         'Instruccion_Metodo',
    METODO_FUNCION: 'Instruccion_Funcion',
    INST:           'Instruccion',    
    PARA:           'Parametros',
    RESE:           'Reservada',
    DAT:            'Tipo_Dato',
    EXP:            'Expresion',
    OP:             'Operacion',
    OPI:            'Operador_Izquierdo',
    OPD:            'Operacion_Derecho',
    INIF:           'Inicio_For',
    CONF:           'Condicion_for',
    FINF:           'Fin_For',
    TIPVAR:         'Variable',
    TIPVAL:         'Valor',
    CONTIF:         'IF',
    CONTSWITCH:     'SWITCH',
    IMP :           'Impresion_consola'
}

//creando operacion
function generarOperacion(operador_Izquierdo, operador_Derecho, tipo_Operacion) {
	return {
		//Operador_Izquierdo: operador_Izquierdo,
		//Operador_Derecho: operador_Derecho,
    //Tipo_Operacion: tipo_Operacion
    text : tipo_Operacion,
    icon:'./img/interfaz.png',
    children :[
      operador_Izquierdo,
      operador_Derecho
    ]
	}
}

function generarOperacionU(operador_Izquierdo, tipo_Operacion) {
	return {
		//Operador_Izquierdo: operador_Izquierdo,
		//Operador_Derecho: operador_Derecho,
    //Tipo_Operacion: tipo_Operacion
    text : tipo_Operacion,
    icon:'./img/interfaz.png',
    children :[
      operador_Izquierdo
    ]
	}
}

const API ={
    //operaciones rel,aritmeticas y logicas
    operacion_Binaria: function(operador_Izquierdo, operador_Derecho, tipo_Operacion) {
		return generarOperacion(operador_Izquierdo, operador_Derecho, tipo_Operacion);
    },
    
    operacion_Unaria: function(operador, tipo_Operacion) {
		return generarOperacionU(operador, tipo_Operacion);
    },

    // guarda los valores cadena,entero,booleano,identificadores,numeros y decimales
    n_Dato: function(dato, tipo_Dato) {
		return {
			//Tipo_Dato: tipo_Dato,
      //Dato: dato
      text : tipo_Dato,
      icon:'./img/interfaz.png',
      children : [
        {
          text : dato,
          icon:'./img/hoja.png'
        }
      ]
		}
    },
    
    // impresion en consola
    n_Impresion: function(tipo_Imprimir,expresion_Cad) {
		return {
			//Tipo_Operacion: tipo_Imprimir,
      //Expresion_Cad: expresion_Cad
      text : TIPO_INSTRUCCION.IMP,
      icon:'./img/interfaz.png',
      children :[
        {
          text : tipo_Imprimir,
          icon:'./img/interfaz.png',
          children : [expresion_Cad]
        }
      ]
		};
  },

  n_Declaracion: function(tipo, lista_variables) {
		return {
			//Tipo: TIPO_INSTRUCCION.DECLARACION,
      //Tipo_dato: tipo,
      //Definicion_variables: lista_variables
      text : TIPO_INSTRUCCION.DECLARACION,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.DAT,
          icon:'./img/interfaz.png',
          children : [{text : tipo ,icon:'./img/hoja.png'}]
        },
        {
          text : TIPO_INSTRUCCION.TIPVAL,
          icon:'./img/interfaz.png',
          children : lista_variables
        }
      ]
    
		}
  },

  n_Variable: function(identificador, valor_variable) {
		return {
      //Identificador: identificador,
      //Valor_variable: valor_variable
      text : TIPO_INSTRUCCION.TIPVAR,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO.IDENTIFICADOR,
          icon:'./img/interfaz.png',
          children : [{text : identificador,icon:'./img/hoja.png'}]
        },
        {
          text : TIPO_INSTRUCCION.TIPVAL,
          icon:'./img/interfaz.png',
          children : [valor_variable]
        }
      ]
		}
  },

  n_Asignacion: function(identificador, expresion) {
		return {
			//Tipo: TIPO_INSTRUCCION.ASIGNACION,
			//Identificador: identificador,
      //Valor_variable: expresion
      text : TIPO_INSTRUCCION.ASIGNACION,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO.IDENTIFICADOR,
          icon:'./img/interfaz.png',
          children : [{text : identificador,icon:'./img/hoja.png'}]
        },
        {
          text : TIPO_INSTRUCCION.TIPVAL,
          icon:'./img/interfaz.png',
          children : [expresion]
        }
      ]
		}
	},
  
  // ciclo while
  n_While: function(expresion, instrucciones) {
		return {
			//Tipo:TIPO_INSTRUCCION.WHILE,
			//Expresion: expresion,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.WHILE,
      icon:'./img/interfaz.png',
      children : [
        {
          text :TIPO_INSTRUCCION.EXP,
          icon:'./img/interfaz.png',
          children : [expresion]
        },
        {
          text :TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ] 
		};
  },
  
  n_For: function (inicio, condicion, fin, instrucciones) {
		return {
      //Tipo: TIPO_INSTRUCCION.FOR,
      //Inicio_for:     inicio,
      //Condicion_for:  condicion,
      //Incremento:     fin,
      //Instrucciones:  instrucciones
      text : TIPO_INSTRUCCION.FOR,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.INIF,
          icon:'./img/interfaz.png',
          children : [inicio] 
        },
        {
          text : TIPO_INSTRUCCION.CONF,
          icon:'./img/interfaz.png',
          children : [condicion] 
        },
        {
          text : TIPO_INSTRUCCION.FINF,
          icon:'./img/interfaz.png',
          children : [fin] 
        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones 
        }
      ]
		}
  },

  n_Funcion : function(identificador,parametro){
      return{
        //Tipo: TIPO.FUNCION,
        //Identificador: identificador,
        //Parametro: parametro
        text : TIPO.FUNCION,
        icon:'./img/interfaz.png',
        children : [
          {
            text :TIPO.IDENTIFICADOR,
            icon:'./img/interfaz.png',
            children : [{text : identificador, icon:'./img/hoja.png'}]
          },
          {
            text :TIPO_INSTRUCCION.PARA,
            icon:'./img/interfaz.png',
            children : parametro
          }
        ]
      }
  },
  
  n_Parametro : function (parametro) {
		return {
      //Definicion_Parametro: parametro
      text : TIPO_INSTRUCCION.EXP,
      children : parametro
		}
  },

  cont_If : function(if_contener){
    return{
        text :TIPO_INSTRUCCION.CONTIF,
        icon:'./img/interfaz.png',
        children : if_contener
    }
  },

  n_If: function(expresion, instrucciones) {
		return {
			//Tipo: TIPO_INSTRUCCION.IF,
			//Expresion: expresion,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.IF,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.EXP,
          icon:'./img/interfaz.png',
          children : [expresion]
        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
		}
  },
  
  n_ElseIf: function(expresion, instrucciones) {
		return {
			//Tipo: TIPO_INSTRUCCION.ELSE_IF,
			//Expresion: expresion,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.ELSE_IF,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.EXP,
          icon:'./img/interfaz.png',
          children : [expresion]
        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
		}
  },
  
  n_Else: function(instrucciones) {
		return {
			//Tipo: TIPO_INSTRUCCION.ELSE,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.ELSE,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
		}
  },
  
  n_Switch: function(expresion, instrucciones) {
		return {
			//Tipo: TIPO_INSTRUCCION.SWITCH,
			//Expresion: expresion,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.SWITCH,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.EXP,
          icon:'./img/interfaz.png',
          children : [expresion]
        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
		}
  },

  n_Case: function(expresion, instrucciones) {
		return {
			//Tipo: TIPO_INSTRUCCION.CASE,
			//Expresion: expresion,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.CASE,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.EXP,
          icon:'./img/interfaz.png',
          children : [expresion]
        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
		}
  },
  //default switch
  n_Default: function(instrucciones) {
		return {
			//Tipo: TIPO_INSTRUCCION.CASE,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.DEFAULT,
      icon:'./img/interfaz.png',
      children : [
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
		}
  },

  //ciclo do while
  n_DoWhile: function(instrucciones, expresion) {
		return {
			//Tipo: TIPO_INSTRUCCION.DO_WHILE,
      //Instrucciones: instrucciones,
      //Expresion: expresion

      text :  TIPO_INSTRUCCION.DO_WHILE,
      icon:'./img/interfaz.png',
      children : [
        {
          text :TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        },
        {
          text :TIPO_INSTRUCCION.EXP,
          icon:'./img/interfaz.png',
          children : [expresion]
        }
      ] 
    }
  },

  //continue
  n_Continue: function() {
		return {
      //Tipo: TIPO_INSTRUCCION.CONTINUE
      text : TIPO_INSTRUCCION.CONTINUE,
      icon:'./img/hoja.png'
		}
  },

  //return
  n_Return: function(expresion) {
		return {
			//Tipo: TIPO_INSTRUCCION.RETURN,
      //Expresion: expresion
      text : TIPO_INSTRUCCION.RETURN,
      icon:'./img/interfaz.png',
      children :  [expresion]
		}
  },

  //break
  n_Break: function() {
		return {
      //Tipo: TIPO_INSTRUCCION.BREAK
      text : TIPO_INSTRUCCION.BREAK,
      icon:'./img/hoja.png'
		}
  },

  // metodos que no retornan valores
  n_Metodo : function(identificador, parametro, instrucciones){
    return {
      //Tipo: TIPO_INSTRUCCION.METODO,
      //Identificador: identificador,
      //Parametro: parametro,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.METODO,
      icon:'./img/interfaz.png',
      children : [
        { text : TIPO.IDENTIFICADOR,
          icon : './img/interfaz.png',
          children :[{text : identificador,icon:'./img/hoja.png'}]
        },
        {
          text : TIPO_INSTRUCCION.PARA,
          icon:'./img/interfaz.png',
          children : parametro

        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones

        }
      ]
    }
  },

  // funciones que retornan valor
  n_Metodo_Funcion : function(tipo_funcion,identificador, parametro,instrucciones){
    return {
      //Tipo: TIPO_INSTRUCCION.METODO_FUNCION,
      //Tipo_Retorno: tipo_funcion,
      //Identificador: identificador,
      //Parametros:  parametro,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.METODO_FUNCION,
      icon:'./img/interfaz.png',
      children : [
        { text : TIPO_INSTRUCCION.DAT,
          icon:'./img/interfaz.png',
          children : [{text : tipo_funcion, icon:'./img/hoja.png'}] 
        },
        { 
          text : TIPO.IDENTIFICADOR,
          icon:'./img/interfaz.png',
          children : [{text : identificador,icon:'./img/hoja.png'}]
        }, 
        {
          text : TIPO_INSTRUCCION.PARA,
          icon:'./img/interfaz.png',
          children : parametro

        },
        {
          text : TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones

        }
      ]
    }
  },

  //metodo principal
  n_Metodo_Principal : function(instrucciones){
    return{
      //Tipo: TIPO_INSTRUCCION.MAIN,
      //Instrucciones: instrucciones
      text : TIPO_INSTRUCCION.MAIN,
      icon:'./img/interfaz.png',
      children : instrucciones
    }
  },

  //declaracion de parametros en metodos
  n_ParametroM : function(tipo_parametro, identificador){
    return{
      //Tipo: tipo_parametro,
      //Identificador: identificador
      text : tipo_parametro,
      icon : './img/interfaz.png',
      children : [
        {
          text : TIPO.IDENTIFICADOR,
          icon : './img/interfaz.png',
          children : [{text :identificador,icon : './img/hoja.png'}]
        }
      ]
      
    }
  },

  n_Clase : function(identificador, instrucciones){
    return{
      //Tipo: TIPO_INSTRUCCION.CLASE,
      //Identificador: identificador,
      //Instrucciones: instrucciones
      text: TIPO_INSTRUCCION.CLASE,
      icon:'./img/interfaz.png',
      children: [
        {text: identificador, icon:'./img/hoja.png'},
        
        {
          text: TIPO_INSTRUCCION.INST,
          icon:'./img/interfaz.png',
          children : instrucciones
        }
      ]
    }
  },

  n_Import : function(identificador){
    return{
      //Tipo: TIPO_INSTRUCCION.IMPORT,
      //Identificador: identificador
      text : TIPO_INSTRUCCION.IMPORT,
      icon:'./img/interfaz.png',
      children : [
        {
          text: TIPO.IDENTIFICADOR,
          icon:'./img/interfaz.png',
          children : identificador
        }
      ]
    }
  },

  n_Ident : function(identificador){
    return{
      //Tipo: TIPO.IDENTIFICADOR,
      //Identificador: identificador
      text : TIPO.IDENTIFICADOR ,
      text : identificador,
      icon : './img/hoja.png'
    }
  },
}



module.exports.TIPO = TIPO;
module.exports.TIPO_OPERACION = TIPO_OPERACION;
module.exports.TIPO_INSTRUCCION = TIPO_INSTRUCCION;
module.exports.API = API;