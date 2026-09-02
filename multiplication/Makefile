all:
	nasm -f elf64 -g -F dwarf mul.asm -o mul.o
	ld mul.o -o mul
clean:
	rm -f *.o mul