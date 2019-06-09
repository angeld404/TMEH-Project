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
#define GYRO_Y 0x45
#define IMU_SLAVE_ADDR  0x68
#define M_PI 3.14159265358979323846
#define RAD_TO_DEG 57.29578


//read from peripheral
int IMU_I2C_read(int reg_addr);

//get ccr value from IMU data
int IMU_get_PWM(int old_angle, int new_angle, int Kp, int Ki, int Kd, int dt);




#endif /* MPU_9250_H_ */
