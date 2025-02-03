#include "wiringPi.h"


#define PIN_BUTTON 18
#define PIN_LED 17

int main(){
    //inti gpio
    wiringPiSetupGpio();

    //set pin modes
    pinMode( PIN_BUTTON, INPUT );
    pinMode( PIN_LED, OUTPUT );

    //infinite loop
    while( 1 ){
        if( digitalRead( PIN_BUTTON ) == HIGH ){
            digitalWrite( PIN_LED, HIGH );
        } else {
            digitalWrite( PIN_LED, LOW );
        }
        delay( 250 ); //delay
    }

    return 0;
}