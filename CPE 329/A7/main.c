/**
 * main.c
 *
 *
 */

#include "msp.h"
#include <math.h>

typedef int8_t var_type;
var_type TestFunction(var_type num);

int main(void) {
     var_type mainVar;

     // Stop watchdog timer
     WDTCTL = WDTPW | WDTHOLD;

     //set P1.0 as simple I/O
     P3->SEL1 &= ~BIT0;
     P3->SEL0 &= ~BIT0;
     P3->DIR |= BIT0;   //set P1.0 as output

     //set P2.0 as simple I/O
     P5->SEL1 &= ~BIT0;
     P5->SEL0 &= ~BIT0;
     P5->DIR |= BIT0;   //set P2.0 as output pins

     P5->OUT |= BIT0;   //turn on Blue LED
     mainVar = TestFunction(15);    // test function for timing
     P5->OUT &= ~BIT0;              // turn off Blue LED

     while(1) // infinite loop to do nothing
     mainVar++; // increment mainVar to eliminate not used warning
}

var_type TestFunction(var_type num) {
     var_type testVar;
     P3->OUT |= BIT0; // turn RED LED on

     testVar = num / 3;

     P3->OUT &= ~BIT0; // turn RED LED off
     return testVar;
}
