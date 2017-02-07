program multiply_matrices

  use timer

  implicit none

  real(kind=8), allocatable :: A(:, :)
  real(kind=8), allocatable :: B(:, :)
  real(kind=8), allocatable :: C(:, :)

  integer :: i, row, col

  real :: elapsed

  integer event_set ! For papi
  integer*8 values(50) !For reading papi values

  ! Allocate memory.
  allocate(A(1000, 1000))
  allocate(B(1000, 1000))
  allocate(C(1000, 1000))

  ! Fill A and B with random numbers.
  call random_number(A)
  call random_number(B)

  ! Initialise C to zero.
  C = 0.0

  call papi_lib_init  ! *Not shown, but is present and works. *
  call papi_add_events(event_set)

  do i = 1, 1000
     do row = 1, 1000
        do col = 1, 1000
           C(col, row) = C(col, row) + A(col, i) * B(i, row)
        end do
     end do
  end do

  call papi_stop_counting(event_set, values)
  print *, 'Value 1: ', values(1)
  print *, 'Value 2: ', values(2)

  ! Free memory.
  deallocate(C)
  deallocate(B)
  deallocate(A)

end program multiply_matrices
