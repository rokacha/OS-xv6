
#define NPROC        			64 // maximum number of processes
#define KSTACKSIZE 				4096 // size of per-process kernel stack
#define NCPU          			8  // maximum number of CPUs
#define NOFILE       			16 // open files per process
#define NFILE       			100// open files per system
#define NBUF         			10 // size of disk block cache
#define NINODE       			50 // maximum number of active i-nodes
#define NDEV         			10 // maximum major device number
#define ROOTDEV       			1  // device number of file system root disk
#define MAXARG       			32 // max exec arguments
#define LOGSIZE      			10 // max data sectors in on-disk log
#define MAX_PATH_ENTRIES 		10 //max entries of paths to be allowed 
#define INPUT_BUF 				128// max input size
#define QUANTA					5// the number of ticks in one run
#define NUMBER_OF_QUEUES    	3//the number of queues
#define NORMAL_PRIORITY_QUEUE	1//the middle queue's number
#define DEFAULT       			1// default scheduling policy
#define FRR						2//FIFO round robin scheduling policy
#define FCFS					3//FIFO round robin infinte time QUANTA
#define THREEQ					4//three priority queues scheduling policy
