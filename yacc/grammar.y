%{
	#include <ctype.h>
	#include <stdio.h>
	#include <stdbool.h>

	extern int yylex();
	void yyerror(char *msg);
%}

%token TOR
%token TAND
%token TNOT
%token TTRUE
%token TFALSE

%%
lines	: lines bexpr '\n' { printf($2 ? "true (1)\n" : "false (0)\n") ;}
		| lines '\n'
		| /* empty */
		;
		
bexpr	: bexpr TOR bterm { $$ = $1 || $3 }
		| bterm { $$ = $1 }
		;
		
bterm	: bterm TAND bfactor	{ $$ = $1 && $3 }
		| bfactor { $$ = $1 }
		;

bfactor	: TNOT bfactor	{ $$ = !$2 }
		| '(' bexpr ')' { $$ = $2 }
		| TTRUE { $$ = true }
		| TFALSE { $$ = false }
		;

%%

#include "lex.yy.c"

void yyerror(char *msg){
	printf("Error de sintaxis\n");
	exit(0);
}

int main(){
	yyparse();
	return 0;
}