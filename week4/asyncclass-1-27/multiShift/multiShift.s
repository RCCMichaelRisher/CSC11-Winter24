.global main

.section .rodata
out: .asciz "%d\n"

.text
main:
    push {lr}

    mov r4, #0              @ int result = 0;
    mov r5, #5              @ int mulitplicand = 5;
    mov r6, #3              @ int multiplier = 3;

whileLoop:
    cmp r5, #0              @ while( mulitplicand > 0 ){
    beq endWhile
    
    tst r5, #1              //tst does an bitwise and r5 & #1        @     if( mulitplicand & 1 ){
                            // so since 5 & 1 is 1 it set the Z flag to 0 because the anding it is not zero
    addne r4, r4, r6  @         result += multiplier;
    @     }

    lsl r6, r6, #1          @     multiplier <<= 1;

    lsr r5, r5, #1          @     mulitplicand >>= 1;
    bal whileLoop
    @ }
endWhile:

    ldr r0, =out
    mov r1, r4
    bl printf               @ printf( "%d\n", result );
    

    mov r0, #0              @ return 0;
    pop {pc}
    