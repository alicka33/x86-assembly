CC = gcc
ASMBIN = as
CFLAGS = -std=c11 -Wall -Wextra -fPIE
LIBS =  -lGL -lGLU -lglut -lm -lGLEW -lX11 -lglfw

all: asm cc link

asm:
	$(ASMBIN) -msyntax=intel -mnaked-reg -o motion.o -g motion.asm

cc:
	$(CC) $(CFLAGS) -c -g -O0 motion_app.c -o motion_app.o $(LIBS) &> errors.txt

link:
	$(CC) -g -o prog motion_app.o motion.o $(LIBS) -no-pie

clean:
	rm *.o
	rm prog
	rm errors.txt
	rm func.lst
