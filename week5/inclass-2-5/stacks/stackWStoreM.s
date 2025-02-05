.global main

.data
    out: .asciz "%d %d\n"

.text

main:
    push {lr}

    //push 25 to the stack
    mov r0, #25
    //store multiple in a decrement before addresing scheme
    @ stmdb sp!, {r0}
 
    mov r1, #16
    stmdb sp!, {r0,r1} //right to left into the stack

    @ add sp, #8
    //load multiple and increment afterwards to remove them from the stack
    //so the ! writes back to the stack pointer to do that increment by 4
    //without the ! it leave the item on the stack
    ldmia sp!, {r1,r2} //left to right

    ldr r0, =out
    bl printf

    mov r0, #0
    pop {pc}
