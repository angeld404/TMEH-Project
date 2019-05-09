/*
 * function_generator.h
 *
 */

#ifndef FUNCTION_GENERATOR_H_
#define FUNCTION_GENERATOR_H_

#define WAVE_RES        (120)   //DAC updates 120 points per period

#define SQUARE_WAVE     (7)     //key pressed = square wave key
#define SINE_WAVE       (8)     //key pressed = sine wave key
#define SAW_WAVE        (9)     //key pressed = sawtooth wave key

#define SQUARE_STR      "Square"
#define SINE_STR        "Sine"
#define SAW_STR         "Sawtooth"

//generates lookup table for sine wave
void Sine_table(int *wave, int amplitude);

//generates lookup table for sawtooth wave
void Saw_table(int *wave, int amplitude);

//generates lookup table for square wave
void Square_table(int *wave, int amplitude, int duty);


#endif /* FUNCTION_GENERATOR_H_ */
