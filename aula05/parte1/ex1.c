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