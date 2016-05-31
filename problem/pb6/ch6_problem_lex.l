%{
	#include "ch6_problem_yacc_test.tab.h"
%}
%%
\n	    	 { return (0);  /* EOF */}
[ \t]+  	 { /*do nothing*/ }
<<<<<<< HEAD
[0-9]+   	 { yylval.ival = atoi(yytext); return(DIGITS); }
\+     		 { return(yytext[0]); }
"->" 		 { yylval.ival = '->'; return(target); }
\(			 { return(yytext[0]); }
\)			 { return(yytext[0]); }
[A-Z][a-z]?  { yylval.cval = strdup(yytext); return(LETTER); }
=======
[0-9]   	 { ECHO; yylval.ival = atoi(yytext); return(DIGITS); }
\+     		 { ECHO; return(yytext[0]); }
"->" 		 { ECHO; yylval.ival = '->'; return(target); }
\(		 { ECHO; return(yytext[0]); }
\)		 { ECHO; return(yytext[0]); }
[A-Z][a-z]?  	{ ECHO; yylval.cval = strdup(yytext); return(LETTER); }
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
%%

