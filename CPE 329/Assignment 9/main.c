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

int ADCVAL = 0;

void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	set_DCO(FREQ_12_MHZ);



	ADC14_init();

    //enable interrupt
    ADC14->IER0 |= ADC14_IER0_IE17;     //enable interrupt on channel 17
    NVIC->ISER[0] = (1 << ADC14_IRQn & 31);
    __enable_irq();


    P4->DIR |= BIT4;
    P4->SEL0 |= BIT4;
    P4->SEL1 &= ~BIT4;

	while(1){
	    __wfi();


	}

}   // end main()
