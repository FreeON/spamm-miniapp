add_executable( mini-spamm
  lexer.c
  logging.F90
  mini-spamm.F90
  parser.F90
  parser.c
  parser_wrapper.c
  strings.F90
  )

target_link_libraries( mini-spamm ${FLEX_LIBRARIES} )
set_target_properties( mini-spamm
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR} )

#bison_target( parser parser.y parser.c )
#flex_target( lexer lexer.l lexer.c )
#add_flex_bison_dependency( lexer parser )

if( PARSER_DEBUG )
  set( EXTRA_BISON_FLAGS "-t" )
endif()

add_custom_command( OUTPUT parser.c
  COMMAND ${BISON_EXECUTABLE} ${EXTRA_BISON_FLAGS} -o parser.c -v -d parser.y
  DEPENDS parser.y )
add_custom_command( OUTPUT lexer.c
  COMMAND ${FLEX_EXECUTABLE} -o lexer.c lexer.l
  DEPENDS lexer.l parser.c )

include_directories( ${CMAKE_CURRENT_BINARY_DIR} )

install( TARGETS mini-spamm
  RUNTIME DESTINATION bin
  )
