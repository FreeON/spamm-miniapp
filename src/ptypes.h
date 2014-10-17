/** @file
 *
 * The parser types.
 *
 * This header contains all type definitions used by the input file parser.
 */

#ifndef __PTYPES_H
#define __PTYPES_H

/** The atom type. */
struct atom_t
{
  /** The atom name. */
  char *name;

  /** The atom position. */
  double x[3];
};

/** The atomlist type. */
struct atomlist_t
{
  /** The number of atoms in this list. */
  int number_atoms;

  /** An array of atoms of type atom_t. */
  struct atom_t *atoms;
};

/** The control data type. */
struct control_t
{
  /** The geometry. */
  struct atomlist_t *atoms;
};

#endif
