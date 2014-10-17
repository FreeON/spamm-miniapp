add_executable( mini-spamm
  logging.F90
  mini-spamm.F90
  parser.F90
  ${BISON_parser_OUTPUTS}
  ${FLEX_lexer_OUTPUTS}
  )

bison_target( parser parser.y parser.c )
flex_target( lexer lexer.l lexer.c )
add_flex_bison_dependency( lexer parser )

include_directories( ${CMAKE_CURRENT_BINARY_DIR} )

install( TARGETS mini-spamm
  RUNTIME DESTINATION bin
  )
