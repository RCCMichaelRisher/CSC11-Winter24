.global main

.section .rodata
    outPrompt: .asciz "Enter a 32 bit signed number and the number of bits to shift by: "
    inPat: .asciz "%d %d"

    outlsl: .asciz "%d (0x%08X) LSL #%d = %d (0x%08X)\n"
    outlsr: .asciz "%d (0x%08X) LSR #%d = %d (0x%08X)\n"
    outasr: .asciz "%d (0x%08X) ASR #%d = %d (0x%08X)\n"
    outror: .asciz "%d (0x%08X) ROR #%d = %d (0x%08X)\n"
    outrol: .asciz "%d (0x%08X) ROL #%d = %d (0x%08X)\n"
debug: .asciz "%d\n"
.section .data
    value: .word 0
    shiftBy: .word 0

.text //begin code
main: 
    push {lr}
    //we want to demo all the shifting in arm

    //prompt the user to do stuff
    ldr r0, =outPrompt
    bl printf

    //input the stuff
    ldr r0, =inPat
    ldr r1, =value
    ldr r2, =shiftBy
    bl scanf

    //output all the shifts
    //load the value of value and shiftBy first
    ldr r4, =value
    ldr r4, [r4]
    ldr r5, =shiftBy
    ldr r5, [r5] 
    
    //Logical Shift Left == lsl
    //get me the shift 
    //these are the exact same instruction and do the same thing
    lsl r0, r4, r5 //puesdo operation
    mov r0, r4, lsl r5 //real instruction
    //print lsl
    //"%d (0x%08X) LSL #%d = %d (0x%08X)\n"
    mov r1, r4 //value as 2nd param
    mov r2, r4 //value as hex as the 3rd param
    mov r3, r5 //shifting by x as the 4th param
    //we have exceeded our 4 parameter limit once i load the string
    //so now we have use the stack to put anymore parameters in
    push {r0} //puts the answer onto the stack which that temp storage area
    push {r0} //put the answer on the stack again to get the hex format
    ldr r0, =outlsl
    bl printf //print my string
    add sp, sp, #8 //clear the two pushing of r0's off the stack

    //Logical Shift Right == lsr
    //both of these instructions do the same thing
    lsr r0, r4, r5 //pusedo operation
    mov r0, r4, lsr r5 //translate to this
    //print the thing
    //"%d (0x%08X) LSR #%d = %d (0x%08X)\n"
    mov r1, r4
    mov r2, r4 //hex version
    mov r3, r5
    push {r0}
    push {r0} //hex version
    ldr r0, =outlsr
    bl printf
    //clean up after my self by the dishes
    add sp, #8

    //Arithmetic Shift Right == asr
    //both of these instructions do the same thing
    asr r0, r4, r5 //pusedo operation
    mov r0, r4, asr r5 //translate to this
    //print the thing
    //"%d (0x%08X) ASR #%d = %d (0x%08X)\n"
    mov r1, r4 //value as 2nd param
    mov r2, r4 //value as hex as the 3rd param
    mov r3, r5 //shifting by x as the 4th param
    //we have exceeded our 4 parameter limit once i load the string
    //so now we have use the stack to put anymore parameters in
    push {r0} //puts the answer onto the stack which that temp storage area
    push {r0} //put the answer on the stack again to get the hex format
    ldr r0, =outasr
    bl printf
    //clean up after my self by the dishes
    add sp, #8
 

    //ROtate Right == ROR
    //cirular shifting where numbers on the right that get pushed off go to the leftside
    //checkout this link for a picture
    //https://onlinetoolz.net/bitshift#base=10&value=65&bits=7&steps=2&dir=r&type=circ&allsteps=1
    //both of these instructions do the same thing
    ror r0, r4, r5 //pusedo operation
    mov r0, r4, ror r5 //translate to this
    //print the thing
    //"%d (0x%08X) ROR #%d = %d (0x%08X)\n"
    mov r1, r4 //value as 2nd param
    mov r2, r4 //value as hex as the 3rd param
    mov r3, r5 //shifting by x as the 4th param
    //we have exceeded our 4 parameter limit once i load the string
    //so now we have use the stack to put anymore parameters in
    push {r0} //puts the answer onto the stack which that temp storage area
    push {r0} //put the answer on the stack again to get the hex format
    ldr r0, =outror
    bl printf
    //clean up after my self by the dishes
    add sp, #8


    //"%d (0x%08X) ROL #%d = %d (0x%08X)\n"
    rsb r0, r5, #32  //32-2
    ror r0, r4, r0 //pusedo operation
    mov r0, r4, ror r0 //translate to this
    //print the thing
    //"%d (0x%08X) ROR #%d = %d (0x%08X)\n"
    mov r1, r4 //value as 2nd param
    mov r2, r4 //value as hex as the 3rd param
    mov r3, r5 //shifting by x as the 4th param
    //we have exceeded our 4 parameter limit once i load the string
    //so now we have use the stack to put anymore parameters in
    push {r0} //puts the answer onto the stack which that temp storage area
    push {r0} //put the answer on the stack again to get the hex format
    ldr r0, =outrol
    bl printf
    //clean up after my self by the dishes
    add sp, #8

    mov r0, #0 //return 0;
    pop {pc}
