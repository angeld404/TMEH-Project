/*
 * MPU_9250.h
 *
 *  Created on: May 31, 2019
 *      Author: angel
 */

#ifndef MPU_9250_H_
#define MPU_9250_H_

#define ACCEL_X 0x3B
#define ACCEL_Y 0x3D
#define ACCEL_Z 0x3F
#define IMU_SLAVE_ADDR  0x68


//read from peripheral
int IMU_I2C_read(int reg_addr);




#endif /* MPU_9250_H_ */
