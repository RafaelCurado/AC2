#include <detpic32.h>

void send2displays(unsigned char value);
void delay(unsigned int ms);

int main(void)
{
    TRISD = TRISD & 0XFF9F;     // configure RD5-RD6 as outputs
    TRISB = TRISB & 0X80FF;     // configure RB8-RB14 as outputs

    // declare variables
    // initialize ports
    int counter = 0;
    int i;
    while(1)
    {
        i = 0;
        do
        {
            send2displays(counter);
            delay(10);                  // wait 10
        } while(++i < 20);
        counter++;
        // increment counter (mod 256)
        if(counter > 256) 
        {
            counter = 0;
        }
    }
    return 0;
}


void send2displays(unsigned char value)
{
    static const char display7Scodes[] = {0x3F, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67, 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71};
    
    static char displayFlag = 0;
    unsigned char dh = value >> 4;      
    unsigned char dl = value & 0xf;     

    dh = display7Scodes[dh];
    dl = display7Scodes[dl];

    if(displayFlag == 0) {  
        LATD = (LATD | 0x0040) & 0xFFDF;
        LATB = (LATB & 0x80FF) | ((unsigned int)(dh)) << 8;
    }
    else {
        LATD = (LATD | 0x0020) & 0xFFBF;
        LATB = (LATB & 0x80FF) | ((unsigned int)(dl)) << 8;
    } 
    
   displayFlag = !displayFlag;          
}

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}