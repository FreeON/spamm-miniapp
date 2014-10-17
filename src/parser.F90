!> The parser interface module.
module parser

  implicit none

  type control_t
    integer :: i
  end type control_t

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
  function parse_input (filename)

    type(control_t) :: parse_input
    character(len = *), intent(in) :: filename

    call yyparse()

  end function parse_input

end module parser
