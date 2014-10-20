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
  subroutine print_geometry (self)

    use logging
    use strings

    class(control_t), intent(in) :: self
    integer :: i

    if(allocated(self%atoms)) then
      call log_always(to_string(size(self%atoms))//" atoms")
      do i = 1, size(self%atoms)
        call log_always(self%atoms(i)%name//" "// &
          to_string(self%atoms(i)%x(1))//" "// &
          to_string(self%atoms(i)%x(2))//" "// &
          to_string(self%atoms(i)%x(3)))
      enddo
    else
      call log_always("empty geometry")
    endif

  end subroutine print_geometry

  !> Print the control structure.
  !!
  !! @param self This object.
  subroutine print_control (self)

    class(control_t), intent(in) :: self

    call print_geometry(self)

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
    type(atom_t), allocatable :: atoms_temp(:)
    integer :: i

    if(.not. allocated(self%atoms)) then
      allocate(self%atoms(1))
    else
      allocate(atoms_temp(size(self%atoms)))
      do i = 1, size(self%atoms)
        atoms_temp(i)%name = self%atoms(i)%name
        atoms_temp(i)%x = self%atoms(i)%x
      enddo
      deallocate(self%atoms)
      allocate(self%atoms(size(atoms_temp)+1))
      do i = 1, size(atoms_temp)
        self%atoms(i)%name = atoms_temp(i)%name
        self%atoms(i)%x = atoms_temp(i)%x
      enddo
    endif
    self%atoms(size(self%atoms))%name = name
    self%atoms(size(self%atoms))%x = x

  end subroutine add_atom

end module control_class
