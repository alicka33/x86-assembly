#include <stdio.h>
#include <string.h>

//extern "C" char* removerng(char *s, char low, char high);

int main(void)
{
  //char text[] = "AzByCx: BEFORE _` and AFTER {|} and small again until the END.";
  //char expected[] = "ABC: BEFORE _`  AFTER {|}      END.";
  
  char text[] = "ala ma 23 koty.";
  char expected[] = "Ala Ma 23 Koty.";

  printf("Input string   > %s\n", text);
  char* result = capwords(text);
  printf("Removal result > %s\n", result);
  
  if (strcmp(result, expected) != 0)
	  printf("Error in testcase #1.\n");


  char text2[] = "122 44 ";
  char expected2[] = "122 44 ";

  printf("Input string   > %s\n", text2);
  char* result2 = capwords(text2);
  printf("Removal result > %s\n", result2);
  
  if (strcmp(result2, expected2) != 0)
	  printf("Error in testcase #2.\n");

    
  char text3[] = "    al al al ...";
  char expected3[] = "    Al Al Al ...";

  printf("Input string   > %s\n", text3);
  char* result3 = capwords(text3);
  printf("Removal result > %s\n", result3);
  
  if (strcmp(result3, expected3) != 0)
	  printf("Error in testcase #2.\n");

  return 0;
}