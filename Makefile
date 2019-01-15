CC=avr-gcc
OBJCOPY=avr-objcopy
MCU=attiny2313
OUTDIR=output/

all: src/main.c
	$(CC) -g -Os -mmcu=${MCU} -c src/main.c -o $(OUTDIR)main.o
	$(CC) -g -mmcu=$(MCU) -o $(OUTDIR)main.elf $(OUTDIR)main.o
	$(OBJCOPY) -j .text -j .data -O ihex $(OUTDIR)main.elf $(OUTDIR)main.hex

clean:
	rm -rf *.o *.hex *.elf
