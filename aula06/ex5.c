#include <detpic32.h>

int main(void)
{
    TRISBbits.TRISB4 = 1;       // RB4 digital output disconnected
    
    AD1PCFGbits.PCFG4= 0;       // RB4 configured as analog input
    AD1CON1bits.SSRC = 7;       // Conversion trigger selection bits: in this
                                // mode an internal counter ends sampling and
                                // starts conversion
    AD1CON1bits.CLRASAM = 1;    // Stop conversions when the 1st A/D converter
                                // interrupt is generated. At the same time,
                                // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16;      // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 4-1;     // Interrupt is generated after XX samples
                                // (replace XX by the desired number of
                                // consecutive samples)
    AD1CHSbits.CH0SA = 4;       // replace x by the desired input
                                // analog channel (0 to 15)
    AD1CON1bits.ON = 1;         // Enable A/D converter
                                // This must the last command of the A/D
                                // configuration sequence 
    while(1)
    {
        AD1CON1bits.ASAM = 1;               // start conversion
        while( IFS1bits.AD1IF == 0 );       // Wait while conversion not done (AD1IF == 0) 
        //printInt(ADC1BUF0, 16 | 3 << 16);
        //printf("\r%4d",ADC1BUF0);           // Read conversion result (ADC1BUF0 value) and print it
        int *p = (int *)(&ADC1BUF0);
        int i;
        int VAL_AD = ADC1BUF0;
        printf("\r");
        for(i = 0; i < 16; i++ ) {
            printf( "%4d ", p[i*4]);
        }
        printf(" Volts: %2d", (VAL_AD*33+511)/1023);
        IFS1bits.AD1IF = 0;                 // reset AD1IF
    }
}