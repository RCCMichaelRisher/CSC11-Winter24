#include <stdio.h>

int main(){
    int rDiv;
    int rMod;
    int increment;
    int decDenom;
    int denom;
    int numer;

    denom = 9;
    numer = 55;

    rDiv = 0;
    rMod = numer;
    increment = 1;
    decDenom = denom;

    do{
        decDenom <<= 1;  //denominator shift left
        increment <<= 1;  //incrementor shift left
    } while( rMod > decDenom ); //stop once we made a number bigger than the numerator

    decDenom >>= 1;  //denominator shift right
    increment >>= 1;  //incrementor shift right

    while( rMod >= decDenom ){
        rDiv += increment;
        rMod -= decDenom;
        while ( increment > 1 && decDenom > rMod ){
            increment >>= 1;
            decDenom >>= 1;
        }
    }

    printf( "%d / %d = %d\n", numer, denom, rDiv );
    printf( "%d %% %d = %d\n", numer, denom, rMod );
}