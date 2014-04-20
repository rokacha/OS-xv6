#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

void
print_handler()
{
  printf(1,"printing from user space\n");
}
  

int
main(int argc, char *argv[])
{
  int i;
  //int a;

  if(argc < 2 || argc > 3){
    printf(1,"cant use sigsend_test that way.. use:\nsigsend_test [SIGNAL]\n");
    exit();
  }

  if((i=fork()) <0)
  {
    printf(1,"failed forking for some reason\n");
    exit();
  }
   if(i!=0){
//   {
//     sleep(50);
//     a=sigsend(i,atoi(argv[1]));
//     if(a<0)
//     {
//           
//       printf(1,"sigsend return -1\n");
//       exit();
//     }
    wait();
    
  }
  else
  {

    signal(14,(sighandler_t)print_handler); //14 is the number of SYGALARM
    printf(1,"an alarm system call was executed with %d parameter\n",atoi(argv[1]));
    alarm(atoi(argv[1]));

    while(1){
    }
  } 
  exit();
}