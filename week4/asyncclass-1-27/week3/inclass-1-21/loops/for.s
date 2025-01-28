.global main

.section .data
    input: .word 0
.section .rodata
    outPrompt: .asciz "Enter a number to sum till: ";
    inPat:     .asciz "%d";
    outRes:    .asciz "Your sum is %d\n";
    debug:     .asciz "i = %d\n";
.text
main:
    push {lr}

    //prompt
    ldr r0, =outPrompt
    bl printf                                   @ printf( outPrompt );

    //input
    ldr r0, =inPat
    ldr r1, =input
    bl scanf                                    @ scanf( inPat, &input );

    //loop addiotn till n
    mov r5, #0                                  @ int sum = 0;
    //load my input
    ldr r6, =input
    ldr r6, [r6] //ldr from address in r6

    mov r4, #1 //i = 1
for:    @ for( int i = 1; i <= input; i++ ){
    cmp r4, r6 //i <= input
    bgt endFor //i > input i need to end the loop

    //stuff in the middle of for
    add r5, r5, r4                              @ sum = sum + i;
    //debug print
    ldr r0, =debug
    mov r1, r4 //copy i to r1
    bl printf                                   @ printf( debug, i );

    //increment as part of the for loop
    add r4, #1 //i++
    bal for
endFor:                                         @ }

    ldr r0, =outRes
    mov r1, r5 
    bl printf                                   @ printf( outRes, sum );

    mov r0, #0                                  @ return 0;
    pop {pc}
