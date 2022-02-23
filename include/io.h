#ifndef IO_H
#define IO_H 1

#include <stdint.h>

#define IO_COMMAND_PORT 0x3D4
#define IO_DATA_PORT 0x3D5

/*
 * outb writes a byte to an IO port.
 */
void outb(uint16_t port, uint8_t data);

#endif
