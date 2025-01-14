#include "stdio.h"


int main(){
    //ask for a number and add it by 32 

    int in;
    int r5 = 32;

    //output prompt
    printf( "%s", "Enter a number: " );

    //input from user
    //input a decimal value from the stdin (aka terminal in our case)
    //work similiarly to printf with format strings
    scanf( "%d", &in );

    //do the math
    int r2 = r5 + in;

    //output the result
    printf( "%d + 32 = %d\n", in, r2 ); //printf( r0, r1, r2, r3) 


    return 0;
}