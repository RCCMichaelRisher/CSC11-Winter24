#include "stdio.h"

int main(){
    //simple while 1-n summation
    int input;
    char *outPrompt = "Enter a number to sum till: ";
    char *inPat = "%d";
    char *outRes = "Your sum is %d\n";

    //prompt for input
    printf( outPrompt );
    //input n
    scanf( inPat, &input );

    //loop addition till n
    int i = 1; //counter
    int sum = 0;
    while ( i <= input ){
        sum = sum + i;
        printf( "i = %d\n", i ); 
        i = i + 1;
    }
    //output the results
    printf( outRes, sum );

    return 0;
}