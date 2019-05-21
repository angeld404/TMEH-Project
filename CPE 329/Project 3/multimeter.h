/*
 * multimeter.h
 *
 */

#include "msp.h"

#ifndef MULTIMETER_H_
#define MULTIMETER_H_

#define DMM_TA0_FREQ        (24000000)      //TA0 clk frequency
#define DMM_SAMPLE_N        (120)           //samples per 4 periods

//put each digit of an int value into separate indices of an array
void Get_freq_string(int freq, int *freq_string, char *freq_chars);

//draws oscilloscope axes on terminal
void DMM_draw_xaxis();

//draws frequency, Vpp, Vrms, and Vdc of input signal on terminal
void DMM_draw_info(char *freq, char *vpp, char *rms, char *dc, char *div);

//draws oscilloscope display of input signal on terminal
void DMM_graph(int *wave_amp);

//draws bar graph of Vrms on terminal
void DMM_RMS_graph(int vrms);

//draws bar graph of Vdc on terminal
void DMM_VDC_graph(int dc);

//calculate DC component of input signal
int Get_DC(int *wave);

//calculate Vpp of input signal
int Get_Vpp(int*wave);

//calculate Vrms of input signal
int Get_RMS(int *wave);

#endif /* MULTIMETER_H_ */
