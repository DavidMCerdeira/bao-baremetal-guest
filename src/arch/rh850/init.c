#include <core.h>
#include <intc.h>
#include <timer.h>
#include <reent.h>
#include <string.h>
#include <srs.h>
extern void _start();

static inline void ei(){
    asm volatile("ei\n\t");
}

#include <reent.h>

// One global reentrancy struct for the whole system
/* static struct _reent g_reent[8]; */
/* extern void __libc_init_array(void); */ 
/* void libc_reent_init(void) */
/* { */ 
/*     _impure_ptr = &g_reent[get_peid()]; */
/*     _REENT_INIT_PTR(_impure_ptr); */
/* } */ 
void arch_init(){
    /* libc_reent_init(); */
#ifndef SINGLE_CORE
    static volatile uint32_t *const BOOTCTRL = (void*) PLAT_BOOTCTRL_ADDR;
    *BOOTCTRL = ~0UL;
#endif
    intc_init();
    ei();
}
