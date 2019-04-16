/**
 *  keypad.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Assignment 4: keypad
 */

#include "msp.h"
#include <string.h>
#include "set_dco.h"
#include "delay_us.h"
#include "LCD.h"
#include "keypad.h"

void main(void) {

    // stop watchdog timer
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

    //set MCLK to DCO at nominal 12 MHz
    set_DCO(FREQ_12_MHZ);

    //initialize LCD and keypad
    delay_us(20000);
    LCD_init();
    keypad_init();
    //LCD_Instr(LCD_DISP_ON & (~LCD_CURSOR_BLINK));

    //blink phrase "Hello World" indefinitely
    while(1){
        char key = keypad_sweep();
        if(key != 0xFF) {
            Write_char_LCD(key);
        }
        delay_us(80000);
        delay_us(50000);
    }

 }


