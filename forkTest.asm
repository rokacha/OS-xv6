
_forkTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"


int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  int i;
  if((i=fork())< 0)
   9:	e8 7e 02 00 00       	call   28c <fork>
   e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  12:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  17:	79 07                	jns    20 <main+0x20>
    return -1;
  19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    	// printf(1,"pid==%d\n",pidd );
  


  exit();
}
  1e:	c9                   	leave  
  1f:	c3                   	ret    
{
  int i;
  if((i=fork())< 0)
    return -1;
  
  if(i==0)
  20:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  25:	75 02                	jne    29 <main+0x29>
    {
    	for(;;){}
  27:	eb fe                	jmp    27 <main+0x27>
    	// printf(1,"wtime:%d rtime:%d iotime:%d\n", wtime,rtime,iotime);
    	// printf(1,"pid==%d\n",pidd );
  


  exit();
  29:	e8 66 02 00 00       	call   294 <exit>
  2e:	90                   	nop
  2f:	90                   	nop

00000030 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	57                   	push   %edi
  34:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  35:	8b 4d 08             	mov    0x8(%ebp),%ecx
  38:	8b 55 10             	mov    0x10(%ebp),%edx
  3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  3e:	89 cb                	mov    %ecx,%ebx
  40:	89 df                	mov    %ebx,%edi
  42:	89 d1                	mov    %edx,%ecx
  44:	fc                   	cld    
  45:	f3 aa                	rep stos %al,%es:(%edi)
  47:	89 ca                	mov    %ecx,%edx
  49:	89 fb                	mov    %edi,%ebx
  4b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  51:	5b                   	pop    %ebx
  52:	5f                   	pop    %edi
  53:	5d                   	pop    %ebp
  54:	c3                   	ret    

00000055 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
  55:	55                   	push   %ebp
  56:	89 e5                	mov    %esp,%ebp
  58:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  5b:	8b 45 08             	mov    0x8(%ebp),%eax
  5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  61:	90                   	nop
  62:	8b 45 0c             	mov    0xc(%ebp),%eax
  65:	0f b6 10             	movzbl (%eax),%edx
  68:	8b 45 08             	mov    0x8(%ebp),%eax
  6b:	88 10                	mov    %dl,(%eax)
  6d:	8b 45 08             	mov    0x8(%ebp),%eax
  70:	0f b6 00             	movzbl (%eax),%eax
  73:	84 c0                	test   %al,%al
  75:	0f 95 c0             	setne  %al
  78:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  7c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  80:	84 c0                	test   %al,%al
  82:	75 de                	jne    62 <strcpy+0xd>
    ;
  return os;
  84:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  87:	c9                   	leave  
  88:	c3                   	ret    

00000089 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  8c:	eb 08                	jmp    96 <strcmp+0xd>
    p++, q++;
  8e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  92:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  96:	8b 45 08             	mov    0x8(%ebp),%eax
  99:	0f b6 00             	movzbl (%eax),%eax
  9c:	84 c0                	test   %al,%al
  9e:	74 10                	je     b0 <strcmp+0x27>
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	0f b6 10             	movzbl (%eax),%edx
  a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  a9:	0f b6 00             	movzbl (%eax),%eax
  ac:	38 c2                	cmp    %al,%dl
  ae:	74 de                	je     8e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	0f b6 00             	movzbl (%eax),%eax
  b6:	0f b6 d0             	movzbl %al,%edx
  b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	0f b6 c0             	movzbl %al,%eax
  c2:	89 d1                	mov    %edx,%ecx
  c4:	29 c1                	sub    %eax,%ecx
  c6:	89 c8                	mov    %ecx,%eax
}
  c8:	5d                   	pop    %ebp
  c9:	c3                   	ret    

000000ca <strlen>:

uint
strlen(char *s)
{
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  cd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  d7:	eb 04                	jmp    dd <strlen+0x13>
  d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  e0:	03 45 08             	add    0x8(%ebp),%eax
  e3:	0f b6 00             	movzbl (%eax),%eax
  e6:	84 c0                	test   %al,%al
  e8:	75 ef                	jne    d9 <strlen+0xf>
    ;
  return n;
  ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ed:	c9                   	leave  
  ee:	c3                   	ret    

000000ef <memset>:

void*
memset(void *dst, int c, uint n)
{
  ef:	55                   	push   %ebp
  f0:	89 e5                	mov    %esp,%ebp
  f2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  f5:	8b 45 10             	mov    0x10(%ebp),%eax
  f8:	89 44 24 08          	mov    %eax,0x8(%esp)
  fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	89 04 24             	mov    %eax,(%esp)
 109:	e8 22 ff ff ff       	call   30 <stosb>
  return dst;
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 111:	c9                   	leave  
 112:	c3                   	ret    

00000113 <strchr>:

char*
strchr(const char *s, char c)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
 116:	83 ec 04             	sub    $0x4,%esp
 119:	8b 45 0c             	mov    0xc(%ebp),%eax
 11c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 11f:	eb 14                	jmp    135 <strchr+0x22>
    if(*s == c)
 121:	8b 45 08             	mov    0x8(%ebp),%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	3a 45 fc             	cmp    -0x4(%ebp),%al
 12a:	75 05                	jne    131 <strchr+0x1e>
      return (char*)s;
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	eb 13                	jmp    144 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 131:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 135:	8b 45 08             	mov    0x8(%ebp),%eax
 138:	0f b6 00             	movzbl (%eax),%eax
 13b:	84 c0                	test   %al,%al
 13d:	75 e2                	jne    121 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 13f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 144:	c9                   	leave  
 145:	c3                   	ret    

00000146 <gets>:

char*
gets(char *buf, int max)
{
 146:	55                   	push   %ebp
 147:	89 e5                	mov    %esp,%ebp
 149:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 153:	eb 44                	jmp    199 <gets+0x53>
    cc = read(0, &c, 1);
 155:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 15c:	00 
 15d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 160:	89 44 24 04          	mov    %eax,0x4(%esp)
 164:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 16b:	e8 3c 01 00 00       	call   2ac <read>
 170:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 173:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 177:	7e 2d                	jle    1a6 <gets+0x60>
      break;
    buf[i++] = c;
 179:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17c:	03 45 08             	add    0x8(%ebp),%eax
 17f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 183:	88 10                	mov    %dl,(%eax)
 185:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 189:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18d:	3c 0a                	cmp    $0xa,%al
 18f:	74 16                	je     1a7 <gets+0x61>
 191:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 195:	3c 0d                	cmp    $0xd,%al
 197:	74 0e                	je     1a7 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 199:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19c:	83 c0 01             	add    $0x1,%eax
 19f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1a2:	7c b1                	jl     155 <gets+0xf>
 1a4:	eb 01                	jmp    1a7 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1a6:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1aa:	03 45 08             	add    0x8(%ebp),%eax
 1ad:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1b3:	c9                   	leave  
 1b4:	c3                   	ret    

000001b5 <stat>:

int
stat(char *n, struct stat *st)
{
 1b5:	55                   	push   %ebp
 1b6:	89 e5                	mov    %esp,%ebp
 1b8:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1c2:	00 
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	89 04 24             	mov    %eax,(%esp)
 1c9:	e8 06 01 00 00       	call   2d4 <open>
 1ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1d5:	79 07                	jns    1de <stat+0x29>
    return -1;
 1d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1dc:	eb 23                	jmp    201 <stat+0x4c>
  r = fstat(fd, st);
 1de:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e1:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e8:	89 04 24             	mov    %eax,(%esp)
 1eb:	e8 fc 00 00 00       	call   2ec <fstat>
 1f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f6:	89 04 24             	mov    %eax,(%esp)
 1f9:	e8 be 00 00 00       	call   2bc <close>
  return r;
 1fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 201:	c9                   	leave  
 202:	c3                   	ret    

00000203 <atoi>:

int
atoi(const char *s)
{
 203:	55                   	push   %ebp
 204:	89 e5                	mov    %esp,%ebp
 206:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 210:	eb 23                	jmp    235 <atoi+0x32>
    n = n*10 + *s++ - '0';
 212:	8b 55 fc             	mov    -0x4(%ebp),%edx
 215:	89 d0                	mov    %edx,%eax
 217:	c1 e0 02             	shl    $0x2,%eax
 21a:	01 d0                	add    %edx,%eax
 21c:	01 c0                	add    %eax,%eax
 21e:	89 c2                	mov    %eax,%edx
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	0f b6 00             	movzbl (%eax),%eax
 226:	0f be c0             	movsbl %al,%eax
 229:	01 d0                	add    %edx,%eax
 22b:	83 e8 30             	sub    $0x30,%eax
 22e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 231:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	0f b6 00             	movzbl (%eax),%eax
 23b:	3c 2f                	cmp    $0x2f,%al
 23d:	7e 0a                	jle    249 <atoi+0x46>
 23f:	8b 45 08             	mov    0x8(%ebp),%eax
 242:	0f b6 00             	movzbl (%eax),%eax
 245:	3c 39                	cmp    $0x39,%al
 247:	7e c9                	jle    212 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 249:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 24c:	c9                   	leave  
 24d:	c3                   	ret    

0000024e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 24e:	55                   	push   %ebp
 24f:	89 e5                	mov    %esp,%ebp
 251:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 260:	eb 13                	jmp    275 <memmove+0x27>
    *dst++ = *src++;
 262:	8b 45 f8             	mov    -0x8(%ebp),%eax
 265:	0f b6 10             	movzbl (%eax),%edx
 268:	8b 45 fc             	mov    -0x4(%ebp),%eax
 26b:	88 10                	mov    %dl,(%eax)
 26d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 271:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 275:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 279:	0f 9f c0             	setg   %al
 27c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 280:	84 c0                	test   %al,%al
 282:	75 de                	jne    262 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 284:	8b 45 08             	mov    0x8(%ebp),%eax
}
 287:	c9                   	leave  
 288:	c3                   	ret    
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop

0000028c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28c:	b8 01 00 00 00       	mov    $0x1,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <exit>:
SYSCALL(exit)
 294:	b8 02 00 00 00       	mov    $0x2,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <wait>:
SYSCALL(wait)
 29c:	b8 03 00 00 00       	mov    $0x3,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <pipe>:
SYSCALL(pipe)
 2a4:	b8 04 00 00 00       	mov    $0x4,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <read>:
SYSCALL(read)
 2ac:	b8 05 00 00 00       	mov    $0x5,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <write>:
SYSCALL(write)
 2b4:	b8 10 00 00 00       	mov    $0x10,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <close>:
SYSCALL(close)
 2bc:	b8 15 00 00 00       	mov    $0x15,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <kill>:
SYSCALL(kill)
 2c4:	b8 06 00 00 00       	mov    $0x6,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <exec>:
SYSCALL(exec)
 2cc:	b8 07 00 00 00       	mov    $0x7,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <open>:
SYSCALL(open)
 2d4:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <mknod>:
SYSCALL(mknod)
 2dc:	b8 11 00 00 00       	mov    $0x11,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <unlink>:
SYSCALL(unlink)
 2e4:	b8 12 00 00 00       	mov    $0x12,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <fstat>:
SYSCALL(fstat)
 2ec:	b8 08 00 00 00       	mov    $0x8,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <link>:
SYSCALL(link)
 2f4:	b8 13 00 00 00       	mov    $0x13,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <mkdir>:
SYSCALL(mkdir)
 2fc:	b8 14 00 00 00       	mov    $0x14,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <chdir>:
SYSCALL(chdir)
 304:	b8 09 00 00 00       	mov    $0x9,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <dup>:
SYSCALL(dup)
 30c:	b8 0a 00 00 00       	mov    $0xa,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <getpid>:
SYSCALL(getpid)
 314:	b8 0b 00 00 00       	mov    $0xb,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <sbrk>:
SYSCALL(sbrk)
 31c:	b8 0c 00 00 00       	mov    $0xc,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <sleep>:
SYSCALL(sleep)
 324:	b8 0d 00 00 00       	mov    $0xd,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <uptime>:
SYSCALL(uptime)
 32c:	b8 0e 00 00 00       	mov    $0xe,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <add_path>:
SYSCALL(add_path)
 334:	b8 16 00 00 00       	mov    $0x16,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <wait2>:
SYSCALL(wait2)
 33c:	b8 17 00 00 00       	mov    $0x17,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <getquanta>:
SYSCALL(getquanta)
 344:	b8 18 00 00 00       	mov    $0x18,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <getqueue>:
SYSCALL(getqueue)
 34c:	b8 19 00 00 00       	mov    $0x19,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <signal>:
SYSCALL(signal)
 354:	b8 1a 00 00 00       	mov    $0x1a,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <sigsend>:
SYSCALL(sigsend)
 35c:	b8 1b 00 00 00       	mov    $0x1b,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <alarm>:
SYSCALL(alarm)
 364:	b8 1c 00 00 00       	mov    $0x1c,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	83 ec 28             	sub    $0x28,%esp
 372:	8b 45 0c             	mov    0xc(%ebp),%eax
 375:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 378:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 37f:	00 
 380:	8d 45 f4             	lea    -0xc(%ebp),%eax
 383:	89 44 24 04          	mov    %eax,0x4(%esp)
 387:	8b 45 08             	mov    0x8(%ebp),%eax
 38a:	89 04 24             	mov    %eax,(%esp)
 38d:	e8 22 ff ff ff       	call   2b4 <write>
}
 392:	c9                   	leave  
 393:	c3                   	ret    

00000394 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 394:	55                   	push   %ebp
 395:	89 e5                	mov    %esp,%ebp
 397:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 39a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a5:	74 17                	je     3be <printint+0x2a>
 3a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3ab:	79 11                	jns    3be <printint+0x2a>
    neg = 1;
 3ad:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3b4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b7:	f7 d8                	neg    %eax
 3b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bc:	eb 06                	jmp    3c4 <printint+0x30>
  } else {
    x = xx;
 3be:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d1:	ba 00 00 00 00       	mov    $0x0,%edx
 3d6:	f7 f1                	div    %ecx
 3d8:	89 d0                	mov    %edx,%eax
 3da:	0f b6 90 5c 14 00 00 	movzbl 0x145c(%eax),%edx
 3e1:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3e4:	03 45 f4             	add    -0xc(%ebp),%eax
 3e7:	88 10                	mov    %dl,(%eax)
 3e9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3ed:	8b 55 10             	mov    0x10(%ebp),%edx
 3f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f6:	ba 00 00 00 00       	mov    $0x0,%edx
 3fb:	f7 75 d4             	divl   -0x2c(%ebp)
 3fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
 401:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 405:	75 c4                	jne    3cb <printint+0x37>
  if(neg)
 407:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 40b:	74 2a                	je     437 <printint+0xa3>
    buf[i++] = '-';
 40d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 410:	03 45 f4             	add    -0xc(%ebp),%eax
 413:	c6 00 2d             	movb   $0x2d,(%eax)
 416:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 41a:	eb 1b                	jmp    437 <printint+0xa3>
    putc(fd, buf[i]);
 41c:	8d 45 dc             	lea    -0x24(%ebp),%eax
 41f:	03 45 f4             	add    -0xc(%ebp),%eax
 422:	0f b6 00             	movzbl (%eax),%eax
 425:	0f be c0             	movsbl %al,%eax
 428:	89 44 24 04          	mov    %eax,0x4(%esp)
 42c:	8b 45 08             	mov    0x8(%ebp),%eax
 42f:	89 04 24             	mov    %eax,(%esp)
 432:	e8 35 ff ff ff       	call   36c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 437:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 43b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 43f:	79 db                	jns    41c <printint+0x88>
    putc(fd, buf[i]);
}
 441:	c9                   	leave  
 442:	c3                   	ret    

00000443 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 443:	55                   	push   %ebp
 444:	89 e5                	mov    %esp,%ebp
 446:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 449:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 450:	8d 45 0c             	lea    0xc(%ebp),%eax
 453:	83 c0 04             	add    $0x4,%eax
 456:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 459:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 460:	e9 7d 01 00 00       	jmp    5e2 <printf+0x19f>
    c = fmt[i] & 0xff;
 465:	8b 55 0c             	mov    0xc(%ebp),%edx
 468:	8b 45 f0             	mov    -0x10(%ebp),%eax
 46b:	01 d0                	add    %edx,%eax
 46d:	0f b6 00             	movzbl (%eax),%eax
 470:	0f be c0             	movsbl %al,%eax
 473:	25 ff 00 00 00       	and    $0xff,%eax
 478:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 47b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47f:	75 2c                	jne    4ad <printf+0x6a>
      if(c == '%'){
 481:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 485:	75 0c                	jne    493 <printf+0x50>
        state = '%';
 487:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 48e:	e9 4b 01 00 00       	jmp    5de <printf+0x19b>
      } else {
        putc(fd, c);
 493:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 496:	0f be c0             	movsbl %al,%eax
 499:	89 44 24 04          	mov    %eax,0x4(%esp)
 49d:	8b 45 08             	mov    0x8(%ebp),%eax
 4a0:	89 04 24             	mov    %eax,(%esp)
 4a3:	e8 c4 fe ff ff       	call   36c <putc>
 4a8:	e9 31 01 00 00       	jmp    5de <printf+0x19b>
      }
    } else if(state == '%'){
 4ad:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4b1:	0f 85 27 01 00 00    	jne    5de <printf+0x19b>
      if(c == 'd'){
 4b7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4bb:	75 2d                	jne    4ea <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c0:	8b 00                	mov    (%eax),%eax
 4c2:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4c9:	00 
 4ca:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4d1:	00 
 4d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d6:	8b 45 08             	mov    0x8(%ebp),%eax
 4d9:	89 04 24             	mov    %eax,(%esp)
 4dc:	e8 b3 fe ff ff       	call   394 <printint>
        ap++;
 4e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e5:	e9 ed 00 00 00       	jmp    5d7 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4ea:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ee:	74 06                	je     4f6 <printf+0xb3>
 4f0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4f4:	75 2d                	jne    523 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f9:	8b 00                	mov    (%eax),%eax
 4fb:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 502:	00 
 503:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 50a:	00 
 50b:	89 44 24 04          	mov    %eax,0x4(%esp)
 50f:	8b 45 08             	mov    0x8(%ebp),%eax
 512:	89 04 24             	mov    %eax,(%esp)
 515:	e8 7a fe ff ff       	call   394 <printint>
        ap++;
 51a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 51e:	e9 b4 00 00 00       	jmp    5d7 <printf+0x194>
      } else if(c == 's'){
 523:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 527:	75 46                	jne    56f <printf+0x12c>
        s = (char*)*ap;
 529:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52c:	8b 00                	mov    (%eax),%eax
 52e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 531:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 535:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 539:	75 27                	jne    562 <printf+0x11f>
          s = "(null)";
 53b:	c7 45 f4 5c 0f 00 00 	movl   $0xf5c,-0xc(%ebp)
        while(*s != 0){
 542:	eb 1e                	jmp    562 <printf+0x11f>
          putc(fd, *s);
 544:	8b 45 f4             	mov    -0xc(%ebp),%eax
 547:	0f b6 00             	movzbl (%eax),%eax
 54a:	0f be c0             	movsbl %al,%eax
 54d:	89 44 24 04          	mov    %eax,0x4(%esp)
 551:	8b 45 08             	mov    0x8(%ebp),%eax
 554:	89 04 24             	mov    %eax,(%esp)
 557:	e8 10 fe ff ff       	call   36c <putc>
          s++;
 55c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 560:	eb 01                	jmp    563 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 562:	90                   	nop
 563:	8b 45 f4             	mov    -0xc(%ebp),%eax
 566:	0f b6 00             	movzbl (%eax),%eax
 569:	84 c0                	test   %al,%al
 56b:	75 d7                	jne    544 <printf+0x101>
 56d:	eb 68                	jmp    5d7 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 573:	75 1d                	jne    592 <printf+0x14f>
        putc(fd, *ap);
 575:	8b 45 e8             	mov    -0x18(%ebp),%eax
 578:	8b 00                	mov    (%eax),%eax
 57a:	0f be c0             	movsbl %al,%eax
 57d:	89 44 24 04          	mov    %eax,0x4(%esp)
 581:	8b 45 08             	mov    0x8(%ebp),%eax
 584:	89 04 24             	mov    %eax,(%esp)
 587:	e8 e0 fd ff ff       	call   36c <putc>
        ap++;
 58c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 590:	eb 45                	jmp    5d7 <printf+0x194>
      } else if(c == '%'){
 592:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 596:	75 17                	jne    5af <printf+0x16c>
        putc(fd, c);
 598:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59b:	0f be c0             	movsbl %al,%eax
 59e:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a2:	8b 45 08             	mov    0x8(%ebp),%eax
 5a5:	89 04 24             	mov    %eax,(%esp)
 5a8:	e8 bf fd ff ff       	call   36c <putc>
 5ad:	eb 28                	jmp    5d7 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5af:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5b6:	00 
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	89 04 24             	mov    %eax,(%esp)
 5bd:	e8 aa fd ff ff       	call   36c <putc>
        putc(fd, c);
 5c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c5:	0f be c0             	movsbl %al,%eax
 5c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cc:	8b 45 08             	mov    0x8(%ebp),%eax
 5cf:	89 04 24             	mov    %eax,(%esp)
 5d2:	e8 95 fd ff ff       	call   36c <putc>
      }
      state = 0;
 5d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5de:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5e8:	01 d0                	add    %edx,%eax
 5ea:	0f b6 00             	movzbl (%eax),%eax
 5ed:	84 c0                	test   %al,%al
 5ef:	0f 85 70 fe ff ff    	jne    465 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f5:	c9                   	leave  
 5f6:	c3                   	ret    
 5f7:	90                   	nop

000005f8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f8:	55                   	push   %ebp
 5f9:	89 e5                	mov    %esp,%ebp
 5fb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	83 e8 08             	sub    $0x8,%eax
 604:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 607:	a1 88 14 00 00       	mov    0x1488,%eax
 60c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60f:	eb 24                	jmp    635 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 619:	77 12                	ja     62d <free+0x35>
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 621:	77 24                	ja     647 <free+0x4f>
 623:	8b 45 fc             	mov    -0x4(%ebp),%eax
 626:	8b 00                	mov    (%eax),%eax
 628:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62b:	77 1a                	ja     647 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 00                	mov    (%eax),%eax
 632:	89 45 fc             	mov    %eax,-0x4(%ebp)
 635:	8b 45 f8             	mov    -0x8(%ebp),%eax
 638:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63b:	76 d4                	jbe    611 <free+0x19>
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 645:	76 ca                	jbe    611 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 647:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64a:	8b 40 04             	mov    0x4(%eax),%eax
 64d:	c1 e0 03             	shl    $0x3,%eax
 650:	89 c2                	mov    %eax,%edx
 652:	03 55 f8             	add    -0x8(%ebp),%edx
 655:	8b 45 fc             	mov    -0x4(%ebp),%eax
 658:	8b 00                	mov    (%eax),%eax
 65a:	39 c2                	cmp    %eax,%edx
 65c:	75 24                	jne    682 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 661:	8b 50 04             	mov    0x4(%eax),%edx
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	8b 00                	mov    (%eax),%eax
 669:	8b 40 04             	mov    0x4(%eax),%eax
 66c:	01 c2                	add    %eax,%edx
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	8b 10                	mov    (%eax),%edx
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	89 10                	mov    %edx,(%eax)
 680:	eb 0a                	jmp    68c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	8b 10                	mov    (%eax),%edx
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	8b 40 04             	mov    0x4(%eax),%eax
 692:	c1 e0 03             	shl    $0x3,%eax
 695:	03 45 fc             	add    -0x4(%ebp),%eax
 698:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69b:	75 20                	jne    6bd <free+0xc5>
    p->s.size += bp->s.size;
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 50 04             	mov    0x4(%eax),%edx
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	01 c2                	add    %eax,%edx
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b4:	8b 10                	mov    (%eax),%edx
 6b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b9:	89 10                	mov    %edx,(%eax)
 6bb:	eb 08                	jmp    6c5 <free+0xcd>
  } else
    p->s.ptr = bp;
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6c3:	89 10                	mov    %edx,(%eax)
  freep = p;
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	a3 88 14 00 00       	mov    %eax,0x1488
}
 6cd:	c9                   	leave  
 6ce:	c3                   	ret    

000006cf <morecore>:

static Header*
morecore(uint nu)
{
 6cf:	55                   	push   %ebp
 6d0:	89 e5                	mov    %esp,%ebp
 6d2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6d5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6dc:	77 07                	ja     6e5 <morecore+0x16>
    nu = 4096;
 6de:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6e5:	8b 45 08             	mov    0x8(%ebp),%eax
 6e8:	c1 e0 03             	shl    $0x3,%eax
 6eb:	89 04 24             	mov    %eax,(%esp)
 6ee:	e8 29 fc ff ff       	call   31c <sbrk>
 6f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6f6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6fa:	75 07                	jne    703 <morecore+0x34>
    return 0;
 6fc:	b8 00 00 00 00       	mov    $0x0,%eax
 701:	eb 22                	jmp    725 <morecore+0x56>
  hp = (Header*)p;
 703:	8b 45 f4             	mov    -0xc(%ebp),%eax
 706:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 709:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70c:	8b 55 08             	mov    0x8(%ebp),%edx
 70f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 712:	8b 45 f0             	mov    -0x10(%ebp),%eax
 715:	83 c0 08             	add    $0x8,%eax
 718:	89 04 24             	mov    %eax,(%esp)
 71b:	e8 d8 fe ff ff       	call   5f8 <free>
  return freep;
 720:	a1 88 14 00 00       	mov    0x1488,%eax
}
 725:	c9                   	leave  
 726:	c3                   	ret    

00000727 <malloc>:

void*
malloc(uint nbytes)
{
 727:	55                   	push   %ebp
 728:	89 e5                	mov    %esp,%ebp
 72a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
 730:	83 c0 07             	add    $0x7,%eax
 733:	c1 e8 03             	shr    $0x3,%eax
 736:	83 c0 01             	add    $0x1,%eax
 739:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 73c:	a1 88 14 00 00       	mov    0x1488,%eax
 741:	89 45 f0             	mov    %eax,-0x10(%ebp)
 744:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 748:	75 23                	jne    76d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 74a:	c7 45 f0 80 14 00 00 	movl   $0x1480,-0x10(%ebp)
 751:	8b 45 f0             	mov    -0x10(%ebp),%eax
 754:	a3 88 14 00 00       	mov    %eax,0x1488
 759:	a1 88 14 00 00       	mov    0x1488,%eax
 75e:	a3 80 14 00 00       	mov    %eax,0x1480
    base.s.size = 0;
 763:	c7 05 84 14 00 00 00 	movl   $0x0,0x1484
 76a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 76d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 770:	8b 00                	mov    (%eax),%eax
 772:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 775:	8b 45 f4             	mov    -0xc(%ebp),%eax
 778:	8b 40 04             	mov    0x4(%eax),%eax
 77b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 77e:	72 4d                	jb     7cd <malloc+0xa6>
      if(p->s.size == nunits)
 780:	8b 45 f4             	mov    -0xc(%ebp),%eax
 783:	8b 40 04             	mov    0x4(%eax),%eax
 786:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 789:	75 0c                	jne    797 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8b 10                	mov    (%eax),%edx
 790:	8b 45 f0             	mov    -0x10(%ebp),%eax
 793:	89 10                	mov    %edx,(%eax)
 795:	eb 26                	jmp    7bd <malloc+0x96>
      else {
        p->s.size -= nunits;
 797:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79a:	8b 40 04             	mov    0x4(%eax),%eax
 79d:	89 c2                	mov    %eax,%edx
 79f:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 40 04             	mov    0x4(%eax),%eax
 7ae:	c1 e0 03             	shl    $0x3,%eax
 7b1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ba:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c0:	a3 88 14 00 00       	mov    %eax,0x1488
      return (void*)(p + 1);
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	83 c0 08             	add    $0x8,%eax
 7cb:	eb 38                	jmp    805 <malloc+0xde>
    }
    if(p == freep)
 7cd:	a1 88 14 00 00       	mov    0x1488,%eax
 7d2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7d5:	75 1b                	jne    7f2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7da:	89 04 24             	mov    %eax,(%esp)
 7dd:	e8 ed fe ff ff       	call   6cf <morecore>
 7e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e9:	75 07                	jne    7f2 <malloc+0xcb>
        return 0;
 7eb:	b8 00 00 00 00       	mov    $0x0,%eax
 7f0:	eb 13                	jmp    805 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fb:	8b 00                	mov    (%eax),%eax
 7fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 800:	e9 70 ff ff ff       	jmp    775 <malloc+0x4e>
}
 805:	c9                   	leave  
 806:	c3                   	ret    
 807:	90                   	nop

00000808 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
 808:	55                   	push   %ebp
 809:	89 e5                	mov    %esp,%ebp
 80b:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
 80e:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 813:	8b 40 04             	mov    0x4(%eax),%eax
 816:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
 819:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 81e:	8b 00                	mov    (%eax),%eax
 820:	89 44 24 08          	mov    %eax,0x8(%esp)
 824:	c7 44 24 04 64 0f 00 	movl   $0xf64,0x4(%esp)
 82b:	00 
 82c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 833:	e8 0b fc ff ff       	call   443 <printf>
  while((newesp < (int *)currentThread->ebp))
 838:	eb 3c                	jmp    876 <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
 83a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83d:	89 44 24 08          	mov    %eax,0x8(%esp)
 841:	c7 44 24 04 7a 0f 00 	movl   $0xf7a,0x4(%esp)
 848:	00 
 849:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 850:	e8 ee fb ff ff       	call   443 <printf>
      printf(1,"val:%x\n",*newesp);
 855:	8b 45 f4             	mov    -0xc(%ebp),%eax
 858:	8b 00                	mov    (%eax),%eax
 85a:	89 44 24 08          	mov    %eax,0x8(%esp)
 85e:	c7 44 24 04 82 0f 00 	movl   $0xf82,0x4(%esp)
 865:	00 
 866:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 86d:	e8 d1 fb ff ff       	call   443 <printf>
    newesp++;
 872:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
 876:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 87b:	8b 40 08             	mov    0x8(%eax),%eax
 87e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 881:	77 b7                	ja     83a <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
 883:	c9                   	leave  
 884:	c3                   	ret    

00000885 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
 885:	55                   	push   %ebp
 886:	89 e5                	mov    %esp,%ebp
 888:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 88b:	8b 45 08             	mov    0x8(%ebp),%eax
 88e:	83 c0 01             	add    $0x1,%eax
 891:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 894:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 898:	75 07                	jne    8a1 <getNextThread+0x1c>
    i=0;
 89a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 8a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a4:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 8aa:	05 a0 14 00 00       	add    $0x14a0,%eax
 8af:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 8b2:	eb 3b                	jmp    8ef <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 8b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b7:	8b 40 10             	mov    0x10(%eax),%eax
 8ba:	83 f8 03             	cmp    $0x3,%eax
 8bd:	75 05                	jne    8c4 <getNextThread+0x3f>
      return i;
 8bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c2:	eb 38                	jmp    8fc <getNextThread+0x77>
    i++;
 8c4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 8c8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8cc:	75 1a                	jne    8e8 <getNextThread+0x63>
    {
     i=0;
 8ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
 8d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 8de:	05 a0 14 00 00       	add    $0x14a0,%eax
 8e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
 8e6:	eb 07                	jmp    8ef <getNextThread+0x6a>
   }
   else
    t++;
 8e8:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 8ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f2:	3b 45 08             	cmp    0x8(%ebp),%eax
 8f5:	75 bd                	jne    8b4 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
 8f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 8fc:	c9                   	leave  
 8fd:	c3                   	ret    

000008fe <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
 8fe:	55                   	push   %ebp
 8ff:	89 e5                	mov    %esp,%ebp
 901:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 904:	c7 45 ec a0 14 00 00 	movl   $0x14a0,-0x14(%ebp)
 90b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 912:	eb 15                	jmp    929 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 914:	8b 45 ec             	mov    -0x14(%ebp),%eax
 917:	8b 40 10             	mov    0x10(%eax),%eax
 91a:	85 c0                	test   %eax,%eax
 91c:	74 1e                	je     93c <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 91e:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
 925:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 929:	81 7d ec a0 5d 00 00 	cmpl   $0x5da0,-0x14(%ebp)
 930:	72 e2                	jb     914 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 932:	b8 00 00 00 00       	mov    $0x0,%eax
 937:	e9 a3 00 00 00       	jmp    9df <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
 93c:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
 93d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 940:	8b 55 f4             	mov    -0xc(%ebp),%edx
 943:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
 945:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 949:	75 1c                	jne    967 <allocThread+0x69>
  {
    STORE_ESP(t->esp);
 94b:	89 e2                	mov    %esp,%edx
 94d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 950:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
 953:	89 ea                	mov    %ebp,%edx
 955:	8b 45 ec             	mov    -0x14(%ebp),%eax
 958:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
 95b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 95e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
 965:	eb 3b                	jmp    9a2 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
 967:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 96e:	e8 b4 fd ff ff       	call   727 <malloc>
 973:	8b 55 ec             	mov    -0x14(%ebp),%edx
 976:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
 979:	8b 45 ec             	mov    -0x14(%ebp),%eax
 97c:	8b 40 0c             	mov    0xc(%eax),%eax
 97f:	05 00 10 00 00       	add    $0x1000,%eax
 984:	89 c2                	mov    %eax,%edx
 986:	8b 45 ec             	mov    -0x14(%ebp),%eax
 989:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
 98c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 98f:	8b 50 08             	mov    0x8(%eax),%edx
 992:	8b 45 ec             	mov    -0x14(%ebp),%eax
 995:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
 998:	8b 45 ec             	mov    -0x14(%ebp),%eax
 99b:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
 9a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9a5:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
 9ac:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
 9af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 9b6:	eb 14                	jmp    9cc <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
 9b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9bb:	8b 55 f0             	mov    -0x10(%ebp),%edx
 9be:	83 c2 08             	add    $0x8,%edx
 9c1:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
 9c8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 9cc:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 9d0:	7e e6                	jle    9b8 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
 9d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d5:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
 9dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 9df:	c9                   	leave  
 9e0:	c3                   	ret    

000009e1 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
 9e1:	55                   	push   %ebp
 9e2:	89 e5                	mov    %esp,%ebp
 9e4:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 9e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 9ee:	eb 18                	jmp    a08 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
 9f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f3:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 9f9:	05 b0 14 00 00       	add    $0x14b0,%eax
 9fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 a04:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a08:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 a0c:	7e e2                	jle    9f0 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
 a0e:	e8 eb fe ff ff       	call   8fe <allocThread>
 a13:	a3 a0 5d 00 00       	mov    %eax,0x5da0
  if(currentThread==0)
 a18:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 a1d:	85 c0                	test   %eax,%eax
 a1f:	75 07                	jne    a28 <uthread_init+0x47>
    return -1;
 a21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a26:	eb 6b                	jmp    a93 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
 a28:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 a2d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
 a34:	c7 44 24 04 1b 0d 00 	movl   $0xd1b,0x4(%esp)
 a3b:	00 
 a3c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a43:	e8 0c f9 ff ff       	call   354 <signal>
 a48:	85 c0                	test   %eax,%eax
 a4a:	79 19                	jns    a65 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
 a4c:	c7 44 24 04 8c 0f 00 	movl   $0xf8c,0x4(%esp)
 a53:	00 
 a54:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a5b:	e8 e3 f9 ff ff       	call   443 <printf>
    exit();
 a60:	e8 2f f8 ff ff       	call   294 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
 a65:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 a6c:	e8 f3 f8 ff ff       	call   364 <alarm>
 a71:	85 c0                	test   %eax,%eax
 a73:	79 19                	jns    a8e <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
 a75:	c7 44 24 04 ac 0f 00 	movl   $0xfac,0x4(%esp)
 a7c:	00 
 a7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a84:	e8 ba f9 ff ff       	call   443 <printf>
    exit();
 a89:	e8 06 f8 ff ff       	call   294 <exit>
  }
  return 0;
 a8e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a93:	c9                   	leave  
 a94:	c3                   	ret    

00000a95 <wrap_func>:

void
wrap_func()
{
 a95:	55                   	push   %ebp
 a96:	89 e5                	mov    %esp,%ebp
 a98:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
 a9b:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 aa0:	8b 50 18             	mov    0x18(%eax),%edx
 aa3:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 aa8:	8b 40 1c             	mov    0x1c(%eax),%eax
 aab:	89 04 24             	mov    %eax,(%esp)
 aae:	ff d2                	call   *%edx
  uthread_exit();
 ab0:	e8 6c 00 00 00       	call   b21 <uthread_exit>
}
 ab5:	c9                   	leave  
 ab6:	c3                   	ret    

00000ab7 <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
 ab7:	55                   	push   %ebp
 ab8:	89 e5                	mov    %esp,%ebp
 aba:	53                   	push   %ebx
 abb:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
 abe:	e8 3b fe ff ff       	call   8fe <allocThread>
 ac3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
 ac6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aca:	75 07                	jne    ad3 <uthread_create+0x1c>
    return -1;
 acc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ad1:	eb 48                	jmp    b1b <uthread_create+0x64>

  t->func=start_func;
 ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad6:	8b 55 08             	mov    0x8(%ebp),%edx
 ad9:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
 adc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adf:	8b 55 0c             	mov    0xc(%ebp),%edx
 ae2:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
 ae5:	89 e3                	mov    %esp,%ebx
 ae7:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
 aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aed:	8b 40 04             	mov    0x4(%eax),%eax
 af0:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
 af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af5:	8b 50 08             	mov    0x8(%eax),%edx
 af8:	b8 95 0a 00 00       	mov    $0xa95,%eax
 afd:	50                   	push   %eax
 afe:	52                   	push   %edx
 aff:	89 e2                	mov    %esp,%edx
 b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b04:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
 b07:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b0a:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
 b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b0f:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 b16:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b19:	8b 00                	mov    (%eax),%eax
}
 b1b:	83 c4 14             	add    $0x14,%esp
 b1e:	5b                   	pop    %ebx
 b1f:	5d                   	pop    %ebp
 b20:	c3                   	ret    

00000b21 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
 b21:	55                   	push   %ebp
 b22:	89 e5                	mov    %esp,%ebp
 b24:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 b27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 b2e:	e8 31 f8 ff ff       	call   364 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 b33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 b3a:	eb 51                	jmp    b8d <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
 b3c:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 b41:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b44:	83 c2 08             	add    $0x8,%edx
 b47:	8b 04 90             	mov    (%eax,%edx,4),%eax
 b4a:	83 f8 01             	cmp    $0x1,%eax
 b4d:	75 3a                	jne    b89 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
 b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b52:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 b58:	05 c0 15 00 00       	add    $0x15c0,%eax
 b5d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
 b63:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 b68:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b6b:	83 c2 08             	add    $0x8,%edx
 b6e:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
 b75:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b78:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 b7e:	05 b0 14 00 00       	add    $0x14b0,%eax
 b83:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 b89:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 b8d:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 b91:	7e a9                	jle    b3c <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
 b93:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 b98:	8b 00                	mov    (%eax),%eax
 b9a:	89 04 24             	mov    %eax,(%esp)
 b9d:	e8 e3 fc ff ff       	call   885 <getNextThread>
 ba2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
 ba5:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 baa:	8b 00                	mov    (%eax),%eax
 bac:	85 c0                	test   %eax,%eax
 bae:	74 10                	je     bc0 <uthread_exit+0x9f>
    free(currentThread->stack);
 bb0:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 bb5:	8b 40 0c             	mov    0xc(%eax),%eax
 bb8:	89 04 24             	mov    %eax,(%esp)
 bbb:	e8 38 fa ff ff       	call   5f8 <free>
  currentThread->tid=-1;
 bc0:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 bc5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 bcb:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 bd0:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 bd7:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 bdc:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
 be3:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 be8:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
 bef:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 bf4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
 bfb:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c00:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
 c07:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c0c:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
 c13:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c18:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
 c1f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c23:	78 7a                	js     c9f <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
 c25:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c28:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 c2e:	05 a0 14 00 00       	add    $0x14a0,%eax
 c33:	a3 a0 5d 00 00       	mov    %eax,0x5da0
    currentThread->state=T_RUNNING;
 c38:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c3d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
 c44:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c49:	8b 40 04             	mov    0x4(%eax),%eax
 c4c:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 c4e:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c53:	8b 40 08             	mov    0x8(%eax),%eax
 c56:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
 c58:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 c5f:	e8 00 f7 ff ff       	call   364 <alarm>
 c64:	85 c0                	test   %eax,%eax
 c66:	79 19                	jns    c81 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
 c68:	c7 44 24 04 ac 0f 00 	movl   $0xfac,0x4(%esp)
 c6f:	00 
 c70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c77:	e8 c7 f7 ff ff       	call   443 <printf>
      exit();
 c7c:	e8 13 f6 ff ff       	call   294 <exit>
    }
    
    if(currentThread->firstTime==1)
 c81:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c86:	8b 40 14             	mov    0x14(%eax),%eax
 c89:	83 f8 01             	cmp    $0x1,%eax
 c8c:	75 10                	jne    c9e <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
 c8e:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 c93:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
 c9a:	5d                   	pop    %ebp
 c9b:	c3                   	ret    
 c9c:	eb 01                	jmp    c9f <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
 c9e:	61                   	popa   
    }
  }
}
 c9f:	c9                   	leave  
 ca0:	c3                   	ret    

00000ca1 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
 ca1:	55                   	push   %ebp
 ca2:	89 e5                	mov    %esp,%ebp
 ca4:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 ca7:	8b 45 08             	mov    0x8(%ebp),%eax
 caa:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 cb0:	05 a0 14 00 00       	add    $0x14a0,%eax
 cb5:	8b 40 10             	mov    0x10(%eax),%eax
 cb8:	85 c0                	test   %eax,%eax
 cba:	75 07                	jne    cc3 <uthread_join+0x22>
    return -1;
 cbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 cc1:	eb 56                	jmp    d19 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
 cc3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 cca:	e8 95 f6 ff ff       	call   364 <alarm>
    currentThread->waitingFor=tid;
 ccf:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 cd4:	8b 55 08             	mov    0x8(%ebp),%edx
 cd7:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
 cdd:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 ce2:	8b 08                	mov    (%eax),%ecx
 ce4:	8b 55 08             	mov    0x8(%ebp),%edx
 ce7:	89 d0                	mov    %edx,%eax
 ce9:	c1 e0 03             	shl    $0x3,%eax
 cec:	01 d0                	add    %edx,%eax
 cee:	c1 e0 03             	shl    $0x3,%eax
 cf1:	01 d0                	add    %edx,%eax
 cf3:	01 c8                	add    %ecx,%eax
 cf5:	83 c0 08             	add    $0x8,%eax
 cf8:	c7 04 85 a0 14 00 00 	movl   $0x1,0x14a0(,%eax,4)
 cff:	01 00 00 00 
    currentThread->state=T_SLEEPING;
 d03:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 d08:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
 d0f:	e8 07 00 00 00       	call   d1b <uthread_yield>
    return 1;
 d14:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d19:	c9                   	leave  
 d1a:	c3                   	ret    

00000d1b <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
 d1b:	55                   	push   %ebp
 d1c:	89 e5                	mov    %esp,%ebp
 d1e:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 d21:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d28:	e8 37 f6 ff ff       	call   364 <alarm>
  int new=getNextThread(currentThread->tid);
 d2d:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 d32:	8b 00                	mov    (%eax),%eax
 d34:	89 04 24             	mov    %eax,(%esp)
 d37:	e8 49 fb ff ff       	call   885 <getNextThread>
 d3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
 d3f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 d43:	75 2d                	jne    d72 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
 d45:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 d4c:	e8 13 f6 ff ff       	call   364 <alarm>
 d51:	85 c0                	test   %eax,%eax
 d53:	0f 89 c1 00 00 00    	jns    e1a <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
 d59:	c7 44 24 04 cc 0f 00 	movl   $0xfcc,0x4(%esp)
 d60:	00 
 d61:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d68:	e8 d6 f6 ff ff       	call   443 <printf>
      exit();
 d6d:	e8 22 f5 ff ff       	call   294 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
 d72:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 d73:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 d78:	89 e2                	mov    %esp,%edx
 d7a:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
 d7d:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 d82:	89 ea                	mov    %ebp,%edx
 d84:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
 d87:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 d8c:	8b 40 10             	mov    0x10(%eax),%eax
 d8f:	83 f8 02             	cmp    $0x2,%eax
 d92:	75 0c                	jne    da0 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
 d94:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 d99:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
 da0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 da3:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 da9:	05 a0 14 00 00       	add    $0x14a0,%eax
 dae:	a3 a0 5d 00 00       	mov    %eax,0x5da0

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
 db3:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 db8:	8b 40 04             	mov    0x4(%eax),%eax
 dbb:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 dbd:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 dc2:	8b 40 08             	mov    0x8(%eax),%eax
 dc5:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
 dc7:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 dce:	e8 91 f5 ff ff       	call   364 <alarm>
 dd3:	85 c0                	test   %eax,%eax
 dd5:	79 19                	jns    df0 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
 dd7:	c7 44 24 04 cc 0f 00 	movl   $0xfcc,0x4(%esp)
 dde:	00 
 ddf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 de6:	e8 58 f6 ff ff       	call   443 <printf>
      exit();
 deb:	e8 a4 f4 ff ff       	call   294 <exit>
    }  
    currentThread->state=T_RUNNING;
 df0:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 df5:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
 dfc:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 e01:	8b 40 14             	mov    0x14(%eax),%eax
 e04:	83 f8 01             	cmp    $0x1,%eax
 e07:	75 10                	jne    e19 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
 e09:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 e0e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
 e15:	5d                   	pop    %ebp
 e16:	c3                   	ret    
 e17:	eb 01                	jmp    e1a <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
 e19:	61                   	popa   
    }
  }
}
 e1a:	c9                   	leave  
 e1b:	c3                   	ret    

00000e1c <uthread_self>:

int
uthread_self(void)
{
 e1c:	55                   	push   %ebp
 e1d:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 e1f:	a1 a0 5d 00 00       	mov    0x5da0,%eax
 e24:	8b 00                	mov    (%eax),%eax
 e26:	5d                   	pop    %ebp
 e27:	c3                   	ret    

00000e28 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
 e28:	55                   	push   %ebp
 e29:	89 e5                	mov    %esp,%ebp
 e2b:	53                   	push   %ebx
 e2c:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
 e2f:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e32:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
 e35:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e38:	89 c3                	mov    %eax,%ebx
 e3a:	89 d8                	mov    %ebx,%eax
 e3c:	f0 87 02             	lock xchg %eax,(%edx)
 e3f:	89 c3                	mov    %eax,%ebx
 e41:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 e44:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
 e47:	83 c4 10             	add    $0x10,%esp
 e4a:	5b                   	pop    %ebx
 e4b:	5d                   	pop    %ebp
 e4c:	c3                   	ret    

00000e4d <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
 e4d:	55                   	push   %ebp
 e4e:	89 e5                	mov    %esp,%ebp
 e50:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
 e53:	8b 45 08             	mov    0x8(%ebp),%eax
 e56:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
 e5d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 e61:	74 0c                	je     e6f <binary_semaphore_init+0x22>
    semaphore->thread=-1;
 e63:	8b 45 08             	mov    0x8(%ebp),%eax
 e66:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
 e6d:	eb 0b                	jmp    e7a <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
 e6f:	e8 a8 ff ff ff       	call   e1c <uthread_self>
 e74:	8b 55 08             	mov    0x8(%ebp),%edx
 e77:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
 e7a:	8b 55 0c             	mov    0xc(%ebp),%edx
 e7d:	8b 45 08             	mov    0x8(%ebp),%eax
 e80:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
 e82:	8b 45 08             	mov    0x8(%ebp),%eax
 e85:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
 e8c:	c9                   	leave  
 e8d:	c3                   	ret    

00000e8e <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
 e8e:	55                   	push   %ebp
 e8f:	89 e5                	mov    %esp,%ebp
 e91:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
 e94:	8b 45 08             	mov    0x8(%ebp),%eax
 e97:	8b 40 08             	mov    0x8(%eax),%eax
 e9a:	85 c0                	test   %eax,%eax
 e9c:	75 20                	jne    ebe <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 e9e:	8b 45 08             	mov    0x8(%ebp),%eax
 ea1:	8b 40 04             	mov    0x4(%eax),%eax
 ea4:	89 44 24 08          	mov    %eax,0x8(%esp)
 ea8:	c7 44 24 04 f0 0f 00 	movl   $0xff0,0x4(%esp)
 eaf:	00 
 eb0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 eb7:	e8 87 f5 ff ff       	call   443 <printf>
    return;
 ebc:	eb 3a                	jmp    ef8 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
 ebe:	e8 59 ff ff ff       	call   e1c <uthread_self>
 ec3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
 ec6:	8b 45 08             	mov    0x8(%ebp),%eax
 ec9:	8b 40 04             	mov    0x4(%eax),%eax
 ecc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 ecf:	74 27                	je     ef8 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 ed1:	eb 05                	jmp    ed8 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
 ed3:	e8 43 fe ff ff       	call   d1b <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 ed8:	8b 45 08             	mov    0x8(%ebp),%eax
 edb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 ee2:	00 
 ee3:	89 04 24             	mov    %eax,(%esp)
 ee6:	e8 3d ff ff ff       	call   e28 <xchg>
 eeb:	85 c0                	test   %eax,%eax
 eed:	74 e4                	je     ed3 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
 eef:	8b 45 08             	mov    0x8(%ebp),%eax
 ef2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ef5:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
 ef8:	c9                   	leave  
 ef9:	c3                   	ret    

00000efa <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
 efa:	55                   	push   %ebp
 efb:	89 e5                	mov    %esp,%ebp
 efd:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
 f00:	8b 45 08             	mov    0x8(%ebp),%eax
 f03:	8b 40 08             	mov    0x8(%eax),%eax
 f06:	85 c0                	test   %eax,%eax
 f08:	75 20                	jne    f2a <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 f0a:	8b 45 08             	mov    0x8(%ebp),%eax
 f0d:	8b 40 04             	mov    0x4(%eax),%eax
 f10:	89 44 24 08          	mov    %eax,0x8(%esp)
 f14:	c7 44 24 04 20 10 00 	movl   $0x1020,0x4(%esp)
 f1b:	00 
 f1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f23:	e8 1b f5 ff ff       	call   443 <printf>
    return;
 f28:	eb 2f                	jmp    f59 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
 f2a:	e8 ed fe ff ff       	call   e1c <uthread_self>
 f2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
 f32:	8b 45 08             	mov    0x8(%ebp),%eax
 f35:	8b 00                	mov    (%eax),%eax
 f37:	85 c0                	test   %eax,%eax
 f39:	75 1e                	jne    f59 <binary_semaphore_up+0x5f>
 f3b:	8b 45 08             	mov    0x8(%ebp),%eax
 f3e:	8b 40 04             	mov    0x4(%eax),%eax
 f41:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 f44:	75 13                	jne    f59 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
 f46:	8b 45 08             	mov    0x8(%ebp),%eax
 f49:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
 f50:	8b 45 08             	mov    0x8(%ebp),%eax
 f53:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
 f59:	c9                   	leave  
 f5a:	c3                   	ret    
