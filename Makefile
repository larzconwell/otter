.PHONY: run clean env_setup

OBJECTS = bin/loader.o bin/kernel.o

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
	gcc -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c $< -o $@

clean:
	rm -r bin/*

env_setup:
	sudo apt install -y build-essential nasm grub2-common xorriso qemu-system-i386 qemu-system-gui
	mkdir -p bin
