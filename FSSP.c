#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"


//void initNext();
//void func(void* tid);
static int next[4][5][5];
static struct binary_semaphore sem1;
static struct binary_semaphore sem2;
///struct binary_semaphore sem3;
static int n;
static int mone=0;
static int* state;
static int print=0;
static int fire=0;
static int in=0;
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


void func(void* tid)
{
  int nextstate,left, right;
 
  int currentstate=state[(int)tid];
  while(currentstate!=5)
  {
    binary_semaphore_down(&sem1);

    if((int)tid==0)
    {
      left=4;
    }
    else
    {
      left=state[(int)tid-1];
    }
    if((int)tid==n-1)
    {
      right=4;
    }
    else
    {
      right=state[(int)tid+1];
    }

    nextstate=next[currentstate][left][right];
    mone++;
    if(mone==n)
      in=1;
    binary_semaphore_up(&sem1);
     // printf (1,"tid: %d  mone: %d\n",(int)tid,mone);
    binary_semaphore_down(&sem2);
    mone--;

    state[(int)tid]=nextstate;
    currentstate=nextstate;
    if(mone==0)
      print=1;
    binary_semaphore_up(&sem2);

  }
 fire++;
   
}

int
main(int argc, char *argv[])
{

  int i;
  if(argc!=2)
  {
    printf (1,"uncorrect use of FSSP, use FSSP <int>\n");
    exit();
  }
  n=atoi(argv[1]);
  state= (int *) malloc(sizeof(int) * n);
  for (i=0;i<n;i++)
  {
    state[i]=0;
  }
  state[0]=1;
  initNext();
  uthread_init();
  binary_semaphore_init(&sem1,0);
  binary_semaphore_init(&sem2,1);
  binary_semaphore_down(&sem2);
    for(i=0;i<n;i++)
       {
        printf(1,"%d",state[i]);
       }
      
  
  for(i=0;i<n;i++)
  {
    uthread_create(func,(void *)i);
  }

  binary_semaphore_up(&sem1);

  while(fire<n)
  {
    if(mone==n && in==1)
    {
      binary_semaphore_down(&sem1);
        printf(1,"\n");
      binary_semaphore_up(&sem2);
      in=0;
    }
    if(print==1)
    {
      binary_semaphore_down(&sem2);
      binary_semaphore_up(&sem1);
       for(i=0;i<n;i++)
       {
        printf(1,"%d",state[i]);
       }
       //printf(1,"\n");
       print=0;
    }
     
  }
//printf (1,"333333\n");
  //uthread_yield();
   free(state);
  uthread_exit();
 
  exit();
}