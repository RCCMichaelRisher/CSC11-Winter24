.global _start

@ .section .data //variable, inited
@     input: .ascii "Hello World String\n"
.section .bss //variable un-inited
    input: .space 24 //each character is 4 bytes i want 5 total characters ( 4 * 5  = 20)

.text
_start:

//this whole section is like a scanf("%5c")
    //ask the user for input with syscall
    //3 into r7 to indicte we want to call a read syscall
    mov r7, #3
    //where its comming from. stdin = 0
    mov r0, #0
    //where we want to store the data
    ldr r1, =input //address of input
    //how much do we want to input
    mov r2, #5
    //call syscall
    swi 0
//end input

    //output what we got with a syscall
    //put 4 into r7 to indicate a write syscall
    mov r7, #4
    //write to stdout aka 1
    mov r0, #1
    //what we want to write, input
    ldr r1, =input
    //how much do we want to write
    mov r2, #5
    //call the syscall
    swi 0

    //lastly we need to exit
    //return 0
    mov r7, #1 //exit syscall
    //error 0. 0 it ran well
    mov r0, #0
    //call the syscall
    swi 0
