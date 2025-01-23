.global main

.section .data
    n1: .word 0
    n2: .word 0

.section .rodata
    outPrompt: .asciz "Enter 2 numbers to multiply (x x): "
    inPat: .asciz "%d %d"
    outRes: .asciz "%d x %d = %d\n"
.text //code section
main:
    push {lr}


    //prompt
    ldr r0, =outPrompt
    bl printf           @ printf( "enter 2 numbers to multiply (x x): ");
    //input
    ldr r0, =inPat
    ldr r1, =n1
    ldr r2, =n2
    bl scanf            @ scanf( "%d %d", &r1, &r2);

    //load the values from memory
    ldr r1, =n1
    ldr r1, [r1]
    ldr r2, =n2
    ldr r2, [r2]

    //looping adding
    mov r4, r1          @ r3 = r1; //make a unchanged copy of r1
    mov r0, #0          @ r0 = 0;
    
while:                  @ while( r1 >= 1 ){
    cmp r1, #1
    blt endLoop
    add r0, r0, r2      @ r0 = r0 + r2;
    sub r1, r1, #1      @ r1 = r1 - 1;
    bal while
endLoop:                 @ }

    //print the output
    mov r3, r0
    mov r1, r4
    //r2 is unmodified
    ldr r0, =outRes
    bl printf           @ printf( "%d x %d = %d\n", r3, r2, r0 );

    mov r0, #0
    pop {pc}
