.extern time
.extern srand
.extern rand
.extern divMod

//allows the linker to let other files access this label initRandom
.global initRandom
.global getRand

//setups the random seed
@ void initRandom()
initRandom:
    stmdb sp!, {lr}

    mov r0, #0
    bl time
    bl srand

    ldmia sp!, {pc}
//end initRandom

@ getRand( int modby, int addby )
getRand:
    stmdb sp!, {r4,r5,lr}
    //move my modBy and addBY to "safe" registers
    mov r4, r0 //modby
    mov r5, r1 //addby
    bl rand //gets some random value into r0

    // r0/r1
    lsr r0, r0, #1 //make r0 not negative
    mov r1, r4 //move modby into r1
    bl divMod
    //return the division in r0, and mod in r1
    add r0, r1, r5 //adds the addBy and the mod and puts in the return register
    // return rand() % modby + addby
    ldmia sp!, {r4,r5,pc}
    