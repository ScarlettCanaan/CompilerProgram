%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *message);
struct ast_node *
new_ast_node (int node_type, int value,
              struct ast_node * left,
              struct ast_node * right);
struct ast_node *
new_ast_number_node (int value);
void
free_ast_tree (struct ast_node * ast_tree);
struct ast_node
{
  int value;
  int operation;
  struct ast_node * left;

  struct ast_node * right;
};
int result = 0;
%}
%union {
	int ival;
	struct ast_node* ast;
}
%token <ival> DIGITS
%type <ast> expression
%type <ast> term
%type <ast> func
%type <ast> line
%left '+'
%left '-'
%left '*'
%left '/'
%%
line	    :   expression					{ $$ = $1; result = $$->value; printf("the preorder expression is : "); free_ast_tree($$); printf("\nthe result is : %d\n",result); }
		    ;
expression  :	term						{ $$ = $1; }
			| 	expression 	'+'	 term 		{ $$ = new_ast_node('+', ($1->value + $3->value), $1, $3); }
			| 	expression 	'-'  term 		{ $$ = new_ast_node('-', ($1->value - $3->value), $1, $3); }
			;
term 		:	func						{ $$= $1; }
			| 	term 	    '*'  func		{ $$ = new_ast_node('*', ($1->value * $3->value), $1, $3); }
			|   term 		'/'	 func 		{ $$ = new_ast_node('/', ($1->value / $3->value), $1, $3); }			
			;
func  		:   DIGITS						{ $$ = new_ast_number_node($1); }
		    |   '('   expression   ')'		{ $$ = $2; }
		    ;
%%

struct ast_node* new_ast_node (int node_type, int value,
              struct ast_node * left,
              struct ast_node * right)
{
  struct ast_node * ast_node =
    malloc (sizeof (struct ast_node));

  ast_node->operation = node_type;
  ast_node->value = value;

  ast_node->left = left;
  ast_node->right = right;

  return ast_node;
}

struct ast_node * new_ast_number_node (int value)
{
  struct ast_node * ast_node =
    malloc (sizeof (struct ast_node));

  ast_node->operation = 'N';

  ast_node->value = value;

  ast_node->right = NULL;
  ast_node->left = NULL;

  return (struct ast_node *) ast_node;
}

void free_ast_tree (struct ast_node * ast_tree)
{
  if (!ast_tree) return;

  switch (ast_tree->operation)
  {
    /* two sub trees */
    case '+':
    	printf("+ ");
    	free_ast_tree(ast_tree->left);
        free_ast_tree (ast_tree->right);
        break;
    case '-':
    	printf("- ");
    	free_ast_tree(ast_tree->left);
        free_ast_tree (ast_tree->right);
        break;
    case '*':
    	printf("* ");
    	free_ast_tree(ast_tree->left);
        free_ast_tree (ast_tree->right);
        break;
    case '/':
      	printf("/ ");
    	free_ast_tree(ast_tree->left);
        free_ast_tree (ast_tree->right);
        break;
  	case 'N':
  	  printf("%d ", ast_tree->value);
  	  break;
  }

  free (ast_tree);
}

void yyerror (const char *message)
{
		printf("Invalid format\n");
}

int main(int argc, char *argv[]) {
        yyparse();

        return(0);
}
