#include <detpic32.h>

void delay(unsigned int ms);

int main(void)
{
    LATDbits.LATD5 = 0;
    LATDbits.LATD6 = 1;
    TRISD = TRISD & 0XFF9F;
    TRISB = TRISB & 0X80FF;

    while(1) 
    {
        char c = getChar();

        switch(c) {
            case 'a':
            case 'A':
                LATB = (LATB & 0x80FF) | 0x0100;
                break;
            case 'b':
            case 'B':
                LATB = (LATB & 0x80FF) | 0x0200;
                break;
            case 'c':
            case 'C':
                LATB = (LATB & 0x80FF) | 0x0400;
                break;
            case 'd':
            case 'D':
                LATB = (LATB & 0x80FF) | 0x0800;
                break;
            case 'e':
            case 'E':
                LATB = (LATB & 0x80FF) | 0x1000;
                break;
            case 'f':
            case 'F':
                LATB = (LATB & 0x80FF) | 0x2000;
                break;
            case 'g':
            case 'G':
                LATB = (LATB & 0x80FF) | 0x4000;
                break;
        }
    }
    return 0;
}

void delay(unsigned int ms)
{
 resetCoreTimer();
 while(readCoreTimer() < 20000 * ms);
} 
