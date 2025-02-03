.global main

.extern wiringPiSetupGpio
.extern pinMode
.extern digitalWrite
.extern delay

//constants
.equ PIN_LED, 21
.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1

.text
main:
    push {lr}

    //initalize always needs for anything gpio
    bl wiringPiSetupGpio            @ wiringPiSetupGpio();

    //set the pin mode
    mov r0, #PIN_LED
    mov r1, #OUTPUT
    bl pinMode                      @ pinMode( PIN_LED, OUTPUT );  //sets the pin 21 to be output(1) mode 

    mov r4, #0                      @ bool on = false;

    //while the program is on forever
    while:                          @ while( true ){
        cmp r4, #1                      @ if( on ){
        //turn on the pin
        beq on
        bne off
        on:
            mov r0, #PIN_LED
            mov r1, #HIGH
            bl digitalWrite             @ digitalWrite( PIN_LED, HIGH ); //turn the pin 21 on(HIGH)
            mov r4, #0                  @ on = false;
            b delayLabel        
        off: 
            //turn off the pin
            mov r0, #PIN_LED
            mov r1, #LOW
            bl digitalWrite             @ digitalWrite( PIN_LED, LOW ); //turn the pin 21 off(LOW)
            mov r4, #1                  @ on = true;
        delayLabel:
        mov r0, #250
        bl delay                        @ delay( 250 ); //delay in milliseconds
                                    @ }   
    mov r0, #0                      @ return 0;
    pop {pc}
