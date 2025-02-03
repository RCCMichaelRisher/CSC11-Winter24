.global main


.extern wiringPiSetupGpio
.extern pinMode
.extern digitalRead
.extern digitalWrite
.extern delay

//constants
.equ PIN_BUTTON, 18
.equ PIN_LED, 17
.equ LOW, 0
.equ HIGH, 1
.equ INPUT, 0
.equ OUTPUT, 1

main:
    push {lr}
    @ //inti gpio
    bl wiringPiSetupGpio    @ wiringPiSetupGpio();

    @ //set pin modes
    mov r0, #PIN_BUTTON
    mov r1, #INPUT
    bl pinMode              @ pinMode( PIN_BUTTON, INPUT );


    mov r0, #PIN_LED
    mov r1, #OUTPUT
    bl pinMode              @ pinMode( PIN_LED, OUTPUT );

    @ //infinite loop
    while:                  @ while( 1 ){
        mov r0, #PIN_BUTTON
        bl digitalRead //thats the result in r0
        cmp r0, #HIGH       @ if( digitalRead( PIN_BUTTON ) == HIGH ){
        mov r0, #PIN_LED 
        moveq r1, #HIGH //if r0 is high put high into r1
        movne r1, #LOW  //if r0 is low then put low into r1
        bl digitalWrite //always run wirte

        //do the delay
        mov r0, #100
        bl delay            @ delay( 250 ); //delay
        
        bal while
    @ }

    mov r0, #0              @ return 0;
    pop {pc}
