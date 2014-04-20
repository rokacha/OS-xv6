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

int
getRunningThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_RUNNING)
      return i;
  }
  return -1;
}

int
getNextThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_RUNNABLE)
      return i;
  }
  return -1;
}

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
  t->firstTime=0;
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
  return t;
}

void 
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
  mainT->state = T_RUNNABLE;
  
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

int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  
  return t->tid;
}

void 
uthread_exit()
{
  //needs to be filled
}

void 
uthread_yield()
{
  
  uthread_p oldt;
  uthread_p newt;
  int old=getRunningThread();
  int new=getNextThread();
  if(old<0)
  {
     printf(1,"Cant find running thread");
    exit();
  }
  if(new<0)
  {
     printf(1,"Cant find runnable thread");
    exit();
  }
oldt=&tTable.table[old];
newt=&tTable.table[new];
  
    asm("pusha");
    STORE_ESP(oldt->esp);
    oldt->state=T_RUNNABLE;
    LOAD_ESP(newt->esp);
    
  
    newt->state=T_RUNNING;

    asm("popa");
    if(oldt->firstTime==0)
    {
       asm("ret");////only firest time
       oldt->firstTime=1;
    }
   


}

// int  uthred_self(void);
// int  uthred_join(int tid);