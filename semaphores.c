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
semaphore_enqueue(struct binary_semaphore* semaphore)
{

}
void
semaphore_dequeue(struct binary_semaphore* semaphore)
{

}

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
  semaphore->init=0;  
  semaphore->locked = value;
  semaphore->init=1;
}

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{

  if(semaphore->init==0)
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    return;
  }

  while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
  {
    uthread_yield();
  }

}

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
  if(semaphore->init==0)
  {
  printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
  return;
  }

  if(xchg(&semaphore->locked, 1)==1) //means the semaphore is taken allready
  {
    printf(1,"trying to release allready released semaphore!!!\n");
  }
}