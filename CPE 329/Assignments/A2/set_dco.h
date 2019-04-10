/*
 * set_dco.h
 *
 *  Created on: Apr 9, 2019
 *      Author: jonat
 */

#ifndef SET_DCO_H_
#define SET_DCO_H_

#define FREQ_15_MHZ (15)
#define FREQ_3_MHZ ( 3)
#define FREQ_6_MHZ ( 6)
#define FREQ_12_MHZ (12)
#define FREQ_24_MHZ (24)
#define FREQ_48_MHZ (48)

void set_DCO(int Freq) {
    CS->KEY &= CS_KEY_VAL;
    CS->CTL1 |= (BIT1 | BIT0);
    if (Freq == 15) {
        CS->CTL0 = CS_CTL0_DCORSEL_0;
        }
    else if(Freq == 3) {
            CS->CTL0 = CS_CTL0_DCORSEL_1;
        }
    else if(Freq == 6) {
            CS->CTL0 = CS_CTL0_DCORSEL_2;
        }
    else if(Freq == 12) {
            CS->CTL0 = CS_CTL0_DCORSEL_3;
        }
    else if(Freq == 24) {
            CS->CTL0 = CS_CTL0_DCORSEL_4;
        }
    else if(Freq == 48) {
            CS->CTL0 = CS_CTL0_DCORSEL_5;
        }
    else {}

    CS->KEY &= 0x00;

}


#endif /* SET_DCO_H_ */
