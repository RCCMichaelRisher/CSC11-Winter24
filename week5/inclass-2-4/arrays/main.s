.global main

.section .data
    @ int a[25];
    arr: .space 100 //25 * 4 bytes = 100 bytes of space
.section .rodata
    out: .asciz "a[%d] = %d\n"
.text
main:
    push {lr}
    
    //load params
    ldr r0, =arr
    mov r1, #25
    bl outputArr        @ outputArr( a, 25 );

    ldr r0, =arr
    mov r4, #0  //i
    for:                @ for( int i = 0; i < 25; i++ ){
        cmp r4, #25
        bge end

        //store the i value and put in the array address
        str r4, [r0]    @ a[i] = i;

        //add counter
        add r4, r4, #1
        add r0, r0, #4 //changes the address to the next spot in the array
    
        bal for
    @ }
    end:

    ldr r0, =arr //this reload the beginning of the array!
    mov r1, #25
    bl outputArr        @ outputArr( a, 25 );
    
    mov r0, #0          @ return 0;
    pop {pc}
//end main


//r0 = address of my array
//r1 = size of my array
outputArr:
    push {r4, lr}
    mov r4, #0 //i
    oaFor:      @ for( int i = 0; i < 25; i++ ){
        cmp r4, r1
        bge oaEnd
    
        push {r0-r1}
        ldr r2, [r0]
        mov r1, r4
        ldr r0, =out
        bl printf       @ printf( "a[%d] = %d\n", i, arr[i] );
        pop {r0-r1}

        add r4, #1 //add to my counter
        add r0, r0, #4 //add to my array address to get the next value
        bal oaFor
    @ }
    oaEnd:
    pop {r4, pc}
//end outputArr
