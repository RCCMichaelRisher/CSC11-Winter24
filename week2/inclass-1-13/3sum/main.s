//since we are in c we need main as the entry point
.global main

.section .data //variable, init
    r1: .word 25
.section .rodata //readonly
    outStr: .asciz "the sum is: %d\n"
.section .bss //variable, non-init

.text //the code begins here
main:                  @ int main(){
    push {lr} //store where we came from
    //move 20 into r0
    mov r0, #20        @ int r0 = 20;
    //load 25 from the data section
    ldr r1, =r1 //this gets me the address of r1 label.
    //to get the value i need to dereference it
    //i have address in r1, i want the number 25 to go into r1
    ldr r1, [r1]       @ int r1 = 25;
    //lastly mov 5 into r3
    mov r3, #5         @ int r3 = 5;

    //add them all together
    add r0, r0, r1 @ r0 = r0 + r1
    add r0, r0, r3 //r0 = r0 + r3

    //printf
    //move my answer from r0 so i don't overwrite it
    mov r1, r0   //r1 = r0;
    //now we can load the string
    ldr r0, =outStr
    //ready to call printf
    bl printf           @ printf( "the sum is: %d\n", r0 );

    mov r0, #25          @ return 0;
    pop {pc}
@ }