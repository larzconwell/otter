#include <stdint.h>

#include "framebuffer.h"

void kernel_main(void) {
    while(1) {
        fb_write((uint8_t *)"1234567890", 10);
    }
}
