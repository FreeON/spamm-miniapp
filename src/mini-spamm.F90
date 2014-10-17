!> @mainpage A SpAMM mini-app
!!
!! @author    Nicolas Bock <nicolasbock@freeon.org>
!! @author    Matt Challacombe <matt.challacombe@freeon.org>
!! @copyright BSD
!! @date      2014

!> The front-end.
program mini_spamm

  use logging
  use parser

  implicit none

  if(command_argument_count() /= 1) then
    call log_fatal("missing input file")
  endif

end program mini_spamm
