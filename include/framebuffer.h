#ifndef FRAMEBUFFER_H
#define FRAMEBUFFER_H

#include <stdint.h>

/*
 * fb_write writes a string of length to the framebuffer.
 */
void fb_write(const uint8_t *string, uint16_t len);

#endif
