.global main

.extern wiringPiSetupGpio
.extern pinMode
.extern digitalRead
.extern delay
.extern digitalWrite

.equ PIN_R, 5
.equ PIN_G, 6
.equ PIN_B, 21
.equ PIN_BUTTON, 12
.equ HIGH, 1
.equ LOW, 0
.equ INPUT, 0
.equ OUTPUT, 1

.text
main:
    push {lr}


    //init
    bl wiringPiSetupGpio        @ wiringPiSetupGpio();

    //set pin modes
    ldr r0, =#PIN_R
    mov r1, #OUTPUT
    bl pinMode                  @ pinMode( PIN_R , OUTPUT );    

    mov r0, #PIN_G
    mov r1, #OUTPUT
    bl pinMode                  @ pinMode( PIN_G , OUTPUT );

    mov r0, #PIN_B
    mov r1, #OUTPUT
    bl pinMode                  @ pinMode( PIN_B , OUTPUT );
    
    mov r0, #PIN_BUTTON
    mov r1, #INPUT
    bl pinMode                  @ pinMode( PIN_BUTTON , INPUT );    

    mov r4, #0                  @ int phase = 0;
    mov r5, #0                  @ bool on = true;

    while:                      @ while( 1 ){
        mov r0, #PIN_BUTTON
        bl digitalRead //r0 for what the pin is
        cmp r0, #HIGH           @ if( digitalRead( PIN_BUTTON ) == HIGH ){
        moveq r5, #1            @ on = true;
        movne r5, #0            @ on = false;

        cmp r5, #0              @ if( on ){
        beq skip

            //move/copy phase to r0 for rgb call
            mov r0, r4
            bl rgb                      @ rgb( phase ); //sets the color

            //update phase
            add r4, r4, #1
            and r4, r4, #0b111          @ phase = ( phase + 1 ) & 0b111;  //looping 0-7 number
                                @ }
        skip:

        mov r0, #1000
        bl delay                @ delay( 1000 );
    @ }
    @ return 0;
    pop {pc}
//end main

//parameter 
//r0 = phase
rgb:
    push {r4,lr}
    mov r4, r0 //keep it in a safe spot
    bl clear        @ clear();
    //red
    tst r4, #0b100
    //since 
    //rgb
    //101 & 100 is equal to 100
    //it is not zero therefore the zero flag is off
    movne r0, #PIN_R
    movne r1, #HIGH
    blne digitalWrite       @ if( phase & 0b100 ) digitalWrite( PIN_R, HIGH ); //if the leftmost bit is on turn on red

    //green
    tst r4, #0b010
    movne r0, #PIN_G
    movne r1, #HIGH
    blne digitalWrite       @ if( phase & 0b010 ) digitalWrite( PIN_G, HIGH ); //if the middle bit is on turn on green
    
    //blue
    tst r4, #0b001
    movne r0, #PIN_B
    movne r1, #HIGH
    blne digitalWrite       @ if( phase & 0b001 ) digitalWrite( PIN_B, HIGH ); //if the rightmost bit is on turn on blue  

    pop {r4,pc}
//end rgb

clear:
    push {lr}
    mov r0, #PIN_R
    mov r1, #LOW
    bl digitalWrite         @ digitalWrite( PIN_R, LOW );

    mov r0, #PIN_G
    mov r1, #LOW
    bl digitalWrite         @ digitalWrite( PIN_G, LOW );
    
    mov r0, #PIN_B
    mov r1, #LOW
    bl digitalWrite         @ digitalWrite( PIN_B, LOW );
    pop {pc}
//end clear
