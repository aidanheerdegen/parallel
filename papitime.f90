module papitime

  implicit none

  include 'f90papi.h'

  private
  type, public :: timer_papi
     real(kind=4), private :: start
     real(kind=4)              :: real_time, proc_time, mflops
     integer                   :: rc
     integer(kind=8)           :: flpins
   contains
     procedure :: init
     procedure :: elapsed
     procedure :: print
  end type timer_papi

contains

  subroutine init(timer)

    class(timer_papi), intent(out) :: timer
    real(kind=4)              :: real_time, proc_time, mflops
    integer                   :: rc
    integer(kind=8)           :: flpins

    ! Implicit init of the PAPI library
    call PAPIf_flops(real_time, proc_time, flpins, mflops, rc)
    if (rc.ne.PAPI_OK) stop 'PAPI_flops failed.'
    timer%real_time = real_time
    timer%proc_time = proc_time
    timer%flpins = flpins
    timer%mflops = mflops

  end subroutine init

  subroutine elapsed(timer)
    class(timer_papi), intent(inout) :: timer
    real(kind=4)              :: real_time, proc_time, mflops
    integer                   :: rc
    integer(kind=8)           :: flpins
    ! Read out PAPI counters
    call PAPIf_flops(real_time, proc_time, flpins, mflops, rc)
    if (rc.ne.PAPI_OK) stop 'PAPI_flops failed.'
    timer%real_time = real_time
    timer%proc_time = proc_time
    timer%flpins = flpins
    timer%mflops = mflops

  end subroutine elapsed

  subroutine print(timer)

    class(timer_papi), intent(in) :: timer
    ! Print Timings
    print *, 'Real time', timer%real_time
    print *, 'Proc time', timer%proc_time
    print *, 'FP_INS'   , timer%flpins
    print *, 'MFLOP/s'  , timer%mflops

  end subroutine print

end module papitime
