%{
#include "parser.h"
%}

%%

'#'  { return COMMENT_TOKEN; }
