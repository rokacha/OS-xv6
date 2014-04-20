#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"



void
acquireSemaphore(struct binary_semaphore *sem)
{
  int j;
  int i = uthred_self();
  
  sem->choosing[i]=1;
  sem->number[i] = 1 + sem->maximalNum ;
  sem->choosing[i]=0;
  
  for (j=0;j<MAX_THREAD;j++)
  {
    while(sem->init==0 ||
	  !(sem->choosing[j]=0) ||
	  !((sem->number[j]=0) || (sem->number[j] >= sem->number[i])))
    {
      uthread_yield();  //for not wasting process cpu-time
    }
  }
}

void
releaseSemaphore(struct binary_semaphore *sem)
{
  int i= uthred_self();
  sem->number[i]=0;
}

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
  semaphore->init=0;
  
  if(value)
    semaphore->thread=-1;
  else 
    semaphore->thread = uthred_self();
  
  semaphore->locked = ( value == 0 );
  
  semaphore->init=1;
  
}

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
  acquireSemaphore(semaphore);
  
  int i= uthred_self();
  
  while( semaphore->locked==1)
  {
      releaseSemaphore(semaphore);
      //starvation freedom is guaranteed only if thread scheduling is fair
      //possible to add a function to send threads to sleep instead
      //and wake them up again when calling up on the semaphore
      //this also requires a queue to be added to the semaphore struct
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
  
  int i= uthred_self();
  
  if( semaphore->locked == 1 && semaphore->thread == i)
  {
      semaphore->locked = 0;
      semaphore->thread = -1;
  }

  releaseSemaphore(semaphore);
}