; =====================================
; main.asm — Programa principal
; =====================================

extern tocar_nota

section _TEXT public
global _main

section _DATA public
msg db 'Presiona una tecla (Z-M) para tocar una nota, ESC para salir$', 0Dh, 0Ah, '$'

_main:
    mov ax, _DATA
    mov ds, ax

    mov dx, msg
    mov ah, 9
    int 21h

leer:
    mov ah, 1
    int 21h
    cmp al, 27
    je salir

    mov bl, al
    call tocar_nota
    jmp leer

salir:
    mov ax, 4C00h
    int 21h
