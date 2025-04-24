CC = gcc
CFLAGS = -O0
LDFLAGS = -lm

all: main

main: main.c
	$(CC) $(CFLAGS) main.c -o P2 $(LDFLAGS) -Wall

clean:
	rm -f P2
