#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"


int
main(int argc, char *argv[])
{
  int i=fork();
  int j=0;
  int x=1;
  if(i==0)
    {
    	for(j=1;j<10000000;j++)
    	{
    		x=x*j;
    	}	
    }
  else
  {
  	int wtime;
  	int rtime;
  	int iotime;
  	int pidd=wait2(&wtime,&rtime,&iotime);
  	printf(1,"wtime:%d rtime:%d iotime:%d\n", wtime,rtime,iotime);
  	printf(1,"%d\n",pidd );
  }


  exit();
}
