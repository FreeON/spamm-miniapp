%{
#include "parser.h"
%}

/* Track line numbers during parsing. */
%option yylineno

%%

"<BeginGeometry>"       { return BEGIN_GEOMETRY; }
"<EndGeometry>"         { return END_GEOMETRY; }
"<BeginOptions>"        { return BEGIN_OPTIONS; }
"<EndOptions>"          { return END_OPTIONS; }
=                       { return ASSIGN_TOKEN; }
[(]                     { return OPEN_BRACE_TOKEN; }
[)]                     { return CLOSE_BRACE_TOKEN; }
,                       { return COMMA_TOKEN; }
[a-zA-Z][0-9a-zA-Z]*    { yylval.string = strdup(yytext); return ID; }
[0-9.][.][0-9.eEdD+-]*  { yylval.float_val = strtod(yytext, NULL); return FLOAT_LITERAL; }
[0-9]+                  { yylval.int_val = strtol(yytext, NULL, 10); return INT_LITERAL; }
#.*$                    { /* A comment. */ }
[ \t\n]                 {}
