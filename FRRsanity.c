#include "types.h"
#include "stat.h"
#include "user.h"


int
main(int argc, char *argv[])
{
  uint i,j,k=1;
  int wtime[10],pid[10],rtime[10],iotime[10],ttime[10];
  for(i=0 ; i<10 ; i++)
  {
    if(k!=0)
    {
      k=fork();
    
    }
    if(k==0)
    {
      break;
    }
  }
if(k==0)
{
  for(j=1;j<1001;j++)
    {
      printf(1,"child:%d prints for the:%d time\n", getpid(), j);
     // printf(1,"time\n");
    }
}
else
{
  for(i=0;i<10;i++)
  {
    pid[i]=wait2(&wtime[i],&rtime[i],&iotime[i]);
    ttime[i]=wtime[i]+iotime[i]+rtime[i];
  }
  for(i=0;i<10;i++)
  {
    printf(1,"child:%d wtime:%d rtime:%d turnaround time:%d\n", pid[i], wtime[i], rtime[i], ttime[i]);
  }

}
  exit();
}