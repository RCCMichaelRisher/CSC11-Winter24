.global main

.section .data
    input: .word 0
.section .rodata
    outPrompt: .asciz "Enter a number to sum till: ";
    inPat:     .asciz "%d";
    outRes:    .asciz "Your sum is %d\n";
    debug:     .asciz "i = %d\n";

.text
main: //entry point
    push {lr}

    //prompt for input
    ldr r0, =outPrompt
    bl printf                   @ printf( outPrompt );
    //input
    ldr r0, =inPat
    ldr r1, =input 
    bl scanf                    @scanf( inPat, &input );

@ //loop addtion till n
    mov r4, #1 //counter        @ int i = 1; //counter r4
    mov r5, #0 //sum            @ int sum = 0; r5
    //reload input
    ldr r6, =input
    ldr r6, [r6]
    do:                             @ do {
        add r5, r4 //add r5, r5, r4     @ sum = sum + i;
        //debug print
        ldr r0, =debug
        mov r1, r4 //copy counter(r4) to r1 
        bl printf                       @ printf( debug, i );

        //add to counter
        add r4, #1                      @ i = i + 1;

        cmp r4, r6   //i <= input
        ble do //while its less than or equal to go back up to do
                                        @ } while ( i <= input );
//end do
    //print our sum
    ldr r0, =outRes
    mov r1, r5 //copy value of sum(r5) to r1 for printing
    bl printf                       @ printf( outRes, sum );

    mov r0, #0                      @ return 0;
    pop {pc}
