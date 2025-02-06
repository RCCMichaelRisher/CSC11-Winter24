.global main


.section .bss
    array: .space 20  //5 * 4byte numbers = 20
    total: .space 4  //4byte number
.section .rodata
    outPrompt: .asciz "Enter numbers for summing\n"
    outRes: .asciz "The sum is %d\n"
    outIn: .asciz "Enter number %d: "
    inPat: .asciz "%d"
.section .data
    len: .word 5
.text
main:
    push {lr}  

    ldr r0, =outPrompt
    bl printf               @ printf( "Enter numbers for summing\n" );

    ldr r0, =array
    ldr r1, =len
    ldr r1, [r1] //load the value
    bl input                @ input( a, len );

    ldr r0, =array
    ldr r1, =len
    ldr r1, [r1]
    bl sum  //gets the sum return r0 @ int total = sum( a, len );
    ldr r1, =total
    str r0, [r1] //store the sum from the function and save into total
    
    ldr r0, =outRes
    ldr r1, [r1]
    bl printf               @ printf( "The sum is %d\n", total );

    mov r0, #0              @ return 0;
    pop {pc}
//end

//r0, a
//r1, n
sum:
    stmdb sp!, {r4,lr}
    mov r2, #0              @ int sum = 0;
    mov r3, #0              @ int i = 0;
    sWhile:                 @ while ( i < n ){
        cmp r3, r1
        bge sEnd
        //load the value a
        //so ldr allow for [address, offset, shift]
        ldr r4, [r0, r3, lsl #2] // a + (i * 4)
        add r2, r2, r4          @ sum = sum + a[i];
        
        add r3, r3, #1          @ i = i + 1;
        bal sWhile          @ }
    sEnd:
    mov r0, r2              @ return sum;
    ldmia sp!, {r4,pc}
//end

//r0, a
//r1, n
input:
    stmdb sp!, {lr}
    mov r2, #0              @ int i = 0;
    iWhile:                 @ while( i < n ){
        cmp r2, r1
        bge iEnd
    
        stmdb sp!, {r0-r2}
        ldr r0, =outIn
        add r2, #1
        mov r1, r2
        bl printf           @ printf( "Enter number %d: ", i+1 );
        ldmia sp!, {r0-r2}

        stmdb sp!, {r0-r2}
        //I cant just pass in r0
        //I need the address + offset
        //calculate the address
        add r1, r0, r2, lsl #2 // r0+(r2 * 4) 
        ldr r0, =inPat
        bl scanf            @ scanf( "%d", &a[i] );
        ldmia sp!, {r0-r2}

        add r2, #1          @ i = i + 1;
        bal iWhile          @ }
    iEnd:
    ldmia sp!, {pc}
//end