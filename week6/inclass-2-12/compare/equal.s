.global main

.section .data
    a: .float 1.0000001
    b: .float 1.0000002
    delta: .float 0.00001 
    outEq: .asciz "equal\n" 
    outNe: .asciz "not equal\n"
    outDelEq: .asciz "equal within delta\n"
    outDelNe: .asciz "not equal within delta\n"
.text
main:
    push {lr}

    //load our numbers
    ldr r0, =a
    vldr s0, [r0]
    ldr r0, =b
    vldr s2, [r0]

    vcmp.f32 s0, s2
    //copy the floating pt compare to general register compare
    vmrs APSR_nzcv, FPSCR

    //load the string based on the cpsr
    ldreq r0, =outEq            
    ldrne r0, =outNe            
    bl printf                   @ if( a == b ){
                                @ printf( "equal\n");
                                @ } else {
                                @ printf( "not equal\n");
                                @ }

    @ //what you usually do is have some delta
    @ //if their difference is smaller than some delta we say they are equal
    vsub.f32 s4, s0, s2
    //new instrcution instead bl to fabs
    vabs.f32 s4, s4
    //compare abs( a - b )
    //load delta
    ldr r0, =delta
    vldr s5, [r0]
    vcmp.f32 s4, s5             @ if( fabs( a - b ) < delta ) {
    //copy the floating pt compare to general register compare
    vmrs APSR_nzcv, FPSCR
    //instead brancing im doing conditional instructions
    ldrlt r0, =outDelEq         @ printf( "equal within delta\n" );
    @ } else {
    ldrge r0, =outDelNe         @ printf( "not equal in the delta\n" );
    bl printf

    mov r0, #0                  @ return 0;
    pop {pc}

