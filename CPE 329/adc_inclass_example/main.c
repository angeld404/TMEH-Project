/**
 * main.c
 *
 * in-class ADC example
 *      -> use ADC14 on channel A0 (P5.5)
 *      -> save samples to location 17 (channel and memory location don't have to match)
 *      -> use HSMCLK
 *      -> sample for 96 clocks
 *
 * Sample exactly once.
 */

#include "msp.h"

void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	// set ADC on SMCLK using HFXT crystal here

	// initialize ADC
	ADC14_init();

	while(1) {
	    ADC14->CTL0 |= ADC14_CTL0_SC;   //start a conversion
	    //delay_us(1000);
	}
}

void ADC14_IRQHandler(void) {
    volatile uint16_t analogValue = ADC14->MEM[17];

}
