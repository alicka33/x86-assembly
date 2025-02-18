CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o removeSmallLetters.o -f elf -g -F dwarf removeSmallLetters.asm
cc :
	$(CC) -m32 -c -g -O0 removeSmallLetters_test.c
link :
	$(CC) -m32 -g -o rmvt removeSmallLetters_test.o removeSmallLetters.o

clean :
	rm *.o
	rm rmvt
