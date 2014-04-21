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
getNextThread(int j)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
  {
    if(t->state==T_RUNNABLE)
      return i;
    i++;
    if(i==MAX_THREAD)
    {
     i=0;
     t=&tTable.table[i];
   }
   else
    t++;

}
return -1;
}


static uthread_p
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
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
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
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
  currentThread=mainT;
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
  t->state= T_RUNNABLE;
  
  return t->tid;
}

void 
uthread_exit()
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
  currentThread->esp=-1;
  currentThread->ebp=-1;
  free(currentThread->stack);
  currentThread->state=T_FREE;
  currentThread->firstTime=0;
  int new=getNextThread(old);
  if(new>=0)
  {
   newt=&tTable.table[new];
   newt->state=T_RUNNING;
   LOAD_ESP(newt->esp);
   LOAD_EBP(newt->ebp);
   asm("popa");
   currentThread=newt;
   if(alarm(THREAD_QUANTA)<0)
   {
    printf(1,"Cant activate alarm system call");
    exit();
  }
}
else
        {/////what if some thread state is sleeping?

         exit();
       }

     }


     int
     uthred_join(int tid)
     {
      if((&tTable.table[tid])->state==T_FREE)
        return -1;
      else
      {
        int i=0;
        while((&tTable.table[tid])->waiting[i]!=-1)
          i++;
        (&tTable.table[tid])->waiting[i]=currentThread->tid;
        currentThread->state=T_SLEEPING;
        uthread_yield();
        return 1;
      }
    }

    void 
    uthread_yield()
    {
      uthread_p newt;
      int old=currentThread->tid;
      int new=getNextThread(old);
      if(new<0)
      {
       printf(1,"(fun uthread_yield)Cant find runnable thread");
       exit();
     }
     newt=&tTable.table[new];

     asm("pusha");
     STORE_ESP(currentThread->esp);
     if(currentThread->state==T_RUNNING)
      currentThread->state=T_RUNNABLE;
    LOAD_ESP(newt->esp);
    

    newt->state=T_RUNNING;

    asm("popa");
    if(currentThread->firstTime==0)
    {
       asm("ret");////only firest time
       currentThread->firstTime=1;
     }

     currentThread=newt;
     if(alarm(THREAD_QUANTA)<0)
       {
        printf(1,"Cant activate alarm system call");
        exit();
      }

   }

   int  uthred_self(void)
   {
    return currentThread->tid;
  }
// int  uthred_join(int tid);