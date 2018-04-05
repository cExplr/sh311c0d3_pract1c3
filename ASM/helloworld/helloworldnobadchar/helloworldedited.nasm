global  _start


section .text

_start:
	jmp code 
	statement: db 'Hello world', 0xa
code:
	mov al, 1	;syscall of write
	xor rdi, rdi
	add rdi, 1	;first argument as fd - stdout
	lea rsi,[rel statement]	; second argument as statement
	xor rdx, rdx		; third argument as length of statement
	add rdx,12
	syscall			; invoke syscall
	xor rax, rax
	add rax, 60		; syscall number of exit
	xor rdi, rdi		; first argument as status number 0
	syscall			; invoke syscall

