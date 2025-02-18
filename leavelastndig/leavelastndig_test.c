#include <stdio.h>
#include <string.h>

//extern "C" char* leavelastndig(char *s, int n);

int main(void)
{
  char text[] = "Ala ma KOTA";
  char expected[] = "KOTA";
  int n = 4;

  printf("Input string   > %s\n", text);
  char* result = leavelastndig(text, n);
  printf("Removal result > %s\n", result);
  
  if (strcmp(result, expected) != 0)
	  printf("Error in testcase #1.\n");

  return 0;
}