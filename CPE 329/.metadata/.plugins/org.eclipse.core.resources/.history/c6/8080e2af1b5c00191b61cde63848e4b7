#include "msp.h"
#include "set_dco.h"
#include "delay_us.h"

/**
 * Jonathan Lau, Angel Delgado
 * CPE 329 Spring 2019
 * Professor Hummel
 *
 * Assignment 2:  Blinking LED, Clock Control, and Software Delay
 */

void main(void) {
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;     // stop watchdog timer


    //set MCLK to DCO at nominal 48 MHz
    set_DCO(FREQ_1_5_MHZ);

    //set P4.3 to MCLCK
    P4 ->SEL0 |= (BIT3);
    P4 ->SEL1 &= ~(BIT3);
    P4 ->DIR |= (BIT3);

    P6 ->DIR |= BIT0;
    P6 ->OUT |= BIT0;
    delay_us(0);
    P6 ->OUT &= ~BIT0;

    while(1){
        //P1 ->OUT ^= XOR_TOGGLE;
    }

 }


