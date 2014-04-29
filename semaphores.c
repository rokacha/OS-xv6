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
/*
void 
semaphore_acquire(struct binary_semaphore* semaphore)
{
    while(xchg(&semaphore->taken, 1) == 1) 
    {
      uthread_yield();
    }
}
void
semaphore_release(struct binary_semaphore* semaphore)
{
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
  semaphore->init=0;
  
  if(value!=0)
    semaphore->thread=-1;
  else 
    semaphore->thread = uthread_self();
  
  semaphore->locked = value;
 // semaphore->taken=0;
  semaphore->init=1;
  
}

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    return;
  }
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    {
      uthread_yield();
    }
    semaphore->thread = i;
  }
  //semaphore_release(semaphore);
}

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    return;
    }
  
  int i= uthread_self();
  if( semaphore->locked == 0 && semaphore->thread == i)
  {
      semaphore->thread = -1;
      semaphore->locked = 1;

  }
//semaphore_release(semaphore);
}