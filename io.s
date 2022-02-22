global outb

section .text
outb:
    mov al, [esp+8] ; 8bit int from stack for data
    mov dx, [esp+4] ; 16bit int from stack for port
    out dx, al
    ret
