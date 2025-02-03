.global main

.extern divMod

.section .data
    out: .asciz "%d\n"

.text
main: 
    push {lr}


    //seeded the random
    mov r0, #0
    bl time         //time(0)
    bl srand        //srand( time(0))

    mov r4, #0      //counter i = 0
    while:
        cmp r4, #20 // i < 20
        bgt end
        bl rand         //rand() puts r0
        //remove any chance of getting negative numbers
        lsr r0, r0, #1

        mov r1, #90     // rand() % 90 [0, 90]
        bl divMod
        //r0 = division
        //r1 = mod

        add r1, r1, #10    //rand() % 90 + 10; [10,99]
        ldr r0, =out
        bl printf
        add r4, #1 //i++
        bal while
    end:


    pop {pc}
