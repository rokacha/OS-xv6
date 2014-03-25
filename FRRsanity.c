#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  uint i,pid,j;

  for(i=0 ; i<10 ; i++)
  {
    if((pid=fork())==0){
      for(j=1;j<1001;j++)
        {
          cprintf("child:%d prints for the:%d time%s\n", getpid(), j);
      
        }
        exit();
    }
  }

   int wtime;
   int rtime;
   int iotime;
   while((pid=wait2(&wtime,&rtime,&iotime))!=-1)
   {
      cprintf("child:%d wtime:%d rtime:%d iotime:%d\n", pid, wtime, rtime, iotime);
   }
   

  exit();
}