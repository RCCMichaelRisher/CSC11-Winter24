.global main

.section .data
    x: .float 0.0
.section .rodata
    outPrompt: .asciz "Enter a floating point number: ";
    inFlt: .asciz "%f";
    outRes: .asciz "Entered: %f\n";    
.text
main:
    push {lr}

    ldr r0, =outPrompt
    bl printf           @ printf( outPrompt );

    ldr r0, =inFlt
    ldr r1, =x
    bl scanf            @ scanf( inFlt, &x );

    ldr r0, =outRes
    ldr r1, =x
    vldr s0, [r1]
    vcvt.f64.f32 d0, s0
    vmov r1, r2, d0
    bl printf           @ printf( outRes, x );

    mov r0, #0          @ return 0;
    pop {pc}
