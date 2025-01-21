.global main

.section .data
    input: .word 0;
.section .rodata
    outPrompt: .asciz "Enter a number between 1-12: ";
    outRes:    .asciz "Your factorial is %d\n";
    inPat:     .asciz "%d";
    debug:     .asciz "current fact is %d\n"
.text //code starts here
main: 
    push {lr}

    //load input
    ldr r4, =input //loading into r4 because it is a safe register from printf & scanf 
    ldr r4, [r4]
    //valid this data 
    inputLoop:                                  @ while( input <= 0 || input > 12 ){
        cmp r4, #0
        ble getInput
        cmp r4, #13
        bgt getInput
        bal endInputLoop
        getInput:
            //prompt for input
            ldr r0, =outPrompt
            bl printf                           @ printf( outPrompt );
            //input
            ldr r0, =inPat
            ldr r1, =input
            bl scanf                            @ scanf( inPat, &input );
            //retrieve the value the user put in
            ldr r4, =input
            ldr r4, [r4]
            bal inputLoop //go back to inputLoop and test the data is valid
    endInputLoop:                               @ }


    mov r4, #1  //fact                      @ int fact = 1; //where im going to store the answer
    mov r5, #1 //counter i                  @ int i = 1; //counter 
    //load my input into r6
    ldr r6, =input
    ldr r6, [r6]
    //loop for the math
    mathLoop:                                   @ while( i <= input ){
        cmp r5, r6 // i(r5) > input(r6) when the loop should end
        bgt endMathLoop
        //do factorial
        mul r4, r4, r5                          @ fact = fact * i; //1 *2 *3 *....input
        //printf
        ldr r0, =debug
        mov r1, r4 //copy what fact(r4) is into r1 for printing
        bl printf

        add r5, r5, #1                          @ i = i + 1;
        bal mathLoop
    endMathLoop: @ }

    //output the result
    ldr r0, =outRes
    mov r1, r4 //move factorial(r4) to r1 for printing
    bl printf                                   @ printf( outRes, fact );

    mov r0, #0                                  @ return 0;
    pop {pc}
