
/* Possible states of a thread; */
typedef enum  {T_FREE,T_UNINIT, T_RUNNING, T_RUNNABLE, T_SLEEPING} uthread_state;

#define STACK_SIZE  4096
#define MAX_THREAD  64

typedef struct uthread uthread_t, *uthread_p;
struct uthread *currentThread;
struct uthread {
  int	tid;			/* thread's id */
  uint	esp;			/* current stack pointer */
  uint	ebp;			/* current base pointer */
  char	*stack;			/* the thread's stack */
  uthread_state	state;		/* running, runnable, sleeping */
  int firstTime;		/* is the thread running for the first time */
  void (*func)(void*);		/*starting function of the thread*/
  void *arguments;  		/*arguments for the starting function*/
  int waitedOn[MAX_THREAD];	/* threads that are waiting for this thread */
  int waitingFor[MAX_THREAD];	/* threads that this thread is waiting for */

};

struct binary_semaphore
{
  uint locked; 		//is the semaphore locked
  int thread;		//the holding thread
  uint init;		//is the semaphore initialized
};

//uthred.c
int uthread_init(void);
int  uthread_create(void (*start_func)(void *), void* arg);
void uthread_exit(void);
void uthread_yield(void);
int  uthread_self(void);
int  uthread_join(int tid);

//semaphores.c
void binary_semaphore_init(struct binary_semaphore* semaphore, int value);
void binary_semaphore_down(struct binary_semaphore* semaphore);
void binary_semaphore_up(struct binary_semaphore* semaphore);

