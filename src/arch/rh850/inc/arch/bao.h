#ifndef __ARCH_BAO_H__
#define __ARCH_BAO_H__

static inline void bao_hypercall(unsigned long id)
{
    register unsigned long r6 asm("r6") = id;
    __asm__ volatile ("hvtrap 0" : : "r"(r6));
}


#endif /* __ARCH_BAO_H__ */
