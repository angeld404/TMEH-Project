/**
 *  keypad.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 */

#include "msp.h"
#include "keypad.h"

void keypad_init() {    // initialize keypad ports
    //  designate P4 as keypad pins
    //  BIT0-BIT2 --> sweep columns
    //  BIT4-BIT7 --> read rows

    P4->DIR |= (COL1 | COL2 | COL3);
    P4->OUT &= ~(COL1|COL2|COL3);

    P4->DIR &= ~(ROW1 | ROW2 | ROW3 | ROW4);

    P4->REN |= (ROW1 | ROW2 | ROW3 | ROW4);
    P4->OUT |= (ROW1 | ROW2 | ROW3 | ROW4);

}   // end keypad_init()

int keypad_sweep() {    //determine key pressed
    int rows, col, key;

    P4->OUT |= (COL1 | COL2 | COL3);

    for(col = 0; col < 3; col++) {
        P4->OUT |= (COL1 | COL2 | COL3);
        P4->OUT &= ((~(COL1 << col)) | (ROW_MASK));
        _delay_cycles(25);
        rows = (P4->IN & ROW_MASK);
        if(rows != ROW_MASK) break;
    }
    rows = rows >> 4;

    if(col == 3) key = 0xFF;
    if(rows == 14) rows = 1;
    if(rows == 13) rows = 2;
    if(rows == 11) rows = 3;
    if(rows == 7) rows = 4;

    key = rows*3 + col - 2;

    if(key == 11) key = 0;
    if(key == 10) key = '*' - '0';
    if(key == 12) key = '#' - '0';

    return key;
}   //end keypad_sweep()





