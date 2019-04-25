/*
 * spi.c
 *
 *
 */

#include "spi.h"

void EUSCIB0_IRQHandler(void) {
    uint8_t rxdata;
    if(EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG) {
        rxdata = EUSCI_B0->TXBUF;                       //read data
        while(!(EUSCI_B0->IFG & EUSCI_B0_IFG_TXIFG));   //wait for TXBUF
        EUSCI_B0->TXBUF = rxdata;                       //clean and copy received data
    }
}


