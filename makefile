c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	ifort -O0 -o timeme_papi timeme_papi.f90 papitime.f90  -I/apps/papi/5.4.3/include/ -lpapi
