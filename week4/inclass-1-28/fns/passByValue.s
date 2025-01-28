.global main
.global passByVal

.section .data
    val1: .word 123;
    val2: .word 100;
    val3: .word 256;

.section .rodata
    outVal1: .asciz "val1: %d\n"
    outVal2: .asciz "val2: %d\n"
    outVal3: .asciz "val3: %d\n"
    outPassByVal: .asciz "Passby Value fn\n\n"
    outSum: .asciz "sum: %d\n"
    outEndPass: .asciz "End pass by val fn\n\n"

.text
main:
    push {lr}
    //print of val1
    ldr r0, =outVal1
    ldr r1, =val1
    ldr r1, [r1]
    bl printf               @ printf( "val1: %d\n", a );

    //print val2
    ldr r0, =outVal2
    ldr r1, =val2
    ldr r1, [r1]
    bl printf               @ printf( "val2: %d\n", b );

    //print val3
    ldr r0, =outVal3
    ldr r1, =val3
    ldr r1, [r1]
    bl printf               @ printf( "val3: %d\n", c );


    //load parameters for passbyval
    //val1 == a
    ldr r0, =val1
    ldr r0, [r0]
    //val2 == b
    ldr r1, =val2
    ldr r1, [r1]
    //val3 == c
    ldr r2, =val3
    ldr r2, [r2]
    bl passByVal            @ passByVal( a, b, c );

    //print of val1
    ldr r0, =outVal1
    ldr r1, =val1
    ldr r1, [r1]
    bl printf               @ printf( "val1: %d\n", a );

    //print val2
    ldr r0, =outVal2
    ldr r1, =val2
    ldr r1, [r1]
    bl printf               @ printf( "val2: %d\n", b );

    //print val3
    ldr r0, =outVal3
    ldr r1, =val3
    ldr r1, [r1]
    bl printf               @ printf( "val3: %d\n", c );


    mov r0, #0              @ return 0;
    pop {pc}


//passbyVal Function void passByVal( int a, int b, int c)
//r0 = a
//r1 = b
//r2 = c
passByVal:
    push {r4,r5,r6,lr} //where this function came from in the call stack

    //since printf will erase my r0-r3 registers i need to save my parameters
    push {r0-r3} //saved our parameters same as push {r0,r1,r2}
    ldr r0, =outPassByVal
    bl printf               @ printf( "Passby Value fn\n\n" );
    //restore our parametes back to where need to be
    pop {r0-r3} //same as pop {r0,r1,r2}

    add r4, r0, r1          @ int t = a + b;
    add r4, r4, r2          @ t = t + c;

    push {r0-r3} //saved our parameters same as push {r0,r1,r2} because the printf will clear r0-r3 we need to keep it
    ldr r0, =outSum
    mov r1, r4
    bl printf               @ printf( "sum: %d\n", t );
    pop {r0-r3} //same as pop {r0,r1,r2}

    add r0, r0, #1          @ a = a + 1;
    add r1, r1, #3          @ b = b + 3;
    sub r2, r2, #4          @ c = c - 4;

    //move my a,b,c to "safe registers"
    mov r4, r0
    mov r5, r1
    mov r6, r2
    
    //print the 3 values
    ldr r0, =outVal1
    mov r1, r4
    bl printf               @ printf( "val1: %d\n", a );

    ldr r0, =outVal2
    mov r1, r5
    bl printf               @ printf( "val2: %d\n", b );

    ldr r0, =outVal3
    mov r1, r6
    bl printf               @ printf( "val3: %d\n", c );

    ldr r0, =outEndPass
    bl printf               @ printf( "End pass by val fn\n\n");

    //mov r0, #0 //dont need this since no return 0
    pop {r4-r6,pc} //where we need to return too after we finish
//end passbyval
