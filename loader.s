global loader
extern sum
extern fb_write_cell

; Multiboot data
MAGIC equ 0x1BADB002
FLAGS equ 0x0
CHECKSUM equ -MAGIC

STACK_SIZE equ 4096

section .multiboot:
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .bss
align 4
    kernel_stack: resb STACK_SIZE

section .text:
loader:
    mov esp, kernel_stack + STACK_SIZE

    push byte 2
    push byte 1
    call sum

    ; Convert result to ASCII
    add eax, 48

    push eax
    push byte 0
    call fb_write_cell

.loop:
    jmp .loop
