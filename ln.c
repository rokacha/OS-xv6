#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  char buf[14];
  if(argc < 3 || argc > 4 || (argc == 4 && (strcmp(argv[1],"-s") !=0)))
  {
    printf(2, "Usage: ln [OPT] old new\n");
    exit();
  }
  if(argc==3)
  {
    if(link(argv[1], argv[2]) < 0)
    {
      printf(2, "link %s %s: failed\n", argv[1], argv[2]);
    }
  }
  else
  {
    if(symlink(argv[2],argv[3]) < 0)
    {
      printf(2, "link -s %s %s: failed\n", argv[2], argv[3]);
    }
    
  }
  readlink(argv[3],buf,14);
  printf(1,"the new link points to %s\n",buf);
  exit();
  
}
