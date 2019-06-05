#include "msp.h"
#include "delay_us.h"
#include "set_dco.h"
#include "spi.h"
#include "timer.h"
#include "MPU_9250.h"
#include <stdio.h>
#include "i2c.h"


/**
 * main.c
 */

uint16_t IMU_data;

void main(void)
{
	WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;		// stop watchdog timer

    //initialize MCLK and SMCLK to DCO, 3 MHz
    set_DCO(FREQ_3_MHZ);

    P6->DIR |= BIT0;                          // P6.0 set as output---------------------------------------------
    P6->OUT &= ~BIT0;

    //initialize SPI
    //SPI_init();

    I2C_init();

    // Enable eUSCI_B0 interrupt in NVIC module
    //NVIC->ISER[0] = 1 << ((EUSCIB0_IRQn) & 31);
    __enable_irq();

    int accel_x, //accel_y,
    accel_z;

    delay_us(100000);

    int grav_x;

    //Directional GPIO
    P9->DIR |= BIT0 | BIT1;

while (1){

    accel_x = IMU_I2C_read(ACCEL_X);
    //accel_y = IMU_I2C_read(ACCEL_Y);
    accel_z = IMU_I2C_read(ACCEL_Z);
    //accel_x_hi = I2C_read_IMU(0x3C);
    //accel_x = IMU_TX_RX(0x3B3C);
    //delay_us(5000);

    if(accel_x >= 0x8000){
        P9->OUT |= BIT0;
        P9->OUT &= ~BIT1;
    }
    else{
        P9->OUT &= ~BIT0;
        P9->OUT |= BIT1;
    }

    if(accel_x >= 0x8000) {
        printf("-");
        accel_x ^= 0xFFFF;
        accel_x += 1;
    }

    if(accel_z >= 0x8000) {
        printf("-");
        accel_z ^= 0xFFFF;
        accel_z += 1;
    }

    if(accel_x >= 0x8000) {
        printf("-");
        accel_x ^= 0xFFFF;
        accel_x += 1;
    }
    grav_x = ((2*accel_x*1000) / 32767);
    //grav_z = ((2*accel_z*1000) / 32767);
    printf("%d x 10^-3 gx\r", grav_x);
    //printf("%d x 10^-3 gz\r", grav_z);


}
}

// I2C interrupt service routine
void EUSCIB0_IRQHandler(void) {
   if (EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG0) {// Check if transmit complete
       EUSCI_B0->IFG &= ~ EUSCI_B_IFG_TXIFG0; // Clear interrupt flag
   }
   if (EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG0) {// Check if receive complete
       EUSCI_B0->IFG &= ~ EUSCI_B_IFG_RXIFG0; // Clear interrupt flag
   }
}   //end EUSCIB0_IRQHandler()
