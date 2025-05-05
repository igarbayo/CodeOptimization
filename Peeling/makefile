CC = gcc
CFLAGS = -O0
OUTPUT_DIR = ensamblador

all: test_sin_opt test_opt generate_asm

generate_asm:
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -S test_sin_opt.c -o $(OUTPUT_DIR)/sin_opt.s -fverbose-asm
	$(CC) $(CFLAGS) -S test_opt.c -o $(OUTPUT_DIR)/opt.s -fverbose-asm

test_sin_opt: test_sin_opt.c
	$(CC) $(CFLAGS) test_sin_opt.c -o P2_SIN_OPT -Wall

test_opt: test_opt.c
	$(CC) $(CFLAGS) test_opt.c -o P2_OPT -Wall

clean:
	rm -f P2*

