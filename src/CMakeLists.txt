add_executable( spamm
  spamm.F90
  )

target_link_libraries( spamm spammpack )

install( TARGETS spamm
  RUNTIME DESTINATION bin
  )