#ifndef __CYCLE_COUNTER__
#define __CYCLE_COUNTER__

#include <arch/cycle_counter.h>

unsigned long cycle_counter_get(void);
void cycle_counter_prepare(void);

#endif /* __CYCLE_COUNTER__ */
