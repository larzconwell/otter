.PHONY: run clean env_setup

OBJECTS = bin/io.o bin/framebuffer.o bin/kernel.o bin/load.o

run: bin/otter.iso
	qemu-system-i386 -display gtk -cdrom bin/otter.iso

bin/otter.iso: bin/otter.elf grub.cfg
	mkdir -p bin/iso/boot/grub
	cp bin/otter.elf bin/iso/boot
	cp grub.cfg bin/iso/boot/grub
	grub-mkrescue -o $@ bin/iso

bin/otter.elf: link.ld $(OBJECTS)
	ld -T link.ld -melf_i386 $(OBJECTS) -o $@

bin/%.o: %.s
	nasm -Wall -Werror -f elf32 $< -o $@

bin/%.o: %.c
	gcc -std=c17 -m32 -ffreestanding -Wall -Wextra -Werror -c $< -o $@

clean:
	rm -r bin/*

env_setup:
	sudo apt install -y build-essential nasm grub2-common xorriso qemu-system-i386 qemu-system-gui
	mkdir -p bin
