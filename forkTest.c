#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"


int
main(int argc, char *argv[])
{
  int i;
  if((i=fork())< 0)
    return -1;
  
  if(i==0)
    {
    	for(;;){}
    }

  
  
    	// int wtime;
    	// int rtime;
    	// int iotime;
    	// int pidd=wait2(&wtime,&rtime,&iotime);
    	// printf(1,"wtime:%d rtime:%d iotime:%d\n", wtime,rtime,iotime);
    	// printf(1,"pid==%d\n",pidd );
  


  exit();
}
