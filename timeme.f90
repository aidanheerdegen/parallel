program multiply_matrices

  implicit none

  real(kind=8), allocatable :: A(:, :)
  real(kind=8), allocatable :: B(:, :)
  real(kind=8), allocatable :: C(:, :)

  integer :: i, row, col

  integer :: start(8)
  integer :: end(8)
  real :: elapsed

  real, parameter :: to_s(4) = [3600.0, 60.0, 1.0, 0.001]

  ! Allocate memory.
  allocate(A(1000, 1000))
  allocate(B(1000, 1000))
  allocate(C(1000, 1000))

  ! Fill A and B with random numbers.
  call random_number(A)
  call random_number(B)

  ! Initialise C to zero.
  C = 0.0


  call date_and_time(values=start)
  do i = 1, 1000
     do row = 1, 1000
        do col = 1, 1000
           C(col, row) = C(col, row) + A(col, i) * B(i, row)
        end do
     end do
  end do
  call date_and_time(values=end)

  elapsed = sum(real(end(5:8) - start(5:8)) * to_s )
  print *,start(5:8)
  print *,end(5:8)
  write(*, *) "Call to calculate took",elapsed," seconds."

  ! Free memory.
  deallocate(C)
  deallocate(B)
  deallocate(A)


end program multiply_matrices
