/**
 * main.c
 */

#include <string.h>
#include <stdio.h>
#include "msp.h"
#include "set_clk.h"
#include "uart.h"
#include "adc.h"
#include "timer.h"

int overflow = 0;
uint32_t timer_val_1 = 0;
uint32_t timer_val_2 = 0;
uint32_t timer_val_diff = 0;

void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	//initialize CLKs
	//MCLK => DCO, 24 MHz
	//SMCLK => HFXT, 24 MHz
	//HSMCLK => HFXT, 48 MHz
	set_HFXT();
	//set_DCO(FREQ_24_MHZ);

	//MCLK PORT
	P4->SEL0 |= BIT3;
	P4->SEL1 &= ~BIT3;
	P4->DIR |= BIT3;

	//SMCLK PORT
	P7->SEL0 |= BIT0;
	P7->SEL1 &= ~BIT0;
	P7->DIR |= BIT0;

	//HSMCLK PORT
	P4->SEL0 |= BIT4;
	P4->SEL1 &= ~BIT4;
	P4->DIR |= BIT4;

	//initialize UART
	UART_init();

	//initialize ADC
	ADC14_init();

	//initialize Timer_A0
	TIMER_A0->CTL = TIMER_A_CTL_SSEL__SMCLK         //select SMCLK source
	              | TIMER_A_CTL_MC__CONTINUOUS      //continuous mode
	             // | TIMER_A_CTL_ID__2               //input clk div 8
	              | TIMER_A_CTL_IE;                 //enable Timer_A0 interrupt
	TIMER_A0->CCTL[0] = TIMER_A_CCTLN_CAP           //Timer_A0 in capture mode
	                  | TIMER_A_CCTLN_CCIS__CCIA    //capture inputs on CCI1A
	                  | TIMER_A_CCTLN_CM__RISING    //capture on rising edge
	                  | TIMER_A_CCTLN_OUTMOD_4      //out mode set/reset
	                  | TIMER_A_CCTLN_CCIE          //enable capture interrupt
	                  | TIMER_A_CCTLN_SCS
	                  | TIMER_A_CCTLN_SCCI;         //synchronize capture input to clk
	P7->SEL0 |= BIT3;
	P7->SEL1 &= ~BIT3;
	P7->DIR &= ~BIT3;
	NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);
	NVIC->ISER[0] |= 1 << (TA0_N_IRQn & 31);

	//enable interrupts
	__enable_irq();


	while(1) {
	    //printf("%d\n", timer_val_2);
	}

}   //end main()



void EUSCIA0_IRQHandler(void) {
    if(EUSCI_A0->IFG & EUSCI_A_IFG_RXIFG) {

    }
}   //end EUSCIA0_IRQHandler()

void ADC14_IRQHandler(void) {
    volatile uint16_t analogValue;
    analogValue= ADC14->MEM[0];
    __delay_cycles(1);
}   //end ADC14_IRQHandler()

void TA0_0_IRQHandler(void) {
    //TIMER_A0->CTL |= TIMER_A_CTL_CLR;                //reset timer
    //TIMER_A0->CCTL[0] &= (~TIMER_A_CCTLN_CCIFG);     //clear interrupt flag


    timer_val_2 = (0xFFFF - timer_val_1);
    timer_val_1 = TIMER_A0->CCR[0];
    //if (overflow == 0) timer_val_diff = (timer_val_2 - timer_val_1);
    //else timer_val_diff = (timer_val_2 + ((overflow - 1) * 0xFFFF) + timer_val_1);
    timer_val_diff = (timer_val_2 + timer_val_1);
    timer_val_diff = timer_val_diff + ((overflow - 1) * 0xFFFF);
    TIMER_A0->CCTL[0] &= (~TIMER_A_CCTLN_CCIFG);     //clear interrupt flag
    overflow = 0;

    /*timer_val_1 = timer_val_1 + TIMER_A0->CCR[0];
    timer_val_2 = timer_val_1;
    timer_val_1 = 0;*/

}   //end TIMER_A_0_IRQHandler()

void TA0_N_IRQHandler(void) {
    TIMER_A0->CTL &= (~TIMER_A_CTL_IFG);

    //timer_val_1 = timer_val_1 + 0xFFFE;

    overflow++;

}   //end TIMER_A_N_IRQHandler()
