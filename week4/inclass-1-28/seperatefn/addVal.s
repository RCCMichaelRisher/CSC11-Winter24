.global addVal
.func addVal

//uint32_t addVal( uint32_t a, uint32_t b );
//addval( r0, r1 )
addVal:
    push {lr}
    //add the parameters then put the sum into the return register
    //which is r0 per the AAPCS standard
    mul r2, r0, r1
    mov r0, r2

    pop {pc}
