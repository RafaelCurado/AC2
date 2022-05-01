#include <detpic32.h>

void delay(unsigned int ms);

int main(void)
{
    LATE = LATE & 0xFFF0;
    TRISE = TRISE & 0XFFF0;
    int cnt = 0;

    while(1){
        LATE = (LATE & 0XFFF0) | cnt;
        delay(250);
        cnt++;

        if(cnt > 15) {
            cnt = 0;
        }
    }
    return 0;
}

void delay(unsigned int ms)
{
 resetCoreTimer();
 while(readCoreTimer() < 20000 * ms);
} 
