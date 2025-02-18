#include <stdio.h>
#include <string.h>

extern unsigned int removeSmallLetters(char *s);

int main(void)
{
  // TEST 1
  char text[] = "Computer Architecture Lab";
  unsigned int expected = 5;

  printf("Input string   > %s\n", text);
  unsigned int result = removeSmallLetters(text);
  printf("Removal result > %d\n", result);
  
  if (result != expected)
	  printf("Error in testcase #1.\n");

  // TEST 2
  char text2[] = "abc";
  unsigned int expected2 = 0;

  printf("Input string   > %s\n", text2);
  unsigned int result2 = removeSmallLetters(text2);
  printf("Removal result > %d\n", result2);
  
  if (result2 != expected2)
	  printf("Error in testcase #2.\n");
  
  // TEST 3
  char text3[] = "Ala ma KOTA ...";  //A  KOTA ...
  unsigned int expected3 = 11;

  printf("Input string   > %s\n", text3);
  unsigned int result3 = removeSmallLetters(text3);
  printf("Removal result > %d\n", result3);
  
  if (result3 != expected3)
	  printf("Error in testcase #3.\n");

  // TEST 4
  char text4[] = "123alaALA!";
  unsigned int expected4 = 7;

  printf("Input string   > %s\n", text4);
  unsigned int result4 = removeSmallLetters(text4);
  printf("Removal result > %d\n", result4);
  
  if (result4 != expected4)
	  printf("Error in testcase #4.\n");

  return 0;
}