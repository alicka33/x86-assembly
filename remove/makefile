CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o remove.o -f elf -g -F dwarf remove.asm
cc :
	$(CC) -m32 -c -g -O0 remove_test.c
link :
	$(CC) -m32 -g -o rmvt remove_test.o remove.o

clean :
	rm *.o
	rm rmvt
