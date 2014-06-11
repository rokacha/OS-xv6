#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
	char buf[32];
	int fd;
	//struct inode *ip=namei(argv[1]);

	fprot(argv[1],argv[2]);
	if(fork()==0)
	{
		funlock(argv[1],argv[2]);

		
		fd=open(argv[1],O_RDONLY);
		read(fd, buf, sizeof(buf));
		printf(1,"%s\n",buf );
		close(fd);
	}
	else
	{
		wait();
		
		if((fd=open(argv[1],O_RDONLY))<0)
			{
				printf(1,"fail to open\n" );
				exit();
			}
			printf(1,"got here\n" );
		funprot(argv[1],argv[2]);
		close(fd);
	}

	
	exit();
}