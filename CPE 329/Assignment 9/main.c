/**
 * main.c
 *
 * Assignment 9: Analog to Digital Conversion
 * CPE 329, Spring 2019
 * Jonathan Lau, Angel Delgado
 * Professor Hummel
 *
 */

#include "msp.h"
#include "set_dco.h"
#include "adc.h"

void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	set_DCO(FREQ_24_MHZ);

}   // end main()
