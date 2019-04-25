/**
 * main.c
 *
 * blink LED0
 *  -> T = 1s, duty = 50%
 *  -> CCR0
 *
*  blink LED1
*   -> T = 1s, duty = 50%
*   -> offset from LED0 by 0.25s
*   -> CCR1
 */

#include "msp.h"
#include "timer.h"

void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	CS_init();
	GPIO_init();

	//enable interrupts
	NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);
	NVIC->ISER[0] |= 1 << (TA0_N_IRQn & 31);
	__enable_irq();

	//set TimerA0 to use ACLK in continuous mode
	TIMER_A0->CTL |= (TIMER_A_CTL_TASSEL_1 | TIMER_A_CTL_MC_2);

	TIMER_A0->CCR[0] = 16384;  //0.5s time in ACLK ticks
	TIMER_A0->CCR[1] = 24576;   //0.75s time in ACLK ticks
	TIMER_A0->CCTL[0] |= TIMER_A_CCTLN_CCIE;
	TIMER_A0->CCTL[1] |= TIMER_A_CCTLN_CCIE;

	while(1) {

	}
}
