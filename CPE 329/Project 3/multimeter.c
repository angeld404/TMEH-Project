/*
 * multimeter.c
 *
 */

#include <math.h>
#include "msp.h"
#include "multimeter.h"
#include "uart.h"

void Get_freq_string(int freq, int *freq_string, char *freq_chars) {
    int i, j;
    int temp = 0;
    freq++;

    for(i = 5; i >= 0; i--) {
        for(j = 0; temp < freq; j++) {
            temp += pow(10, i);
        }
        freq_string[i] = j-1;
        temp -= pow(10,i);
    }

    for(i = 5; i >= 0; i--) freq_chars[5-i] = freq_string[i] + '0';

}   //end Get_freq_string()

int Get_DC(int *wave) {
    int i;
    int sum = 0;
    int avg = 0;

    for(i = 119; i >= 0; i--) {
        sum += wave[i];
    }
    avg = sum / 119;

    return avg;
}   //end Get_DC()

int Get_Vpp(int *wave) {
    int i, vpp;
    int max = 0;
    int min = 33000;

    for(i = 119; i >= 0; i--) {
        if(max < wave[i]) max = wave[i];
        if(min > wave[i]) min = wave[i];
    }

    vpp = max - min;
    return vpp;
}   //end Get_Vpp()

int Get_RMS(int *wave) {
    int i;
    int sum= 0;
    int rms = 0;
    int wave_copy[120];

    for(i = 0; i < 119; i++) {
        wave_copy[i] = wave[i]/100;
    }

    for(i = 0; i < 119; i++) {
        sum += wave_copy[i] * wave_copy[i];
    }
    rms = sqrt(sum/120) * 100;

    return rms;
}   //end Get_rms

void DMM_draw_xaxis() {
    int i;

    for (i = 0; i < 35; i++){
        UART_tx_char(0x1b);
        UART_tx_string("[B");
    }
    for (i = 0; i < 120; i++){
        if (i == 11) UART_tx_char('|');
        else if (i == 23) UART_tx_char('|');
        else if (i == 35) UART_tx_char('|');
        else if (i == 47) UART_tx_char('|');
        else if (i == 59) UART_tx_char('|');
        else if (i == 71) UART_tx_char('|');
        else if (i == 83) UART_tx_char('|');
        else if (i == 95) UART_tx_char('|');
        else if (i == 107) UART_tx_char('|');
        else if (i == 119) UART_tx_char('|');
       else UART_tx_char('-');
    }

    UART_tx_char(0x1b);
    UART_tx_string("[H");

}

void DMM_draw_info(char *freq, char *vpp, char *rms, char *dc, char *div) {
    int i;

    UART_tx_char(0x1b);         // set cursor home
    UART_tx_string("[H");

    for (i = 0; i < 37; i++){   //move down 5 lines
       UART_tx_char(0x1b);
       UART_tx_string("[B");}
    UART_tx_string("Frequency: ");
    UART_tx_string(freq);

    for (i = 0; i < 15; i++){   //move right 20 lines
       UART_tx_char(0x1b);
       UART_tx_string("[C");}
    UART_tx_string("Vpp: ");
    UART_tx_string(vpp);

    for (i = 0; i < 15; i++){   //move right 20 lines
        UART_tx_char(0x1b);
        UART_tx_string("[C");}
    UART_tx_string("Vrms: ");
    UART_tx_string(rms);

    for (i = 0; i < 15; i++){   //move right 20 lines
        UART_tx_char(0x1b);
        UART_tx_string("[C");}
    UART_tx_string("V Offset / VDC: ");
    UART_tx_string(dc);

    UART_tx_string("\r\n");
    UART_tx_string("us/Div: ");
    UART_tx_string(div);

}

void DMM_graph(int *wave_amp){
    int i; //row
    int j; //col
    int graph[34][120];

    for (j = 0; j < 120; j++){
        for (i = 0; i < 34; i++){
            graph[i][j] = ' ';
        }
        i = 0;
    }
    j = 0;

    for (j = 0; j < 120; j++){
           graph[wave_amp[j]][j] = 'L';
       }
       j = 0;

    UART_tx_char(0x1b);
    UART_tx_string("[H");

    for (i = 33; i >= 0; i--){
       for (j = 119; j >= 0; j--){
           UART_tx_char(graph[i][j]);
       }
       j = 0;
    }


}   //end DMM_graph()
