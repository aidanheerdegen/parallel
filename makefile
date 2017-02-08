c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	mpif90 -O0 -o timeme timeme.f90 $(LIBS)
	mpif90 -O0 -o timeme_mpi timeme_mpi.f90 $(LIBS)
	mpif90 -O0 -o mpiexample mpiexample.f90
