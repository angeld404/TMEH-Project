/*
 * timer.h
 *
 */


#ifndef TIMER_H_
#define TIMER_H_

#include "msp.h"

//initialize Timer_A based on parameters passed
void Timer_A_init(int ccmode, int clk, int mc, int IE, int outmod);

#endif /* TIMER_H_ */
