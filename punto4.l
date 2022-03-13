%{
#include "punto4.tab.h"
%}

digito	[0-9]
identificador   [a-z][a-z0-9]{0,20}
/** Sección de reglas **/
%%

-?{digito}+(\.{digito}{0,5})?		{return NUM; /* Numeros */}

SIKS						{return TRU; /* TRUE */}
NOKS						{return FAL; /* FALSE */}

VAR							{return VAR; /* INICIO VARIABLE */}
ENDVAR						{return EVA;}/* FIN DE VARIABLE */

CONST						{return CST; /* INICIO CONSTANTE */}
ENDCONST					{return ECS;/* FIN CONSTANTE */}

IF							{return CIF; /* INICIO IF */}
ENDIF						{return EIF; /* FIN IF */}
ELIF						{return ELI; /* INICIO ELIF */}
ELSE						{return ELS; /* INICIO ELSE */}
THEN						{return THN; /* INICIO DE EXPRESIONES DENTRO DE LOS CONDICIONALES */}

FOR							{return FOR; /* INICIO CICLO FOR */}
ENDFOR						{return EFO; /* FINAL CILCO FORS */}
IN							{return FIN; /* INICIO DE RANGO PARA EL CICLO FOR */}
TO							{return FTO; /* SEPARADOR DEL RANGO MENOR Y MAYOR DEL CILO FOR */}
DO							{return CDO; /* INDICA EL INICIO DE LAS INSTRUCCIONES DENTRO DEL CICLO */}

WHILE						{return WHI; /* INICIO CICLO WHILE */}
ENDWHILE					{return EWH; /* FINAL CICLO WHILE */}

AND							{return AND; /* CONDICIONAL Y */}
OR							{return COR; /* CONDICIONAL O */}
"=="						{return IGU; /* CONDICIONAL IGUAL */}
">"							{return MAY; /* MAYOR QUE */}
"<"							{return MER; /* MENOR QUE */}
s
\"[a-zA-Z0-9 -]*\"		  	{return STR; /* STRINGS */}
\'.?\'		  				{return CHA; /* CHAR */}

{identificador}				{return IDE; /* IDENTIFICADORES DE VARIABLES */}
\=							{return ASG; /* ASIGNACIÓN DE VARIABLES */}

\(							{return APS; /* ABRE PARÉTESIS */}
\)							{return CPS; /* CIERRA PARÉTESIS */}
\*							{return MUL; /* SIGNO MULTIPLICACIÓN */}
\/							{return DIV; /* SIGNO DIVISIÓN */}
\+							{return MAS; /* SIGNO SUMA */}
\-							{return MEN; /* SIGNO RESTA */}
\%							{return MOD; /* SIGNO MODULO */}

";"							{return EOL; /* FINAL DE LINEA */}

\/\*.{0,1000}\*\/ 			{/* Ignora comentarios*/}
[ \n\t]						{/* Ignorar espacios*/}
.							{printf("Error lexico: %s\n", yytext);} 

%%

/** Sección código de usuario **/