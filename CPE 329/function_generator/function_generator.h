/*
 * function_generator.h
 *
 */

#ifndef FUNCTION_GENERATOR_H_
#define FUNCTION_GENERATOR_H_

#define WAVE_RES (120)

void Empty_table(int *wave);

void Sine_table(int *wave, int amplitude);

void Saw_table(int *wave, int amplitude);

void Square_table(int *wave, int amplitude, int duty);


#endif /* FUNCTION_GENERATOR_H_ */
