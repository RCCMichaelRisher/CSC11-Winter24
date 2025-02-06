#include "stdio.h"

int sum( int *a, int n );
void input( int *a, int n );
//the user gives me the 5 numbers
//sum all the numbers spit back a sum
int main(){
    printf( "Enter numbers for summing\n" );
    int len = 5;
    int a[len];
    input( a, len );

    int total = sum( a, len );

    printf( "The sum is %d\n", total );
    return 0;
}

int sum( int *a, int n ){
    int sum = 0;
    int i = 0;
    while ( i < n ){
        sum = sum + a[i];
        i = i + 1;
    }
    return sum;
}

void input( int *a, int n ){
    int i = 0;
    while( i < n ){
        printf( "Enter number %d: ", i+1 );
        scanf( "%d", &a[i] );
        i = i + 1;
    }
}