%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ptypes.h"
int yydebug = 1;

/** The line numbers from the lexer. */
extern int yylineno;

/** Interface for the error reporting function. */
void yyerror(const char *msg);

/** From parser.F90. */
void parser_add_atom (char *name, double *x, double *y, double *z);
%}

%union{
  int int_val;
  double float_val;
  char *string;
}

%token BEGIN_GEOMETRY "<BeginGeometry>"
%token END_GEOMETRY "<EndGeometry>"
%token BEGIN_OPTIONS "<BeginOptions>"
%token END_OPTIONS "<EndOptions>"
%token ASSIGN_TOKEN "="
%token OPEN_BRACE_TOKEN "("
%token CLOSE_BRACE_TOKEN ")"
%token COMMA_TOKEN ","
%token <string> ID
%token <float_val> FLOAT_LITERAL "float literal"
%token <int_val> INT_LITERAL "integer literal"

%type <float_val> float_value

%start input

%locations

%destructor { if($$) free($$); } <string>;

%printer { if($$) fprintf(yyoutput, "%s", $$); } <string>
%printer { fprintf(yyoutput, "%f", $$); } <float_val>

%%

input: /* empty. */
     | input geometry
     | input options
     ;

options: BEGIN_OPTIONS option_list END_OPTIONS
       ;

option_list: /* empty */
           | option_list option
            ;

option: ID ASSIGN_TOKEN float_value
        {
          fprintf(stderr, "assignment: %s = %f\n", $1, $3);
          yyerror("[FIXME] encountered option");
        }
      | ID ASSIGN_TOKEN list_value
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

list_value: OPEN_BRACE_TOKEN list_values CLOSE_BRACE_TOKEN
            {
              yyerror("[FIXME] encountered list");
            }
          ;

list_values: float_value { fprintf(stderr, "list value: %f\n", $1); }
           | list_values COMMA_TOKEN float_value
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
