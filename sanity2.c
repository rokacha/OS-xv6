#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
char buf[32];
int
main(int argc, char *argv[])
{
	int fd;
	//struct inode *ip=namei(argv[1]);
	fprot(argv[1],argv[2]);
	if(fork()==0)
	{
		funprot(argv[1],argv[2]);
		fd=open(argv[1],O_RDONLY);
		read(fd, buf, sizeof(buf));
		printf(1,"%s\n", buf);
		close(fd);
	}
	else
	{
		wait();
		fd=open(argv[1],O_RDONLY);
		if(fd==-1)
			printf(1,"fail to open\n" );
		funprot(argv[1],argv[2]);
	}

	
	exit();
}