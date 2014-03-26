#ifndef SCHEDFLAG
  SCHEDFLAG=SCHED_DEFAULT
#endif

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"


struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

static int pidQueue[NUMBER_OF_QUEUES*NPROC]={-1};
static int queueCurrent[NUMBER_OF_QUEUES]={0};
static int queueEnd[NUMBER_OF_QUEUES]={0};

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

  //used to get the number of ticks since the clock started
int
get_time(){
  uint rticks;

  acquire(&tickslock);
  rticks=ticks;
  release(&tickslock);
return rticks;
}


void
pinit(void)
{
  int i;
  initlock(&ptable.lock, "ptable");
  for(i=0;i<NUMBER_OF_QUEUES*NPROC;i++)
    pidQueue[i]=-1;
  for(i=0;i<NUMBER_OF_QUEUES;i++){
  queueCurrent[i]=i*NPROC;
  queueEnd[i]=i*NPROC;
}

}


void
sleepingUpDate(void)
{
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == SLEEPING){
      p->iotime++;
      
    }
    if(p->state == RUNNING){
      p->rtime++;
      p->quanta--;
    }
  }
 release(&ptable.lock);
}

int
findIndxOfProc(struct proc* np){
  int i;
  for(i=0; i < NPROC; i++)
  {
    if((&ptable.proc[i])->pid == np->pid){
      return i;   
    }
  }
 return -1;
}

void
fixQueue(int queue){
  int i;
  
  for(i=queue*NPROC;i<queueEnd[queue];i++)
  {
    if(pidQueue[i]==-1){
       pidQueue[i]=pidQueue[i+1];
       pidQueue[i+1]=-1;
    }
  }
  while(queueEnd[queue]>queue*NPROC && pidQueue[queueEnd[queue]-1]==-1){  
    queueEnd[queue]--;
    if(queueCurrent[queue]>queueEnd[queue])
      queueCurrent[queue]--;
  }
}

int
queuesAboveEmpty(int queue){
  int ans = 1;
  int placer;
  if(queue==NUMBER_OF_QUEUES-1)
    return 1;
  
  for(placer = (queue+1)*NPROC;placer<NUMBER_OF_QUEUES*NPROC;placer++)
  {
    ans = ans * (pidQueue[placer]==-1)? 1 : 0;
  }

  return ans;
}

void
changeStatus(enum procstate s,struct proc* p)
{
  
  int location = findIndxOfProc(p);
  
  enum procstate prevState = p->state; 

  p->state=s;

  if(location<0)
    cprintf("Cant find any processes with pid %d\n",p->pid);
  
    switch(SCHEDFLAG){
      case SCHED_3Q:

        if(s==RUNNABLE)
        {
          if(p->quanta==0)  //process was forced to yield last run
          {
            p->queue = (p->queue==0)? 0 : (p->queue-1);
          }
          if(prevState==SLEEPING){
           p->queue= (p->queue==(NUMBER_OF_QUEUES-1))? (NUMBER_OF_QUEUES-1) : (p->queue+1); 
          }
          pidQueue[queueEnd[p->queue]]=location;
          p->placeInQueue=queueEnd[p->queue];
          queueEnd[p->queue]++;
        }
        if(s==RUNNING){
          pidQueue[p->placeInQueue]=-1;
          p->placeInQueue=-1;
          p->quanta=(p->queue==0)? -1 : QUANTA; //lowest queue works without preempting
        }
        if(s==UNUSED||s==ZOMBIE||s==SLEEPING){
          pidQueue[p->placeInQueue]=-1;
          p->placeInQueue=-1;
        }
      break;

      case SCHED_FCFS:
      case SCHED_FRR:
        if(s==RUNNABLE)
        {
          pidQueue[queueEnd[p->queue]]=location;
          p->placeInQueue=queueEnd[p->queue];
          queueEnd[p->queue]++;
        }
        if(s==RUNNING){
          pidQueue[p->placeInQueue]=-1;
          p->placeInQueue=-1;
          if(SCHEDFLAG==SCHED_FRR)
            p->quanta=QUANTA;
          else
            p->quanta=-1;
        }
        if(s==UNUSED||s==ZOMBIE||s==SLEEPING){
          pidQueue[p->placeInQueue]=-1;
          p->placeInQueue=-1;
        }
      break;
      default:
        if(s==RUNNING){
          p->quanta=QUANTA;
        }
      break;
    }
}


//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;
  
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:

  p->queue=NORMAL_PRIORITY_QUEUE;
  
  
  changeStatus(EMBRYO,p);

  p->pid = nextpid++;

  //update time of creation
  p->ctime=get_time();
  p->iotime=0;
  p->rtime=0;

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    changeStatus(UNUSED,p);
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;
  
  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;
  
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}



//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();

  initproc = p;
  if((p->pgdir = setupkvm(kalloc)) == 0)
    panic("userinit: out of memory?");

  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
  
  changeStatus(RUNNABLE,p);
  
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  
  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    changeStatus(UNUSED,np);
    return -1;
  }
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
 
  pid = np->pid;
  changeStatus(RUNNABLE,np);
  safestrcpy(np->name, proc->name, sizeof(proc->name));
  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
  proc->cwd = 0;
  proc->etime=get_time();
  proc->queue=0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  changeStatus(ZOMBIE,proc);
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        changeStatus(UNUSED,p);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->queue=0;
       
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}


int 
wait2(int *wtime, int *rtime, int *iotime)
{
struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        changeStatus(UNUSED,p);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->queue=0;
        *wtime=p->etime-p->ctime-p->rtime-p->iotime;
        *rtime=p->rtime;
        *iotime=p->iotime;
        
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}


void
register_handler(sighandler_t sighandler)
{
  char* addr = uva2ka(proc->pgdir, (char*)proc->tf->esp);
  if ((proc->tf->esp & 0xFFF) == 0)
    panic("esp_offset == 0");

    /* open a new frame */
  *(int*)(addr + ((proc->tf->esp - 4) & 0xFFF))
          = proc->tf->eip;
  proc->tf->esp -= 4;

    /* update eip */
  proc->tf->eip = (uint)sighandler;
}


void
operateProcess(struct proc *p){
  switchuvm(p);
  changeStatus(RUNNING,p);
  swtch(&cpu->scheduler, proc->context);
  switchkvm();

  proc = 0;
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  int workingQueue;
    //int i;
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    switch(SCHEDFLAG){
      case SCHED_3Q:
        for(workingQueue=NUMBER_OF_QUEUES-1;workingQueue>=0;workingQueue--){
          if(queuesAboveEmpty(workingQueue)){
            for(queueCurrent[workingQueue]=workingQueue*NPROC;
              queueCurrent[workingQueue]< queueEnd[workingQueue];
              queueCurrent[workingQueue]++)
            {

              if(pidQueue[queueCurrent[workingQueue]]!=-1&&
                 ptable.proc[pidQueue[queueCurrent[workingQueue]]].pid!=0&&
                 queuesAboveEmpty(workingQueue))
              {
                proc = &ptable.proc[pidQueue[queueCurrent[workingQueue]]];
                operateProcess(proc);
              }
            }
          }
          fixQueue(workingQueue);
        }
      break;

      case SCHED_FCFS:
      case SCHED_FRR:

        for(queueCurrent[NORMAL_PRIORITY_QUEUE]=NORMAL_PRIORITY_QUEUE*NPROC;
          queueCurrent[NORMAL_PRIORITY_QUEUE]< queueEnd[NORMAL_PRIORITY_QUEUE];
          queueCurrent[NORMAL_PRIORITY_QUEUE]++)
        {

          if(pidQueue[queueCurrent[NORMAL_PRIORITY_QUEUE]]!=-1)
            if(ptable.proc[pidQueue[queueCurrent[NORMAL_PRIORITY_QUEUE]]].pid!=0){

            proc = &ptable.proc[pidQueue[queueCurrent[NORMAL_PRIORITY_QUEUE]]];
            operateProcess(proc);
          }
        }
        fixQueue(NORMAL_PRIORITY_QUEUE);
    break;
      
    default:
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state != RUNNABLE)
          continue;
      
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        proc = p;
        operateProcess(proc);
      }
    break;
    }
        release(&ptable.lock);
  }
  
}


// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);

  cpu->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
   changeStatus(RUNNABLE,proc);
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot 
    // be run from main().
    first = 0;
    initlog();
  }
  
  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
   changeStatus(SLEEPING,proc);
 
  sched();

  // Tidy up.
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == SLEEPING && p->chan == chan)
    {
      changeStatus(RUNNABLE,p);
    }
    
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING){
        changeStatus(RUNNABLE,p);
      }
      
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36f
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  cprintf("Process List:\n");
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("id:%d status:%s name:%s\n", p->pid, state, p->name);
    cprintf("ctime:%d rtime:%d iotime:%d etime:%d\n", p->ctime, p->rtime, p->iotime,p->etime);
        cprintf("quanta is:%d queue is:%d\n", p->quanta,p->queue);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf("%p  ", pc[i]);
    }
    cprintf("\n");
  }
  cprintf("SCHEFLAG is : %d",SCHEDFLAG);
  for (i=0;i<NUMBER_OF_QUEUES*NPROC;i++){
    if (i%NPROC==0)
    {
      cprintf("\n* Queue %d *",i/NPROC);  
    }
    if(pidQueue[i]!=-1)
      cprintf(" %d",pidQueue[i]);
  }
  cprintf("\n");
  
}


