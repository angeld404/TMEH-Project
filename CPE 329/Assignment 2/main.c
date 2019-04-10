#include "msp.h"
#include "set_dco.h"

/**
 * main.c
 */

void main(void) {
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;     // stop watchdog timer


    //set MCLK to DCO at nominal 48 MHz
    set_DCO(FREQ_48_MHZ);

    //set P4.3 to MCLCK
    P4 ->SEL0 |= (BIT3);
    P4 ->SEL1 &= ~(BIT3);
    P4 ->DIR |= (BIT3);

    P1 ->DIR |= BIT0;
    P2 ->OUT |= BIT0;

    while(1){
        P1 ->OUT ^= XOR_TOGGLE;
        delay_us(40);
    }


 }


