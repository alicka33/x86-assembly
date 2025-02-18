CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o brackets.o -f elf -g -F dwarf brackets.asm
cc :
	$(CC) -m32 -c -g -O0 brackets_test.c
link :
	$(CC) -m32 -g -o rmvt brackets_test.o brackets.o

clean :
	rm *.o
	rm rmvt
