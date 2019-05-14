/**
 * main.c
 *
 * Assignment 8: UART Communications
 * CPE 329, Spring 2019
 * Jonathan Lau, Angel Delgado
 * Professor Hummel
 */

#include "msp.h"
#include <string.h>
#include <math.h>
#include "set_dco.h"
#include "uart.h"
#include "DAC.h"
#include "spi.h"

uint16_t enter_flg = 0;     // global enter flag

     void main(void) {
     //stop watchdog timer
     WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

     //set MCLK to DCO at nominal 3 MHz
     set_DCO(FREQ_3_MHZ);

     //initialize SPI for DAC
     SPI_init();

     //initialize UART
     UART_init();

     //enable global interrupt
     __enable_irq();

     //write a single char to terminal
     UART_tx_char('A');

     //variables for parsing DAC value
     int i = 0;
     int num[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
     int dac_out = 0;

     while(1) {
         __wfi();
         if(!enter_flg) {           //read from UART RX
             num[i] = EUSCI_A0->RXBUF - '0';
             i++;
         } else {                   //parse data
             int i_max = i-1;
             for(i = i; i >= 0; i--) {
                 dac_out += num[i]*pow(10,i_max-i);
             }
             /*
             if((dac_out >= 0) & (dac_out <= 4095)) {
                 SPI_TX(dac_out);   // output dac value
             } else {
                 SPI_TX(4095);      // dac output caps at 4095
             }
             */
             UART_tx_string("RECEIVED");
             dac_out = 0;
             for(i = 0; i < 10; i++) num[i] = 0;
             enter_flg = 0;         // reset enter flag
             i = 0;
         }
     }
}

void EUSCIA0_IRQHandler(void) {
    if(EUSCI_A0->IFG & EUSCI_A_IFG_RXIFG) {
        if(EUSCI_A0->RXBUF == 0xD) enter_flg = 1;   // set enter flag
    }
}



