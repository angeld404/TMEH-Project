/*
 * i2c.h
 *
 */


#ifndef I2C_H_
#define I2C_H_

#include "msp.h"

#define IMU_SLAVE_ADDR  (0x68)

//initialize I2C
void I2C_init();

//write to peripheral
void I2C_write(int per_addr, int data);

//read from peripheral
int I2C_read_IMU(int reg_addr);

#endif /* I2C_H_ */
