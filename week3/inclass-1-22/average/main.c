#include "stdio.h"

int main(){
	//average 5 postivie numbers
	int input; //1 sum 1 input
	int sum = 0; 
	
	char *outPrompt = "Enter a postive number for n%d: ";
	char *inPat = "%d";
	char *outRes = "You're average is %d\n";
	
	//n1-n5
	for( int i = 0; i < 5; i++ ){
		do {
		//prompt input
		printf( outPrompt, i );
		//get input & validate
		scanf( inPat, &input );
		//once we input add it to the sum
		} while ( input < 0 );
		sum = sum + input;
	}


	//do the average (math)
	//multply by 1/5
	int average = sum * 0x334; //0x3 * 2^-12

	average = average >> 12; //undos that ^-4 from the step before

	//output the results
	printf( outRes, average );
	return 0;
}
