#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main()
{
	char buf[512];
	int fd;
	uint size=0,filesize=1<<20;
	fd=open("sanity.file",O_CREATE | O_WRONLY);
	if(fd < 0)
	{
		printf(1, "sanity: cannot open big.file for writing\n");
		exit();
	}
	while(size<filesize)
	{
		int rez=write(fd, buf, sizeof(buf));
		if(rez<=0)
		{
			printf(1,"failed to write more than: %d bytes\n",size);
			break;
		}
		size += sizeof(buf);
		if (size==12*sizeof(buf))
		{
			printf(1,"finish writing 6KB direct\n");
		}
		if (size==(12+(1<<7))*sizeof(buf))
		{
			printf(1,"finish writing 70KB single indirect\n");
		}
		
	}
	
	printf(1,"finish writing 1MB singel indirect\n");
	close(fd);
	exit();
}