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

/*  OPERACIONES */

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

/*  CADENAS  */

[\"][^\\\"]*([\\][\\\"ntr][^\\\"]*)*[\"]           { yytext = yytext.substr(1,yyleng-2); return 'Cadena'; }

/*  NUMEROS */

[0-9]+("."[0-9]+)?\b    {return 'Decimal';}
[0-9]+\b                {return 'Entero';}

/*  IDENTIFICADORES */

([a-zA-Z_])[a-zA-Z0-9_]* {return 'Identificador';}

/*  CHAR    */
[\'][\\][\"\'nrt\\][\']       {yytext = yytext.substr(1,yyleng-2);return 'CHAR_Especial';}
[\'][^\'\\\"][\']             {yytext = yytext.substr(1,yyleng-2);return 'Char';}

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

CONTENIDO
    : CONTENIDO IMPORT {console.log($2);}
    | IMPORT {console.log($1 + "\n"); }
    | CONTENIDO MODIFICADORES_ACCESO CLASES {console.log( $2+' '+$3 + "\n");}
    | MODIFICADORES_ACCESO CLASES {console.log($1+' ' + $2 + "\n");}
    | CONTENIDO VARIABLE {console.log($2 + "\n");}
    | VARIABLE {console.log($1 + "\n"); }
;

IMPORT
    : R_Import LISTADO_IMPORT S_PuntoComa {$$ = $1 +' '+ $2+ $3;}
;

LISTADO_IMPORT
    : LISTADO_IMPORT S_Punto Identificador {$$ = $1 + $2+ $3;}
    | Identificador {$$ = $1;}
;

VARIABLE
    : TIPO_DATO LISTADO_ID_VARIABLE S_PuntoComa {$$ = $1 + ' ' + $2+ $3;}
;

LISTADO_ID_VARIABLE
    : LISTADO_ID_VARIABLE S_Coma CONTENIDO_VARIABLE {$$ = $1 + $2+ $3;}
    | CONTENIDO_VARIABLE {$$ = $1;}
;

CONTENIDO_VARIABLE
    : Identificador {$$ = $1;}
;

CLASES 
    : R_Class Identificador S_LlaveAbre LISTA_METODOS S_LlaveCierra {$$ = $1+' ' + $2 + $3 +$4 +$5 +"\n";}
;

LISTA_METODOS
    : LISTA_METODOS METODO {$$ = $1 + $2;}
    | METODO {$$ = $1;}
;

METODO
    : TIPO_DATO Identificador S_ParentesisAbre S_ParentesisCierra S_LlaveAbre S_LlaveCierra {$$ = $1 +' '+ $2 + $3 +$4 +$5 +$6+"\n";}
    | R_Void METODO_VOID {$$ = $1 +' '+ $2;}
;

METODO_VOID
    : R_Main S_ParentesisAbre S_ParentesisCierra S_LlaveAbre S_LlaveCierra {$$ = $1 + $2 + $3 +$4 + $5;}
    | Identificador S_ParentesisAbre S_ParentesisCierra S_LlaveAbre S_LlaveCierra {$$ = $1 + $2 + $3 +$4 + $5;}
;

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
    |
;


