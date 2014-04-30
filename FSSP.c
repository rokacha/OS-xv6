#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

#define Q 0
#define Z 1
#define P 2
#define M 3
#define R 4

//void initNext();
//void func(void* tid);
static int next[5][6][6];
static struct binary_semaphore sem1;
static struct binary_semaphore sem2;
///struct binary_semaphore sem3;
static int n;
static int counter=0;
static int* state;
static int print=0;
static int fire=0;
static int change=0;

void
print_state()
{
  int i;
  for(i=0;i<n;i++)
  {
    if(state[i]==0)
    {
      printf(1," ");
    }
    else
    {
      printf(1,"%d",state[i]);   
    }   
    if(state[i]==5)
    {
      fire++;
    }
  }
  printf(1,"\n");
}

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


void func(void * tid)
{
  int currentstate,nextstate,left, right,soldier;

  soldier = (int)tid;

  currentstate=state[soldier];

  while(currentstate!=5)
  {
    binary_semaphore_down(&sem1);
    
    left = (soldier == 0) ? 4 :state[soldier-1] ;

    right = (soldier == n-1) ? 4 :state[soldier+1] ;
    
    nextstate=next[currentstate][left][right];
    
    if(++counter==n)
    {
      change=1;
      print=0;
    }

    binary_semaphore_up(&sem1);
    
    // printf (1,"tid: %d  counter: %d\n",(int)tid,counter);
    binary_semaphore_down(&sem2);
    
    state[soldier]=nextstate;
    currentstate=nextstate;

    if(--counter == 0)
    {
      change=1;
      print=1;
    }

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
    printf (1,"incorrect use of FSSP, use FSSP <int>\n");
    exit();
  }
  n=atoi(argv[1]);

  state= (int *) malloc(sizeof(int) * n);
  
  for (i = 0 ; i < n ; i++)
  {
    state[i]= (i==0) ? 1 : 0;
  }

  initNext();

  uthread_init();
  
  binary_semaphore_init(&sem1,0);
  binary_semaphore_init(&sem2,0);
  
  for(i=0;i<n;i++)
  {
    uthread_create(func,(void *)i);
  }

  print_state();

  binary_semaphore_up(&sem1); //release all thread to check states

  while(fire!=n)
  {
    if(change && !print)
    {
      binary_semaphore_down(&sem1);
      //printf(1,"\n");
      change= 0;
      binary_semaphore_up(&sem2); //release threads to change states
    }
    if(change && print)
    {
      binary_semaphore_down(&sem2);
      change = 0;
      binary_semaphore_up(&sem1);

      fire =0;
      print_state();
      print=0;
    }
     
  }
  free(state);
  uthread_exit();
 
  exit();
}