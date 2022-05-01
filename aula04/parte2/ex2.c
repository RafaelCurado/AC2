#include <detpic32.h>

void delay(unsigned ms);

int main(void)
{
    unsigned char segment;
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;         // enable display low (RD5) and disable display high (RD6)
    TRISD = TRISD & 0XFF9F;     // configure RD5-RD6 as outputs
    TRISB = TRISB & 0X80FF;     // configure RB8-RB14 as outputs
    
    int i;
    while(1)
    {
        segment = 1;
        for(i=0; i < 7; i++)
        {
            LATB = (LATB & 0x80FF) | segment<<8;     // send "segment" value to display
            delay(60);                              // wait 0.5 second
            segment = segment << 1;
        }
        LATDbits.LATD5 = !LATDbits.LATD5;
        LATDbits.LATD6 = !LATDbits.LATD6;
    }
    return 0;
} 


void delay(unsigned int ms)
{
 resetCoreTimer();
 while(readCoreTimer() < 20000 * ms);
} 