flex_target( lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.c )
bison_target( parser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.c )
add_flex_bison_dependency( lexer parser )

include_directories( ${CMAKE_CURRENT_BINARY_DIR} )

add_executable( mini-spamm
  ${BISON_parser_OUTPUTS}
  ${FLEX_lexer_OUTPUTS}
  control_class.F90
  logging.F90
  mini-spamm.F90
  parser.F90
  parser_wrapper.c
  strings.F90
  )

target_link_libraries( mini-spamm ${FLEX_LIBRARIES} )

set_target_properties( mini-spamm
  PROPERTIES
  COMPILE_DEFINITIONS "YYERROR_VERBOSE;YYDEBUG=$<BOOL:${PARSER_DEBUG}>"
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR} )

install( TARGETS mini-spamm
  RUNTIME DESTINATION bin
  )
