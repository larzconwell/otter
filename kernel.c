#define fg 15
#define bg 0

typedef unsigned char uint8_t;

// Framebuffer mapped address
uint8_t *fb = (uint8_t *)0x000B8000;

void fb_write_cell(uint8_t cell, uint8_t val) {
    fb[cell] = val;
    fb[cell + 1] = ((fg & 0x0F) << 4) | (bg & 0x0F);
}

uint8_t sum(uint8_t a, uint8_t b) {
    return a + b;
}
