/**
 *  keypad.h
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 */

#include "msp.h"

#ifndef KEYPAD_H_

#define KEYPAD_H_

#define COL1            BIT0 //Define column bits
#define COL2            BIT1
#define COL3            BIT2

#define ROW1            BIT4 //Define row bits
#define ROW2            BIT5
#define ROW3            BIT6
#define ROW4            BIT7

#define ROW_MASK        (BIT4 | BIT5 | BIT6 | BIT7) //Row bit mask

#define ASCII_POUND     0x23 //Pound ASCII value
#define ASCII_ASTERISK  0x2A //Asterisk ASCII Value

void keypad_init();

int keypad_sweep();

#endif
