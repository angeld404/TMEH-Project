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

    //INTERRUPT ENABLE
    P4->IES |= (ROW1|ROW2|ROW3|ROW4); //Set Interrupt on High to Low Transition
    P4->IFG &= ~(ROW1|ROW2|ROW3|ROW4); //Clear Interrupt Flag
    P4->IE |= (ROW1|ROW2|ROW3|ROW4); //Enable Interrupts
    NVIC->ISER[1] = 1<<(PORT4_IRQn&31); //Enable NVIC
    __enable_irq(); //Enable Interrupts Globally

    while(1){
    }

 }




