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
%token <ival> digits
%type <ival> expression
%token <cval> letter
%token <ival> target;
%left '('
%left '+'
%%
line	    :	 expression  target { rightHandSide = 1; }  expression
		    ;
expression  :	 expression  '+'  term	{ printf(" match expression->expression + term\n"); }
		    |	 term					{ printf(" match expression->term\n"); }
		    ;
term	    :	 subterm  '('  {bracketSets++;} letter subterm  ')'			{ printf(" match term->( term )\n"); }
		    |	 subterm				{ printf(" match term->subterm\n"); }
		    ;
subterm		: 	 item					{ printf(" match subterm->item\n"); }
			|	 item subterm 			{ printf(" match subterm->item subterm\n"); }
			| 
			;
item 		:	 digits					{ /*printf(" match item->digits\n");*/
										  if (!rightHandSide)
										  {
											  printf("digits:%d\n", $1);
											  s->top->info.value += $1; 
											  //printf("%s %d\n",s->top->info.element, s->top->info.value);
										  }else
										  {
										  	  printf("digits:-%d\n", $1);
										  	  s->top->info.value -= $1;
										  }
										}

		    |	 letter					{ /*printf(" match item->letter\n");*/
		    							  printf("letter:%s\n", $1); 
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
