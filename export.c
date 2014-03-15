// add new path to the default PATH the console will use

#include "types.h"
#include "stat.h"
#include "user.h"
int
determineNumOfPaths(char* string)
{
  int i=0;
  while(*string!=0)
  {
    if(*string==':' && *(string+1)!=0)
      i++;
    string++;
  }
  
  return i+1;
}

int
parsePathsInString(char* string,int numOfPaths,char** paths)
{
  uint i;
  for(i=0 ; i<numOfPaths ; i++)
  {
    paths[i]=string;
    while(*string!=0 && *string!=':'){
      string++;
    }
    if (*string==':')
    {
      *string=0;
      string++;

    }

  }
  return 1;
}

int
main(int argc, char *argv[])
{
  uint i;
  
  if(argc != 2){
    printf(1,"Cant export path, please use: export [PATH]\n");
    exit();
  }
  
  int numOfPaths = determineNumOfPaths(argv[1]);
  char* array[numOfPaths];
  parsePathsInString(argv[1],numOfPaths,array);
  
  for(i=0 ; i<numOfPaths ; i++)
  {
    if(add_path(array[i])<0){
      printf(1,"Failed To add to the path\n");
      return -1;
    }
  }
  exit();
}