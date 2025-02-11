#include <stdio.h>


int main(){

    float x = 0.0;
    float y = 2.35;
    float z = -9.87654;
    float w = 4.56123;

    char *outPrompt = "Enter a number: ";
    char *inFlt = "%f";
    char *outRes = "Value entered was %f; (y=%f, z=%f, w=%f). The sum is %f\n";

    //get user input
    printf( outPrompt );
    scanf( inFlt, &x );

    float sum = x + y;
    sum = sum + z;
    sum = sum + w;

    printf( outRes, x, y, z, w, sum );
    return 0;
}