%{
#include <stdio.h>
#include <string.h>
#include "stack.h"
void yyerror(const char *message);
PLinkStack record;
PLinkStack s;
PLinkStack bracket_s[10];
PNode temp;
int bracketSets = 0;
int rightHandSide = 0;
int firsFlag = 1;
int addedFlag = 0;
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
<<<<<<< HEAD
line	    :	 expression  target { rightHandSide = 1; }  expression	{ 
																			record = sort(record);
																			showStack(record); 
																		}
=======
line	    :	 expression  target { rightHandSide = 1; }  expression	{ record = sort(record); showStack(record); }
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
	    ;
expression  :	 expression  '+'  chemical
	    |	 chemical
	    ;
chemical    :	 num molecules						{ 
										bracketSets = 0;
										DataType node;
										while (!isEmptyStack(s))
										{
											node = getTop(s);
											node.value *= $1;
											temp = record->top;
											if (firsFlag)
											{
												push(record, node);
												pop(s);
												firsFlag = 0;
											}
											else
											{
												while ((temp) != 0x48 && (temp) != 0x0)
												{
													if (strcmp(temp->info.element, node.element) == 0)
													{
														temp->info.value += node.value;
														pop(s);
														addedFlag = 1;
													}
													temp = temp->link;
												}
												if (!addedFlag)
												{
													push(record, node);
													pop(s);
												}
												addedFlag = 0;
											}
										}
										destroyStack(s);
										s = createEmptyStack();
									}
	    ;
num 	    :    DIGITS    						{ $$ = $1; }
	    |			   					{ $$ = 1;  }
	    ;
<<<<<<< HEAD
molecules   :    non_term '(' left molecules ')' non_digit non_mole
	    |    item  										
	    ;
left 	    :						{
										bracket_s[bracketSets] = createEmptyStack();
										++bracketSets;
=======
molecules   :    non_term '(' left item ')' non_digit non_mole
	    |    item  										
	    ;
left 	    :								{
										bracketSets = 1;
										bracket_s = createEmptyStack();
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
									}
non_mole    :    molecules 									
	    | 												
	    ;
non_term    :	 item  										
	    |											    
	    ;
non_digit   :    DIGITS  									
									{
<<<<<<< HEAD
										DataType node;
										if (bracketSets == 1)
										{
											while (!isEmptyStack(bracket_s[0]))
											{
												node = getTop(bracket_s[0]);
												node.value *= $1;
												push(s, node);
												pop(bracket_s[0]);
											}
											destroyStack(bracket_s[0]);
										}
										else
										{
											while (!isEmptyStack(bracket_s[bracketSets-1]))
											{
												node = getTop(bracket_s[bracketSets-1]);
												node.value *= $1;
												push(bracket_s[bracketSets-2], node);
												pop(bracket_s[bracketSets-1]);
											}
											destroyStack(bracket_s[bracketSets-1]);										
										}
										--bracketSets;
									}
 	    | 												
 									{													
										DataType node;
										if (bracketSets == 1)
										{
											while (!isEmptyStack(bracket_s[0]))
											{
												node = getTop(bracket_s[0]);
												node.value *= 1;
												push(s, node);
												pop(bracket_s[0]);
											}
											destroyStack(bracket_s[0]);
										}
										else
										{
											while (!isEmptyStack(bracket_s[bracketSets-1]))
											{
												node = getTop(bracket_s[bracketSets-1]);
												node.value *= 1;
												push(bracket_s[bracketSets-2], node);
												pop(bracket_s[bracketSets-1]);
											}
											destroyStack(bracket_s[bracketSets-1]);										
										}
										--bracketSets;
=======
										bracketSets = 0;
										DataType node;
										while (!isEmptyStack(bracket_s))
										{
											node = getTop(bracket_s);
											node.value *= $1;
											push(s, node);
											pop(bracket_s);
										}
										destroyStack(bracket_s);
									}
 	    | 												
 									{													
 										bracketSets = 0;
										DataType node;
										while (!isEmptyStack(bracket_s))
										{
											node = getTop(bracket_s);
											node.value *= 1;
											push(s, node);
											pop(bracket_s);
										}
										destroyStack(bracket_s);
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
									}
 	    ;
item        :    LETTER 
		    							{
				    						DataType node; 
				  				 		node.element = $1; 
		    								if (!rightHandSide)
		    								{
		    									node.value = 1;
		    								}
		    								else
		    								{
		    									node.value = -1;
		    								}
		    								if (!bracketSets)
		    								{
		    									push(s, node);	
					    					}
					    					else
		    								{
<<<<<<< HEAD
		    									push(bracket_s[bracketSets-1], node);
=======
		    									push(bracket_s, node);
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
		    								}
		    							}
 		 subitem	 						
	    |	 LETTER
					    				{
				    						DataType node; 
				  				 		node.element = $1; 
		    								if (!rightHandSide)
		    								{
		    									node.value = 1;
		    								}
		    								else
		    								{
		    									node.value = -1;
		    								}
		    								if (!bracketSets)
		    								{
		    									push(s, node);	
					    					}
					    					else
		    								{
<<<<<<< HEAD
		    									push(bracket_s[bracketSets-1], node);
=======
		    									push(bracket_s, node);
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
		    								}
		    							}
	    ;
subitem     :    element subitem    						
	    | 
	    ;
element     :	 DIGITS							{
										int temp;
										if (!rightHandSide)
										{
											temp = +($1 - 1);
										}
										else
										{
										  	temp = -($1 - 1);
										}
										if (!bracketSets)
										{
											s->top->info.value += temp;
										}
										else
										{
<<<<<<< HEAD
											bracket_s[bracketSets-1]->top->info.value += temp;
=======
											bracket_s->top->info.value += temp;
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
										}
									}
	    |	 LETTER		
		    							{
				    						DataType node; 
				  				 		node.element = $1; 
		    								if (!rightHandSide)
		    								{
		    									node.value = 1;
		    								}
		    								else
		    								{
		    									node.value = -1;
		    								}
		    								if (!bracketSets)
		    								{
		    									push(s, node);	
					    					}
					    					else
		    								{
<<<<<<< HEAD
		    									push(bracket_s[bracketSets-1], node);
=======
		    									push(bracket_s, node);
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
		    								}
		    							}
			;
%%
void yyerror (const char *message)
{
        //fprintf (stderr, "%s\n",message);
		printf("Invalid format\n");
}

int main(int argc, char *argv[]) {
		record = createEmptyStack();
		s = createEmptyStack();
        yyparse();
        return(0);
}
