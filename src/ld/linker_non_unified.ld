#include <core.h>
#include <plat.h>

MEMORY
{
  /* Keep consistent with bao-demos/config.c */
  FLASH  : ORIGIN = FLASH_BASE,  LENGTH = FLASH_SIZE

  RAM    : ORIGIN = RAM_BASE,  LENGTH = RAM_SIZE
}

ENTRY(_start)

SECTIONS {

    .start :  {
        *(.start*)
    } > FLASH

    .text :  {
        *(.text*)
    } > FLASH

    .const :  {
        *(.const*)
        *(.rodata*)
    } > FLASH

    /* .data initial contents stored in flash must be copied to RAM */
    .data : ALIGN(8) {
        __data_start = .;
        *(.data .data.*)
        PROVIDE(__global_pointer$ = . + 0x800);
        __gp = . + 0x800;
        *(.sdata .sdata.* .sdata2.*)
        __data_end = .;
    } > RAM AT > FLASH

    /* LMA (flash) for startup copy */
    __data_load_start = LOADADDR(.data);
    __data_load_end   = LOADADDR(.data) + SIZEOF(.data);

    .bss (NOLOAD) :  {
        __bss_start = .;
        *(.bss* .sbss*)
        *(COMMON)
        __bss_end = .;
    } > RAM

    .stackheap (NOLOAD) : ALIGN(16) {
        PROVIDE(_stack_base = .);
        . = . + STACKHEAP_SIZE;
        PROVIDE(_heap_base = .);
        PROVIDE(__heap_base = .); /* needed for RH850 */
    } > RAM
}
