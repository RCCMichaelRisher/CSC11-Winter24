.global main

.section .data //variable, init
.section .rodata //readonly 
.section .bss //variabel un-init

.text //the code starts here
main:
    //keep track of where i came from
    push {lr}


    pop {pc} //resume where i left off