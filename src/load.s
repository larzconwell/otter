global load
extern kernel_main

MB_MAGIC: equ 0x1BADB002
MB_FLAGS: equ 0x0
MB_CHECKSUM: equ -MB_MAGIC

STACK_SIZE: equ 16000

section .multiboot
align 4
    dd MB_MAGIC
    dd MB_FLAGS
    dd MB_CHECKSUM

section .bss
align 16
stack_bottom:
    resb STACK_SIZE
stack_top:

section .text
load:
    mov esp, stack_top

    call kernel_main

    cli
loop:
    hlt
    jmp loop
