#include "stdio.h"
#include "math.h"

int main(){
    float a = 1.0000001f;
    float b = 1.0000002f;

    if( a == b ){
        printf( "equal\n");
    } else {
        printf( "not equal\n");
    }


    //what you usually do is have some delta
    float delta = 0.00001f;
    //if their difference is smaller than some delta we say they are equal
    if( fabs( a - b ) < delta ) {
        printf( "equal within delta\n" );
    } else {
        printf( "not equal in the delta\n" );
    }
    return 0;
}