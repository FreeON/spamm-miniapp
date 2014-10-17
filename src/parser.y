%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ptypes.h"
int yydebug = 1;
%}

%union{
  double float_val;
  char *string;
  struct atom_t *atom;
  struct atomlist_t *atoms;
}

%token BEGIN_GEOMETRY
%token END_GEOMETRY
%token EOL
%token <string> ID
%token <float_val> FLOAT_LITERAL

%type <atom> geometry_entry
%type <atoms> geometry_entries

%start input

%destructor { free($$); } ID;
%destructor { free($$->name); free($$); } geometry_entry;
%destructor {
  int i;
  for(i = 0; i < $$->number_atoms; i++)
  {
    free($$->atoms[i].name);
  }
  free($$);
} geometry_entries

%printer { fprintf(yyoutput, "%s", $$); } ID
%printer { fprintf(yyoutput, "%f", $$); } FLOAT_LITERAL
%printer {
  fprintf(yyoutput, "%s %f %f %f", $$->name, $$->x[0], $$->x[1], $$->x[2]);
} geometry_entry
%printer {
  int i;
  fprintf(yyoutput, "%p", $$);
  //fprintf(yyoutput, "%d atoms\n", $$->number_atoms);
  //for(i = 0; i < $$->number_atoms; i++)
  //{
  //  fprintf(yyoutput, "%s %f %f %f", $$->atoms[i].name,
  //          $$->atoms[i].x[0], $$->atoms[i].x[1], $$->atoms[i].x[2]);
  //  if(i+1 < $$->number_atoms) fprintf(yyoutput, "\n");
  //}
} geometry_entries

%%

input: /* empty */
     | input geometry
     ;

geometry: BEGIN_GEOMETRY geometry_entries END_GEOMETRY
        ;

geometry_entries: /* empty */
                | geometry_entry geometry_entries
                  {
                    int i;
                    $$ = calloc(1, sizeof(struct atomlist_t));
                    $$->number_atoms = 1+$2->number_atoms;
                    $$->atoms = calloc($$->number_atoms, sizeof(struct atom_t));
                    $$->atoms[0].name = strdup($1->name);
                    $$->atoms[0].x[0] = $1->x[0];
                    $$->atoms[0].x[1] = $1->x[1];
                    $$->atoms[0].x[2] = $1->x[2];
                    for(i = 1; i < $$->number_atoms; i++)
                    {
                      $$->atoms[i].name = strdup($2->atoms[i].name);
                    }
                  }
                ;

geometry_entry: ID FLOAT_LITERAL FLOAT_LITERAL FLOAT_LITERAL
                {
                  $$ = calloc(1, sizeof(struct atom_t));
                  $$->name = strdup($1);
                  $$->x[0] = $2;
                  $$->x[1] = $3;
                  $$->x[2] = $4;
                }
                ;

%%

int yyerror (const char *s)
{
  printf("[syntax error] %s\n", s);
  exit(1);
}
