/* descripcion: ANALIZADOR DEL LENGUAJE JAVA */
// segmento de codigo, importaciones y todo dentro de 
/*%{
    //declaraciones imports
%}*/

/*  Directivas lexicas, expresiones regulares ,Analisis Lexico */
%lex
%options flex case-sensitive
%options yylineno
%locations
%%
\s+                   /* salta espacios en blanco */
"//".*               {/* comentario simple*/}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] {/*comentario multilinea*/}
/*  CADENAS  */
//yytext = yytext.substr(1,yyleng-2);
[\"][^\\\"]*([\\][\\\"ntr][^\\\"]*)*[\"]           {  return 'Cadena'; }

/*  CHAR    */
//yytext = yytext.substr(1,yyleng-2);
//yytext = yytext.substr(1,yyleng-2);
[\'][\\][\"\'nrt\\][\']       {return 'CHAR_Especial';}
[\'][^\'\\\"][\']             {return 'Char';}


/*  TIPOS DE DATOS  */

"int"       {return 'T_Int';}
"double"    {return 'T_Double';}
"boolean"   {return 'T_Boolean';}
"char"      {return 'T_Char';}
"String"    {return 'T_String';}

/*  PALABRAS RESERVADAS */

"import"    {return 'R_Import';}
"class"     {return 'R_Class';}
"void"      {return 'R_Void';}
"main"      {return 'R_Main';}
"if"        {return 'R_If';}
"else"      {return 'R_Else';}
"switch"    {return 'R_Switch';}
"for"       {return 'R_For';}
"while"     {return 'R_While';}
"do"        {return 'R_Do';}
"break"     {return 'R_Break';}
"continue"  {return 'R_Continue';}
"return"    {return 'R_Return';}
"public"    {return 'R_Public';}
"protected" {return 'R_Protected';}
"private"   {return 'R_Private';}
"System"    {return 'R_System';}
"out"       {return 'R_Out';}
"println"   {return 'R_Println';}
"print"     {return 'R_Print';}
"true"      {return 'R_True';}
"false"     {return 'R_False';}
"case"      {return 'R_Case';}
"default"   {return 'def';}
/*  SIMBOLO */

":"			{return 'S_DosPuntos';}
";"			{return 'S_PuntoComa';}
"{"			{return 'S_LlaveAbre';}
"}"			{return 'S_LlaveCierra';}
"("			{return 'S_ParentesisAbre';}
")"			{return 'S_ParentesisCierra';}
"="         {return 'S_Igual';}
"."         {return 'S_Punto';}
"\'"        {return 'S_ComillaSimple';}
","         {return 'S_Coma';}
"\""        {return 'S_ComillaDoble';}

/*  EXPRESION */

"+"         {return 'OP_Mas';}
"-"         {return 'OP_Menos';}
"*"         {return 'OP_Multiplicacion';}
"/"         {return 'OP_Division';}
"^"         {return 'OP_Potencia';}
"%"         {return 'OP_Modulo';}
"--"        {return 'OP_Decremento';}
"++"        {return 'OP_Incremento';}

/* OPERADORES RELACIONALES*/

"<="	    {return 'REL_MenorIgualQue';}
">="		{return 'REL_MayorIgualQue';}
"=="		{return 'REL_IgualIgual';}
"!="		{return 'REL_Distinto';}
"<"			{return 'REL_MenorQue';}
">"			{return 'REL_MayorQue';}

/*OPERADORES LOGICOS*/

"!"			{return 'LOG_Not';}
"&&"		{return 'LOG_Concatenar';}
"||"		{return 'LOG_OR';}



/*  NUMEROS */

[0-9]+("."[0-9]+)?\b    {return 'Decimal';}
[0-9]+\b                {return 'Entero';}

/*  IDENTIFICADORES */

([a-zA-Z_])[a-zA-Z0-9_]* {return 'Identificador';}


/*  FIN DEL ARCHIVO */

<<EOF>>               {return 'EOF';}

/*  ERRORES LEXICOS */
.                   {console.error("error lexico: " + yytext)}

/lex

//PRECEDENCIA DE OPERADORES
/* operator associations and precedence */
%left 'OP_Mas' 'OP_Menos'
%left 'OP_Multiplicacion' 'OP_Division' 'OP_Modulo'
%left 'OP_Potencia'
%left UMINUS
//GRAMATICA
%start INICIO

%%
INICIO
    : CONTENIDO EOF
        {console.log("ANALISIS FINALIZADO");}
;
/*----------------------------------------------------------------------LISTADO GENERAL----------------------------------------------------------------------*/

CONTENIDO
    : CONTENIDO IMPORT {console.log($2);}
    | IMPORT {console.log($1 + "\n"); }
    | CONTENIDO MODIFICADORES_ACCESO CLASES {console.log( $2+' '+$3 + "\n");}
    | MODIFICADORES_ACCESO CLASES {console.log($1+' ' + $2 + "\n");}
;
/*----------------------------------------------------------------------IMPORTS----------------------------------------------------------------------*/
IMPORT
    : R_Import LISTADO_IMPORT S_PuntoComa {$$ = $1 +' '+ $2+ $3;}
;

LISTADO_IMPORT
    : LISTADO_IMPORT S_Punto Identificador {$$ = $1 + $2+ $3;}
    | Identificador {$$ = $1;}
;

/*----------------------------------------------------------------------CLASES----------------------------------------------------------------------*/
CLASES 
    : R_Class Identificador S_LlaveAbre  LISTA_CLASES S_LlaveCierra {$$ = $1+ $2 + $3+"\n" +$4 +"\n"+$5 ;}
;

LISTA_CLASES
    : LISTA_CLASES CONTENIDO_CLASE {$$ = $1 + $2;}
    | CONTENIDO_CLASE {$$ = $1;}    
;

CONTENIDO_CLASE
    : TIPO_DATO Identificador S_ParentesisAbre PARAMETROS S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra {$$ = $1 +' '+ $2 + $3 +$4 +$5 +$6+"\n" + $7+"\n"+$8;}
    | VARIABLE {console.log($1+ "\n");}
    | R_Void METODO_VOID {$$ = $1 + $2;}
    | LLAMAR_METODOF_CLASE {console.log($1)}
    
;

METODO_VOID
    : R_Main S_ParentesisAbre S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra {$$ = $1 + $2 + $3 +$4 +"\n"+ $5 +"\n"+ $6;}
    | Identificador S_ParentesisAbre PARAMETROS S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra {$$ = $1 + $2 + $3 +$4 + $5 +"\n" + $6+"\n" + $7;}
;

/*----------------------------------------------------------------------VARIABLE----------------------------------------------------------------------*/

VARIABLE
    : TIPO_DATO LISTADO_ID_VARIABLE S_PuntoComa {$$ = $1 + ' ' + $2+ $3;}
;

LISTADO_ID_VARIABLE
    : LISTADO_ID_VARIABLE S_Coma CONTENIDO_VARIABLE {$$ = $1 + $2+ $3;}
    | CONTENIDO_VARIABLE {$$ = $1;}
;

CONTENIDO_VARIABLE
    //aqui tengo que agregar la asignacion de variables
    :Identificador S_Igual EXPRESION  {$$ = $1 + $2 + $3;}
    |Identificador {$$ = $1;}
;
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------TIPOS_DATO----------------------------------------------------------------------*/
TIPO_DATO
    : T_Int {$$ = $1;}
    | T_String {$$ = $1;}
    | T_Boolean {$$ = $1;}
    | T_Char {$$ = $1;}
    | T_Double  {$$ = $1;}
;

MODIFICADORES_ACCESO 
    : R_Protected {$$ = $1;}
    | R_Public {$$ = $1;}
    | R_Private {$$ = $1;}
    | {$$='';}
;
/*----------------------------------------------------------------------EXPRESIONES----------------------------------------------------------------------*/

EXPRESION 
    : VALOR1 EXPRESION2        { $$ = $1 + $2; }
;

EXPRESION2
    : OPERADOR EXPRESION   {$$ = $1 + $2; }
    | OPERADOR
    |   { $$ = ''; }
;

OPERADOR 
    : OP_Mas 
    | OP_Menos
    | OP_Multiplicacion 
    | OP_Division 
    | OP_Potencia 
    | OP_Modulo 
    | S_Igual S_Igual    { $$ = $1 + $2; }                                               
    | REL_Distinto                                                          
    | REL_MayorIgualQue                                                    
    | REL_MenorIgualQue                                                   
    | REL_MayorQue 
    | REL_MenorQue 
    | LOG_Concatenar                                                     
    | LOG_OR
    | OP_Menos OP_Menos
    | OP_Mas OP_Mas                                                             
;

VALOR1 
    : Cadena
    | Char    
    | CHAR_Especial                                                            
    | VALOR2
    | OP_Menos VALOR2  { $$ = $1 + $2; }
    | LOG_Not VALOR2   { $$ = $1 + $2; }
;

VALOR2 
    : Entero
    | Decimal
    | Identificador
    | Identificador S_ParentesisAbre S_ParentesisCierra                                         { $$ = $1 + $2 + $3; }
    | Identificador S_ParentesisAbre OPCIONAL S_ParentesisCierra                                  { $$ = $1 + $2 + $3 + $4; }
    | R_True
    | R_False
    | S_ParentesisAbre EXPRESION S_ParentesisCierra  { $$ = $1 + $2 + $3; }
;

OPCIONAL 
    : EXPRESION
    | OPCIONAL S_Coma EXPRESION                                                 { $$ = $1 + $2 + $3; }    
    ;

/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
FUNC
    :EXPRESION
    | {$$='';}
;
/*----------------------------------------------------------------------PARAMETROS METODOS----------------------------------------------------------------------*/
PARAMETROS
    : TIPO_DATO Identificador LISTA_PARAMETROS {$$ = $1 +" "+ $2 +$3;}
    | TIPO_DATO Identificador {$$ = $1 +" "+ $2;}
    | {$$='';}
;

LISTA_PARAMETROS
    : LISTA_PARAMETROS S_Coma TIPO_DATO Identificador {$$ = $1 + $2 +" " +$3 + $4;}
    | S_Coma TIPO_DATO Identificador {$$ = $1 +" "+ $2 +$3;}
;
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------LLAMADAS FUNCION DENTRO METODOS----------------------------------------------------------------------*/
METODOS_LL
    : Identificador REDUCCION {$$ = $1 + $2 + "\n";}
;

REDUCCION
    :  S_Igual EXPRESION S_PuntoComa {$$ = $1 +' '+ $2+' '+ $3+"\n";}
    | S_ParentesisAbre PARAMETROS_FUNC S_ParentesisCierra S_PuntoComa
;

PARAMETROS_FUNC
    : PARAMETROS_FUNC S_Coma EXPRESION {$$ = $1 + $2 + $3;}
    | EXPRESION
    | {$$='';}
;
/*--------------------------------------------------------------------LLAMADAS FUNCION FUERA METODOS----------------------------------------------------------------------*/
LLAMAR_METODOF_CLASE
    : Identificador S_ParentesisAbre PARAMETROS_FUNC S_ParentesisCierra S_PuntoComa {$$ = $1 + $2 + $3 + $4 + $5;}
;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------------------------------INSTRUCCIONES CONTENIDO METODOS----------------------------------------------------------------------*/
INSTRUCCIONES
    : LISTA_INS
    | {$$='';}
;

LISTA_INS
    : LISTA_INS LISTA_INSTRUCCIONES {$$ = $1 + $2;}
    | LISTA_INSTRUCCIONES
;

LISTA_INSTRUCCIONES
    : METODOS_LL
    | VARIABLE 
    | IMPRIMIR 
    | SENT_IF
    | LOOP_WHILE
    | LOOP_DO_WHILE
    | LOOP_FOR
    | SENT_SWITCH
    | S_TRANSFERENCIA
;
/*---------------------------------------------PRINT---------------------------------------------------------*/
IMPRIMIR 
    : R_System S_Punto R_Out S_Punto TIPO_IMPRESION S_ParentesisAbre EXPRESION S_ParentesisCierra S_PuntoComa {$$ = $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9;}
;

TIPO_IMPRESION
    : R_Print {$$ =$1;}
    | R_Println {$$ =$1;}
;

S_TRANSFERENCIA
    : R_Break S_PuntoComa { $$ = $1 + $2; }
    | R_Continue S_PuntoComa { $$ = $1 + $2; }
    | R_Return FUNC S_PuntoComa { $$ = $1 + $2 + $3; }
;

/*---------------------------------------------IF---------------------------------------------------------*/
SENT_IF
    : R_If CONT_IF ELSE  { $$ = $1+ $2 +$3; }
;

CONT_IF
    : S_ParentesisAbre EXPRESION S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra   {$$ = $1+ $2 +$3 + $4 + $5 + $6;}
;

ELSE
    : R_Else AB { $$ = $1 + $2; }
    | { $$ = ''; }
;

AB
    : S_LlaveAbre INSTRUCCIONES S_LlaveCierra { $$ = $1 + $2 + $3; }
    | SENT_IF 
;
/*---------------------------------------------SWITCH---------------------------------------------------------*/

SENT_SWITCH
    : R_Switch S_ParentesisAbre EXPRESION S_ParentesisCierra S_LlaveAbre LISTA_CASE S_LlaveCierra { $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7; }
;

LISTA_CASE
    : LS_CASE
    | { $$= ''; }
;


LS_CASE
    : LS_CASE DEF_CASE { $$ = $1 + $2; }
    | DEF_CASE
;

DEF_CASE
    : RED_SWITCH S_DosPuntos INSTRUCCIONES { $$ = $1 + $2 + $3; }
;

RED_SWITCH
    : R_Case EXPRESION { $$ = $1 + $2; }
    | def
;

/*---------------------------------------------WHILE---------------------------------------------------------*/
  LOOP_WHILE
    : R_While CONT_IF { $$ = $1 + $2; }
;
/*--------------------------------------------- DO WHILE---------------------------------------------------------*/
  LOOP_DO_WHILE
    : R_Do S_LlaveAbre INSTRUCCIONES S_LlaveCierra R_While S_ParentesisAbre EXPRESION S_ParentesisCierra S_PuntoComa { $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9; }
;

/*--------------------------------------------- FOR ---------------------------------------------------------*/

LOOP_FOR
    : R_For S_ParentesisAbre CONT_FOR EXPRESION S_PuntoComa FIN_FOR S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra { $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10; }
;

CONT_FOR
    : VARIABLE
    | METODOS_LL
;

FIN_FOR
    : Identificador S_Igual EXPRESION                                                  { $$ = $1 + $2 + $3; }
    | Identificador INCREMENTO                                                         { $$ = $1 + $2; }
    ;


INCREMENTO 
    : OP_Menos OP_Menos                                                 { $$ = $1 + $2; }
    | OP_Mas OP_Mas                                                     { $$ = $1 + $2; }
    ;
