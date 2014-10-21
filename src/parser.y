%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ptypes.h"
int yydebug = 1;
extern int yylineno;
void yyerror(const char *msg);
void parser_add_atom (char *name, double *x, double *y, double *z);
%}

%union{
  int int_val;
  double float_val;
  char *string;
}

%token BEGIN_GEOMETRY "<BeginGeometry>"
%token END_GEOMETRY "<EndGeometry>"
%token <string> ID
%token <float_val> FLOAT_LITERAL "a float literal"
%token <int_val> INT_LITERAL "an integer literal"

%type <float_val> float_value

%locations

%start input

%locations

%destructor { if($$) free($$); } <string>;

%printer { fprintf(yyoutput, "%s", $$); } <string>
%printer { fprintf(yyoutput, "%f", $$); } <float_val>

%%

input: /* empty. */
     | input geometry
     ;

geometry: BEGIN_GEOMETRY atom_list END_GEOMETRY
        ;

atom_list: /* empty */
           | atom_list atom
         ;

atom: ID float_value float_value float_value
      {
        /* Call up into parser.F90 */
        parser_add_atom($1, &$2, &$3, &$4);
      }
      ;

float_value: INT_LITERAL { $$ = $1; }
           | FLOAT_LITERAL { $$ = $1; }
           ;

%%

void yyerror (const char *s)
{
  fprintf(stderr, "%s on line %d\n", s, yylineno);
  exit(1);
}
