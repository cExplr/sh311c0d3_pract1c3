global _start 

section .text: 

_start:
    call mainn
    string: db 'Exiting program ' mainn:
    pop rsi
    push 16
    push rsi
    push 1
    push 1
    call print
    xor rax, rax
    add rax, 60
    inc rdi
    pop rbx
    pop rbx
    pop rbx
    pop rbx
    syscall print:
    mov rbp, rsp
    xor rax,rax
    mov rax, [rbp+8]
    mov rdi, [rbp+16]
    mov rsi, [rbp+24]
    mov rdx, [rbp+32]
    syscall
    ret
