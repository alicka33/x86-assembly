CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o reverselet.o -f elf -g -F dwarf reverselet.asm
cc :
	$(CC) -m32 -c -g -O0 reverselet_test.c
link :
	$(CC) -m32 -g -o rmvt reverselet_test.o reverselet.o

clean :
	rm *.o
	rm rmvt
