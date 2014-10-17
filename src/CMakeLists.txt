add_executable( mini-spamm
  mini-spamm.F90
  )

install( TARGETS mini-spamm
  RUNTIME DESTINATION bin
  )
