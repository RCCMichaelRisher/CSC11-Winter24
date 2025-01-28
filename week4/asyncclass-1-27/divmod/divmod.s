.global main


.section .rodata
outDiv: .asciz "%d / %d = %d\n"
outMod: .asciz "%d %% %d = %d\n"

.text
main:
    push {lr}
/*
r0 = result of mod
r1 = result of div
r2 = increment
r3 = decrementDenom
r4 = denom
r5 = numer
 */
    mov r4, #9          @     denom = 9;
    mov r5, #55         @     numer = 55;

    mov r1, #0          @     rDiv = 0;
    mov r0, r5          @     rMod = numer;
    mov r2, #1          @     increment = 1;
    mov r3, r4          @     decDenom = denom;

do:                     @     do{        
    lsl r3, r3, #1      @         decDenom <<= 1;  //denominator shift left
    lsl r2, r2, #1      @         increment <<= 1;  //incrementor shift left
    cmp r0, r3          @     } while( rMod > decDenom ); //stop once we made a number bigger than the numerator
    bgt do
endDo:
    lsr r3, r3, #1      @     decDenom >>= 1;  //denominator shift right
    lsr r2, r2, #1      @     increment >>= 1;  //incrementor shift right

while1:
    cmp r0, r3
    blt endWhile1       @     while( rMod >= decDenom ){
    add r1, r1, r2      @         rDiv += increment;
    sub r0, r0, r3      @         rMod -= decDenom;

while2:
    cmp r2, #1
    ble endWhile2
    cmp r3, r0
    ble endWhile2       @         while ( increment > 1 && decDenom > rMod ){
    
    lsr r2, r2, #1      @             increment >>= 1;
    lsr r3, r3, #1      @             decDenom >>= 1;
    bal while2
    @         }
endWhile2:
    @     }
    bal while1
endWhile1:

    //move the results to function safe registers
    mov r6, r0
    mov r7, r1

    ldr r0, =outDiv
    mov r1, r5
    mov r2, r4
    mov r3, r7
    bl printf           @     printf( "%d / %d = %d\n", numer, denom, rDiv );
    
    
    ldr r0, =outMod
    mov r1, r5
    mov r2, r4
    mov r3, r6
    bl printf@     printf( "%d %% %d = %d\n", numer, denom, rMod );
    @ }

    mov r0, #0
    pop {pc}