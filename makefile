CC = gcc
CFLAGS = -O0
OUTPUT_DIR = ensamblador

all: test_sin_opt test_opt_old generate_asm

generate_asm:
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -S test_sin_opt.c -o $(OUTPUT_DIR)/sin_opt.s
	$(CC) $(CFLAGS) -S test_opt_old.c -o $(OUTPUT_DIR)/opt_old.s

test_sin_opt: test_sin_opt.c
	$(CC) $(CFLAGS) test_sin_opt.c -o P2_SIN_OPT -Wall

test_opt_old: test_opt_old.c
	$(CC) $(CFLAGS) test_opt_old.c -o P2_OPT_OLD -Wall

clean:
	rm -f P2*

