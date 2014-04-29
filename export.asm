
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
      bc:	c7 44 24 04 c4 10 00 	movl   $0x10c4,0x4(%esp)
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
     161:	c7 44 24 04 f1 10 00 	movl   $0x10f1,0x4(%esp)
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
     542:	0f b6 90 68 16 00 00 	movzbl 0x1668(%eax),%edx
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
     6a3:	c7 45 f4 0c 11 00 00 	movl   $0x110c,-0xc(%ebp)
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
     76f:	a1 88 16 00 00       	mov    0x1688,%eax
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
     830:	a3 88 16 00 00       	mov    %eax,0x1688
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
     888:	a1 88 16 00 00       	mov    0x1688,%eax
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
     8a4:	a1 88 16 00 00       	mov    0x1688,%eax
     8a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8b0:	75 23                	jne    8d5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8b2:	c7 45 f0 80 16 00 00 	movl   $0x1680,-0x10(%ebp)
     8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8bc:	a3 88 16 00 00       	mov    %eax,0x1688
     8c1:	a1 88 16 00 00       	mov    0x1688,%eax
     8c6:	a3 80 16 00 00       	mov    %eax,0x1680
    base.s.size = 0;
     8cb:	c7 05 84 16 00 00 00 	movl   $0x0,0x1684
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
     928:	a3 88 16 00 00       	mov    %eax,0x1688
      return (void*)(p + 1);
     92d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     930:	83 c0 08             	add    $0x8,%eax
     933:	eb 38                	jmp    96d <malloc+0xde>
    }
    if(p == freep)
     935:	a1 88 16 00 00       	mov    0x1688,%eax
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

00000970 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     976:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     97b:	8b 40 04             	mov    0x4(%eax),%eax
     97e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     981:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     986:	8b 00                	mov    (%eax),%eax
     988:	89 44 24 08          	mov    %eax,0x8(%esp)
     98c:	c7 44 24 04 14 11 00 	movl   $0x1114,0x4(%esp)
     993:	00 
     994:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     99b:	e8 0b fc ff ff       	call   5ab <printf>
  while((newesp < (int *)currentThread->ebp))
     9a0:	eb 3c                	jmp    9de <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     9a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a5:	89 44 24 08          	mov    %eax,0x8(%esp)
     9a9:	c7 44 24 04 2a 11 00 	movl   $0x112a,0x4(%esp)
     9b0:	00 
     9b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9b8:	e8 ee fb ff ff       	call   5ab <printf>
      printf(1,"val:%x\n",*newesp);
     9bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c0:	8b 00                	mov    (%eax),%eax
     9c2:	89 44 24 08          	mov    %eax,0x8(%esp)
     9c6:	c7 44 24 04 32 11 00 	movl   $0x1132,0x4(%esp)
     9cd:	00 
     9ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9d5:	e8 d1 fb ff ff       	call   5ab <printf>
    newesp++;
     9da:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     9de:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     9e3:	8b 40 08             	mov    0x8(%eax),%eax
     9e6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     9e9:	77 b7                	ja     9a2 <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     9eb:	c9                   	leave  
     9ec:	c3                   	ret    

000009ed <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     9ed:	55                   	push   %ebp
     9ee:	89 e5                	mov    %esp,%ebp
     9f0:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     9f3:	8b 45 08             	mov    0x8(%ebp),%eax
     9f6:	83 c0 01             	add    $0x1,%eax
     9f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     9fc:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a00:	75 07                	jne    a09 <getNextThread+0x1c>
    i=0;
     a02:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     a09:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a0c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a12:	05 a0 16 00 00       	add    $0x16a0,%eax
     a17:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     a1a:	eb 3b                	jmp    a57 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     a1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a1f:	8b 40 10             	mov    0x10(%eax),%eax
     a22:	83 f8 03             	cmp    $0x3,%eax
     a25:	75 05                	jne    a2c <getNextThread+0x3f>
      return i;
     a27:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a2a:	eb 38                	jmp    a64 <getNextThread+0x77>
    i++;
     a2c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     a30:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     a34:	75 1a                	jne    a50 <getNextThread+0x63>
    {
     i=0;
     a36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     a3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a40:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     a46:	05 a0 16 00 00       	add    $0x16a0,%eax
     a4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
     a4e:	eb 07                	jmp    a57 <getNextThread+0x6a>
   }
   else
    t++;
     a50:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     a57:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a5a:	3b 45 08             	cmp    0x8(%ebp),%eax
     a5d:	75 bd                	jne    a1c <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     a5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     a64:	c9                   	leave  
     a65:	c3                   	ret    

00000a66 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     a66:	55                   	push   %ebp
     a67:	89 e5                	mov    %esp,%ebp
     a69:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     a6c:	c7 45 ec a0 16 00 00 	movl   $0x16a0,-0x14(%ebp)
     a73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a7a:	eb 15                	jmp    a91 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     a7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a7f:	8b 40 10             	mov    0x10(%eax),%eax
     a82:	85 c0                	test   %eax,%eax
     a84:	74 1e                	je     aa4 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     a86:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     a8d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a91:	81 7d ec a0 5f 00 00 	cmpl   $0x5fa0,-0x14(%ebp)
     a98:	72 e2                	jb     a7c <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     a9a:	b8 00 00 00 00       	mov    $0x0,%eax
     a9f:	e9 a3 00 00 00       	jmp    b47 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     aa4:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     aa5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     aa8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     aab:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     aad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ab1:	75 1c                	jne    acf <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     ab3:	89 e2                	mov    %esp,%edx
     ab5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ab8:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     abb:	89 ea                	mov    %ebp,%edx
     abd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ac0:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     ac3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ac6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     acd:	eb 3b                	jmp    b0a <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     acf:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     ad6:	e8 b4 fd ff ff       	call   88f <malloc>
     adb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ade:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     ae1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ae4:	8b 40 0c             	mov    0xc(%eax),%eax
     ae7:	05 00 10 00 00       	add    $0x1000,%eax
     aec:	89 c2                	mov    %eax,%edx
     aee:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af1:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     af4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af7:	8b 50 08             	mov    0x8(%eax),%edx
     afa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     afd:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     b00:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b03:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     b0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b0d:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     b14:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     b17:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     b1e:	eb 14                	jmp    b34 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b23:	8b 55 f0             	mov    -0x10(%ebp),%edx
     b26:	83 c2 08             	add    $0x8,%edx
     b29:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     b30:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b34:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     b38:	7e e6                	jle    b20 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     b3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b3d:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     b44:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     b47:	c9                   	leave  
     b48:	c3                   	ret    

00000b49 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     b49:	55                   	push   %ebp
     b4a:	89 e5                	mov    %esp,%ebp
     b4c:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b4f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b56:	eb 18                	jmp    b70 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     b58:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b5b:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     b61:	05 b0 16 00 00       	add    $0x16b0,%eax
     b66:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     b6c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     b70:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     b74:	7e e2                	jle    b58 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     b76:	e8 eb fe ff ff       	call   a66 <allocThread>
     b7b:	a3 a0 5f 00 00       	mov    %eax,0x5fa0
  if(currentThread==0)
     b80:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     b85:	85 c0                	test   %eax,%eax
     b87:	75 07                	jne    b90 <uthread_init+0x47>
    return -1;
     b89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b8e:	eb 6b                	jmp    bfb <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     b90:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     b95:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     b9c:	c7 44 24 04 83 0e 00 	movl   $0xe83,0x4(%esp)
     ba3:	00 
     ba4:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     bab:	e8 0c f9 ff ff       	call   4bc <signal>
     bb0:	85 c0                	test   %eax,%eax
     bb2:	79 19                	jns    bcd <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     bb4:	c7 44 24 04 3c 11 00 	movl   $0x113c,0x4(%esp)
     bbb:	00 
     bbc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bc3:	e8 e3 f9 ff ff       	call   5ab <printf>
    exit();
     bc8:	e8 2f f8 ff ff       	call   3fc <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     bcd:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     bd4:	e8 f3 f8 ff ff       	call   4cc <alarm>
     bd9:	85 c0                	test   %eax,%eax
     bdb:	79 19                	jns    bf6 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     bdd:	c7 44 24 04 5c 11 00 	movl   $0x115c,0x4(%esp)
     be4:	00 
     be5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bec:	e8 ba f9 ff ff       	call   5ab <printf>
    exit();
     bf1:	e8 06 f8 ff ff       	call   3fc <exit>
  }
  return 0;
     bf6:	b8 00 00 00 00       	mov    $0x0,%eax
}
     bfb:	c9                   	leave  
     bfc:	c3                   	ret    

00000bfd <wrap_func>:

void
wrap_func()
{
     bfd:	55                   	push   %ebp
     bfe:	89 e5                	mov    %esp,%ebp
     c00:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     c03:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     c08:	8b 50 18             	mov    0x18(%eax),%edx
     c0b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     c10:	8b 40 1c             	mov    0x1c(%eax),%eax
     c13:	89 04 24             	mov    %eax,(%esp)
     c16:	ff d2                	call   *%edx
  uthread_exit();
     c18:	e8 6c 00 00 00       	call   c89 <uthread_exit>
}
     c1d:	c9                   	leave  
     c1e:	c3                   	ret    

00000c1f <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     c1f:	55                   	push   %ebp
     c20:	89 e5                	mov    %esp,%ebp
     c22:	53                   	push   %ebx
     c23:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     c26:	e8 3b fe ff ff       	call   a66 <allocThread>
     c2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     c2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c32:	75 07                	jne    c3b <uthread_create+0x1c>
    return -1;
     c34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c39:	eb 48                	jmp    c83 <uthread_create+0x64>

  t->func=start_func;
     c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3e:	8b 55 08             	mov    0x8(%ebp),%edx
     c41:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c47:	8b 55 0c             	mov    0xc(%ebp),%edx
     c4a:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     c4d:	89 e3                	mov    %esp,%ebx
     c4f:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     c52:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c55:	8b 40 04             	mov    0x4(%eax),%eax
     c58:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5d:	8b 50 08             	mov    0x8(%eax),%edx
     c60:	b8 fd 0b 00 00       	mov    $0xbfd,%eax
     c65:	50                   	push   %eax
     c66:	52                   	push   %edx
     c67:	89 e2                	mov    %esp,%edx
     c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c6c:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     c6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c72:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c77:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c81:	8b 00                	mov    (%eax),%eax
}
     c83:	83 c4 14             	add    $0x14,%esp
     c86:	5b                   	pop    %ebx
     c87:	5d                   	pop    %ebp
     c88:	c3                   	ret    

00000c89 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     c89:	55                   	push   %ebp
     c8a:	89 e5                	mov    %esp,%ebp
     c8c:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     c8f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c96:	e8 31 f8 ff ff       	call   4cc <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ca2:	eb 51                	jmp    cf5 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     ca4:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     ca9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cac:	83 c2 08             	add    $0x8,%edx
     caf:	8b 04 90             	mov    (%eax,%edx,4),%eax
     cb2:	83 f8 01             	cmp    $0x1,%eax
     cb5:	75 3a                	jne    cf1 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cba:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     cc0:	05 c0 17 00 00       	add    $0x17c0,%eax
     cc5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     ccb:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     cd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cd3:	83 c2 08             	add    $0x8,%edx
     cd6:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ce0:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     ce6:	05 b0 16 00 00       	add    $0x16b0,%eax
     ceb:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     cf1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cf5:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     cf9:	7e a9                	jle    ca4 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     cfb:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d00:	8b 00                	mov    (%eax),%eax
     d02:	89 04 24             	mov    %eax,(%esp)
     d05:	e8 e3 fc ff ff       	call   9ed <getNextThread>
     d0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     d0d:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d12:	8b 00                	mov    (%eax),%eax
     d14:	85 c0                	test   %eax,%eax
     d16:	74 10                	je     d28 <uthread_exit+0x9f>
    free(currentThread->stack);
     d18:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d1d:	8b 40 0c             	mov    0xc(%eax),%eax
     d20:	89 04 24             	mov    %eax,(%esp)
     d23:	e8 38 fa ff ff       	call   760 <free>
  currentThread->tid=-1;
     d28:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d2d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     d33:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d38:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     d3f:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d44:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     d4b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d50:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     d57:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d5c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     d63:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d68:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     d6f:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d74:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     d7b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     d80:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     d87:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d8b:	78 7a                	js     e07 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     d8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d90:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d96:	05 a0 16 00 00       	add    $0x16a0,%eax
     d9b:	a3 a0 5f 00 00       	mov    %eax,0x5fa0
    currentThread->state=T_RUNNING;
     da0:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     da5:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     dac:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     db1:	8b 40 04             	mov    0x4(%eax),%eax
     db4:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     db6:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     dbb:	8b 40 08             	mov    0x8(%eax),%eax
     dbe:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     dc0:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     dc7:	e8 00 f7 ff ff       	call   4cc <alarm>
     dcc:	85 c0                	test   %eax,%eax
     dce:	79 19                	jns    de9 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     dd0:	c7 44 24 04 5c 11 00 	movl   $0x115c,0x4(%esp)
     dd7:	00 
     dd8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ddf:	e8 c7 f7 ff ff       	call   5ab <printf>
      exit();
     de4:	e8 13 f6 ff ff       	call   3fc <exit>
    }
    
    if(currentThread->firstTime==1)
     de9:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     dee:	8b 40 14             	mov    0x14(%eax),%eax
     df1:	83 f8 01             	cmp    $0x1,%eax
     df4:	75 10                	jne    e06 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     df6:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     dfb:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     e02:	5d                   	pop    %ebp
     e03:	c3                   	ret    
     e04:	eb 01                	jmp    e07 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     e06:	61                   	popa   
    }
  }
}
     e07:	c9                   	leave  
     e08:	c3                   	ret    

00000e09 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     e09:	55                   	push   %ebp
     e0a:	89 e5                	mov    %esp,%ebp
     e0c:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     e0f:	8b 45 08             	mov    0x8(%ebp),%eax
     e12:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e18:	05 a0 16 00 00       	add    $0x16a0,%eax
     e1d:	8b 40 10             	mov    0x10(%eax),%eax
     e20:	85 c0                	test   %eax,%eax
     e22:	75 07                	jne    e2b <uthread_join+0x22>
    return -1;
     e24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e29:	eb 56                	jmp    e81 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     e2b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e32:	e8 95 f6 ff ff       	call   4cc <alarm>
    currentThread->waitingFor=tid;
     e37:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e3c:	8b 55 08             	mov    0x8(%ebp),%edx
     e3f:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     e45:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e4a:	8b 08                	mov    (%eax),%ecx
     e4c:	8b 55 08             	mov    0x8(%ebp),%edx
     e4f:	89 d0                	mov    %edx,%eax
     e51:	c1 e0 03             	shl    $0x3,%eax
     e54:	01 d0                	add    %edx,%eax
     e56:	c1 e0 03             	shl    $0x3,%eax
     e59:	01 d0                	add    %edx,%eax
     e5b:	01 c8                	add    %ecx,%eax
     e5d:	83 c0 08             	add    $0x8,%eax
     e60:	c7 04 85 a0 16 00 00 	movl   $0x1,0x16a0(,%eax,4)
     e67:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     e6b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e70:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     e77:	e8 07 00 00 00       	call   e83 <uthread_yield>
    return 1;
     e7c:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     e81:	c9                   	leave  
     e82:	c3                   	ret    

00000e83 <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     e83:	55                   	push   %ebp
     e84:	89 e5                	mov    %esp,%ebp
     e86:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     e89:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e90:	e8 37 f6 ff ff       	call   4cc <alarm>
  int new=getNextThread(currentThread->tid);
     e95:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     e9a:	8b 00                	mov    (%eax),%eax
     e9c:	89 04 24             	mov    %eax,(%esp)
     e9f:	e8 49 fb ff ff       	call   9ed <getNextThread>
     ea4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     ea7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     eab:	75 2d                	jne    eda <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     ead:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     eb4:	e8 13 f6 ff ff       	call   4cc <alarm>
     eb9:	85 c0                	test   %eax,%eax
     ebb:	0f 89 c1 00 00 00    	jns    f82 <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     ec1:	c7 44 24 04 7c 11 00 	movl   $0x117c,0x4(%esp)
     ec8:	00 
     ec9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ed0:	e8 d6 f6 ff ff       	call   5ab <printf>
      exit();
     ed5:	e8 22 f5 ff ff       	call   3fc <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     eda:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     edb:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     ee0:	89 e2                	mov    %esp,%edx
     ee2:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     ee5:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     eea:	89 ea                	mov    %ebp,%edx
     eec:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     eef:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     ef4:	8b 40 10             	mov    0x10(%eax),%eax
     ef7:	83 f8 02             	cmp    $0x2,%eax
     efa:	75 0c                	jne    f08 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     efc:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f01:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     f08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f0b:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     f11:	05 a0 16 00 00       	add    $0x16a0,%eax
     f16:	a3 a0 5f 00 00       	mov    %eax,0x5fa0

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     f1b:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f20:	8b 40 04             	mov    0x4(%eax),%eax
     f23:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     f25:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f2a:	8b 40 08             	mov    0x8(%eax),%eax
     f2d:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     f2f:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     f36:	e8 91 f5 ff ff       	call   4cc <alarm>
     f3b:	85 c0                	test   %eax,%eax
     f3d:	79 19                	jns    f58 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     f3f:	c7 44 24 04 7c 11 00 	movl   $0x117c,0x4(%esp)
     f46:	00 
     f47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f4e:	e8 58 f6 ff ff       	call   5ab <printf>
      exit();
     f53:	e8 a4 f4 ff ff       	call   3fc <exit>
    }  
    currentThread->state=T_RUNNING;
     f58:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f5d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     f64:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f69:	8b 40 14             	mov    0x14(%eax),%eax
     f6c:	83 f8 01             	cmp    $0x1,%eax
     f6f:	75 10                	jne    f81 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     f71:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f76:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     f7d:	5d                   	pop    %ebp
     f7e:	c3                   	ret    
     f7f:	eb 01                	jmp    f82 <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     f81:	61                   	popa   
    }
  }
}
     f82:	c9                   	leave  
     f83:	c3                   	ret    

00000f84 <uthread_self>:

int
uthread_self(void)
{
     f84:	55                   	push   %ebp
     f85:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     f87:	a1 a0 5f 00 00       	mov    0x5fa0,%eax
     f8c:	8b 00                	mov    (%eax),%eax
     f8e:	5d                   	pop    %ebp
     f8f:	c3                   	ret    

00000f90 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	53                   	push   %ebx
     f94:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     f97:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f9a:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     f9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     fa0:	89 c3                	mov    %eax,%ebx
     fa2:	89 d8                	mov    %ebx,%eax
     fa4:	f0 87 02             	lock xchg %eax,(%edx)
     fa7:	89 c3                	mov    %eax,%ebx
     fa9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     fac:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     faf:	83 c4 10             	add    $0x10,%esp
     fb2:	5b                   	pop    %ebx
     fb3:	5d                   	pop    %ebp
     fb4:	c3                   	ret    

00000fb5 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
     fb5:	55                   	push   %ebp
     fb6:	89 e5                	mov    %esp,%ebp
     fb8:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
     fbb:	8b 45 08             	mov    0x8(%ebp),%eax
     fbe:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
     fc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fc9:	74 0c                	je     fd7 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
     fcb:	8b 45 08             	mov    0x8(%ebp),%eax
     fce:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
     fd5:	eb 0b                	jmp    fe2 <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
     fd7:	e8 a8 ff ff ff       	call   f84 <uthread_self>
     fdc:	8b 55 08             	mov    0x8(%ebp),%edx
     fdf:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
     fe2:	8b 55 0c             	mov    0xc(%ebp),%edx
     fe5:	8b 45 08             	mov    0x8(%ebp),%eax
     fe8:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
     fea:	8b 45 08             	mov    0x8(%ebp),%eax
     fed:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
     ff4:	c9                   	leave  
     ff5:	c3                   	ret    

00000ff6 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
     ff6:	55                   	push   %ebp
     ff7:	89 e5                	mov    %esp,%ebp
     ff9:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
     ffc:	8b 45 08             	mov    0x8(%ebp),%eax
     fff:	8b 40 08             	mov    0x8(%eax),%eax
    1002:	85 c0                	test   %eax,%eax
    1004:	75 20                	jne    1026 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    1006:	8b 45 08             	mov    0x8(%ebp),%eax
    1009:	8b 40 04             	mov    0x4(%eax),%eax
    100c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1010:	c7 44 24 04 a0 11 00 	movl   $0x11a0,0x4(%esp)
    1017:	00 
    1018:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    101f:	e8 87 f5 ff ff       	call   5ab <printf>
    return;
    1024:	eb 3a                	jmp    1060 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
    1026:	e8 59 ff ff ff       	call   f84 <uthread_self>
    102b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
    102e:	8b 45 08             	mov    0x8(%ebp),%eax
    1031:	8b 40 04             	mov    0x4(%eax),%eax
    1034:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1037:	74 27                	je     1060 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    1039:	eb 05                	jmp    1040 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
    103b:	e8 43 fe ff ff       	call   e83 <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
    1040:	8b 45 08             	mov    0x8(%ebp),%eax
    1043:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    104a:	00 
    104b:	89 04 24             	mov    %eax,(%esp)
    104e:	e8 3d ff ff ff       	call   f90 <xchg>
    1053:	85 c0                	test   %eax,%eax
    1055:	74 e4                	je     103b <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
    1057:	8b 45 08             	mov    0x8(%ebp),%eax
    105a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    105d:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
    1060:	c9                   	leave  
    1061:	c3                   	ret    

00001062 <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
    1062:	55                   	push   %ebp
    1063:	89 e5                	mov    %esp,%ebp
    1065:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
    1068:	8b 45 08             	mov    0x8(%ebp),%eax
    106b:	8b 40 08             	mov    0x8(%eax),%eax
    106e:	85 c0                	test   %eax,%eax
    1070:	75 20                	jne    1092 <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
    1072:	8b 45 08             	mov    0x8(%ebp),%eax
    1075:	8b 40 04             	mov    0x4(%eax),%eax
    1078:	89 44 24 08          	mov    %eax,0x8(%esp)
    107c:	c7 44 24 04 d0 11 00 	movl   $0x11d0,0x4(%esp)
    1083:	00 
    1084:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    108b:	e8 1b f5 ff ff       	call   5ab <printf>
    return;
    1090:	eb 2f                	jmp    10c1 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    1092:	e8 ed fe ff ff       	call   f84 <uthread_self>
    1097:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    109a:	8b 45 08             	mov    0x8(%ebp),%eax
    109d:	8b 00                	mov    (%eax),%eax
    109f:	85 c0                	test   %eax,%eax
    10a1:	75 1e                	jne    10c1 <binary_semaphore_up+0x5f>
    10a3:	8b 45 08             	mov    0x8(%ebp),%eax
    10a6:	8b 40 04             	mov    0x4(%eax),%eax
    10a9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    10ac:	75 13                	jne    10c1 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    10ae:	8b 45 08             	mov    0x8(%ebp),%eax
    10b1:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    10b8:	8b 45 08             	mov    0x8(%ebp),%eax
    10bb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    10c1:	c9                   	leave  
    10c2:	c3                   	ret    
