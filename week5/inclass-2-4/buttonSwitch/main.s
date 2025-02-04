.global main

.extern wiringPiSetupGpio
.extern pinMode
.extern digitalRead
.extern delay
.extern digitalWrite

.equ PIN_LED, 18
.equ PIN_BUTTON, 16
.equ HIGH, 1
.equ LOW, 0
.equ INPUT, 0
.equ OUTPUT, 1

.text
main:
    push {lr}
    //init
    bl wiringPiSetupGpio            @ wiringPiSetupGpio();

    @ //set pin modes
    mov r0, #PIN_LED
    mov r1, #OUTPUT
    bl pinMode                      @ pinMode( PIN_LED , OUTPUT );    
    
    mov r0, #PIN_BUTTON
    mov r1, #INPUT
    bl pinMode                      @ pinMode( PIN_BUTTON , INPUT ); 

    mov r4, #0                      @ int ledState = 0;
    mov r5, #0                      @ int prevBtnState = 0;

    while:                          @ while( 1 ){
        //gets the input before happens this tick
        mov r0, #PIN_BUTTON
        bl digitalRead //puts the result into r0
        mov r6, r0                  @ int currentBtnState = digitalRead( PIN_BUTTON );

        //if the button was pressed this tick and the previous button state was off
        cmp r6, #1
        bne skip
        cmp r5, #0
        bne skip                    @ if( currentBtnState == 1 && prevBtnState == 0 ){

        @ printf( "pressed the button\n" );
        //0->1 1->0
        eor r4, r4, #1              @ ledState = !ledState;

        mov r0, #PIN_LED
        mov r1, r4
        bl digitalWrite             @ digitalWrite( PIN_LED, ledState );
        @ }
        skip:
        //update my button state for next tick
        mov r5, r6                  @ prevBtnState = currentBtnState;

        mov r0, #50
        bl delay                    @ delay( 50 );
        bal while
    @ }

    pop {pc}
