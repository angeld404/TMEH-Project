/**
 *  main.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Assignment 5: Interrupts and Timers
 */

#include "msp.h"
#include "timer_waves.h"


void main(void) {

    // stop watchdog timer
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

    //uncomment desired init functions
    //Part_A_init();
    //Part_B_init();
    //Part_C_init();
    Part_D_init();
    //Part_E_init();

    //INTERRUPT ENABLE
    NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);
    NVIC->ISER[0] |= 1 << (TA0_N_IRQn & 31);
    __enable_irq();         //Enable Interrupts Globally

    while(1);

 }  //end main()




