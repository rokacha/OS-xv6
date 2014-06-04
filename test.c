#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
	int a; 
	int b;
	//int* p=0;

	int* variable = (int*)malloc(sizeof(int));
	printf(1,"First test : regular fork\n");
	procdump();
	if((b=fork())!=0)
	{
		//printf(1,"parent is working\n");
		procdump();
		sleep(100);
		//printf(1,"Second test : cowfork\n");
		if((a = cowfork())!=0)
		{
			//printf(1,"parent is working\n");
			procdump();
			sleep(100);
			*variable=2;
			//*p =1;
			procdump();
			wait();
			wait();
		}
		else //in the cowfork son
		{
		//	printf(1,"cowfork child is working\n");
		}
	}
	else // in the fork son
	{
		//printf(1,"fork child is working\n");
	}


	
	
  	exit();
}
