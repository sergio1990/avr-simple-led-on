# Simple LED ON

The simple learning project with the restrictions to use only shell to build
and burn the program onto the AVR ATtiny2313 microcontroller.

The following tools and devices are used:

- `avr-gcc` - to build the C program
- `avrdude` - to burn the program
- `USBasp programmer` - the AVR programmer. I've bought [this one](https://www.aliexpress.com/item/1pcs-New-USBASP-USBISP-AVR-Programmer-USB-ISP-USB-ASP-ATMEGA8-ATMEGA128-Support-Win7-64K/32582933115.html?spm=a2g0s.9042311.0.0.27424c4dnpeCwv) on Aliexpress.

__NOTICE__: the following guide is valid only for macOS operating system. My
current version is `macOS Mojave 10.14.2`.

## Installation of the avr-gcc and avrdude

I've used the [Homebrew](https://brew.sh/) package manager to install the
needed tools. Please, follow the installation instructions on the official site
to install it on your local machine.

You will then need to install avr-libc from the avr repository.

`brew tap osx-cross/avr`

Now you can install it.

`brew install avr-libc`

You will also need avrdude to handle the C to hex code conversion and programming the microcontroller.

`brew install avrdude --with-usb`

As a result I got the next tools versions:

```
$ avr-gcc -v
Using built-in specs.
Reading specs from /usr/local/Cellar/avr-gcc/8.2.0/lib/avr-gcc/8/gcc/avr/8.2.0/device-specs/specs-avr2
COLLECT_GCC=avr-gcc
COLLECT_LTO_WRAPPER=/usr/local/Cellar/avr-gcc/8.2.0/libexec/gcc/avr/8.2.0/lto-wrapper
Target: avr
Configured with: ../configure --target=avr --prefix=/usr/local/Cellar/avr-gcc/8.2.0 --libdir=/usr/local/Cellar/avr-gcc/8.2.0/lib/avr-gcc/8 --enable-languages=c,c++ --with-ld=/usr/local/opt/avr-binutils/bin/avr-ld --with-as=/usr/local/opt/avr-binutils/bin/avr-as --disable-nls --disable-libssp --disable-shared --disable-threads --disable-libgomp --with-dwarf2
Thread model: single
gcc version 8.2.0 (GCC)
```

```
$ avrdude -v

avrdude: Version 6.3, compiled on Sep 21 2018 at 19:15:33
         Copyright (c) 2000-2005 Brian Dean, http://www.bdmicro.com/
         Copyright (c) 2007-2014 Joerg Wunsch

         System wide configuration file is "/usr/local/Cellar/avrdude/6.3_1/etc/avrdude.conf"
         User configuration file is "/Users/sergio/.avrduderc"
         User configuration file does not exist or is not a regular file, skipping


avrdude: no programmer has been specified on the command line or the config file
         Specify a programmer using the -c option and try again
```

## Building the project

Once you've written the program for the microcontroller you can build the
project to get the HEX file, which could be used to burn it onto the
microcontroller.

```
$ make
make
avr-gcc -g -Os -mmcu=attiny2313 -c src/main.* -o output/main.o
avr-gcc -g -mmcu=attiny2313 -o output/main.elf output/main.o
avr-objcopy -j .text -j .data -O ihex output/main.elf output/main.hex
```

## Burning the HEX file onto the MCU

For-first you have to connect the programmer to the computer. Also you have to
connect the MCU to the programmer.

```
$ make burn

avrdude: warning: cannot set sck period. please check for usbasp firmware update.
avrdude: AVR device initialized and ready to accept instructions

Reading | ################################################## | 100% 0.00s

avrdude: Device signature = 0x1e910a (probably t2313)
avrdude: NOTE: "flash" memory has been specified, an erase cycle will be performed
         To disable this feature, specify the -D option.
avrdude: erasing chip
avrdude: warning: cannot set sck period. please check for usbasp firmware update.
avrdude: reading input file "output/main.hex"
avrdude: writing flash (68 bytes):

Writing | ################################################## | 100% 0.10s

avrdude: 68 bytes of flash written
avrdude: verifying flash memory against output/main.hex:
avrdude: load data flash data from input file output/main.hex:
avrdude: input file output/main.hex contains 68 bytes
avrdude: reading on-chip flash data:

Reading | ################################################## | 100% 0.06s

avrdude: verifying ...
avrdude: 68 bytes of flash verified

avrdude: safemode: Fuses OK (E:FF, H:DF, L:64)

avrdude done.  Thank you.
```
