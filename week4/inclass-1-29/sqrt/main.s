.global main
.global abs //absolute value
.global isqrt
.global getInput

.extern divMod

.section .rodata
    outPrompt: .asciz "Enter a number to approximate the square root: "
    inPat: .asciz "%d"
    debug: .asciz "guess %d is %d\n"
    outRes: .asciz "the approximate sqrt of %d is %d\n"
.section .data
    input: .word 0
.text //start the code section
main:
    push {lr}
    //prompt for a number to get the aprox sqrt
    //get the number
    bl getInput                 @ input = getInput();
    //that returns a value of input r0
    mov r4, r0
    //do the sqrt
    //getinput is in r0 & r4 so I dont need to move it to call isqrt
    bl isqrt                    @ int guess = isqrt( input );
    mov r2, r0

    //output 
    ldr r0, =outRes
    mov r1, r4
    //guess is in the right spot
    bl printf                   @ printf( "the approximate sqrt of %d is %d\n", input, guess );
    pop {pc}
//end main

//int getInput()
getInput:
    push {lr}
    giDo:                       @ do{  
    //prompt for a number to get the aprox sqrt
    ldr r0, =outPrompt
    bl printf                   @ printf( "Enter a number to approximate the square root: " );
    //get the number
    ldr r0, =inPat
    ldr r1, =input
    bl scanf                    @ scanf( "%d", &r1 );
    //load the value of input
    //I have to reload it since scanf wipes r0-r3
    ldr r0, =input
    ldr r0, [r0]
    cmp r0, #0
    ble giDo                    @ } while( r1 <= 0 );
    @ //load the value of input
    //since r0 is unmodified i can assume it is there still
    pop {pc}                    @ return r0;
//end getInput

//int isqrt( int input )
//r0 = input
isqrt:
    push {r4-r8,lr}
    //r4 = input
    //r5 = guess
    //r6 = prevGuess //previous guess so we can determine if we converge
    //r7 = t
    //r8 = i
    mov r4, r0 //move the input parameter to r4. a "safe" register
    lsr r5, r4, #1              @ int guess = input >> 1; //guess divided by 2 
 
    mov r8, #0                  @ int i = 0; //counter
    //formula
    //x_(n+1) = 1/2 ( x_n + input / x_n );
    isqrtDo:                    @ do{
        mov r6, r5                @ prevGuess = guess;

        //setup for divmod
        //r0 numerator
        //r1 denom
        mov r0, r4
        mov r1, r5
        bl divMod //performs the division and puts answer into r0 and a mod into r1
        mov r7, r0                @ int t = input / guess; //input / x_n
        
        add r7, r5, r7            @ t = guess + t; // ( x_n + input / x_n ) -> x_n + t

        //divide by 2
        lsr r7, r7, #1            @ t = t >> 1; // 1/2 ( x_n + input / x_n ) -> 1/2 (t)
        mov r5, r7                @ guess = t;

        //debug print
        ldr r0, =debug
        mov r1, r8 
        mov r2, r5
        bl printf                 @ printf( "guess %d is %d\n", i, guess );
        //printf will wipe r0-r3, lr

        add r8, #1                @ i = i + 1;

        //while math
        sub r0, r5, r6      //guess - prevGuess
        //run abs on the contect r0
        bl abs //it will give that result back into r0
        cmp r0, #0
        bgt isqrtDo               @ } while( abs( guess - prevGuess ) > 0 ); //abs(guess - prevguess) > 0 
    
    //return register is r0
    mov r0, r5 //move the value of guess to the return register
    pop {r4-r8,pc}                    @ return guess;
//end isqrt

//int abs( int x )
//r0 = x
abs:
    push {lr}
    //return ( x < 0 ) ? -x : x;
    cmp r0, #0
    bge absEnd
    rsb r0, r0, #0  // 0 - r0 = -r0
    absEnd:
    //return register is r0 already has my answer
    pop {pc}
//end abs
