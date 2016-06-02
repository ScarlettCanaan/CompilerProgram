%{
	#include "gc3.tab.h"
%}
%%
\n	    	 { return (0);  /* EOF */}
[ \t]+  	 { /*do nothing*/ }
[0-9]+   	 { yylval.ival = atoi(yytext); return(DIGITS); }
\+     		 { return(yytext[0]); }
\-			 { return(yytext[0]); }
\*			 { return(yytext[0]); }
\/			 { return(yytext[0]); }
\(		 { return(yytext[0]); }
\)		 { return(yytext[0]); }
%%
