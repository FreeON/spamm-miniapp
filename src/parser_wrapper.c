/** The wrapper for the input file parser.
 */

#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

/** Parse the input.
 *
 * @param length The length of the filename.
 * @param filename The input file.
 */
void parse_input_file (const int *length, const char *filename)
{
  int fd;
  int i;
  char *new_filename;

  /* Terminate string. */
  new_filename = calloc(*length+1, sizeof(char));
  for(i = 0; i < *length; i++)
  {
    new_filename[i] = filename[i];
  }

  if((fd = open(new_filename, O_RDONLY)) < 0)
  {
    printf("can not open input file: %s\n", new_filename);
    exit(1);
  }

  if(dup2(fd, 0) != 0)
  {
    printf("can not redirect input file to stdin\n");
    exit(1);
  }

  yyparse();
}
