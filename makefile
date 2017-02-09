f:
	ifort -c timer_module.f90 $(LIBS)
	ifort -O0 -o timeme timeme.f90 timer_module.f90 $(LIBS)
	ifort -O0 -openmp -o timeme_openmp timeme_openmp.f90 timer_module.o $(LIBS)
	mpif90 -g -O0 -o mpiexample mpiexample.f90
	mpif90 -g -c -o timer_module_mpi.o timer_module.f90 $(LIBS)
	mpif90 -g -traceback -O0 -o timeme_mpi timeme_mpi.f90 timer_module_mpi.o $(LIBS)
	ifort -c papitime.f90  $(LIBS) -I/apps/papi/5.4.3/include/
	ifort -O0 -o timeme_papi timeme_papi.f90 papitime.o  -I/apps/papi/5.4.3/include/ -lpapi

c:
	gcc -std=c99 -o timeme timeme.c $(LIBS)

clean:
	rm -f *.o
	rm -f *.mod
