struct file {
  enum { FD_NONE, FD_PIPE, FD_INODE ,FD_SLINK} type;
  int ref; // reference count
  char readable;
  char writable;
  struct pipe *pipe;
  struct inode *ip;
  uint off;
};


// in-memory copy of an inode
struct inode {
  uint dev;           		// Device number
  uint inum;          		// Inode number
  int ref;            		// Reference count
  int flags;          		// I_BUSY, I_VALID
  char slink_path[14];		// support for symbolic links
  short type;         		// copy of disk inode
  short major;
  short minor;
  short nlink;
  uint size;
  uint addrs[NDIRECT+2];
  char pass[10];
  char lock;
  uint proclock;
  char align[53]; 
};
#define I_BUSY 0x1
#define I_VALID 0x2

// table mapping major device number to
// device functions
struct devsw {
  int (*read)(struct inode*, char*, int);
  int (*write)(struct inode*, char*, int);
};

extern struct devsw devsw[];

#define CONSOLE 1
