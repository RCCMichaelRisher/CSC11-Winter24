.global main

.section .data
num1: .float 0
num2: .float 0

.section .rodata
    outPrompt: .asciz "Enter 2 numbers %%f %%f\n"
    inPat: .asciz "%f %f"
    outLess: .asciz "num1 is less than num2\n"
    outMore: .asciz "num1 is more than num2\n"
    outEqual: .asciz "num1 is equal to num2\n"
.text
main:
    push {lr}

    //pormpt the user
    ldr r0, =outPrompt
    bl printf

    //get the input from the user
    ldr r0, =inPat
    ldr r1, =num1
    ldr r2, =num2
    bl scanf

    //loading num 1
    ldr r0, =num1
    //load the value into the float registers
    vldr s0, [r0]

    //loading num 2
    ldr r1, =num2
    //load the value into fp registers
    vldr s2, [r1]

    //compare in floating point be sure to include what datatype single or double
    vcmp.f32 s0, s2

    //in order to use the floating point status registers for branching i need to copy it
    //to the regular cpsr register
    //to copy the floating status (FPSCR) to my general purpose cpsr(APSR_nzcv)
    vmrs APSR_nzcv, FPSCR
    blt less
    beq equal
    bgt more
less:
    ldr r0, =outLess
    bl printf
    bal end
equal:
    ldr r0, =outEqual
    bl printf
    bal end
more:
    ldr r0, =outMore
    bl printf
end:
    mov r0, #0   //return 0
    pop {pc}
