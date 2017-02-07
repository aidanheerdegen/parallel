module timer

  implicit none

  integer, save :: start(8)
  
contains

  subroutine start_timer()
    
    call date_and_time(values=start)

  end subroutine start_timer

  real function time_to_seconds(start,end)

    integer, intent(in) :: start(8)
    integer, intent(in) :: end(8)
  
    real, parameter :: to_s(4) = [3600.0, 60.0, 1.0, 0.001]
    
    time_to_seconds = sum(real(end(5:8) - start(5:8)) * to_s )

  end function time_to_seconds

  real function lap_time() 
    
    real :: lap_time
    integer :: current(8)

    call date_and_time(values=current)

    lap_time = time_to_seconds(start, current)

  end function lap_time

end module timer
