#include "stdio.h"
//* mean its an address
void passByRef( int*, int*, int* );

int main(){
    int val1 = 123;
    int val2 = 456,
    val3 = 256;

    printf( "Before passbyref function\n");
    printf( "val1: %d\n", val1 );
    printf( "val2: %d\n", val2 );
    printf( "val2: %d\n", val3 );

    passByRef( &val1, &val2, &val3 ); 

    printf( "After passbyref function\n");
    printf( "val1: %d\n", val1 );
    printf( "val2: %d\n", val2 );
    printf( "val2: %d\n", val3 );
    return 0;
}

void passByRef( int *a1, int *a2, int *a3 ){
    printf( "In passByRef function\n" );
    int v1 = *a1;
    int v2 = *a2;
    int v3 = *a3;

    int t = v1 + v2;
    t = t + v3;

    v1 = v1 + 5;
    v2 = v2 + 10;
    v3 = v3 * 2;

    *a1 = v1;
    *a2 = v2;
    *a3 = v3; 
    
    printf( "sum is:%d\n", t );
    printf( "val1: %d\n", v1 );
    printf( "val2: %d\n", v2 );
    printf( "val2: %d\n", v3 );
    return;
}