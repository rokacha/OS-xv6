
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
  bc:	c7 44 24 04 d4 0d 00 	movl   $0xdd4,0x4(%esp)
  c3:	00 
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	e8 db 04 00 00       	call   5ab <printf>
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
 161:	c7 44 24 04 01 0e 00 	movl   $0xe01,0x4(%esp)
 168:	00 
 169:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 170:	e8 36 04 00 00       	call   5ab <printf>
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

000004bc <signal>:
SYSCALL(signal)
 4bc:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <sigsend>:
SYSCALL(sigsend)
 4c4:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <alarm>:
SYSCALL(alarm)
 4cc:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4d4:	55                   	push   %ebp
 4d5:	89 e5                	mov    %esp,%ebp
 4d7:	83 ec 28             	sub    $0x28,%esp
 4da:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4e0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e7:	00 
 4e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ef:	8b 45 08             	mov    0x8(%ebp),%eax
 4f2:	89 04 24             	mov    %eax,(%esp)
 4f5:	e8 22 ff ff ff       	call   41c <write>
}
 4fa:	c9                   	leave  
 4fb:	c3                   	ret    

000004fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fc:	55                   	push   %ebp
 4fd:	89 e5                	mov    %esp,%ebp
 4ff:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 502:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 509:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 50d:	74 17                	je     526 <printint+0x2a>
 50f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 513:	79 11                	jns    526 <printint+0x2a>
    neg = 1;
 515:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 51c:	8b 45 0c             	mov    0xc(%ebp),%eax
 51f:	f7 d8                	neg    %eax
 521:	89 45 ec             	mov    %eax,-0x14(%ebp)
 524:	eb 06                	jmp    52c <printint+0x30>
  } else {
    x = xx;
 526:	8b 45 0c             	mov    0xc(%ebp),%eax
 529:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 52c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 533:	8b 4d 10             	mov    0x10(%ebp),%ecx
 536:	8b 45 ec             	mov    -0x14(%ebp),%eax
 539:	ba 00 00 00 00       	mov    $0x0,%edx
 53e:	f7 f1                	div    %ecx
 540:	89 d0                	mov    %edx,%eax
 542:	0f b6 90 38 12 00 00 	movzbl 0x1238(%eax),%edx
 549:	8d 45 dc             	lea    -0x24(%ebp),%eax
 54c:	03 45 f4             	add    -0xc(%ebp),%eax
 54f:	88 10                	mov    %dl,(%eax)
 551:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 555:	8b 55 10             	mov    0x10(%ebp),%edx
 558:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 55b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 55e:	ba 00 00 00 00       	mov    $0x0,%edx
 563:	f7 75 d4             	divl   -0x2c(%ebp)
 566:	89 45 ec             	mov    %eax,-0x14(%ebp)
 569:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 56d:	75 c4                	jne    533 <printint+0x37>
  if(neg)
 56f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 573:	74 2a                	je     59f <printint+0xa3>
    buf[i++] = '-';
 575:	8d 45 dc             	lea    -0x24(%ebp),%eax
 578:	03 45 f4             	add    -0xc(%ebp),%eax
 57b:	c6 00 2d             	movb   $0x2d,(%eax)
 57e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 582:	eb 1b                	jmp    59f <printint+0xa3>
    putc(fd, buf[i]);
 584:	8d 45 dc             	lea    -0x24(%ebp),%eax
 587:	03 45 f4             	add    -0xc(%ebp),%eax
 58a:	0f b6 00             	movzbl (%eax),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	89 44 24 04          	mov    %eax,0x4(%esp)
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	89 04 24             	mov    %eax,(%esp)
 59a:	e8 35 ff ff ff       	call   4d4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 59f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a7:	79 db                	jns    584 <printint+0x88>
    putc(fd, buf[i]);
}
 5a9:	c9                   	leave  
 5aa:	c3                   	ret    

000005ab <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5ab:	55                   	push   %ebp
 5ac:	89 e5                	mov    %esp,%ebp
 5ae:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5b8:	8d 45 0c             	lea    0xc(%ebp),%eax
 5bb:	83 c0 04             	add    $0x4,%eax
 5be:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5c8:	e9 7d 01 00 00       	jmp    74a <printf+0x19f>
    c = fmt[i] & 0xff;
 5cd:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d3:	01 d0                	add    %edx,%eax
 5d5:	0f b6 00             	movzbl (%eax),%eax
 5d8:	0f be c0             	movsbl %al,%eax
 5db:	25 ff 00 00 00       	and    $0xff,%eax
 5e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5e7:	75 2c                	jne    615 <printf+0x6a>
      if(c == '%'){
 5e9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ed:	75 0c                	jne    5fb <printf+0x50>
        state = '%';
 5ef:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5f6:	e9 4b 01 00 00       	jmp    746 <printf+0x19b>
      } else {
        putc(fd, c);
 5fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fe:	0f be c0             	movsbl %al,%eax
 601:	89 44 24 04          	mov    %eax,0x4(%esp)
 605:	8b 45 08             	mov    0x8(%ebp),%eax
 608:	89 04 24             	mov    %eax,(%esp)
 60b:	e8 c4 fe ff ff       	call   4d4 <putc>
 610:	e9 31 01 00 00       	jmp    746 <printf+0x19b>
      }
    } else if(state == '%'){
 615:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 619:	0f 85 27 01 00 00    	jne    746 <printf+0x19b>
      if(c == 'd'){
 61f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 623:	75 2d                	jne    652 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 625:	8b 45 e8             	mov    -0x18(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 631:	00 
 632:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 639:	00 
 63a:	89 44 24 04          	mov    %eax,0x4(%esp)
 63e:	8b 45 08             	mov    0x8(%ebp),%eax
 641:	89 04 24             	mov    %eax,(%esp)
 644:	e8 b3 fe ff ff       	call   4fc <printint>
        ap++;
 649:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 64d:	e9 ed 00 00 00       	jmp    73f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 652:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 656:	74 06                	je     65e <printf+0xb3>
 658:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 65c:	75 2d                	jne    68b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 65e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 661:	8b 00                	mov    (%eax),%eax
 663:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 66a:	00 
 66b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 672:	00 
 673:	89 44 24 04          	mov    %eax,0x4(%esp)
 677:	8b 45 08             	mov    0x8(%ebp),%eax
 67a:	89 04 24             	mov    %eax,(%esp)
 67d:	e8 7a fe ff ff       	call   4fc <printint>
        ap++;
 682:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 686:	e9 b4 00 00 00       	jmp    73f <printf+0x194>
      } else if(c == 's'){
 68b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 68f:	75 46                	jne    6d7 <printf+0x12c>
        s = (char*)*ap;
 691:	8b 45 e8             	mov    -0x18(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 699:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 69d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a1:	75 27                	jne    6ca <printf+0x11f>
          s = "(null)";
 6a3:	c7 45 f4 1c 0e 00 00 	movl   $0xe1c,-0xc(%ebp)
        while(*s != 0){
 6aa:	eb 1e                	jmp    6ca <printf+0x11f>
          putc(fd, *s);
 6ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6af:	0f b6 00             	movzbl (%eax),%eax
 6b2:	0f be c0             	movsbl %al,%eax
 6b5:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
 6bc:	89 04 24             	mov    %eax,(%esp)
 6bf:	e8 10 fe ff ff       	call   4d4 <putc>
          s++;
 6c4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 6c8:	eb 01                	jmp    6cb <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6ca:	90                   	nop
 6cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ce:	0f b6 00             	movzbl (%eax),%eax
 6d1:	84 c0                	test   %al,%al
 6d3:	75 d7                	jne    6ac <printf+0x101>
 6d5:	eb 68                	jmp    73f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6d7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6db:	75 1d                	jne    6fa <printf+0x14f>
        putc(fd, *ap);
 6dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6e0:	8b 00                	mov    (%eax),%eax
 6e2:	0f be c0             	movsbl %al,%eax
 6e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	89 04 24             	mov    %eax,(%esp)
 6ef:	e8 e0 fd ff ff       	call   4d4 <putc>
        ap++;
 6f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f8:	eb 45                	jmp    73f <printf+0x194>
      } else if(c == '%'){
 6fa:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6fe:	75 17                	jne    717 <printf+0x16c>
        putc(fd, c);
 700:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 703:	0f be c0             	movsbl %al,%eax
 706:	89 44 24 04          	mov    %eax,0x4(%esp)
 70a:	8b 45 08             	mov    0x8(%ebp),%eax
 70d:	89 04 24             	mov    %eax,(%esp)
 710:	e8 bf fd ff ff       	call   4d4 <putc>
 715:	eb 28                	jmp    73f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 717:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 71e:	00 
 71f:	8b 45 08             	mov    0x8(%ebp),%eax
 722:	89 04 24             	mov    %eax,(%esp)
 725:	e8 aa fd ff ff       	call   4d4 <putc>
        putc(fd, c);
 72a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 72d:	0f be c0             	movsbl %al,%eax
 730:	89 44 24 04          	mov    %eax,0x4(%esp)
 734:	8b 45 08             	mov    0x8(%ebp),%eax
 737:	89 04 24             	mov    %eax,(%esp)
 73a:	e8 95 fd ff ff       	call   4d4 <putc>
      }
      state = 0;
 73f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 746:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 74a:	8b 55 0c             	mov    0xc(%ebp),%edx
 74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 750:	01 d0                	add    %edx,%eax
 752:	0f b6 00             	movzbl (%eax),%eax
 755:	84 c0                	test   %al,%al
 757:	0f 85 70 fe ff ff    	jne    5cd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 75d:	c9                   	leave  
 75e:	c3                   	ret    
 75f:	90                   	nop

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 766:	8b 45 08             	mov    0x8(%ebp),%eax
 769:	83 e8 08             	sub    $0x8,%eax
 76c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76f:	a1 68 12 00 00       	mov    0x1268,%eax
 774:	89 45 fc             	mov    %eax,-0x4(%ebp)
 777:	eb 24                	jmp    79d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 779:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77c:	8b 00                	mov    (%eax),%eax
 77e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 781:	77 12                	ja     795 <free+0x35>
 783:	8b 45 f8             	mov    -0x8(%ebp),%eax
 786:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 789:	77 24                	ja     7af <free+0x4f>
 78b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78e:	8b 00                	mov    (%eax),%eax
 790:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 793:	77 1a                	ja     7af <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 795:	8b 45 fc             	mov    -0x4(%ebp),%eax
 798:	8b 00                	mov    (%eax),%eax
 79a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 79d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a3:	76 d4                	jbe    779 <free+0x19>
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7ad:	76 ca                	jbe    779 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b2:	8b 40 04             	mov    0x4(%eax),%eax
 7b5:	c1 e0 03             	shl    $0x3,%eax
 7b8:	89 c2                	mov    %eax,%edx
 7ba:	03 55 f8             	add    -0x8(%ebp),%edx
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 00                	mov    (%eax),%eax
 7c2:	39 c2                	cmp    %eax,%edx
 7c4:	75 24                	jne    7ea <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	8b 50 04             	mov    0x4(%eax),%edx
 7cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cf:	8b 00                	mov    (%eax),%eax
 7d1:	8b 40 04             	mov    0x4(%eax),%eax
 7d4:	01 c2                	add    %eax,%edx
 7d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7df:	8b 00                	mov    (%eax),%eax
 7e1:	8b 10                	mov    (%eax),%edx
 7e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e6:	89 10                	mov    %edx,(%eax)
 7e8:	eb 0a                	jmp    7f4 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 7ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ed:	8b 10                	mov    (%eax),%edx
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	c1 e0 03             	shl    $0x3,%eax
 7fd:	03 45 fc             	add    -0x4(%ebp),%eax
 800:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 803:	75 20                	jne    825 <free+0xc5>
    p->s.size += bp->s.size;
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 50 04             	mov    0x4(%eax),%edx
 80b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80e:	8b 40 04             	mov    0x4(%eax),%eax
 811:	01 c2                	add    %eax,%edx
 813:	8b 45 fc             	mov    -0x4(%ebp),%eax
 816:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 819:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81c:	8b 10                	mov    (%eax),%edx
 81e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 821:	89 10                	mov    %edx,(%eax)
 823:	eb 08                	jmp    82d <free+0xcd>
  } else
    p->s.ptr = bp;
 825:	8b 45 fc             	mov    -0x4(%ebp),%eax
 828:	8b 55 f8             	mov    -0x8(%ebp),%edx
 82b:	89 10                	mov    %edx,(%eax)
  freep = p;
 82d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 830:	a3 68 12 00 00       	mov    %eax,0x1268
}
 835:	c9                   	leave  
 836:	c3                   	ret    

00000837 <morecore>:

static Header*
morecore(uint nu)
{
 837:	55                   	push   %ebp
 838:	89 e5                	mov    %esp,%ebp
 83a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 83d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 844:	77 07                	ja     84d <morecore+0x16>
    nu = 4096;
 846:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 84d:	8b 45 08             	mov    0x8(%ebp),%eax
 850:	c1 e0 03             	shl    $0x3,%eax
 853:	89 04 24             	mov    %eax,(%esp)
 856:	e8 29 fc ff ff       	call   484 <sbrk>
 85b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 85e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 862:	75 07                	jne    86b <morecore+0x34>
    return 0;
 864:	b8 00 00 00 00       	mov    $0x0,%eax
 869:	eb 22                	jmp    88d <morecore+0x56>
  hp = (Header*)p;
 86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 871:	8b 45 f0             	mov    -0x10(%ebp),%eax
 874:	8b 55 08             	mov    0x8(%ebp),%edx
 877:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 87a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87d:	83 c0 08             	add    $0x8,%eax
 880:	89 04 24             	mov    %eax,(%esp)
 883:	e8 d8 fe ff ff       	call   760 <free>
  return freep;
 888:	a1 68 12 00 00       	mov    0x1268,%eax
}
 88d:	c9                   	leave  
 88e:	c3                   	ret    

0000088f <malloc>:

void*
malloc(uint nbytes)
{
 88f:	55                   	push   %ebp
 890:	89 e5                	mov    %esp,%ebp
 892:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 895:	8b 45 08             	mov    0x8(%ebp),%eax
 898:	83 c0 07             	add    $0x7,%eax
 89b:	c1 e8 03             	shr    $0x3,%eax
 89e:	83 c0 01             	add    $0x1,%eax
 8a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8a4:	a1 68 12 00 00       	mov    0x1268,%eax
 8a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8b0:	75 23                	jne    8d5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8b2:	c7 45 f0 60 12 00 00 	movl   $0x1260,-0x10(%ebp)
 8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bc:	a3 68 12 00 00       	mov    %eax,0x1268
 8c1:	a1 68 12 00 00       	mov    0x1268,%eax
 8c6:	a3 60 12 00 00       	mov    %eax,0x1260
    base.s.size = 0;
 8cb:	c7 05 64 12 00 00 00 	movl   $0x0,0x1264
 8d2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d8:	8b 00                	mov    (%eax),%eax
 8da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e0:	8b 40 04             	mov    0x4(%eax),%eax
 8e3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8e6:	72 4d                	jb     935 <malloc+0xa6>
      if(p->s.size == nunits)
 8e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8eb:	8b 40 04             	mov    0x4(%eax),%eax
 8ee:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8f1:	75 0c                	jne    8ff <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f6:	8b 10                	mov    (%eax),%edx
 8f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fb:	89 10                	mov    %edx,(%eax)
 8fd:	eb 26                	jmp    925 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 902:	8b 40 04             	mov    0x4(%eax),%eax
 905:	89 c2                	mov    %eax,%edx
 907:	2b 55 ec             	sub    -0x14(%ebp),%edx
 90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 910:	8b 45 f4             	mov    -0xc(%ebp),%eax
 913:	8b 40 04             	mov    0x4(%eax),%eax
 916:	c1 e0 03             	shl    $0x3,%eax
 919:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 91c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 922:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 925:	8b 45 f0             	mov    -0x10(%ebp),%eax
 928:	a3 68 12 00 00       	mov    %eax,0x1268
      return (void*)(p + 1);
 92d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 930:	83 c0 08             	add    $0x8,%eax
 933:	eb 38                	jmp    96d <malloc+0xde>
    }
    if(p == freep)
 935:	a1 68 12 00 00       	mov    0x1268,%eax
 93a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 93d:	75 1b                	jne    95a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 93f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 942:	89 04 24             	mov    %eax,(%esp)
 945:	e8 ed fe ff ff       	call   837 <morecore>
 94a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 94d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 951:	75 07                	jne    95a <malloc+0xcb>
        return 0;
 953:	b8 00 00 00 00       	mov    $0x0,%eax
 958:	eb 13                	jmp    96d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 960:	8b 45 f4             	mov    -0xc(%ebp),%eax
 963:	8b 00                	mov    (%eax),%eax
 965:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 968:	e9 70 ff ff ff       	jmp    8dd <malloc+0x4e>
}
 96d:	c9                   	leave  
 96e:	c3                   	ret    
 96f:	90                   	nop

00000970 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 976:	8b 45 08             	mov    0x8(%ebp),%eax
 979:	83 c0 01             	add    $0x1,%eax
 97c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 97f:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 983:	75 07                	jne    98c <getNextThread+0x1c>
    i=0;
 985:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 98c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98f:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 995:	05 80 12 00 00       	add    $0x1280,%eax
 99a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 99d:	eb 3b                	jmp    9da <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 99f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a2:	8b 40 10             	mov    0x10(%eax),%eax
 9a5:	83 f8 03             	cmp    $0x3,%eax
 9a8:	75 05                	jne    9af <getNextThread+0x3f>
      return i;
 9aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ad:	eb 38                	jmp    9e7 <getNextThread+0x77>
    i++;
 9af:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 9b3:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 9b7:	75 1a                	jne    9d3 <getNextThread+0x63>
    {
       i=0;
 9b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 9c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c3:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 9c9:	05 80 12 00 00       	add    $0x1280,%eax
 9ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
 9d1:	eb 07                	jmp    9da <getNextThread+0x6a>
    }
    else
      t++;
 9d3:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 9da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9dd:	3b 45 08             	cmp    0x8(%ebp),%eax
 9e0:	75 bd                	jne    99f <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 9e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 9e7:	c9                   	leave  
 9e8:	c3                   	ret    

000009e9 <allocThread>:


static uthread_p
allocThread()
{
 9e9:	55                   	push   %ebp
 9ea:	89 e5                	mov    %esp,%ebp
 9ec:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 9ef:	c7 45 ec 80 12 00 00 	movl   $0x1280,-0x14(%ebp)
 9f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 9fd:	eb 15                	jmp    a14 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 9ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a02:	8b 40 10             	mov    0x10(%eax),%eax
 a05:	85 c0                	test   %eax,%eax
 a07:	74 1e                	je     a27 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 a09:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 a10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a14:	81 7d ec 80 58 00 00 	cmpl   $0x5880,-0x14(%ebp)
 a1b:	76 e2                	jbe    9ff <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 a1d:	b8 00 00 00 00       	mov    $0x0,%eax
 a22:	e9 88 00 00 00       	jmp    aaf <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 a27:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 a28:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a2b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a2e:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 a30:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 a37:	e8 53 fe ff ff       	call   88f <malloc>
 a3c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a3f:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 a42:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a45:	8b 40 0c             	mov    0xc(%eax),%eax
 a48:	89 c2                	mov    %eax,%edx
 a4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a4d:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 a50:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a53:	8b 40 0c             	mov    0xc(%eax),%eax
 a56:	89 c2                	mov    %eax,%edx
 a58:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a5b:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 a5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a61:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 a68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 a6f:	eb 15                	jmp    a86 <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 a71:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a74:	8b 55 f0             	mov    -0x10(%ebp),%edx
 a77:	83 c2 04             	add    $0x4,%edx
 a7a:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 a81:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 a82:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 a86:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 a8a:	7e e5                	jle    a71 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 a8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a8f:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 a92:	ba ae 0b 00 00       	mov    $0xbae,%edx
 a97:	89 c4                	mov    %eax,%esp
 a99:	52                   	push   %edx
 a9a:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 a9c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 a9f:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 aa2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aa5:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 aac:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 aaf:	c9                   	leave  
 ab0:	c3                   	ret    

00000ab1 <uthread_init>:

void 
uthread_init()
{  
 ab1:	55                   	push   %ebp
 ab2:	89 e5                	mov    %esp,%ebp
 ab4:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 ab7:	c7 05 80 58 00 00 00 	movl   $0x0,0x5880
 abe:	00 00 00 
  tTable.current=0;
 ac1:	c7 05 84 58 00 00 00 	movl   $0x0,0x5884
 ac8:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 acb:	e8 19 ff ff ff       	call   9e9 <allocThread>
 ad0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 ad3:	89 e9                	mov    %ebp,%ecx
 ad5:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 ada:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 add:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 ae0:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae6:	8b 50 08             	mov    0x8(%eax),%edx
 ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aec:	8b 40 04             	mov    0x4(%eax),%eax
 aef:	89 d1                	mov    %edx,%ecx
 af1:	29 c1                	sub    %eax,%ecx
 af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af6:	8b 40 04             	mov    0x4(%eax),%eax
 af9:	89 c2                	mov    %eax,%edx
 afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afe:	8b 40 0c             	mov    0xc(%eax),%eax
 b01:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 b05:	89 54 24 04          	mov    %edx,0x4(%esp)
 b09:	89 04 24             	mov    %eax,(%esp)
 b0c:	e8 a5 f8 ff ff       	call   3b6 <memmove>
  mainT->state = T_RUNNABLE;
 b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b14:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b1e:	a3 88 58 00 00       	mov    %eax,0x5888
  if(signal(SIGALRM,uthread_yield)<0)
 b23:	c7 44 24 04 1e 0d 00 	movl   $0xd1e,0x4(%esp)
 b2a:	00 
 b2b:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 b32:	e8 85 f9 ff ff       	call   4bc <signal>
 b37:	85 c0                	test   %eax,%eax
 b39:	79 19                	jns    b54 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 b3b:	c7 44 24 04 24 0e 00 	movl   $0xe24,0x4(%esp)
 b42:	00 
 b43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b4a:	e8 5c fa ff ff       	call   5ab <printf>
    exit();
 b4f:	e8 a8 f8 ff ff       	call   3fc <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 b54:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 b5b:	e8 6c f9 ff ff       	call   4cc <alarm>
 b60:	85 c0                	test   %eax,%eax
 b62:	79 19                	jns    b7d <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 b64:	c7 44 24 04 44 0e 00 	movl   $0xe44,0x4(%esp)
 b6b:	00 
 b6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 b73:	e8 33 fa ff ff       	call   5ab <printf>
    exit();
 b78:	e8 7f f8 ff ff       	call   3fc <exit>
  }
  
}
 b7d:	c9                   	leave  
 b7e:	c3                   	ret    

00000b7f <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 b7f:	55                   	push   %ebp
 b80:	89 e5                	mov    %esp,%ebp
 b82:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 b85:	e8 5f fe ff ff       	call   9e9 <allocThread>
 b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
 b90:	8b 55 08             	mov    0x8(%ebp),%edx
 b93:	50                   	push   %eax
 b94:	52                   	push   %edx
 b95:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 b9a:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba0:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 ba7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 baa:	8b 00                	mov    (%eax),%eax
}
 bac:	c9                   	leave  
 bad:	c3                   	ret    

00000bae <uthread_exit>:

void 
uthread_exit()
{
 bae:	55                   	push   %ebp
 baf:	89 e5                	mov    %esp,%ebp
 bb1:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 bb4:	a1 88 58 00 00       	mov    0x5888,%eax
 bb9:	8b 00                	mov    (%eax),%eax
 bbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 bbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 bc5:	eb 25                	jmp    bec <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 bc7:	a1 88 58 00 00       	mov    0x5888,%eax
 bcc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bcf:	83 c2 04             	add    $0x4,%edx
 bd2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 bd6:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bdc:	05 80 12 00 00       	add    $0x1280,%eax
 be1:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 be8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 bec:	a1 88 58 00 00       	mov    0x5888,%eax
 bf1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bf4:	83 c2 04             	add    $0x4,%edx
 bf7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 bfb:	83 f8 ff             	cmp    $0xffffffff,%eax
 bfe:	75 c7                	jne    bc7 <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 c00:	a1 88 58 00 00       	mov    0x5888,%eax
 c05:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 c0b:	a1 88 58 00 00       	mov    0x5888,%eax
 c10:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 c17:	a1 88 58 00 00       	mov    0x5888,%eax
 c1c:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 c23:	a1 88 58 00 00       	mov    0x5888,%eax
 c28:	8b 40 0c             	mov    0xc(%eax),%eax
 c2b:	89 04 24             	mov    %eax,(%esp)
 c2e:	e8 2d fb ff ff       	call   760 <free>
  currentThread->state=T_FREE;
 c33:	a1 88 58 00 00       	mov    0x5888,%eax
 c38:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 c3f:	a1 88 58 00 00       	mov    0x5888,%eax
 c44:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 c4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c4e:	89 04 24             	mov    %eax,(%esp)
 c51:	e8 1a fd ff ff       	call   970 <getNextThread>
 c56:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 c59:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 c5d:	78 36                	js     c95 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 c5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c62:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c68:	05 80 12 00 00       	add    $0x1280,%eax
 c6d:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 c70:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c73:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 c7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c7d:	8b 40 04             	mov    0x4(%eax),%eax
 c80:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 c82:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c85:	8b 40 08             	mov    0x8(%eax),%eax
 c88:	89 c5                	mov    %eax,%ebp
             asm("popa");
 c8a:	61                   	popa   
             currentThread=newt;
 c8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c8e:	a3 88 58 00 00       	mov    %eax,0x5888
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 c93:	c9                   	leave  
 c94:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 c95:	e8 62 f7 ff ff       	call   3fc <exit>

00000c9a <uthred_join>:
}


int
uthred_join(int tid)
{
 c9a:	55                   	push   %ebp
 c9b:	89 e5                	mov    %esp,%ebp
 c9d:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 ca0:	8b 45 08             	mov    0x8(%ebp),%eax
 ca3:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 ca9:	05 80 12 00 00       	add    $0x1280,%eax
 cae:	8b 40 10             	mov    0x10(%eax),%eax
 cb1:	85 c0                	test   %eax,%eax
 cb3:	75 07                	jne    cbc <uthred_join+0x22>
    return -1;
 cb5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 cba:	eb 60                	jmp    d1c <uthred_join+0x82>
  else
  {
      int i=0;
 cbc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 cc3:	eb 04                	jmp    cc9 <uthred_join+0x2f>
        i++;
 cc5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 cc9:	8b 45 08             	mov    0x8(%ebp),%eax
 ccc:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cd2:	05 80 12 00 00       	add    $0x1280,%eax
 cd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 cda:	83 c2 04             	add    $0x4,%edx
 cdd:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 ce1:	83 f8 ff             	cmp    $0xffffffff,%eax
 ce4:	75 df                	jne    cc5 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 ce6:	8b 45 08             	mov    0x8(%ebp),%eax
 ce9:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cef:	8d 90 80 12 00 00    	lea    0x1280(%eax),%edx
 cf5:	a1 88 58 00 00       	mov    0x5888,%eax
 cfa:	8b 00                	mov    (%eax),%eax
 cfc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 cff:	83 c1 04             	add    $0x4,%ecx
 d02:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 d06:	a1 88 58 00 00       	mov    0x5888,%eax
 d0b:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 d12:	e8 07 00 00 00       	call   d1e <uthread_yield>
      return 1;
 d17:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d1c:	c9                   	leave  
 d1d:	c3                   	ret    

00000d1e <uthread_yield>:

void 
uthread_yield()
{
 d1e:	55                   	push   %ebp
 d1f:	89 e5                	mov    %esp,%ebp
 d21:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 d24:	a1 88 58 00 00       	mov    0x5888,%eax
 d29:	8b 00                	mov    (%eax),%eax
 d2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 d2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d31:	89 04 24             	mov    %eax,(%esp)
 d34:	e8 37 fc ff ff       	call   970 <getNextThread>
 d39:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 d3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 d40:	79 19                	jns    d5b <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 d42:	c7 44 24 04 64 0e 00 	movl   $0xe64,0x4(%esp)
 d49:	00 
 d4a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d51:	e8 55 f8 ff ff       	call   5ab <printf>
    exit();
 d56:	e8 a1 f6 ff ff       	call   3fc <exit>
  }
newt=&tTable.table[new];
 d5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d5e:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 d64:	05 80 12 00 00       	add    $0x1280,%eax
 d69:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 d6c:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 d6d:	a1 88 58 00 00       	mov    0x5888,%eax
 d72:	89 e2                	mov    %esp,%edx
 d74:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 d77:	a1 88 58 00 00       	mov    0x5888,%eax
 d7c:	8b 40 10             	mov    0x10(%eax),%eax
 d7f:	83 f8 02             	cmp    $0x2,%eax
 d82:	75 0c                	jne    d90 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 d84:	a1 88 58 00 00       	mov    0x5888,%eax
 d89:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 d90:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d93:	8b 40 04             	mov    0x4(%eax),%eax
 d96:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 d98:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d9b:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 da2:	61                   	popa   
    if(currentThread->firstTime==0)
 da3:	a1 88 58 00 00       	mov    0x5888,%eax
 da8:	8b 40 14             	mov    0x14(%eax),%eax
 dab:	85 c0                	test   %eax,%eax
 dad:	75 0d                	jne    dbc <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 daf:	c3                   	ret    
       currentThread->firstTime=1;
 db0:	a1 88 58 00 00       	mov    0x5888,%eax
 db5:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 dbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 dbf:	a3 88 58 00 00       	mov    %eax,0x5888

}
 dc4:	c9                   	leave  
 dc5:	c3                   	ret    

00000dc6 <uthred_self>:

int  uthred_self(void)
{
 dc6:	55                   	push   %ebp
 dc7:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 dc9:	a1 88 58 00 00       	mov    0x5888,%eax
 dce:	8b 00                	mov    (%eax),%eax
}
 dd0:	5d                   	pop    %ebp
 dd1:	c3                   	ret    
