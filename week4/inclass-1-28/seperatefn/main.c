#include "stdio.h"
#include "stdint.h"

//extern means its going to be somewhere else in this case its going to be in arm32
extern uint32_t addVal( uint32_t a, uint32_t b );

int main(){

    uint32_t a, b, c;
    a = 4;
    b = 2;
    c = addVal( a, b );

    printf ( "a = %d\n", a );
    printf ( "b = %d\n", b );
    printf ( "c = %d\n", c );

}