#include <stdio.h>
#include <string.h>

//extern "C" char* removerng(char *s, char low, char high);

int main(void)
{
  //char text[] = "AzByCx: BEFORE _` and AFTER {|} and small again until the END.";
  //char expected[] = "ABC: BEFORE _`  AFTER {|}      END.";
  
  char text[] = "abc123 98";
  unsigned int expected = 123;

  printf("Input string   > %s\n", text);
  unsigned int result = getdec(text);
  printf("Removal result > %d\n", result);
  
  if (result != expected)
	  printf("Error in testcase #1.\n");

  return 0;
}