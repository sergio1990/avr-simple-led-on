CC=avr-gcc
OBJCOPY=avr-objcopy
MCU=attiny2313

all: src/main.c
	$(CC) -g -Os -mmcu=${MCU} -c src/main.c
	$(CC) -g -mmcu=$(MCU) -o main.elf main.o
	$(OBJCOPY) -j .text -j .data -O ihex main.elf main.hex

clean:
	rm -rf *.o *.hex *.elf
