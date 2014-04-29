#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

#define THREAD_QUANTA 5

// Saves the value of esp to var
#define STORE_ESP(var)  asm("movl %%esp, %0;" : "=r" ( var ))

// Saves the value of ebp to var
#define STORE_EBP(var)  asm("movl %%ebp, %0;" : "=r" ( var ))

// Loads the contents of var into esp
#define LOAD_ESP(var)   asm("movl %0, %%esp;" : : "r" ( var ))

// Loads the contents of var into ebp
#define LOAD_EBP(var)   asm("movl %0, %%ebp;" : : "r" ( var ))

//Pop all registers
#define POP_ALL_REGISTERS() asm("popa")

//Push all registers
#define PUSH_ALL_REGISTERS() asm("pusha")

//pop top of stack and use it to goto function
#define POP_AND_RET() asm("pop %ebp;" "ret;")

//Used to push a function to a specific stack
#define PUSH_FUNC(ESP,EBP,FUNC) asm(\
      "push %1;"\
      "push %2;"\
      "movl %%esp,%0;"\
      :"=r"(ESP)\
      :"r"(FUNC),"r"(EBP));

static struct {
  uthread_t table[MAX_THREAD];

} tTable;


/*
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  if(currentThread->tid==1){
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
  {
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }
}
}

/*
 *Count the number of threads that thread tid is waiting for
 */
int
count_waiting(int tid)
{
  int count=0;
  int i;
  for (i=0; i<MAX_THREAD ; i++)
  {
    count += tTable.table[tid].waitingFor[i];
  }
  return count;
}

/*
 * returns the next thread in line to run
 * if none exists it returns -1
 */
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

/*
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
  if(i==0) //main thread init
  {
    STORE_ESP(t->esp);
    STORE_EBP(t->ebp);
    t->firstTime=0;
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
    t->ebp=(int)t->stack+STACK_SIZE;
    t->esp=t->ebp;
    t->firstTime=1;
  }
  for(j=0;j<MAX_THREAD;j++)
  {
    t->waitingFor[j]=-1;
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
  
    
  return t;
}

/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
  if(currentThread==0)
    return -1;
  
  currentThread->state = T_RUNNING;
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
  {
    printf(1,"Cant register the alarm signal");
    exit();
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
  {
    printf(1,"Cant activate alarm system call");
    exit();
  }
  return 0;
}

void
wrap_func()
{
  currentThread->func(currentThread->arguments);
  uthread_exit();
}
/*
 * creates a new thread that receives a pointer
 * to a function from which to start and poinetr to arguments
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uint local_esp;
  uthread_p t = allocThread();
  if(t==0)
    return -1;

  t->func=start_func;
  t->arguments=arg;
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
  LOAD_ESP(t->esp);
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
  LOAD_ESP(local_esp);
  
  t->state = T_RUNNABLE;
  
  return t->tid;
}

/*
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
  {
   if(currentThread->waitedOn[i]==1)
   {
     tTable.table[i].waitingFor[currentThread->tid]=0; //release thread i from waiting
     currentThread->waitedOn[i]=0; //not necessary maybe
     
     if(count_waiting(i)==0) //thread i is not waiting for no one
     {
       tTable.table[i].state=T_RUNNABLE;
     }
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
  
  //release all resources and zero all fields
  free(currentThread->stack);
  currentThread->tid=-1;
  currentThread->esp=-1;
  currentThread->ebp=-1;
  currentThread->func=0;
  currentThread->arguments=0;
  currentThread->stack=0;
  currentThread->firstTime=1;
  currentThread->state=T_FREE;
  
  //load new thread
  if(new>=0)
  {
    currentThread=&tTable.table[new];
    currentThread->state=T_RUNNING;
    LOAD_ESP(currentThread->esp);
    LOAD_EBP(currentThread->ebp);
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
    {
      printf(1,"Cant activate alarm system call");
      exit();
    }
    
    if(currentThread->firstTime==1)
    {
      currentThread->firstTime=0;
      POP_AND_RET();
    }
    else
    {  
    POP_ALL_REGISTERS();
    }
  }
}

/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
    tTable.table[tid].waitingFor[currentThread->tid]=1;
    currentThread->waitedOn[tid]=1;
    currentThread->state=T_SLEEPING;
    uthread_yield();
    return 1;
  }
}

/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new=getNextThread(currentThread->tid);
  if(new==-1)
  {
    if(alarm(THREAD_QUANTA)<0)
    {
      printf(1,"Cant activate alarm system call\n");
      exit();
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
    STORE_ESP(currentThread->esp);
    STORE_EBP(currentThread->ebp);
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
      currentThread->state=T_RUNNABLE;

    currentThread=&tTable.table[new];

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
    LOAD_EBP(currentThread->ebp);
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
    {
      printf(1,"Cant activate alarm system call\n");
      exit();
    }  
    currentThread->state=T_RUNNING;
    
    if(currentThread->firstTime==1)
    {
    currentThread->firstTime=0;
    POP_AND_RET();
    }
    else
    {
      POP_ALL_REGISTERS();
    }
  }
}

int
uthread_self(void)
{
  return currentThread->tid;
}