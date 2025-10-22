global _main
extern _printf
extern _exit

section .data
    print_fib db "Fibonacci(%u) = %u", 10, 0 ; format string for printf
    n         dq  7                          ; input value for Fibonacci(n)

section .text
_main:
    mov     rax, [rel n]                     ; move value of n into rax register
    cmp     rax, 2                           ; compare n with 2
    jbe     .base_case                       ; if n <= 2, jump to base case

    ; Initialize registers
    mov     rbx, 1                           ; previous = 1
    mov     rdx, 1                           ; current = 1
    mov     rcx, rax                         ; set rcx register(loop counter) to n
    sub     rcx, 2                           ; loop counter = n - 2 since first two Fibonacci numbers are known

.loop_fib:
    mov     rsi, rbx                         ; next = previous
    add     rsi, rdx                         ; next = previous + current
    mov     rbx, rdx                         ; previous = current
    mov     rdx, rsi                         ; current = next
    ; loop instructions automatically decrements rcx register(loop counter)
    loop    .loop_fib                        ; loop if rcx != 0

    ; Final result is in rdx register
    mov     rax, rdx                         ; move final result into rax for printing
    jmp     .print                           ; jump to print and exit

.base_case:
    mov     rdx, 1                           ; return 1 if n <= 2, (Fibonacci(1) = 1, Fibonacci(2) = 1)
    jmp     .print                           ; jump to print and exit

.print:
    ; Print the result
    lea     rdi, [rel print_fib]             ; format string
    mov     rsi, [rel n]                     ; first %u argument = n
    mov     rdx, rax                         ; second %u argument = final result
    xor     rax, rax                         ; required to clear rax for printf to avoid printing garbage
    call    _printf
    
    ; Exit cleanly
    mov     rdi, 0                           ; exit code = 0
    call    _exit