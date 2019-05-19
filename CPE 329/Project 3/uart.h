/*
 * uart.h
 *
 */
#ifndef UART_H_
#define UART_H_

#include "msp.h"

// initialize UART
void UART_init();

// transmit char to terminal
void UART_tx_char(char a);

// transmit string to terminal
void UART_tx_string(char *phrase);

// echo terminal input
void UART_rx_echo(char a);


#endif /* UART_H_ */
