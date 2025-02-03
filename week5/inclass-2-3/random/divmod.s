.global divMod

.align 4
.section .rodata

// r0 numerator / dividend
// r1 what you to divide by aka denom / divisor
// results
// r0 return register for all function. has the division
// r1 mod

.text
divMod: //int divMod( x, y){  x/y r0 returns results of the division, r1 should have the result of the mod


/*
r0 = result of div
r1 = result of mod
r2 = increment from 1
r3 = decrement from denom
r4 = denom
r5 = numerator
 */
    push {lr}
    push {r4-r12}
    mov r4, r1          //denom = 3;
    mov r5, r0        //numer = 600; 

    //Initialize the working registers with the data
    mov r1, #0          //rDiv = 0;
    mov r0, r5          //rMod = numer;
    mov r2, #1          //increment = 1;
    mov r3, r4          //decDenom = denom;

do:
    //Shift the denominator left until greater than numerator, then shift back
    //do{
    lsl r3, r3, #1      //decDenom = decDenom << 1;           //Denominator shift left
    lsl r2, r2, #1      //increment = increment << 1;           //Division shift left
    cmp r0, r3          //} while( rDiv > decDenom );         //Shift Left until Decrement/Division Greater than Numerator
    bgt do
endDoWhile:
    //since we went to far greater than than the numerator go back once
    lsr r3, r3, #1      //decDenom = decDenom >> 1;
    lsr r2, r2, #1      //increment = increment >> 1;

while1:
    //Loop and keep subtracting off the shifted Denominator
    cmp r0, r3          //while( rDiv >= decDenom ){
    blt endWhile1
    add r1, r1, r2      //rDiv += increment;               //Increment division by the increment
    sub r0, r0, r3      //rMod -= decDenom;               //Subtract shifted Denominator with remainder of Numerator
while2:
    cmp r2, #1
    ble endWhile2
    cmp r3, r0
    ble endWhile2       //while( increment > 1 && decDenom > rDiv ){ //Shift Denominator until less than Numerator
    lsr r2, r2, #1      //increment >>= 1;           //Shift Increment left
    lsr r3, r3, #1      //decDenom >>= 1;           //Shift Denominator left
    bal while2
endWhile2: //}
    bal while1
endWhile1: //}
    //Output the results
    //move the values around 
    mov r6, r0          //move rmod to safe register
    mov r7, r1          //mov rdiv to safe register

    push {r0}
    mov r0, r1
    pop {r1}

    pop {r4-r12}
    pop {pc}
//}
