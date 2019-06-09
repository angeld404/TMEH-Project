/*
 * MPU_9250.c
 *
 *  Created on: May 31, 2019
 *      Author: angel
 */
#include "msp.h"
#include "delay_us.h"
#include "MPU_9250.h"

int IMU_I2C_read(int reg_addr) {
    int hi_data, lo_data, data;

    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TR;        // Set transmit mode (write)
    EUSCI_B0->I2CSA = IMU_SLAVE_ADDR;                 // Peripheral address
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTT;     // I2C start condition

    while((EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG0) | (EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG0));                                     // Wait for peripheral address to transmit
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_RXIFG0; // Clear interrupt flag
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_TXIFG0; // Clear interrupt flag
    EUSCI_B0 -> TXBUF = reg_addr;                   // Send address of register to be read

    while((EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG0) | (EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG0));                                       // Wait for the transmit to complete
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_RXIFG0; // Clear interrupt flag
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_TXIFG0; // Clear interrupt flag
    EUSCI_B0->CTLW0 &= ~EUSCI_B_CTLW0_TR;           // Set receive mode (read)
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTT;         // I2C start condition (restart)

    // Wait for start to be transmitted
    while ((EUSCI_B0->CTLW0 & EUSCI_B_CTLW0_TXSTT));

    while((EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG0) | (EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG0));                        // Wait for transmit to complete
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_RXIFG0; // Clear interrupt flag
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_TXIFG0; // Clear interrupt flag
    hi_data = EUSCI_B0->RXBUF;      // Read low byte from the buffer
    // Set stop bit to trigger after reading data high byte
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTP;

    while((EUSCI_B0->IFG & EUSCI_B_IFG_RXIFG0) | (EUSCI_B0->IFG & EUSCI_B_IFG_TXIFG0));                        // Wait for transmit to complete
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_RXIFG0; // Clear interrupt flag
    EUSCI_B0->IFG &= ~ EUSCI_B_IFG_TXIFG0; // Clear interrupt flag
    lo_data = EUSCI_B0->RXBUF;      // Read high byte from buffer
    data = ((hi_data << 8) | lo_data);
    return data;
}   //end I2C_read_IMU()

int IMU_get_PWM(int old_angle, int new_angle, int Kp, int Ki, int Kd, int dt){
    int prop, intg, der, ccr;

    prop = new_angle * Kp;

    intg = (new_angle - old_angle) * dt * Ki;

    der = ((new_angle - old_angle) / dt) * Kd;

    ccr = ((prop + intg + der)*60000)/180;

    return ccr;

}

