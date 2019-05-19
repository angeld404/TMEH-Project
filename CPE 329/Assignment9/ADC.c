#include "ADC.h"
#include "msp.h"

/*
 * ADC.c
 *
 *  Created on: May 13, 2019
 *      Author: angel
 */

void ADC_init(){
    /* ADC Initialization */
       P5 ->SEL1 |= BIT4;      //analog input on P5.4
       P5 ->SEL0 |=BIT4;

       NVIC -> ISER[0] = 1 << ((ADC14_IRQn) & 31); //enable NVIC interrupts



       ADC14 ->CTL0 |= ADC14_CTL0_SHT0_7 | //select sample amount and turn on ADC
                       ADC14_CTL0_SHT1_7 |
                           ADC14_CTL0_SHP |
                           ADC14_CTL0_ON;

       ADC14 ->CTL0 |= ADC14_CTL1_RES_3;    //16bit res
       ADC14 ->MCTL[0] |= ADC14_MCTLN_INCH_1; //mem[0] and P5.4
       ADC14 ->IER0 |= ADC14_IER0_IE0; //interrupt en
}


