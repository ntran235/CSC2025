global _main
extern _exit

section .data
    n   dd 7              ; input value for Fibonacci(n)

section .text
_main:
    mov     eax, [rel n]   ; eax = n
    cmp     eax, 2         ; compare n with 2
    jbe     .base_case     ; if n <= 2, jump to base case

    ; Initialize registers
    mov     ebx, 1         ; previous = 1
    mov     ecx, 1         ; current  = 1
    mov     edx, 1         ; next = 1
    mov     esi, 3         ; i = 3

.loop:
    cmp     esi, eax       ; compare i with n, for (i <= n) loop
    jg      .done          ; if i > n, jump to done

    mov     edx, ebx       ; next = previous
    add     edx, ecx       ; next = previous + current
    mov     ebx, ecx       ; previous = current
    mov     ecx, edx       ; current = next
    inc     esi            ; i++
    jmp     .loop

.done:
    mov     eax, edx       ; move next (F(n)) into eax for return
    ret                    ; exit

.base_case:
    mov     eax, 1         ; return 1 if n <= 2, (F(1) = 1, F(2) = 1)
    ret                    ; exit
