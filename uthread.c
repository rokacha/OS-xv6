#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

#define THREAD_QUANTA 5
/********************************
        Macors which inline assembly
 ********************************/
 
// Saves the value of esp to var
#define STORE_ESP(var)  asm("movl %%esp, %0;" : "=r" ( var ))

// Saves the value of ebp to var
#define STORE_EBP(var)  asm("movl %%ebp, %0;" : "=r" ( var ))

// Saves the value of eip to var
//#define STORE_EIP(var)  asm("movl %%eip, %0;" : "=r" ( var ))

// Loads the contents of var into esp
#define LOAD_ESP(var)   asm("movl %0, %%esp;" : : "r" ( var ))

// Loads the contents of var into ebp
#define LOAD_EBP(var)   asm("movl %0, %%ebp;" : : "r" ( var ))

//jmp to address
#define JMP(var) asm("jmp *%0": : "r" (var))

//Pop all registers
#define POP_ALL_REGISTERS() asm("popa")

//Push all registers
#define PUSH_ALL_REGISTERS() asm("pusha")

//call head of stack
#define CALL_HEAD() asm("pop %eax;" "call %eax;")

/*pushes a function FUNC to the stack represented by ESP,ESP
 * and updates the stack poinetr ESP accordingly
 *save current esp
 *use current stack for push
 *push exit func
 *update current esp after push
 *reload former stack*/
#define PUSH_FUNC(ESP,EBP,FUNC)    asm(\
		"movl %%esp,%%ebx;"\
		"movl %1,%%esp;"\
		"push %2;" \
		"movl %%esp,%0;"\
		"movl %%ebx,%%esp;"\
	      : "=r" (ESP)\
	      : "r" (EBP) , "r"(FUNC)\
	      : "%ebx")

/*pushes a stating function with its arguments to the stack ESP
 * and updates the stack poinetr ESP accordingly
 *save current esp
 *use the new thread esp
 *stores the arguments to be used
 *stores the start_func location
 *export new esp
 *restore former esp*/
#define PUSH_STARTING_FUNC(ESP,FUNC,ARG)  asm(\
		"movl %%esp,%%eax;"\
		"movl %3,%%esp;"\
		"push %1;"\
		"push %2;"\
		"movl %%esp,%0;"\
		"movl %%eax,%%esp;"\
	      : "=r" (ESP)\
	      : "r" (ARG) , "r"(FUNC),"r" (ESP)\
	      :"%eax")

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
  if(i==0)
  {
    STORE_ESP(t->esp);
    STORE_EBP(t->ebp);
    t->firstTime=0;
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
    //t->ebp=(int)t->stack+STACK_SIZE-sizeof(int);
    t->ebp=(int)t->stack+STACK_SIZE;
    t->firstTime=1;
    //init stack state and update pointers
    //PUSH_FUNC(t->esp,t->ebp,uthread_exit);
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
  return 0;
}

void
wrap_func()
{
  asm("push %0;""call %1;"::"r"(currentThread->arguments),"r"(currentThread->func));
  //currentThread->start_func(currentThread->arg);
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
  uthread_p t = allocThread();
  if(t==0)
    return -1;
  //print_stack();
  // printf(1,"creating a new thresd with start func %d and arg %d\n",start_func,arg);  
  t->func=(uint)start_func;
  //printf(1,"--%x--\n",func);
  t->arguments=(uint)arg;
  
  //PUSH_STARTING_FUNC(t->esp,start_func,arg);
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
  printf(1,"called exit\n");
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
    POP_ALL_REGISTERS();
   // LOAD_EIP(currentThread->eip);
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
    {
      printf(1,"Cant activate alarm system call");
      exit();
    }
  }
  
//   else  /////what if some thread is sleeping?
//       exit();
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
  int new=getNextThread(currentThread->tid);
  if(new==-1)
  {
    printf(1,"(uthread_yield) there no other runneble theard, currentThread keep running\n");
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
      
      //change thread state
      if(currentThread->state==T_RUNNING) //might be sleeping from join operation
        currentThread->state=T_RUNNABLE;

      currentThread=&tTable.table[new];

      //load all new thread registers and pointers
      LOAD_ESP(currentThread->esp);
      LOAD_EBP(currentThread->ebp);
      //printf(1,"1");
      // if(alarm(THREAD_QUANTA)<0)
      // {
      //   printf(1,"Cant activate alarm system call\n");
      //   exit();
      // }  
      //printf(1,"2");
      currentThread->state=T_RUNNING;
      
      //print_stack();
      if(currentThread->firstTime==1)
      {
        
        currentThread->firstTime=0;
        wrap_func();
      }
      else
      {
        POP_ALL_REGISTERS();
        //JMP(currentThread->eip);
      }
      
  }
 

}

int
uthread_self(void)
{
  return currentThread->tid;
}