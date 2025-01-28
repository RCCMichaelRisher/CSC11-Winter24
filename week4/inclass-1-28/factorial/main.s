.global main
.global factorial

.section .data
    n: .word 0
.section .rodata
    outPrompt: .asciz "Enter a number from 1-12: "
    inPat: .asciz "%d"
    outRes: .asciz "The factorial is %d\n"
    debug: .asciz "%d\n"
.text //code begins
main:
    push {lr}
    mainDo:                     @ do{
        //prompt for input
        ldr r0, =outPrompt
        bl printf               @ printf( "Enter a number from 1-12: ");
        //input input 1-12
        ldr r0, =inPat
        ldr r1, =n
        bl scanf                @ scanf( "%d", &n );

        //load n to compare
        ldr r0, =n
        ldr r0, [r0]
        cmp r0, #0
        blt mainDo
        cmp r0, #12
        bgt mainDo
        @ } while ( n < 0 || n > 12 );
    //1-12 should fall here
    //n is in r0 right now
    //do the factorial
    //since r0 has the value of n we dont need to load anything
    bl factorial            @ n = factorial( n );
    //my answer should be in r0 if i follow the AAPCS standard

    mov r1, r0
    //output
    ldr r0, =outRes
    bl printf               @ printf( "The factorial is %d\n", n );

    mov r0, #0              @ return 0;
    pop {pc}
//end main fn

//int factorial( int n )
//r0 == n
//then return into r0
factorial:
    push {lr}
    cmp r0, #0              @ if( n == 0 ){
    beq factorialBaseCase

    push {r0} //keep my unedited r0(n)
    sub r0, r0, #1          @ int t = n - 1;
    bl factorial            @ t = factorial( t ); //r0 = factorial( r0 - 1 );

    pop {r1} //get my n from the stack
    //r0 == (n-1)!
    //r1 == n
    mul r0, r0, r1
    bal factorialExit         @ return n * t;
    
    factorialBaseCase:
        mov r0, #1          @ return 1;
    factorialExit:
    pop {pc}
//end factorial fn
