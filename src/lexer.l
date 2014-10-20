%{
#include "parser.h"
%}

%%

"<BeginGeometry>"       { return BEGIN_GEOMETRY; }
"<EndGeometry>"         { return END_GEOMETRY; }
[a-zA-Z][0-9a-zA-Z]*    { yylval.string = strdup(yytext); return ID; }
[0-9.][.][0-9.eEdD+-]*  { yylval.float_val = strtod(yytext, NULL); return FLOAT_LITERAL; }
[0-9]+                  { yylval.int_val = strtol(yytext, NULL, 10); return INT_LITERAL; }
#.*$                    { /* A comment. */ }
[ \t\n]                 {}
