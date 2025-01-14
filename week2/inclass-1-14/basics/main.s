.global main

.section .data //variable, init
.section .rodata //readonly
    outStr: .asciz "result: %d\n"
.section .bss //variabel un-init

.text //the code starts here
main:
    //keep track of where i came from
    push {lr}

    mov r0, #25
    mov r1, #10
    mov r2, #30


    //(r0 * r1) * r2
    @ add r0, r0, r1 //r0=r0+r1
    @ sub r0, r0, r1 //r0 = 25-10
    @ rsb r0, r0, r1 //r0 = 10 - 25
    mul r0, r0, r1 //r0 = 25*10 
    mul r0, r2 //shorthand for mul r0, r0, r2

    //load the parameters
    //move my answer to the right register before i overwrite it
    mov r1, r0
    ldr r0, =outStr
    bl printf  //printf( r0, r1, r2, r3)

    pop {pc} //resume where i left off
