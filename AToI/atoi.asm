global _atoi
extern _read

section .data
    buffer:     times 1024 db 0      ; input buffer
    answer:     dq 0                 ; final result stored in memory location "answer"

section .text
_atoi:
    ; Read string from console
    ; assume string will not exceed 1024 bytes
    mov     rdi, 0                  ; stdin file descriptor
    lea     rsi, [rel buffer]       ; buffer address
    mov     rdx, 1024               ; max bytes
    call    _read                   ; rax = bytes read (ignored mostly)


    ; Convert ASCII to integer (manual atoi)
    xor     rbx, rbx                ; rbx will hold the integer result, must be zeroed first
    lea     rcx, [rel buffer]       ; pointer to current character

atoi_loop:
    mov     al, [rcx]               ; load current character, one byte, into al register
    cmp     al, 10                  ; if newline, end of input
    je      atoi_done

    cmp     al, 0                   ; if null terminator, end of input
    je      atoi_done

    cmp     al, '0'                 ; check if character is below '0'
    jb      atoi_done               ; if below '0', not a digit, done
    cmp     al, '9'                 ; check if character is above '9'
    ja      atoi_done               ; if above '9', not a digit, done
    sub     al, '0'                 ; convert ASCII → digit (0–9)

    ; rbx = rbx*10 + al
    imul    rbx, rbx, 10            ; rbx = rbx * 10
    add     rbx, rax                ; rbx = rbx + al (digit), al is zero-extended in rax

    inc     rcx                     ; move to next character
    jmp     atoi_loop               ; repeat loop

atoi_done:
    ; Add 23 to the result
    add     rbx, 23                 ; rbx = rbx + 23

    ; Store result in memory label `answer`
    mov     [rel answer], rbx       ; store final result from rbx to memory location "answer"

    ; Return value in RAX
    mov     rax, rbx                ; move result in rbx to rax for return
    ret