/*
 * timer.h
 *
 *
 */

#ifndef TIMER_H_
#define TIMER_H_

#define FREQ_1_5_MHZ    (BIT0)
#define FREQ_3_MHZ      (BIT1)
#define FREQ_6_MHZ      (BIT2)
#define FREQ_12_MHZ     (BIT3)
#define FREQ_24_MHZ     (BIT4)
#define FREQ_48_MHZ     (BIT5)

void CS_init();

void GPIO_init();


#endif /* TIMER_H_ */
