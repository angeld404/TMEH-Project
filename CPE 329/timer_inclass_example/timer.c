/*
 *  timer.c
 *
 *  TimerA example
 *
 *      -> timerA takes in clk input
 *      -> includes built-in clk divider
 *      -> roll-over flag RC triggers when counter rolls over
 *
 *      Mode Control (MC):
 *          > (00) Stop:        doesn't count
 *          > (01) Up:          count up to value stored in CCR0, resets to 0 when
 *                              CCR0, then keep counting. Triggers TAIFG flag on roll-over
 *          > (10) Continuous:  counts up to 0xFFFF, triggers TAIFG flag on roll-over
 *          > (11) Updown:      count up to CCR0, then count down to 0. Triggers TAIFG flag
 *                              on reaching 0x00
 */

#include "msp.h"
#include "timer.h"

void CS_init() {
    CS->KEY = CS_KEY_VAL;                   //unlock CS registers
    CS->CTL1 |= (BIT1 | BIT0);              //set DCO as MCLK source
    CS->CTL0 &= ~(CS_CTL0_DCORSEL_MASK);    //clear previous DCO frequency setting

    if (Freq == FREQ_1_5_MHZ)               //MCLK = 1.5 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_0;
    }
    else if(Freq == FREQ_3_MHZ)             //MCLK = 3 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_1;
        }
    else if(Freq == FREQ_6_MHZ)             //MCLK = 6 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_2;
        }
    else if(Freq == FREQ_12_MHZ)            //MCLK = 12 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_3;
        }
    else if (Freq == FREQ_24_MHZ)           //MCLK = 24 MHz
        {
            CS->CTL0 |= CS_CTL0_DCORSEL_4;
        }
    else if(Freq == FREQ_48_MHZ)            //MCLK = 48 MHz
        {
            while ((PCM->CTL1 & PCM_CTL1_PMR_BUSY));
            PCM->CTL0 = PCM_CTL0_KEY_VAL | PCM_CTL0_AMR_1;
            while ((PCM->CTL1 & PCM_CTL1_PMR_BUSY));
            /* Configure Flash wait-state to 1 for both banks 0 & 1 */
            FLCTL->BANK0_RDCTL = (FLCTL->BANK0_RDCTL &
             ~(FLCTL_BANK0_RDCTL_WAIT_MASK)) | FLCTL_BANK0_RDCTL_WAIT_1;
            FLCTL->BANK1_RDCTL = (FLCTL->BANK0_RDCTL &
             ~(FLCTL_BANK1_RDCTL_WAIT_MASK)) | FLCTL_BANK1_RDCTL_WAIT_1;
            CS->CTL0 |= CS_CTL0_DCORSEL_5;
        }


    CS->KEY &= 0x0000;      // lock CS registers

}

void GPIO_init() {

}

void TA0_0_IRQHandler(void) {
    TIMER_A0->CCTL[0] &= (~TIMER_A_CCTL_CCIFG);
    TIMER_A0->CCR[0] += 16384;
    P1->OUT ^= BIT0;
}

void TA0_N_IRQHandler(void) {
    if(TIMER_A0->CCTL[1] & TIMER_A_CCTLN_CCIFG) {
        TIMER_A0->CCTL[1] ~TIMER_A_CTLN_CCIFG;      //clear interrupt flag
        TIMER_A0->CCR[1] += 16384;                  //add 0.5s timer
        P2->OUT ^= BIT0;                            //toggle LED
    }
}
