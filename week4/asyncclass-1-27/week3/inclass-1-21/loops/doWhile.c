#include "stdio.h"

int main(){
    //simple while 1-n summation
    int input;
    char *outPrompt = "Enter a number to sum till: ";
    char *inPat = "%d";
    char *outRes = "Your sum is %d\n";
    char *debug = "i = %d\n";

    //prompt for input
    printf( outPrompt );
    //input
    scanf( inPat, &input );

    //loop addtion till n
    int i = 1; //counter
    int sum = 0;
    do {
        sum = sum + i;
        printf( debug, i );
        i = i + 1;
    } while ( i <= input );

    printf( outRes, sum );
    return 0;
}