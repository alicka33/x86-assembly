CC = gcc
ASMBIN = as
CFLAGS = -std=c11 -Wall -Wextra -fPIE
LIBS = -lGL -lGLU -lglut -lm -lGLEW -lX11 -lglfw

all: asm cc link

asm:
	$(ASMBIN) -msyntax=intel -mnaked-reg -o test.o -g test.asm

cc:
	$(CC) $(CFLAGS) -c -g -O0 test_app.c -o test_app.o $(LIBS) &> errors.txt

link:
	$(CC) -g -o prog test_app.o test.o $(LIBS) -no-pie

clean:
	rm *.o
	rm prog
	rm errors.txt
	rm func.lst
