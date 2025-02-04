#include "wiringPi.h"
#include "stdbool.h"
#include "stdio.h"

#define PIN_LED 18
#define PIN_BUTTON 16

int main(){

    //init
    wiringPiSetupGpio();

    //set pin modes
    pinMode( PIN_LED , OUTPUT );    
    pinMode( PIN_BUTTON , INPUT ); 

    int ledState = 0;
    int prevBtnState = 0;

    while( 1 ){
        //gets the input before happens this tick
        int currentBtnState = digitalRead( PIN_BUTTON );

        //if the button was pressed this tick and the previous button state was off
        if( currentBtnState == 1 && prevBtnState == 0 ){
            printf( "pressed the button\n" );
            ledState = !ledState;
            digitalWrite( PIN_LED, HIGH );
        }

        //update my button state for next tick
        prevBtnState = currentBtnState;
        
        delay( 50 );
    }

    return 0;
}