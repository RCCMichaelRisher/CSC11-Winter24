.global main

.section .rodata //read only data
    outStr: .asciz "%08x%08x\n"
.text //code begins
main:
    push {lr} //save where i came from

    //I want to add these 64 bit numbers together
    //0x01ffffffff   n1
    //0xffffffffff   n2

    //upper n1 0x01, lower n1 0xffffffff
    //upper n2 0xff, lower n2 0xffffffff

    //load n1 into registers
    ldr r0, =#0xffffffff //lower half n1
    ldr r1, =#0x01 //upper half n1

    //load n2 into registers
    ldr r2, =#0xffffffff //lower half n2
    ldr r3, =#0xff       //upper half n2

    //add the two lower parts
    //r0 lower n1
    //r2 lower n2 
    adds r4, r0, r2 //lower sum
    //add the upper half
    //ADC == AD with Carry
    adcs r5, r1, r3


    //print it out to see the value
    ldr r0, =outStr
    mov r1, r5 //move upper to r1 for printf
    mov r2, r4 //move lowwer to r2 for printf
    //print( "%08x%08x", r5, r4) the right registers for function call is printf( r0, r1, r2, r3)
    bl printf

    mov r0, #0 //return 0
    pop {pc} //return to where i was
