#include <stdio.h>
void outputArr( int arr[], int size );
int main(){
    int a[25];
    //printf( "%x", &a );
    outputArr( a, 25 );

    for( int i = 0; i < 25; i++ ){
        a[i] = i;
    }

    outputArr( a, 25 );
    return 0;
}

void outputArr( int arr[], int size ){
    for( int i = 0; i < 25; i++ ){
        printf( "a[%d] = %d\n", i, arr[i] );
    }
}