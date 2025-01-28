.global main

.section .data //var, init
	sum: .word 0
.section .rodata
	outPrompt: .asciz "Enter a postive number for n%d: "
	inPat: .asciz "%d"
	outRes: .asciz  "You're average is %d\n"
.section .bss //vars, uninit
	input: .space 4

.text //code begins
main: 
	push {lr}


	//average 5 postivie numbers
	//n1-n5
	//load sum into r5
	ldr r6, =sum //address
	//i counter
	mov r4, #0 //put i into a "function safe" register
	inputLoop: 				@ for( int i = 0; i < 5; i++ ){
		ldr r5, [r6] //put the value of sum into r5 and keep the address in r6
		cmp r4, #5
		bge endInputLoop//the loop ends when i >= 5
			validDo: 		@ do {
				//prompt input
				ldr r0, =outPrompt
				mov r1, r4 //copies i(r4) into r1 for printing
				add r1, #1
				bl printf	@ printf( outPrompt, i );

				//get input & validate
				ldr r0, =inPat
				ldr r1, =input
				bl scanf	@ scanf( inPat, &input );
				//load input to get the value to test if its valid
				ldr r1, =input
				ldr r1, [r1]
				//compare stuff
				cmp r1, #0
				blt validDo
			endValidDo:		@ } while ( input < 0 );
			//once we input & validate add it to the sum
			add r5, r1 		@ sum = sum + input;
			//store that new sum in r5 back into the memorylocation
			str r5, [r6] //storing the sum in r5 into the address of sum in r6
		add r4, r4, #1  //i++ at the edn of the for loop
		bal inputLoop //go back and do looping
	endInputLoop: 				@ }

	//do the average (math)
	//multply by 1/5
	mov r3, #0x334 //could also be ldr r3, =#0x334
	//load sum into r2
	ldr r2, =sum
	ldr r2, [r2]
	//now i can mult
	mul r2, r2, r3				@ int average = sum * 0x334; //0x3 * 2^-12

	//Logical Shift Right = lsr
	lsr r2, r2, #12 			@ average = average >> 12; //undos that ^-4 from the step before

	//output the results
	ldr r0, =outRes
	mov r1, r2 //move our average we had in r2
	bl printf 				@ printf( outRes, average );

	mov r0, #0				@ return 0;
	pop {pc}

