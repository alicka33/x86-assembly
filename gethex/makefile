CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o gethex.o -f elf -g -F dwarf gethex.asm
cc :
	$(CC) -m32 -c -g -O0 gethex_test.c
link :
	$(CC) -m32 -g -o rmvt gethex_test.o gethex.o

clean :
	rm *.o
	rm rmvt