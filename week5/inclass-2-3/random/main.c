#include "stdio.h"
#include "stdlib.h"  //rand function
#include "time.h"  //srand, time function


int main(){ 
    //seed to make the random number better
    srand( time(0) );  //I put the time as the seed

    for( int i = 0; i < 20; i++ ){
        //if i want 0-90 then it is just rand % 90
        int a = rand() % 90 + 10; //inclusive 10-99 
        printf( "%d\n", a );

    }
}


