#include "wiringPi.h"
#include "stdbool.h"
#include "stdio.h"

#define PIN_R 5
#define PIN_G 6
#define PIN_B 21
#define PIN_BUTTON 12

void rgb( int );
void clear();

int main(){

    //init
    wiringPiSetupGpio();

    //set pin modes
    pinMode( PIN_R , OUTPUT );    
    pinMode( PIN_G , OUTPUT );
    pinMode( PIN_B , OUTPUT );
    pinMode( PIN_BUTTON , INPUT );    

    int phase = 0;
    bool on = true;

    while( 1 ){
        if( digitalRead( PIN_BUTTON ) == HIGH ){
            on =true;
        } else {
            on =false;
        }

        if( on ){
            rgb( phase ); //sets the color
            printf( "phase %d\n", phase ); //prints debug
            phase = ( phase + 1 ) & 0b111;  //looping 0-7 number
        }

        delay( 1000 );
    }
    return 0;
}

void rgb( int phase ){
    clear();
    if( phase & 0b100 ) digitalWrite( PIN_R, HIGH ); //if the leftmost bit is on turn on red
    if( phase & 0b010 ) digitalWrite( PIN_G, HIGH ); //if the middle bit is on turn on green
    if( phase & 0b001 ) digitalWrite( PIN_B, HIGH ); //if the rightmost bit is on turn on blue
    return;
}

//this just resets everything before we write the new setting
void clear(){
    digitalWrite( PIN_R, LOW );
    digitalWrite( PIN_G, LOW );
    digitalWrite( PIN_B, LOW );
    return;
}