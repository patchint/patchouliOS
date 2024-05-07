CC = gcc
NASM = nasm
LD = ld
GRUB_MKRESCUE = grub-mkrescue

CFLAGS = -m32 -fno-stack-protector -fno-builtin
NASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T linker.ld
DISK_IMG = patchouli.iso

.PHONY: all run clean

all: patchouli.iso

vga.o: vga.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

boot.o: boot.s
	$(NASM) $(NASMFLAGS) $< -o $@

kernel: boot.o kernel.o vga.o
	$(LD) $(LDFLAGS) -o $@ $^

patchouli.iso: kernel
	mkdir -p PatchouliOS/boot
	mv $< PatchouliOS/boot/kernel
	$(GRUB_MKRESCUE) -o $@ PatchouliOS

run: $(DISK_IMG)
	@echo "Running disk image..."
	qemu-system-x86_64 -cdrom $(DISK_IMG)

clean:
	rm -f *.o kernel patchouli.iso
	rm -rf PatchouliOS/kernel
