project( spamm-miniapp Fortran )
cmake_minimum_required( VERSION 2.8 )

add_executable( spamm
  spamm.F90
  )

add_subdirectory( spammpack )

target_link_libraries( spamm spammpack )
