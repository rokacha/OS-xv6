#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
  char* c ;
  
  for (c=(char*)main;c<(char*)(main+100);c++){
    printf(1,"%d",(int)*c);
  }

  c=(char*)main;
  *c=10;
  exit();
}
