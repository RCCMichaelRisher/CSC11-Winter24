.global main

.section .rodata
    outSum: .asciz "sum is %d\n"
    outStep: .asciz "%d + %d\n"
.section .data
    arr: .word 10, 20, 30, 40, 50
.text
main:
    stmdb sp!, {lr} //push lr

    ldr r0, =arr //load the address of arr
    mov r1, #5
    bl sumArr

    //print the sum
    mov r1, r0 //move the sum from sumArr first
    ldr r0, =outSum
    bl printf

    //return 0
    mov r0, #0
    ldmia sp!, {pc} //pop pc
//end of main

@ int sumArr( int *arr, int size );
//r0 = arr (address) 0th
//r1 = size
sumArr:
    stmdb sp!, {lr} //push lr

    mov r4, #0      @ int sum = 0;
    mov r5, #0      @ int i = 0;
    while:          @ while( i < size ){
        //compare for the while
        cmp r5, r1 //i < size
        bgt endWhile

        stmdb sp!, {r0,r1}  //push {r0,r1}
        ldr r2, [r0]
        mov r1, r4
        ldr r0, =outStep
        bl printf       @ printf( "%d + %d\n", sum, arr[i] );
        ldmia sp!, {r0, r1}         
    
        ldr r2, [r0], #4  //load the value from arr[i] and increment afterwards
        add r4, r4, r2  @ sum = sum + arr[i];
        add r5, #1      @ i = i + 1;
        bal while
    @ }
    endWhile:
    
    mov r0, r4          @ return sum;    
    ldmia sp!, {pc} //pop pc
//end of sumArr
