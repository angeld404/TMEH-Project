/**
 * main.c
 *
 * FSM of a simple vending machine
 */

#include "msp.h"
#include <stdio.h>

enum state_type {IDLE, COUNT_MONEY, DISPENSE, CHANGE};

enum event_type {intput_money, coin_return, make_select};

enum state_type current_state = IDLE;
enum event_type current_event;


void main(void) {
    // stop watchdog timer
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;

	uint32_t input_coin, total_money, price, selection,  = 0;

	while(1) {
	    switch(current_state) {
	        case IDLE:
	            if(current_event == input_money) current_state = count_money;
	            break;
	        case COUNT_MONEY:
	            total_money += input_coin;
	            display(total_money);
	            if(current_event == coin_return) current_state = CHANGE;
	            else if(current_event == make_select) current_state = DISPENSE;
	            input_coin = 0;
	            break;
	        case DISPENSE:
                price = Price_lookup(selection);
                if(price < total_money) {
                    dispense(selection);
                    total_money -= price;
                    current_state = CHANGE;
                } else if(price == total_money) {
                    dispense(selection);
                    total_money = 0;
                    current_state = IDLE;
                } else {
                    displace(price);
                    current_state = COUNT_MONEY;
                }
	            break;
	        case CHANGE:
	            Take_all_remaining_money();
	            display("now fk off lmao");
	            current_state = IDLE;
	            break;
	        default:
	            current_state = IDLE;
	    }
	}

}   //end main()
