#include "stdio.h"

int main(){
    //factorial with number validation from 1 to 12
    char *outPrompt = "Enter a number between 1-12: ";
    char *outRes = "Your factorial is %d\n";
    char *inPat = "%d";
    int input = 0;

    //valid this data 
    while( input <= 0 || input > 12 ){
        //prompt for input
        printf( outPrompt );
        //input
        scanf( inPat, &input );
    }

    int fact = 1; //where im going to store the answer
    int i = 1; //counter 

    //loop for the math
    while( i <= input ){
        fact = fact * i; //1 *2 *3 *....input
        i = i + 1;
    }

    //output the result
    printf( outRes, fact );

    return 0;
}
