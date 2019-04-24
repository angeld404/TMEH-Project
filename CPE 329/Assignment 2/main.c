/**
 *  main.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Project 1: Digital Lock
 *
 *  Default password is 1234
 */

#include "msp.h"
#include <string.h>

#include "set_dco.h"
#include "delay_us.h"
#include "LCD.h"
#include "keypad.h"
#include "lock.h"

void main(void) {

    // stop watchdog timer
    WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

    //set MCLK to DCO at nominal 12 MHz
    set_DCO(FREQ_12_MHZ);

    //initialize LCD and keypad
    delay_us(20000);
    LCD_init();
    keypad_init();

    //INTERRUPT ENABLE
    P4->IES |= (ROW1|ROW2|ROW3|ROW4);   //Set Interrupt on High to Low Transition
    P4->IFG &= ~(ROW1|ROW2|ROW3|ROW4);  //Clear Interrupt Flag
    P4->IE |= (ROW1|ROW2|ROW3|ROW4);    //Enable Interrupts
    NVIC->ISER[1] = 1<<(PORT4_IRQn&31); //Enable NVIC
    __enable_irq();                     //Enable Interrupts Globally

    //set default lock state and parameters
    int lockstate = LOCKED;
    int pw_key = DEFAULT_PIN;
    int pw = 0;

    while(1) {

        //print current state on LCD
        Lock_write(lockstate);

        //determine action based on present state
        if(lockstate != UNLOCKED) {
            if(lockstate == SET_LOCK) {
                pw_key = Lock_read_key();
                pw = 0;
            } else {
                pw = Lock_read_key();
            }
        }

        //update digital lock state
        lockstate = Lock_fsm(pw, pw_key, lockstate);

    }   //end while(1)

 }  //end main()




