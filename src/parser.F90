!> The parser interface module.
module parser

  use logging

  implicit none

  !> The atom type.
  type :: atom_t
    !> The atom name.
    character(len = 2) :: atom_name
  end type atom_t

  !> The atomlist type.
  type :: atomlist_t
    !> The number of atoms in the list.
    integer :: number_atoms

    !> The atoms.
    type(atom_t), allocatable :: atom(:)
  end type atomlist_t

  !> The control data type.
  type :: control_t
    !> The geometry.
    type(atomlist_t) :: geometry
  end type control_t

  !> The C interface to the Bison parser.
  interface
    !> The interface to the Bison parser.
    subroutine yyparse () bind(C)
      use, intrinsic :: iso_C_binding
    end subroutine yyparse

    !> Check whether the parsed input contains a geometry block.
    !!
    !! @return 1 if the geometry block was found, 0 otherwise.
    function have_geometry () bind(C)
      use, intrinsic :: iso_C_binding
      integer(C_INT) :: have_geometry
    end function have_geometry

    !> Get the number of atoms in the geometry.
    !!
    !! @return The number of atoms.
    function get_number_atoms () bind(C)
      use, intrinsic :: iso_C_binding
      integer(C_INT) :: get_number_atoms
    end function get_number_atoms

    !> Get the atom name of a particular atom.
    !!
    !! @param i The index of the atom.
    !! @return The name of the atom.
    subroutine get_atom_name (i, atom_name) bind(C)
      use, intrinsic :: iso_C_binding
      integer(C_INT), intent(in) :: i
      character(C_CHAR), intent(inout) :: atom_name
    end subroutine get_atom_name
  end interface

contains

  !> Parse the input file.
  !!
  !! @return A parser::control object.
  function parse_input (filename)

    type(control_t) :: parse_input
    character(len = *), intent(in) :: filename
    character(len = :), allocatable :: buffer
    integer :: i

    call log_debug("parsing input")
    call yyparse()
    call log_debug("done parsing")
    if(have_geometry() == 0) then
      call log_fatal("missing geometry")
    endif

    parse_input%geometry%number_atoms = get_number_atoms()
    allocate(parse_input%geometry%atom(parse_input%geometry%number_atoms))
    do i = 1, parse_input%geometry%number_atoms
      call get_atom_name(i, buffer)
      parse_input%geometry%atom(i)%atom_name = buffer
    enddo

  end function parse_input

  !> Print the geometry.
  !!
  !! @param G The geometry.
  subroutine print_geometry (G)

    use strings

    type(atomlist_t), intent(in) :: G
    integer :: i

    call log_info(to_string(G%number_atoms)//" atoms")
    do i = 1, G%number_atoms
      call log_info(G%atom(i)%atom_name)
    enddo

  end subroutine print_geometry

end module parser
