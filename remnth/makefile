CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o remnth.o -f elf -g -F dwarf remnth.asm
cc :
	$(CC) -m32 -c -g -O0 remnth_test.c
link :
	$(CC) -m32 -g -o rmvt remnth_test.o remnth.o

clean :
	rm *.o
	rm rmvt
