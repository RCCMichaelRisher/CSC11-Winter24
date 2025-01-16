#include "stdio.h"


int main(){
	//find the area of a rectangle program
	int r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
	int width, length, area;

	//prompt the user width
	printf( "input the width: ");

	//input from the user
	scanf( "%d", &width );

	//prompt the user legnth
	printf( "Input the length: " );

	//input from user
	scanf( "%d", &length );

	//validate the data
	if( width < 0 ){
		printf( "need to enter a non-negative number for width\n" );
		return 0;
	}
	if( length < 0 ) {
		goto invalidLength;
invalidLength:
		printf( "need to enter a non-negative number for length\n");
		return 0;
	}
	//do the math
	//"load"  the value 
	r1 = width;
	r2 = length;
	r3 = r1 * r2;
	area = r3;

	//out put the answer
	//if square output that 
	if( r1 == r2 ) {
		goto square;
square:
		printf( "your shape is a square\n" );
	} else {
		printf( "your shape is a %s", "rectangle\n" );
	}
	printf( "Your area is %d\n", area );
	return 0;
}










































//end
