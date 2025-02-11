.global main

.section .data
    x: .float 0.0
    y: .float 2.35
    z: .float -9.87654
    w: .float 4.56123
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

    //load the number from scanf
    ldr r1, =x
    vldr s0, [r1]

    ldr r1, =y
    vldr s1, [r1]

    ldr r1, =z
    vldr s2, [r1]

    ldr r1, =w
    vldr s3, [r1]
    
    //t = -(x * y)
    vnmul.f32 s4, s0, s1
    //t = t + ( z * w)
    //s4 = s4 + ( s2 * s3 )
    vmla.f32 s4, s2, s3
    
    ldr r0, =outRes
    //once i convert my s0&s1 value is no more 
    vcvt.f64.f32 d0, s4
    vmov r1, r2, d0
    bl printf           @ printf( outRes, x );

    mov r0, #0          @ return 0;
    pop {pc}


/*
VADD.F32 S0, S1, S2 @ Addition S0=S1+S2
VSUB.F64 D0, D2, D4 @ Subtraction D0=D2-D4
VDIV.F64 D4, D5, D1 @ Divide D4=D5/D1
VMUL.F32 S2, S4, S1 @ Multiply S2=S4*S1
VNMUL.F64 D4, D3, D2 @ Mult and negate. D4=-(D3*D2)
VMLA.F64 D4, D3, D2 @ Mult and accumulate D4=D4+(D3*D2)
VSUB.F64 D0, D1, D2 @ Mult and Subtract D0=D0-(D1xD2)
VABS.F32 S0, S1 @ Absolute S0=ABS(S1)
VNEG.F32 S2, S3 @ Negate S2=-S3
VSQRT.F64 D0,D1 @ Square Root D0=SQR(D1
 */