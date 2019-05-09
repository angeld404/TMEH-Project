/**
 * main.c
 *
 * Project 2 - Function Generator
 * CPE 329-11, Spring 2019
 * Jonathan Lau, Angel Delgado
 * Professor Hummel
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
#include "LCD.h"
#include "function_generator.h"

int amplitude = 32767/2;        //amplitude of waveform
int wave[WAVE_RES];             //waveform lookup table
int duty = 50;                  //square wave duty cycle
int current_wave = SINE_WAVE;   //current wave type setting
int current_freq = 5;           //current frequency setting

void main(void) {
    //stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	//initialize DCO as clock source
	set_DCO(FREQ_24_MHZ);

	//initialize SPI
	SPI_init();

	//initialize keypad
	keypad_init();

	//initialize LCD
	LCD_init();

	//initialize Timer_A
	int clk, mc, ie, outmod;
	clk = 1;            //set SMCLK as source
	mc = 1;             //set up mode
	ie = 1;             //timer interrupt
	outmod = 3;         //set/reset
	Timer_A_init(clk, mc, ie, outmod);

    __enable_irq();     //Enable Interrupts Globally

	//default waveform on start: Sine wave, 500 Hz, max amplitude
    TIMER_A0->CCR[0] = 400;
    Sine_table(wave, amplitude);

    //display default wave info
    LCD_string_write(SINE_STR);
    LCD_Instr(LCD_ADDR_LINE_2);
    LCD_char_write(current_freq + '0');
    LCD_string_write("00 Hz");

    int i;
	while (1) {
	    for(i = WAVE_RES-1; i >= 0; i--) {
	        __wfi();
	        DAC_DCV(wave[i]);   //output next wave value from lookup table
	    }
	}
}   // end main()

void PORT4_IRQHandler(void){

    //identify key pressed
    int key_pressed = keypad_sweep();

    //frequency adjustment
    if(key_pressed <= 5 & key_pressed > 0) {
        TIMER_A0->CCR[0] = 2000 / key_pressed;
        current_freq = key_pressed;
    }

    //change amplitude, wave type, or duty cycle
    switch(keypad_sweep()) {
        case 6:     //adjust amplitude
            amplitude += 500;
            if (amplitude >= 32767/2) amplitude = 0;

            //update lookup table with correct amplitude
            if(current_wave == 7) {
                Square_table(wave, amplitude, duty);
            } else if(current_wave == 8) {
                Sine_table(wave, amplitude);
            } else if(current_wave == 9) {
                Saw_table(wave, amplitude);
            }
            break;
        case 7:     //set wave type to square
            Square_table(wave, amplitude, duty);
            current_wave = key_pressed;
            break;
        case 8:     //set wave type to sine
            Sine_table(wave, amplitude);
            current_wave = key_pressed;
            break;
        case 9:     //set wave type to sawtooth
            Saw_table(wave, amplitude);
            current_wave = key_pressed;
            break;
        case 0:     //duty cycle = 50%
            duty = 50;
            if(current_wave == 7) Square_table(wave, amplitude, duty);
            break;
        case '*':   //duty cycle -10%
            if(duty > 0) duty -= 10;
            if(current_wave == 7) Square_table(wave, amplitude, duty);
            break;
        case '#':   //duty cycle + 10%
            if(duty < 100) duty += 10;
            if(current_wave == 7) Square_table(wave, amplitude, duty);
            break;
        default:
            break;
    }

    //print updated info on LCD
    LCD_clear();
    LCD_home();
    if(current_wave == SQUARE_WAVE) LCD_string_write(SQUARE_STR);
    else if(current_wave == SINE_WAVE) LCD_string_write(SINE_STR);
    else if(current_wave == SAW_WAVE) LCD_string_write(SAW_STR);
    LCD_Instr(LCD_ADDR_LINE_2);
    LCD_char_write(current_freq + '0');
    LCD_string_write("00 Hz");
    if(current_wave == SQUARE_WAVE) {
        if(duty == 100) {
            LCD_string_write(",100% duty");
        } else {
            LCD_string_write(", ");
            LCD_char_write(duty/10 + '0');
            LCD_string_write("0% duty");
        }
    }


    P4->IFG &= ~(ROW1|ROW2|ROW3|ROW4);  //clear interrupt flag

}   //end PORT4_IRQHandler()
