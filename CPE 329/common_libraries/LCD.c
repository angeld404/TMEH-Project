/*
 *  LCD.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 */

#include "msp.h"
#include "LCD.h"
#include "delay_us.h"

void LCD_Instr(int Instruction) {           //executes LCD instructions
    int Instruction1 = Instruction; //Instruction upper 4 bits
    int Instruction0 = Instruction<<4; //Instruction lower 4 bits
    P9->DIR |= LCD_DB_PORTS; //Set data bits as outputs
    P10->DIR |= LCD_INSTR_PORTS; //Set instruction pins as outputs
    P10->OUT &= ~LCD_INSTR_PORTS; //set RS RW & E Low
    P9->OUT = Instruction1; //Output message higher 4 bits
    P10->OUT |= (BIT2);     //E High
    delay_us(1);
    P10->OUT &= ~(BIT2);    //E Low
    if (Instruction == LCD_INIT_SET) { //necessary init delay
        delay_us(400);
        return;
    }
    delay_us(1);
    P9->OUT = (Instruction0); //Output message lower 4 bits
    P10->OUT |= (BIT2);     //E High
    delay_us(1);
    P10->OUT &= ~(BIT2);    //E Low
    delay_us(40);
}   //end LCD_Instr()

void LCD_init() {       //initialize LCD
    LCD_Instr(LCD_INIT_SET);
    LCD_Instr(LCD_DEFAULT_SET);
    LCD_Instr(LCD_DEFAULT_SET);
    LCD_Instr(LCD_DISP_ON);
    LCD_Instr(LCD_DISP_CLEAR);
    delay_us(2100);
    LCD_Instr(LCD_SHIFT_RIGHT);
    delay_us(40);
    LCD_Instr(LCD_CURSOR_HOME);
    delay_us(40);
}   //end LCD_init

void LCD_clear() {      //clear LCD
    LCD_Instr(LCD_DISP_CLEAR);
    delay_us(2000);     //delay makes LCD print properly
}   //end LCD_clear()

void LCD_home() {       //brings cursor to top left of LCD
    LCD_Instr(LCD_CURSOR_HOME);
}   //end LCD_home()

void LCD_char_write(int Message) {      //print a char to LCD

    int Message1 = Message;
    int Message0 = Message<<4;
    P9->DIR |= (BIT7 | BIT6 | BIT5 | BIT4);
    P10->DIR |= LCD_INSTR_PORTS;
    P10->OUT |= BIT0; //set RS high
    P10->OUT &= ~(BIT1 |BIT2);//set RW & E Low
    P9->OUT = (Message1);
    P10->OUT |= (BIT2); //E High
    delay_us(1);
    P10->OUT &= ~(BIT2); //E Low
    delay_us(1);
    P9->OUT = (Message0);
    P10->OUT |= (BIT2); //E High
    delay_us(1);
    P10->OUT &= ~(BIT2); //E Low
    delay_us(40);

}   //end LCD_char_write()

void LCD_string_write(char *phrase) {       //print a string to LCD
    int i;

    for(i = 0; i < strlen(phrase); i++) {
        LCD_char_write(phrase[i]);
    }
}   //end LCD_string_write()

