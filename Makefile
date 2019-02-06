CC=avr-gcc
OBJCOPY=avr-objcopy
CCMCU=attiny2313
OUTDIR=output/

DUDEC=avrdude
DUDEMCU=t2313
DUDEPROGRAMMER=usbasp
DUDEBAUDRATE=19200
DUDEPORT=$(PORT)

all: src/main.c
	$(CC) -g -O3 -mmcu=${CCMCU} -c src/main.* -o $(OUTDIR)main.o
	$(CC) -g -mmcu=$(CCMCU) -o $(OUTDIR)main.elf $(OUTDIR)main.o
	$(OBJCOPY) -j .text -j .data -O ihex $(OUTDIR)main.elf $(OUTDIR)main.hex

clean:
	rm -rf $(OUTDIR)*.o $(OUTDIR)*.hex $(OUTDIR)*.elf

burn:
ifeq ($(origin PORT), undefined)
	exit "The PORT variable should be passed in!"
else
	$(DUDEC) -c $(DUDEPROGRAMMER) -p $(DUDEMCU) -P $(DUDEPORT) -b $(DUDEBAUDRATE) -U flash:w:$(OUTDIR)main.hex $(ARGS)
endif
