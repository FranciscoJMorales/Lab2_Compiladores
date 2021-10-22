
%%
[ \t]		; { /* Espacios en blanco */ }
or			return TOR; 
and			return TAND; 
not			return TNOT; 
true		return TTRUE; 

false		return TFALSE; 

[\(\)\n]	return yytext[0];
.		{
	printf("Error lexico\n");
	exit(0);
}
%%

int yywrap(void)
{
	return 0;
}
