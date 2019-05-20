/*
 * multimeter.h
 *
 */

#include "msp.h"

#ifndef MULTIMETER_H_
#define MULTIMETER_H_

#define DMM_TA0_FREQ        (24000000)
#define DMM_SAMPLE_N        (120)

void Get_freq_string(int freq, int *freq_string, char *freq_chars);

void DMM_draw_xaxis();

void DMM_draw_info(char *freq, char *vpp, char *rms, char *dc, char *div);

void DMM_graph(int *wave_amp);

void DMM_RMS_graph(int vrms);

void DMM_VDC_graph(int dc);

int Get_DC(int *wave);

int Get_Vpp(int*wave);

int Get_RMS(int *wave);

#endif /* MULTIMETER_H_ */
