#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  uint i,j,k=1,cid;
  int wtime[20],pid[20],rtime[20],iotime[20],ttime[20],acid[20];
 

  for(i=0 ; i<20 ; i++)
  {
    if(k!=0)
    {
      k=fork();
      if(k!=0)
        acid[i]=k;  
    }
    if(k==0)
    {
      cid=i;
      break;
    }
  }


if(k==0)
{
  if(cid%2==0)
    {
      int m=0;
      for(i=0;i<10000;i++)
        for(j=0;j<10000;j++)
              m=m+1;
    }
    else
    {
      sleep(1);
      //printf(1,"io call\n");
    }
     for(j=0;j<500;j++)
      {
         printf(1,"cid is:%d time number:%d\n", cid, j);
      }
  }
 else
  {
    int mwtime=0,mrtime=0,mttime=0;
    for(i=0;i<20;i++)
    {
      pid[i]=wait2(&wtime[i],&rtime[i],&iotime[i]);
      mwtime+=wtime[i];
      mrtime+=rtime[i];
      ttime[i]=wtime[i]+iotime[i]+rtime[i];
      mttime+=ttime[i];
    }
    mwtime=mwtime/20;
    mrtime=mrtime/20;
    mttime=mttime/20;
    printf(1,"avg wtime:%davg rtime:%davg turnaround time:%d\n", mwtime, mrtime, mttime);
    int mwtime1=0,mrtime1=0,mttime1=0,mwtime2=0,mrtime2=0,mttime2=0;
    for(i=0;i<20;i++)
    {
      for(j=0;j<20;j++)
      {
        if(pid[j]==acid[i])
        {
          if(i%2==0)
          {
            mwtime2+=wtime[j];
            mrtime2+=rtime[j];
            mttime2+=ttime[j];
          }
          else
          {
            mwtime1+=wtime[j];
            mrtime1+=rtime[j];
            mttime1+=ttime[j];
          }
        }
      }
    }
    mwtime2=mwtime2/10;
    mrtime2=mrtime2/10;
    mttime2=mttime2/10;
    mwtime1=mwtime1/10;
    mrtime1=mrtime1/10;
    mttime1=mttime1/10;
    printf(1,"high priority: wtime:%d rtime:%d turnaround time:%d\n", mwtime1, mrtime1, mttime1);
    printf(1,"low priority: wtime:%d rtime:%d turnaround time:%d\n", mwtime2, mrtime2, mttime2);
    for(i=0;i<20;i++)
    {
      printf(1,"child:%d wtime:%d rtime:%d turnaround time:%d\n", i, wtime[i], rtime[i], ttime[i]);
    }
  }
  exit();
}
