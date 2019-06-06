/*
 * i2c.c
 *
 */

#include "msp.h"
#include "i2c.h"
#include "MPU_9250.h"

void I2C_init() {
    P1->SEL0 |= BIT6 | BIT7; // Set I2C pins of eUSCI_B0

    // Configure USCI_B0 for I2C mode
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_SWRST;         // Software reset enabled
    EUSCI_B0->CTLW0 = EUSCI_B_CTLW0_SWRST           // Remain eUSCI in reset mode
                    | EUSCI_B_CTLW0_MODE_3          // I2C mode
                    | EUSCI_B_CTLW0_MST             // Master mode
                    | EUSCI_B_CTLW0_SYNC            // Sync mode
                    | EUSCI_B_CTLW0_SSEL__SMCLK;    // SMCLK

    EUSCI_B0->BRW = 30;                                             // baudrate = SMCLK / 30 = 100kHz
    EUSCI_B0->CTLW0 &= ~EUSCI_B_CTLW0_SWRST;                        // Release eUSCI from reset
    EUSCI_B0->IE |= (EUSCI_B_IE_RXIE | EUSCI_B_IE_TXIE);            // Enable receive interrupt

    // Enable eUSCIB0 interrupt in NVIC module
    NVIC->ISER[0] = 1 << ((EUSCIB0_IRQn) & 31);
}   //end I2C_init()

void I2C_write(int per_addr, int data) {
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TR;        // Set transmit mode (write)
    EUSCI_B0->I2CSA = per_addr;                 // Peripheral address
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTT;     // I2C start condition

    __wfi();                                        // Wait for peripheral address to transmit
    EUSCI_B0 -> TXBUF = data;                       // Send the high byte of the memory address

    __wfi();                                        // Wait for the transmit to complete
    EUSCI_B0 -> CTLW0 |= EUSCI_B_CTLW0_TXSTP;       // I2C stop condition
}   //end I2C_write()

/*

int I2C_read_IMU(int reg_addr) {
    int hi_data, lo_data, data;

    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TR;        // Set transmit mode (write)
    EUSCI_B0->I2CSA = IMU_SLAVE_ADDR;                 // Peripheral address
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTT;     // I2C start condition

    __wfi();                                        // Wait for peripheral address to transmit
    EUSCI_B0 -> TXBUF = reg_addr;                   // Send address of register to be read

    __wfi();                                        // Wait for the transmit to complete
    EUSCI_B0->CTLW0 &= ~EUSCI_B_CTLW0_TR;           // Set receive mode (read)
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTT;         // I2C start condition (restart)

    // Wait for start to be transmitted
    while ((EUSCI_B0->CTLW0 & EUSCI_B_CTLW0_TXSTT));

    __wfi();                        // Wait for transmit to complete
    hi_data = EUSCI_B0->RXBUF;      // Read low byte from the buffer

    // Set stop bit to trigger after reading data high byte
    EUSCI_B0->CTLW0 |= EUSCI_B_CTLW0_TXSTP;

    __wfi();                        // Wait for transmit to complete
    lo_data = EUSCI_B0->RXBUF;      // Read high byte from buffer

    data = ((hi_data << 8) | lo_data);
    return data;
}   //end I2C_read_IMU()

*/
