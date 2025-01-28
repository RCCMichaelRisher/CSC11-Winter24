#include "stdio.h"


int main(){
    //ask input multiplier and multiplicand 
    int r0, r1, r2, r3, r4, r5;
    //pprompt
    printf( "enter 2 numbers to multiply (x x): ");
    //input
    scanf( "%d %d", &r1, &r2);

    //looping adding
    r0 = 0;
    r3 = r1; //make a unchanged copy of r1
    while( r1 >= 1 ){
        r0 = r0 + r2;
        r1 = r1 - 1;
    }

    printf( "%d x %d = %d\n", r3, r2, r0 );
}