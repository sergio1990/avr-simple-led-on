#include <avr/io.h>

int main(void)
{
    // make the LED pin an output for PORTB5
    DDRB = 1 << 5;
    PORTB = 1 << 5;

    return 0;
}
