/*
 * lcd.c
 *
 *  Created on: Apr 10, 2019
 *      Author: jonat
 */

#include "msp.h"
#include "set_dco.h"
#include "delay_us.h"


void main(void) {
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;     // stop watchdog timer


    //set MCLK to DCO at nominal 24 MHz
    set_DCO(FREQ_24_MHZ);

    //set P9 as LCD data bus
    P9->DIR |= 0xFF;

    //initialize LCD driver

    while(1){}

 }