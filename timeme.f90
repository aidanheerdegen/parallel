program multiply_matrices

  use mpi

  implicit none

  integer :: size, rank
  integer :: ierr

  integer, parameter :: N = 1000

  real(kind=8), allocatable :: A(:, :)
  real(kind=8), allocatable :: B(:, :)
  real(kind=8), allocatable :: C(:, :)

  integer :: i, row, col
  real :: elapsed

  integer :: chunk_size, chunk_start

  integer :: i_start, i_end

  call MPI_Init(ierr)
  call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

  chunk_size = N / size

  i_start = 1 + rank*chunk_size
  i_end   = min(i_start + chunk_size - 1,N)

  ! Allocate memory.
  allocate(A(N, N))
  allocate(B(N, N))
  allocate(C(N, N))

  if (rank == 1) then

     ! Fill A and B with random numbers.
     call random_number(A)
     call random_number(B)

  end if

  ! Broadcast arrays
  call mpi_bcast(A, N*N, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)
  call mpi_bcast(B, N*N, MPI_DOUBLE_PRECISION, 0, MPI_COMM_WORLD, ierr)

  ! Initialise C to zero.
  C = 0.0

  print *, "Hello from rank ",rank," of ",size
  print *,i_start,i_end

  do i = i_start, i_end
     do row = 1, N
        do col = 1, N
           C(col, row) = C(col, row) + A(col, i) * B(i, row)
        end do
     end do
  end do

  ! Gather results
  IF (rank == 0) THEN
     call mpi_reduce(MPI_IN_PLACE, C, N*N, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
  ELSE
     call mpi_reduce(C, C, N*N, MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
  END IF

  ! Free memory.
  deallocate(C)
  deallocate(B)
  deallocate(A)

  call MPI_Finalize(ierr)

end program multiply_matrices
