!> The parser interface module.
module parser

  implicit none

  type control
    integer :: i
  end type control

  !> The C interface to the Bison parser.
  interface
    subroutine yyparse () bind(C)
      use, intrinsic :: iso_C_binding
    end subroutine yyparse
  end interface

contains

  !> Parse the input file.
  !!
  !! @return A parser::control object.
  function parse_input ()

    type(control) :: parse_input

  end function parse_input

end module parser
