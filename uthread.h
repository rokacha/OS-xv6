#define THREAD_QUANTA 5
/********************************
        Macors which inline assembly
 ********************************/
 
// Saves the value of esp to var
#define STORE_ESP(var)  asm("movl %%esp, %0;" : "=r" ( var ))

// Loads the contents of var into esp
#define LOAD_ESP(var)   asm("movl %0, %%esp;" : : "r" ( var ))

// Loads the contents of var into ebp
#define LOAD_EBP(var)   asm("movl %0, %%ebp;" : : "r" ( var ))

// Calls the function func
#define CALL(addr)              asm("call *%0;" : : "r" ( addr ))

// Pushes the contents of var to the stack
#define PUSH(var)               asm("movl %0, %%edi; push %%edi;" : : "r" ( var ))


/* Possible states of a thread; */
typedef enum  {T_FREE,T_UNINIT, T_RUNNING, T_RUNNABLE, T_SLEEPING} uthread_state;

#define STACK_SIZE  4096
#define MAX_THREAD  64

typedef struct uthread uthread_t, *uthread_p;
struct uthread *currentThread;
struct uthread {
  int	tid;		/* thread's id */
  int	esp;		/* current stack pointer */
  int	ebp;		/* current base pointer */
  char	*stack;		/* the thread's stack */
  uthread_state	state;	/* running, runnable, sleeping */

	int firstTime;
  int waiting[MAX_THREAD];
};

struct binary_semaphore
{
  uint locked; 				//is the semaphore locked
  int thread;				//the holding thread
  uint init;
  //synchronizing fields (using Lamport’s bakery algorithm)
  uint choosing[MAX_THREAD];
  int number[MAX_THREAD] ;
  int maximalNum;
};

//uthred.c
void uthread_init(void);
int  uthread_create(void (*start_func)(void *), void* arg);
void uthread_exit(void);
void uthread_yield(void);
int  uthred_self(void);
int  uthred_join(int tid);


int getNextThread(int j);

//semaphores.c
void binary_semaphore_init(struct binary_semaphore* semaphore, int value);
void binary_semaphore_down(struct binary_semaphore* semaphore);
void binary_semaphore_up(struct binary_semaphore* semaphore);

