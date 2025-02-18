CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o removeSmall.o -f elf -g -F dwarf removeSmall.asm
cc :
	$(CC) -m32 -c -g -O0 removeSmall_test.c
link :
	$(CC) -m32 -g -o rmvt removeSmall_test.o removeSmall.o

clean :
	rm *.o
	rm rmvt
