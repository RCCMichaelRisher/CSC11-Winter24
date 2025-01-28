#include "stdio.h"

int factorial( int );

int main(){
    int n;
    
    do{
        //prompt for input
        printf( "Enter a number from 1-12: ");
        //input input 1-12
        scanf( "%d", &n );
    } while ( n < 0 || n > 12 );

    //do the factorial
    n = factorial( n );

    //output
    printf( "The factorial is %d\n", n );

    return 0;
}

int factorial( int n ){
    if( n == 0 ){
        return 1;
    }
    
    int t = n - 1;
    t = factorial( t );
    return n * t;
}
