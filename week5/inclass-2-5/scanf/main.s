.global main

.section .rodata
    inPat: .asciz "%d"
    out: .asciz "read in %d\n"
.text
main:
    str lr, [sp, #-4]! //== push {lr}

    ldr r0, =inPat
    sub sp, sp, #4 //allocate 4bytes in the stack
    mov r1, sp //copy the sp address into r1
    bl scanf

    ldr r0, =out
    ldr r1, [sp], #4 //increment the sp after loading. this is one option
    bl printf

    @ add sp, #4 //you need to clear the stack. this is one option
    ldr pc, [sp], #4    //== pop {pc}