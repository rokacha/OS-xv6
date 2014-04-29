
_wait2test:     file format elf32-i386


Disassembly of section .text:

00000000 <foo>:
}
*/

void
foo()
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int i;
  for (i=0;i<100;i++)
       6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
       d:	eb 1f                	jmp    2e <foo+0x2e>
     printf(2, "wait test %d\n",i);
       f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      12:	89 44 24 08          	mov    %eax,0x8(%esp)
      16:	c7 44 24 04 38 10 00 	movl   $0x1038,0x4(%esp)
      1d:	00 
      1e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      25:	e8 f5 04 00 00       	call   51f <printf>

void
foo()
{
  int i;
  for (i=0;i<100;i++)
      2a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      2e:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
      32:	7e db                	jle    f <foo+0xf>
     printf(2, "wait test %d\n",i);
  sleep(20);
      34:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
      3b:	e8 c0 03 00 00       	call   400 <sleep>
  for (i=0;i<100;i++)
      40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      47:	eb 1f                	jmp    68 <foo+0x68>
     printf(2, "wait test %d\n",i);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	89 44 24 08          	mov    %eax,0x8(%esp)
      50:	c7 44 24 04 38 10 00 	movl   $0x1038,0x4(%esp)
      57:	00 
      58:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      5f:	e8 bb 04 00 00       	call   51f <printf>
{
  int i;
  for (i=0;i<100;i++)
     printf(2, "wait test %d\n",i);
  sleep(20);
  for (i=0;i<100;i++)
      64:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      68:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
      6c:	7e db                	jle    49 <foo+0x49>
     printf(2, "wait test %d\n",i);

}
      6e:	c9                   	leave  
      6f:	c3                   	ret    

00000070 <waittest>:

void
waittest(void)
{
      70:	55                   	push   %ebp
      71:	89 e5                	mov    %esp,%ebp
      73:	83 ec 38             	sub    $0x38,%esp
  int wTime;
  int rTime;
  int ioTime;
  int pid;
  printf(1, "wait test\n");
      76:	c7 44 24 04 46 10 00 	movl   $0x1046,0x4(%esp)
      7d:	00 
      7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      85:	e8 95 04 00 00       	call   51f <printf>


    pid = fork();
      8a:	e8 d9 02 00 00       	call   368 <fork>
      8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid == 0)
      92:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      96:	75 0a                	jne    a2 <waittest+0x32>
    {
      foo();
      98:	e8 63 ff ff ff       	call   0 <foo>
      exit();      
      9d:	e8 ce 02 00 00       	call   370 <exit>
    }
    wait2(&wTime,&rTime,&ioTime);
      a2:	8d 45 e8             	lea    -0x18(%ebp),%eax
      a5:	89 44 24 08          	mov    %eax,0x8(%esp)
      a9:	8d 45 ec             	lea    -0x14(%ebp),%eax
      ac:	89 44 24 04          	mov    %eax,0x4(%esp)
      b0:	8d 45 f0             	lea    -0x10(%ebp),%eax
      b3:	89 04 24             	mov    %eax,(%esp)
      b6:	e8 5d 03 00 00       	call   418 <wait2>
     printf(1, "hi \n");
      bb:	c7 44 24 04 51 10 00 	movl   $0x1051,0x4(%esp)
      c2:	00 
      c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      ca:	e8 50 04 00 00       	call   51f <printf>
    printf(1, "wTime: %d rTime: %d ioTime: %d \n",wTime,rTime, ioTime);
      cf:	8b 4d e8             	mov    -0x18(%ebp),%ecx
      d2:	8b 55 ec             	mov    -0x14(%ebp),%edx
      d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d8:	89 4c 24 10          	mov    %ecx,0x10(%esp)
      dc:	89 54 24 0c          	mov    %edx,0xc(%esp)
      e0:	89 44 24 08          	mov    %eax,0x8(%esp)
      e4:	c7 44 24 04 58 10 00 	movl   $0x1058,0x4(%esp)
      eb:	00 
      ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      f3:	e8 27 04 00 00       	call   51f <printf>

}
      f8:	c9                   	leave  
      f9:	c3                   	ret    

000000fa <main>:
int
main(void)
{
      fa:	55                   	push   %ebp
      fb:	89 e5                	mov    %esp,%ebp
      fd:	83 e4 f0             	and    $0xfffffff0,%esp
  waittest();
     100:	e8 6b ff ff ff       	call   70 <waittest>
  exit();
     105:	e8 66 02 00 00       	call   370 <exit>
     10a:	90                   	nop
     10b:	90                   	nop

0000010c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     10c:	55                   	push   %ebp
     10d:	89 e5                	mov    %esp,%ebp
     10f:	57                   	push   %edi
     110:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     111:	8b 4d 08             	mov    0x8(%ebp),%ecx
     114:	8b 55 10             	mov    0x10(%ebp),%edx
     117:	8b 45 0c             	mov    0xc(%ebp),%eax
     11a:	89 cb                	mov    %ecx,%ebx
     11c:	89 df                	mov    %ebx,%edi
     11e:	89 d1                	mov    %edx,%ecx
     120:	fc                   	cld    
     121:	f3 aa                	rep stos %al,%es:(%edi)
     123:	89 ca                	mov    %ecx,%edx
     125:	89 fb                	mov    %edi,%ebx
     127:	89 5d 08             	mov    %ebx,0x8(%ebp)
     12a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     12d:	5b                   	pop    %ebx
     12e:	5f                   	pop    %edi
     12f:	5d                   	pop    %ebp
     130:	c3                   	ret    

00000131 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     131:	55                   	push   %ebp
     132:	89 e5                	mov    %esp,%ebp
     134:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     137:	8b 45 08             	mov    0x8(%ebp),%eax
     13a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     13d:	90                   	nop
     13e:	8b 45 0c             	mov    0xc(%ebp),%eax
     141:	0f b6 10             	movzbl (%eax),%edx
     144:	8b 45 08             	mov    0x8(%ebp),%eax
     147:	88 10                	mov    %dl,(%eax)
     149:	8b 45 08             	mov    0x8(%ebp),%eax
     14c:	0f b6 00             	movzbl (%eax),%eax
     14f:	84 c0                	test   %al,%al
     151:	0f 95 c0             	setne  %al
     154:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     158:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     15c:	84 c0                	test   %al,%al
     15e:	75 de                	jne    13e <strcpy+0xd>
    ;
  return os;
     160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     163:	c9                   	leave  
     164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     165:	55                   	push   %ebp
     166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
     16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     172:	8b 45 08             	mov    0x8(%ebp),%eax
     175:	0f b6 00             	movzbl (%eax),%eax
     178:	84 c0                	test   %al,%al
     17a:	74 10                	je     18c <strcmp+0x27>
     17c:	8b 45 08             	mov    0x8(%ebp),%eax
     17f:	0f b6 10             	movzbl (%eax),%edx
     182:	8b 45 0c             	mov    0xc(%ebp),%eax
     185:	0f b6 00             	movzbl (%eax),%eax
     188:	38 c2                	cmp    %al,%dl
     18a:	74 de                	je     16a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     18c:	8b 45 08             	mov    0x8(%ebp),%eax
     18f:	0f b6 00             	movzbl (%eax),%eax
     192:	0f b6 d0             	movzbl %al,%edx
     195:	8b 45 0c             	mov    0xc(%ebp),%eax
     198:	0f b6 00             	movzbl (%eax),%eax
     19b:	0f b6 c0             	movzbl %al,%eax
     19e:	89 d1                	mov    %edx,%ecx
     1a0:	29 c1                	sub    %eax,%ecx
     1a2:	89 c8                	mov    %ecx,%eax
}
     1a4:	5d                   	pop    %ebp
     1a5:	c3                   	ret    

000001a6 <strlen>:

uint
strlen(char *s)
{
     1a6:	55                   	push   %ebp
     1a7:	89 e5                	mov    %esp,%ebp
     1a9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1b3:	eb 04                	jmp    1b9 <strlen+0x13>
     1b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     1bc:	03 45 08             	add    0x8(%ebp),%eax
     1bf:	0f b6 00             	movzbl (%eax),%eax
     1c2:	84 c0                	test   %al,%al
     1c4:	75 ef                	jne    1b5 <strlen+0xf>
    ;
  return n;
     1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1c9:	c9                   	leave  
     1ca:	c3                   	ret    

000001cb <memset>:

void*
memset(void *dst, int c, uint n)
{
     1cb:	55                   	push   %ebp
     1cc:	89 e5                	mov    %esp,%ebp
     1ce:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     1d1:	8b 45 10             	mov    0x10(%ebp),%eax
     1d4:	89 44 24 08          	mov    %eax,0x8(%esp)
     1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
     1db:	89 44 24 04          	mov    %eax,0x4(%esp)
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	89 04 24             	mov    %eax,(%esp)
     1e5:	e8 22 ff ff ff       	call   10c <stosb>
  return dst;
     1ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1ed:	c9                   	leave  
     1ee:	c3                   	ret    

000001ef <strchr>:

char*
strchr(const char *s, char c)
{
     1ef:	55                   	push   %ebp
     1f0:	89 e5                	mov    %esp,%ebp
     1f2:	83 ec 04             	sub    $0x4,%esp
     1f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     1f8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1fb:	eb 14                	jmp    211 <strchr+0x22>
    if(*s == c)
     1fd:	8b 45 08             	mov    0x8(%ebp),%eax
     200:	0f b6 00             	movzbl (%eax),%eax
     203:	3a 45 fc             	cmp    -0x4(%ebp),%al
     206:	75 05                	jne    20d <strchr+0x1e>
      return (char*)s;
     208:	8b 45 08             	mov    0x8(%ebp),%eax
     20b:	eb 13                	jmp    220 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     20d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     211:	8b 45 08             	mov    0x8(%ebp),%eax
     214:	0f b6 00             	movzbl (%eax),%eax
     217:	84 c0                	test   %al,%al
     219:	75 e2                	jne    1fd <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     21b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     220:	c9                   	leave  
     221:	c3                   	ret    

00000222 <gets>:

char*
gets(char *buf, int max)
{
     222:	55                   	push   %ebp
     223:	89 e5                	mov    %esp,%ebp
     225:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     228:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     22f:	eb 44                	jmp    275 <gets+0x53>
    cc = read(0, &c, 1);
     231:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     238:	00 
     239:	8d 45 ef             	lea    -0x11(%ebp),%eax
     23c:	89 44 24 04          	mov    %eax,0x4(%esp)
     240:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     247:	e8 3c 01 00 00       	call   388 <read>
     24c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     24f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     253:	7e 2d                	jle    282 <gets+0x60>
      break;
    buf[i++] = c;
     255:	8b 45 f4             	mov    -0xc(%ebp),%eax
     258:	03 45 08             	add    0x8(%ebp),%eax
     25b:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     25f:	88 10                	mov    %dl,(%eax)
     261:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     265:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     269:	3c 0a                	cmp    $0xa,%al
     26b:	74 16                	je     283 <gets+0x61>
     26d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     271:	3c 0d                	cmp    $0xd,%al
     273:	74 0e                	je     283 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     275:	8b 45 f4             	mov    -0xc(%ebp),%eax
     278:	83 c0 01             	add    $0x1,%eax
     27b:	3b 45 0c             	cmp    0xc(%ebp),%eax
     27e:	7c b1                	jl     231 <gets+0xf>
     280:	eb 01                	jmp    283 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     282:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     283:	8b 45 f4             	mov    -0xc(%ebp),%eax
     286:	03 45 08             	add    0x8(%ebp),%eax
     289:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     28f:	c9                   	leave  
     290:	c3                   	ret    

00000291 <stat>:

int
stat(char *n, struct stat *st)
{
     291:	55                   	push   %ebp
     292:	89 e5                	mov    %esp,%ebp
     294:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     297:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     29e:	00 
     29f:	8b 45 08             	mov    0x8(%ebp),%eax
     2a2:	89 04 24             	mov    %eax,(%esp)
     2a5:	e8 06 01 00 00       	call   3b0 <open>
     2aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2b1:	79 07                	jns    2ba <stat+0x29>
    return -1;
     2b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2b8:	eb 23                	jmp    2dd <stat+0x4c>
  r = fstat(fd, st);
     2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
     2bd:	89 44 24 04          	mov    %eax,0x4(%esp)
     2c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2c4:	89 04 24             	mov    %eax,(%esp)
     2c7:	e8 fc 00 00 00       	call   3c8 <fstat>
     2cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2d2:	89 04 24             	mov    %eax,(%esp)
     2d5:	e8 be 00 00 00       	call   398 <close>
  return r;
     2da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2dd:	c9                   	leave  
     2de:	c3                   	ret    

000002df <atoi>:

int
atoi(const char *s)
{
     2df:	55                   	push   %ebp
     2e0:	89 e5                	mov    %esp,%ebp
     2e2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2ec:	eb 23                	jmp    311 <atoi+0x32>
    n = n*10 + *s++ - '0';
     2ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2f1:	89 d0                	mov    %edx,%eax
     2f3:	c1 e0 02             	shl    $0x2,%eax
     2f6:	01 d0                	add    %edx,%eax
     2f8:	01 c0                	add    %eax,%eax
     2fa:	89 c2                	mov    %eax,%edx
     2fc:	8b 45 08             	mov    0x8(%ebp),%eax
     2ff:	0f b6 00             	movzbl (%eax),%eax
     302:	0f be c0             	movsbl %al,%eax
     305:	01 d0                	add    %edx,%eax
     307:	83 e8 30             	sub    $0x30,%eax
     30a:	89 45 fc             	mov    %eax,-0x4(%ebp)
     30d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     311:	8b 45 08             	mov    0x8(%ebp),%eax
     314:	0f b6 00             	movzbl (%eax),%eax
     317:	3c 2f                	cmp    $0x2f,%al
     319:	7e 0a                	jle    325 <atoi+0x46>
     31b:	8b 45 08             	mov    0x8(%ebp),%eax
     31e:	0f b6 00             	movzbl (%eax),%eax
     321:	3c 39                	cmp    $0x39,%al
     323:	7e c9                	jle    2ee <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     325:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     328:	c9                   	leave  
     329:	c3                   	ret    

0000032a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     32a:	55                   	push   %ebp
     32b:	89 e5                	mov    %esp,%ebp
     32d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     330:	8b 45 08             	mov    0x8(%ebp),%eax
     333:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     336:	8b 45 0c             	mov    0xc(%ebp),%eax
     339:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     33c:	eb 13                	jmp    351 <memmove+0x27>
    *dst++ = *src++;
     33e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     341:	0f b6 10             	movzbl (%eax),%edx
     344:	8b 45 fc             	mov    -0x4(%ebp),%eax
     347:	88 10                	mov    %dl,(%eax)
     349:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     34d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     351:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     355:	0f 9f c0             	setg   %al
     358:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     35c:	84 c0                	test   %al,%al
     35e:	75 de                	jne    33e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     360:	8b 45 08             	mov    0x8(%ebp),%eax
}
     363:	c9                   	leave  
     364:	c3                   	ret    
     365:	90                   	nop
     366:	90                   	nop
     367:	90                   	nop

00000368 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     368:	b8 01 00 00 00       	mov    $0x1,%eax
     36d:	cd 40                	int    $0x40
     36f:	c3                   	ret    

00000370 <exit>:
SYSCALL(exit)
     370:	b8 02 00 00 00       	mov    $0x2,%eax
     375:	cd 40                	int    $0x40
     377:	c3                   	ret    

00000378 <wait>:
SYSCALL(wait)
     378:	b8 03 00 00 00       	mov    $0x3,%eax
     37d:	cd 40                	int    $0x40
     37f:	c3                   	ret    

00000380 <pipe>:
SYSCALL(pipe)
     380:	b8 04 00 00 00       	mov    $0x4,%eax
     385:	cd 40                	int    $0x40
     387:	c3                   	ret    

00000388 <read>:
SYSCALL(read)
     388:	b8 05 00 00 00       	mov    $0x5,%eax
     38d:	cd 40                	int    $0x40
     38f:	c3                   	ret    

00000390 <write>:
SYSCALL(write)
     390:	b8 10 00 00 00       	mov    $0x10,%eax
     395:	cd 40                	int    $0x40
     397:	c3                   	ret    

00000398 <close>:
SYSCALL(close)
     398:	b8 15 00 00 00       	mov    $0x15,%eax
     39d:	cd 40                	int    $0x40
     39f:	c3                   	ret    

000003a0 <kill>:
SYSCALL(kill)
     3a0:	b8 06 00 00 00       	mov    $0x6,%eax
     3a5:	cd 40                	int    $0x40
     3a7:	c3                   	ret    

000003a8 <exec>:
SYSCALL(exec)
     3a8:	b8 07 00 00 00       	mov    $0x7,%eax
     3ad:	cd 40                	int    $0x40
     3af:	c3                   	ret    

000003b0 <open>:
SYSCALL(open)
     3b0:	b8 0f 00 00 00       	mov    $0xf,%eax
     3b5:	cd 40                	int    $0x40
     3b7:	c3                   	ret    

000003b8 <mknod>:
SYSCALL(mknod)
     3b8:	b8 11 00 00 00       	mov    $0x11,%eax
     3bd:	cd 40                	int    $0x40
     3bf:	c3                   	ret    

000003c0 <unlink>:
SYSCALL(unlink)
     3c0:	b8 12 00 00 00       	mov    $0x12,%eax
     3c5:	cd 40                	int    $0x40
     3c7:	c3                   	ret    

000003c8 <fstat>:
SYSCALL(fstat)
     3c8:	b8 08 00 00 00       	mov    $0x8,%eax
     3cd:	cd 40                	int    $0x40
     3cf:	c3                   	ret    

000003d0 <link>:
SYSCALL(link)
     3d0:	b8 13 00 00 00       	mov    $0x13,%eax
     3d5:	cd 40                	int    $0x40
     3d7:	c3                   	ret    

000003d8 <mkdir>:
SYSCALL(mkdir)
     3d8:	b8 14 00 00 00       	mov    $0x14,%eax
     3dd:	cd 40                	int    $0x40
     3df:	c3                   	ret    

000003e0 <chdir>:
SYSCALL(chdir)
     3e0:	b8 09 00 00 00       	mov    $0x9,%eax
     3e5:	cd 40                	int    $0x40
     3e7:	c3                   	ret    

000003e8 <dup>:
SYSCALL(dup)
     3e8:	b8 0a 00 00 00       	mov    $0xa,%eax
     3ed:	cd 40                	int    $0x40
     3ef:	c3                   	ret    

000003f0 <getpid>:
SYSCALL(getpid)
     3f0:	b8 0b 00 00 00       	mov    $0xb,%eax
     3f5:	cd 40                	int    $0x40
     3f7:	c3                   	ret    

000003f8 <sbrk>:
SYSCALL(sbrk)
     3f8:	b8 0c 00 00 00       	mov    $0xc,%eax
     3fd:	cd 40                	int    $0x40
     3ff:	c3                   	ret    

00000400 <sleep>:
SYSCALL(sleep)
     400:	b8 0d 00 00 00       	mov    $0xd,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <uptime>:
SYSCALL(uptime)
     408:	b8 0e 00 00 00       	mov    $0xe,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <add_path>:
SYSCALL(add_path)
     410:	b8 16 00 00 00       	mov    $0x16,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <wait2>:
SYSCALL(wait2)
     418:	b8 17 00 00 00       	mov    $0x17,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <getquanta>:
SYSCALL(getquanta)
     420:	b8 18 00 00 00       	mov    $0x18,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <getqueue>:
SYSCALL(getqueue)
     428:	b8 19 00 00 00       	mov    $0x19,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <signal>:
SYSCALL(signal)
     430:	b8 1a 00 00 00       	mov    $0x1a,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <sigsend>:
SYSCALL(sigsend)
     438:	b8 1b 00 00 00       	mov    $0x1b,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <alarm>:
SYSCALL(alarm)
     440:	b8 1c 00 00 00       	mov    $0x1c,%eax
     445:	cd 40                	int    $0x40
     447:	c3                   	ret    

00000448 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     448:	55                   	push   %ebp
     449:	89 e5                	mov    %esp,%ebp
     44b:	83 ec 28             	sub    $0x28,%esp
     44e:	8b 45 0c             	mov    0xc(%ebp),%eax
     451:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     454:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     45b:	00 
     45c:	8d 45 f4             	lea    -0xc(%ebp),%eax
     45f:	89 44 24 04          	mov    %eax,0x4(%esp)
     463:	8b 45 08             	mov    0x8(%ebp),%eax
     466:	89 04 24             	mov    %eax,(%esp)
     469:	e8 22 ff ff ff       	call   390 <write>
}
     46e:	c9                   	leave  
     46f:	c3                   	ret    

00000470 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     476:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     47d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     481:	74 17                	je     49a <printint+0x2a>
     483:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     487:	79 11                	jns    49a <printint+0x2a>
    neg = 1;
     489:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     490:	8b 45 0c             	mov    0xc(%ebp),%eax
     493:	f7 d8                	neg    %eax
     495:	89 45 ec             	mov    %eax,-0x14(%ebp)
     498:	eb 06                	jmp    4a0 <printint+0x30>
  } else {
    x = xx;
     49a:	8b 45 0c             	mov    0xc(%ebp),%eax
     49d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4ad:	ba 00 00 00 00       	mov    $0x0,%edx
     4b2:	f7 f1                	div    %ecx
     4b4:	89 d0                	mov    %edx,%eax
     4b6:	0f b6 90 b0 15 00 00 	movzbl 0x15b0(%eax),%edx
     4bd:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4c0:	03 45 f4             	add    -0xc(%ebp),%eax
     4c3:	88 10                	mov    %dl,(%eax)
     4c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     4c9:	8b 55 10             	mov    0x10(%ebp),%edx
     4cc:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     4cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4d2:	ba 00 00 00 00       	mov    $0x0,%edx
     4d7:	f7 75 d4             	divl   -0x2c(%ebp)
     4da:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e1:	75 c4                	jne    4a7 <printint+0x37>
  if(neg)
     4e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4e7:	74 2a                	je     513 <printint+0xa3>
    buf[i++] = '-';
     4e9:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4ec:	03 45 f4             	add    -0xc(%ebp),%eax
     4ef:	c6 00 2d             	movb   $0x2d,(%eax)
     4f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     4f6:	eb 1b                	jmp    513 <printint+0xa3>
    putc(fd, buf[i]);
     4f8:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4fb:	03 45 f4             	add    -0xc(%ebp),%eax
     4fe:	0f b6 00             	movzbl (%eax),%eax
     501:	0f be c0             	movsbl %al,%eax
     504:	89 44 24 04          	mov    %eax,0x4(%esp)
     508:	8b 45 08             	mov    0x8(%ebp),%eax
     50b:	89 04 24             	mov    %eax,(%esp)
     50e:	e8 35 ff ff ff       	call   448 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     513:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     517:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     51b:	79 db                	jns    4f8 <printint+0x88>
    putc(fd, buf[i]);
}
     51d:	c9                   	leave  
     51e:	c3                   	ret    

0000051f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     51f:	55                   	push   %ebp
     520:	89 e5                	mov    %esp,%ebp
     522:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     525:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     52c:	8d 45 0c             	lea    0xc(%ebp),%eax
     52f:	83 c0 04             	add    $0x4,%eax
     532:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     535:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     53c:	e9 7d 01 00 00       	jmp    6be <printf+0x19f>
    c = fmt[i] & 0xff;
     541:	8b 55 0c             	mov    0xc(%ebp),%edx
     544:	8b 45 f0             	mov    -0x10(%ebp),%eax
     547:	01 d0                	add    %edx,%eax
     549:	0f b6 00             	movzbl (%eax),%eax
     54c:	0f be c0             	movsbl %al,%eax
     54f:	25 ff 00 00 00       	and    $0xff,%eax
     554:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     557:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     55b:	75 2c                	jne    589 <printf+0x6a>
      if(c == '%'){
     55d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     561:	75 0c                	jne    56f <printf+0x50>
        state = '%';
     563:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     56a:	e9 4b 01 00 00       	jmp    6ba <printf+0x19b>
      } else {
        putc(fd, c);
     56f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     572:	0f be c0             	movsbl %al,%eax
     575:	89 44 24 04          	mov    %eax,0x4(%esp)
     579:	8b 45 08             	mov    0x8(%ebp),%eax
     57c:	89 04 24             	mov    %eax,(%esp)
     57f:	e8 c4 fe ff ff       	call   448 <putc>
     584:	e9 31 01 00 00       	jmp    6ba <printf+0x19b>
      }
    } else if(state == '%'){
     589:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     58d:	0f 85 27 01 00 00    	jne    6ba <printf+0x19b>
      if(c == 'd'){
     593:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     597:	75 2d                	jne    5c6 <printf+0xa7>
        printint(fd, *ap, 10, 1);
     599:	8b 45 e8             	mov    -0x18(%ebp),%eax
     59c:	8b 00                	mov    (%eax),%eax
     59e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     5a5:	00 
     5a6:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     5ad:	00 
     5ae:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b2:	8b 45 08             	mov    0x8(%ebp),%eax
     5b5:	89 04 24             	mov    %eax,(%esp)
     5b8:	e8 b3 fe ff ff       	call   470 <printint>
        ap++;
     5bd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c1:	e9 ed 00 00 00       	jmp    6b3 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     5c6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5ca:	74 06                	je     5d2 <printf+0xb3>
     5cc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5d0:	75 2d                	jne    5ff <printf+0xe0>
        printint(fd, *ap, 16, 0);
     5d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d5:	8b 00                	mov    (%eax),%eax
     5d7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5de:	00 
     5df:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     5e6:	00 
     5e7:	89 44 24 04          	mov    %eax,0x4(%esp)
     5eb:	8b 45 08             	mov    0x8(%ebp),%eax
     5ee:	89 04 24             	mov    %eax,(%esp)
     5f1:	e8 7a fe ff ff       	call   470 <printint>
        ap++;
     5f6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5fa:	e9 b4 00 00 00       	jmp    6b3 <printf+0x194>
      } else if(c == 's'){
     5ff:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     603:	75 46                	jne    64b <printf+0x12c>
        s = (char*)*ap;
     605:	8b 45 e8             	mov    -0x18(%ebp),%eax
     608:	8b 00                	mov    (%eax),%eax
     60a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     60d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     611:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     615:	75 27                	jne    63e <printf+0x11f>
          s = "(null)";
     617:	c7 45 f4 79 10 00 00 	movl   $0x1079,-0xc(%ebp)
        while(*s != 0){
     61e:	eb 1e                	jmp    63e <printf+0x11f>
          putc(fd, *s);
     620:	8b 45 f4             	mov    -0xc(%ebp),%eax
     623:	0f b6 00             	movzbl (%eax),%eax
     626:	0f be c0             	movsbl %al,%eax
     629:	89 44 24 04          	mov    %eax,0x4(%esp)
     62d:	8b 45 08             	mov    0x8(%ebp),%eax
     630:	89 04 24             	mov    %eax,(%esp)
     633:	e8 10 fe ff ff       	call   448 <putc>
          s++;
     638:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     63c:	eb 01                	jmp    63f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     63e:	90                   	nop
     63f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     642:	0f b6 00             	movzbl (%eax),%eax
     645:	84 c0                	test   %al,%al
     647:	75 d7                	jne    620 <printf+0x101>
     649:	eb 68                	jmp    6b3 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     64b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     64f:	75 1d                	jne    66e <printf+0x14f>
        putc(fd, *ap);
     651:	8b 45 e8             	mov    -0x18(%ebp),%eax
     654:	8b 00                	mov    (%eax),%eax
     656:	0f be c0             	movsbl %al,%eax
     659:	89 44 24 04          	mov    %eax,0x4(%esp)
     65d:	8b 45 08             	mov    0x8(%ebp),%eax
     660:	89 04 24             	mov    %eax,(%esp)
     663:	e8 e0 fd ff ff       	call   448 <putc>
        ap++;
     668:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     66c:	eb 45                	jmp    6b3 <printf+0x194>
      } else if(c == '%'){
     66e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     672:	75 17                	jne    68b <printf+0x16c>
        putc(fd, c);
     674:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     677:	0f be c0             	movsbl %al,%eax
     67a:	89 44 24 04          	mov    %eax,0x4(%esp)
     67e:	8b 45 08             	mov    0x8(%ebp),%eax
     681:	89 04 24             	mov    %eax,(%esp)
     684:	e8 bf fd ff ff       	call   448 <putc>
     689:	eb 28                	jmp    6b3 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     68b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     692:	00 
     693:	8b 45 08             	mov    0x8(%ebp),%eax
     696:	89 04 24             	mov    %eax,(%esp)
     699:	e8 aa fd ff ff       	call   448 <putc>
        putc(fd, c);
     69e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6a1:	0f be c0             	movsbl %al,%eax
     6a4:	89 44 24 04          	mov    %eax,0x4(%esp)
     6a8:	8b 45 08             	mov    0x8(%ebp),%eax
     6ab:	89 04 24             	mov    %eax,(%esp)
     6ae:	e8 95 fd ff ff       	call   448 <putc>
      }
      state = 0;
     6b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6be:	8b 55 0c             	mov    0xc(%ebp),%edx
     6c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6c4:	01 d0                	add    %edx,%eax
     6c6:	0f b6 00             	movzbl (%eax),%eax
     6c9:	84 c0                	test   %al,%al
     6cb:	0f 85 70 fe ff ff    	jne    541 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6d1:	c9                   	leave  
     6d2:	c3                   	ret    
     6d3:	90                   	nop

000006d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6d4:	55                   	push   %ebp
     6d5:	89 e5                	mov    %esp,%ebp
     6d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6da:	8b 45 08             	mov    0x8(%ebp),%eax
     6dd:	83 e8 08             	sub    $0x8,%eax
     6e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6e3:	a1 e8 15 00 00       	mov    0x15e8,%eax
     6e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6eb:	eb 24                	jmp    711 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f0:	8b 00                	mov    (%eax),%eax
     6f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6f5:	77 12                	ja     709 <free+0x35>
     6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6fd:	77 24                	ja     723 <free+0x4f>
     6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     702:	8b 00                	mov    (%eax),%eax
     704:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     707:	77 1a                	ja     723 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     709:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70c:	8b 00                	mov    (%eax),%eax
     70e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     711:	8b 45 f8             	mov    -0x8(%ebp),%eax
     714:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     717:	76 d4                	jbe    6ed <free+0x19>
     719:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71c:	8b 00                	mov    (%eax),%eax
     71e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     721:	76 ca                	jbe    6ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     723:	8b 45 f8             	mov    -0x8(%ebp),%eax
     726:	8b 40 04             	mov    0x4(%eax),%eax
     729:	c1 e0 03             	shl    $0x3,%eax
     72c:	89 c2                	mov    %eax,%edx
     72e:	03 55 f8             	add    -0x8(%ebp),%edx
     731:	8b 45 fc             	mov    -0x4(%ebp),%eax
     734:	8b 00                	mov    (%eax),%eax
     736:	39 c2                	cmp    %eax,%edx
     738:	75 24                	jne    75e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     73a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73d:	8b 50 04             	mov    0x4(%eax),%edx
     740:	8b 45 fc             	mov    -0x4(%ebp),%eax
     743:	8b 00                	mov    (%eax),%eax
     745:	8b 40 04             	mov    0x4(%eax),%eax
     748:	01 c2                	add    %eax,%edx
     74a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     74d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     750:	8b 45 fc             	mov    -0x4(%ebp),%eax
     753:	8b 00                	mov    (%eax),%eax
     755:	8b 10                	mov    (%eax),%edx
     757:	8b 45 f8             	mov    -0x8(%ebp),%eax
     75a:	89 10                	mov    %edx,(%eax)
     75c:	eb 0a                	jmp    768 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     75e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     761:	8b 10                	mov    (%eax),%edx
     763:	8b 45 f8             	mov    -0x8(%ebp),%eax
     766:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     768:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76b:	8b 40 04             	mov    0x4(%eax),%eax
     76e:	c1 e0 03             	shl    $0x3,%eax
     771:	03 45 fc             	add    -0x4(%ebp),%eax
     774:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     777:	75 20                	jne    799 <free+0xc5>
    p->s.size += bp->s.size;
     779:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77c:	8b 50 04             	mov    0x4(%eax),%edx
     77f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     782:	8b 40 04             	mov    0x4(%eax),%eax
     785:	01 c2                	add    %eax,%edx
     787:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     78d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     790:	8b 10                	mov    (%eax),%edx
     792:	8b 45 fc             	mov    -0x4(%ebp),%eax
     795:	89 10                	mov    %edx,(%eax)
     797:	eb 08                	jmp    7a1 <free+0xcd>
  } else
    p->s.ptr = bp;
     799:	8b 45 fc             	mov    -0x4(%ebp),%eax
     79c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     79f:	89 10                	mov    %edx,(%eax)
  freep = p;
     7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a4:	a3 e8 15 00 00       	mov    %eax,0x15e8
}
     7a9:	c9                   	leave  
     7aa:	c3                   	ret    

000007ab <morecore>:

static Header*
morecore(uint nu)
{
     7ab:	55                   	push   %ebp
     7ac:	89 e5                	mov    %esp,%ebp
     7ae:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7b1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7b8:	77 07                	ja     7c1 <morecore+0x16>
    nu = 4096;
     7ba:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7c1:	8b 45 08             	mov    0x8(%ebp),%eax
     7c4:	c1 e0 03             	shl    $0x3,%eax
     7c7:	89 04 24             	mov    %eax,(%esp)
     7ca:	e8 29 fc ff ff       	call   3f8 <sbrk>
     7cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7d2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7d6:	75 07                	jne    7df <morecore+0x34>
    return 0;
     7d8:	b8 00 00 00 00       	mov    $0x0,%eax
     7dd:	eb 22                	jmp    801 <morecore+0x56>
  hp = (Header*)p;
     7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e8:	8b 55 08             	mov    0x8(%ebp),%edx
     7eb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f1:	83 c0 08             	add    $0x8,%eax
     7f4:	89 04 24             	mov    %eax,(%esp)
     7f7:	e8 d8 fe ff ff       	call   6d4 <free>
  return freep;
     7fc:	a1 e8 15 00 00       	mov    0x15e8,%eax
}
     801:	c9                   	leave  
     802:	c3                   	ret    

00000803 <malloc>:

void*
malloc(uint nbytes)
{
     803:	55                   	push   %ebp
     804:	89 e5                	mov    %esp,%ebp
     806:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     809:	8b 45 08             	mov    0x8(%ebp),%eax
     80c:	83 c0 07             	add    $0x7,%eax
     80f:	c1 e8 03             	shr    $0x3,%eax
     812:	83 c0 01             	add    $0x1,%eax
     815:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     818:	a1 e8 15 00 00       	mov    0x15e8,%eax
     81d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     820:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     824:	75 23                	jne    849 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     826:	c7 45 f0 e0 15 00 00 	movl   $0x15e0,-0x10(%ebp)
     82d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     830:	a3 e8 15 00 00       	mov    %eax,0x15e8
     835:	a1 e8 15 00 00       	mov    0x15e8,%eax
     83a:	a3 e0 15 00 00       	mov    %eax,0x15e0
    base.s.size = 0;
     83f:	c7 05 e4 15 00 00 00 	movl   $0x0,0x15e4
     846:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     849:	8b 45 f0             	mov    -0x10(%ebp),%eax
     84c:	8b 00                	mov    (%eax),%eax
     84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     851:	8b 45 f4             	mov    -0xc(%ebp),%eax
     854:	8b 40 04             	mov    0x4(%eax),%eax
     857:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     85a:	72 4d                	jb     8a9 <malloc+0xa6>
      if(p->s.size == nunits)
     85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85f:	8b 40 04             	mov    0x4(%eax),%eax
     862:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     865:	75 0c                	jne    873 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     867:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86a:	8b 10                	mov    (%eax),%edx
     86c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86f:	89 10                	mov    %edx,(%eax)
     871:	eb 26                	jmp    899 <malloc+0x96>
      else {
        p->s.size -= nunits;
     873:	8b 45 f4             	mov    -0xc(%ebp),%eax
     876:	8b 40 04             	mov    0x4(%eax),%eax
     879:	89 c2                	mov    %eax,%edx
     87b:	2b 55 ec             	sub    -0x14(%ebp),%edx
     87e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     881:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     884:	8b 45 f4             	mov    -0xc(%ebp),%eax
     887:	8b 40 04             	mov    0x4(%eax),%eax
     88a:	c1 e0 03             	shl    $0x3,%eax
     88d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     890:	8b 45 f4             	mov    -0xc(%ebp),%eax
     893:	8b 55 ec             	mov    -0x14(%ebp),%edx
     896:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     899:	8b 45 f0             	mov    -0x10(%ebp),%eax
     89c:	a3 e8 15 00 00       	mov    %eax,0x15e8
      return (void*)(p + 1);
     8a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a4:	83 c0 08             	add    $0x8,%eax
     8a7:	eb 38                	jmp    8e1 <malloc+0xde>
    }
    if(p == freep)
     8a9:	a1 e8 15 00 00       	mov    0x15e8,%eax
     8ae:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8b1:	75 1b                	jne    8ce <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     8b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     8b6:	89 04 24             	mov    %eax,(%esp)
     8b9:	e8 ed fe ff ff       	call   7ab <morecore>
     8be:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8c5:	75 07                	jne    8ce <malloc+0xcb>
        return 0;
     8c7:	b8 00 00 00 00       	mov    $0x0,%eax
     8cc:	eb 13                	jmp    8e1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d7:	8b 00                	mov    (%eax),%eax
     8d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8dc:	e9 70 ff ff ff       	jmp    851 <malloc+0x4e>
}
     8e1:	c9                   	leave  
     8e2:	c3                   	ret    
     8e3:	90                   	nop

000008e4 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     8e4:	55                   	push   %ebp
     8e5:	89 e5                	mov    %esp,%ebp
     8e7:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     8ea:	a1 00 5f 00 00       	mov    0x5f00,%eax
     8ef:	8b 40 04             	mov    0x4(%eax),%eax
     8f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     8f5:	a1 00 5f 00 00       	mov    0x5f00,%eax
     8fa:	8b 00                	mov    (%eax),%eax
     8fc:	89 44 24 08          	mov    %eax,0x8(%esp)
     900:	c7 44 24 04 80 10 00 	movl   $0x1080,0x4(%esp)
     907:	00 
     908:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     90f:	e8 0b fc ff ff       	call   51f <printf>
  while((newesp < (int *)currentThread->ebp))
     914:	eb 3c                	jmp    952 <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     916:	8b 45 f4             	mov    -0xc(%ebp),%eax
     919:	89 44 24 08          	mov    %eax,0x8(%esp)
     91d:	c7 44 24 04 96 10 00 	movl   $0x1096,0x4(%esp)
     924:	00 
     925:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     92c:	e8 ee fb ff ff       	call   51f <printf>
      printf(1,"val:%x\n",*newesp);
     931:	8b 45 f4             	mov    -0xc(%ebp),%eax
     934:	8b 00                	mov    (%eax),%eax
     936:	89 44 24 08          	mov    %eax,0x8(%esp)
     93a:	c7 44 24 04 9e 10 00 	movl   $0x109e,0x4(%esp)
     941:	00 
     942:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     949:	e8 d1 fb ff ff       	call   51f <printf>
    newesp++;
     94e:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     952:	a1 00 5f 00 00       	mov    0x5f00,%eax
     957:	8b 40 08             	mov    0x8(%eax),%eax
     95a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     95d:	77 b7                	ja     916 <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     95f:	c9                   	leave  
     960:	c3                   	ret    

00000961 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     961:	55                   	push   %ebp
     962:	89 e5                	mov    %esp,%ebp
     964:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     967:	8b 45 08             	mov    0x8(%ebp),%eax
     96a:	83 c0 01             	add    $0x1,%eax
     96d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     970:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     974:	75 07                	jne    97d <getNextThread+0x1c>
    i=0;
     976:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     97d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     980:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     986:	05 00 16 00 00       	add    $0x1600,%eax
     98b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     98e:	eb 3b                	jmp    9cb <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     990:	8b 45 f8             	mov    -0x8(%ebp),%eax
     993:	8b 40 10             	mov    0x10(%eax),%eax
     996:	83 f8 03             	cmp    $0x3,%eax
     999:	75 05                	jne    9a0 <getNextThread+0x3f>
      return i;
     99b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     99e:	eb 38                	jmp    9d8 <getNextThread+0x77>
    i++;
     9a0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     9a4:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     9a8:	75 1a                	jne    9c4 <getNextThread+0x63>
    {
     i=0;
     9aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     9b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b4:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     9ba:	05 00 16 00 00       	add    $0x1600,%eax
     9bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
     9c2:	eb 07                	jmp    9cb <getNextThread+0x6a>
   }
   else
    t++;
     9c4:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     9cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ce:	3b 45 08             	cmp    0x8(%ebp),%eax
     9d1:	75 bd                	jne    990 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     9d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     9d8:	c9                   	leave  
     9d9:	c3                   	ret    

000009da <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     9da:	55                   	push   %ebp
     9db:	89 e5                	mov    %esp,%ebp
     9dd:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     9e0:	c7 45 ec 00 16 00 00 	movl   $0x1600,-0x14(%ebp)
     9e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9ee:	eb 15                	jmp    a05 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     9f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9f3:	8b 40 10             	mov    0x10(%eax),%eax
     9f6:	85 c0                	test   %eax,%eax
     9f8:	74 1e                	je     a18 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     9fa:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     a01:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a05:	81 7d ec 00 5f 00 00 	cmpl   $0x5f00,-0x14(%ebp)
     a0c:	72 e2                	jb     9f0 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     a0e:	b8 00 00 00 00       	mov    $0x0,%eax
     a13:	e9 a3 00 00 00       	jmp    abb <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     a18:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     a19:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a1f:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     a21:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a25:	75 1c                	jne    a43 <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     a27:	89 e2                	mov    %esp,%edx
     a29:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a2c:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     a2f:	89 ea                	mov    %ebp,%edx
     a31:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a34:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     a37:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a3a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     a41:	eb 3b                	jmp    a7e <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     a43:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     a4a:	e8 b4 fd ff ff       	call   803 <malloc>
     a4f:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a52:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     a55:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a58:	8b 40 0c             	mov    0xc(%eax),%eax
     a5b:	05 00 10 00 00       	add    $0x1000,%eax
     a60:	89 c2                	mov    %eax,%edx
     a62:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a65:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     a68:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a6b:	8b 50 08             	mov    0x8(%eax),%edx
     a6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a71:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     a74:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a77:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     a7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a81:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     a88:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     a8b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a92:	eb 14                	jmp    aa8 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     a94:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a97:	8b 55 f0             	mov    -0x10(%ebp),%edx
     a9a:	83 c2 08             	add    $0x8,%edx
     a9d:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     aa4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aa8:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     aac:	7e e6                	jle    a94 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     aae:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ab1:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     ab8:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     abb:	c9                   	leave  
     abc:	c3                   	ret    

00000abd <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     abd:	55                   	push   %ebp
     abe:	89 e5                	mov    %esp,%ebp
     ac0:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     ac3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     aca:	eb 18                	jmp    ae4 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acf:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     ad5:	05 10 16 00 00       	add    $0x1610,%eax
     ada:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     ae0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ae4:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     ae8:	7e e2                	jle    acc <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     aea:	e8 eb fe ff ff       	call   9da <allocThread>
     aef:	a3 00 5f 00 00       	mov    %eax,0x5f00
  if(currentThread==0)
     af4:	a1 00 5f 00 00       	mov    0x5f00,%eax
     af9:	85 c0                	test   %eax,%eax
     afb:	75 07                	jne    b04 <uthread_init+0x47>
    return -1;
     afd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b02:	eb 6b                	jmp    b6f <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     b04:	a1 00 5f 00 00       	mov    0x5f00,%eax
     b09:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     b10:	c7 44 24 04 f7 0d 00 	movl   $0xdf7,0x4(%esp)
     b17:	00 
     b18:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     b1f:	e8 0c f9 ff ff       	call   430 <signal>
     b24:	85 c0                	test   %eax,%eax
     b26:	79 19                	jns    b41 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     b28:	c7 44 24 04 a8 10 00 	movl   $0x10a8,0x4(%esp)
     b2f:	00 
     b30:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b37:	e8 e3 f9 ff ff       	call   51f <printf>
    exit();
     b3c:	e8 2f f8 ff ff       	call   370 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     b41:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     b48:	e8 f3 f8 ff ff       	call   440 <alarm>
     b4d:	85 c0                	test   %eax,%eax
     b4f:	79 19                	jns    b6a <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     b51:	c7 44 24 04 c8 10 00 	movl   $0x10c8,0x4(%esp)
     b58:	00 
     b59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b60:	e8 ba f9 ff ff       	call   51f <printf>
    exit();
     b65:	e8 06 f8 ff ff       	call   370 <exit>
  }
  return 0;
     b6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b6f:	c9                   	leave  
     b70:	c3                   	ret    

00000b71 <wrap_func>:

void
wrap_func()
{
     b71:	55                   	push   %ebp
     b72:	89 e5                	mov    %esp,%ebp
     b74:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     b77:	a1 00 5f 00 00       	mov    0x5f00,%eax
     b7c:	8b 50 18             	mov    0x18(%eax),%edx
     b7f:	a1 00 5f 00 00       	mov    0x5f00,%eax
     b84:	8b 40 1c             	mov    0x1c(%eax),%eax
     b87:	89 04 24             	mov    %eax,(%esp)
     b8a:	ff d2                	call   *%edx
  uthread_exit();
     b8c:	e8 6c 00 00 00       	call   bfd <uthread_exit>
}
     b91:	c9                   	leave  
     b92:	c3                   	ret    

00000b93 <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     b93:	55                   	push   %ebp
     b94:	89 e5                	mov    %esp,%ebp
     b96:	53                   	push   %ebx
     b97:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     b9a:	e8 3b fe ff ff       	call   9da <allocThread>
     b9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     ba2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ba6:	75 07                	jne    baf <uthread_create+0x1c>
    return -1;
     ba8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bad:	eb 48                	jmp    bf7 <uthread_create+0x64>

  t->func=start_func;
     baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb2:	8b 55 08             	mov    0x8(%ebp),%edx
     bb5:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbb:	8b 55 0c             	mov    0xc(%ebp),%edx
     bbe:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     bc1:	89 e3                	mov    %esp,%ebx
     bc3:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc9:	8b 40 04             	mov    0x4(%eax),%eax
     bcc:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd1:	8b 50 08             	mov    0x8(%eax),%edx
     bd4:	b8 71 0b 00 00       	mov    $0xb71,%eax
     bd9:	50                   	push   %eax
     bda:	52                   	push   %edx
     bdb:	89 e2                	mov    %esp,%edx
     bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be0:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     be3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     be6:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     beb:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf5:	8b 00                	mov    (%eax),%eax
}
     bf7:	83 c4 14             	add    $0x14,%esp
     bfa:	5b                   	pop    %ebx
     bfb:	5d                   	pop    %ebp
     bfc:	c3                   	ret    

00000bfd <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     bfd:	55                   	push   %ebp
     bfe:	89 e5                	mov    %esp,%ebp
     c00:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     c03:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c0a:	e8 31 f8 ff ff       	call   440 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c16:	eb 51                	jmp    c69 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     c18:	a1 00 5f 00 00       	mov    0x5f00,%eax
     c1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c20:	83 c2 08             	add    $0x8,%edx
     c23:	8b 04 90             	mov    (%eax,%edx,4),%eax
     c26:	83 f8 01             	cmp    $0x1,%eax
     c29:	75 3a                	jne    c65 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2e:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c34:	05 20 17 00 00       	add    $0x1720,%eax
     c39:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     c3f:	a1 00 5f 00 00       	mov    0x5f00,%eax
     c44:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c47:	83 c2 08             	add    $0x8,%edx
     c4a:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     c51:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c54:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c5a:	05 10 16 00 00       	add    $0x1610,%eax
     c5f:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c69:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     c6d:	7e a9                	jle    c18 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     c6f:	a1 00 5f 00 00       	mov    0x5f00,%eax
     c74:	8b 00                	mov    (%eax),%eax
     c76:	89 04 24             	mov    %eax,(%esp)
     c79:	e8 e3 fc ff ff       	call   961 <getNextThread>
     c7e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     c81:	a1 00 5f 00 00       	mov    0x5f00,%eax
     c86:	8b 00                	mov    (%eax),%eax
     c88:	85 c0                	test   %eax,%eax
     c8a:	74 10                	je     c9c <uthread_exit+0x9f>
    free(currentThread->stack);
     c8c:	a1 00 5f 00 00       	mov    0x5f00,%eax
     c91:	8b 40 0c             	mov    0xc(%eax),%eax
     c94:	89 04 24             	mov    %eax,(%esp)
     c97:	e8 38 fa ff ff       	call   6d4 <free>
  currentThread->tid=-1;
     c9c:	a1 00 5f 00 00       	mov    0x5f00,%eax
     ca1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     ca7:	a1 00 5f 00 00       	mov    0x5f00,%eax
     cac:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     cb3:	a1 00 5f 00 00       	mov    0x5f00,%eax
     cb8:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     cbf:	a1 00 5f 00 00       	mov    0x5f00,%eax
     cc4:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     ccb:	a1 00 5f 00 00       	mov    0x5f00,%eax
     cd0:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     cd7:	a1 00 5f 00 00       	mov    0x5f00,%eax
     cdc:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     ce3:	a1 00 5f 00 00       	mov    0x5f00,%eax
     ce8:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     cef:	a1 00 5f 00 00       	mov    0x5f00,%eax
     cf4:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     cfb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     cff:	78 7a                	js     d7b <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     d01:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d04:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d0a:	05 00 16 00 00       	add    $0x1600,%eax
     d0f:	a3 00 5f 00 00       	mov    %eax,0x5f00
    currentThread->state=T_RUNNING;
     d14:	a1 00 5f 00 00       	mov    0x5f00,%eax
     d19:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     d20:	a1 00 5f 00 00       	mov    0x5f00,%eax
     d25:	8b 40 04             	mov    0x4(%eax),%eax
     d28:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     d2a:	a1 00 5f 00 00       	mov    0x5f00,%eax
     d2f:	8b 40 08             	mov    0x8(%eax),%eax
     d32:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     d34:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     d3b:	e8 00 f7 ff ff       	call   440 <alarm>
     d40:	85 c0                	test   %eax,%eax
     d42:	79 19                	jns    d5d <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     d44:	c7 44 24 04 c8 10 00 	movl   $0x10c8,0x4(%esp)
     d4b:	00 
     d4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d53:	e8 c7 f7 ff ff       	call   51f <printf>
      exit();
     d58:	e8 13 f6 ff ff       	call   370 <exit>
    }
    
    if(currentThread->firstTime==1)
     d5d:	a1 00 5f 00 00       	mov    0x5f00,%eax
     d62:	8b 40 14             	mov    0x14(%eax),%eax
     d65:	83 f8 01             	cmp    $0x1,%eax
     d68:	75 10                	jne    d7a <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     d6a:	a1 00 5f 00 00       	mov    0x5f00,%eax
     d6f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     d76:	5d                   	pop    %ebp
     d77:	c3                   	ret    
     d78:	eb 01                	jmp    d7b <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     d7a:	61                   	popa   
    }
  }
}
     d7b:	c9                   	leave  
     d7c:	c3                   	ret    

00000d7d <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     d7d:	55                   	push   %ebp
     d7e:	89 e5                	mov    %esp,%ebp
     d80:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     d83:	8b 45 08             	mov    0x8(%ebp),%eax
     d86:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d8c:	05 00 16 00 00       	add    $0x1600,%eax
     d91:	8b 40 10             	mov    0x10(%eax),%eax
     d94:	85 c0                	test   %eax,%eax
     d96:	75 07                	jne    d9f <uthread_join+0x22>
    return -1;
     d98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d9d:	eb 56                	jmp    df5 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     d9f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     da6:	e8 95 f6 ff ff       	call   440 <alarm>
    currentThread->waitingFor=tid;
     dab:	a1 00 5f 00 00       	mov    0x5f00,%eax
     db0:	8b 55 08             	mov    0x8(%ebp),%edx
     db3:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     db9:	a1 00 5f 00 00       	mov    0x5f00,%eax
     dbe:	8b 08                	mov    (%eax),%ecx
     dc0:	8b 55 08             	mov    0x8(%ebp),%edx
     dc3:	89 d0                	mov    %edx,%eax
     dc5:	c1 e0 03             	shl    $0x3,%eax
     dc8:	01 d0                	add    %edx,%eax
     dca:	c1 e0 03             	shl    $0x3,%eax
     dcd:	01 d0                	add    %edx,%eax
     dcf:	01 c8                	add    %ecx,%eax
     dd1:	83 c0 08             	add    $0x8,%eax
     dd4:	c7 04 85 00 16 00 00 	movl   $0x1,0x1600(,%eax,4)
     ddb:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     ddf:	a1 00 5f 00 00       	mov    0x5f00,%eax
     de4:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     deb:	e8 07 00 00 00       	call   df7 <uthread_yield>
    return 1;
     df0:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     df5:	c9                   	leave  
     df6:	c3                   	ret    

00000df7 <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     df7:	55                   	push   %ebp
     df8:	89 e5                	mov    %esp,%ebp
     dfa:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     dfd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e04:	e8 37 f6 ff ff       	call   440 <alarm>
  int new=getNextThread(currentThread->tid);
     e09:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e0e:	8b 00                	mov    (%eax),%eax
     e10:	89 04 24             	mov    %eax,(%esp)
     e13:	e8 49 fb ff ff       	call   961 <getNextThread>
     e18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     e1b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     e1f:	75 2d                	jne    e4e <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     e21:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     e28:	e8 13 f6 ff ff       	call   440 <alarm>
     e2d:	85 c0                	test   %eax,%eax
     e2f:	0f 89 c1 00 00 00    	jns    ef6 <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     e35:	c7 44 24 04 e8 10 00 	movl   $0x10e8,0x4(%esp)
     e3c:	00 
     e3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e44:	e8 d6 f6 ff ff       	call   51f <printf>
      exit();
     e49:	e8 22 f5 ff ff       	call   370 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     e4e:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     e4f:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e54:	89 e2                	mov    %esp,%edx
     e56:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     e59:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e5e:	89 ea                	mov    %ebp,%edx
     e60:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     e63:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e68:	8b 40 10             	mov    0x10(%eax),%eax
     e6b:	83 f8 02             	cmp    $0x2,%eax
     e6e:	75 0c                	jne    e7c <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     e70:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e75:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     e7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e7f:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e85:	05 00 16 00 00       	add    $0x1600,%eax
     e8a:	a3 00 5f 00 00       	mov    %eax,0x5f00

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     e8f:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e94:	8b 40 04             	mov    0x4(%eax),%eax
     e97:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     e99:	a1 00 5f 00 00       	mov    0x5f00,%eax
     e9e:	8b 40 08             	mov    0x8(%eax),%eax
     ea1:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     ea3:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     eaa:	e8 91 f5 ff ff       	call   440 <alarm>
     eaf:	85 c0                	test   %eax,%eax
     eb1:	79 19                	jns    ecc <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     eb3:	c7 44 24 04 e8 10 00 	movl   $0x10e8,0x4(%esp)
     eba:	00 
     ebb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ec2:	e8 58 f6 ff ff       	call   51f <printf>
      exit();
     ec7:	e8 a4 f4 ff ff       	call   370 <exit>
    }  
    currentThread->state=T_RUNNING;
     ecc:	a1 00 5f 00 00       	mov    0x5f00,%eax
     ed1:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     ed8:	a1 00 5f 00 00       	mov    0x5f00,%eax
     edd:	8b 40 14             	mov    0x14(%eax),%eax
     ee0:	83 f8 01             	cmp    $0x1,%eax
     ee3:	75 10                	jne    ef5 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     ee5:	a1 00 5f 00 00       	mov    0x5f00,%eax
     eea:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     ef1:	5d                   	pop    %ebp
     ef2:	c3                   	ret    
     ef3:	eb 01                	jmp    ef6 <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     ef5:	61                   	popa   
    }
  }
}
     ef6:	c9                   	leave  
     ef7:	c3                   	ret    

00000ef8 <uthread_self>:

int
uthread_self(void)
{
     ef8:	55                   	push   %ebp
     ef9:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     efb:	a1 00 5f 00 00       	mov    0x5f00,%eax
     f00:	8b 00                	mov    (%eax),%eax
     f02:	5d                   	pop    %ebp
     f03:	c3                   	ret    

00000f04 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     f04:	55                   	push   %ebp
     f05:	89 e5                	mov    %esp,%ebp
     f07:	53                   	push   %ebx
     f08:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     f0b:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f0e:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     f11:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f14:	89 c3                	mov    %eax,%ebx
     f16:	89 d8                	mov    %ebx,%eax
     f18:	f0 87 02             	lock xchg %eax,(%edx)
     f1b:	89 c3                	mov    %eax,%ebx
     f1d:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     f20:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     f23:	83 c4 10             	add    $0x10,%esp
     f26:	5b                   	pop    %ebx
     f27:	5d                   	pop    %ebp
     f28:	c3                   	ret    

00000f29 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
     f29:	55                   	push   %ebp
     f2a:	89 e5                	mov    %esp,%ebp
     f2c:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
     f2f:	8b 45 08             	mov    0x8(%ebp),%eax
     f32:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
     f39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f3d:	74 0c                	je     f4b <binary_semaphore_init+0x22>
    semaphore->thread=-1;
     f3f:	8b 45 08             	mov    0x8(%ebp),%eax
     f42:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
     f49:	eb 0b                	jmp    f56 <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
     f4b:	e8 a8 ff ff ff       	call   ef8 <uthread_self>
     f50:	8b 55 08             	mov    0x8(%ebp),%edx
     f53:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
     f56:	8b 55 0c             	mov    0xc(%ebp),%edx
     f59:	8b 45 08             	mov    0x8(%ebp),%eax
     f5c:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
     f5e:	8b 45 08             	mov    0x8(%ebp),%eax
     f61:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
     f68:	c9                   	leave  
     f69:	c3                   	ret    

00000f6a <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
     f6a:	55                   	push   %ebp
     f6b:	89 e5                	mov    %esp,%ebp
     f6d:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
     f70:	8b 45 08             	mov    0x8(%ebp),%eax
     f73:	8b 40 08             	mov    0x8(%eax),%eax
     f76:	85 c0                	test   %eax,%eax
     f78:	75 20                	jne    f9a <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     f7a:	8b 45 08             	mov    0x8(%ebp),%eax
     f7d:	8b 40 04             	mov    0x4(%eax),%eax
     f80:	89 44 24 08          	mov    %eax,0x8(%esp)
     f84:	c7 44 24 04 0c 11 00 	movl   $0x110c,0x4(%esp)
     f8b:	00 
     f8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f93:	e8 87 f5 ff ff       	call   51f <printf>
    return;
     f98:	eb 3a                	jmp    fd4 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
     f9a:	e8 59 ff ff ff       	call   ef8 <uthread_self>
     f9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
     fa2:	8b 45 08             	mov    0x8(%ebp),%eax
     fa5:	8b 40 04             	mov    0x4(%eax),%eax
     fa8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     fab:	74 27                	je     fd4 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
     fad:	eb 05                	jmp    fb4 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
     faf:	e8 43 fe ff ff       	call   df7 <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
     fb4:	8b 45 08             	mov    0x8(%ebp),%eax
     fb7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     fbe:	00 
     fbf:	89 04 24             	mov    %eax,(%esp)
     fc2:	e8 3d ff ff ff       	call   f04 <xchg>
     fc7:	85 c0                	test   %eax,%eax
     fc9:	74 e4                	je     faf <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
     fcb:	8b 45 08             	mov    0x8(%ebp),%eax
     fce:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fd1:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
     fd4:	c9                   	leave  
     fd5:	c3                   	ret    

00000fd6 <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
     fd6:	55                   	push   %ebp
     fd7:	89 e5                	mov    %esp,%ebp
     fd9:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
     fdc:	8b 45 08             	mov    0x8(%ebp),%eax
     fdf:	8b 40 08             	mov    0x8(%eax),%eax
     fe2:	85 c0                	test   %eax,%eax
     fe4:	75 20                	jne    1006 <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     fe6:	8b 45 08             	mov    0x8(%ebp),%eax
     fe9:	8b 40 04             	mov    0x4(%eax),%eax
     fec:	89 44 24 08          	mov    %eax,0x8(%esp)
     ff0:	c7 44 24 04 3c 11 00 	movl   $0x113c,0x4(%esp)
     ff7:	00 
     ff8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fff:	e8 1b f5 ff ff       	call   51f <printf>
    return;
    1004:	eb 2f                	jmp    1035 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    1006:	e8 ed fe ff ff       	call   ef8 <uthread_self>
    100b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    100e:	8b 45 08             	mov    0x8(%ebp),%eax
    1011:	8b 00                	mov    (%eax),%eax
    1013:	85 c0                	test   %eax,%eax
    1015:	75 1e                	jne    1035 <binary_semaphore_up+0x5f>
    1017:	8b 45 08             	mov    0x8(%ebp),%eax
    101a:	8b 40 04             	mov    0x4(%eax),%eax
    101d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1020:	75 13                	jne    1035 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    1022:	8b 45 08             	mov    0x8(%ebp),%eax
    1025:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    102c:	8b 45 08             	mov    0x8(%ebp),%eax
    102f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    1035:	c9                   	leave  
    1036:	c3                   	ret    
