%{
	#include "ch6_problem_yacc_test.tab.h"
%}
%%
\n	    	 { return (0);  /* EOF */}
[ \t]+  	 { /*do nothing*/ }
[0-9]+   	 { yylval.ival = atoi(yytext); return(DIGITS); }
\+     		 { return(yytext[0]); }
"->" 		 { yylval.ival = '->'; return(target); }
\(			 { return(yytext[0]); }
\)			 { return(yytext[0]); }
[A-Z][a-z]?  { yylval.cval = strdup(yytext); return(LETTER); }
%%

