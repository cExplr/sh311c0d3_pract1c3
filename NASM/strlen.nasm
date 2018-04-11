global _start 
section .text: 
_start:
    call main
    message db 'it is correct' main:
    pop rax ;store message
    mov rbx, rax
    call strlen
    xor rdi, rdi
    cmp rax,13
    jnz incorrect
    inc rdi
    xor rax, rax
    inc rax
    mov rsi,rbx
    mov rdx, 13
    syscall
    xor rax, rax
    add rax, 60
    dec rdi
    syscall incorrect:    
    xor rax, rax
    add rax, 60
    xor rdi, rdi
    inc rdi
    syscall strlen:
    push rbx
    mov rbx, rax count:
    cmp byte [rax], 0
    jz endline
    inc rax
    jmp count endline:
    sub rax, rbx
    pop rbx
    ret
    
