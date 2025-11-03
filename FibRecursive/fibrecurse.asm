global _fibrecurse

section .text
_fibrecurse:
    ; before actions - function prologue
    push    rbp
    mov     rbp, rsp

    push    rbx        ; callee-saved: use rbx register to store fib(n-1)
    push    r12        ; callee-saved: use r12 register to store original n

    mov     r12, rdi   ; save original n in r12 (callee-saved so preserved across calls)

    cmp     rdi, 2     ; compare n with 2
    jbe     .base_case ; if n <= 2, jump to base case

    ; --- compute fib(n-1) ---
    mov     rax, r12    ; store n in rax
    dec     rax         ; rax = n - 1
    mov     rdi, rax    ; argument = n - 1
    call    _fibrecurse ; rax = fib(n-1)
    mov     rbx, rax    ; rbx = fib(n-1)

    ; --- compute fib(n-2) ---
    mov     rax, r12    ; store n in rax
    sub     rax, 2      ; rax = n - 2
    mov     rdi, rax    ; argument = n - 2
    call    _fibrecurse ; rax = fib(n-2)

    add     rax, rbx    ; rax = fib(n-2) + fib(n-1)

    jmp     .done

.base_case:
    mov     rax, 1      ; return 1 if n <= 2, (Fibonacci(1) = 1, Fibonacci(2) = 1)

.done:
    ; after actions - epilogue - restore callee-saved registers and return
    pop     r12
    pop     rbx
    mov     rsp, rbp
    pop     rbp
    ret