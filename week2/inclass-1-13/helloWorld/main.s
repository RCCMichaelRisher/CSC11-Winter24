//going a _start somewhere
.global _start

//this is for read only data
.section .rodata
//math constants, strings that dont change,
//new hello world data at label hello
hello: .ascii "Hello World\n" //== string hello = "Hello World\n";

.section .data
//variables. initalized 

.section .bss
//non constant data. uninitalized.

.text //this is where the code begins
//start label/function
_start: 

    //write a syscall to output to the terminal
    //snippit from the book rpi sys appendix
    //sys       action      function
    //4         write       Write to file descriptor
    //params i need for this syscall
    //unsigned int fd, char *buf, size_t count
    //translates to where its going, what writing, how long is it

    //put 4 into r7 which our syscall register
    mov r7, #4
    //write to cout is 1
    //moving 1 to r0 register
    mov r0, #1
    //load the string hello world into the r1 register
    //LoaD Register, the address of the data into r1
    ldr r1, =hello
    //store the size of what we are printing
    mov r2, #12
    //run the system call. by doing a software interrupt
    swi 0

    //to return 0 we need to do a syscall for exit
    //sys       action      function
    //1         exit       terminate the current process
    mov r7, #1
    //put the error code into r0. 0 means there was no error so load that r0
    mov r0, #0
    //run the syscall
    swi 0

/*
int main(){
    char h[50] = "Hello world\n";
    printf( "%s", h );
    return 0;
}
*/