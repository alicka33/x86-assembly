#include <stdio.h>
#include <string.h>

//extern "C" char* removerng(char *s, char low, char high);

int main(void)
{
  //char text[] = "AzByCx: BEFORE _` and AFTER {|} and small again until the END.";
  //char expected[] = "ABC: BEFORE _`  AFTER {|}      END.";
  
  char text[] = "abc123ab";
  char expected[] = "bac123ba";

  printf("Input string   > %s\n", text);
  char* result = reverselet(text);
  printf("Removal result > %s\n", result);
  
  if (strcmp(result, expected) != 0)
	  printf("Error in testcase #1.\n");

  return 0;
}