/*
 * uart.c
 *
 *  Created on: May 3, 2019
 *      Author: jlau30
 */


#include "msp.h"
#include "uart.h"

void UART_init() {
    //put in reset
    EUSCI_A0->CTLW0 |= EUSCI_A_CTLW0_SWRST;

    EUSCI_A0->CTLW0 = EUSCI_A_CTLW0_PEN         // enable parity odd
                    | EUSCI_A_CTLW0_SPB         // 2 stop bits
                    | EUSCI_A_CTLW0_MODE_0      // UART MODE
                    | EUSCI_A_CTLW0_UCSSEL_2    // select SMCLK
                    | EUSCI_A_CTLW0_SWRST;      // keep in reset

    //from baud rate calculation
    EUSCI_A0->BRW = 1;

    //BRF OFS 4 t shift value into correct place
    //OS16 enable oversampling
    EUSCI_A0->MCTLW = (10 << EUSCI_A_MCTLW_BRF_OFS) | EUSCI_A_MCTLW_OS1;

    //configure TX RX pins
    P1->SEL0 |= (BIT2|BIT3);
    P1->SEL1 &= ~(BIT2|BIT3);

    EUSCI_A0->CTLW0 &= ~EUSCI_A_CTLW0_SWRST;    //take out of reset


}





