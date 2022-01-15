/**
 * Source file : main.c
 * MUNOZ Melvyn, CAUSSE Raphael
 * CY TECH PREING 2 MI
 */
 
#include <stdio.h>
#include <stdlib.h>

/* Usage: ./syracuse n nf.dat
* n         strictly positive integer. 
* nf.dat    file name containing the integer n.
*/

int main(int argc, char **argv)
{
    char *end_ptr;
    /* Convert string argv[1] to a long integer. */
    long Uo = strtol(argv[1], &end_ptr, 10);
    if (Uo <= 0) {
        fprintf(stderr, "\033[31m\x1b[1mError:\x1b[0m\033[0m \x1b[1munvalid argument:\x1b[0m Must be a strictly positive integer.\n\n");
        exit(1);
    }
    FILE *file = fopen(argv[2], "w");
    if (!file) {
        fprintf(stderr, "\033[31m\x1b[1mError:\x1b[0m\033[0m \x1b[1m%s:\x1b[0m Failed to open the file.\n\n", argv[2]);
        exit(2);
    }
    fprintf(file, "n Un\n0 %li\n", Uo);
    long value = Uo, altitude_max = Uo, flight_time = 0, altitude_time = 0, incre_alti_time = 1;
    while (value != 1) {
        /* Syracuse sequence. */
        value = (value%2 == 0) ? (value/2) : (1+value*3);
        flight_time++;
        fprintf(file, "%li %li\n", flight_time, value);
        /* Max altitude update. */
        if (value > altitude_max)
            altitude_max = value;
        /* Altitude flight time update. */
        if (value < Uo)
            incre_alti_time = 0;
        if (value > Uo)
            altitude_time += incre_alti_time;
    }
    fprintf(file, "altitude_max=%li\nflight_time=%li\naltitude_time=%li", altitude_max, flight_time, altitude_time);
    fclose(file);
    return 0;
}