!> A module for string operations.
module strings

  implicit none

  !> The interface for converting things to strings.
  interface to_string
    module procedure :: int_to_string
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

end module strings
