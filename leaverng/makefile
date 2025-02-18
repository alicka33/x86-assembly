CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o leaverng.o -f elf -g -F dwarf leaverng.asm
cc :
	$(CC) -m32 -c -g -O0 leaverng_test.c
link :
	$(CC) -m32 -g -o rmvt leaverng_test.o leaverng.o

clean :
	rm *.o
	rm rmvt