.global main

.section .data //var init
    input: .word 0
.section .rodata //readonly
    outPrompt: .asciz "Enter a number to sum till: ";
    inPat:     .asciz "%d";
    outRes:    .asciz "Your sum is %d\n";
    debug:     .asciz "i = %d\n"
.section .bss //vars, non-init

.text //code begins here
main: //entry point
    push {lr} //link registers keeps track of where i came from

    //prompt for input
    ldr r0, =outPrompt
    bl printf                       @ printf( outPrompt );
    //input n
    ldr r0, =inPat
    ldr r1, =input
    bl scanf                        @ scanf( inPat, &input );

    //loop addition till n
                                    @ int i = 1; //counter
    mov r4, #1 //put counter into a "safe" register since printf can change r0-r3 once it runs
    mov r5, #0                      @ int sum = 0;
    //load input
    ldr r6, =input //just the address of input
    ldr r6, [r6] //access memory to get the value of input from the address
while:                              @ while ( i <= input ){
    cmp r4, r6  //i(r4) <= input(r6)
    bgt endWhile //if it greater that, so i > input then the loop ends and we should stop looping
    //increment my sum (r5) with my counter(r4)
    add r5, r5, r4                  @     sum = sum + i;

    //debug printf
    ldr r0, =debug
    mov r1, r4 //copy the value in r4 to t1
    bl printf                       @     printf( "i = %d\n", i ); 

    //lastly increment my counter (r4) by adding 1 to it
    add r4, #1                      @     i = i + 1;
    bal while   //you need a bal to create a loop
endWhile:                           @ } //end while loop
    //output the results
    ldr r0, =outRes
    mov r1, r5  ///copy the sum(r5) to r1 for printing
    bl printf                       @ printf( outRes, sum );

    mov r0, #0                      @ return 0;
    pop {pc} //program counter
