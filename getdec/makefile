CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o getdec.o -f elf -g -F dwarf getdec.asm
cc :
	$(CC) -m32 -c -g -O0 getdec_test.c
link :
	$(CC) -m32 -g -o rmvt getdec_test.o getdec.o

clean :
	rm *.o
	rm rmvt