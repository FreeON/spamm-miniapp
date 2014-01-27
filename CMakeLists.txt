project( spamm-miniapp Fortran )
cmake_minimum_required( VERSION 2.8 )

add_subdirectory( spammpack )
add_subdirectory( src )

target_link_libraries( spamm spammpack )
