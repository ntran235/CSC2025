global _main
extern _write
extern _exit

section .data
msg: db "Hello from x86_64 under Rosetta!", 10
len: equ $ - msg

section .text
_main:
    mov     edi, 1                ; fd = stdout
    lea     rsi, [rel msg]        ; buf
    mov     edx, len              ; count
    call    _write

    xor     edi, edi              ; exit code = 0
    call    _exit