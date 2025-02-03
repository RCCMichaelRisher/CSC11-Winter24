.global main
.global passByRef

.section .rodata
    outBefore: .asciz "Before passbyref function\n"
    outv1: .asciz "val1: %d\n"
    outv2: .asciz "val2: %d\n"
    outv3: .asciz "val3: %d\n"
    outAfter: .asciz "After passbyref function\n"
    outIn: .asciz "In passByRef function\n"
    outSum: .asciz "sum is:%d\n"
.section .data
    val1: .word 123
    val2: .word 456
    val3: .word 256
.text //start the code
main:
    push {lr}
    
    ldr r0, =outBefore
    bl printf                   @ printf( "Before passbyref function\n");

    ldr r4, =val1 
    ldr r5, =val2
    ldr r6, =val3

    ldr r0, =outv1
    ldr r1, [r4] //load the content at the address in r4
    bl printf                   @ printf( "val1: %d\n", val1 );

    ldr r0, =outv2
    ldr r1, [r5]
    bl printf                   @ printf( "val2: %d\n", val2 );

    ldr r0, =outv3
    ldr r1, [r6]
    bl printf                   @ printf( "val2: %d\n", val3 );

    mov r0, r4 //move the addresses around to be the parameters
    mov r1, r5 //move the addresses around to be the parameters
    mov r2, r6 //move the addresses around to be the parameters
    bl passByRef                @ passByRef( &val1, &val2, &val3 ); 

    ldr r0, =outAfter
    bl printf                   @ printf( "After passbyref function\n");

    ldr r0, =outv1
    ldr r1, [r4]
    bl printf                   @ printf( "val1: %d\n", val1 );

    ldr r0, =outv2
    ldr r1, [r5]
    bl printf                   @ printf( "val2: %d\n", val2 );

    ldr r0, =outv3
    ldr r1, [r6]
    bl printf                   @ printf( "val2: %d\n", val3 );    

    pop {pc}
//end main

//void passByRef( int*, int*, int* );
//r0 = &v1
//r1 = &v2
//r2 = &v3
passByRef:
    push {r4-r7,lr}

    //move the parameters back to where they were before 
    mov r4, r0 //v1 address
    mov r5, r1 //v2 address
    mov r6, r2 //v3 address

    ldr r0, =outIn
    bl printf                   @ printf( "In passByRef function\n" );
    ldr r0, [r4]                @ int v1 = *a1;
    ldr r1, [r5]                @ int v2 = *a2;
    ldr r2, [r6]                @ int v3 = *a3;

    //sum in r3
    add r3, r0, r1              @ int t = v1 + v2;
    add r3, r3, r2              @ t = t + v3;
    //modify the v1-v3 values to be different
    add r0, r0, #5              @ v1 = v1 + 5;
    add r1, r1, #10             @ v2 = v2 + 10;
    mov r7, #2 //cant use immediate values in multiplication so have to use r7
    mul r2, r2, r7              @ v3 = v3 * 2;

    //store the values we just changed back into their addresses in r4-r6
    str r0, [r4]                @ *a1 = v1;
    str r1, [r5]                @ *a2 = v2;
    str r2, [r6]                @ *a3 = v3; 

    push {r0-r2} //push them to the stack temp
    ldr r0, =outSum
    mov r1, r3 //move the sum
    bl printf                   @ printf( "sum is:%d\n", t );
    pop {r0-r2}

    //print v1
    push {r1,r2}
    mov r1, r0 //move the value of v1 which was in r0 to r1 for printing
    ldr r0, =outv1
    bl printf                   @ printf( "val1: %d\n", v1 );
    pop {r1,r2} 

    //print v2
    push {r2}
    ldr r0, =outv2
    //r1 should be in r1 from pop in line 104
    bl printf                   @ printf( "val2: %d\n", v2 );
    pop {r1} //pop the value that was pushed from r2, into r1 for the next print statement

    //printf v3
    ldr r0, =outv3
    //r1 already loaded from the pop above
    bl printf                   @ printf( "val2: %d\n", v3 );

    pop {r4-r7,pc}              @ return;
//end passByRef
