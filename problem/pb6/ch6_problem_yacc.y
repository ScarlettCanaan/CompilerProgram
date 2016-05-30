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
%token <ival> target;
%token <ival> left-bracket
%left '+'
%%
line	    :	 expression  target { rightHandSide = 1; }  expression
		    ;
expression  :	 expression  '+'  term	{ printf(" match expression->expression + term\n"); }
		    |	 term					{ printf(" match expression->term\n"); }
		    ;
term	    :	 subterm  '('  {bracketSets++;} LETTER subterm  ')'			{ printf(" match term->( term )\n"); }
		    |	 subterm				{ printf(" match term->subterm\n"); }
		    ;
subterm		: 	 item					{ printf(" match subterm->item\n"); }
			|	 item subterm 			{ printf(" match subterm->item subterm\n"); }
			| 
			;
item 		:	 DIGITS					{ /*printf(" match item->DIGITS\n");*/
										  if (!rightHandSide)
										  {
											  printf("DIGITS:%d\n", $1);
											  s->top->info.value += $1; 
											  //printf("%s %d\n",s->top->info.element, s->top->info.value);
										  }else
										  {
										  	  printf("DIGITS:-%d\n", $1);
										  	  s->top->info.value -= $1;
										  }
										}

		    |	 LETTER					{ /*printf(" match item->LETTER\n");*/
		    							  printf("LETTER:%s\n", $1); 
		    							  DataType node; 
		    							  node.element = $1; 
		    							  node.value = 0; 
		    							  push(s, node);
		    							  //printf("%s %d\n",s->top->info.element, s->top->info.value);
		    							}
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
