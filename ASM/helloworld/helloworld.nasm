global  _start

section .text

	mov rax, 1	;syscall of write
	mov rdi, 1	;first argument as fd - stdout
	mov rsi, statement	; second argument as statement
	mov rdx, length		; third argument as length of statement
	syscall			; invoke syscall
	mov rax, 60		; syscall number of exit
	mov rdi, 0		; first argument as status number 0
	syscall			; invoke syscall

section .data
	
	statement: db 'Hello world', 0xa
	length: equ $-statement
