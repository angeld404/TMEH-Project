#include "msp.h"
#include "delay_us.h"
#include "set_dco.h"
#include "timer.h"
#include "MPU_9250.h"
#include <stdio.h>
#include "i2c.h"
#include <math.h>



/**
 * main.c
 */


uint16_t ccr;

//IMU Variables
signed int accel_x, accel_z, gyro_y;
float old_angle, angle_acc, angle_gyr, angle;
float angle_x;

//PID Parameters
uint16_t Kp = 1;
uint16_t Ki = 1;
uint16_t Kd = 1;
uint16_t dt = .02; //sample rate

void main(void)
{
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;		// stop watchdog timer

    //initialize MCLK and SMCLK to DCO, 3 MHz
    set_DCO(FREQ_3_MHZ);

    //init I2C
    I2C_init();

    //Timer A Init
    Timer_A_init(TIMER_CLK_SMCLK, TIMER_MC_UP, TIMER_IE, TIMER_OUTMOD_SR);
    NVIC->ISER[0] = 1 << ((TA0_0_IRQn) & 31);
    NVIC->ISER[0] = 1 << ((TA0_N_IRQn) & 31);
    TIMER_A0->CCR[0] = 60000;
    TIMER_A0->CCR[1] = 30000;
    P7->DIR |= BIT3;


    //EN global Int
    __enable_irq();



    //Motor Directional GPIO
    P9->DIR |= BIT0 | BIT1 | BIT2 | BIT3;

    while (1){




    }
}

// I2C interrupt service routine
void EUSCIB0_IRQHandler(void) {
   if (EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG0) {// Check if transmit complete
       EUSCI_B0->IFG &= ~ EUSCI_B_IFG_TXIFG0; // Clear interrupt flag
       __delay_cycles(50);
   }
   if (EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG0) {// Check if receive complete
       EUSCI_B0->IFG &= ~ EUSCI_B_IFG_RXIFG0; // Clear interrupt flag
       __delay_cycles(50);
   }
}   //end EUSCIB0_IRQHandler()

void TA0_0_IRQHandler(void) {

    TIMER_A0->CCTL[0] &= (~TIMER_A_CCTLN_CCIFG);     //clear interrupt flag

    P7->OUT ^= BIT3;

    old_angle = angle;
    accel_x = IMU_I2C_read(ACCEL_X);
    accel_z = IMU_I2C_read(ACCEL_Z);
    gyro_y = IMU_I2C_read(GYRO_Y);

    angle_acc = (float) (atan2(accel_x,accel_z)+M_PI)*RAD_TO_DEG;
    angle_gyr += (float) gyro_y * dt * .0076294;
    angle = .98*(angle+gyro_y*dt) + (.02)*angle_acc;

    printf("%f\r", angle);


    //grav_x = ((2*accel_x*1000) / 32767);
    ccr = IMU_get_PWM(old_angle, angle, Kp, Ki, Kd, dt);
    TIMER_A0->CCR[1] = ccr;

}   //end TA0_0_IRQHandler()
