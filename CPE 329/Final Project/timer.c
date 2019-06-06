/*
 * timer.c
 *
 */

#include "msp.h"
#include "timer.h"


void Timer_A_init(int clk, int mc, int IE, int outmod){

    if (clk == 0) clk = TIMER_A_CTL_SSEL__ACLK;                     // 0 = ACLK
    else if (clk == 1) clk = TIMER_A_CTL_SSEL__SMCLK;               // 1 = SMCLK

    if (mc == 0) mc = TIMER_A_CTL_MC__STOP;                         // 0 = STOP
    else if (mc == 1) mc = TIMER_A_CTL_MC__UP;                      // 1 = UP
    else if (mc == 2) mc = TIMER_A_CTL_MC__CONTINUOUS;              // 2 = CONT
    else if (mc == 3) mc = TIMER_A_CTL_MC__UPDOWN;                  // 3 = UPDOWN

    if (IE == 0) IE = 0;
    else if (IE == 1) IE = TIMER_A_CCTLN_CCIE;                      // 1 = Interrupt enable

    if (outmod == 1) outmod = TIMER_A_CCTLN_OUTMOD_1;               /*!< 1 = Set */
    else if (outmod == 2) outmod = TIMER_A_CCTLN_OUTMOD_2;          /*!< 2 = Toggle/reset */
    else if (outmod == 3) outmod = TIMER_A_CCTLN_OUTMOD_3;          /*!< 3 = Set/reset */
    else if (outmod == 4) outmod = TIMER_A_CCTLN_OUTMOD_4;          /*!< 4 = Toggle */
    else if (outmod == 5) outmod = TIMER_A_CCTLN_OUTMOD_5;          /*!< 5 = Reset */
    else if (outmod == 6) outmod = TIMER_A_CCTLN_OUTMOD_6;          /*!< 6 = Toggle/set */
    else if (outmod == 7) outmod = TIMER_A_CCTLN_OUTMOD_7;          /*!< 7 = Reset/set */

    TIMER_A0->CTL |= (clk | mc);
    TIMER_A0->CCTL[0] |= (IE | outmod);
    TIMER_A0->CCTL[1] |= (IE | outmod);



}



void TA0_N_IRQHandler(void) {


    TIMER_A0->CCTL[1] &= (~TIMER_A_CCTLN_CCIFG);     //clear interrupt flag

    P7->OUT ^= BIT3;
}   //end TA0_N_IRQHandler()


