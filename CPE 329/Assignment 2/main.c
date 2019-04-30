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
#include "DAC.h"


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


    DAC_DCV(32767);//32767 absolute maximum DC value


    while(1) {

        DAC_DCV(0);
        delay_us(100);
        DAC_DCV(20000);
        delay_us(100);

        }
    //}

 }  //end main()




