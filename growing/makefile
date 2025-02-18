CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o growing.o -f elf -g -F dwarf growing.asm
cc :
	$(CC) -m32 -c -g -O0 growing_test.c
link :
	$(CC) -m32 -g -o rmvt growing_test.o growing.o

clean :
	rm *.o
	rm rmvt
