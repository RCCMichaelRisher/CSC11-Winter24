.global main


.data
    out: .asciz "%d\n"

.text

main: 
    stmdb sp!, {lr} // == push {lr}

    mov r0, #25
    //preindexing to store the value of 25
    //adds the offset which is -4 to the address in sp first, then it accesses that new address
    //the ! saves the new address into sp. You dont always need to do write back
    str r0, [sp, #-4]!  //save r0 into the stack and write the stack address to the sp register

    ldr r0, =out

    //postindexing to load the value of 25
    //loads from sp first, it then adds by the offset (4), then it writes back that new address into sp
    ldr r1, [sp], #4
    bl printf

    mov r0, #0
    
    //LoaD Multiple Increment After
    ldmia sp!, {pc}  //== pop {pc}
