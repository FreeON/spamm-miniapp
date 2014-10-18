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
    procedure, pass :: set => set

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
  !! @param name The atom name (2 character limit).
  !! @param x Position vector.
  subroutine add_atom (self, name, x)

    class(control_t), intent(inout) :: self
    character(len = 2), intent(in) :: name
    real(kind(0d0)), intent(in) :: x(3)

  end subroutine add_atom

  !> Set the control object to another one (deep copy).
  !!
  !! @todo Implement.
  !! @param self This object.
  !! @param c The control object to copy.
  subroutine set (self, c)

    class(control_t), intent(inout) :: self
    type(control_t), intent(in) :: c

  end subroutine set

end module control_class
