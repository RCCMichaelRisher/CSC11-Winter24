.global main
.global multby5
.global getInput
.global output

.section .data
    input: .word 0
.section .rodata
    outRes: .asciz "%d x 5 = %d\n"
    outPrompt: .asciz "Enter a number to multiply by 5: "
    inPat: .asciz "%d"
.text //begin the code section
main:
    push {lr}
    //prompt for number 
    //get the number
    bl getInput                     @ r4 = getInput();
    //so the user number is now in r0 since getInput puts the return value into r0
    mov r4, r0 //put it into r4 to save it for later

    //do the * 5 to the number
    //load the parameters for multby5
    mov r0, r4
    bl multby5                      @ r3 = multby5( r4 );
    //answer gets put r0 once i finish the function

    //output the number
    //load my parameters for ouput
    //(input, result) -> (r0, r1)
    mov r1, r0 //move the answer first so i dont overwrite it
    mov r0, r4 //move the input to the 1st parameter
    bl output                       @ output( r4, r3 );
    
    mov r0, #0                      
    pop {pc}                        @ return 0;
//end main

//int multby5( int a )
//r0 = input
multby5:
    push {lr}
    add r0, r0, r0, lsl #2          @ int b = a;
                                    @ a = a << 2; //multiple by 4
                                    @ a += b; //adds the last mult by 5
    //since r0 is already in place i dont need to do anything special
    //return register is r0
    pop {pc}                        @ return a;
//end mult by 5

//int getInput()
getInput:
    push {lr}
    //prompt for a number
    ldr r0, =outPrompt
    bl printf                       @ printf( "Enter a number to multiply by 5: " );
    //get the number
    ldr r0, =inPat
    ldr r1, =input
    bl scanf                        @ scanf( "%d", &r1);

    //load the value
    //because i called scanf i cant assume that r1 still has that address to input
    ldr r0, =input
    ldr r0, [r0]
    pop {pc}                        @return r0
//end getInput

//void output( int in, int res )
//r0 = input
//r1 = result
output:
    push {lr}
    //mov ethe parameters first otherwise I'll erase them
    mov r2, r1  //result -> r2
    mov r1, r0  //input -> r1
    ldr r0, =outRes
    bl printf                   @ printf( "%d x 5 = %d\n", in, res );
    pop {pc}                    @ return;
//end output
