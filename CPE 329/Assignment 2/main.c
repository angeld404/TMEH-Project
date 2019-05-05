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
#include "timer.h"


void main(void) {
    // stop watchdog timer
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

    //initialize MCLK and SMCLK to DCO, 3 MHz
    set_DCO(FREQ_3_MHZ);

    //initialize SPI
    SPI_init();

    //initialize Timer_A
    int clk, mc, ie, outmod;
    clk = 1;            //run on SMCLK
    mc = 3;             //run on up-down mode
    ie = 1;             //interrupt enabled
    outmod = 3;         //set/reset
    Timer_A_init(clk, mc, ie, outmod);
    TIMER_A0->CCR[0] = 30000;       //Timer_A peak at CCR[0] = 30000
    TIMER_A0->CCR[1] = 30000;

    //INTERRUPT ENABLE
    NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);    //Timer_A0_0
    NVIC->ISER[0] |= 1 << (TA0_N_IRQn & 31);    //Timer_A0_N
    NVIC->ISER[0] = (1 << (EUSCIB0_IRQn & 31)); //EUSCIB0
    __enable_irq();                 //Enable Interrupts Globally


    //DAC_DCV(32767);             //32767 absolute maximum DC value


    //Timer_A sync waveform
    P7->SEL0 |= BIT3;
    P7->SEL1 &= ~BIT3;
    P7->DIR |= BIT3;

    while(1) {

        // SELECT A WAVE BY UNCOMMENTING

        //triangle wave
        /*
        DAC_DCV(((TIMER_A0->R)/3) * 2);     //triangle wave algebra
        */

        //square wave
        /*
        if ((P2->OUT & BIT4) == BIT4) DAC_DCV(20000);
        else DAC_DCV(0);
        */
    }


 }  //end main()




