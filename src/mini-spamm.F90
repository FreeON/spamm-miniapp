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

  character(len = 1000) :: input_file
  type(control_t) :: control

  if(command_argument_count() /= 1) then
    call log_fatal("missing input file")
  endif

  call get_command_argument(1, input_file)
  control = parse_input(input_file)

end program mini_spamm
