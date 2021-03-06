/*
 * function_generator.c
 *
 */

#include <math.h>
#include "function_generator.h"

void Sine_table(int *wave, int amplitude) {
    int i;
    double pi = 4*atan(1);

    //generate sine wave lookup table
    for(i = 0; i < WAVE_RES; i++) {
        wave[i] = ((sin((2*pi/WAVE_RES)*i)) * amplitude) + amplitude;
    }

}

void Saw_table(int *wave, int amplitude) {
    int i;

    //generate sawtooth wave lookup table
    for(i = 0; i < WAVE_RES; i++) {
        wave[(WAVE_RES-1)-i] = (i * amplitude * 2)/WAVE_RES;
    }
}

void Square_table(int *wave, int amplitude, int duty) {
    int i;

    //generate square wave lookup table
    for(i = 0; i < (WAVE_RES * duty)/100; i++){
        wave[i] = amplitude * 2;
    }
    for(i = i+1; i < WAVE_RES; i++){
        wave[i] = 0;
    }
}



