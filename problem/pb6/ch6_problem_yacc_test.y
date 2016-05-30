%{
#include <stdio.h>
#include <string.h>
#include "stack.h"
void yyerror(const char *message);
PLinkStack s;
int bracketSets = 0;
int rightHandSide = 0;
%}
%union {
int ival;
char* cval;
}
%token <ival> DIGITS
%type <ival> expression
%token <cval> LETTER
%token <ival> target
%token <ival> left-bracket
%type <ival> num
%type <ival> non_digit
%left '+'
%%
line	    :	 expression  target { rightHandSide = 1; }  expression
		    ;
expression  :	 expression  '+'  chemical	{ printf(" Match expression->expression + chemical\n"); }
		    |	 chemical					{ printf(" Match expression->chemical\n"); }
		    ;
chemical	:	 num molecules		{ printf(" Match chemical->%d molecules\n",$1); }
		    ;
num 		:    DIGITS    {$$ = $1;}
		    |			   {$$ = 1;}
		    ;
molecules   :    non_term '(' item ')' non_digit non_molecules { printf(" Match molecules->non_term ( item ) molecules\n"); }
			|    item  					{ printf(" Match molecules->item\n"); }
			;
non_molecules : molecules 				{ printf(" Match non_molecules->molecules\n"); }
			  | 						{ printf("Match non_molecules-> lambda\n"); }
			  ;
non_term    :	 item  				{ printf(" Match non_term->item\n"); }
			|					    { printf(" Match non_term-> lambda\n"); }
			;
non_digit   :    DIGITS  			{ printf(" Match non_digit->%d\n", $1); $$ = $1; }
 			| 						{ printf(" Match non_digit->1\n"); $$ = 1; }
 			;
item        :    LETTER  subitem	 { printf(" Match item->LETTER subitem\n"); }
			|	 LETTER
			;
subitem     :    element subitem    { printf(" Match subitem->subitem element\n"); }
			| 
			;
element     :	 DIGITS
			|	 LETTER
			;
%%
void yyerror (const char *message)
{
        //fprintf (stderr, "%s\n",message);
		printf("Invalid format\n");
}

int main(int argc, char *argv[]) {
		s = createEmptyStack();
        yyparse();
        return(0);
}
