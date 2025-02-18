#include <stdio.h>
#include <string.h>

extern int remrep(char *s);

int main(void)
{
  
  char text[] = "CCCoomputer";
  char expected[] = "Computer";

  printf("Input string   > %s\n", text);
  int result = remrep(text);
  printf("Removal result > %s\n", text);

  printf("result: %d\n", result);
  
  if (strcmp(text, expected) != 0)
	  printf("Error in testcase #1.\n");

  return 0;
}