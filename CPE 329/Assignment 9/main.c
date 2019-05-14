/**
 * main.c
 *
 * Assignment 9: Analog to Digital Conversion
 * CPE 329, Spring 2019
 * Jonathan Lau, Angel Delgado
 * Professor Hummel
 *
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "msp.h"
#include "set_clk.h"
#include "adc.h"
#include "uart.h"
#include "DAC.h"
#include "delay_us.h"
#include "spi.h"
#include "timer.h"

int analogValue = 0;
int adc_int = 0;
char adc_char[14];

void main(void) {
    //stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	//initialize HSMCLK and SMCLK to HFXT, 48 MHz
    set_HFXT();
	//initialize DCO
	set_DCO(FREQ_24_MHZ);

	//initialize ADC14
	ADC14_init();

	//initialize Timer_A
	Timer_A_init(1, 2, 1, 3);

	//initialize SPI
	//SPI_init();

	//enable interrupts globally
    __enable_irq();

    //uint16_t analogValue = ADC14->MEM[17];
	while(1) {
	    __wfi();
	    //ADC14->CTL0 |= ADC14_CTL0_SC;   //start a conversion
	    delay_us(1000);
	}

}   // end main()

void ADC14IRQHandler(void) {
    volatile uint16_t analogValue = ADC14->MEM[17];
}
