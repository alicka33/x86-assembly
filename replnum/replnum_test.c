#include <stdio.h>
#include <string.h>

//extern "C" char* replnum(char *s, char a);

int main(void)
{
  //char text[] = "AzByCx: BEFORE _` and AFTER {|} and small again until the END.";
  //char expected[] = "ABC: BEFORE _`  AFTER {|}      END.";
  
  char text[] = "Ala 1 123 ala 45 a";
  char expected[] = "Ala & & ala & a";

  printf("Input string   > %s\n", text);
  char* result = replnum(text, '&');
  printf("Removal result > %s\n", result);
  
  if (strcmp(result, expected) != 0)
	  printf("Error in testcase #1.\n");

  return 0;
}