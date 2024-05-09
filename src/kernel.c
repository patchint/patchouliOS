#include "vga.h"
#include "gdt.h"
#include "idt.h"


void kmain(void);

void kmain(void) {
    Reset();
    print("Welcome to PatchouliOS !\r\n");

    // a cat
    print("       /\\_/\\\n");
    print("      ( o.o )\n");
    print("       > ^ <\n");

    initGdt();
    print("GDT is working!\r\n");
    initIdt();
    print(15/30);
    print("Interrupts are working!\rn");
}
