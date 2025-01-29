#include "stdio.h"

int abs( int x ); //absolute value
int isqrt( int input );
int getInput();

int main(){
    int input;
    //prompt for a number to get the aprox sqrt
    //get the number
    input = getInput();

    //do the sqrt
    int guess = isqrt( input );

    //output 
    printf( "the approximate sqrt of %d is %d\n", input, guess );
}

int isqrt( int input ){
    int guess = input >> 1; //guess divided by 2 
    int prevGuess; //previous guess so we can determine if we converge

    int i = 0; //counter
    //x_(n+1) = 1/2 ( x_n + input / x_n );
    do{
        prevGuess = guess;
        int t = input / guess; //input / x_n
        t = guess + t; // ( x_n + input / x_n ) -> x_n + t
        t = t >> 1; // 1/2 ( x_n + input / x_n ) -> 1/2 (t)
        guess = t;
    printf( "guess %d is %d\n", i, guess );
        i = i + 1;
    } while( abs( guess - prevGuess ) > 0 ); //abs(guess - prevguess) > 0 

    return guess;
}

int getInput(){
    int r1;
    do{
        //prompt for a number to get the aprox sqrt
        printf( "Enter a number to approximate the square root: " );
        //get the number
        scanf( "%d", &r1 );
        //load the value of input
    } while( r1 <= 0 );
    //load the value of input
    return r1;
}

int abs( int x ){
    return ( x < 0 ) ? -x : x;
}