.global main

.section .data
    val1: .float 3.14159
    val2: .float 0.10
.section .rodata
    outRes: .asciz "The result is: %f\n"
.text
main:
    push {lr}

    ldr r0, =val1
    //we cant just ldr the number like we were before
    //to load a float we need to use Vector LoaD Register
    vldr s0, [r0]

    ldr r0, =val2
    vldr s2, [r0]

    //do the math
    vdiv.f32 s0, s0, s2

    //move the floating point out of the vfp registers so i can print it
    //before i can print i have to promote my single precision into a double
    //because printf like to promote float to doubles
    //convert to a 64bit from a 32bit. going to d0 from s0
    vcvt.f64.f32 d0, s0

    //i cant put a 64 number into a single 32bit register so i need two of them
    vmov r1, r2, d0

print:
    ldr r0, =outRes
    bl printf

    pop {pc}
