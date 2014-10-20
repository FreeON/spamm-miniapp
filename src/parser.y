%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ptypes.h"
int yydebug = 1;
extern int yylineno;
extern char *yytext;
struct control_t *control;
void yyerror(const char *msg);
void free_atom (struct atom_t *atom);
void free_atoms (struct atomlist_t *atoms);
void free_control (struct control_t *control);
void parser_add_atom (char *name, double *x, double *y, double *z);
%}

%union{
  int int_val;
  double float_val;
  char *string;
  struct atom_t *atom;
  struct atomlist_t *atoms;
  struct control_t *control;
}

%token BEGIN_GEOMETRY "<BeginGeometry>"
%token END_GEOMETRY "<EndGeometry>"
%token EOL
%token <string> ID
%token <float_val> FLOAT_LITERAL "a float literal"
%token <int_val> INT_LITERAL "an integer literal"

%type <float_val> float_value
%type <atom> atom
%type <atoms> atom_list
%type <atoms> geometry
%type <control> input

%locations

%start input

%locations

%destructor { if($$) free($$); } <string>;
%destructor { if($$) free_atom($$); } <atom>;
%destructor { free_atoms($$); } <atoms>;
%destructor { free_control($$); } <control>;

%printer { fprintf(yyoutput, "%s", $$); } <string>
%printer { fprintf(yyoutput, "%f", $$); } <float_val>
%printer {
  if($$) fprintf(yyoutput, "%s %f %f %f", $$->name, $$->x[0], $$->x[1], $$->x[2]);
} <atom>
%printer {
  if($$) fprintf(yyoutput, "%d atoms", $$->number_atoms);
} <atoms>
%printer {
  if($$->atoms != NULL)
  {
    fprintf(yyoutput, "%d atoms", $$->atoms->number_atoms);
  }
  else
  {
    fprintf(yyoutput, "empty");
  }
} <control>

%%

input: /* empty */
     { $$ = calloc(1, sizeof(struct control_t)); }
     | input geometry
     {
       if($1->atoms != NULL)
       {
         yyerror("duplicate geometry entry");
       }
       else
       {
         $$ = calloc(1, sizeof(struct control_t));
         $$->atoms = $2;
       }
     }
     ;

geometry: BEGIN_GEOMETRY atom_list END_GEOMETRY
        {
          $$ = calloc(1, sizeof(struct atomlist_t));
          $$->number_atoms = $2->number_atoms;
          $$->atoms = $2->atoms;
        }
        ;

atom_list: /* empty */
           { $$ = calloc(1, sizeof(struct atomlist_t)); }
           | atom_list atom
           {
             int i;
             $$ = calloc(1, sizeof(struct atomlist_t));
             $$->number_atoms = 1+$1->number_atoms;
             $$->atoms = calloc($$->number_atoms, sizeof(struct atom_t));
             for(i = 0; i < $1->number_atoms; i++)
             {
               $$->atoms[i].name = strdup($1->atoms[i].name);
               $$->atoms[i].x[0] = $1->atoms[i].x[0];
               $$->atoms[i].x[1] = $1->atoms[i].x[1];
               $$->atoms[i].x[2] = $1->atoms[i].x[2];
             }
             $$->atoms[$1->number_atoms].name = strdup($2->name);
             $$->atoms[$1->number_atoms].x[0] = $2->x[0];
             $$->atoms[$1->number_atoms].x[1] = $2->x[1];
             $$->atoms[$1->number_atoms].x[2] = $2->x[2];
             free_atom($2);
           }
         ;

atom: ID float_value float_value float_value
      {
        $$ = calloc(1, sizeof(struct atom_t));
        $$->name = strdup($1);
        $$->x[0] = $2;
        $$->x[1] = $3;
        $$->x[2] = $4;
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
  fprintf(stderr, "%s on line %d, unexpected \"%s\"\n", s, yylineno, yytext);
  exit(1);
}

void free_atom (struct atom_t *atom)
{
  free(atom->name);
  free(atom);
  YYDPRINTF((stderr, "Free atom\n"));
}

void free_atoms (struct atomlist_t *atoms)
{
  int i;
  for(i = 0; i < atoms->number_atoms; i++)
  {
    free(atoms->atoms[i].name);
  }
  free(atoms->atoms);
  free(atoms);
  YYDPRINTF((stderr, "Free atom_list\n"));
}

void free_control (struct control_t *control_arg)
{
  control = control_arg;
}
