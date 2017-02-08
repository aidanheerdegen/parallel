c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

f:
	ifort -O0 -o timeme timeme.f90 timer_module.f90 $(LIBS)
	ifort -O0 -openmp -o timeme_openmp timeme_openmp.f90 timer_module.f90 $(LIBS)
