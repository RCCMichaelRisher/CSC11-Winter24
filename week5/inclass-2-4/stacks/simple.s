.global main

.data
    o: .asciz "%d\n"
.text
main:
    push {lr}

    //pushing 25 to the stack
    sub sp, sp, #4 //allocate space
    mov r0, #25
    str r0, [sp]

    //pushing 16 to the stack
    sub sp, sp, #4 //allocate space
    mov r0, #16
    str r0, [sp]

    //pop 16 from the stack
    ldr r1, [sp]
    add sp, sp, #8  //remove space


    ldr r0, =o
    ldr r1, [sp] //peek. just look at what is in the stack without removing it from the stack
    bl printf
    pop {pc}
