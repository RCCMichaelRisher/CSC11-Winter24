.global main

.section .data //variable, init
.section .rodata //readonly 
    outStr: .asciz "%x\n"
.section .bss //variabel un-init

.text //the code starts here
main:
    //keep track of where i came from
    push {lr}

    mov r0, #7    //7 in base 10
    mov r0, #0b0111  //7 in binary
    mov r1, #0b1001 //9 in binary

    @ and r0, r0, r1 //and the 7 and 9 together
    @ orr r0, r0, r1 //or them together
    @ eor r0, r0, r1 //xor should get me = 
    //bit clear. turns off (zeros out) a specific bit
    mov r2, #0b0010 //I want to turn off the 2nd bit in 0b111
    bic r0, r0, r2 //clear that 2nd bit and put the result in r0

    //set up for printf
    mov r1, r0
    ldr r0, =outStr
    bl printf           //print( r0, r1, r2, r3)



    pop {pc} //resume where i left off