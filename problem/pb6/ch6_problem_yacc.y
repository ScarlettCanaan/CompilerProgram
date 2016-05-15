%{
#include <stdio.h>
#include <string.h>
#include "stack.h"
void yyerror(const char *message);
PLinkStack s;
%}
%union {
int ival;
char* cval;
}
%token <ival> digits
%type <ival> expression
%token <cval> letter
%token <ival> LoveArrowShoooooooot___UMI;
%left '+'
%%
line	    :	 expression  LoveArrowShoooooooot___UMI  expression { showStack(s); }
		    ;
expression  :	 expression  '+'  term	{ printf("match expression->expression + term\n"); }
		    |	 term					{ printf("match expression->term\n"); }
		    ;
term	    :	 '('  term  ')'			{ printf("match term->( term )\n"); }
		    |	 subterm				{ printf("match term->subterm\n"); }
		    ;
subterm		: 	 item					{ printf("match subterm->item\n"); }
			|	 item subterm 			{ printf("match subterm->item subterm\n"); }
			;
item 		:	 digits					{ printf("match item->digits\n");/*printf("digits:%d\n", $1); s->top->info.value += $1; printf("%s %d\n",s->top->info.element, s->top->info.value);*/ }
		    |	 letter					{ printf("match item->letter\n");/*printf("letter:%s\n", $1); DataType node; node.element = $1; node.value = 0; push(s, node);printf("%s %d\n",s->top->info.element, s->top->info.value);*/ }
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
