program helloworld

  use mpi

  integer :: size, rank
  integer :: ierr

  call MPI_Init(ierr)
  call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)
  print *, "Hello from rank ",rank," of ",size
  call MPI_Finalize(ierr)

end program helloworld
