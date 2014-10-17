/** The parser types.
 */

#ifndef __PTYPES_H
#define __PTYPES_H

struct atom_t
{
  char *name;
  double x[3];
};

struct atomlist_t
{
  int number_atoms;
  struct atom_t *atoms;
};

#endif
