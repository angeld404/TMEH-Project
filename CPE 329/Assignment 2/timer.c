/*
 * timer.c
 *
 *  Created on: Apr 29, 2019
 *      Author: angel
 */

#include "msp.h"

#ifndef TIMER_C_
#define TIMER_C_


void Timer_A_init(int clk, int mc, int IE, int outmod, int CCR0, int CCR1, int CCR2, int CCR3, int CCR4){

    if (clk == 0) clk = TIMER_A_CTL_SSEL__ACLK;                     // 0 = ACLK
    else if (clk == 1) clk = TIMER_A_CTL_SSEL__SMCLK;               // 1 = SMCLK

    if (mc == 0) mc = TIMER_A_CTL_MC__STOP;                         // 0 = STOP
    else if (mc == 1) mc = TIMER_A_CTL_MC__UP;                      // 1 = UP
    else if (mc == 2) mc = TIMER_A_CTL_MC__CONTINUOUS;              // 2 = CONT
    else if (mc == 3) mc = TIMER_A_CTL_MC__UPDOWN;                  // 3 = UPDOWN

    if (IE == 0) IE = 0;
    else if (IE == 1) IE = TIMER_A_CCTLN_CCIE;                      // 1 = Interrupt enable

    if (outmod == 0) outmod = TIMER_A_CCTLN_OUTMOD_1;               /*!< 0 = Set */
    else if (outmod == 1) outmod = TIMER_A_CCTLN_OUTMOD_2;          /*!< 1 = Toggle/reset */
    else if (outmod == 2) outmod = TIMER_A_CCTLN_OUTMOD_3;          /*!< 2 = Set/reset */
    else if (outmod == 3) outmod = TIMER_A_CCTLN_OUTMOD_4;          /*!< 3 = Toggle */
    else if (outmod == 4) outmod = TIMER_A_CCTLN_OUTMOD_5;          /*!< 4 = Reset */
    else if (outmod == 5) outmod = TIMER_A_CCTLN_OUTMOD_6;          /*!< 5 = Toggle/set */
    else if (outmod == 6) outmod = TIMER_A_CCTLN_OUTMOD_7;          /*!< 6 = Reset/set */

    TIMER_A0->CTL |= (clk | mc);
    TIMER_A0->CCTL[0] |= (IE | outmod);

    TIMER_A0->CCR[0] = CCR0;
    TIMER_A0->CCR[1] = CCR1;
    TIMER_A0->CCR[3] = CCR2;
    TIMER_A0->CCR[4] = CCR3;



}




#endif /* TIMER_C_ */
