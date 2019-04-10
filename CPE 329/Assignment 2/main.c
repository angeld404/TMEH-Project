#include "msp.h"
#include "set_dco.h"

/**
 * main.c
 */

void main(void) {
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;     // stop watchdog timer


    P1 ->DIR |= (BIT0);
    P1 ->OUT |= (BIT0);
    set_DCO(FREQ_3_MHZ);

    //set P4.3 to MCLCK
    P4 ->SEL0 |= (BIT3);
    P4 ->SEL1 &= ~(BIT3);
    P4 ->DIR |= (BIT3);
    while(1){}


 }


