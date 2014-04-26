#include "types.h"
#include "x86.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// add a path to the pathvariable in exec.c
int
sys_add_path(void)
{
  char *path;
    if(argstr(0, &path) < 0){
      return -1;
    }
else{
  definition_add_path(path);
  }
  return 0;  
}
 
int
sys_wait2(void)
{
  int wtime;
  int rtime;
  int iotime;
  if(argint(0, &wtime) < 0){
      return -1;
    }
    if(argint(1, &rtime) < 0){
      return -1;
    }
    if(argint(2, &iotime) < 0){
      return -1;
    }
return wait2((int *)wtime,(int *)rtime,(int *)iotime);

}

int
sys_getquanta(void)
{
return getquanta();
}

int
sys_getqueue(void)
{ 
return getqueue();
}

int
sys_signal(void)
{
  int handler;
  int signum;
  
  if(argint(0, &signum) < 0){
    cprintf("err1\n");
    return -1;
  }
  if(argint(1, &handler) < 0){
    cprintf("err2\n");
    return -1;
  }
  if(signum < 0 || signum >= NUMSIG)
  {
    cprintf("err3\n");
    return -1;
  }
  //cprintf("registering signal %d as handler %d\n",signum,handler);
  
  proc->handlers[signum-1]=(sighandler_t)handler;

  return 0;
}

int
sys_sigsend(void)
{
  int pid;
  int signum;

  if(argint(0, &pid) < 0){
    cprintf("err1\n");
    return -1;
  }
  if(argint(1, &signum) < 0){
    cprintf("err2\n");
    return -1;
  }
  if(signum < 0 || signum >= NUMSIG)
  {
    cprintf("err3\n");
    return -1;
  }
pid = handle_sigsend(pid,signum);
  return pid;
}

int 
sys_alarm(void)
{
  int alarm_time;
  if(argint(0, &alarm_time) < 0){

    return -1;
  }
  if (alarm_time<0)
  {
    return -1;
  }
  if (alarm_time==0)
  {
    proc->pending = proc-> pending & ~(1 << (SIGALRM-1));
    return -1;
  }
  cprintf("*");
  //proc->pending = proc-> pending | (1 << SIGALRM);
  proc->alarm = alarm_time;
  return 0;

};