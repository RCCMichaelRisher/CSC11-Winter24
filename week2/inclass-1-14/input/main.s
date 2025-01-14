.global main

.section .data //variable, init
    in: .word 0                                    @ int in;
    result: .word 0
.section .rodata //readonly 
    addBy: .word 32
    inPat: .asciz "%d"
    outPat: .asciz "%s" 
    outPrompt: .asciz "Enter a number: "
    outResult: .asciz "%d + 32 = %d\n"
.section .bss //variable un-init
result .word
.text //the code starts here
main:
    //keep track of where i came from
    push {lr}

    //ask for a number and add it by 32 
    ldr r5, =addBy //address of addBy 
    ldr r5, [r5] //get val from address
    @ mov r5, #32                                     @ int r5 = 32;

    //output prompt
    ldr r0, =outPat
    ldr r1, =outPrompt
    bl printf                                       @ printf( "%s", "Enter a number: " );

    //input from user
    //input a decimal value from the stdin (aka terminal in our case)
    //work similiarly to printf with format strings
    ldr r0, =inPat
    ldr r1, =in
    bl scanf                                        @ scanf( "%d", &in );

@ //do the math
    //load in into a register first
    ldr r1, =in //address
    ldr r1, [r1] //dereference that address

    add r2, r5, r1                                  @ int r2 = r5 + in;

    //store the result
    //STore to Register
    //since the load was like this 
    //ldr storehere, loadthis
    //the reverse is true for store.
    //str storethis, [at this address]
    ldr r3, =result //gets the address and puts it into r3
    str r2, [r3]

    @ //output the result
    ldr r0, =outResult
    ldr r1, =in //gets the address only not the value
    ldr r1, [r1] //this loads the value from the address

    //get the result from our result variable in memory
    ldr r2, =result //address
    ldr r2, [r2]  //value from the address

    bl printf                                       @ printf( "%d + 32 = %d\n", in, r2 ); //printf( r0, r1, r2, r3) 


    mov r0, #0                                      @ return 0;
    pop {pc} //resume where i left off
