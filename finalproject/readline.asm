global readline
extern _read

section .text
; readline(buffer, size)
; Reads a line of text from stdin into the buffer.
; Arguments:
;   RDI = pointer to buffer
;   RSI = maximum number of bytes to read, buffer size
; Returns:
;   Buffer is filled with null-terminated string
readline:               ; save registers that will be used (callee-saved)
    push rbx
    push rcx
    push rdx
    push r8
    push r9

    mov rdx, rsi        ; rdx = number of bytes to read
    mov rsi, rdi        ; rsi = buffer pointer
    mov rdi, 0          ; rdi = file descriptor 0 (stdin)
    call _read          ; call _read system call
    ; RAX = number of bytes read
    ; check for errors or zero bytes read
    cmp rax, 0          ; compare bytes read with 0
    jle .done           ; if less or equal to 0, done

    ; null-terminate the string
    mov rcx, rax        ; rcx = number of bytes read
    dec rcx             ; decrement to get last character index
    mov bl, byte [rsi + rcx] ; load last character
    cmp bl, 10          ; check if last character is newline
    jne .skip_newline   ; if not newline, skip
    mov byte [rsi + rcx], 0 ; null terminate
    jmp .done           ; jump to done

.skip_newline:
    mov byte [rsi + rax], 0   ; if no newline, null terminate after last char

.done:                  ; restore saved registers   
    pop r9
    pop r8
    pop rdx
    pop rcx
    pop rbx
    ret                 ; return to caller with buffer filled null-terminated string