#yacc compiler
bison -d -o ch6_problem_yacc.tab.c ch6_problem_yacc_test.y
cc -c -g -I.. ch6_problem_yacc.tab.c

#lex compiler
flex -o ch6_problem_lex.yy.c ch6_problem_lex.sty
cc -c -g -I.. ch6_problem_lex.yy.c

#compile and link bison and lex
cc -o ch6_problem ch6_problem_yacc.tab.o ch6_problem_lex.yy.o -ll
