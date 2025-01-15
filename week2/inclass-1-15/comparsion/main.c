#include "stdio.h"


int main(){
    int r0 = 0;
    int r2;

    printf( "Enter a number: " );
    scanf( "%d", &r0 );

    if( r0 < 0 ){
        r2 = 60;
    } else {
        r2 = 0;
    }

    printf( "r2: %d\n", r2 );

    return 0;
}