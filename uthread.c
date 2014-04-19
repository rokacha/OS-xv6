#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

#include "uthread.h"


static struct {
  uthread_t table[MAX_THREAD];
  int length;
  int current;
} tTable;



static uthread_p
allocThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
  
  found:
  
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit as return address
    : "=r" ((int)t->ebp) 
    : "r" ((int)t->esp) , "r"((int)uthread_exit)
  );
  t->state=T_UNINIT;
  return t;
}

void 
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  //uthread_p mainT = allocThread(); needed to allocate the main thread !!!!!!
  allocThread(); 
  
  // need to add esp,ebp and stack of the process somehow
  
  if(signal(SIGALRM,uthread_yield)<0)
  {
    printf(1,"Cant register the alarm signal");
    exit();
  }
  if(alarm(THREAD_QUANTA)<0)
  {
    printf(1,"Cant activate alarm system call");
    exit();
  }
  
}

// int  uthread_create(void (*func)(void *), void* value);

 void uthread_exit()
 {
   //needs to be filled
 }
void uthread_yield(void)
{
  //needs to be filled
}

// int  uthred_self(void);
// int  uthred_join(int tid);