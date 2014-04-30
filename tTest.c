#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "uthread.h"

#define NUM_TICKETS 200
#define NUM_SELLERS 20

void SellTickets(void*);

/**
 * The ticket counter and its associated lock will be accessed
 * all threads, so made global for easy access.
 */
static int numTickets = NUM_TICKETS;
static struct binary_semaphore ticketsLock;

static int randomSleeps[] = {2, 3, 5, 7, 11, 13, 17, 19, 23,
         29 , 31 , 37 , 41 , 43 , 47 , 53 , 59 , 61 , 67 , 71,
         73 , 79 , 83 , 89 , 97 , 101 , 103 , 107 , 109 , 113,
         127 , 131 , 137 , 139 , 149 , 151 , 157 , 163 , 167 , 173};

int main(int argc, char **argv)
{
 int i;
 uthread_init();
 printf(1, "Creating threads\n");
 for (i = 0; i < NUM_SELLERS; i++)
    uthread_create(SellTickets, randomSleeps + i);
  
binary_semaphore_init(&ticketsLock, 1);
 printf(1, "Start selling\n");
 uthread_yield(); // Let all threads loose

 //printf(1, "All done!\n");

 uthread_exit();
 exit(); // satisfy gcc
}

static void delay(int i) {
    int j;
    for (j=0; j<i; j++)
        sleep(1);
}

/**
 * SellTickets
 * -----------
 * This is the routine forked by each of the ticket-selling threads.
 * It will loop selling tickets until there are no more tickets left
 * to sell. Before accessing the global numTickets variable,
 * it acquires the ticketsLock to ensure that our threads don't step
 * on one another and oversell on the number of tickets.
 */
void SellTickets(void* arg)
{
 int done = 0;
 int numSoldByThisThread = 0; // local vars are unique to each thread
 int sleepArg = *(int*)arg;

 while (done == 0) {
    delay(sleepArg);
    binary_semaphore_down(&ticketsLock);
    if (numTickets == 0) {
        // here is safe to access numTickets
        done = 1;
    } else {
        numTickets--;
        numSoldByThisThread++;
        printf(1, "%d sold one (%d left)\n", uthread_self(), numTickets);
    }

    binary_semaphore_up(&ticketsLock);
 }
 printf(1, "%d noticed all tickets sold! (I sold %d myself) \n", uthread_self(), numSoldByThisThread);
}
/*  void
  printT()
  {
  int a = uthread_self();

  printf(1,"-%d-",a);
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

  //uthread_yield();
     while(1)
     {};

  exit();
  return 0;
  }

void 
test(void *t){
  int i = 0;
  int* a =t;
  while (i < 10){
	  printf(1,"thread child %d\n",*a);
	  i++;
	  //uthread_yield();
	  sleep(60);
  }

}
int 
main(int argc,char** argv)
{
    uthread_init();
    int a =1;
    int b =2;
    int tid = uthread_create(test, &a);
    printf(1,"created 1\n");
    if (!tid)
	    goto out_err;
    
    tid = uthread_create(test, &b);
    printf(1,"created 2\n");
    if (!tid)
	    goto out_err;
    
    while (1){
          printf(1,"thread father\n");
          //uthread_yield();
	  sleep(60);
    }
	exit();
	out_err:
	printf(1,"Faild to create thread, we go bye bye\n");
	exit();
}*/