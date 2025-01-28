#include <stdio.h>


int main(){
    int result = 0;
    int mulitplicand = 5;
    int multiplier = 3;

    while( mulitplicand > 0 ){
        if( mulitplicand & 1 ){
            result += multiplier;
        }

        multiplier <<= 1;

        mulitplicand >>= 1;
    }

    printf( "%d\n", result );
    return 0;
}