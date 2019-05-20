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


    UART_tx_char(0x1b);
    UART_tx_string("[34B");

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

    UART_tx_char(0x1b);     //RMS BAR GRAPH TITLE
    UART_tx_string("[H");

    UART_tx_char(0x1b);
    UART_tx_string("[135C");
    UART_tx_char(0x1b);
    UART_tx_string("[35B");
    UART_tx_string("Volts RMS");

    UART_tx_char(0x1b);
    UART_tx_string("[15C");
    UART_tx_string("Volts DC");

    UART_tx_char(0x1b);
    UART_tx_string("[H");

    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---3.3V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---3.2V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---3.1V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---3.0V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.9V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.8V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.7V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.6V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.5V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.4V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.3V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.2V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.1V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---2.0V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.9V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.8V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.7V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.6V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.5V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.4V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.3V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.2V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.1V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---1.0V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.9V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.8V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.7V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.6V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.5V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.4V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.3V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.2V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.1V");
    UART_tx_string("\r\n");
    UART_tx_char(0x1b);
    UART_tx_string("[122C");
    UART_tx_string("---0.0V");
    UART_tx_string("\r\n");

    UART_tx_char(0x1b);
    UART_tx_string("[H");


}

void DMM_draw_info(char *freq, char *vpp, char *rms, char *dc, char *div) {
    int i;

    UART_tx_char(0x1b);         // set cursor home
    UART_tx_string("[H");


   UART_tx_char(0x1b);      //move down 5 lines
   UART_tx_string("[35B");


    UART_tx_string("Frequency: ");
    UART_tx_char(freq[2]);
    UART_tx_char('.');
    for(i = 3; i < 6; i++) UART_tx_char(freq[i]);
    UART_tx_string(" kHz");

    for (i = 0; i < 10; i++){   //move right 20 lines
       UART_tx_char(0x1b);
       UART_tx_string("[C");
    }
    UART_tx_string("Vpp: ");
    UART_tx_char(vpp[1]);
    UART_tx_char('.');
    for(i = 2; i < 6; i++) UART_tx_char(vpp[i]);
    UART_tx_string(" Vpp");


    //move right 20 lines
    UART_tx_char(0x1b);
    UART_tx_string("[20C");

    UART_tx_string("Vrms: ");
    UART_tx_char(rms[1]);
    UART_tx_char('.');
    for(i = 2; i < 6; i++) UART_tx_char(rms[i]);
    UART_tx_string(" Vrms");

    for (i = 0; i < 10; i++){   //move right 20 lines
        UART_tx_char(0x1b);
        UART_tx_string("[C");
    }
    UART_tx_string("V Offset / VDC: ");
    UART_tx_char(dc[1]);
    UART_tx_char('.');
    for(i = 2; i < 6; i++) UART_tx_char(dc[i]);
    UART_tx_string(" Vdc");

    UART_tx_string("\r\n\r\n    \r\n");
    UART_tx_string("us/Div: ");
    UART_tx_string(div);

}

void DMM_RMS_graph(int vrms){
    int graph[34][20];
    int i, j; //rows, cols

    UART_tx_char(0x1b);
    UART_tx_string("[H");
    UART_tx_char(0x1b);
    UART_tx_string("[130C");

    vrms = vrms/1000;

    for (i = 33; i >= 0 ;i--){
        for (j = 19; j>= 0; j--){
            graph[i][j] = ' ';
        }
    }


    for (i = vrms; i >= 0 ;i--){
        for (j = 19; j>= 0; j--){
            graph[i][j] = '-';
        }
    }

    for (i = 33; i >= 0; i--){
       for (j = 19; j >= 0; j--){
           UART_tx_char(graph[i][j]);
       }
       UART_tx_string("\r\n");
       UART_tx_char(0x1b);
       UART_tx_string("[130C");

    }


}


void DMM_VDC_graph(int dc){
    int graph[34][20];
    int i, j; //rows, cols

    UART_tx_char(0x1b);
    UART_tx_string("[H");
    UART_tx_char(0x1b);
    UART_tx_string("[155C");

    dc = dc/1000;

    for (i = 33; i >= 0 ;i--){
        for (j = 19; j>= 0; j--){
            graph[i][j] = ' ';
        }
    }


    for (i = dc; i >= 0 ;i--){
        for (j = 19; j>= 0; j--){
            graph[i][j] = '-';
        }
    }

    for (i = 33; i >= 0; i--){
       for (j = 19; j >= 0; j--){
           UART_tx_char(graph[i][j]);
       }
       UART_tx_string("\r\n");
       UART_tx_char(0x1b);
       UART_tx_string("[155C");

    }


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
       UART_tx_string("\r\n");
    }


}   //end DMM_graph()
