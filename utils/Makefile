BIN=bmp2isc
LDFLAGS=-lm
CFLAGS=-Wall -Wextra -pedantic $(LDFLAGS)

all: bmp2isc

bmp2isc: bmp2isc.o
	cc $^ $(CFLAGS) -o $(BIN)

bmp2isc.o: bmp2isc.c
	cc $^ -c

clean:
	rm --force *.o $(BIN)

install:
	mkdir -p "$(HOME)/.local/bin" && \
	cp $(BIN) "$(HOME)/.local/bin"
