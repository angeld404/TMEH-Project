/*
 * MPU_9250.c
 *
 *  Created on: May 31, 2019
 *      Author: angel
 */
#include "msp.h"
#include "delay_us.h"

/*int IMU_TX_RX(int addr){

    int loByte = addr & 0xFF;           //lower 8 bits of data
    int hiByte = (addr >> 8);    //upper 8 bits
    int data, loByteData, hiByteData;

    P3 ->OUT &= ~BIT6;      //set CS low
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = hiByte;                       //push hiByte to TX register
    __wfi();
    hiByteData = IMU_data;
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = loByte;                     //Push loByte to TX reg
    __wfi();
    loByteData = IMU_data;
    P3->OUT |= BIT6;        //set CS high

    hiByteData = hiByteData << 8;
    data = (hiByteData | loByteData);
    return data;
}
*/

