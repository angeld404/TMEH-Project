/*
 * adc.c
 *
 */

#include <stdio.h>
#include "msp.h"
#include "adc.h"

void ADC14_init() {
    //select ADC0 port
    P5->SEL0 |= BIT5;
    P5->SEL1 |= BIT5;


    //disable conversion_enable bit to start configuration
    ADC14->CTL0 &= ~ADC14_CTL0_ENC;

    ADC14->CTL0 = ( ADC14_CTL0_SHP              //pulse mode, use internal sample timer
                  | ADC14_CTL0_SSEL__HSMCLK     //use HSMCLK
                  | ADC14_CTL0_SHT1__128        //sample for 4 clocks on memory location 0
                  | ADC14_CTL0_SHT0_0
                  | ADC14_CTL0_ON );            //turn ADC14 on (on/off option exists for power consumption purposes)

    ADC14->CTL1 = ( 0 << ADC14_CTL1_CSTARTADD_OFS)    //start conversions using memory 0
                  | ADC14_CTL1_RES_3;                  //14-bit resolution

    ADC14->MCTL[0] = ADC14_MCTLN_INCH_0;       //read from channel A0 for conversion

    //enable conversion_enable bit, end configuration
    ADC14->CTL0 |= ADC14_CTL0_ENC;
    ADC14->CLRIFGR0 = ADC14_CLRIFGR0_CLRIFG0;


    //enable interrupt
    ADC14->IER0 |= ADC14_IER0_IE0;             //enable interrupt on memory location 1
    NVIC->ISER[0] |= (1 << (ADC14_IRQn & 31));


}   //end ADC14_init()


