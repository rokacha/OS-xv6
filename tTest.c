#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

void
printT()
{

  printf(1,"-%d-",uthread_self());
}

int
main(int argc, char *argv[])
{
  
  
  int i;
  uthread_init();
  for (i=0; i<60 ; i++)
  {
    uthread_create(printT,0);  
    
  }
  
  uthread_yield();
//   while(1)
//   {};
  
  exit();
  return 0;
}

// void 
// test(void *t){
//   int i = 0;
//   while (i < 50){
// 	  printf(1,"thread child %p\n", t);
// 	  i++;
// 	  //uthread_yield();
// 	  sleep(60);
//   }
// 
// }
// int 
// main(int argc,char** argv)
// {
//     uthread_init();
//     printf(1,"created 1\n");
//     int tid = uthread_create(test, (void *) 1);
//     if (!tid)
// 	    goto out_err;
//     printf(1,"created 2\n");
//     tid = uthread_create(test, (void *) 2);
//     if (!tid)
// 	    goto out_err;
//     
//     while (1){
//           printf(1,"thread father\n");
//           //uthread_yield();
// 	  sleep(60);
//     }
// 	exit();
// 	out_err:
// 	printf(1,"Faild to create thread, we go bye bye\n");
// 	exit();
// }