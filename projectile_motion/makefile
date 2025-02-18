# CC = gcc
# ASMBIN = nasm

# CFLAGS = -Wall -Wextra -pedantic -std=c11 -fPIE
# LDFLAGS = -lGL -lGLU -lglut -lm

# all: asm cc link

# asm:
# 	$(ASMBIN) -o projectile_motion.o -f elf64 -g -F dwarf projectile_motion.asm

# cc:
# 	$(CC) -c -g -O0 $(CFLAGS) projectile_motion_app.c

# link:
# 	$(CC) -g -o rmvt projectile_motion_app.o projectile_motion.o $(LDFLAGS) -no-pie

# clean:
# 	rm -f *.o rmvt

CC = gcc
ASMBIN = as
CFLAGS = -std=c11 -Wall -Wextra -fPIE
LIBS = -lGL -lGLU -lglut -lm

all: asm cc link

asm:
	$(ASMBIN) -msyntax=intel -mnaked-reg -o projectile_motion.o -g projectile_motion.asm

cc:
	$(CC) $(CFLAGS) -c -g -O0 projectile_motion_app.c -o projectile_motion_app.o $(LIBS) &> errors.txt

link:
	$(CC) -g -o prog projectile_motion_app.o projectile_motion.o $(LIBS) -no-pie

clean:
	rm *.o
	rm prog
	rm errors.txt
	rm func.lst
