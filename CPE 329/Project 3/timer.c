/*
 * timer.c
 *
 */

#include "msp.h"
#include "timer.h"


void Timer_A_init(int ccmode, int clk, int mc, int IE, int outmod) {

    if (ccmode == 1) {
        ccmode = TIMER_A_CCTLN_CAP | TIMER_A_CCTLN_CM_1;
        P7->DIR &= ~BIT3;
        P7->SEL0 |= BIT3;
        P7->SEL1 &= ~BIT3;
    }

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
    TIMER_A0->CCTL[0] |= (ccmode | IE | outmod);

    NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);

}

