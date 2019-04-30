/*
 * spi.c
 *
 */

#include "msp.h"
#include "spi.h"

void SPI_init() {
    // initialize SPI and ports
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_SWRST;
    EUSCI_B0->CTLW0 = ( EUSCI_B_CTLW0_CKPL      // clk inactive high for mode 1.1 operation
                      | EUSCI_B_CTLW0_MSB       // MSB first
                      | EUSCI_B_CTLW0_MST       // master mode
                      | EUSCI_B_CTLW0_SYNC      // SPI is synchronous
                      | EUSCI_B_CTLW0_UCSSEL_2  // select SMCLK
                      | EUSCI_B_CTLW0_SWRST );  // keep in reset state

    EUSCI_B0->BRW = 0x01;           //full SMCLK speed

    P1->SEL0 |= (BIT5 | BIT6);      // SCLK and SIMO
    P1->SEL1 &= ~(BIT5 | BIT6);
    P3->DIR |= (BIT6);             // CS chip select

    EUSCI_B0->CTLW0 &= ~EUSCI_B_CTLW0_SWRST;
    // end SPI and ports initialization
}
