; This is the jump-call trick from penetration Testing with shellcode book

global _start:

section .text

_start:
	jmp goal ; Jump to goal unconditionally
	
code:
	pop rsi			; From before, pop the string onto rsi as second argument
	xor rax, rax		; reset rax incase
	xor rdi, rdi		; reset rdi
	xor rdx, rdx		; reset rdx
	inc rdi			; set rdi = 1 as file descriptor
	inc rax			; set syscall to write
	mov rdx, 13		; Length of 13 hardcoded
	syscall			; call to write the string popped to rsi
	mov rax, 60		; call for exit
	mov rdx, 1		; exit status set to 1
	syscall			; Exit 

goal:
	call code		 ; This is where the trick is ... This will jump to code function and save the wstring on stack
	stringg: db 'How are you?', 0xa	
