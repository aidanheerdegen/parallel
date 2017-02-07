c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	mpif90 -o timeme timeme.f90 $(LIBS)

fmpi:

	mpif90 -o mpiexample mpiexample.f90
