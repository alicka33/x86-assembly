#include <stdio.h>
#include <string.h>

//extern "C" char* removerng(char *s, char low, char high);

int main(void)
{
  //char text[] = "AzByCx: BEFORE _` and AFTER {|} and small again until the END.";
  //char expected[] = "ABC: BEFORE _`  AFTER {|}      END.";
  
  char text[] = "Ala ma kota.";
  char expected[] = "lamakota";

  printf("Input string   > %s\n", text);
  char* result = leaverng(text, 'a', 'z');
  printf("Removal result > %s\n", result);
  
  if (strcmp(result, expected) != 0)
	  printf("Error in testcase #1.\n");

  return 0;
}