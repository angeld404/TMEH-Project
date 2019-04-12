/*
 *  LCD.h
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Assignment 3: LCD Display
 */

#include "msp.h"
#include "delay_us.h"

#define RS BIT0
#define RW BIT1
#define E BIT2
#define LCD_INSTR_PORTS (BIT0 | BIT1 | BIT2)
#define LCD_INIT_SET (BIT5 | BIT4)
#define LCD_DEFAULT_SET (BIT5 | BIT3)
#define LCD_DISP_ON (BIT3 | BIT2)
#define LCD_CURSOR_BLINK (BIT1 | BIT0)
#define LCD_DISP_CLEAR BIT0
#define LCD_SHIFT_RIGHT (BIT2 | BIT1)
#define LCD_SHIFT_LEFT (BIT2)
#define LCD_DISP_SHIFT (BIT0)
#define LCD_CURSOR_HOME 0x02
#define LCD_ADDR_LINE_2 0xC0

void LCD_Instr(int Instruction) {           //executes LCD instructions
    int Instruction1 = Instruction;
    int Instruction0 = Instruction<<4;
    P9->DIR |= (BIT7 | BIT6 | BIT5 | BIT4);
    P10->DIR |= LCD_INSTR_PORTS;
    P10->OUT &= ~(BIT0 |BIT1 |BIT2);        //set RS RW & E Low
    P9->OUT = Instruction1;
    P10->OUT |= (BIT2);     //E High
    delay_us(0);
    P10->OUT &= ~(BIT2);    //E Low
    if (Instruction == LCD_INIT_SET) {
        delay_us(40);
        return;
    }
    delay_us(0);
    P9->OUT = (Instruction0);
    P10->OUT |= (BIT2);     //E High
    delay_us(0);
    P10->OUT &= ~(BIT2);    //E Low
    delay_us(40);
    if (Instruction == LCD_DISP_CLEAR){
        delay_us(2000);
    }
}

void LCD_initialize() {
    LCD_Instr(LCD_INIT_SET);
    LCD_Instr(LCD_DEFAULT_SET);
    LCD_Instr(LCD_DEFAULT_SET);
    LCD_Instr(LCD_DISP_ON);
    LCD_Instr(LCD_DISP_CLEAR);
    LCD_Instr(LCD_SHIFT_RIGHT);
    LCD_Instr(LCD_CURSOR_HOME);
}

void Clear_LCD() {
    LCD_Instr(LCD_DISP_CLEAR);
}

void Home_LCD() {
    LCD_Instr(LCD_CURSOR_HOME);
}

void Write_char_LCD(int Message) {

    int Message1 = Message;
    int Message0 = Message<<4;
    P9->DIR |= (BIT7 | BIT6 | BIT5 | BIT4);
    P10->DIR |= LCD_INSTR_PORTS;
    P10->OUT |= BIT0; //set RS high
    P10->OUT &= ~(BIT1 |BIT2);//set RW & E Low
    P9->OUT = (Message1);
    P10->OUT |= (BIT2); //E High
    delay_us(0);
    P10->OUT &= ~(BIT2); //E Low
    delay_us(0);
    P9->OUT = (Message0);
    P10->OUT |= (BIT2); //E High
    delay_us(0);
    P10->OUT &= ~(BIT2); //E Low
    delay_us(40);

}

void Write_string_LCD(char *phrase) {
    int i;
    for(i = 0; i < strlen(phrase); i++) {
        Write_char_LCD(phrase[i]);
    }
}
