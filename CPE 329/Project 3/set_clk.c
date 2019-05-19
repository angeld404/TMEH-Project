/*
 * set_DCO.c
 *
 */

#include "set_clk.h"
#include "msp.h"

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

    CS->CTL1 |= CS_CTL1_SELM__DCOCLK;       //set MCLK to (DCO, 24 MHz)

    CS->KEY &= 0x0000;      // lock CS registers

}   //end set_DCO()

void set_HFXT() {
    /* Configure HFXT to use 48MHz crystal, source to MCLK & HSMCLK*/
    PJ->SEL0 |= BIT2 | BIT3; // Configure PJ.2/3 for HFXT function
    PJ->SEL1 &= ~(BIT2 | BIT3);

    /* Transition to VCORE Level 1: AM0_LDO --> AM1_LDO */
    while ((PCM->CTL1 & PCM_CTL1_PMR_BUSY));
     PCM->CTL0 = PCM_CTL0_KEY_VAL | PCM_CTL0_AMR_1;
    while ((PCM->CTL1 & PCM_CTL1_PMR_BUSY));

    /* Configure Flash wait-state to 1 for both banks 0 & 1 */
    FLCTL->BANK0_RDCTL = (FLCTL->BANK0_RDCTL &
     ~(FLCTL_BANK0_RDCTL_WAIT_MASK)) | FLCTL_BANK0_RDCTL_WAIT_1;
    FLCTL->BANK1_RDCTL = (FLCTL->BANK0_RDCTL &
     ~(FLCTL_BANK1_RDCTL_WAIT_MASK)) | FLCTL_BANK1_RDCTL_WAIT_1;

    /* Configure HFXT to use 48MHz crystal, source to MCLK & HSMCLK*/
    PJ->SEL0 |= BIT2 | BIT3; // Configure PJ.2/3 for HFXT function
    PJ->SEL1 &= ~(BIT2 | BIT3);

    CS->KEY = CS_KEY_VAL ; // Unlock CS module for register access

    CS->CTL2 |= CS_CTL2_HFXT_EN | CS_CTL2_HFXTFREQ_6 | CS_CTL2_HFXTDRIVE;
    while(CS->IFG & CS_IFG_HFXTIFG) CS->CLRIFG |= CS_CLRIFG_CLR_HFXTIFG;

    /* Select MCLK & HSMCLK = HFXT, no divider */
    CS->CTL1 = CS->CTL1
             & ~(CS_CTL1_SELM_MASK | CS_CTL1_DIVM_MASK | CS_CTL1_SELS_MASK | CS_CTL1_DIVHS_MASK)
             | CS_CTL1_SELM__HFXTCLK | CS_CTL1_SELS__HFXTCLK | CS_CTL1_DIVS__2;

    //CS->CTL1 |= CS_CTL1_DIVS__128;
    //CS->CTL1 |= CS_CTL1_DIVHS__128;

    CS->KEY = 0; // Lock CS module from unintended access

}   //end set_HFXT()

