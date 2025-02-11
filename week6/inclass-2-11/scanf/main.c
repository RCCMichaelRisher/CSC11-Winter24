#include <stdio.h>

int main(){
    float x;

    char *outPrompt = "Enter a floating point number: ";
    char *inFlt = "%f";
    char *outRes = "Entered: %f";

    printf( outPrompt );
    scanf( inFlt, &x );
    printf( outRes, x );
    return 0;
}