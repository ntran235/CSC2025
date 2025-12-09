global _main
extern _fibrecurse
extern _printf
extern _exit

section .data
    n dq 7                                           ; input value for Fibonacci(n)
    print_fib db "Fibonacci(%d) = %d", 10, 0         ; format string for printf

section .text
_main:
    ; Call fibrecurse(n)
    mov     rdi, [rel n]       ; rdi = n
    call    _fibrecurse        ; rax = Fibonacci(n)

    ; Print result using printf
    lea     rdi, [rel print_fib]     ; format string
    mov     rsi, [rel n]             ; first %d argument = n
    mov     rdx, rax                 ; second %d argument = final result
    xor     rax, rax                 ; printf requires rax = 0 before call
    call    _printf                  ; call printf to output result

    ; Exit cleanly
    xor     rdi, rdi           ; exit(0)
    call    _exit