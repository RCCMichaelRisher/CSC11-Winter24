#include "stdio.h"

int main(){
	//i want to write an even and odd tester

	int r0,r1,r2,r3,r4,r5;
	int value;
	//prompt, pattern, even, odd
	char *outPrompt = "Enter an number: ";
	char *inPat = "%d";
	char *outEven = "Your number %d is even\n";
	char *outOdd = "your number %d is odd\n";

	//i want prompt the user for a number
	printf( outPrompt );
	//input the number
	scanf( inPat, &value );

	//test the number
	//output odd or even
	if ( ( value & 1 ) == 0 ) {
		printf( outEven, value );
	} else {
		printf( outOdd, value );
	}
	
	return 0;
}
