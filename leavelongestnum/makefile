CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o leavelongestnum.o -f elf -g -F dwarf leavelongestnum.asm
cc :
	$(CC) -m32 -c -g -O0 leavelongestnum_test.c
link :
	$(CC) -m32 -g -o rmvt leavelongestnum_test.o leavelongestnum.o

clean :
	rm *.o
	rm rmvt
