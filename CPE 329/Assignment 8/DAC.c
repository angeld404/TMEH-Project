/*
 * DAC.c
 *
 */

#include "msp.h"
#include "DAC.h"
#include "delay_us.h"

//outputs desired analog DC value to DAC via SPI
void DAC_DCV(int DCV) {             //32767 absolute maximum DC value
                                    //DCV = desired analog DC value output * 10,000
    int data, loByte, hiByte;
    data = DCV >> 3;                //convert DCV to 12-bit data value
                                    //divide DCV by resolution, resolution = 0.8 mV

    loByte = data & 0xFF;           //lower 8 bits of data
    hiByte = (data >> 8) & 0x0F;    //lower 4 of upper 8 bits

    hiByte |= (BIT4 | BIT5);        //Set Gain and Shutdown config bits.

    P3 ->OUT &= ~BIT6;                              //set CS low
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = hiByte;                       //push hiByte to TX register
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = loByte;                       //push loByte to TX register
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG));    //wait for transmission to end
    P3->OUT |= BIT6;                                //set CS high

    delay_us(0); //hold voltage for 200us
}
