/** The wrapper for the input file parser.
 */

#include <assert.h>
#include <stdlib.h>

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
 * @param i The index of the atom.
 * @return The name of the atom.
 */
void get_atom_name (const int i, char *name)
{
}
