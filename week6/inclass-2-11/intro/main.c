#include "stdio.h"

int main(){
    float val1 = 3.14159;
    double val2 = 0.10;

    char *outRes = "The result is: %f\n";

    float s = val1 * val2;
    printf( outRes, s );
    return 0;
}