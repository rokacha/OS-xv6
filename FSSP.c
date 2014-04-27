#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

static int next[4][5][5];
struct binary_semaphore sem1;
struct binary_semaphore sem2;
struct binary_semaphore sem3;
int n;
int fire;
void
initNext()
{
  next[0][0][0]=0;
  next[0][0][1]=0;
  next[0][0][2]=2;
  next[0][0][3]=0;
  next[0][0][4]=0;
  next[0][1][0]=1;
  next[0][1][1]=1;
  next[0][1][2]=-1;
  next[0][1][3]=-1;
  next[0][1][4]=1;
  next[0][2][0]=0;
  next[0][2][1]=-1;
  next[0][2][2]=2;
  next[0][2][3]=3;
  next[0][2][4]=0;
  next[0][3][0]=0;
  next[0][3][1]=3;
  next[0][3][2]=-1;
  next[0][3][3]=-1;
  next[0][3][4]=-1;
  next[0][4][0]=0;
  next[0][4][1]=0;
  next[0][4][2]=2;
  next[0][4][3]=0;
  next[0][4][4]=-1;
  
  next[1][0][0]=1;
  next[1][0][1]=1;
  next[1][0][2]=0;
  next[1][0][3]=2;
  next[1][0][4]=-1;
  next[1][1][0]=0;
  next[1][1][1]=1;
  next[1][1][2]=2;
  next[1][1][3]=-1;
  next[1][1][4]=2;
  next[1][2][0]=3;
  next[1][2][1]=-1;
  next[1][2][2]=0;
  next[1][2][3]=5;
  next[1][2][4]=-1;
  next[1][3][0]=0;
  next[1][3][1]=1;
  next[1][3][2]=2;
  next[1][3][3]=-1;
  next[1][3][4]=2;
  next[1][4][0]=3;
  next[1][4][1]=-1;
  next[1][4][2]=0;
  next[1][4][3]=5;
  next[1][4][4]=-1;
  
  
  next[2][0][0]=2;
  next[2][0][1]=3;
  next[2][0][2]=0;
  next[2][0][3]=0;
  next[2][0][4]=-1;
  next[2][1][0]=0;
  next[2][1][1]=0;
  next[2][1][2]=1;
  next[2][1][3]=1;
  next[2][1][4]=0;
  next[2][2][0]=2;
  next[2][2][1]=-1;
  next[2][2][2]=2;
  next[2][2][3]=2;
  next[2][2][4]=-1;
  next[2][3][0]=1;
  next[2][3][1]=5;
  next[2][3][2]=-1;
  next[2][3][3]=-1;
  next[2][3][4]=5;
  next[2][4][0]=-1;
  next[2][4][1]=-1;
  next[2][4][2]=1;
  next[2][4][3]=1;
  next[2][4][4]=-1;
  
  next[3][0][0]=0;
  next[3][0][1]=3;
  next[3][0][2]=2;
  next[3][0][3]=0;
  next[3][0][4]=-1;
  next[3][1][0]=1;
  next[3][1][1]=-1;
  next[3][1][2]=-1;
  next[3][1][3]=5;
  next[3][1][4]=-1;
  next[3][2][0]=3;
  next[3][2][1]=-1;
  next[3][2][2]=-1;
  next[3][2][3]=3;
  next[3][2][4]=-1;
  next[3][3][0]=0;
  next[3][3][1]=3;
  next[3][3][2]=5;
  next[3][3][3]=-1;
  next[3][3][4]=-1;
  next[3][4][0]=0;
  next[3][4][1]=3;
  next[3][4][2]=5;
  next[3][4][3]=-1;
  next[3][4][4]=-1;
}


void func(void * args)
{
  int i;
  int * a = args;
  int state[n];
  for (i=0;i<n;i++)
  {
    state[i]=*(a+i);
  }
  int nextstate;
  int tid=uthread_self();
  while(state[tid]!=5)
  {
    binary_semaphore_down(&sem1);
    if(tid==0)
    {
      nextstate=next[state[tid]][4][state[tid+1]];
      //binary_semaphore_down(sem3);
    }
    else
    {
      if(tid==(n-1))
      {
	nextstate=next[state[tid]][state[tid-1]][4];
	binary_semaphore_up(&sem2);
      }
      else
      {
	nextstate=next[state[tid]][state[tid-1]][state[tid+1]];
      }
    }
    binary_semaphore_up(&sem1);
    binary_semaphore_down(&sem2);
    state[tid]=nextstate;
    if(tid!=0)
    {
      if(nextstate==5)
	if(state[tid-1]!=5)
	{
	  printf(1,"not all soldiers fire in the same time\n");
	  exit();
	}
    }
    if(tid==(n-1))
      binary_semaphore_up(&sem3);
    else
      binary_semaphore_up(&sem2);
  }
  if(tid==(n-1))
    fire=1;
  uthread_exit();
  
}

int
main(int argc, char *argv[])
{
  
  n=atoi(argv[0]);
  int state[n];
  state[0]=1;
  fire=0;
  initNext();
  int i;
  uthread_init();
  
  binary_semaphore_init(&sem1,1);
  binary_semaphore_init(&sem2,0);
  binary_semaphore_init(&sem3,0);
  
  for(i=0;i<n;i++)
  {
    uthread_create(func,&state);
  }
  while(!fire)
  {
    binary_semaphore_down(&sem3);
    for(i=0;i<n-1;i++)
    {
      printf(1,"%d", state[i]);
    }
    printf(1,"%d\n", state[n-1]);
    binary_semaphore_down(&sem2);
  }
  binary_semaphore_up(&sem3);
  exit();
}