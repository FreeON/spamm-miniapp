/** The wrapper for the input file parser.
 */

#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "ptypes.h"

extern struct control_t *control;

/** Check whether the parsed input contained a geometry block.
 *
 * @return 1 if a geometry was found, 0 otherwise.
 */
int have_geometry (void)
{
  if(control != NULL)
  {
    if(control->atoms != NULL)
    {
      return 1;
    }
  }

  return 0;
}

/** Return the number of atoms in the geometry.
 *
 * @preturn The number of atoms.
 */
int get_number_atoms (void)
{
  assert(control != NULL);
  if(control->atoms == NULL)
  {
    return 0;
  }
  else
  {
    return control->atoms->number_atoms;
  }
}

/** Get the atom name of a particular atom.
 *
 * @todo Not implemented yet.
 * @param i The index of the atom.
 * @return The name of the atom.
 */
void get_atom_name (const int i, char *name)
{
}

/** Parse the input.
 *
 * @todo Not implemented yet.
 * @param length The length of the filename.
 * @param filename The input file.
 */
void parse_input_file (const int *length, const char *filename)
{
  int fd;
  int i;
  char *new_filename;

  /* Terminate string. */
  new_filename = calloc(*length+1, sizeof(char));
  for(i = 0; i < *length; i++)
  {
    new_filename[i] = filename[i];
  }

  if((fd = open(new_filename, O_RDONLY)) < 0)
  {
    printf("can not open input file: %s\n", new_filename);
    exit(1);
  }

  if(dup2(fd, 0) != 0)
  {
    printf("can not redirect input file to stdin\n");
    exit(1);
  }

  yyparse();
}
