.global main
.section .rodata
    out: .asciz "%d\n"
.text
main:
    stmdb sp!, {lr}

    bl initRandom

    mov r4, #0
    while:
        cmp r4, #15
        bge end

        mov r0, #90
        mov r1, #10
        bl getRand

        mov r1, r0
        ldr r0, =out
        bl printf

        add r4, #1
        bal while
    end:
    mov r0, #0
    ldmia sp!, {pc}
