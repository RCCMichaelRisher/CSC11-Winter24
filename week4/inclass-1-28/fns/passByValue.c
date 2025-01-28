#include "stdio.h"

//prototype of the function since it reads the main.c once and if i use a function
// before i declare it it will error out the compiler
void passByVal( int, int, int );

int main(){
    int a = 123;
    int b = 100;
    int c = 256;

    printf( "val1: %d\n", a );
    printf( "val2: %d\n", b );
    printf( "val3: %d\n", c );

    passByVal( a, b, c );

    printf( "val1: %d\n", a );
    printf( "val2: %d\n", b );
    printf( "val3: %d\n", c );
    return 0;
}

void passByVal( int a, int b, int c ){
    printf( "Passby Value fn\n\n" );
    int t = a + b;
    t = t + c;

    printf( "sum: %d\n", t );

    a = a + 1;
    b = b + 3;
    c = c - 4;

    printf( "val1: %d\n", a );
    printf( "val2: %d\n", b );
    printf( "val3: %d\n", c );
    printf( "End pass by val fn\n\n");

}