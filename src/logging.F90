!> The logging module.
module logging

  implicit none

  !> Global constant for logging FATAL level messages.
  integer, parameter :: LOGLEVEL_FATAL = 0

  !> Global constant for logging INFO level messages.
  integer, parameter :: LOGLEVEL_INFO  = 1

  !> Global constant for logging DEBUG level messages.
  integer, parameter :: LOGLEVEL_DEBUG = 2

  !> The global log level.
  integer, private, save :: log_level = LOGLEVEL_FATAL

contains

  !> Set the global log level.
  !!
  !! @param level The log level
  subroutine set_log_level (level)

    integer, intent(in) :: level

    if(level < LOGLEVEL_FATAL) then
      call log_fatal("log level has to be >= 0")
    endif

    if(level > LOGLEVEL_DEBUG) then
      call log_fatal("log level has to be < 2")
    endif

    log_level = level

  end subroutine set_log_level

  !> Log a fatal error message. The program will terminate.
  !!
  !! @param msg The message.
  subroutine log_fatal (msg)

    character(len = *), intent(in) :: msg

    write(*, "(A)") "[FATAL] "//msg
    error stop

  end subroutine log_fatal

  !> Log a message.
  !!
  !! @param msg The message.
  subroutine log_always (msg)

    character(len = *), intent(in) :: msg

    write(*, "(A)") msg

  end subroutine log_always

  !> Log a INFO message.
  !!
  !! @param msg The message.
  subroutine log_info (msg)

    character(len = *), intent(in) :: msg

    if(log_level >= LOGLEVEL_INFO) then
      write(*, "(A)") "[INFO] "//msg
    endif

  end subroutine log_info

  !> Log a DEBUG message.
  !!
  !! @param msg The message.
  subroutine log_debug (msg)

    character(len = *), intent(in) :: msg

    if(log_level >= LOGLEVEL_DEBUG) then
      write(*, "(A)") "[DEBUG] "//msg
    endif

  end subroutine log_debug

end module logging
