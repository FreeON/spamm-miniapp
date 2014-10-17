!> The logging module.
module logging

  implicit none

contains

  subroutine log_fatal (msg)

    character(len = *), intent(in) :: msg

    write(*, "(A)") msg
    error stop

  end subroutine log_fatal

end module logging
