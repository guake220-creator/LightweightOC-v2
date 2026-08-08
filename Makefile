all: kernel.bin

boot.o: boot.asm
	nasm -f elf32 boot.asm -o boot.o

kernel.o: kernel.c
	gcc -m32 -fno-stack-protector -ffreestanding -c kernel.c -o kernel.o

kernel.bin: boot.o kernel.o linker.ld
	ld -m elf_i386 -T linker.ld -o kernel.bin boot.o kernel.o

clean:
	rm -rf *.o kernel.bin
