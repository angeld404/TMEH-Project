/**
 *  lock.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Project 1: Digital Lock
 */

#include "msp.h"
#include "lock.h"
#include "LCD.h"
#include "keypad.h"
#include "delay_us.h"

//check if '#' is pressed, for setting new key
int Check_pound() {
    __wfi();    //suspends code execution until a key is pressed

    int entered_key = keypad_sweep();
    if(entered_key == ('#' - '0')) {
        return 1;
    } else return 0;

}   //end Check_pound()

//FSM description of digital lock
int Lock_fsm(int pw, int pw_key, int lockstate) {

    if((pw == PW_CLEARED) || (pw_key == PW_CLEARED)) {
        return lockstate;
    }
    if(lockstate == LOCKED) {
        if(pw == pw_key) {
            return UNLOCKED;
        } else {
            return LOCKED;
        }
    } else if(lockstate == UNLOCKED) {
        if(Check_pound()) {
            return SET_LOCK;
        } else {
            return LOCKED;
        }
    } else if(lockstate == SET_LOCK) {
        return LOCKED;
    }
    return LOCKED;

}   //end Lock_fsm

//writes appropriate text on LCD according to current state
void Lock_write(int lockstate) {

    LCD_clear();

    if(lockstate == LOCKED) {
        LCD_string_write("LOCKED.");
        LCD_Instr(LCD_ADDR_LINE_2);
        LCD_string_write("ENTER KEY: ");

    } else if(lockstate == UNLOCKED) {
        LCD_string_write("UNLOCKED!");
        LCD_Instr(LCD_ADDR_LINE_2);
        LCD_string_write("# TO SET NEW KEY");

    } else if(lockstate == SET_LOCK) {
        LCD_string_write("SETTING NEW KEY.");
        LCD_Instr(LCD_ADDR_LINE_2);
        LCD_string_write("ENTER KEY: ");

    }

}   //end Lock_write()

//reads keys entered by user via keypad
int Lock_read_key() {

    int pw_pos, entered_key = 0;
    int pw = 0;

    for(pw_pos = 4; pw_pos > 0; pw_pos--) {
        __wfi();    //suspends code execution until a key is pressed
        entered_key = keypad_sweep();

        //'*' key clears password entered by user
        if(entered_key == ('*'-'0')) {
            return PW_CLEARED;
        }

        switch(pw_pos) {
            case 4:
                pw = pw +  (entered_key * 1000);
                break;
            case 3:
                pw = pw + (entered_key * 100);
                break;
            case 2:
                pw = pw + (entered_key * 10);
                break;
            case 1:
                pw = pw + (entered_key);
                break;
        }

        //print entered key to LCD
        LCD_char_write(entered_key + '0');
    }   //end for()

    delay_us(750000);   //lets last digit show for a bit
    return pw;

}   //end Lock_read_key()

//interrupt triggered by keypad pins
void PORT4_IRQHandler(void){

    P4->OUT &= ~(COL1 | COL2 | COL3);
    P4->IFG &= ~(ROW1|ROW2|ROW3|ROW4);

}   //end PORT4_IRQHandler()


