kernel:
    jmp k_main

kernel_msg db "Welcome to PatchouliOS", 0x0D, 0x0A, 0

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

k_main:
    push cs
    pop ds
    mov si, kernel_msg
    call print_msg
.k_main_loop:
    jmp .k_main_loop

times 512-($-$$) db 0
