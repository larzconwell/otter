global loader
extern sum

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
    push dword 2
    push dword 1
    call sum
