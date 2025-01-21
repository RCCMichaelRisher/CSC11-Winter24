#include "stdio.h"

int main(){
    int input;
    char *outPrompt = "Enter a number to sum till: ";
    char *inPat = "%d";
    char *outRes = "Your sum is %d\n";
    char *debug = "i = %d\n";

    //prompt
    printf( outPrompt );
    //input
    scanf( inPat, &input );

    //loop addiotn till n
    int sum = 0;
    for( int i = 1; i <= input; i++ ){
        sum = sum + i;
        printf( debug, i );
    }

    printf( outRes, sum );

    return 0;
}