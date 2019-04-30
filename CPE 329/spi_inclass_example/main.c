/**
 * main.c
 *
 * Serial Peripheral Interface lecture example
 *  -> full duplex
 *  -> synchronous
 *  -> low power
 *  -> connected independently OR daisy-chain
 *  -> no speed limit
 *
 *  Communication lines:
 *      -> SCLK: serial clock
 *      -> MOSI: master out slave in
 *      -> MISO: master in slave out
 *      -> SS/CS: slave select/chip select
 *
 *  EUSCI_B0 -> PIN 1.5, 1.6, 1.7
 *
 *  this example receives data and sends same data back.
 **/

#include "msp.h"
#include "set_dco.h"
#include "spi.h"

void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	set_DCO(FREQ_12_MHZ);

	uint_8_t data = 1;   //some arbitrary 8-bit value

	EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_SWRST;     //reset serial state machine
	EUSCI_B0->CTLW0 = ( EUSCI_B_CTLW0_MST       //master mode
	                  | EUSCI_B_CTLW0_SYNC      //synchronous
	                  | EUSCI_B_CTLW0_UCSSEL_2  //use SMCLK
	                  | EUSCI_B_CTLW0_SWRST );  //stay in reset

	EUSCI_B0->BRW = 0x01;   //run at full SMCLK speed

	P1->SEL0 |= (BIT5 | BIT6 | BIT7);   //configure port mode to EUSCI_B0
    P1->SEL1 &= ~(BIT5 | BIT6 | BIT7);

    EUSCI_B0->CTLW0 &= ~EUSCI_B_CTLW0_SWRST;    //clear reset to activate peripheral

    EUSCI_B0->IE |= EUSCI_B_IE_RXIE;    //set interrupt en

    //set interrupt
    NVIC->ISER[0] = (1 << (EUSCIB0_IRQn & 31));
    __enable_irq();

	while(!(EUSCI_B0->IFG & EUSCI_B0_IFG_TXIFG));

	EUSCI_B0->TXBUF = data;

	while(1);
}
