#include "stdio.h"

int multby5( int a );
int getInput();
void output( int in, int res );

int main(){
    int r3,r4;
    //prompt for number 
    //get the number
    r4 = getInput();
    //do the * 5 to the number
    r3 = multby5( r4 );
    //output the number
    output( r4, r3 );
    return 0;
}

void output( int in, int res ){
    printf( "%d x 5 = %d\n", in, res );
    return;
}

int multby5( int a ){
    int b = a;
    a = a << 2; //multiple by 4
    a += b; //adds the last mult by 5
    return a;
}

int getInput(){
    int r1;
    //prompt for a number
    printf( "Enter a number to multiply by 5: " );
    //get the number
    scanf( "%d", &r1);

    //load the value
    return r1;
}