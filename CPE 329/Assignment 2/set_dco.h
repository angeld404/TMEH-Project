#include "msp.h"

#define FREQ_1_5_MHZ BIT0
#define FREQ_3_MHZ BIT1
#define FREQ_6_MHZ BIT2
#define FREQ_12_MHZ BIT3
#define FREQ_24_MHZ BIT4
#define FREQ_48_MHZ BIT5




void set_DCO(int Freq)
{
    CS->KEY = CS_KEY_VAL;
    CS->CTL1 |= (BIT1 | BIT0);
    CS->CTL0 &= ~ CS_CTL0_DCORSEL_MASK;
    if (Freq == FREQ_1_5_MHZ){
        CS->CTL0 |= CS_CTL0_DCORSEL_0;
    }
    else if(Freq == FREQ_3_MHZ)
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_1;
        }
    else if(Freq == FREQ_6_MHZ)
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_2;
        }
    else if(Freq == FREQ_12_MHZ)
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_3;
        }
    else if (Freq == FREQ_24_MHZ)
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_4;
        }
    else if(Freq == FREQ_48_MHZ)
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_5;
        }
    else
        {}


    CS->KEY &= 0x0000;

}
