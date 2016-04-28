%{
#include <string.h>
int stateCount = 0; 
void tabCount() {
	int j = 0;
	while(yytext[j] == '\t' && yytext[j] != '\0') j++;
	if (j < stateCount)
		for (; j < stateCount; ++j) printf("\t");
	else if (j > stateCount)
		for (; j > stateCount; --j) yytext++;
		printf("%s//%d", yytext, stateCount);
}
void tabCount2() {
	int k = 0;
	printf("%s", yytext);
	for (; k < stateCount; ++k) printf("\t");
	printf("//%d", stateCount);
}
%}
%%
.*\{[\t]*    { tabCount(); stateCount++; }
.*\}[\t]*	 { stateCount--;tabCount(); }
.+           { tabCount(); }
\n$		     { tabCount2(); }
%%
int main() {
	yylex();
	return (0);
}
