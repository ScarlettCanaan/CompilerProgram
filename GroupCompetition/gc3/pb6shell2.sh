#yacc compiler
bison -d gc3.y
cc -c -g -I.. gc3.tab.c

#lex compiler
flex gc3.l
cc -c -g -I.. lex.yy.c

#compile and link bison and lex
cc -o gc3_problem gc3.tab.o lex.yy.o -ll
