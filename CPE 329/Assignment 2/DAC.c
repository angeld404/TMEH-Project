/*
 * DAC.c
 *
 *  Created on: Apr 29, 2019
 *      Author: angel
 */

#include "msp.h"
#include "DAC.h"
#include "delay_us.h"



void DAC_DCV(int DCV){ //32767 absolute maximum DC value

    int data, loByte, hiByte;
    data = (DCV/8);

    loByte = data & 0xFF; //lower 8 bits of data
    hiByte = (data >> 8) & 0x0F; //lower 4 of upper 8 bits

    hiByte |= (BIT4 | BIT5); //Set Gain and Shutdown config bits.

    P3 ->OUT &= ~BIT6; //set CS low
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG)); //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = hiByte;       // push hiByte to TX register
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG)); //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = loByte;       // push loByte to TX register
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG)); //wait for transmission to end
    P3->OUT |= BIT6; //set CS high

    delay_us(200); //hold voltage for 200us
}




