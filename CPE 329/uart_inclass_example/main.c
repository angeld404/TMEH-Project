/*
 *  ======= main ========
 *
 *  Created on: May 3, 2019
 *  Author:     jlau30
 *
 *  UART - Universal Asynchronous Receiver-Transmitter
 *      > asynchronous: no clock input from MCU to peripheral
 *      > devices must agree on predetermined speed
 *      > braud rate: bits per second (bps)
 *      > typical range: 300 bps - 115.2 kbps, most commonly 9.6 kbps
 *
 *  RS-232 - Recommended Standard #232 protocol
 *      > send start bit (0)
 *      > data bits (5 to 9 bits, usually 8)
 *      > parity bit (optional)
 *      > stop bit (1)
 *      > second stop bit (optional, also a 1)
 *
 *  note:
 *      > only EUSCI_A has UART mode
 *      > refer to reference manual section 24.3.10 for baud rate math
 */

#include "msp.h"
#include <string.h>
#include "set_dco.h"
//#include "delay_us.h"
#include "uart.h"

void main(void) {
     //stop watchdog timer
     WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

     //set MCLK to DCO at nominal 3 MHz
     set_DCO(FREQ_3_MHZ);

     //initialize UART
     UART_init();

     while(1) {
         //UART_tx_string("RECEIVED: ");
     }
}

void EUSCI_A0_IRQHandler(void) {
    volatile char got = EUSCI_A0->RXBUF;
    UART_rx_echo(got);
    EUSCI_A0->IFG &= ~EUSCI_A_IFG_RXIFG;
}
