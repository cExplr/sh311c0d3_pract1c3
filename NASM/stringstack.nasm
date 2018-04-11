global _start 
section .text: 

_start:
    call mainn
    string: db 'Exiting program ' 
mainn:

    ;https://www.nasm.us/doc/nasmdo11.html ;The only instructions which take a full 64-bit displacement is loading or storing, using MOV, AL, AX, EAX or RAX (but no other registers) to an absolute 64-bit address.

    mov rax, 0x3f7961642072756f
    push rax
    mov rax, 0x7920736920776f48
    push rax
    mov rsi, rsp
    xor rax, rax
    inc rax
    xor rdi, rdi
    inc rdi
    xor rdx, rdi
    add rdx, 16
    syscall
    xor rax, rax
    add rax, 60
    inc rdi
    syscall
