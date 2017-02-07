c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	gfortran -o timeme timeme.f90 papitime.f90 -I/apps/papi/5.4.3/include/ $(LIBS)
