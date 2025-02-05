.global main

.section .bss //un-init variable space
.align 4
a: .space 10485760 //10 megabytes of space

.text
main:
    push {lr}
    pop {pc}