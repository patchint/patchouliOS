CC = gcc
NASM = nasm
LD = ld
GRUB_MKRESCUE = grub-mkrescue

# Add -g flag to CFLAGS for debugging and use 
# gdb PatchouliOS/boot/kernel
# Inside of GDB : target remote :1234
# Then go through the wiki of GDB and good luck !

CFLAGS = -m32 -fno-stack-protector -fno-builtin
NASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T src/linker.ld
DISK_IMG = patchouli.iso

SRCDIR = src
BINDIR = bin
BUILDDIR = build

.PHONY: all run clean

all: $(DISK_IMG)

$(BINDIR):
	mkdir -p $(BINDIR)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(BINDIR)/vga.o: $(SRCDIR)/vga.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BINDIR)/kernel.o: $(SRCDIR)/kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BINDIR)/gdt.o: $(SRCDIR)/gdt.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BINDIR)/util.o: $(SRCDIR)/util.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BINDIR)/idt.o: $(SRCDIR)/idt.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BINDIR)/gdts.o: $(SRCDIR)/gdts.s
	$(NASM) $(NASMFLAGS) $< -o $@

$(BINDIR)/idts.o: $(SRCDIR)/idt.s
	$(NASM) $(NASMFLAGS) $< -o $@

$(BINDIR)/boot.o: $(SRCDIR)/boot.s
	$(NASM) $(NASMFLAGS) $< -o $@

$(BINDIR)/kernel: $(BINDIR)/boot.o $(BINDIR)/gdts.o $(BINDIR)/kernel.o $(BINDIR)/vga.o $(BINDIR)/gdt.o $(BINDIR)/util.o $(BINDIR)/idt.o $(BINDIR)/idts.o
	$(LD) $(LDFLAGS) -o $@ $^

$(DISK_IMG): $(BINDIR)/kernel
	mkdir -p $(SRCDIR)/PatchouliOS/boot
	mv $(BINDIR)/kernel $(SRCDIR)/PatchouliOS/boot/kernel
	$(GRUB_MKRESCUE) -o $@ $(SRCDIR)/PatchouliOS

run: $(DISK_IMG)
	@echo "Running disk image..."
	qemu-system-x86_64 -cdrom $(DISK_IMG)

clean:
	rm -f $(BINDIR)/*.o $(BINDIR)/kernel $(DISK_IMG)
	rm -rf $(SRCDIR)/PatchouliOS/boot/kernel
