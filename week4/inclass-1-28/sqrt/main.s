.global main
.extern intSqrt

.section .rodata
    outRes: .asciz "the sqrt is %d\n"
//do the sqrt of 4
main:
    push {lr}

    mov r0, #4
    bl intSqrt

    //move the answer into r1 for printing
    mov r1, r0
    ldr r0, =outRes
    bl printf

    pop {pc}
