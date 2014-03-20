#include "types.h"
#include "stat.h"
#include "user.h"


int
main(int argc, char *argv[]){
	int i,pid;
	for(i=0;i<10;i++)
	{
		pid=fork();
		if(pid==0)
		{
			for(j=0;j<1000;j++)
			{
				 cprintf("child:%d prints for the:%d\n", getpid(), j);
			}
			exit();
		}
	}
	int wtime;
    int rtime;
    int iotime;
    int pidd;
     while((pidd=wait2(&wtime,&rtime,&iotime)>=0)
     {
     	cprintf("child:%d wtime:%d rtime:%d iotime:%d\n",pidd, wtime,rtime,iotime);
     	
     }
     
exit();
}