/*
 * timer.h
 *
 */


#ifndef TIMER_H_
#define TIMER_H_

#include "msp.h"

#define TIMER_CLK_ACLK      (0)
#define TIMER_CLK_SMCLK     (1)

#define TIMER_MC_STOP       (0)
#define TIMER_MC_UP         (1)
#define TIMER_MC_CONT       (2)
#define TIMER_MC_UPDOWN     (3)

#define TIMER_IE            (1)

#define TIMER_OUTMOD_S      (1)
#define TIMER_OUTMOD_TR     (2)
#define TIMER_OUTMOD_SR     (3)
#define TIMER_OUTMOD_T      (4)
#define TIMER_OUTMOD_R      (5)
#define TIMER_OUTMOD_TS     (6)
#define TIMER_OUTMOD_RS     (7)

//initialize Timer_A based on parameters passed
void Timer_A_init(int clk, int mc, int IE, int outmod);

#endif /* TIMER_H_ */
