CC = gcc
CFLAGS = -O0
OUTPUT_DIR = ensamblador

all: arit_sin_potencias arit_con_potencias desp generate_asm

generate_asm:
	mkdir -p $(OUTPUT_DIR)
	$(CC) $(CFLAGS) -S arit_sin_potencias.c -o $(OUTPUT_DIR)/arit_sin_potencias.s
	$(CC) $(CFLAGS) -S arit_con_potencias.c -o $(OUTPUT_DIR)/arit_con_potencias.s
	$(CC) $(CFLAGS) -S desp.c -o $(OUTPUT_DIR)/desp.s

arit_sin_potencias: arit_sin_potencias.c
	$(CC) $(CFLAGS) arit_sin_potencias.c -o ARIT_SIN_POTENCIAS -Wall
	
arit_con_potencias: arit_con_potencias.c
	$(CC) $(CFLAGS) arit_con_potencias.c -o ARIT_CON_POTENCIAS -Wall
	
desp: desp.c
	$(CC) $(CFLAGS) desp.c -o DESP -Wall

clean:
	rm -f ARIT_SIN_POTENCIAS ARIT_CON_POTENCIAS DESP

