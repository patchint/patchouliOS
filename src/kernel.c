#include "vga.h"
#include "gdt.h"



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
}
