.global main

.section .rodata
    outBefore: .asciz "Before sorting\n"
    outAfter: .asciz "Sorted Array!\n"
    outNum: .asciz "%d "
    newline: .asciz "\n"
.section .data
    len: .word 5
.section .bss
    array: .space 20 //5*4
.text
main:
    stmdb sp!, {lr}

    bl initRandom           @ srand( time( 0 ) );

    @ //input function
    ldr r0, =array
    ldr r1, =len
    ldr r1, [r1]
    bl input                @ input( array, len );
    
    ldr r0, =outBefore
    bl printf               @ printf( "Before sorting\n" );

    ldr r0, =array
    ldr r1, =len
    ldr r1, [r1]
    bl outArr               @ outArr( array, len );

    @ //sort function
    ldr r0, =array
    ldr r1, =len
    ldr r1, [r1]
    bl bubbleSort           @ bubbleSort( array, len );

    @ //print function
    ldr r0, =outAfter
    bl printf               @ printf( "Sorted Array!\n" );

    ldr r0, =array
    ldr r1, =len
    ldr r1, [r1]
    bl outArr               @ outArr( array, len );

    ldmia sp!, {pc}
//end

//bubbleSort( *a, n)
bubbleSort:
    stmdb sp!, {lr}
    sub r1, r1, #1          @ int x = n - 1;
    mov r2, #0              //int i = 0
    bsForOut:               @ for( int i = 0; i < x; i++ ){
        cmp r2, r1
        bge bsEndOut
        mov r3, #0              //int j = 0
        bsForInner:             @ for( int j = 0; j < x; j++ ){
            cmp r3, r1              //j<x
            bge bsEndInner
            //load a[j]
            //get the offset
            add r4, r0, r3, lsl #2 //new address with the offset
            ldr r5, [r4] //the value of a[j]
            //load a[j+1]
            add r6, r3, #1 //j + 1
            add r6, r0, r6, lsl #2 // a + [(j + 1) * 4 ] //this is my address
            ldr r7, [r6]
            //now i can test them
            cmp r5, r7              @ if ( a[j] > a[j + 1] ){
            ble noswap
            
            str r7, [r4]                @ a[j] = a[j + 1];
            str r5, [r6]                @ a[j + 1] = temp;
                                    @ }
            noswap:
            add r3, #1          //j++
            bal bsForInner      @ }
        bsEndInner:
        add r2, r2, #1 //i++
        bal bsForOut@ }
    bsEndOut:
    ldmia sp!, {pc}
//end


//input(*a, n)
input:
    stmdb sp!, {lr}
    mov r4, #0 //i = 0
    mov r5, r0 //move array & len to "safe" registers
    mov r6, r1
    iWhile:             @ for( int i = 0; i < n; i++ ){
        cmp r4, r6
        bge iEnd
        mov r0, #90
        mov r1, #10
        bl getRand //value is in r0
        //str where, [to, offset, shift]
        str r0, [r5, r4, lsl #2] //r5 + (r4*4)
                        @     a[i] = rand() % 90 + 10; //[10,99]
        
        add r4, #1
        bal iWhile      @ }
    iEnd:
    ldmia sp!, {r4-r6,pc}
//end

//(*a, n)
outArr:
    stmdb sp!, {r4-r6,lr}
    mov r4, #0
    mov r5, r0
    mov r6, r1
    oaWhile:            @ for( int i = 0; i < n; i++ ){
        cmp r4, r6
        bge oaEnd
    
        ldr r1, [r5], #4
        ldr r0, =outNum
        bl printf       @ printf( "%d ", a[i] );

        add r4, #1
        bal oaWhile     @ }
    oaEnd:
    ldr r0, =newline
    bl printf           @ printf( "\n" );
    ldmia sp!, {r4-r6,pc}
//end
