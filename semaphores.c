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
acquireSemaphore(struct binary_semaphore *sem)
{
  while(xchg(&sem->taken, 1) == 1) 
  {
    uthread_yield();
  }
}

void
releaseSemaphore(struct binary_semaphore *sem)
{
  sem->taken=0;
}

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
  semaphore->init=0;
  
  if(value==1)
    semaphore->thread=-1;
  else 
    semaphore->thread = uthread_self();
  
  semaphore->locked = 1 - value;
  
  semaphore->init=1;
  
}

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
  acquireSemaphore(semaphore);
  
  int i= uthread_self();
  
  while( semaphore->locked==1)
  {
      releaseSemaphore(semaphore);
      uthread_yield();  
      acquireSemaphore(semaphore);
  }
  
  semaphore->locked = 1;
  semaphore->thread = i;
  releaseSemaphore(semaphore);
}

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
  acquireSemaphore(semaphore);
  
  int i= uthread_self();
  
  if( semaphore->locked == 1 && semaphore->thread == i)
  {
      semaphore->locked = 0;
      semaphore->thread = -1;
  }

  releaseSemaphore(semaphore);
}