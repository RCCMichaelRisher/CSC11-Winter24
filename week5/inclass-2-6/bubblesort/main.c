#include "stdio.h"
#include "stdlib.h"
#include "time.h"

//bubble sort
void bubbleSort( int *a, int n ){
    int x = n - 1;
    for( int i = 0; i < x; i++ ){
        for( int j = 0; j < x; j++ ){
            if ( a[j] > a[j + 1] ){
                int temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
}

//input function
void input( int *a, int n ){
    //user input numbers
    // for( int i = 0; i < n; i++ ){
    //     printf( "Enter a[%d]: ", i+1 );
    //     scanf( "%d", &a[i] );
    // }
    //random numbers
    for( int i = 0; i < n; i++ ){
        a[i] = rand() % 90 + 10; //[10,99]
    }
}

//print function
void outArr( int *a, int n ){
    for( int i = 0; i < n; i++ ){
        printf( "%d ", a[i] );
    }
    printf( "\n" );
}

int main(){
    srand( time( 0 ) );
    int len = 5;
    int array[len];

    //input function
    input( array, len );
    printf( "Before sorting\n" );
    outArr( array, len );
    //sort function
    bubbleSort( array, len );
    //print function
    printf( "Sorted Array!\n" );
    outArr( array, len );

    return 0;
}