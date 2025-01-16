.global main

.section .bss
	value: .space 4 //4 bytes of space since its is a 32bit  number
.section .rodata
	outPrompt: .asciz "Enter an number: "
        inPat: .asciz "%d"
        outEven: .asciz "Your number %d is even\n"
        outOdd: .asciz "your number %d is odd\n"
.text
main:
	push {lr} //where i came from

	//i want prompt the user for a number
        ldr r0, =outPrompt
	bl printf				//printf( outPrompt );

        //input the number
	ldr r0, =inPat
	ldr r1, =value
	bl scanf				//scanf( inPat, &value );

        //test the number
	//load the number from memory
	ldr r1, =value //address of value
	ldr r1, [r1]  //load the value from address

	//and r2, r1, #1 	//and with 1 first
	//cmp r2, #0				//if ( ( value & 1 ) == 0 ) {
	tst r1, #1
	beq even
	bne odd
        //output odd or even
even:
	//setup even printf
	ldr r0, =outEven
	//so since we were smart about not overwriting r1 we dont need reload/move it for the printf
	bl printf 				//printf( outEven, value );
	bal end
odd:
    	ldr r0, =outOdd
	//so since we were smart about not overwriting r1 we dont need reload/move it for the printf
	bl printf				//printf( outOdd, value );
end:
	mov r0, #0 // return 0
	pop {lr} //another variant of the pop {pc}
	bx lr
