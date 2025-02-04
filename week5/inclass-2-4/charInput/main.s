.global main

.section .data
    inPat: .asciz "%c"
    n: .word 0

.text
main:
    push {lr}

    //load the scanf
    ldr r0, =in
    ldr r1, =n
    bl scanf

    //load the value
    ldr r0, =n
    ldr r0, [r0]

    //test if the character is a "C" aka 67 in ascii value
    cmp r0, #67
    //if is a 'C' return 0
    moveq r0, #0
    //if is not a 'C' return 255
    movne r0, #255
    pop {pc}