program multiply_matrices

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

  call timer()
  do i = 1, 1000
     do row = 1, 1000
        do col = 1, 1000
           C(col, row) = C(col, row) + A(col, i) * B(i, row)
        end do
     end do
  end do
  call timer(elapsed)
  write(*, *) "Call to calculate took",elapsed," seconds."

  ! Free memory.
  deallocate(C)
  deallocate(B)
  deallocate(A)

contains

  subroutine timer(elapsed)

    integer, save :: start(8) = 0.0
    integer, save :: end(8) = 0.0
    real, optional :: elapsed
    
    real, parameter :: to_s(4) = [3600.0, 60.0, 1.0, 0.001]
    
    if (present(elapsed)) then
       call date_and_time(values=end)
       elapsed = sum(real(end(5:8) - start(5:8)) * to_s )
    else
       call date_and_time(values=start)
    end if

  end subroutine timer

end program multiply_matrices
