/*====================================================================
 * Title: GccAppBlink1.c
 * Created: 11/24/2013 (Updated: 2026-07-19)
 * Author: khatathapswatdipisal
 * Description: AVR GCC C program to blink Port D and PB5 LEDs
 *====================================================================*/

#include <avr/io.h>

int main(void)
{
    unsigned int i, j;
    
    DDRD = 0xFF;        // Set all pins of Port D as Output
    DDRB = 0x3F;        // Set PB0-PB5 pins of Port B as Output (0b00111111)
    
    // Initial delay loop
    for (j = 0; j < 1; j++)
    {
        for (i = 0; i < 42150; i++)
        {
            // Crude software delay
        }
    }
    
    PORTD = 0x00;       // Set Port D output low
    PORTB = 0x00;       // Set Port B output low
    
    while (1)
    {
        PORTD = 0xFF;                   // Turn all Port D LEDs ON
        PORTB = PORTB | 0b00100000;     // Turn PB5 LED ON
        
        // Delay loop for 5 iterations (longer ON time)
        for (j = 0; j < 5; j++)
        {
            for (i = 0; i < 42150; i++)
            {
                // Crude software delay
            }
        }
        
        PORTD = 0x00;                   // Turn all Port D LEDs OFF
        PORTB = PORTB & ~0b00100000;    // Turn PB5 LED OFF
        
        // Delay loop for 2 iterations (shorter OFF time)
        for (j = 0; j < 2; j++)
        {
            for (i = 0; i < 42150; i++)
            {
                // Crude software delay
            }
        }
    }
    
    return 0;
}
