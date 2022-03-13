/* Seccion de definiciones*/
%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex(void);
extern FILE *yyin;
void yyerror(char *s);
%}

/* Numeros,Strings, char*/
%token NUM STR CHA
/* Booleanos */
%token TRU FAL 
/* Variables */
%token VAR EVA 
/* Constantes */
%token CST ECS 
/* IF */
%token CIF EIF ELI ELS THN
/* Ciclo for */
%token FOR EFO FIN FTO
/* Ciclo WHILE */
%token WHI CDO EWH
/* Condicionales */
%token AND COR IGU MAY MER
/* Identificador asignación */
%token IDE ASG
/* operaciones */
%token APS CPS MUL DIV MAS MEN MOD
/* final de linea*/
%token EOL

/* Sección de reglas */
%%
/*Lineas del código*/
linea	:
		| linea exp EOL {printf("salto de linea\n");}

/*Expresiones del lenguaje*/
exp		:	
		|	if explist elsif EIF {printf("fin IF\n");}
		|	if explist elsif ELS explist EIF {printf("fin IF else\n");}
		|	for explist EFO {printf("fin FOR\n");}
		|	while explist EWH {printf("fin while\n");}
		|	asig;

/*Lista de expresiones contenidas en los ciclos y condicionales*/
explist : 	exp
		| 	explist EOL exp;

/*inicio ELIF*/
elsif	:	
		|	ELI bool THN explist {printf("inicio elif\n");}
		|	ELI bool THN elsif {printf("inicio elif\n");}

/*Inicio if*/
if		:	CIF bool THN {printf("inicio if\n");};

/*Inicio for*/
for		:	FOR opr FIN opr FTO opr CDO {printf("inicio for\n");};

/*Inicio while*/
while	:	WHI bool CDO {printf("inicio while\n");};

/*Asignaciones */
asig	: VAR IDE ASG tdato EVA {printf("variable asignada\n");}
		| CST IDE ASG tdato ECS {printf("constante asignada\n");};

/*Tipos de datos*/
tdato	:	STR | CHA | bool | opr;

/*booleanos */
bool	:	TRU /*TRUE*/
		|	FAL /*FALSE*/
		|	IDE /*identificación*/
		|	opr MAY opr /*mayor que*/
		|	STR MAY STR /*mayor que strings*/
		|	CHA MAY CHA /*mayor que caracteres*/
		|	opr MER opr /*menor que*/
		|	STR MER STR /*menor que strings*/
		|	CHA MER CHA /*menor que caracteres*/
		|	opr IGU opr  /*igual que*/
		|	STR IGU STR  /*igual que strings*/
		|	CHA IGU CHA /*igual que caracteres*/
		|	bool IGU bool 
		|	bool AND bool
		|	bool COR bool
		|	APS bool CPS

/* Operacones Matematicas */
opr 	: 	NUM 
	 	| 	IDE 
		|	opr MAS opr 
		|	opr MEN opr 
		|	opr MUL opr 
		|	opr MOD opr 
		|	opr DIV	opr	
		|	APS opr CPS 
%%

/* Sección de codigo de usuario */
void yyerror(char *s){
	printf("Error sintáctico: %s\n", s);
}

int main(int argc, char **argv){
	if (argc > 1){
		printf("leyendo archivo: %s\n", argv[1]);
		yyin=fopen(argv[1],"rt");
	}else{
		printf("Entrada por teclado\n");
		yyin=stdin;
	}
	yyparse();
	return 0;
}
