global _main
extern _printf
extern _exit

section .data
    number1 dq 10                       ; number1 = 10
    number2 dq 20                       ; number2 = 20
    number3 dq 30                       ; number3 = 30 
    number4 dq 40                       ; number4 = 40

    print_num db "number1 = %d, number2 = %d, number3 = %d, number4 = %d", 10, 0
    msg_before db "Before exchange:", 10, 0
    msg_after  db "After exchange:", 10, 0

section .text
_main:
    lea     rdi, [rel msg_before]     ; load ("Before exchange:\n") into register rdi
    xor     eax, eax                  ; clear eax register before printf   
    call    _printf                   ; printf("Before exchange:\n")

    lea     rdi, [rel print_num]      ; load print_num format string into rdi
    mov     rsi, [rel number1]        ; move number1 address into rsi
    mov     rdx, [rel number2]        ; move number2 into rdx
    mov     rcx, [rel number3]        ; move number3 into rcx
    mov     r8,  [rel number4]        ; move number4 into r8
    xor     eax, eax                  ; clear eax register before printf
    call    _printf                   ; printf("number1 = %d, number2 = %d, number3 = %d, number4 = %d", ...)    

    ; Initialize original values into registers
    mov     rax, [rel number1]        ; rax = 10
    mov     rbx, [rel number2]        ; rbx = 20
    mov     rcx, [rel number3]        ; rcx = 30
    mov     rdx, [rel number4]        ; rdx = 40

    ; Exchange values using MOV
    mov     [rel number1], rdx        ; number1 = 40
    mov     [rel number2], rcx        ; number2 = 30
    mov     [rel number3], rbx        ; number3 = 20
    mov     [rel number4], rax        ; number4 = 10

    lea     rdi, [rel msg_after]      ; load ("After exchange:\n") into register rdi
    xor     eax, eax                  ; clear eax register before printf
    call    _printf                   ; printf("After exchange:\n")

    lea     rdi, [rel print_num]      ; load print_num format string into rdi
    mov     rsi, [rel number1]         
    mov     rdx, [rel number2]
    mov     rcx, [rel number3]
    mov     r8,  [rel number4]
    xor     eax, eax                  ; clear eax register before printf    
    call    _printf                   ; printf("number1 = %d, number2 = %d, number3 = %d, number4 = %d", ...)

    ; Exit cleanly
    xor     rdi, rdi                  ; clear rdi for exit code 0
    call    _exit