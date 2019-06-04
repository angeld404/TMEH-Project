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

    P6DIR |= BIT0;                          // P6.0 set as output---------------------------------------------
    P6OUT &= ~BIT0;

    //initialize SPI
    //SPI_init();

    I2C_init();

    // Enable eUSCI_B0 interrupt in NVIC module
    //NVIC->ISER[0] = 1 << ((EUSCIB0_IRQn) & 31);
    __enable_irq();

    int accel_x, accel_y, accel_z;

    delay_us(100000);

    /*accel_x = IMU_TX_RX(0x6B80);
    accel_x = IMU_TX_RX(0x6B01);
    accel_x = IMU_TX_RX(0x6C00);
    accel_x = IMU_TX_RX(0x6B80);


    accel_x = IMU_TX_RX(0x0A02); //enable
    accel_x = IMU_TX_RX(0x6A08); //user CTL
    accel_x = IMU_TX_RX(0x1A20); //CONFIG FIFO MODE
    accel_x = IMU_TX_RX(0x2308); //FIFO EN

    //accel_x = IMU_TX_RX(0x1CE0);//acc en

    accel_x = IMU_TX_RX(0x6B00);
    accel_x = IMU_TX_RX(0x2440);
    accel_x = IMU_TX_RX(0x258C);
    accel_x = IMU_TX_RX(0x2602);
    accel_x = IMU_TX_RX(0x2788);
    accel_x = IMU_TX_RX(0x280C);
    accel_x = IMU_TX_RX(0x280A);
    accel_x = IMU_TX_RX(0x2A81);
    accel_x = IMU_TX_RX(0x6401);
    accel_x = IMU_TX_RX(0x6703);
    accel_x = IMU_TX_RX(0x0180);

    accel_x = IMU_TX_RX(0x3404);
    accel_x = IMU_TX_RX(0x1CE0);
    accel_x = IMU_TX_RX(0x6400);
    accel_x = IMU_TX_RX(0x6A00);
    accel_x = IMU_TX_RX(0x6401);
    accel_x = IMU_TX_RX(0x6A20);
    accel_x = IMU_TX_RX(0x3413);*/


    int grav_x, grav_z;

while (1){

    accel_x = I2C_read_IMU(0x3B);
    accel_y = I2C_read_IMU(0x3D);
    accel_z = I2C_read_IMU(0x3F);
    //accel_x_hi = I2C_read_IMU(0x3C);
    //accel_x = IMU_TX_RX(0x3B3C);
    //delay_us(5000);
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
    grav_z = ((2*accel_z*1000) / 32767);
    printf("%d x 10^-3 gx\r", grav_x);
    printf("%d x 10^-3 gz\r", grav_z);


}
}

int IMU_TX_RX(int addr){

    int loByte = addr & 0xFF;           //lower 8 bits of data
    int hiByte = (addr >> 8);    //upper 8 bits
    int data, loByteData, hiByteData;

    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    P3 ->OUT &= ~BIT6;      //set CS low
    EUSCI_B0->TXBUF = hiByte;                       //push hiByte to TX register
    __wfi();
    hiByteData = IMU_data;
    while(!(EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG));    //wait for TxBUF to be empty
    EUSCI_B0->TXBUF = loByte;                     //Push loByte to TX reg
    __wfi();
    P3->OUT |= BIT6;        //set CS high
    loByteData = IMU_data;

    hiByteData = hiByteData << 8;
    data = (hiByteData | loByteData);
    return data;
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
