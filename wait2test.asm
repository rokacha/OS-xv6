
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
  16:	c7 44 24 04 48 0d 00 	movl   $0xd48,0x4(%esp)
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
  50:	c7 44 24 04 48 0d 00 	movl   $0xd48,0x4(%esp)
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
  76:	c7 44 24 04 56 0d 00 	movl   $0xd56,0x4(%esp)
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
  bb:	c7 44 24 04 61 0d 00 	movl   $0xd61,0x4(%esp)
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
  e4:	c7 44 24 04 68 0d 00 	movl   $0xd68,0x4(%esp)
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
 4b6:	0f b6 90 80 11 00 00 	movzbl 0x1180(%eax),%edx
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
 617:	c7 45 f4 89 0d 00 00 	movl   $0xd89,-0xc(%ebp)
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
 6e3:	a1 a8 11 00 00       	mov    0x11a8,%eax
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
 7a4:	a3 a8 11 00 00       	mov    %eax,0x11a8
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
 7fc:	a1 a8 11 00 00       	mov    0x11a8,%eax
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
 818:	a1 a8 11 00 00       	mov    0x11a8,%eax
 81d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 820:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 824:	75 23                	jne    849 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 826:	c7 45 f0 a0 11 00 00 	movl   $0x11a0,-0x10(%ebp)
 82d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 830:	a3 a8 11 00 00       	mov    %eax,0x11a8
 835:	a1 a8 11 00 00       	mov    0x11a8,%eax
 83a:	a3 a0 11 00 00       	mov    %eax,0x11a0
    base.s.size = 0;
 83f:	c7 05 a4 11 00 00 00 	movl   $0x0,0x11a4
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
 89c:	a3 a8 11 00 00       	mov    %eax,0x11a8
      return (void*)(p + 1);
 8a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a4:	83 c0 08             	add    $0x8,%eax
 8a7:	eb 38                	jmp    8e1 <malloc+0xde>
    }
    if(p == freep)
 8a9:	a1 a8 11 00 00       	mov    0x11a8,%eax
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

000008e4 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 8e4:	55                   	push   %ebp
 8e5:	89 e5                	mov    %esp,%ebp
 8e7:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 8ea:	8b 45 08             	mov    0x8(%ebp),%eax
 8ed:	83 c0 01             	add    $0x1,%eax
 8f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 8f3:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8f7:	75 07                	jne    900 <getNextThread+0x1c>
    i=0;
 8f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 900:	8b 45 fc             	mov    -0x4(%ebp),%eax
 903:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 909:	05 c0 11 00 00       	add    $0x11c0,%eax
 90e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 911:	eb 3b                	jmp    94e <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 913:	8b 45 f8             	mov    -0x8(%ebp),%eax
 916:	8b 40 10             	mov    0x10(%eax),%eax
 919:	83 f8 03             	cmp    $0x3,%eax
 91c:	75 05                	jne    923 <getNextThread+0x3f>
      return i;
 91e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 921:	eb 38                	jmp    95b <getNextThread+0x77>
    i++;
 923:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 927:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 92b:	75 1a                	jne    947 <getNextThread+0x63>
    {
       i=0;
 92d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 934:	8b 45 fc             	mov    -0x4(%ebp),%eax
 937:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 93d:	05 c0 11 00 00       	add    $0x11c0,%eax
 942:	89 45 f8             	mov    %eax,-0x8(%ebp)
 945:	eb 07                	jmp    94e <getNextThread+0x6a>
    }
    else
      t++;
 947:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 94e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 951:	3b 45 08             	cmp    0x8(%ebp),%eax
 954:	75 bd                	jne    913 <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 956:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 95b:	c9                   	leave  
 95c:	c3                   	ret    

0000095d <allocThread>:


static uthread_p
allocThread()
{
 95d:	55                   	push   %ebp
 95e:	89 e5                	mov    %esp,%ebp
 960:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 963:	c7 45 ec c0 11 00 00 	movl   $0x11c0,-0x14(%ebp)
 96a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 971:	eb 15                	jmp    988 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 973:	8b 45 ec             	mov    -0x14(%ebp),%eax
 976:	8b 40 10             	mov    0x10(%eax),%eax
 979:	85 c0                	test   %eax,%eax
 97b:	74 1e                	je     99b <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 97d:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 984:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 988:	81 7d ec c0 57 00 00 	cmpl   $0x57c0,-0x14(%ebp)
 98f:	76 e2                	jbe    973 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 991:	b8 00 00 00 00       	mov    $0x0,%eax
 996:	e9 88 00 00 00       	jmp    a23 <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 99b:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 99c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 99f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 9a2:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 9a4:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9ab:	e8 53 fe ff ff       	call   803 <malloc>
 9b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9b3:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 9b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9b9:	8b 40 0c             	mov    0xc(%eax),%eax
 9bc:	89 c2                	mov    %eax,%edx
 9be:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9c1:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 9c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9c7:	8b 40 0c             	mov    0xc(%eax),%eax
 9ca:	89 c2                	mov    %eax,%edx
 9cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9cf:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 9d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d5:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 9dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 9e3:	eb 15                	jmp    9fa <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 9e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9e8:	8b 55 f0             	mov    -0x10(%ebp),%edx
 9eb:	83 c2 04             	add    $0x4,%edx
 9ee:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 9f5:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 9f6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 9fa:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 9fe:	7e e5                	jle    9e5 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 a00:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a03:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 a06:	ba 22 0b 00 00       	mov    $0xb22,%edx
 a0b:	89 c4                	mov    %eax,%esp
 a0d:	52                   	push   %edx
 a0e:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 a10:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 a13:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 a16:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a19:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 a20:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 a23:	c9                   	leave  
 a24:	c3                   	ret    

00000a25 <uthread_init>:

void 
uthread_init()
{  
 a25:	55                   	push   %ebp
 a26:	89 e5                	mov    %esp,%ebp
 a28:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 a2b:	c7 05 c0 57 00 00 00 	movl   $0x0,0x57c0
 a32:	00 00 00 
  tTable.current=0;
 a35:	c7 05 c4 57 00 00 00 	movl   $0x0,0x57c4
 a3c:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 a3f:	e8 19 ff ff ff       	call   95d <allocThread>
 a44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a47:	89 e9                	mov    %ebp,%ecx
 a49:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a4e:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 a51:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 a54:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5a:	8b 50 08             	mov    0x8(%eax),%edx
 a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a60:	8b 40 04             	mov    0x4(%eax),%eax
 a63:	89 d1                	mov    %edx,%ecx
 a65:	29 c1                	sub    %eax,%ecx
 a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a6a:	8b 40 04             	mov    0x4(%eax),%eax
 a6d:	89 c2                	mov    %eax,%edx
 a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a72:	8b 40 0c             	mov    0xc(%eax),%eax
 a75:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 a79:	89 54 24 04          	mov    %edx,0x4(%esp)
 a7d:	89 04 24             	mov    %eax,(%esp)
 a80:	e8 a5 f8 ff ff       	call   32a <memmove>
  mainT->state = T_RUNNABLE;
 a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a88:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a92:	a3 c8 57 00 00       	mov    %eax,0x57c8
  if(signal(SIGALRM,uthread_yield)<0)
 a97:	c7 44 24 04 92 0c 00 	movl   $0xc92,0x4(%esp)
 a9e:	00 
 a9f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 aa6:	e8 85 f9 ff ff       	call   430 <signal>
 aab:	85 c0                	test   %eax,%eax
 aad:	79 19                	jns    ac8 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 aaf:	c7 44 24 04 90 0d 00 	movl   $0xd90,0x4(%esp)
 ab6:	00 
 ab7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 abe:	e8 5c fa ff ff       	call   51f <printf>
    exit();
 ac3:	e8 a8 f8 ff ff       	call   370 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 ac8:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 acf:	e8 6c f9 ff ff       	call   440 <alarm>
 ad4:	85 c0                	test   %eax,%eax
 ad6:	79 19                	jns    af1 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 ad8:	c7 44 24 04 b0 0d 00 	movl   $0xdb0,0x4(%esp)
 adf:	00 
 ae0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ae7:	e8 33 fa ff ff       	call   51f <printf>
    exit();
 aec:	e8 7f f8 ff ff       	call   370 <exit>
  }
  
}
 af1:	c9                   	leave  
 af2:	c3                   	ret    

00000af3 <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 af3:	55                   	push   %ebp
 af4:	89 e5                	mov    %esp,%ebp
 af6:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 af9:	e8 5f fe ff ff       	call   95d <allocThread>
 afe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 b01:	8b 45 0c             	mov    0xc(%ebp),%eax
 b04:	8b 55 08             	mov    0x8(%ebp),%edx
 b07:	50                   	push   %eax
 b08:	52                   	push   %edx
 b09:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 b0e:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b14:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 b1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b1e:	8b 00                	mov    (%eax),%eax
}
 b20:	c9                   	leave  
 b21:	c3                   	ret    

00000b22 <uthread_exit>:

void 
uthread_exit()
{
 b22:	55                   	push   %ebp
 b23:	89 e5                	mov    %esp,%ebp
 b25:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 b28:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b2d:	8b 00                	mov    (%eax),%eax
 b2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 b32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 b39:	eb 25                	jmp    b60 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 b3b:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b40:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b43:	83 c2 04             	add    $0x4,%edx
 b46:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 b4a:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b50:	05 c0 11 00 00       	add    $0x11c0,%eax
 b55:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 b5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 b60:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b65:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b68:	83 c2 04             	add    $0x4,%edx
 b6b:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 b6f:	83 f8 ff             	cmp    $0xffffffff,%eax
 b72:	75 c7                	jne    b3b <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 b74:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b79:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 b7f:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b84:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 b8b:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b90:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 b97:	a1 c8 57 00 00       	mov    0x57c8,%eax
 b9c:	8b 40 0c             	mov    0xc(%eax),%eax
 b9f:	89 04 24             	mov    %eax,(%esp)
 ba2:	e8 2d fb ff ff       	call   6d4 <free>
  currentThread->state=T_FREE;
 ba7:	a1 c8 57 00 00       	mov    0x57c8,%eax
 bac:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 bb3:	a1 c8 57 00 00       	mov    0x57c8,%eax
 bb8:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 bbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bc2:	89 04 24             	mov    %eax,(%esp)
 bc5:	e8 1a fd ff ff       	call   8e4 <getNextThread>
 bca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 bcd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 bd1:	78 36                	js     c09 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 bd3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 bd6:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bdc:	05 c0 11 00 00       	add    $0x11c0,%eax
 be1:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 be4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 be7:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 bee:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bf1:	8b 40 04             	mov    0x4(%eax),%eax
 bf4:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 bf6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 bf9:	8b 40 08             	mov    0x8(%eax),%eax
 bfc:	89 c5                	mov    %eax,%ebp
             asm("popa");
 bfe:	61                   	popa   
             currentThread=newt;
 bff:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c02:	a3 c8 57 00 00       	mov    %eax,0x57c8
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 c07:	c9                   	leave  
 c08:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 c09:	e8 62 f7 ff ff       	call   370 <exit>

00000c0e <uthred_join>:
}


int
uthred_join(int tid)
{
 c0e:	55                   	push   %ebp
 c0f:	89 e5                	mov    %esp,%ebp
 c11:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 c14:	8b 45 08             	mov    0x8(%ebp),%eax
 c17:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c1d:	05 c0 11 00 00       	add    $0x11c0,%eax
 c22:	8b 40 10             	mov    0x10(%eax),%eax
 c25:	85 c0                	test   %eax,%eax
 c27:	75 07                	jne    c30 <uthred_join+0x22>
    return -1;
 c29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c2e:	eb 60                	jmp    c90 <uthred_join+0x82>
  else
  {
      int i=0;
 c30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 c37:	eb 04                	jmp    c3d <uthred_join+0x2f>
        i++;
 c39:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 c3d:	8b 45 08             	mov    0x8(%ebp),%eax
 c40:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c46:	05 c0 11 00 00       	add    $0x11c0,%eax
 c4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 c4e:	83 c2 04             	add    $0x4,%edx
 c51:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 c55:	83 f8 ff             	cmp    $0xffffffff,%eax
 c58:	75 df                	jne    c39 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 c5a:	8b 45 08             	mov    0x8(%ebp),%eax
 c5d:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c63:	8d 90 c0 11 00 00    	lea    0x11c0(%eax),%edx
 c69:	a1 c8 57 00 00       	mov    0x57c8,%eax
 c6e:	8b 00                	mov    (%eax),%eax
 c70:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 c73:	83 c1 04             	add    $0x4,%ecx
 c76:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 c7a:	a1 c8 57 00 00       	mov    0x57c8,%eax
 c7f:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 c86:	e8 07 00 00 00       	call   c92 <uthread_yield>
      return 1;
 c8b:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 c90:	c9                   	leave  
 c91:	c3                   	ret    

00000c92 <uthread_yield>:

void 
uthread_yield()
{
 c92:	55                   	push   %ebp
 c93:	89 e5                	mov    %esp,%ebp
 c95:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 c98:	a1 c8 57 00 00       	mov    0x57c8,%eax
 c9d:	8b 00                	mov    (%eax),%eax
 c9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ca5:	89 04 24             	mov    %eax,(%esp)
 ca8:	e8 37 fc ff ff       	call   8e4 <getNextThread>
 cad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 cb0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 cb4:	79 19                	jns    ccf <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 cb6:	c7 44 24 04 d0 0d 00 	movl   $0xdd0,0x4(%esp)
 cbd:	00 
 cbe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 cc5:	e8 55 f8 ff ff       	call   51f <printf>
    exit();
 cca:	e8 a1 f6 ff ff       	call   370 <exit>
  }
newt=&tTable.table[new];
 ccf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cd2:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 cd8:	05 c0 11 00 00       	add    $0x11c0,%eax
 cdd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 ce0:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 ce1:	a1 c8 57 00 00       	mov    0x57c8,%eax
 ce6:	89 e2                	mov    %esp,%edx
 ce8:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 ceb:	a1 c8 57 00 00       	mov    0x57c8,%eax
 cf0:	8b 40 10             	mov    0x10(%eax),%eax
 cf3:	83 f8 02             	cmp    $0x2,%eax
 cf6:	75 0c                	jne    d04 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 cf8:	a1 c8 57 00 00       	mov    0x57c8,%eax
 cfd:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 d04:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d07:	8b 40 04             	mov    0x4(%eax),%eax
 d0a:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 d0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d0f:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 d16:	61                   	popa   
    if(currentThread->firstTime==0)
 d17:	a1 c8 57 00 00       	mov    0x57c8,%eax
 d1c:	8b 40 14             	mov    0x14(%eax),%eax
 d1f:	85 c0                	test   %eax,%eax
 d21:	75 0d                	jne    d30 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 d23:	c3                   	ret    
       currentThread->firstTime=1;
 d24:	a1 c8 57 00 00       	mov    0x57c8,%eax
 d29:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 d30:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d33:	a3 c8 57 00 00       	mov    %eax,0x57c8

}
 d38:	c9                   	leave  
 d39:	c3                   	ret    

00000d3a <uthred_self>:

int  uthred_self(void)
{
 d3a:	55                   	push   %ebp
 d3b:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 d3d:	a1 c8 57 00 00       	mov    0x57c8,%eax
 d42:	8b 00                	mov    (%eax),%eax
}
 d44:	5d                   	pop    %ebp
 d45:	c3                   	ret    
