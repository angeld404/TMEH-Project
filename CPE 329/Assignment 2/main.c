/**
 *  main.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Assignment 7: SPI DAC and waveform generation
 */

#include "msp.h"
#include "spi.h"
#include "set_dco.h"
#include "delay_us.h"

void main(void) {
    // stop watchdog timer
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

    //set MCLK and SMCLK to DCO, 12 MHz
    set_DCO(FREQ_12_MHZ);

    SPI_init();

    //INTERRUPT ENABLE
    NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);    //Timer_A0_0
    NVIC->ISER[0] |= 1 << (TA0_N_IRQn & 31);    //Timer_A0_N
    NVIC->ISER[0] = (1 << (EUSCIB0_IRQn & 31)); //EUSCIB0
    __enable_irq();         //Enable Interrupts Globally

    int data, loByte, hiByte;

    while(1) {
        for(data = 0; data < 4096; data++){

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
    }

 }  //end main()




