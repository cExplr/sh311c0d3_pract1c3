global _start:

section .text:

_start:

	xor rax, rax
	inc rax
	push 0x0a646c72
	mov rbx, 0x6f77206f6c6c6568
	push rbx
	push rbx
	xor rbx, rbx
	mov rsi, rsp
	mov rdx, 12
	xor rdi, rdi
	inc rdi
	syscall
	mov rax, 60
	xor rdi, rdi
	syscall
	
