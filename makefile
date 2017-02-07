c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	gfortran -o timeme timeme.f90 timer_module.f90 $(LIBS)

fmpi:

	mpif90 -o mpiexample mpiexample.f90
