/*
 * set_DCO.c
 *
 */

#include "msp.h"
#include "set_dco.h"

void set_DCO(int freq) {
    CS->KEY = CS_KEY_VAL;                   //unlock CS registers

    CS->CTL0 &= ~(CS_CTL0_DCORSEL_MASK);    //clear previous DCO frequency setting

    if (freq == FREQ_1_5_MHZ)               //DCO = 1.5 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_0;
    }
    else if(freq == FREQ_3_MHZ)             //DCO = 3 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_1;
        }
    else if(freq == FREQ_6_MHZ)             //DCO = 6 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_2;
        }
    else if(freq == FREQ_12_MHZ)            //DCO = 12 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_3;
        }
    else if (freq == FREQ_24_MHZ)           //DCO = 24 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_4;
        }
    else if(freq == FREQ_48_MHZ)            //DCO = 48 MHz
        {
            while ((PCM->CTL1 & PCM_CTL1_PMR_BUSY));
            PCM->CTL0 = PCM_CTL0_KEY_VAL | PCM_CTL0_AMR_1;
            while ((PCM->CTL1 & PCM_CTL1_PMR_BUSY));
            /* Configure Flash wait-state to 1 for both banks 0 & 1 */
            FLCTL->BANK0_RDCTL = (FLCTL->BANK0_RDCTL &
             ~(FLCTL_BANK0_RDCTL_WAIT_MASK)) | FLCTL_BANK0_RDCTL_WAIT_1;
            FLCTL->BANK1_RDCTL = (FLCTL->BANK0_RDCTL &
             ~(FLCTL_BANK1_RDCTL_WAIT_MASK)) | FLCTL_BANK1_RDCTL_WAIT_1;
            CS->CTL0 |= CS_CTL0_DCORSEL_5;
        }


    CS->KEY &= 0x0000;      // lock CS registers

}   //end set_DCO()



