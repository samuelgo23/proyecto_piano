; ==================================
; Piano en ensamblador (NASM + DOSBox)
; ==================================
; Versión: en desarrollo (funcional parcialmente)
; Uso: nasm -f bin piano.asm -o piano.com
; Ejecutar en DOSBox: piano
; ==================================

org 100h          ; Programa tipo .COM

; -------------------
; Datos
; -------------------
msg db "Piano en ensamblador - Presione A S D F G H J K L (ESC para salir)$"

notes:
    dw 4545, 4049, 3607, 3400, 3030, 2703, 2407, 2272, 2024  ; Frecuencias aproximadas C4–D5
keys:
    db 'a','s','d','f','g','h','j','k','l',0

; -------------------
; Código principal
; -------------------
start:
    mov ah, 09h
    mov dx, msg
    int 21h

main_loop:
    call play_key
    jmp main_loop

; -------------------
; Subrutinas
; -------------------

; --- Lee una tecla y toca nota ---
play_key:
    push ax
    push bx
    push cx
    push dx
    push si

    mov ah, 1
    int 16h
    jz .no_key       ; No hay tecla

    mov ah, 0
    int 16h
    mov bl, al       ; Tecla presionada en BL

    cmp bl, 27       ; ESC
    je exit_program

    mov si, keys
    xor cx, cx
.find_key:
    mov al, [si]
    cmp al, 0
    je .done
    cmp al, bl
    je .found
    inc si
    inc cx
    jmp .find_key

.found:
    mov bx, cx
    shl bx, 1
    mov ax, [notes + bx]
    call beep
    jmp .done

.no_key:
    jmp .done

.done:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

; --- Genera sonido en el altavoz del PC ---
beep:
    push ax
    push bx
    push dx

    mov bx, ax
    mov al, 0b6h
    out 43h, al
    mov ax, bx
    out 42h, al
    mov al, ah
    out 42h, al

    in al, 61h
    or al, 03h
    out 61h, al

    mov cx, 0FFFFh
.delay:
    loop .delay

    in al, 61h
    and al, 0FCh
    out 61h, al

    pop dx
    pop bx
    pop ax
    ret

; --- Salida del programa ---
exit_program:
    mov ax, 4C00h
    int 21h
