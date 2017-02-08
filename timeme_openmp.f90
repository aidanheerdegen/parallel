program multiply_matrices

  use timer
  use omp_lib

  implicit none

  real(kind=8), allocatable :: A(:, :)
  real(kind=8), allocatable :: B(:, :)
  real(kind=8), allocatable :: C(:, :)

  integer :: i, row, col

  real :: elapsed

  ! Allocate memory.
  allocate(A(1000, 1000))
  allocate(B(1000, 1000))
  allocate(C(1000, 1000))

  ! Fill A and B with random numbers.
  call random_number(A)
  call random_number(B)

  ! Initialise C to zero.
  C = 0.0

  call start_timer()
!$OMP PARALLEL DO DEFAULT(NONE) COLLAPSE(2) SHARED(A, B, C) PRIVATE(i, row, col)
  do i = 1, 1000
     do row = 1, 1000
        do col = 1, 1000
           C(col, row) = C(col, row) + A(col, i) * B(i, row)
        end do
     end do
  end do
!$OMP END PARALLEL DO
  elapsed = lap_time()
  write(*, *) "Call to calculate took",elapsed," seconds."

  ! Free memory.
  deallocate(C)
  deallocate(B)
  deallocate(A)

end program multiply_matrices
