/**
 *  lock.h
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Project 1: Digital Lock
 */

#include "msp.h"
#include <string.h>

#define PW_CLEARED      (0xFF)
#define DEFAULT_PIN     (1234)

#define LOCKED          (1)
#define UNLOCKED        (2)
#define SET_LOCK        (3)

//check if '#' is pressed, for setting new key
int Check_pound();

//FSM description of digital lock
int Lock_fsm(int pw, int pw_key, int lockstate);

//reads keys entered by user via keypad
int Lock_read_key();

//writes appropriate text on LCD according to current state
void Lock_write(int lockstate);

//interrupt triggered by keypad pins
void PORT4_IRQHandler(void);

