  
subroutine api_lib_init()

  call PAPIF_num_counters(check)
  call PAPIF_start_counters(*events, array_length, check)

end subroutine api_lib_init
 
subroutine papi_add_events(event_set)
  integer, intent(inout) :: event_set
  include 'f77papi.h'
  !     create the eventset
  integer check             
  integer*8 event_code

  event_set = PAPI_NULL
  call PAPIF_create_eventset(event_set, check)
  if (check .ne. PAPI_OK) then
     print *, 'Error in subroutine PAPIF_create_eventset'
     call abort
  end if
  !event_code = PAPI_L1_DCM  ! Total L1 Data Cache misses
  call PAPIF_event_name_to_code('PAPI_FP_INS', event_code, check)
  if (check .NE. PAPI_OK) then
     print *, 'Abort After PAPIF_event_name_to_code: ', check
     call abort
  endif
  call PAPIF_add_event(event_set, event_code, check)
  if (check .NE. PAPI_OK) then
     print *, 'Abort PAPIF_add_events1: ', check, ' ', event_code
     call abort
  endif
  !event_code = PAPI_MEM_RCY ! Cycle stalled waiting for memory reads
  call PAPIF_event_name_to_code('PAPI_TOT_CYC', event_code, check)
  call PAPIF_add_event(event_set, event_code, check)
  if (check .NE. PAPI_OK) then
     print *, 'Abort PAPIF_add_events2: ', check, ' ', event_code
     call abort
  endif

  call PAPIF_start(event_set, check)
  if(check .ne. PAPI_OK) then
     print *, 'Abort after PAPIF_start: ', check
     call abort
  endif

end subroutine papi_add_events

subroutine papi_stop_counting(event_set, values)
  integer, intent(in) :: event_set
  integer*8, intent(inout) :: values(*) !shows an array

  !     Local variable integer check
  include 'f77papi.h'      

  !     stop counting
  call PAPIF_stop(event_set, values(1), check) !*Not sure if it should be values(1) or values*
  if (check .ne. PAPI_OK) then
      print *, 'Abort after PAPIF_stop: ', check
      call abort
  endif

end subroutine papi_stop_counting
