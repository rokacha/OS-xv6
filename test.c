#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
	int a; 
	int b;

	procdump();

	int* variable = (int*)malloc(sizeof(int));
	printf(1,"First test : regular fork\n");
	if((b=fork())!=0)
	{
		printf(1,"parent is working\n");
		procdump();
		sleep(100);
	}
	else // in the fork son
	{
		printf(1,"first child is working\n");
		exit();
	}

	printf(1,"Second test : cowfork\n");

	if((a = cowfork())!=0)
	{
		printf(1,"parent is working\n");
		procdump();
		sleep(100);
		*variable=2;
		procdump();
	}
	else //in the cowfork son
	{
		printf(1,"second child is working\n");
		exit();
	}
	procdump();
	
  	exit();
}
