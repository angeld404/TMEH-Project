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
    //  BIT0-BIT2 --> sweep columns
    //  BIT4-BIT7 --> read rows

    P4->DIR |= (COL1 | COL2 | COL3);//  designate P4 keypad columns
    P4->OUT &= ~(COL1|COL2|COL3);//Clear columns

    P4->DIR &= ~(ROW1 | ROW2 | ROW3 | ROW4);//  designate P4 keypad rows
    P4->REN |= (ROW1 | ROW2 | ROW3 | ROW4);//Enable Resistors
    P4->OUT |= (ROW1 | ROW2 | ROW3 | ROW4);//Set resistors as pullups

}   // end keypad_init()

int keypad_sweep() {    //determine key pressed
    int rows, col, key;

    P4->OUT |= (COL1 | COL2 | COL3); //Clear columns

    for(col = 0; col < 3; col++) { //Sweep columns
        P4->OUT |= (COL1 | COL2 | COL3); //clear columns
        P4->OUT &= ((~(COL1 << col)) | (ROW_MASK)); //Shift through columns
        _delay_cycles(25);
        rows = (P4->IN & ROW_MASK); //read row pins
        if(rows != ROW_MASK) break;
    }
    rows = rows >> 4; //shift rows to lower bits

    if(col == 3) key = 0xFF; //no key press
    if(rows == 14) rows = 1; //translate row values
    if(rows == 13) rows = 2;
    if(rows == 11) rows = 3;
    if(rows == 7) rows = 4;

    key = rows*3 + col - 2; //translate key pressed

    if(key == 11) key = 0; //fix 0 case
    if(key == 10) key = '*' - '0'; //fix asterisk case
    if(key == 12) key = '#' - '0'; //fix pount case

    return key;
}   //end keypad_sweep()





