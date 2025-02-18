#include <stdio.h>
#include <string.h>

//extern "C" char* remnth(char *s, int n);

int main(void)
{
    char text[] = "Ala";
    char expected[] = "Aa";

    printf("Input string   > %s\n", text);
    char* result = remnth(text, 2);
    printf("Removal result > %s\n", result);

    if (strcmp(result, expected) != 0)    // string comparison
        printf("Error in testcase #1.\n");

    return 0;
}