CC=gcc
ASMBIN=nasm

all : asm cc link

asm : 
	$(ASMBIN) -o leavelastndig.o -f elf -g -F dwarf leavelastndig.asm
cc :
	$(CC) -m32 -c -g -O0 leavelastndig_test.c
link :
	$(CC) -m32 -g -o rmvt leavelastndig_test.o leavelastndig.o

clean :
	rm *.o
	rm rmvt
