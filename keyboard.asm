; ===========================
; keyboard.asm — Manejo de teclas (versión NASM .OBJ)
; ===========================

extern beep
extern notes
extern keys

section _TEXT
global tocar_nota

tocar_nota:
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov si, keys
    xor di, di           ; índice = 0

buscar:
    mov al, [si]
    cmp al, 0
    je no_encontrada
    cmp bl, al
    je encontrada
    inc si
    inc di
    jmp buscar

encontrada:
    mov bx, di
    shl bx, 1              
    mov ax, [ds:notes + bx]  
    call beep
    jmp fin

no_encontrada:
    nop

fin:
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
