bits 32

section .text
    align 4
    dd 0x1BADB002
    dd 0x00000000
    dd -(0x1BADB002 + 0x00000000)

global start
extern kmain

start:
    cli
    mov esp, stack_space
    call kmain
    hlt

haltkernel:
    cli
    hlt
    jmp haltkernel

section .bss 

resb 8192

stack_space:
