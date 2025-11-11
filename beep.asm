; =====================================
; beep.asm — Rutina de sonido PC speaker
; =====================================

section _TEXT public
global beep

beep:
    ; AX = divisor (frecuencia)
    mov al, 0B6h
    out 43h, al

    mov dx, ax
    out 42h, al
    mov al, ah
    out 42h, al

    ; activar altavoz
    in  al, 61h
    or  al, 03h
    out 61h, al

    ; pequeña pausa
    mov cx, 0FFFFh
.delay:
    loop .delay

    ; apagar altavoz
    in  al, 61h
    and al, 0FCh
    out 61h, al
    ret
