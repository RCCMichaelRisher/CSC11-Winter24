.global main //since im using c to compile this i need my entrypoint to be main

.section .data //variables, init
.section .rodata //readonly
    //c expects string to have a \0 at the end.
    //asciz puts that \0 at the end
    hello: .asciz "Hello world\n" //     char h[50] = "Hello world\n";
    //since print f needs the format and the parameters i need to store the format
    format: .asciz "%s"
.section .bss //variable, non-init

.text //beginning of the code section
main: // int main(){
    //pushing onto a stack from temporary memory storage
    push {lr} //this i came from. I need to save this so i can return there when i finish
    
    //load the parameters for printf
    //put the format into the 1st parameter spot, r0
    //need to use load since its a string
    ldr r0, =format
    //load the string we are printing
    ldr r1, =hello
    //run printf
    //run function with branching. Branch w/ Link
    bl printf                   //     printf( "%s", h );

    //return values in function always to r0
    //put 0 r0
    mov r0, #0                  //     return 0;
    //take off a value from the stack and put into a register i need to use pop
    pop {pc}
// }
