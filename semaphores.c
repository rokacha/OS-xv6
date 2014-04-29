#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
}


void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
  semaphore->init=0;
  
  if(value!=0)
    semaphore->thread=-1;
  else 
    semaphore->thread = uthread_self();
  
  semaphore->locked = value;
  
  semaphore->init=1;
  
}

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
  if(semaphore->init==0)
  {
    printf(1,"semaphore uninitialized yet\n");
    return;
  }
  
  
  int i= uthread_self();
  
  while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
  {
    uthread_yield();
  }
  
  semaphore->thread = i;
}

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    if(semaphore->init==0)
  {
    printf(1,"semaphore uninitialized yet\n");
    return;
  }
  
  int i= uthread_self();
  
  if( semaphore->locked == 0 && semaphore->thread == i)
  {
      semaphore->thread = -1;
      semaphore->locked = 1;

  }

}