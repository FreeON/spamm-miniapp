project( spamm-miniapp Fortran C )
cmake_minimum_required( VERSION 2.8 )

include( FindFLEX )
if( NOT FLEX_FOUND )
  message( FATAL_ERROR "I need the flex lexer" )
endif()

include( FindBISON )
if( NOT BISON_FOUND )
  message( FATAL_ERROR "I need the bison parser generator" )
endif()

include( FindDoxygen )
if( DOXYGEN_FOUND )
  configure_file( Doxyfile.in Doxyfile )
  add_custom_target( doc
    COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_BINARY_DIR}/Doxyfile )
endif()

add_subdirectory( src )
