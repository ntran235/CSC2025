global _main
extern _exit
    ; input values
section .data
    number1 dq 10
    number2 dq 20
    number3 dq 30
    number4 dq 40


section .text
_main:
    ; initialize registers to hold original values
    mov     rax, [rel number1]        ; rax = 10
    mov     rbx, [rel number2]        ; rbx = 20
    mov     rcx, [rel number3]        ; rcx = 30
    mov     rdx, [rel number4]        ; rdx = 40

    ; Exchange values using MOV
    mov     [rel number1], rdx        ; number1 = 40
    mov     [rel number2], rcx        ; number2 = 30
    mov     [rel number3], rbx        ; number3 = 20
    mov     [rel number4], rax        ; number4 = 10

    ; Exit cleanly
    xor     edi, edi                  ; exit(0)
    call    _exit