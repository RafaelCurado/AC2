#include <detpic32.h>

void delay(unsigned int ms)
{
 resetCoreTimer();
 while(readCoreTimer() < 20000 * ms);
} 

int main(void)
{
    int cnt1 = 0, cnt5 = 0, cnt10 = 0;
    while(1)
    {
        delay(100);
        cnt10 += 1;
        if ( cnt10 % 2 == 0) cnt5 += 1;
        if ( cnt10 % 10 == 0) cnt1 += 1;
        printInt(cnt10, 0x0005000A);
        putChar(' ');
        printInt(cnt5, 0x0005000A);
        putChar(' ');
        printInt(cnt1, 0x0005000A);
        putChar('\r');
    
    }
    return 0;
}