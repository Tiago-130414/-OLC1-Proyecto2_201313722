const TIPO = {
    INT:                'Entero',
    DOUBLE:             'Decimal',
    CHAR:               'Caracter',
    BOOLEAN:            'Logico',
    STRING:             'Cadena',
    IDENTIFICADOR:      'Ident',
    FUNCION:            'Funcion'
}

const TIPO_OPERACION = {
// OPERACIONES ARITMETICAS    
    SUMA:               'Op_Suma',
    RESTA:              'Op_Resta',
    MULTIPLICACION:     'Op_Multiplicacion',
    DIVISION:           'Op_Division',
    POTENCIA:           'Op_Potencia',
    MODULO:             'Op_Modulo',
    NEGATIVO:           'Op_Negativo',
    INCREMENTO:         'Op_Incremento',
    DECREMENTO:         'Op_Decremento',
// OPERACIONES RELACIONALES
    MAYOR_IGUAL_QUE:   'Op_MayorIgualQue',
    MENOR_IGUAL_QUE:   'Op_MenorIgualQue',
    IGUAL_IGUAL:       'Op_IgualIgual',
    DISTINTO:          'Op_Distinto',
    MENOR_QUE:         'Op_MenorQue',
    MAYOR_QUE:         'Op_MayorQue',
// OPERADORES RELACIONALES
    NOT:               'Op_Not',
    AND:               'Op_And',
    OR:                'Op_Or'
}

const TIPO_INSTRUCCION = {
    IMPRIMIR:       'Ins_Imprimir',
    IMPRIMIR_LN:    'Ins_ImprimirLN', 
    IF:             'Ins_If',
    ELSE_IF:        'Ins_ElseIf',
    ELSE:           'Ins_Else',
    SWITCH:         'Ins_Switch',
    DO_WHILE:       'Ins_Do',
    WHILE:          'Ins_While',
    FOR:            'Ins_For',
    DECLARACION:    'Ins_Declaracion',
    ASIGNACION:     'Ins_Asignacion',
    IMPORT:         'Ins_Import',
    CLASE:          'Ins_clase',
    DEFAULT:        'Ins_Default',
    CASE:           'Ins_Case',
    BREAK:          'Ins_Break', 
    CONTINUE:       'Ins_Continue',
    RETURN:         'Ins_Return'
}

//creando operacion
function generarOperacion(operador_Izquierdo, operador_Derecho, tipo_Operacion) {
	return {
		Operador_Izquierdo: operador_Izquierdo,
		Operador_Derecho: operador_Derecho,
		Tipo_Operacion: tipo_Operacion
	}
}

const API ={
    //operaciones rel,aritmeticas y logicas
    operacion_Binaria: function(operador_Izquierdo, operador_Derecho, tipo_Operacion) {
		return generarOperacion(operador_Izquierdo, operador_Derecho, tipo_Operacion);
    },
    
    operacion_Unaria: function(operador, tipo_Operacion) {
		return generarOperacion(operador, undefined, tipo_Operacion);
    },

    // guarda los valores cadena,entero,booleano,identificadores,numeros y decimales
    n_Dato: function(dato, tipo_Dato) {
		return {
			Tipo_Dato: tipo_Dato,
			Dato: dato
		}
    },
    
    // impresion en consola
    n_Impresion: function(tipo_Imprimir,expresion_Cad) {
		return {
			Tipo_Operacion: tipo_Imprimir,
			Expresion_Cad: expresion_Cad
		};
  },

  n_Declaracion: function(tipo, lista_variables) {
		return {
			Tipo: TIPO_INSTRUCCION.DECLARACION,
      Tipo_dato: tipo,
      Definicion_variables: lista_variables
		}
  },

  n_Variable: function(identificador, valor_variable) {
		return {
      Identificador: identificador,
			Valor_variable: valor_variable
		}
  },

  n_Asignacion: function(identificador, expresion) {
		return {
			Tipo: TIPO_INSTRUCCION.ASIGNACION,
			Identificador: identificador,
			Valor_variable: expresion
		}
	},
  
  // ciclo while
  n_While: function(expresion, instrucciones) {
		return {
			Tipo: TIPO_INSTRUCCION.WHILE,
			Expresion: expresion,
			Instrucciones: instrucciones
		};
  },
  
  n_For: function (inicio, condicion, fin, instrucciones) {
		return {
      Tipo: TIPO_INSTRUCCION.FOR,
      Inicio_for:     inicio,
      Condicion_for:  condicion,
      Incremento:     fin,
      Instrucciones:  instrucciones
		}
  },

  n_Funcion : function(identificador,parametro){
      return{
        Tipo: TIPO.FUNCION,
        Identificador: identificador,
        Parametro: parametro
      }
  },
  
  n_Parametro : function (parametro) {
		return {
      Parametro: parametro
		}
  },

}


module.exports.TIPO = TIPO;
module.exports.TIPO_OPERACION = TIPO_OPERACION;
module.exports.TIPO_INSTRUCCION = TIPO_INSTRUCCION;
module.exports.API = API;