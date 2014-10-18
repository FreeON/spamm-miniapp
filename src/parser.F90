!> The parser interface module.
module parser

  use logging

  implicit none

  !> The C interface to the Bison parser.
  interface
    !> The interface to the Bison parser.
    subroutine yyparse () bind(C)
      use, intrinsic :: iso_C_binding
    end subroutine yyparse
  end interface

contains

  !> Parse the input file.
  !!
  !! @todo Open input file, fold into stdin, and call yyparse()...
  !! @return A parser::control object.
  function parse_input (filename)

    use control_class

    type(control_t) :: parse_input
    character(len = *), intent(in) :: filename
    character(len = :), allocatable :: buffer
    integer :: i

    call yyparse()

  end function parse_input

end module parser
