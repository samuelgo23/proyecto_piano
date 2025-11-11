; =====================================
; Archivo: piano.inc
; Datos compartidos
; =====================================

section _DATA public
global notes
global keys

notes dw 1911, 1703, 1517, 1432, 1275, 1136, 1012, 956, 851   ; Notas C4–D5
keys  db 'ZXCVBNM<>', 0