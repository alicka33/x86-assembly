#include <stdio.h>
#include <string.h>

//extern "C" char* removerng(char *s, char low, char high);

int main(void)
{
  // TEST 1
  char text[] = "Computer Architecture Lab";
  unsigned int expected = 5;

  printf("Input string   > %s\n", text);
  unsigned int result = removeSmall(text);
  printf("Removal result > %d\n", result);
  
  if (result != expected)
	  printf("Error in testcase #1.\n");

  // TEST 2
  char text2[] = "abc";
  unsigned int expected2 = 0;

  printf("Input string   > %s\n", text2);
  unsigned int result2 = removeSmall(text2);
  printf("Removal result > %d\n", result2);
  
  if (result2 != expected2)
	  printf("Error in testcase #1.\n");
  
  // TEST 3
  char text3[] = "Ala ma KOTA ...";  //A  KOTA ...
  unsigned int expected3 = 11;

  printf("Input string   > %s\n", text3);
  unsigned int result3 = removeSmall(text3);
  printf("Removal result > %d\n", result3);
  
  if (result3 != expected3)
	  printf("Error in testcase #1.\n");

  return 0;
}