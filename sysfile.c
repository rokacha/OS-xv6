//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "file.h"
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

int
sys_dup(void)
{
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

int
sys_read(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return fileread(f, p, n);
}

int
sys_write(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  return filewrite(f, p, n);
}

int
sys_close(void)
{
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}

int
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;
  if((ip = namei(old)) == 0)
    return -1;

  begin_trans();

  ilock(ip);
  
  if(ip->type == T_DIR){
    iunlockput(ip);
    commit_trans();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  commit_trans();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  commit_trans();
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

//PAGEBREAK!
int
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
    return -1;

  begin_trans();

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  commit_trans();

  return 0;

bad:
  iunlockput(dp);
  commit_trans();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}

int
sys_open(void)
{
  char *path;
  
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  if(omode & O_CREATE){
    begin_trans();
    ip = create(path, T_FILE, 0, 0);
    commit_trans();
    if(ip == 0)
      return -1;
  } 
  else 
  {

    if((omode & O_IGNORE) !=0)
    {
      if((ip = namei_ignore_slink(path)) == 0)
	return -1;
    }
    else
    {
      if((ip = namei(path)) == 0)
	return -1;
    }
    
    ilock(ip);

    if(ip->lock)
    {
      if(getlocked_files(ip->inum,proc->pid)==0)//locked for me
      {
        iunlockput(ip);
        return -1;
      }
    }
  
    if(ip->type == T_DIR && ((omode & O_RDONLY)!=0) ){
      iunlockput(ip);
      return -1;
    }

  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  f->ignore_slink= (omode & O_IGNORE);
  return fd;
}

int
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  begin_trans();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    commit_trans();
    return -1;
  }
  iunlockput(ip);
  commit_trans();
  return 0;
}

int
sys_mknod(void)
{
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
    return -1;
  }
  iunlockput(ip);
  commit_trans();
  return 0;
}

int
sys_chdir(void)
{
  char *path;
  //char newpath[14];
  struct inode *ip;

  if(argstr(0, &path) < 0)
    return -1;
/*  
  if(deref_path(path,newpath,1)>=0)
    path = newpath;
    
  */
  if((ip = namei(path)) == 0)
    return -1;

  ilock(ip);
  if(checklock(ip)<0)
   {
     iunlockput(ip);
     return -1;
   }
  
  if(ip->type != T_DIR){
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  proc->cwd = ip;
  return 0;
}

int
sys_exec(void)
{
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(proc, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(proc, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}


int
sys_symlink(void)
{
  char *old, *new;
  struct inode *ip;
  
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;
  
  begin_trans();
  
  if((ip = create(new,  T_SLINK, 0, 0)) == 0)
    return -1;
  //cprintf("created %s with type of  %d\n",new,ip->type);
  writei(ip, old, 0, strlen(old));
  iunlockput(ip);
  commit_trans();
  
  return 0;
}

int
sys_readlink(void)
{
  char *buf,*pathname;
  int bufsize,i;
  struct inode *ip;

  if(argstr(0, &pathname) < 0 || argstr(1, &buf) || argint(2, &bufsize) < 0)
    return -1;
  char tbuf[bufsize+1];
  for(i=0;i<bufsize+1;i++)
    tbuf[i]='\0';
  if((ip = namei_ignore_slink(pathname)) == 0)
    return -1;
  ilock(ip);
  while(ip->type == T_SLINK)
  {
    i=readi(ip, tbuf, 0, bufsize);
    tbuf[i]=0;
    //cprintf("sys_readlink: tbuf is %s\n",tbuf);
    iunlockput(ip);
    if((ip = namei_ignore_slink(tbuf)) == 0)
      return -1;
    ilock(ip);
  }
  iunlockput(ip);
  memmove(buf,tbuf,bufsize);
 
  return 0;
}

int 
sys_fprot(void)
{
  char *pathname,*password;
  struct inode *ip;

  if(argstr(0, &pathname) < 0 || argstr(1, &password) < 0)
    return -1;
  
  if((ip = namei(pathname)) == 0)
    return -1;
  
  begin_trans();
  
  ilock(ip);
  if(ip->type!=T_FILE)
    goto bad;
  if(ip->flags == I_BUSY || ip->lock)
    goto bad;
  if (strlen(password)>10)
  {
    cprintf("password set is too long\n");
     goto bad;
  }
  strncpy(ip->pass,password,strlen(password));
  
  ip->lock=1;
  iupdate(ip);
  iunlockput(ip);
  commit_trans();
  return 0;
  
  bad:
  iunlockput(ip);
  commit_trans();
  return -1;
}
int 
sys_funprot(void)
{
  char *pathname,*password;
  struct inode *ip;

  if(argstr(0, &pathname) < 0 || argstr(1, &password) < 0)
    return -1;
  if((ip = namei(pathname)) == 0)
    return -1;
  begin_trans();
  ilock(ip);
  
  if(ip->lock)
  {
    if(strncmp(ip->pass,password,strlen(password))!=0)
      goto bad;
    else
        {
          ip->lock=0;
          memset(ip->pass,'\0',strlen(ip->pass));
          iupdate(ip);
          unlockInum(ip->inum);  
        }
      
  }
  iunlockput(ip);
  commit_trans();
  return 0;
  
  
  bad:
  commit_trans();
  iunlockput(ip);
  return -1;
}

int 
sys_funlock(void)
{
  char *pathname,*password;
  struct inode *ip;

  if(argstr(0, &pathname) < 0 || argstr(1, &password) < 0)
    return -1;
  if((ip = namei(pathname)) == 0)
    return -1;
  ilock(ip);
  if(ip->lock)
  {
    if(strncmp(ip->pass,password,strlen(ip->pass))==0)
    {
      setlocked_files(ip->inum,proc->pid,1);
    }
    else
    {
      iunlockput(ip);
      return -1;
    }
  }
  iunlockput(ip);
  return 0;
}
























