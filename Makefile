# Makefile for building the bootable disk image

# Compiler and flags
NASM = nasm
DD = dd
QEMU = qemu-system-i386

# Source files
BOOTLOADER_SRC = bootloader.asm
KERNEL_SRC = kernel.asm

# Binary files
BOOTLOADER_BIN = bootloader.bin
KERNEL_BIN = kernel.bin
DISK_IMG = patchouli.img

# Build targets
all: $(DISK_IMG)

$(DISK_IMG): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	@echo "Creating disk image..."
	@$(DD) if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	@$(DD) if=$(BOOTLOADER_BIN) of=$(DISK_IMG) conv=notrunc
	@$(DD) if=$(KERNEL_BIN) of=$(DISK_IMG) seek=1 conv=notrunc

$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	@echo "Assembling bootloader..."
	@$(NASM) -f bin $(BOOTLOADER_SRC) -o $(BOOTLOADER_BIN)

$(KERNEL_BIN): $(KERNEL_SRC)
	@echo "Assembling kernel..."
	@$(NASM) -f bin $(KERNEL_SRC) -o $(KERNEL_BIN)

run: $(DISK_IMG)
	@echo "Running disk image..."
	@$(QEMU) -fda $(DISK_IMG)

clean:
	@echo "Cleaning up..."
	@rm -f $(BOOTLOADER_BIN) $(KERNEL_BIN) $(DISK_IMG)

.PHONY: all clean run
