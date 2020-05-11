/* descripcion: EJEMPLO DE CALCULAORA */
// segmento de codigo, importaciones y todo dentro de 
%{

%}


/*  Directivas lexicas, expresiones regulares ,Analisis Lexico */
%lex
%options flex case-sensitive
%options yylineno
%locations
%%
\s+                   /* salta espacios en blanco */
"//".*              {}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] {}
([a-zA-Z_])[a-zA-Z0-9_]* {console.log(yytext);}
[\'][\\][\"\'nrt\\][\']       {console.log(yytext);}
[\'][^\'\\\"][\']       {console.log(yytext);}
[\"][^\\\"]*([\\][\\\"ntr][^\\\"]*)*[\"]      { yytext = yytext.substr(1,yyleng-2); console.log(yytext)}
[0-9]+                {return 'Numero';}
"*"                   {return '*';}
"/"                   {return '/';}
"-"                   {return '-';}
"+"                   {return '+';}
"^"                   {return '^';}
"("                   {return '(';}
")"                   {return ')';}
[\t\n\r\f]            {/*se ignoran*/}
<<EOF>>               {return 'EOF';}
.                   {console.error("error lexico: " + yytext)}
/lex

/* operator associations and precedence */

%left '+' '-'
%left '*' '/'
%left '^'

%start expressions

%% /* language grammar */

expressions
    : e EOF
        {console.log($1); return $1;}
    ;

e
    : e '+' e{$$ = $1+$3;}
    | e '-' e{$$ = $1-$3;}
    | e '*' e{$$ = $1*$3;}
    | e '/' e{$$ = $1/$3;}
    | e '^' e{$$ = Math.pow($1, $3);}
    | '(' e ')' {$$ = $2;}
    | Numero {$$ = Number(yytext);}
    ;