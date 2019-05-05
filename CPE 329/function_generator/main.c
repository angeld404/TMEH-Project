/**
 * main.c
 *
 * Project 2 - Function Generator
 * CPE 329-11, Spring 2019
 * Jonathan Lau, Angel Delgado
 * Professor Hummel
 *
 * Functionalities:
 *      > sinusoid
 *      > square wave
 *      > sawtooth wave
 *
 */

#include "msp.h"
#include <string.h>
#include <math.h>
#include "set_dco.h"
#include "keypad.h"
#include "timer.h"
#include "DAC.h"
#include "SPI.h"
#include "function_generator.h"

int amplitude = 32767/2;
int wave[120];
int duty = 50;
int current_wave = 7;

void main(void) {
    //stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	//initialize DCO as clock source
	set_DCO(FREQ_24_MHZ);

	//initialize SPI
	SPI_init();

	//initialize keypad
	keypad_init();

	//initialize Timer_A
	int clk, mc, ie, outmod;
	clk = 1;        //set SMCLK as source
	mc = 1;         //set up mode
	ie = 1;         //timer interrupt
	outmod = 3;     //set/reset
	Timer_A_init(clk, mc, ie, outmod);

    __enable_irq();                 //Enable Interrupts Globally

	int i;
    TIMER_A0->CCR[0] = 400;

    Sine_table(wave, amplitude);

	while (1) {
	    for(i = WAVE_RES-1; i >= 0; i--) {
	        __wfi();
	        DAC_DCV(wave[i]);
	    }

	}
}   // end main()

void PORT4_IRQHandler(void){

    int key_pressed = keypad_sweep();

    if(key_pressed <= 5 & key_pressed > 0) {
        TIMER_A0->CCR[0] = 2000 / key_pressed;
    }

    switch(keypad_sweep()) {
        case 6:
            amplitude += 1000;
            if (amplitude >= 32767/2) amplitude = 0;
            if(current_wave == 7) {
                Square_table(wave, amplitude, duty);
            } else if(current_wave == 8) {
                Sine_table(wave, amplitude);
            } else if(current_wave == 9) {
                Saw_table(wave, amplitude);
            }
            break;
        case 7:
            Empty_table(wave);
            Square_table(wave, amplitude, duty);
            current_wave = key_pressed;
            break;
        case 8:
            Empty_table(wave);
            Sine_table(wave, amplitude);
            current_wave = key_pressed;
            break;
        case 9:
            Empty_table(wave);
            Saw_table(wave, amplitude);
            current_wave = key_pressed;
            break;
        case 0:
            duty = 50;
            if(current_wave == 7) Square_table(wave, amplitude, duty);
            break;
        case '*':
            if(duty > 0) duty -= 10;
            if(current_wave == 7) Square_table(wave, amplitude, duty);
            break;
        case '#':
            if(duty < 100) duty += 10;
            if(current_wave == 7) Square_table(wave, amplitude, duty);
            break;
        default:
            break;
    }


    P4->IFG &= ~(ROW1|ROW2|ROW3|ROW4);  //clear int flag

}   //end PORT4_IRQHandler()


