#define THREAD_QUANTA 5

/* Possible states of a thread; */
typedef enum  {T_FREE,T_UNINIT, T_RUNNING, T_RUNNABLE, T_SLEEPING} uthread_state;

#define STACK_SIZE  4096
#define MAX_THREAD  64

typedef struct uthread uthread_t, *uthread_p;

struct uthread {
  int	tid;		/* thread's id */
  int	esp;		/* current stack pointer */
  int	ebp;		/* current base pointer */
  char	*stack;		/* the thread's stack */
  uthread_state	state;	/* running, runnable, sleeping */
};

struct binary_semaphore;

//uthred.c
void uthread_init(void);
int  uthread_create(void (*start_func)(void *), void* arg);
void uthread_exit(void);
void uthread_yield(void);
int  uthred_self(void);
int  uthred_join(int tid);

//semaphores.c
void binary_semaphore_init(struct binary_semaphore* semaphore, int value);
void binary_semaphore_down(struct binary_semaphore* semaphore);
void binary_semaphore_up(struct binary_semaphore* semaphore);