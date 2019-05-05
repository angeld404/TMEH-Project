/*
 * timer_waves.c
 *
 *
 */
#include "msp.h"
#include "timer_waves.h"
#include "set_dco.h"

void Part_A_init() {
    //set GPIO ports
    P6->DIR |= BIT4;       // set P6.4 as output
    P6->OUT |= BIT4;       // P6.4 initially on

    //set MCLK and SMCLK to DCO at nominal 24 MHz
    //set_DCO(FREQ_24_MHZ);

    //set TimerA0 to use SMCLK in UP mode
    TIMER_A0->CTL |= (TIMER_A_CTL_SSEL__SMCLK | TIMER_A_CTL_MC__UP);
    TIMER_A0->CCTL[0] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);
    TIMER_A0->CCTL[1] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);

    //25 kHz square wave, 25% duty cycle
    TIMER_A0->CCR[0] = 960;
    TIMER_A0->CCR[1] = 240;
}

void Part_B_init() {
    //set GPIO ports
    P6->DIR |= BIT4;        // set P6.4 as output
    P6->OUT |= BIT4;        // P6.4 initially on
    P6->DIR |= BIT0;        // set P6.0 to measure ISR execution time
    P6->OUT &= ~BIT0;       // P6.0 initially off

    //set MCLK port
    P4->SEL0 |= BIT3;
    P4->SEL1 &= ~BIT3;
    P4->DIR |= (BIT3);

    //set MCLK and SMCLK to DCO at nominal 24 MHz
    set_DCO(FREQ_24_MHZ);

    //set TimerA0 to use SMCLK in UP mode
    TIMER_A0->CTL |= (TIMER_A_CTL_SSEL__SMCLK | TIMER_A_CTL_MC__UP);
    TIMER_A0->CCTL[0] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);

    //25 kHz square wave, 50% duty cycle
    TIMER_A0->CCR[0] = 480;
}

void Part_C_init() {
    //set GPIO ports
    P6->DIR |= BIT4;        // set P6.4 as output
    P6->OUT |= BIT4;        // P6.4 initially on
    P6->DIR |= BIT0;        // set P6.0 to measure ISR execution time
    P6->OUT &= ~BIT0;       // P6.0 initially off

    //set MCLK port
    P4->SEL0 |= BIT3;
    P4->SEL1 &= ~BIT3;
    P4->DIR |= (BIT3);

    //set MCLK and SMCLK to DCO at nominal 24 MHz
    set_DCO(FREQ_24_MHZ);

    //set TimerA0 to use SMCLK in UP mode
    TIMER_A0->CTL |= (TIMER_A_CTL_SSEL__SMCLK | TIMER_A_CTL_MC__UP);
    TIMER_A0->CCTL[0] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);

    //lowered until ISR timing failure
    TIMER_A0->CCR[0] = 59;
}

void Part_D_init() {
    //set GPIO ports
    P6->DIR |= BIT0;        // set LED as output
    P6->OUT |= BIT0;        // LED initially ON

    //set MCLK and SMCLK to DCO at nominal 1.5 MHz
    set_DCO(FREQ_1_5_MHZ);

    //set TimerA0 to use SMCLK in UP mode
    TIMER_A0->CTL |= (TIMER_A_CTL_SSEL__SMCLK | TIMER_A_CTL_MC__CONTINUOUS);
    TIMER_A0->CCTL[0] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);
    TIMER_A0->CCTL[1] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);



}

void Part_E_init() {
    //set GPIO ports
    P8->DIR |= (BIT5 | BIT6);        // set P6.0-1 as output
    P8->OUT &= ~(BIT5 | BIT6);        // P6.0-1 initially off

    //set MCLK port
    //P4->SEL0 |= BIT3;
    //P4->SEL1 &= ~BIT3;
    //P4->DIR |= (BIT3);

    //set MCLK and SMCLK to DCO at nominal 24 MHz
    set_DCO(FREQ_1_5_MHZ);

    //set TimerA0 to use SMCLK in UP mode
    TIMER_A0->CTL |= (TIMER_A_CTL_SSEL__SMCLK | TIMER_A_CTL_MC__UP);
    TIMER_A0->CCTL[0] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);
    TIMER_A0->CCTL[1] |= (TIMER_A_CCTLN_CCIE | TIMER_A_CCTLN_OUTMOD_2);

    //25 kHz square wave, 50% duty cycle
    TIMER_A0->CCR[0] = 1500;
    TIMER_A0->CCR[1] = 750;
}



