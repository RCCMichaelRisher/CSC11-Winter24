.global main

.section .data //variable data
	width: .word 0
	length: .word 0
.section .rodata //constant strings
	outWPrompt: .asciz "input the width: "
	outLPrompt: .asciz "Input the length: "
	inPat: .asciz "%d"
	outInvalidW: .asciz  "need to enter a non-negative number for width\n"
	outInvalidL: .asciz "need to enter a non-negative number for length\n"
	outResult: .asciz "Your area is %d\n"
	outSquare: .asciz "your shape is a square\n"
	outRect: .asciz "your shape is a rectangle\n"
.section .bss //variable non-init
	area: .space 4  //give me space for 4 bytes
.text //code begins now
main:
	push {lr} //where we came from

        //find the area of a rectangle program
        //prompt the user width

	ldr r0, =outWPrompt
	bl printf 				//printf( "input the width: ");

        //input from the user
        ldr r0, =inPat
	ldr r1, =width
	bl scanf				//scanf( "%d", &width );

        //prompt the user legnth
	ldr r0, =outLPrompt
	bl printf 				//printf( "Input the length: " );

        //input from user
	ldr r0, =inPat
	ldr r1, =length
	bl scanf				//scanf( "%d", &length );


        //"load"  the value
	ldr r1, =width //gets the address
	ldr r1, [r1] 	//gets the value from the address	//        r1 = width;


	ldr r2, =length	//get address
	ldr r2, [r2] 	//get the val from address	//        r2 = length;

        //validate the data
	cmp r1, #0 					//if( width < 0 ){
	blt invalidWidth   //branch if less than

	cmp r2, #0					//if( length < 0 ) {
	blt invalidLength   //branch if less than

        //do the math
	//its safe to assume that r1,r2 are width and length still since the printf that ran in the invalid labels would end the program
	mul r3, r1, r2 					//r3 = r1 * r2;

	//store that into area
	ldr r4, =area //load the address for area first
	str r3, [r4]  //store the contents of r3 into r1	//area = r3;

	//check if the shape is a square
	//r1 width, r2 length
	cmp r1, r2
	beq square  //branch if equal
	bne rect    //branch if not equal
square:
	//set the printf for square
	ldr r0, =outSquare
	bl printf
	bal outputArea //if i dont do  this it will run the print for a rectangle too 
rect:
	//setup the printf for rect
	ldr r0, =outRect
	bl printf
outputArea:
        //output the answer
	ldr r0, =outResult
	ldr r1, [r4] //since r4 is my area address from line 63 i can just load it from it like this
	bl printf						//printf( "Your area is %d\n", area );
        
	bal end

invalidWidth:
	ldr r0, =outInvalidW
	bl printf					//printf( "need to enter a non-negative number for width\n" );
	bal end
invalidLength:
	ldr r0, =outInvalidL
	bl printf					//printf( "need to enter a non-negative number for length\n");
	bal end
end:
	mov r0, #0 //return 0
	pop {pc} //where we go back to
