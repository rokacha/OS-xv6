
_export:     file format elf32-i386


Disassembly of section .text:

00000000 <determineNumOfPaths>:
#include "types.h"
#include "stat.h"
#include "user.h"
int
determineNumOfPaths(char* string)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
  int i=0;
   6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while(*string!=0)
   d:	eb 1f                	jmp    2e <determineNumOfPaths+0x2e>
  {
    if(*string==':' && *(string+1)!=0)
   f:	8b 45 08             	mov    0x8(%ebp),%eax
  12:	0f b6 00             	movzbl (%eax),%eax
  15:	3c 3a                	cmp    $0x3a,%al
  17:	75 11                	jne    2a <determineNumOfPaths+0x2a>
  19:	8b 45 08             	mov    0x8(%ebp),%eax
  1c:	83 c0 01             	add    $0x1,%eax
  1f:	0f b6 00             	movzbl (%eax),%eax
  22:	84 c0                	test   %al,%al
  24:	74 04                	je     2a <determineNumOfPaths+0x2a>
      i++;
  26:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    string++;
  2a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
#include "user.h"
int
determineNumOfPaths(char* string)
{
  int i=0;
  while(*string!=0)
  2e:	8b 45 08             	mov    0x8(%ebp),%eax
  31:	0f b6 00             	movzbl (%eax),%eax
  34:	84 c0                	test   %al,%al
  36:	75 d7                	jne    f <determineNumOfPaths+0xf>
    if(*string==':' && *(string+1)!=0)
      i++;
    string++;
  }
  
  return i+1;
  38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  3b:	83 c0 01             	add    $0x1,%eax
}
  3e:	c9                   	leave  
  3f:	c3                   	ret    

00000040 <parsePathsInString>:

int
parsePathsInString(char* string,int numOfPaths,char** paths)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 10             	sub    $0x10,%esp
  uint i;
  for(i=0 ; i<numOfPaths ; i++)
  46:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  4d:	eb 40                	jmp    8f <parsePathsInString+0x4f>
  {
    paths[i]=string;
  4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  52:	c1 e0 02             	shl    $0x2,%eax
  55:	03 45 10             	add    0x10(%ebp),%eax
  58:	8b 55 08             	mov    0x8(%ebp),%edx
  5b:	89 10                	mov    %edx,(%eax)
    while(*string!=0 && *string!=':'){
  5d:	eb 04                	jmp    63 <parsePathsInString+0x23>
      string++;
  5f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
{
  uint i;
  for(i=0 ; i<numOfPaths ; i++)
  {
    paths[i]=string;
    while(*string!=0 && *string!=':'){
  63:	8b 45 08             	mov    0x8(%ebp),%eax
  66:	0f b6 00             	movzbl (%eax),%eax
  69:	84 c0                	test   %al,%al
  6b:	74 0a                	je     77 <parsePathsInString+0x37>
  6d:	8b 45 08             	mov    0x8(%ebp),%eax
  70:	0f b6 00             	movzbl (%eax),%eax
  73:	3c 3a                	cmp    $0x3a,%al
  75:	75 e8                	jne    5f <parsePathsInString+0x1f>
      string++;
    }
    if (*string==':')
  77:	8b 45 08             	mov    0x8(%ebp),%eax
  7a:	0f b6 00             	movzbl (%eax),%eax
  7d:	3c 3a                	cmp    $0x3a,%al
  7f:	75 0a                	jne    8b <parsePathsInString+0x4b>
    {
      *string=0;
  81:	8b 45 08             	mov    0x8(%ebp),%eax
  84:	c6 00 00             	movb   $0x0,(%eax)
      string++;
  87:	83 45 08 01          	addl   $0x1,0x8(%ebp)

int
parsePathsInString(char* string,int numOfPaths,char** paths)
{
  uint i;
  for(i=0 ; i<numOfPaths ; i++)
  8b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  92:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  95:	77 b8                	ja     4f <parsePathsInString+0xf>
      string++;

    }

  }
  return 1;
  97:	b8 01 00 00 00       	mov    $0x1,%eax
}
  9c:	c9                   	leave  
  9d:	c3                   	ret    

0000009e <main>:

int
main(int argc, char *argv[])
{
  9e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  a2:	83 e4 f0             	and    $0xfffffff0,%esp
  a5:	ff 71 fc             	pushl  -0x4(%ecx)
  a8:	55                   	push   %ebp
  a9:	89 e5                	mov    %esp,%ebp
  ab:	56                   	push   %esi
  ac:	53                   	push   %ebx
  ad:	51                   	push   %ecx
  ae:	83 ec 3c             	sub    $0x3c,%esp
  b1:	89 cb                	mov    %ecx,%ebx
  b3:	89 e0                	mov    %esp,%eax
  b5:	89 c6                	mov    %eax,%esi
  uint i;
  
  if(argc != 2){
  b7:	83 3b 02             	cmpl   $0x2,(%ebx)
  ba:	74 19                	je     d5 <main+0x37>
    printf(1,"Cant export path, please use: export [PATH]\n");
  bc:	c7 44 24 04 58 09 00 	movl   $0x958,0x4(%esp)
  c3:	00 
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	e8 c3 04 00 00       	call   593 <printf>
    exit();
  d0:	e8 27 03 00 00       	call   3fc <exit>
  }
  
  int numOfPaths = determineNumOfPaths(argv[1]);
  d5:	8b 43 04             	mov    0x4(%ebx),%eax
  d8:	83 c0 04             	add    $0x4,%eax
  db:	8b 00                	mov    (%eax),%eax
  dd:	89 04 24             	mov    %eax,(%esp)
  e0:	e8 1b ff ff ff       	call   0 <determineNumOfPaths>
  e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  char* array[numOfPaths];
  e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  ee:	89 55 dc             	mov    %edx,-0x24(%ebp)
  f1:	c1 e0 02             	shl    $0x2,%eax
  f4:	8d 50 0f             	lea    0xf(%eax),%edx
  f7:	b8 10 00 00 00       	mov    $0x10,%eax
  fc:	83 e8 01             	sub    $0x1,%eax
  ff:	01 d0                	add    %edx,%eax
 101:	c7 45 d4 10 00 00 00 	movl   $0x10,-0x2c(%ebp)
 108:	ba 00 00 00 00       	mov    $0x0,%edx
 10d:	f7 75 d4             	divl   -0x2c(%ebp)
 110:	6b c0 10             	imul   $0x10,%eax,%eax
 113:	29 c4                	sub    %eax,%esp
 115:	8d 44 24 0c          	lea    0xc(%esp),%eax
 119:	83 c0 0f             	add    $0xf,%eax
 11c:	c1 e8 04             	shr    $0x4,%eax
 11f:	c1 e0 04             	shl    $0x4,%eax
 122:	89 45 d8             	mov    %eax,-0x28(%ebp)
  parsePathsInString(argv[1],numOfPaths,array);
 125:	8b 55 d8             	mov    -0x28(%ebp),%edx
 128:	8b 43 04             	mov    0x4(%ebx),%eax
 12b:	83 c0 04             	add    $0x4,%eax
 12e:	8b 00                	mov    (%eax),%eax
 130:	89 54 24 08          	mov    %edx,0x8(%esp)
 134:	8b 55 e0             	mov    -0x20(%ebp),%edx
 137:	89 54 24 04          	mov    %edx,0x4(%esp)
 13b:	89 04 24             	mov    %eax,(%esp)
 13e:	e8 fd fe ff ff       	call   40 <parsePathsInString>
  
  for(i=0 ; i<numOfPaths ; i++)
 143:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 14a:	eb 3f                	jmp    18b <main+0xed>
  {
    if(add_path(array[i])<0){
 14c:	8b 45 d8             	mov    -0x28(%ebp),%eax
 14f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 152:	8b 04 90             	mov    (%eax,%edx,4),%eax
 155:	89 04 24             	mov    %eax,(%esp)
 158:	e8 3f 03 00 00       	call   49c <add_path>
 15d:	85 c0                	test   %eax,%eax
 15f:	79 26                	jns    187 <main+0xe9>
      printf(1,"Failed To add to the path\n");
 161:	c7 44 24 04 85 09 00 	movl   $0x985,0x4(%esp)
 168:	00 
 169:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 170:	e8 1e 04 00 00       	call   593 <printf>
      return -1;
 175:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 17a:	89 f4                	mov    %esi,%esp
    }
  }
  exit();
 17c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17f:	59                   	pop    %ecx
 180:	5b                   	pop    %ebx
 181:	5e                   	pop    %esi
 182:	5d                   	pop    %ebp
 183:	8d 61 fc             	lea    -0x4(%ecx),%esp
 186:	c3                   	ret    
  
  int numOfPaths = determineNumOfPaths(argv[1]);
  char* array[numOfPaths];
  parsePathsInString(argv[1],numOfPaths,array);
  
  for(i=0 ; i<numOfPaths ; i++)
 187:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 18b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 18e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
 191:	77 b9                	ja     14c <main+0xae>
    if(add_path(array[i])<0){
      printf(1,"Failed To add to the path\n");
      return -1;
    }
  }
  exit();
 193:	e8 64 02 00 00       	call   3fc <exit>

00000198 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	57                   	push   %edi
 19c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 19d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a0:	8b 55 10             	mov    0x10(%ebp),%edx
 1a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a6:	89 cb                	mov    %ecx,%ebx
 1a8:	89 df                	mov    %ebx,%edi
 1aa:	89 d1                	mov    %edx,%ecx
 1ac:	fc                   	cld    
 1ad:	f3 aa                	rep stos %al,%es:(%edi)
 1af:	89 ca                	mov    %ecx,%edx
 1b1:	89 fb                	mov    %edi,%ebx
 1b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1b9:	5b                   	pop    %ebx
 1ba:	5f                   	pop    %edi
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    

000001bd <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1c9:	90                   	nop
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	0f b6 10             	movzbl (%eax),%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	88 10                	mov    %dl,(%eax)
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	0f b6 00             	movzbl (%eax),%eax
 1db:	84 c0                	test   %al,%al
 1dd:	0f 95 c0             	setne  %al
 1e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1e4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 1e8:	84 c0                	test   %al,%al
 1ea:	75 de                	jne    1ca <strcpy+0xd>
    ;
  return os;
 1ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1ef:	c9                   	leave  
 1f0:	c3                   	ret    

000001f1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f1:	55                   	push   %ebp
 1f2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1f4:	eb 08                	jmp    1fe <strcmp+0xd>
    p++, q++;
 1f6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1fa:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1fe:	8b 45 08             	mov    0x8(%ebp),%eax
 201:	0f b6 00             	movzbl (%eax),%eax
 204:	84 c0                	test   %al,%al
 206:	74 10                	je     218 <strcmp+0x27>
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	0f b6 10             	movzbl (%eax),%edx
 20e:	8b 45 0c             	mov    0xc(%ebp),%eax
 211:	0f b6 00             	movzbl (%eax),%eax
 214:	38 c2                	cmp    %al,%dl
 216:	74 de                	je     1f6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	0f b6 00             	movzbl (%eax),%eax
 21e:	0f b6 d0             	movzbl %al,%edx
 221:	8b 45 0c             	mov    0xc(%ebp),%eax
 224:	0f b6 00             	movzbl (%eax),%eax
 227:	0f b6 c0             	movzbl %al,%eax
 22a:	89 d1                	mov    %edx,%ecx
 22c:	29 c1                	sub    %eax,%ecx
 22e:	89 c8                	mov    %ecx,%eax
}
 230:	5d                   	pop    %ebp
 231:	c3                   	ret    

00000232 <strlen>:

uint
strlen(char *s)
{
 232:	55                   	push   %ebp
 233:	89 e5                	mov    %esp,%ebp
 235:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 238:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 23f:	eb 04                	jmp    245 <strlen+0x13>
 241:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 245:	8b 45 fc             	mov    -0x4(%ebp),%eax
 248:	03 45 08             	add    0x8(%ebp),%eax
 24b:	0f b6 00             	movzbl (%eax),%eax
 24e:	84 c0                	test   %al,%al
 250:	75 ef                	jne    241 <strlen+0xf>
    ;
  return n;
 252:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 255:	c9                   	leave  
 256:	c3                   	ret    

00000257 <memset>:

void*
memset(void *dst, int c, uint n)
{
 257:	55                   	push   %ebp
 258:	89 e5                	mov    %esp,%ebp
 25a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 25d:	8b 45 10             	mov    0x10(%ebp),%eax
 260:	89 44 24 08          	mov    %eax,0x8(%esp)
 264:	8b 45 0c             	mov    0xc(%ebp),%eax
 267:	89 44 24 04          	mov    %eax,0x4(%esp)
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	89 04 24             	mov    %eax,(%esp)
 271:	e8 22 ff ff ff       	call   198 <stosb>
  return dst;
 276:	8b 45 08             	mov    0x8(%ebp),%eax
}
 279:	c9                   	leave  
 27a:	c3                   	ret    

0000027b <strchr>:

char*
strchr(const char *s, char c)
{
 27b:	55                   	push   %ebp
 27c:	89 e5                	mov    %esp,%ebp
 27e:	83 ec 04             	sub    $0x4,%esp
 281:	8b 45 0c             	mov    0xc(%ebp),%eax
 284:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 287:	eb 14                	jmp    29d <strchr+0x22>
    if(*s == c)
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 292:	75 05                	jne    299 <strchr+0x1e>
      return (char*)s;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	eb 13                	jmp    2ac <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 299:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
 2a0:	0f b6 00             	movzbl (%eax),%eax
 2a3:	84 c0                	test   %al,%al
 2a5:	75 e2                	jne    289 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ac:	c9                   	leave  
 2ad:	c3                   	ret    

000002ae <gets>:

char*
gets(char *buf, int max)
{
 2ae:	55                   	push   %ebp
 2af:	89 e5                	mov    %esp,%ebp
 2b1:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2bb:	eb 44                	jmp    301 <gets+0x53>
    cc = read(0, &c, 1);
 2bd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2c4:	00 
 2c5:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2d3:	e8 3c 01 00 00       	call   414 <read>
 2d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2df:	7e 2d                	jle    30e <gets+0x60>
      break;
    buf[i++] = c;
 2e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2e4:	03 45 08             	add    0x8(%ebp),%eax
 2e7:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 2eb:	88 10                	mov    %dl,(%eax)
 2ed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 2f1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f5:	3c 0a                	cmp    $0xa,%al
 2f7:	74 16                	je     30f <gets+0x61>
 2f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2fd:	3c 0d                	cmp    $0xd,%al
 2ff:	74 0e                	je     30f <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 301:	8b 45 f4             	mov    -0xc(%ebp),%eax
 304:	83 c0 01             	add    $0x1,%eax
 307:	3b 45 0c             	cmp    0xc(%ebp),%eax
 30a:	7c b1                	jl     2bd <gets+0xf>
 30c:	eb 01                	jmp    30f <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 30e:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 30f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 312:	03 45 08             	add    0x8(%ebp),%eax
 315:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 318:	8b 45 08             	mov    0x8(%ebp),%eax
}
 31b:	c9                   	leave  
 31c:	c3                   	ret    

0000031d <stat>:

int
stat(char *n, struct stat *st)
{
 31d:	55                   	push   %ebp
 31e:	89 e5                	mov    %esp,%ebp
 320:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 323:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 32a:	00 
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	89 04 24             	mov    %eax,(%esp)
 331:	e8 06 01 00 00       	call   43c <open>
 336:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 339:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 33d:	79 07                	jns    346 <stat+0x29>
    return -1;
 33f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 344:	eb 23                	jmp    369 <stat+0x4c>
  r = fstat(fd, st);
 346:	8b 45 0c             	mov    0xc(%ebp),%eax
 349:	89 44 24 04          	mov    %eax,0x4(%esp)
 34d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 350:	89 04 24             	mov    %eax,(%esp)
 353:	e8 fc 00 00 00       	call   454 <fstat>
 358:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 35b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 35e:	89 04 24             	mov    %eax,(%esp)
 361:	e8 be 00 00 00       	call   424 <close>
  return r;
 366:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 369:	c9                   	leave  
 36a:	c3                   	ret    

0000036b <atoi>:

int
atoi(const char *s)
{
 36b:	55                   	push   %ebp
 36c:	89 e5                	mov    %esp,%ebp
 36e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 371:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 378:	eb 23                	jmp    39d <atoi+0x32>
    n = n*10 + *s++ - '0';
 37a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 37d:	89 d0                	mov    %edx,%eax
 37f:	c1 e0 02             	shl    $0x2,%eax
 382:	01 d0                	add    %edx,%eax
 384:	01 c0                	add    %eax,%eax
 386:	89 c2                	mov    %eax,%edx
 388:	8b 45 08             	mov    0x8(%ebp),%eax
 38b:	0f b6 00             	movzbl (%eax),%eax
 38e:	0f be c0             	movsbl %al,%eax
 391:	01 d0                	add    %edx,%eax
 393:	83 e8 30             	sub    $0x30,%eax
 396:	89 45 fc             	mov    %eax,-0x4(%ebp)
 399:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 39d:	8b 45 08             	mov    0x8(%ebp),%eax
 3a0:	0f b6 00             	movzbl (%eax),%eax
 3a3:	3c 2f                	cmp    $0x2f,%al
 3a5:	7e 0a                	jle    3b1 <atoi+0x46>
 3a7:	8b 45 08             	mov    0x8(%ebp),%eax
 3aa:	0f b6 00             	movzbl (%eax),%eax
 3ad:	3c 39                	cmp    $0x39,%al
 3af:	7e c9                	jle    37a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3b4:	c9                   	leave  
 3b5:	c3                   	ret    

000003b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b6:	55                   	push   %ebp
 3b7:	89 e5                	mov    %esp,%ebp
 3b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3c8:	eb 13                	jmp    3dd <memmove+0x27>
    *dst++ = *src++;
 3ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3cd:	0f b6 10             	movzbl (%eax),%edx
 3d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3d3:	88 10                	mov    %dl,(%eax)
 3d5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3d9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 3e1:	0f 9f c0             	setg   %al
 3e4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 3e8:	84 c0                	test   %al,%al
 3ea:	75 de                	jne    3ca <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ef:	c9                   	leave  
 3f0:	c3                   	ret    
 3f1:	90                   	nop
 3f2:	90                   	nop
 3f3:	90                   	nop

000003f4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3f4:	b8 01 00 00 00       	mov    $0x1,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <exit>:
SYSCALL(exit)
 3fc:	b8 02 00 00 00       	mov    $0x2,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <wait>:
SYSCALL(wait)
 404:	b8 03 00 00 00       	mov    $0x3,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <pipe>:
SYSCALL(pipe)
 40c:	b8 04 00 00 00       	mov    $0x4,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <read>:
SYSCALL(read)
 414:	b8 05 00 00 00       	mov    $0x5,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <write>:
SYSCALL(write)
 41c:	b8 10 00 00 00       	mov    $0x10,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <close>:
SYSCALL(close)
 424:	b8 15 00 00 00       	mov    $0x15,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <kill>:
SYSCALL(kill)
 42c:	b8 06 00 00 00       	mov    $0x6,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <exec>:
SYSCALL(exec)
 434:	b8 07 00 00 00       	mov    $0x7,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <open>:
SYSCALL(open)
 43c:	b8 0f 00 00 00       	mov    $0xf,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <mknod>:
SYSCALL(mknod)
 444:	b8 11 00 00 00       	mov    $0x11,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <unlink>:
SYSCALL(unlink)
 44c:	b8 12 00 00 00       	mov    $0x12,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <fstat>:
SYSCALL(fstat)
 454:	b8 08 00 00 00       	mov    $0x8,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <link>:
SYSCALL(link)
 45c:	b8 13 00 00 00       	mov    $0x13,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <mkdir>:
SYSCALL(mkdir)
 464:	b8 14 00 00 00       	mov    $0x14,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <chdir>:
SYSCALL(chdir)
 46c:	b8 09 00 00 00       	mov    $0x9,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <dup>:
SYSCALL(dup)
 474:	b8 0a 00 00 00       	mov    $0xa,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <getpid>:
SYSCALL(getpid)
 47c:	b8 0b 00 00 00       	mov    $0xb,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <sbrk>:
SYSCALL(sbrk)
 484:	b8 0c 00 00 00       	mov    $0xc,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <sleep>:
SYSCALL(sleep)
 48c:	b8 0d 00 00 00       	mov    $0xd,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <uptime>:
SYSCALL(uptime)
 494:	b8 0e 00 00 00       	mov    $0xe,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <add_path>:
SYSCALL(add_path)
 49c:	b8 16 00 00 00       	mov    $0x16,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <wait2>:
SYSCALL(wait2)
 4a4:	b8 17 00 00 00       	mov    $0x17,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <getquanta>:
SYSCALL(getquanta)
 4ac:	b8 18 00 00 00       	mov    $0x18,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <getqueue>:
SYSCALL(getqueue)
 4b4:	b8 19 00 00 00       	mov    $0x19,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4bc:	55                   	push   %ebp
 4bd:	89 e5                	mov    %esp,%ebp
 4bf:	83 ec 28             	sub    $0x28,%esp
 4c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4cf:	00 
 4d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d7:	8b 45 08             	mov    0x8(%ebp),%eax
 4da:	89 04 24             	mov    %eax,(%esp)
 4dd:	e8 3a ff ff ff       	call   41c <write>
}
 4e2:	c9                   	leave  
 4e3:	c3                   	ret    

000004e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4f1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4f5:	74 17                	je     50e <printint+0x2a>
 4f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4fb:	79 11                	jns    50e <printint+0x2a>
    neg = 1;
 4fd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 504:	8b 45 0c             	mov    0xc(%ebp),%eax
 507:	f7 d8                	neg    %eax
 509:	89 45 ec             	mov    %eax,-0x14(%ebp)
 50c:	eb 06                	jmp    514 <printint+0x30>
  } else {
    x = xx;
 50e:	8b 45 0c             	mov    0xc(%ebp),%eax
 511:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 514:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 51b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 51e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 521:	ba 00 00 00 00       	mov    $0x0,%edx
 526:	f7 f1                	div    %ecx
 528:	89 d0                	mov    %edx,%eax
 52a:	0f b6 90 48 0c 00 00 	movzbl 0xc48(%eax),%edx
 531:	8d 45 dc             	lea    -0x24(%ebp),%eax
 534:	03 45 f4             	add    -0xc(%ebp),%eax
 537:	88 10                	mov    %dl,(%eax)
 539:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 53d:	8b 55 10             	mov    0x10(%ebp),%edx
 540:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 543:	8b 45 ec             	mov    -0x14(%ebp),%eax
 546:	ba 00 00 00 00       	mov    $0x0,%edx
 54b:	f7 75 d4             	divl   -0x2c(%ebp)
 54e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 551:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 555:	75 c4                	jne    51b <printint+0x37>
  if(neg)
 557:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 55b:	74 2a                	je     587 <printint+0xa3>
    buf[i++] = '-';
 55d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 560:	03 45 f4             	add    -0xc(%ebp),%eax
 563:	c6 00 2d             	movb   $0x2d,(%eax)
 566:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 56a:	eb 1b                	jmp    587 <printint+0xa3>
    putc(fd, buf[i]);
 56c:	8d 45 dc             	lea    -0x24(%ebp),%eax
 56f:	03 45 f4             	add    -0xc(%ebp),%eax
 572:	0f b6 00             	movzbl (%eax),%eax
 575:	0f be c0             	movsbl %al,%eax
 578:	89 44 24 04          	mov    %eax,0x4(%esp)
 57c:	8b 45 08             	mov    0x8(%ebp),%eax
 57f:	89 04 24             	mov    %eax,(%esp)
 582:	e8 35 ff ff ff       	call   4bc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 587:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 58b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58f:	79 db                	jns    56c <printint+0x88>
    putc(fd, buf[i]);
}
 591:	c9                   	leave  
 592:	c3                   	ret    

00000593 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 593:	55                   	push   %ebp
 594:	89 e5                	mov    %esp,%ebp
 596:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 599:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5a0:	8d 45 0c             	lea    0xc(%ebp),%eax
 5a3:	83 c0 04             	add    $0x4,%eax
 5a6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5b0:	e9 7d 01 00 00       	jmp    732 <printf+0x19f>
    c = fmt[i] & 0xff;
 5b5:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5bb:	01 d0                	add    %edx,%eax
 5bd:	0f b6 00             	movzbl (%eax),%eax
 5c0:	0f be c0             	movsbl %al,%eax
 5c3:	25 ff 00 00 00       	and    $0xff,%eax
 5c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5cf:	75 2c                	jne    5fd <printf+0x6a>
      if(c == '%'){
 5d1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d5:	75 0c                	jne    5e3 <printf+0x50>
        state = '%';
 5d7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5de:	e9 4b 01 00 00       	jmp    72e <printf+0x19b>
      } else {
        putc(fd, c);
 5e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e6:	0f be c0             	movsbl %al,%eax
 5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ed:	8b 45 08             	mov    0x8(%ebp),%eax
 5f0:	89 04 24             	mov    %eax,(%esp)
 5f3:	e8 c4 fe ff ff       	call   4bc <putc>
 5f8:	e9 31 01 00 00       	jmp    72e <printf+0x19b>
      }
    } else if(state == '%'){
 5fd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 601:	0f 85 27 01 00 00    	jne    72e <printf+0x19b>
      if(c == 'd'){
 607:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 60b:	75 2d                	jne    63a <printf+0xa7>
        printint(fd, *ap, 10, 1);
 60d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 619:	00 
 61a:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 621:	00 
 622:	89 44 24 04          	mov    %eax,0x4(%esp)
 626:	8b 45 08             	mov    0x8(%ebp),%eax
 629:	89 04 24             	mov    %eax,(%esp)
 62c:	e8 b3 fe ff ff       	call   4e4 <printint>
        ap++;
 631:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 635:	e9 ed 00 00 00       	jmp    727 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 63a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 63e:	74 06                	je     646 <printf+0xb3>
 640:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 644:	75 2d                	jne    673 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 646:	8b 45 e8             	mov    -0x18(%ebp),%eax
 649:	8b 00                	mov    (%eax),%eax
 64b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 652:	00 
 653:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 65a:	00 
 65b:	89 44 24 04          	mov    %eax,0x4(%esp)
 65f:	8b 45 08             	mov    0x8(%ebp),%eax
 662:	89 04 24             	mov    %eax,(%esp)
 665:	e8 7a fe ff ff       	call   4e4 <printint>
        ap++;
 66a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 66e:	e9 b4 00 00 00       	jmp    727 <printf+0x194>
      } else if(c == 's'){
 673:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 677:	75 46                	jne    6bf <printf+0x12c>
        s = (char*)*ap;
 679:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 681:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 685:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 689:	75 27                	jne    6b2 <printf+0x11f>
          s = "(null)";
 68b:	c7 45 f4 a0 09 00 00 	movl   $0x9a0,-0xc(%ebp)
        while(*s != 0){
 692:	eb 1e                	jmp    6b2 <printf+0x11f>
          putc(fd, *s);
 694:	8b 45 f4             	mov    -0xc(%ebp),%eax
 697:	0f b6 00             	movzbl (%eax),%eax
 69a:	0f be c0             	movsbl %al,%eax
 69d:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a1:	8b 45 08             	mov    0x8(%ebp),%eax
 6a4:	89 04 24             	mov    %eax,(%esp)
 6a7:	e8 10 fe ff ff       	call   4bc <putc>
          s++;
 6ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 6b0:	eb 01                	jmp    6b3 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6b2:	90                   	nop
 6b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b6:	0f b6 00             	movzbl (%eax),%eax
 6b9:	84 c0                	test   %al,%al
 6bb:	75 d7                	jne    694 <printf+0x101>
 6bd:	eb 68                	jmp    727 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6bf:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6c3:	75 1d                	jne    6e2 <printf+0x14f>
        putc(fd, *ap);
 6c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c8:	8b 00                	mov    (%eax),%eax
 6ca:	0f be c0             	movsbl %al,%eax
 6cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 6d1:	8b 45 08             	mov    0x8(%ebp),%eax
 6d4:	89 04 24             	mov    %eax,(%esp)
 6d7:	e8 e0 fd ff ff       	call   4bc <putc>
        ap++;
 6dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6e0:	eb 45                	jmp    727 <printf+0x194>
      } else if(c == '%'){
 6e2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6e6:	75 17                	jne    6ff <printf+0x16c>
        putc(fd, c);
 6e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6eb:	0f be c0             	movsbl %al,%eax
 6ee:	89 44 24 04          	mov    %eax,0x4(%esp)
 6f2:	8b 45 08             	mov    0x8(%ebp),%eax
 6f5:	89 04 24             	mov    %eax,(%esp)
 6f8:	e8 bf fd ff ff       	call   4bc <putc>
 6fd:	eb 28                	jmp    727 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ff:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 706:	00 
 707:	8b 45 08             	mov    0x8(%ebp),%eax
 70a:	89 04 24             	mov    %eax,(%esp)
 70d:	e8 aa fd ff ff       	call   4bc <putc>
        putc(fd, c);
 712:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 715:	0f be c0             	movsbl %al,%eax
 718:	89 44 24 04          	mov    %eax,0x4(%esp)
 71c:	8b 45 08             	mov    0x8(%ebp),%eax
 71f:	89 04 24             	mov    %eax,(%esp)
 722:	e8 95 fd ff ff       	call   4bc <putc>
      }
      state = 0;
 727:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 732:	8b 55 0c             	mov    0xc(%ebp),%edx
 735:	8b 45 f0             	mov    -0x10(%ebp),%eax
 738:	01 d0                	add    %edx,%eax
 73a:	0f b6 00             	movzbl (%eax),%eax
 73d:	84 c0                	test   %al,%al
 73f:	0f 85 70 fe ff ff    	jne    5b5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 745:	c9                   	leave  
 746:	c3                   	ret    
 747:	90                   	nop

00000748 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 748:	55                   	push   %ebp
 749:	89 e5                	mov    %esp,%ebp
 74b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 74e:	8b 45 08             	mov    0x8(%ebp),%eax
 751:	83 e8 08             	sub    $0x8,%eax
 754:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 757:	a1 64 0c 00 00       	mov    0xc64,%eax
 75c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 75f:	eb 24                	jmp    785 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 761:	8b 45 fc             	mov    -0x4(%ebp),%eax
 764:	8b 00                	mov    (%eax),%eax
 766:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 769:	77 12                	ja     77d <free+0x35>
 76b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 771:	77 24                	ja     797 <free+0x4f>
 773:	8b 45 fc             	mov    -0x4(%ebp),%eax
 776:	8b 00                	mov    (%eax),%eax
 778:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 77b:	77 1a                	ja     797 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 780:	8b 00                	mov    (%eax),%eax
 782:	89 45 fc             	mov    %eax,-0x4(%ebp)
 785:	8b 45 f8             	mov    -0x8(%ebp),%eax
 788:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 78b:	76 d4                	jbe    761 <free+0x19>
 78d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 790:	8b 00                	mov    (%eax),%eax
 792:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 795:	76 ca                	jbe    761 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 797:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79a:	8b 40 04             	mov    0x4(%eax),%eax
 79d:	c1 e0 03             	shl    $0x3,%eax
 7a0:	89 c2                	mov    %eax,%edx
 7a2:	03 55 f8             	add    -0x8(%ebp),%edx
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	39 c2                	cmp    %eax,%edx
 7ac:	75 24                	jne    7d2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 7ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b1:	8b 50 04             	mov    0x4(%eax),%edx
 7b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b7:	8b 00                	mov    (%eax),%eax
 7b9:	8b 40 04             	mov    0x4(%eax),%eax
 7bc:	01 c2                	add    %eax,%edx
 7be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c7:	8b 00                	mov    (%eax),%eax
 7c9:	8b 10                	mov    (%eax),%edx
 7cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ce:	89 10                	mov    %edx,(%eax)
 7d0:	eb 0a                	jmp    7dc <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d5:	8b 10                	mov    (%eax),%edx
 7d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7da:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	c1 e0 03             	shl    $0x3,%eax
 7e5:	03 45 fc             	add    -0x4(%ebp),%eax
 7e8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7eb:	75 20                	jne    80d <free+0xc5>
    p->s.size += bp->s.size;
 7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f0:	8b 50 04             	mov    0x4(%eax),%edx
 7f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	01 c2                	add    %eax,%edx
 7fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fe:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 801:	8b 45 f8             	mov    -0x8(%ebp),%eax
 804:	8b 10                	mov    (%eax),%edx
 806:	8b 45 fc             	mov    -0x4(%ebp),%eax
 809:	89 10                	mov    %edx,(%eax)
 80b:	eb 08                	jmp    815 <free+0xcd>
  } else
    p->s.ptr = bp;
 80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 810:	8b 55 f8             	mov    -0x8(%ebp),%edx
 813:	89 10                	mov    %edx,(%eax)
  freep = p;
 815:	8b 45 fc             	mov    -0x4(%ebp),%eax
 818:	a3 64 0c 00 00       	mov    %eax,0xc64
}
 81d:	c9                   	leave  
 81e:	c3                   	ret    

0000081f <morecore>:

static Header*
morecore(uint nu)
{
 81f:	55                   	push   %ebp
 820:	89 e5                	mov    %esp,%ebp
 822:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 825:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 82c:	77 07                	ja     835 <morecore+0x16>
    nu = 4096;
 82e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 835:	8b 45 08             	mov    0x8(%ebp),%eax
 838:	c1 e0 03             	shl    $0x3,%eax
 83b:	89 04 24             	mov    %eax,(%esp)
 83e:	e8 41 fc ff ff       	call   484 <sbrk>
 843:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 846:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 84a:	75 07                	jne    853 <morecore+0x34>
    return 0;
 84c:	b8 00 00 00 00       	mov    $0x0,%eax
 851:	eb 22                	jmp    875 <morecore+0x56>
  hp = (Header*)p;
 853:	8b 45 f4             	mov    -0xc(%ebp),%eax
 856:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 859:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85c:	8b 55 08             	mov    0x8(%ebp),%edx
 85f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 862:	8b 45 f0             	mov    -0x10(%ebp),%eax
 865:	83 c0 08             	add    $0x8,%eax
 868:	89 04 24             	mov    %eax,(%esp)
 86b:	e8 d8 fe ff ff       	call   748 <free>
  return freep;
 870:	a1 64 0c 00 00       	mov    0xc64,%eax
}
 875:	c9                   	leave  
 876:	c3                   	ret    

00000877 <malloc>:

void*
malloc(uint nbytes)
{
 877:	55                   	push   %ebp
 878:	89 e5                	mov    %esp,%ebp
 87a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 87d:	8b 45 08             	mov    0x8(%ebp),%eax
 880:	83 c0 07             	add    $0x7,%eax
 883:	c1 e8 03             	shr    $0x3,%eax
 886:	83 c0 01             	add    $0x1,%eax
 889:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 88c:	a1 64 0c 00 00       	mov    0xc64,%eax
 891:	89 45 f0             	mov    %eax,-0x10(%ebp)
 894:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 898:	75 23                	jne    8bd <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 89a:	c7 45 f0 5c 0c 00 00 	movl   $0xc5c,-0x10(%ebp)
 8a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a4:	a3 64 0c 00 00       	mov    %eax,0xc64
 8a9:	a1 64 0c 00 00       	mov    0xc64,%eax
 8ae:	a3 5c 0c 00 00       	mov    %eax,0xc5c
    base.s.size = 0;
 8b3:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 8ba:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c0:	8b 00                	mov    (%eax),%eax
 8c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c8:	8b 40 04             	mov    0x4(%eax),%eax
 8cb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8ce:	72 4d                	jb     91d <malloc+0xa6>
      if(p->s.size == nunits)
 8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d3:	8b 40 04             	mov    0x4(%eax),%eax
 8d6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8d9:	75 0c                	jne    8e7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8de:	8b 10                	mov    (%eax),%edx
 8e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e3:	89 10                	mov    %edx,(%eax)
 8e5:	eb 26                	jmp    90d <malloc+0x96>
      else {
        p->s.size -= nunits;
 8e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ea:	8b 40 04             	mov    0x4(%eax),%eax
 8ed:	89 c2                	mov    %eax,%edx
 8ef:	2b 55 ec             	sub    -0x14(%ebp),%edx
 8f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fb:	8b 40 04             	mov    0x4(%eax),%eax
 8fe:	c1 e0 03             	shl    $0x3,%eax
 901:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 904:	8b 45 f4             	mov    -0xc(%ebp),%eax
 907:	8b 55 ec             	mov    -0x14(%ebp),%edx
 90a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 90d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 910:	a3 64 0c 00 00       	mov    %eax,0xc64
      return (void*)(p + 1);
 915:	8b 45 f4             	mov    -0xc(%ebp),%eax
 918:	83 c0 08             	add    $0x8,%eax
 91b:	eb 38                	jmp    955 <malloc+0xde>
    }
    if(p == freep)
 91d:	a1 64 0c 00 00       	mov    0xc64,%eax
 922:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 925:	75 1b                	jne    942 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 927:	8b 45 ec             	mov    -0x14(%ebp),%eax
 92a:	89 04 24             	mov    %eax,(%esp)
 92d:	e8 ed fe ff ff       	call   81f <morecore>
 932:	89 45 f4             	mov    %eax,-0xc(%ebp)
 935:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 939:	75 07                	jne    942 <malloc+0xcb>
        return 0;
 93b:	b8 00 00 00 00       	mov    $0x0,%eax
 940:	eb 13                	jmp    955 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 942:	8b 45 f4             	mov    -0xc(%ebp),%eax
 945:	89 45 f0             	mov    %eax,-0x10(%ebp)
 948:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94b:	8b 00                	mov    (%eax),%eax
 94d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 950:	e9 70 ff ff ff       	jmp    8c5 <malloc+0x4e>
}
 955:	c9                   	leave  
 956:	c3                   	ret    
