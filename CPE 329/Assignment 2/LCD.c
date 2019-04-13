/**
 *  LCD.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Assignment 3: LCD Display
 */

#include "msp.h"
#include <string.h>
#include "set_dco.h"
#include "delay_us.h"
#include "LCD.h"

void main(void) {

    // stop watchdog timer
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

    //set MCLK to DCO at nominal 48 MHz
    set_DCO(FREQ_12_MHZ);

    //initialize LCD
    delay_us(20000);
    LCD_initialize();
    LCD_Instr(LCD_DISP_ON & (~LCD_CURSOR_BLINK));

    //blink phrase "Hello World" indefinitely
    while(1){
        Write_string_LCD("Hello World");
        LCD_Instr(LCD_ADDR_LINE_2);
        Write_string_LCD("Assignment 3");
        delay_us(700000);
        Clear_LCD();
        delay_us(700000);
    }

 }


