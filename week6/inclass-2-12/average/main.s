.global main

.section .rodata
    outPrompt: .asciz "Enter 5 Numbers to average.\n"
    outInLoop: .asciz "Enter num %d: "
    inFlt: .asciz "%f"
    outRes: .asciz "Your average is %f\n"

    debug: .asciz "sum %f\n"
.section .data
    input: .float 0.0
    zero: .float 0.0
    five: .float 5.0
.text
main:
    push {lr}

    //prompt 
    ldr r0, =outPrompt
    bl printf

    //set the sum register to zero beforehand
    ldr r0, =zero
    vldr.f32 s8, [r0]

    //loop get 5 numbers
    mov r6, #0  //int i = 0;
    loop:
        cmp r6, #5
        bge endLoop

        //tell them to enter a number
        ldr r0, =outInLoop
        mov r1, r6
        //human readable number
        add r1, #1
        bl printf

        //get their number
        ldr r0, =inFlt
        ldr r1, =input
        bl scanf

        //load their number
        ldr r0, =input
        vldr.f32 s2, [r0]

        //add to my sum
        vadd.f32 s8, s8, s2

        ldr r0, =debug
        vcvt.f64.f32 d2, s8
        vmov r1, r2, d2 //need 2 32bits to hold 1 64 bit number
        bl printf

        //increment my i counter
        add r6, #1
        bal loop
    endLoop:
    
    //do average
    //we want to divide by 5
    ldr r0, =five
    vldr.f32 s2, [r0]
    //division
    vdiv.f32 s0, s8, s2 //sum / 5

    //print the results
    //convert to 64 for printing
    vcvt.f64.f32 d0, s0
    ldr r0, =outRes
    vmov r1, r2, d0
    bl printf

    mov r0, #0 //return 0
    pop {pc}
