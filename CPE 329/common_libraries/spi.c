/*
 * spi.c
 *
 */

#include "msp.h"
#include "spi.h"
#include "delay_us.h"

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
    P3->DIR |= (BIT6);              // CS chip select

    EUSCI_B0->CTLW0 &= ~EUSCI_B_CTLW0_SWRST;
    // end SPI and ports initialization
}

void SPI_TX(int data){

    int loByte = data & 0xFF;           //lower 8 bits of data
    int hiByte = (data >> 8) & 0x0F;    //lower 4 of upper 8 bits

    hiByte |= (BIT4 | BIT5); //Set Gain and Shutdown config bits.

    P3 ->OUT &= ~BIT6;      //set CS low
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = hiByte;                       //push hiByte to TX register
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = loByte;                       //push loByte to TX register
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG));    //wait for transmission to end
    P3->OUT |= BIT6;        //set CS high

    delay_us(200);          //hold voltage for 200us
}
