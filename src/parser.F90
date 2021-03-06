!> The parser interface module.
module parser

  use logging
  use control_class

  implicit none

  private

  public :: parse_input

  !> The C interface to the Bison parser.
  interface
    !> The interface to the Bison parser.
    !!
    !! @param length The string length of the filename.
    !! @param filename The filename.
    subroutine parse_input_file (length, filename) bind(C)
      use, intrinsic :: iso_C_binding
      integer(C_INT), intent(in) :: length
      character(C_CHAR), intent(in) :: filename
    end subroutine parse_input_file
  end interface

  !> The parsed control object. We keep this here so we can call back from the parser and modify it.
  type(control_t), pointer, save :: control_temp

contains

  !> Parse the input file.
  !!
  !! @todo Open input file, fold into stdin, and call yyparse()...
  !! @return A parser::control object.
  function parse_input (filename)

    type(control_t), pointer :: parse_input
    character(len = *), intent(in) :: filename
    character(len = :), allocatable :: buffer
    integer :: i

    allocate(control_temp)
    parse_input => control_temp
    call parse_input_file(len_trim(filename), trim(filename))

  end function parse_input

  subroutine parser_add_atom (name, x, y, z) bind(C, name = "parser_add_atom")

    use, intrinsic :: iso_C_binding
    use strings

    character(C_CHAR), intent(in) :: name(2)
    real(C_DOUBLE), intent(in) :: x, y, z
    character(len = 2) :: atom_name
    integer :: i

    atom_name = ""
    do i = 1, 2
      if(name(i) /= C_NULL_CHAR) then
        atom_name(i:i) = name(i)
      endif
    enddo

    call log_debug("adding "//trim(atom_name)//" at "// &
      to_string(x)//" "// &
      to_string(y)//" "// &
      to_string(z))
    call control_temp%add_atom(atom_name, [ x, y, z ])

  end subroutine parser_add_atom

end module parser
