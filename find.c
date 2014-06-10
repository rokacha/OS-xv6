#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

uint follow=0,checkname=0,checksize=0,checktype=0,type=T_FILE,help=0;
int size,sizedirection=0;
char path[14]={'\0'};


void
help_function()
{
  printf(1,"Usage: find <path> <options> <predicates>\n");
  printf(1,"\n<path>\n  specifies the location where the search should begin and descend from.\n");
  printf(1,"  In case the provided path is a file and not a directory, then only the specified\n");
  printf(1,"  file will be tested for the specified criteria. The rest of the arguments are\n");
  printf(1,"   optional.\n\n<Options>:\n  -follow\n");
  printf(1,"    Dereference symbolic links. If a symbolic link is encountered,\n    apply tests to the");
  printf(1,"target of the link. If a symbolic link points\n    to a directory, then descend into it.\n");
  printf(1,"  -help\n    Print a summary of the command-line usage of find and exit.\n\n<Predicates>:\n");
  printf(1,"  -name filename\n    All files named (exactly, no wildcards) filename.\n  -size (+/-)n\n");
  printf(1,"    File is of size n (exactly), +n (more than n), -n (less than n).\n");
  printf(1,"  -type c\n    File is of type c:\n      d directory\n      f regular file\n      s soft (symbolic) link\n");
  exit();
}

int
check(struct dirent de,struct stat st)
{
  int pass_name=1,pass_type=1,pass_size=1;
  
  if(checkname)
  {
    pass_name = !strcmp(path,de.name);
  }
  if(checktype)
  {
    pass_type = (st.type==type);
  }
  if(checksize)
  {
    
  }
  
  return pass_name && pass_type && pass_size;
}
void
f_find(char* start_path)
{
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  
  switch(st.type){
  case T_FILE:
    //printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      //printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
  exit();
}

int
main(int argc, char *argv[])
{
  int i;
  if(argc < 2){
    goto bad_use;
  }
  if(argc==2 && strcmp(argv[1],"-help")!=0)
  {
    checkname=1;
    strcpy(path,argv[1]);
    f_find("/");
  }

  if(strcmp(argv[1],"-help")==0)
    help_function();
  
  for(i=2; i<argc; i++ )
  {
    if(strcmp(argv[i],"-help")==0)
      help_function();
    else
    if(strcmp(argv[i],"-follow")==0)
      follow=1;
    else
    if(strcmp(argv[i],"-name")==0)
    {
      if(i<argc-1)
      {
	checkname=1;
	strcpy(path,argv[i+1]);
	i++;
      }
      else
      {
	printf(1,"Error : No filename defined\n");
	goto bad_use;
      }
    }
    else
    if(strcmp(argv[i],"-size")==0)
    {
      if(i<argc-1)
      {
	checksize=1;
	i++;
	switch(argv[i][0])
	{
	  case '+':
	    sizedirection=1;
	    size=atoi(&argv[i][1]);
	  break;
	  
	  case '-':
	    sizedirection=-1;
	    size=atoi(&argv[i][1]);
	  break;
	  
	  default:
	    size=atoi(argv[i]);
	  break;
	}
      }
      else
      {
	printf(1,"Error : No size defined\n");
	goto bad_use;
      }
    }
    else
    if(strcmp(argv[i],"-type")==0)
    {
      if((i<argc-1) && (strlen(argv[i])==1))
      {
	checktype=1;
	i++;
	switch(argv[i][0])
	{
	  case 'd':
	    type=T_DIR;
	  break;
	  
	  case 'f':
	    type=T_FILE;
	  break;
	  
	  case 's':
	    type=T_SLINK;
	  break;
	  
	  default:
	    goto err_made;	    
	}
      }
      else
      {
	err_made:
	printf(1,"Error : Incorrect Use of types , use -help\n");
	goto bad_use;
      }
    }
    else
      goto bad_use;    
  }
  f_find(argv[1]);

  exit();
  
  bad_use:   
  printf(1,"Usage: find <path> <options> <preds>");
  exit();
}
