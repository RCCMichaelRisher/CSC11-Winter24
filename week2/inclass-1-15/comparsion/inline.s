.global main

.section .data //var, init
    input: .word 0
.section .rodata //readonly
    outPrompt: .asciz "Enter a number: "
    inPat: .asciz "%d"
    outStr: .asciz "r2: %d\n"


.text //code begins
main:
    push {lr}//where i was

    //set up printf
    ldr r0, =outPrompt
    bl printf                       @ printf( "Enter a number: " );

    //get input
    ldr r0, =inPat
    ldr r1, =input
    bl scanf                        @ scanf( "%d", &r0 );

    //extract input from memory
    ldr r0, =input //address
    ldr r0, [r0]

    //compare input(r0) with 0
    //compare by subtracting the 2 values
    cmp r0, #0                      @ if( r0 < 0 ){

    //so i know that r2 will be 0 or 60
    //so set r2 to 0 
    movge r2, #0
    movlt r2, #60  //if (r0<0) r2 = 60

    //print the result
    ldr r0, =outStr
    mov r1, r2 //need to follow the order (r0, r1, r2, r3) for functions
    bl printf                       @ printf( "r2: %d\n", r2 );

    mov r0, #0                      @ return 0;
    pop {pc}
@ } end of main
