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

set( PARSER_DEBUG FALSE
  CACHE BOOL "Debug the input file parser" )

include( FindDoxygen )
if( DOXYGEN_FOUND )
  configure_file( Doxyfile.in Doxyfile )
  add_custom_target( doc
    COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_BINARY_DIR}/Doxyfile )
else()
  message( STATUS "Can not build documentation" )
endif()

if( NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE Debug )
endif()

if( CMAKE_Fortran_COMPILER_ID STREQUAL "GNU" )
  message( STATUS "Setting default GNU compiler flags" )
  set( CMAKE_C_FLAGS_DEBUG "-O0 -g" )
  set( CMAKE_Fortran_FLAGS_DEBUG "-O0 -g -fcheck=all" )
endif()

add_subdirectory( src )
