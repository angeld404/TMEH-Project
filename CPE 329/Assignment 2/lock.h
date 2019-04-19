/**
 *  lock.h
 *
 *  Jonathan Lau, Angel Delgado
 *  CPE 329 Spring 2019
 *  Professor Hummel
 *
 *  Project 1: keypad lock
 */

#include "msp.h"
#include <string.h>

#define PW_CLEARED      (0xFF)
#define DEFAULT_PIN     (1234)

#define LOCKED          (1)
#define UNLOCKED        (2)
#define SET_LOCK        (3)

int Check_pound();

int Lock_fsm(int pw, int pw_key, int lockstate);

int Lock_read_key();

void Lock_write(int lockstate);

void PORT4_IRQHandler(void);

