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
#include "multimeter.h"

uint32_t ta0_val = 0;
uint32_t freq_ccr = 0;
uint32_t sample_ccr = 0;
uint32_t ta2_ov = 0;
uint32_t ta2_ov_cnt = 0;

int wave[120];
int wave_table[120];
uint32_t sample_n = 0;

int vpp, rms, dc;
int freq = 1000;
int per_flg = 0;
int trigger_flg = 0;

int freq_string[6];
int wave_string[6];
int vpp_string[6];
int rms_string[6];
int dc_string[6];
int graph_div_string[6];

char freq_chars[6];
char wave_chars[6];
char vpp_chars[6];
char rms_chars[6];
char dc_chars[6];
char graph_div_chars[6];


    void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	//initialize CLKs
	//MCLK => DCO, 48 MHz
	//SMCLK => HFXT, 24 MHz
	//HSMCLK => HFXT, 24 MHz
	set_HFXT();

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
	              | TIMER_A_CTL_IE;                 //enable Timer_A0 interrupt
	TIMER_A0->CCTL[0] = TIMER_A_CCTLN_CAP           //Timer_A0 in capture mode
	                  | TIMER_A_CCTLN_CCIS__CCIA    //capture inputs on CCI0A
	                  | TIMER_A_CCTLN_CM__RISING    //capture on rising edge
	                  | TIMER_A_CCTLN_OUTMOD_4      //out mode set/reset
	                  | TIMER_A_CCTLN_CCIE          //enable capture interrupt
	                  | TIMER_A_CCTLN_SCS
	                  | TIMER_A_CCTLN_SCCI;         //synchronize capture input to clk
	P7->SEL0 |= BIT3;                               //configure capture input pin
	P7->SEL1 &= ~BIT3;
	P7->DIR &= ~BIT3;
	P7->REN |= BIT3;
	NVIC->ISER[0] |= 1 << (TA0_0_IRQn & 31);        //interrupt registers for timers
    NVIC->ISER[0] |= 1 << (TA0_N_IRQn & 31);

	//initialize Timer_A2
    TIMER_A2->CTL = TIMER_A_CTL_SSEL__SMCLK         //select SMCLK source
                  | TIMER_A_CTL_MC__CONTINUOUS      //continuous mode
                  | TIMER_A_CTL_ID__8;              //input clk div 8
	TIMER_A2->CCTL[0] = TIMER_A_CCTLN_OUTMOD_4      //out mode set/reset
                      | TIMER_A_CCTLN_CCIE          //enable capture interrupt
                      | TIMER_A_CCTLN_SCS           //synchronize capture source to clk
                      | TIMER_A_CCTLN_SCCI;         //synchronize capture input to clk
	TIMER_A2->CCR[0] = 200;
	NVIC->ISER[0] |= 1 << (TA2_0_IRQn & 31);        //interrupt registers for timers
    NVIC->ISER[0] |= 1 << (TA2_N_IRQn & 31);

	//GPIO for testing TIMER_A0 interrupt
	P8->DIR |= BIT6;

	//enable interrupts
	__enable_irq();


	int graph_div;

	//clear terminal screen
	UART_tx_char(0x1b);
    UART_tx_string("[2J");
    UART_tx_char(0x1b);
    UART_tx_string("[H");


	while(1) {
	    //get input wave frequency
        freq = DMM_TA0_FREQ / (freq_ccr);

	    //calculate and update sampling time
        sample_ccr = freq_ccr / 240;
        ta2_ov = 0;
        if(ta0_val >= 306500) {
            ta2_ov = 3;
            ta2_ov_cnt = ta2_ov;
            TIMER_A2->CCR[0] = 3395;
            freq = 0;
        }
        while(sample_ccr > 0xFFFF) {
            sample_ccr -= 0xFFFF;
            ta2_ov++;
        }
        if((sample_ccr < 90) & (ta2_ov == 0)) sample_ccr = 90;
        TIMER_A2->CCR[0] = sample_ccr;

        //calculate vpp, rms, dc, and graph
        vpp = Get_Vpp(wave);
        rms = Get_RMS(wave);
        dc = Get_DC(wave);
        graph_div = 400000 / freq;
	    Get_freq_string(freq, freq_string, freq_chars);
        Get_freq_string(vpp, vpp_string, vpp_chars);
        Get_freq_string(rms, rms_string, rms_chars);
        Get_freq_string(dc, dc_string, dc_chars);
        Get_freq_string(graph_div, graph_div_string, graph_div_chars);

        //print waveform in terminal
        UART_tx_char(0x1b);
        UART_tx_string("[H");
        DMM_draw_xaxis();
        DMM_graph(wave_table);
        DMM_draw_info(freq_chars, vpp_chars, rms_chars, dc_chars, graph_div_chars);
        DMM_RMS_graph(rms);
        DMM_VDC_graph(dc);
        __delay_cycles(30);
	}

}   //end main()

void ADC14_IRQHandler(void) {
    ADC14->CLRIFGR0 |= ADC14_CLRIFGR0_CLRIFG0;

    if(trigger_flg) {
        wave[sample_n] = ADC14->MEM[0] * 33000 / 16383;
        wave_table[sample_n] = wave[sample_n] / 1000;
        sample_n++;
        if(sample_n >= DMM_SAMPLE_N){
            trigger_flg = 0;
            sample_n = 0;
        }
    }

}   //end ADC14_IRQHandler()

void TA0_0_IRQHandler(void) {
    TIMER_A0->R = 0;                                 //reset timers
    TIMER_A2->R = 0;
    P8->OUT ^= BIT6;

    trigger_flg = 1;

    if(sample_n >= DMM_SAMPLE_N) {
        trigger_flg = 0;
        sample_n = 0;
        ta2_ov_cnt = 0;
    }

    TIMER_A0->CCTL[0] &= (~TIMER_A_CCTLN_CCIFG);     //clear interrupt flag


    ta0_val += (TIMER_A0->CCR[0]);
    if(ta0_val >= 306500) {
        ta2_ov = 3;
        ta2_ov_cnt = ta2_ov;
        TIMER_A2->CCR[0] = 3395;
        freq = 0;
    }
    freq_ccr = ta0_val;

    //get input wave frequency
    freq = DMM_TA0_FREQ / (freq_ccr);

    ta0_val = 0;



}   //end TA0_0_IRQHandler()

void TA0_N_IRQHandler(void) {
    TIMER_A0->CTL &= (~TIMER_A_CTL_IFG);     //clear interrupt flag

    ta0_val += 0xFFFF;

}   //end TA0_N_IRQHandler()

void TA2_0_IRQHandler(void) {
    TIMER_A2->R = 0;                                 //reset timer
    TIMER_A2->CCTL[0] &= (~TIMER_A_CCTLN_CCIFG);     //clear interrupt flag

    //calculate and update sampling time
    if(ta0_val >= 306500) {
        ta2_ov = 3;
        ta2_ov_cnt = ta2_ov;
        TIMER_A2->CCR[0] = 3395;
        freq = 0;
        //trigger_flg = 1;
    }
    if((ta2_ov_cnt >= ta2_ov) & trigger_flg) {
        ta2_ov_cnt = 0;

        ADC14->CTL0 |= ADC14_CTL0_SC;   //start a conversion
    }

}   //end TA2_0_IRQHandler()

void TA2_N_IRQHandler(void) {
    TIMER_A2->CTL &= (~TIMER_A_CTL_IFG);     //clear interrupt flag

    ta2_ov_cnt++;

}   //end TA2_N_IRQHandler()
