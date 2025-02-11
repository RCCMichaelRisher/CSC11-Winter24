.global main

.section .data
    x: .float 0.0
    y: .float 2.35
    z: .float -9.87654
    w: .float 4.56123
.section .rodata
    outPrompt: .asciz "Enter a floating point number: ";
    inFlt: .asciz "%f";
    outRes: .asciz "Value entered was %f; (y=%f, z=%f, w=%f). The sum is %f\n";

.text
main:
    push {fp, lr}
    mov fp, sp //mark the stack pointer as the beginning of the frame pointer
    //A "frame pointer" is like a marker on the computer's memory stack that points 
    //the beginning of a specific function's data
    //acting as a reference point to easily access local variables and arugments within that function.
    //imagine it as a flag on a stack of boxes where each box represents a function call, allowing you to
    //quickly identify which box contains the data for the current function.

    ldr r0, =outPrompt
    bl printf                   @ printf( outPrompt );

    ldr r0, =inFlt
    ldr r1, =x
    bl scanf                    @ scanf( inFlt, &x );

    //load the string for printing
    ldr r0, =outRes

    //get the users number
    ldr r2, =x
    vldr s0, [r2]
    //lets convert to 64 and move to the registers for print
    vcvt.f64.f32 d5, s0
    //make a copy of d5 into d6
    vmov.f64 d6, d5
    //move it to reg registers
    vmov r2, r3, d5

    //allocate space on the stack
    //i need to put 4 8 byte numbers on the stack so a total of 32 bytes 
    sub sp, sp, #32

    //load y
    ldr r4, =y
    vldr s0, [r4]
    //convert 64 to print with
    vcvt.f64.f32 d5, s0
    vadd.f64 d6, d6, d5             @ float sum = x + y;
    //store d5 (y) into the stack
    vstr d5, [sp]

    //load z
    ldr r4, =z
    vldr s0, [r4]
    //convert 64 to print with
    vcvt.f64.f32 d5, s0
    vadd.f64 d6, d6, d5             @ sum = sum + z;
    //add 8 to get that new spot in the stack
    vstr d5, [sp, #8]

    //load w
    ldr r4, =w
    vldr s0, [r4]
    //convert 64 to print with
    vcvt.f64.f32 d5, s0
    vadd.f64 d6, d6, d5             @ sum = sum + w;;
    //add 8 to get that new spot in the stack
    vstr d5, [sp, #16]

    //store the sum
    vstr d6, [sp, #24]

    //so i have y, z,w, sum all in stack
    //call printf
    bl printf                       @ printf( outRes, x, y, z, w, sum );

    //clean up the stack of that clutter
    add sp, #32

    //return 0
    mov r0, #0
    mov sp, fp
    pop {fp,pc}
