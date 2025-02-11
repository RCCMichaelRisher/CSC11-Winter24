.global main

.section .rodata
    outPrompt: .asciz "Enter something Please:"
    outRes: .asciz "= %d\n"
    inPat: .asciz "%d"

.text
main:
    push {lr}

    //print the prompt
    ldr r0, =outPrompt
    bl printf

    //ask for input
    ldr r0, =inPat
    //i have no variable to input scanf too. But i can use the stack
    //allocate space on the stack
    sub sp, #4
    //put the address of sp in the r1 
    mov r1, sp
    bl scanf

    //get the value out
    pop {r0}

    mov r1, #3

    //sdiv signed division
    sdiv r1, r0, r1

    //udiv unsigned division
    @ udiv r1, r0, r1

    //load my print
    ldr r0, =outRes
    bl printf

    mov r0, #0 //return 0
    ldmia sp!, {pc}
//I need to compile this gcc filename.s -mcpu=cortex-a7
