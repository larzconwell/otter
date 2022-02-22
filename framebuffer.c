#include <stdint.h>

#include "io.h"

#define FB_MAX_COLS 80
#define FB_HIGH_COMMAND 14
#define FB_LOW_COMMAND 15

uint16_t *fb = (uint16_t *)0x000B8000;
uint16_t fbidx = 0;

void fb_write_cell(uint16_t cell, uint8_t value) {
    /*
     * | 7 6 5 4 | 3 2 1 0 | 7 6 5 4 3 2 1 0 |
     * | bg      | fg      | value           |
     */
    fb[cell] = 0x0F00 | value;
}

void fb_move_cursor(uint16_t position) {
    outb(IO_COMMAND_PORT, FB_HIGH_COMMAND);
    outb(IO_DATA_PORT, ((position >> 8) & 0x00FF));

    outb(IO_COMMAND_PORT, FB_LOW_COMMAND);
    outb(IO_DATA_PORT, position & 0x00FF);
}

void fb_write(const uint8_t *string, uint16_t len) {
    for (uint16_t i = 0; i < len; i++) {
        fb_write_cell(fbidx + i, string[i]);
        fb_move_cursor(fbidx + i);
    }

    fbidx += len;
}
