/* descripcion: ANALIZADOR DEL LENGUAJE JAVA */
// segmento de codigo, importaciones y todo dentro de 
%{
    const TIPO = require('./API_MAESTRA').TIPO;
    const TIPO_OPERACION = require('./API_MAESTRA').TIPO_OPERACION;
    const API = require('./API_MAESTRA').API;
%}
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
[\"][^\\\"]*([\\][\\\"ntr][^\\\"]*)*[\"]           {yytext = yytext.substr(1,yyleng-2); return 'Cadena'; }

/*  CHAR    */
//yytext = yytext.substr(1,yyleng-2);
//yytext = yytext.substr(1,yyleng-2);
[\'][\\][\"\'nrt\\][\']       {yytext = yytext.substr(1,yyleng-2); return 'CHAR_Especial';}
[\'][^\'\\\"][\']             {yytext = yytext.substr(1,yyleng-2); return 'Char';}


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
"."         {return 'S_Punto';}
"\'"        {return 'S_ComillaSimple';}
","         {return 'S_Coma';}
"\""        {return 'S_ComillaDoble';}

/*  EXPRESION */

"++"        {return 'OP_Incremento';}
"--"        {return 'OP_Decremento';}
"+"         {return 'OP_Mas';}
"-"         {return 'OP_Menos';}
"*"         {return 'OP_Multiplicacion';}
"/"         {return 'OP_Division';}
"^"         {return 'OP_Potencia';}
"%"         {return 'OP_Modulo';}


/* OPERADORES RELACIONALES*/

"<="	    {return 'REL_MenorIgualQue';}
">="		{return 'REL_MayorIgualQue';}
"=="		{return 'REL_IgualIgual';}
"="         {return 'S_Igual';}
"!="		{return 'REL_Distinto';}
"<"			{return 'REL_MenorQue';}
">"			{return 'REL_MayorQue';}

/*OPERADORES LOGICOS*/

"!"			{return 'LOG_Not';}
"&&"		{return 'LOG_Concatenar';}
"||"		{return 'LOG_OR';}



/*  NUMEROS */

[0-9]+("."[0-9]+)\b    {return 'Decimal';}
[0-9]+\b                {return 'Entero';}

/*  IDENTIFICADORES */

([a-zA-Z_])[a-zA-Z0-9_]* {return 'Identificador';}


/*  FIN DEL ARCHIVO */

<<EOF>>               {return 'EOF';}

/*  ERRORES LEXICOS */
.                   {console.error("error lexico: " + yytext)}

/lex

//PRECEDENCIA DE OPERADORES
//prescedencia operadores logicos
%left 'LOG_Concatenar' 'LOG_OR'
//prescedencia operadores relcionales
%left 'REL_IgualIgual' 'REL_Distinto' 'REL_MayorIgualQue' 'REL_MayorQue' 'REL_MenorIgualQue' 'REL_MenorQue'
//prescedencia operadores aritmeticos
%left 'OP_Mas' 'OP_Menos'
%left 'OP_Multiplicacion' 'OP_Division' 
%left 'OP_Potencia' 'OP_Modulo'
%left UMINUS PRUEBA
//GRAMATICA
%start INICIO

%%
INICIO
    : CONTENIDO EOF
        {console.log($1); return $1;}
;
/*----------------------------------------------------------------------LISTADO GENERAL----------------------------------------------------------------------*/

CONTENIDO
    : CONTENIDO IMPORT {$$ = $1 + $2;}
    | IMPORT 
    | CONTENIDO MODIFICADORES_ACCESO CLASES {$$ = $1 + $2 + $3;}
    | MODIFICADORES_ACCESO CLASES {$$ = $1 + $2 ;}
;
/*----------------------------------------------------------------------IMPORTS----------------------------------------------------------------------*/
IMPORT
    : R_Import LISTADO_IMPORT S_PuntoComa {$$ = $1 + $2+ $3;}
;

LISTADO_IMPORT
    : LISTADO_IMPORT S_Punto Identificador {$$ = $1 + $2+ $3;}
    | Identificador 
;

/*----------------------------------------------------------------------CLASES----------------------------------------------------------------------*/
CLASES 
    : R_Class Identificador S_LlaveAbre  LISTA_CLASES S_LlaveCierra {$$ = $1+ $2 + $3 + $4 + $5;}
;

LISTA_CLASES
    : LISTA_CLASES CONTENIDO_CLASE {$1.push($2); $$ = $1;}
    | CONTENIDO_CLASE              {$$ = [$1];}
;

CONTENIDO_CLASE
    : TIPO_DATO Identificador S_ParentesisAbre PARAMETROS S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra {$$ = $1 + $2 + $3 +$4 + $5 + $6 + $7 + $8;}
    | VARIABLE 
    | R_Void METODO_VOID {$$ = $1 + $2;}
    | LLAMAR_METODOF_CLASE 
    
;

METODO_VOID
    : R_Main S_ParentesisAbre S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra {$$ = $1 + $2 + $3 +$4 + $5 + $6;}
    | Identificador S_ParentesisAbre PARAMETROS S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra {$$ = $1 + $2 + $3 +$4 + $5 + $6 + $7;}
;

/*----------------------------------------------------------------------VARIABLE----------------------------------------------------------------------*/

VARIABLE
    : TIPO_DATO LISTADO_ID_VARIABLE S_PuntoComa                      {$$ = API.n_Declaracion($1 , $2);}
;

LISTADO_ID_VARIABLE
    : LISTADO_ID_VARIABLE S_Coma CONTENIDO_VARIABLE                 {$1.push($3); $$ = $1}
    | CONTENIDO_VARIABLE                                            {$$ = [$1]}
;

CONTENIDO_VARIABLE
    //aqui tengo que agregar la asignacion de variables
    :Identificador S_Igual EXPRESION_G                              {$$ = API.n_Variable($1,$3)}
    |Identificador                                                  {$$ = API.n_Variable($1,'undefined')}
;
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------TIPOS_DATO----------------------------------------------------------------------*/
TIPO_DATO
    : T_Int             {$$ = TIPO.INT; }
    | T_String          {$$ = TIPO.STRING; }
    | T_Boolean         {$$ = TIPO.BOOLEAN; }
    | T_Char            {$$ = TIPO.CHAR; }
    | T_Double          {$$ = TIPO.DOUBLE; }
;

MODIFICADORES_ACCESO 
    : R_Protected {$$ = $1;}
    | R_Public {$$ = $1;}
    | R_Private {$$ = $1;}
    | {$$='';}
;
/*----------------------------------------------------------------------EXPRESIONES----------------------------------------------------------------------*/

EXPRESION_G 
    : EXPRESION_G LOG_Concatenar EXPRESION_G                                                     { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.AND); }//$1 + $2 + $3
    | EXPRESION_G LOG_OR EXPRESION_G                                                             { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.OR); }
    | EXPRESION_G REL_IgualIgual EXPRESION_G                                                     { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.IGUAL_IGUAL); }
    | EXPRESION_G REL_MayorIgualQue EXPRESION_G                                                  { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.MAYOR_IGUAL_QUE); }
    | EXPRESION_G REL_MayorQue EXPRESION_G                                                       { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.MAYOR_QUE); }
    | EXPRESION_G REL_MenorIgualQue EXPRESION_G                                                  { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.MENOR_IGUAL_QUE); }
    | EXPRESION_G REL_MenorQue EXPRESION_G                                                       { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.MENOR_QUE); }
    | EXPRESION_G REL_Distinto EXPRESION_G                                                       { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.DISTINTO); }
    | EXPRESION_G OP_Mas EXPRESION_G                                                             { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.SUMA); }
    | EXPRESION_G OP_Menos EXPRESION_G                                                           { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.RESTA); }
    | EXPRESION_G OP_Multiplicacion EXPRESION_G                                                  { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.MULTIPLICACION); }
    | EXPRESION_G OP_Division EXPRESION_G                                                        { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.DIVISION); }
    | EXPRESION_G OP_Potencia EXPRESION_G                                                        { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.POTENCIA); }
    | EXPRESION_G OP_Modulo EXPRESION_G                                                          { $$ = API.operacion_Binaria($1,$3,TIPO_OPERACION.MODULO); }
    | CONTENIDO_EXPRESION OP_Decremento %prec PRUEBA                                             { $$ = API.operacion_Unaria($1,TIPO_OPERACION.MODULO); }
    | CONTENIDO_EXPRESION OP_Incremento %prec PRUEBA                                             { $$ = API.operacion_Unaria($1,TIPO_OPERACION.DECREMENTO); }
    | OP_Menos  CONTENIDO_EXPRESION     %prec UMINUS                                             { $$ = API.operacion_Unaria($2,TIPO_OPERACION.NEGATIVO); }
    | LOG_Not   CONTENIDO_EXPRESION     %prec UMINUS                                             { $$ = API.operacion_Unaria($2,TIPO_OPERACION.NOT); }
    | CONTENIDO_EXPRESION                                                                        { $$ = $1; }  
;

 CONTENIDO_EXPRESION
    : Entero                                                                                     {$$ = API.n_Dato($1,TIPO.INT); }
    | Decimal                                                                                    {$$ = API.n_Dato($1,TIPO.DOUBLE); }
    | Identificador S_ParentesisAbre S_ParentesisCierra                                          {$$ = API.n_Funcion($1,'undefined');}
    | Identificador S_ParentesisAbre OPCIONAL S_ParentesisCierra                                 {$$ = API.n_Funcion($1,API.n_Parametro($3));}
    | R_True                                                                                     {$$ = API.n_Dato($1,TIPO.BOOLEAN); }
    | R_False                                                                                    {$$ = API.n_Dato($1,TIPO.BOOLEAN); }
    | S_ParentesisAbre EXPRESION_G S_ParentesisCierra                                            {$$ = $2;}
    | Identificador                                                                              {$$ = API.n_Dato($1,TIPO.IDENTIFICADOR); }
    | Cadena                                                                                     {$$ = API.n_Dato($1,TIPO.STRING); }
    | Char                                                                                       {$$ = API.n_Dato($1,TIPO.CHAR); }
    | CHAR_Especial                                                                              {$$ = API.n_Dato($1,TIPO.CHAR); }
;

OPCIONAL 
    : EXPRESION_G                                                                                {$$ = [$1];}
    | OPCIONAL S_Coma EXPRESION_G                                                                {$1.push($2); $$ = $1;}  
;

/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
FUNC
    :EXPRESION_G
    | {$$='';}
;
/*----------------------------------------------------------------------PARAMETROS METODOS----------------------------------------------------------------------*/
PARAMETROS
    : TIPO_DATO Identificador LISTA_PARAMETROS {$$ = $1 + $2 +$3;}
    | TIPO_DATO Identificador {$$ = $1 + $2;}
    | {$$='';}
;

LISTA_PARAMETROS
    : LISTA_PARAMETROS S_Coma TIPO_DATO Identificador {$$ = $1 + $2 + $3 + $4;}
    | S_Coma TIPO_DATO Identificador {$$ = $1 + $2 +$3;}
;
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------LLAMADAS FUNCION DENTRO METODOS----------------------------------------------------------------------*/
METODOS_LL
    : Identificador S_Igual EXPRESION_G S_PuntoComa                                             {$$ = API.n_Asignacion($1,$3);}
    | Identificador S_ParentesisAbre PARAMETROS_FUNC S_ParentesisCierra S_PuntoComa
;
/*
REDUCCION
    :  S_Igual EXPRESION_G S_PuntoComa {$$ = $1 +$2+$3;}
    | S_ParentesisAbre PARAMETROS_FUNC S_ParentesisCierra S_PuntoComa {$$ = $1 + $2+$3+ $4;}
;
*/
PARAMETROS_FUNC
    : PARAMETROS_FUNC S_Coma EXPRESION_G {$$ = $1 + $2 + $3;}
    | EXPRESION_G
    | {$$='';}
;
/*--------------------------------------------------------------------LLAMADAS FUNCION FUERA METODOS----------------------------------------------------------------------*/
LLAMAR_METODOF_CLASE
    : Identificador S_ParentesisAbre PARAMETROS_FUNC S_ParentesisCierra S_PuntoComa {$$ = $1 + $2 + $3 + $4 + $5;}
;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------------------------------INSTRUCCIONES CONTENIDO METODOS----------------------------------------------------------------------*/
INSTRUCCIONES
    : LISTA_INS                     {console.log(JSON.stringify($1, null, 2));}
    | {$$='';}
;

LISTA_INS
    : LISTA_INS LISTA_INSTRUCCIONES {$1.push($2); $$ = $1;}
    | LISTA_INSTRUCCIONES           {$$ = [$1];}
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
    : R_System S_Punto R_Out S_Punto TIPO_IMPRESION S_ParentesisAbre EXPRESION_G S_ParentesisCierra S_PuntoComa {$$ = API.n_Impresion($5,$7);}/*$1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9*/
;

TIPO_IMPRESION
    : R_Print 
    | R_Println 
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
    : S_ParentesisAbre EXPRESION_G S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra   {$$ = $1+ $2 +$3 + $4 + $5 + $6;}
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
    : R_Switch S_ParentesisAbre EXPRESION_G S_ParentesisCierra S_LlaveAbre LISTA_CASE S_LlaveCierra { $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7; }
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
    : R_Case EXPRESION_G { $$ = $1 + $2; }
    | def
;

/*---------------------------------------------WHILE---------------------------------------------------------*/
  LOOP_WHILE
    : R_While S_ParentesisAbre EXPRESION_G S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra   {$$ = API.n_While($3,$6);}/*$1+ $2 +$3 + $4 + $5 + $6 + $7;*/
;
/*--------------------------------------------- DO WHILE---------------------------------------------------------*/
  LOOP_DO_WHILE
    : R_Do S_LlaveAbre INSTRUCCIONES S_LlaveCierra R_While S_ParentesisAbre EXPRESION_G S_ParentesisCierra S_PuntoComa { $$ = $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9; }
;

/*--------------------------------------------- FOR ---------------------------------------------------------*/

LOOP_FOR
    : R_For S_ParentesisAbre CONT_FOR S_PuntoComa EXPRESION_G S_PuntoComa FIN_FOR S_ParentesisCierra S_LlaveAbre INSTRUCCIONES S_LlaveCierra { $$ = API.n_For( $3 , $5 , $7 , $10); } /*$1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 + $10*/
;
                                                                                                                                            //inicio, condicion, fin, instrucciones
CONT_FOR
    : TIPO_DATO Identificador S_Igual EXPRESION_G        {$$ = API.n_Declaracion($1 , API.n_Variable($2,$4));}
    | Identificador S_Igual EXPRESION_G                  {$$ = API.n_Asignacion($1,$3);}
;

FIN_FOR
    : Identificador S_Igual EXPRESION_G                  {$$ = API.n_Asignacion($1,$3);}
    | EXPRESION_G                                                                      
    ;
