global loader

MAGIC equ 0x1BADB002
FLAGS equ 0x0
CHECKSUM equ -MAGIC

section .multiboot:
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

loader:
    mov eax, 0xBADBEEF
.loop:
    jmp .loop
