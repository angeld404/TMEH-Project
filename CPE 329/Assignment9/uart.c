/*
 * uart.c
 *
 */

#include <string.h>
#include "msp.h"
#include "uart.h"

void UART_init() {

    EUSCI_A0->CTLW0 |= EUSCI_A_CTLW0_SWRST;     //put in reset

    EUSCI_A0->CTLW0 = EUSCI_A_CTLW0_PEN         // enable parity odd
                    | EUSCI_A_CTLW0_SPB         // 2 stop bits
                    | EUSCI_A_CTLW0_MODE_0      // UART MODE
                    | EUSCI_A_CTLW0_UCSSEL_2    // select SMCLK
                    | EUSCI_A_CTLW0_SWRST;      // keep in reset

    //from baud rate calculation
    EUSCI_A0->BRW = 0;

    //BRF_OFS 4 t shift value into correct place
    //OS16 enable oversampling
    EUSCI_A0->MCTLW = (10 << EUSCI_A_MCTLW_BRF_OFS) | EUSCI_A_MCTLW_OS16;

    //configure TX RX pins
    P1->SEL0 |= (BIT2|BIT3);
    P1->SEL1 &= ~(BIT2|BIT3);

    EUSCI_A0->CTLW0 &= ~EUSCI_A_CTLW0_SWRST;        //take out of reset

    //interrupt enables


}

void UART_tx_char(char a) {
    while (!(EUSCI_A0->IFG & EUSCI_A_IFG_TXIFG));   // wait until the tx buffer is empty
    EUSCI_A0->TXBUF = a;                            // send ASCII char to serial terminal
}

void UART_tx_string(char *phrase) {
    int i;
    for(i = 0; i < strlen(phrase); i++) {
        UART_tx_char(phrase[i]);
    }
}

void UART_rx_echo(char echo) {
    UART_tx_char(echo);
}






