.global main
.section .data
    value: .word 0
.section .rodata
    outPrompt: .asciz "Enter a number to multiply by 5: "
    inPat: .asciz "%d"
    outRes: .asciz "%d x 5 = %d\n"
.text
main:
    //ask for a number to times by 5
    push {lr}

    //prompt
    ldr r0, =outPrompt
    bl printf
    //input
    ldr r0, =inPat
    ldr r1, =value
    bl scanf //get the input

    //load the values
    ldr r1, =value
    ldr r1, [r1]
    //math
    //shift by x to multiply by 4 
    lsl r2, r1, #2 //multiply by 4
    add r2, r2, r1 //add by r1 to get that 5th time
    //output maths
    ldr r0, =outRes
    bl printf


    mov r0, #0 //return 0
    pop {pc}
    