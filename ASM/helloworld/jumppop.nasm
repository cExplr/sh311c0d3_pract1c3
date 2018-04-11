global: _start

section .data:

section .text:
_start:

xor rax, rax
xor rdi, rdi
xor rsi, rsi
xor rdx, rdx
inc rdi
push dword 0x61616161
mov rsi, rsp
add rdx, 5
syscall

mov rax, 60
mov rdi, 1
syscall
