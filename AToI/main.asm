; ---------------------------
; Project: AToI
; Reads a string from console, converts to integer, adds 23,
; stores result in memory location "answer".
; macOS x86-64 NASM version (Mach-O)
; ---------------------------
global _main
extern _atoi
extern _printf
extern _exit

section .data
    print_result db "Converted integer + 23 = %d", 10, 0 ; format string for printf

section .text
_main:

    ; call your custom atoi() implementation
    call    _atoi                       ; result returned in rax

    ; print the result using printf
    lea     rdi, [rel print_result]     ; format string
    mov     rsi, rax                    ; integer to print
    xor     rax, rax                    ; printf requires rax = 0 before call
    call    _printf

    ; exit(0)
    xor     rdi, rdi                    ; exit code 0
    call    _exit