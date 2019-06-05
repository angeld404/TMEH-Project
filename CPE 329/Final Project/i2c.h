/*
 * i2c.h
 *
 */


#ifndef I2C_H_
#define I2C_H_

#include "msp.h"


//initialize I2C
void I2C_init();

//write to peripheral
void I2C_write(int per_addr, int data);



#endif /* I2C_H_ */
