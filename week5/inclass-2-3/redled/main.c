#include "stdio.h"
#include "wiringPi.h"
#include "stdbool.h"

#define PIN_LED 21

int main(){
    //initalize always needs for anything gpio
    wiringPiSetupGpio();

    //set the pin mode
    pinMode( PIN_LED, OUTPUT );  //sets the pin 21 to be output(1) mode 
    
    bool on = false;

    //while the program is on forever
    while( true ){
        if( on ){
            //turn on the pin
            digitalWrite( PIN_LED, HIGH ); //turn the pin 21 on(HIGH)
            on = false;
        } else {
            //turn off the pin
            digitalWrite( PIN_LED, LOW ); //turn the pin 21 off(LOW)
            on = true;
        }

        delay( 250 ); //delay in milliseconds
    }

    return 0;
}