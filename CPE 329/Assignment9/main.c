#include "msp.h"
#include "set_dco.h"
#include "uart.h"
#include "delay_us.h"
#include "ADC.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

/**
 * main.c
 */
char terminal[4];
int enter_flg = 0;
int result = 0;
void main(void) {
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;		// stop watchdog timer

	set_DCO(FREQ_3_MHZ);

	UART_init(); //initialize UART

    EUSCI_A0->IE &= ~EUSCI_A_IE_TXIE;
    EUSCI_A0->IE &= ~EUSCI_A_IE_RXIE;
    NVIC->ISER[0] |= 1 << (EUSCIA0_IRQn & 31); //enable interrupts

    ADC_init();

	__enable_irq();
	ADC14 ->CTL0 |= ADC14_CTL0_ENC | ADC14_CTL0_SC; //start initial conversion
	while(1){



	    if (enter_flg){
	        enter_flg = 0;
	        ADC14 ->CTL0 |= ADC14_CTL0_ENC | ADC14_CTL0_SC; //start conversion
	    }
	}
}

void ADC14_IRQHandler(void){
    int result = ADC14 -> MEM[0]; //store ADC val
    result = (result*(3.3))/(16383) - .01; //convert to actual voltage
    UART_tx_int(result);
    enter_flg = 1; //set global flag

}
