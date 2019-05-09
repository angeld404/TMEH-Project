/*
 * uart.h
 *
 *  Created on: May 3, 2019
 *      Author: jlau30
 */

#ifndef UART_H_
#define UART_H_

#include "msp.h"

void UART_init();

void UART_tx_char(char a);

void UART_tx_string(char *phrase);

void UART_rx_echo(char a);

#endif /* UART_H_ */
