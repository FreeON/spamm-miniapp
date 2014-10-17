%{
#include "parser.h"
%}

%%

"<BeginGeometry>" { return BEGIN_GEOMETRY; }
"<EndGeometry>"   { return END_GEOMETRY; }
[a-zA-Z]+         { yylval.string = strdup(yytext); return ID; }
[0-9.eEdD+-]      { yylval.float_val = strtod(yytext, NULL); return FLOAT_LITERAL; }
