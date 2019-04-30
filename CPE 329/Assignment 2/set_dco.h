/*
 *  set_dco.h
 *
 *  Created on: Apr 10, 2019
 *  Author: Jonathan Lau, Angle Delgado
 */

#include "msp.h"

#ifndef SET_DCO_H_
#define SET_DCO_H_

#define FREQ_1_5_MHZ    (BIT0)
#define FREQ_3_MHZ      (BIT1)
#define FREQ_6_MHZ      (BIT2)
#define FREQ_12_MHZ     (BIT3)
#define FREQ_24_MHZ     (BIT4)
#define FREQ_48_MHZ     (BIT5)

#define XOR_TOGGLE      (0xFF)

void set_DCO(int Freq);

#endif
