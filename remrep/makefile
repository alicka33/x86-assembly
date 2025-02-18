CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o remrep.o -f elf -g -F dwarf remrep.asm
cc :
	$(CC) -m32 -c -g -O0 remrep_test.c
link :
	$(CC) -m32 -g -o rmvt remrep_test.o remrep.o

clean :
	rm *.o
	rm rmvt