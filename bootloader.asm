bits 16
org 0x7C00

boot:
    jmp main

; BIOS Parameter Block (BPB)
    DB "PatchouliOS"
    DW 0x0200  ; Bytes per sector
    DB 0x01    ; Sectors per cluster
    DW 0x0001  ; Reserved sectors count
    DB 0x02    ; Number of FATs
    DW 0x00E0  ; Root directory entries
    DW 0x0B40  ; Total sectors
    DB 0xF0    ; Media descriptor
    DW 0x0009  ; Sectors per FAT
    DW 0x0012  ; Sectors per track
    DW 0x0002  ; Number of heads
    DD 0x00000000  ; Hidden sectors
    DD 0x00000000  ; Total sectors (if bpbTotalSectors is 0)
    DB 0x00    ; Drive number
    DB 0x00    ; Reserved (for use by Windows NT)
    DB 0x29    ; Boot signature
    DD 0x00010203  ; Volume serial number
    DB "PATCHOULI_OS"   ; Volume label
    DB "FAT12   "   ; Filesystem type

main:
    mov si, bootloader_started_msg
    call print_msg
    call reset_floppy
    call read_kernel
    jmp $

bootloader_started_msg db "Boot loader started...", 0x0D, 0x0A, 0
floppy_reset_msg db "Floppy disk reset...", 0x0D, 0x0A, 0
kernel_loaded_msg db "Kernel loaded...", 0x0D, 0x0A, 0
bootloader_complete_msg db "Bootloader complete.", 0x0D, 0x0A, 0

print_msg:
    mov ah, 0x0E
    .start_loop:
        lodsb
        cmp al, 0
        je .end_loop
        int 0x10
        jmp .start_loop
    .end_loop:
    ret

reset_floppy:
    mov ah, 0
    mov dl, 0
    int 0x13
    jc reset_floppy
    mov si, floppy_reset_msg
    call print_msg
    ret

read_kernel:
    mov ax, 0x1000
    mov es, ax
    xor bx, bx
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x00
    int 0x13
    jc read_kernel
    mov si, kernel_loaded_msg
    call print_msg
    jmp 0x1000:0x0000

times 510 - ($-$$) db 0
dw 0xAA55
