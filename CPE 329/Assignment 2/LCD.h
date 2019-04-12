#include "msp.h"
#include "delay_us.h"

#define RS BIT0
#define RW BIT1
#define E BIT2
#define LCD_INIT_SET (BIT5 | BIT4)
#define LCD_DEFAULT_SET (BIT5 | BIT3)
#define LCD_DISP_ON (BIT3 | BIT2 | BIT1 | BIT0)
#define LCD_DISP_CLEAR BIT0
#define LCD_SHIFT_RIGHT (BIT2 | BIT1)
#define LCD_SHIFT_LEFT (BIT2)
#define LCD_DISP_SHIFT (BIT0)



/*
 * LCD.h
 *
 *  Created on: Apr 10, 2019
 *      Author: Jonathan Lau, Angle Delgado
 */

void LCD_Instr(int Instruction)
{
    int Instruction1 = Instruction;
    int Instruction0 = Instruction<<4;
    P9->DIR = 0x00;
    P10->DIR = 0x00;
    P10->OUT &= ~(BIT0 |BIT1 |BIT2);//set RS RW & E Low
    P9->OUT = Instruction1;
    P10->OUT |= (BIT2); //E High
    delay_us(0);
    P10->OUT &= ~(BIT2); //E Low
    if (Instruction == LCD_INIT_SET){
        delay_us(40);
        return;
    }
    else {
    }
    delay_us(0);
    P9->OUT = (Instruction0);
    P10->OUT |= (BIT2); //E High
    delay_us(0);
    P10->OUT &= ~(BIT2); //E Low
    delay_us(40);
    if (Instruction == LCD_DISP_CLEAR){
        delay_us(2000);
    }
    else{}
}   

void LCD_Message(int Message)
{

    int Message1 = Message;
    int Message0 = Message<<4;
    P9->DIR = 0x00;
    P10->DIR = 0x00;
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
