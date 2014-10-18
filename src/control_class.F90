!> Module controlling the behavior of the app.
module control_class

  implicit none

  !> The atom type.
  type :: atom_t

    !> The atom name.
    character(len = 2) :: name

    !> The atom position.
    real(kind(0d0)) :: x(3)

  end type atom_t

  !> The main control structure.
  type :: control_t

    !> The system geometry.
    type(atom_t), allocatable :: atoms(:)

  contains

    procedure, pass :: print => print_control
    procedure, pass :: add_atom => add_atom

  end type control_t

contains

  !> Print the geometry.
  subroutine print_geometry ()

    use strings

  end subroutine print_geometry

  !> Print the control structure.
  !!
  !! @param self This object.
  subroutine print_control (self)

    use logging

    class(control_t), intent(in) :: self

    call log_info("control")

  end subroutine print_control

  !> Add an atom to the geometry.
  !!
  !! @param self This object.
  !! @param name The atom name (2 character char array).
  !! @param x Position, x-component.
  !! @param y Position, y-component.
  !! @param z Position, z-component.
  subroutine add_atom (self, name, x, y, z)

    use, intrinsic :: iso_C_binding

    class(control_t), intent(inout) :: self
    character(C_CHAR), dimension(2), intent(in) :: name
    real(C_DOUBLE), intent(in) :: x, y, z

  end subroutine add_atom

end module control_class
