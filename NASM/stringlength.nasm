global _start 
section .text: 
_start:
    call main

    message: db 'What is the length?',0 
       ; the message whose string we want to count
       ; dont forget the null terminator

main:
    pop rax ;store message
    xor rcx, rcx
    mov rcx, rax	; make a copy of the string
    call strlen		; call strlen function which we wrote
    xor rdi, rdi	; set exit status code to 0 by default
    cmp rax,19		; check if strlength is correct
    jnz incorrect	; if not correct,jump to incorrect
    xor rax, rax
    inc rax		; set to write syscall
    mov rsi,rcx		; set string to print
    mov rdx, 19		; set correct length to check
    syscall		; write message
    xor rax, rax
    add rax, 60		; set exit
    xor rdi,rdi		; set code to 0
    syscall		; exit with no error
incorrect:
    xor rax, rax	
    add rax, 60		; exit without printing
    inc rdi		; set status code as 1
    syscall		;exit
strlen:
    push rbx		; preserve rbx since we will be using it
    mov rbx, rax	; copy and store in rbx the message
count:
    cmp byte [rax], 0	; compare byte by byte the value
    jz endline		; if null terminator is reached, end of line
    inc rax		; else increment rax
    jmp count		; loop at count
endline:
    sub rax, rbx	; get length value and store in rax
    pop rbx		; restore saved value of rbx
    ret			; return to caller   
