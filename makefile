c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	gfortran -openmp -o timeme timeme.f90 timer_module.f90 $(LIBS)
