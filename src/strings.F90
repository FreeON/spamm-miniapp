!> A module for string operations.
module strings

  implicit none

  !> The interface for converting things to strings.
  interface to_string
    module procedure :: int_to_string
    module procedure :: double_to_string
  end interface to_string

contains

  !> Convert an integer to a string.
  !!
  !! @param i The integer.
  !!
  !! @return The string representation.
  function int_to_string (i)

    character(len = :), allocatable :: int_to_string
    character(len = 100) :: buffer
    integer, intent(in) :: i

    write(buffer, "(I100)") i
    int_to_string = trim(adjustl(buffer))

  end function int_to_string

  !> Convert a double to a string.
  !!
  !! @param x The double.
  !!
  !! @return The string representation.
  function double_to_string (x)

    character(len = :), allocatable :: double_to_string
    character(len = 100) :: buffer
    real(kind(0d0)), intent(in) :: x

    write(buffer, "(ES20.10E3)") x
    double_to_string = trim(adjustl(buffer))

  end function double_to_string

end module strings
