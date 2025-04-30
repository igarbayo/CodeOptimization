CC = gcc
CFLAGS = -O0
OUTPUT_DIR = ensamblador

all: test_sin_opt test_opt_old test_opt_new $(OUTPUT_DIR)/sin_opt.s $(OUTPUT_DIR)/opt_old.s $(OUTPUT_DIR)/opt_new.s

test_sin_opt: test_sin_opt.c
	$(CC) $(CFLAGS) test_sin_opt.c -o P2_SIN_OPT -Wall

test_opt_old: test_opt_old.c
	$(CC) $(CFLAGS) test_opt_old.c -o P2_OPT_OLD -Wall

test_opt_new: test_opt_new.c
	$(CC) $(CFLAGS) test_opt_new.c -o P2_OPT_NEW -Wall

$(OUTPUT_DIR)/sin_opt.s: sin_opt.c
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -S test_sin_opt.c -o $(OUTPUT_DIR)/sin_opt.s

$(OUTPUT_DIR)/opt_old.s: opt_old.c
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -S test_opt_old.c -o $(OUTPUT_DIR)/opt_old.s

$(OUTPUT_DIR)/opt_new.s: opt_new.c
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -S opt_new.c -o $(OUTPUT_DIR)/opt_new.s

clean:
	rm -f P2 $(OUTPUT_DIR)/*.s

