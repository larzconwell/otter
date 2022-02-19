.PHONY: run clean env_setup

run: out/otter.iso
	qemu-system-i386 -display gtk -cdrom out/otter.iso

out/otter.iso: grub.cfg out/otter.elf
	mkdir -p out/iso/boot/grub
	cp out/otter.elf out/iso/boot
	cp grub.cfg out/iso/boot/grub
	grub-mkrescue -o $@ out/iso

out/otter.elf: link.ld out/loader.o
	ld -T link.ld -melf_i386 $(filter-out $<,$^) -o $@

out/loader.o: loader.s
	nasm -f elf32 $^ -o $@

clean:
	rm -r out/*

env_setup:
	sudo apt install -y build-essential nasm grub2-common xorriso qemu-system-i386 qemu-system-gui
	mkdir -p out
