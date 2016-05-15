#lex compiler
flex -o ch6_problem_lex.yy.c ch6_problem_lex.sty
cc -c -g -I.. ch6_problem_lex.yy.c

#yacc compiler
bison -d -o ch6_problem_yacc.tab.c ch6_problem_yacc.y
cc -c -g -I.. ch6_problem_yacc.tab.c

#compile and link bison and lex
cc -o ch6_problem ch6_problem_yacc.tab.o ch6_problem_lex.yy.o -ll
