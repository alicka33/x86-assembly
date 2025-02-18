CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o reversedig.o -f elf -g -F dwarf reversedig.asm
cc :
	$(CC) -m32 -c -g -O0 reversedig_test.c
link :
	$(CC) -m32 -g -o rmvt reversedig_test.o reversedig.o

clean :
	rm *.o
	rm rmvt
