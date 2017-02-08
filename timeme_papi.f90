program multiply_matrices

  use papitime

  implicit none

  real(kind=8), allocatable :: A(:, :)
  real(kind=8), allocatable :: B(:, :)
  real(kind=8), allocatable :: C(:, :)

  integer :: i, row, col

  type(timer_papi) :: timer

  ! Allocate memory.
  allocate(A(1000, 1000))
  allocate(B(1000, 1000))
  allocate(C(1000, 1000))

  ! Fill A and B with random numbers.
  call random_number(A)
  call random_number(B)

  ! Initialise C to zero.
  C = 0.0

  call timer.init()

  do i = 1, 1000
     do row = 1, 1000
        do col = 1, 1000
           C(col, row) = C(col, row) + A(col, i) * B(i, row)
        end do
     end do
  end do

  call timer.elapsed()
  call timer.print()

  ! Free memory.
  deallocate(C)
  deallocate(B)
  deallocate(A)

end program multiply_matrices
