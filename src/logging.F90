!> The logging module.
module logging

  implicit none

contains

  !> Log a fatal error message. The program will terminate.
  !!
  !! @param msg The message.
  subroutine log_fatal (msg)

    character(len = *), intent(in) :: msg

    write(*, "(A)") "[FATAL] "//msg
    error stop

  end subroutine log_fatal

  !> Log a INFO message.
  !!
  !! @param msg The message.
  subroutine log_info (msg)

    character(len = *), intent(in) :: msg

    write(*, "(A)") "[INFO] "//msg

  end subroutine log_info

  !> Log a DEBUG message.
  !!
  !! @param msg The message.
  subroutine log_debug (msg)

    character(len = *), intent(in) :: msg

    write(*, "(A)") "[DEBUG] "//msg

  end subroutine log_debug

end module logging
