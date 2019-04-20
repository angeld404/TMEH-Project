/**
 *  delay_us.c
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 */

#include "msp.h"
#include "delay_us.h"

void delay_us(int time_us) {
    int i, n;     //i, n counter variables
    switch((CS->CTL0) & (CS_CTL0_DCORSEL_MASK)) {
        case CS_CTL0_DCORSEL_0:
            for(i = (time_us/6); i > 0; i--) {

            }
            break;
        case CS_CTL0_DCORSEL_1:
            for(i = (time_us/2); i > 0; i--) {

            }
            break;
        case CS_CTL0_DCORSEL_2:
            for(i = time_us/3 + 2; i > 0; i--) {
                for(n = 0; n > 0; n--);
            }
            break;
        case CS_CTL0_DCORSEL_3:
            for(i = time_us+2; i > 0; i--) {

            }
            break;
        case CS_CTL0_DCORSEL_4:
            for(i = time_us; i > 0; i--) {
                for(n = 1; n > 0; n--);
            }
            break;
        case CS_CTL0_DCORSEL_5:
            for(i = time_us; i > 0; i--) {
                for(n = 3; n > 0; n--);
            }
            break;
    }

}   // end delay_us()



