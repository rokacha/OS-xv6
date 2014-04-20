
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

00000354 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 354:	55                   	push   %ebp
 355:	89 e5                	mov    %esp,%ebp
 357:	83 ec 28             	sub    $0x28,%esp
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 360:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 367:	00 
 368:	8d 45 f4             	lea    -0xc(%ebp),%eax
 36b:	89 44 24 04          	mov    %eax,0x4(%esp)
 36f:	8b 45 08             	mov    0x8(%ebp),%eax
 372:	89 04 24             	mov    %eax,(%esp)
 375:	e8 3a ff ff ff       	call   2b4 <write>
}
 37a:	c9                   	leave  
 37b:	c3                   	ret    

0000037c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 37c:	55                   	push   %ebp
 37d:	89 e5                	mov    %esp,%ebp
 37f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 382:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 389:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 38d:	74 17                	je     3a6 <printint+0x2a>
 38f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 393:	79 11                	jns    3a6 <printint+0x2a>
    neg = 1;
 395:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 39c:	8b 45 0c             	mov    0xc(%ebp),%eax
 39f:	f7 d8                	neg    %eax
 3a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3a4:	eb 06                	jmp    3ac <printint+0x30>
  } else {
    x = xx;
 3a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b9:	ba 00 00 00 00       	mov    $0x0,%edx
 3be:	f7 f1                	div    %ecx
 3c0:	89 d0                	mov    %edx,%eax
 3c2:	0f b6 90 3c 0a 00 00 	movzbl 0xa3c(%eax),%edx
 3c9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3cc:	03 45 f4             	add    -0xc(%ebp),%eax
 3cf:	88 10                	mov    %dl,(%eax)
 3d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3d5:	8b 55 10             	mov    0x10(%ebp),%edx
 3d8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3db:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3de:	ba 00 00 00 00       	mov    $0x0,%edx
 3e3:	f7 75 d4             	divl   -0x2c(%ebp)
 3e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3ed:	75 c4                	jne    3b3 <printint+0x37>
  if(neg)
 3ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3f3:	74 2a                	je     41f <printint+0xa3>
    buf[i++] = '-';
 3f5:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3f8:	03 45 f4             	add    -0xc(%ebp),%eax
 3fb:	c6 00 2d             	movb   $0x2d,(%eax)
 3fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 402:	eb 1b                	jmp    41f <printint+0xa3>
    putc(fd, buf[i]);
 404:	8d 45 dc             	lea    -0x24(%ebp),%eax
 407:	03 45 f4             	add    -0xc(%ebp),%eax
 40a:	0f b6 00             	movzbl (%eax),%eax
 40d:	0f be c0             	movsbl %al,%eax
 410:	89 44 24 04          	mov    %eax,0x4(%esp)
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	89 04 24             	mov    %eax,(%esp)
 41a:	e8 35 ff ff ff       	call   354 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 41f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 423:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 427:	79 db                	jns    404 <printint+0x88>
    putc(fd, buf[i]);
}
 429:	c9                   	leave  
 42a:	c3                   	ret    

0000042b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 42b:	55                   	push   %ebp
 42c:	89 e5                	mov    %esp,%ebp
 42e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 431:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 438:	8d 45 0c             	lea    0xc(%ebp),%eax
 43b:	83 c0 04             	add    $0x4,%eax
 43e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 441:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 448:	e9 7d 01 00 00       	jmp    5ca <printf+0x19f>
    c = fmt[i] & 0xff;
 44d:	8b 55 0c             	mov    0xc(%ebp),%edx
 450:	8b 45 f0             	mov    -0x10(%ebp),%eax
 453:	01 d0                	add    %edx,%eax
 455:	0f b6 00             	movzbl (%eax),%eax
 458:	0f be c0             	movsbl %al,%eax
 45b:	25 ff 00 00 00       	and    $0xff,%eax
 460:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 463:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 467:	75 2c                	jne    495 <printf+0x6a>
      if(c == '%'){
 469:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 46d:	75 0c                	jne    47b <printf+0x50>
        state = '%';
 46f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 476:	e9 4b 01 00 00       	jmp    5c6 <printf+0x19b>
      } else {
        putc(fd, c);
 47b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 47e:	0f be c0             	movsbl %al,%eax
 481:	89 44 24 04          	mov    %eax,0x4(%esp)
 485:	8b 45 08             	mov    0x8(%ebp),%eax
 488:	89 04 24             	mov    %eax,(%esp)
 48b:	e8 c4 fe ff ff       	call   354 <putc>
 490:	e9 31 01 00 00       	jmp    5c6 <printf+0x19b>
      }
    } else if(state == '%'){
 495:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 499:	0f 85 27 01 00 00    	jne    5c6 <printf+0x19b>
      if(c == 'd'){
 49f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4a3:	75 2d                	jne    4d2 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4a8:	8b 00                	mov    (%eax),%eax
 4aa:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4b1:	00 
 4b2:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4b9:	00 
 4ba:	89 44 24 04          	mov    %eax,0x4(%esp)
 4be:	8b 45 08             	mov    0x8(%ebp),%eax
 4c1:	89 04 24             	mov    %eax,(%esp)
 4c4:	e8 b3 fe ff ff       	call   37c <printint>
        ap++;
 4c9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4cd:	e9 ed 00 00 00       	jmp    5bf <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4d2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4d6:	74 06                	je     4de <printf+0xb3>
 4d8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4dc:	75 2d                	jne    50b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4de:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e1:	8b 00                	mov    (%eax),%eax
 4e3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4ea:	00 
 4eb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4f2:	00 
 4f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f7:	8b 45 08             	mov    0x8(%ebp),%eax
 4fa:	89 04 24             	mov    %eax,(%esp)
 4fd:	e8 7a fe ff ff       	call   37c <printint>
        ap++;
 502:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 506:	e9 b4 00 00 00       	jmp    5bf <printf+0x194>
      } else if(c == 's'){
 50b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 50f:	75 46                	jne    557 <printf+0x12c>
        s = (char*)*ap;
 511:	8b 45 e8             	mov    -0x18(%ebp),%eax
 514:	8b 00                	mov    (%eax),%eax
 516:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 519:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 51d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 521:	75 27                	jne    54a <printf+0x11f>
          s = "(null)";
 523:	c7 45 f4 ef 07 00 00 	movl   $0x7ef,-0xc(%ebp)
        while(*s != 0){
 52a:	eb 1e                	jmp    54a <printf+0x11f>
          putc(fd, *s);
 52c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52f:	0f b6 00             	movzbl (%eax),%eax
 532:	0f be c0             	movsbl %al,%eax
 535:	89 44 24 04          	mov    %eax,0x4(%esp)
 539:	8b 45 08             	mov    0x8(%ebp),%eax
 53c:	89 04 24             	mov    %eax,(%esp)
 53f:	e8 10 fe ff ff       	call   354 <putc>
          s++;
 544:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 548:	eb 01                	jmp    54b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 54a:	90                   	nop
 54b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54e:	0f b6 00             	movzbl (%eax),%eax
 551:	84 c0                	test   %al,%al
 553:	75 d7                	jne    52c <printf+0x101>
 555:	eb 68                	jmp    5bf <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 557:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 55b:	75 1d                	jne    57a <printf+0x14f>
        putc(fd, *ap);
 55d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 560:	8b 00                	mov    (%eax),%eax
 562:	0f be c0             	movsbl %al,%eax
 565:	89 44 24 04          	mov    %eax,0x4(%esp)
 569:	8b 45 08             	mov    0x8(%ebp),%eax
 56c:	89 04 24             	mov    %eax,(%esp)
 56f:	e8 e0 fd ff ff       	call   354 <putc>
        ap++;
 574:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 578:	eb 45                	jmp    5bf <printf+0x194>
      } else if(c == '%'){
 57a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 57e:	75 17                	jne    597 <printf+0x16c>
        putc(fd, c);
 580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 583:	0f be c0             	movsbl %al,%eax
 586:	89 44 24 04          	mov    %eax,0x4(%esp)
 58a:	8b 45 08             	mov    0x8(%ebp),%eax
 58d:	89 04 24             	mov    %eax,(%esp)
 590:	e8 bf fd ff ff       	call   354 <putc>
 595:	eb 28                	jmp    5bf <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 597:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 59e:	00 
 59f:	8b 45 08             	mov    0x8(%ebp),%eax
 5a2:	89 04 24             	mov    %eax,(%esp)
 5a5:	e8 aa fd ff ff       	call   354 <putc>
        putc(fd, c);
 5aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ad:	0f be c0             	movsbl %al,%eax
 5b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b4:	8b 45 08             	mov    0x8(%ebp),%eax
 5b7:	89 04 24             	mov    %eax,(%esp)
 5ba:	e8 95 fd ff ff       	call   354 <putc>
      }
      state = 0;
 5bf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5ca:	8b 55 0c             	mov    0xc(%ebp),%edx
 5cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d0:	01 d0                	add    %edx,%eax
 5d2:	0f b6 00             	movzbl (%eax),%eax
 5d5:	84 c0                	test   %al,%al
 5d7:	0f 85 70 fe ff ff    	jne    44d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5dd:	c9                   	leave  
 5de:	c3                   	ret    
 5df:	90                   	nop

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e6:	8b 45 08             	mov    0x8(%ebp),%eax
 5e9:	83 e8 08             	sub    $0x8,%eax
 5ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ef:	a1 58 0a 00 00       	mov    0xa58,%eax
 5f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f7:	eb 24                	jmp    61d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fc:	8b 00                	mov    (%eax),%eax
 5fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 601:	77 12                	ja     615 <free+0x35>
 603:	8b 45 f8             	mov    -0x8(%ebp),%eax
 606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 609:	77 24                	ja     62f <free+0x4f>
 60b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60e:	8b 00                	mov    (%eax),%eax
 610:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 613:	77 1a                	ja     62f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 615:	8b 45 fc             	mov    -0x4(%ebp),%eax
 618:	8b 00                	mov    (%eax),%eax
 61a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 623:	76 d4                	jbe    5f9 <free+0x19>
 625:	8b 45 fc             	mov    -0x4(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62d:	76 ca                	jbe    5f9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 62f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 632:	8b 40 04             	mov    0x4(%eax),%eax
 635:	c1 e0 03             	shl    $0x3,%eax
 638:	89 c2                	mov    %eax,%edx
 63a:	03 55 f8             	add    -0x8(%ebp),%edx
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	39 c2                	cmp    %eax,%edx
 644:	75 24                	jne    66a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 646:	8b 45 f8             	mov    -0x8(%ebp),%eax
 649:	8b 50 04             	mov    0x4(%eax),%edx
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	8b 00                	mov    (%eax),%eax
 651:	8b 40 04             	mov    0x4(%eax),%eax
 654:	01 c2                	add    %eax,%edx
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	8b 10                	mov    (%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	89 10                	mov    %edx,(%eax)
 668:	eb 0a                	jmp    674 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 10                	mov    (%eax),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 40 04             	mov    0x4(%eax),%eax
 67a:	c1 e0 03             	shl    $0x3,%eax
 67d:	03 45 fc             	add    -0x4(%ebp),%eax
 680:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 683:	75 20                	jne    6a5 <free+0xc5>
    p->s.size += bp->s.size;
 685:	8b 45 fc             	mov    -0x4(%ebp),%eax
 688:	8b 50 04             	mov    0x4(%eax),%edx
 68b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68e:	8b 40 04             	mov    0x4(%eax),%eax
 691:	01 c2                	add    %eax,%edx
 693:	8b 45 fc             	mov    -0x4(%ebp),%eax
 696:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 699:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69c:	8b 10                	mov    (%eax),%edx
 69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a1:	89 10                	mov    %edx,(%eax)
 6a3:	eb 08                	jmp    6ad <free+0xcd>
  } else
    p->s.ptr = bp;
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ab:	89 10                	mov    %edx,(%eax)
  freep = p;
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	a3 58 0a 00 00       	mov    %eax,0xa58
}
 6b5:	c9                   	leave  
 6b6:	c3                   	ret    

000006b7 <morecore>:

static Header*
morecore(uint nu)
{
 6b7:	55                   	push   %ebp
 6b8:	89 e5                	mov    %esp,%ebp
 6ba:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6bd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6c4:	77 07                	ja     6cd <morecore+0x16>
    nu = 4096;
 6c6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6cd:	8b 45 08             	mov    0x8(%ebp),%eax
 6d0:	c1 e0 03             	shl    $0x3,%eax
 6d3:	89 04 24             	mov    %eax,(%esp)
 6d6:	e8 41 fc ff ff       	call   31c <sbrk>
 6db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6de:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e2:	75 07                	jne    6eb <morecore+0x34>
    return 0;
 6e4:	b8 00 00 00 00       	mov    $0x0,%eax
 6e9:	eb 22                	jmp    70d <morecore+0x56>
  hp = (Header*)p;
 6eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f4:	8b 55 08             	mov    0x8(%ebp),%edx
 6f7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fd:	83 c0 08             	add    $0x8,%eax
 700:	89 04 24             	mov    %eax,(%esp)
 703:	e8 d8 fe ff ff       	call   5e0 <free>
  return freep;
 708:	a1 58 0a 00 00       	mov    0xa58,%eax
}
 70d:	c9                   	leave  
 70e:	c3                   	ret    

0000070f <malloc>:

void*
malloc(uint nbytes)
{
 70f:	55                   	push   %ebp
 710:	89 e5                	mov    %esp,%ebp
 712:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 715:	8b 45 08             	mov    0x8(%ebp),%eax
 718:	83 c0 07             	add    $0x7,%eax
 71b:	c1 e8 03             	shr    $0x3,%eax
 71e:	83 c0 01             	add    $0x1,%eax
 721:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 724:	a1 58 0a 00 00       	mov    0xa58,%eax
 729:	89 45 f0             	mov    %eax,-0x10(%ebp)
 72c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 730:	75 23                	jne    755 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 732:	c7 45 f0 50 0a 00 00 	movl   $0xa50,-0x10(%ebp)
 739:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73c:	a3 58 0a 00 00       	mov    %eax,0xa58
 741:	a1 58 0a 00 00       	mov    0xa58,%eax
 746:	a3 50 0a 00 00       	mov    %eax,0xa50
    base.s.size = 0;
 74b:	c7 05 54 0a 00 00 00 	movl   $0x0,0xa54
 752:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 755:	8b 45 f0             	mov    -0x10(%ebp),%eax
 758:	8b 00                	mov    (%eax),%eax
 75a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 75d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 760:	8b 40 04             	mov    0x4(%eax),%eax
 763:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 766:	72 4d                	jb     7b5 <malloc+0xa6>
      if(p->s.size == nunits)
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	8b 40 04             	mov    0x4(%eax),%eax
 76e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 771:	75 0c                	jne    77f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	8b 10                	mov    (%eax),%edx
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	89 10                	mov    %edx,(%eax)
 77d:	eb 26                	jmp    7a5 <malloc+0x96>
      else {
        p->s.size -= nunits;
 77f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 782:	8b 40 04             	mov    0x4(%eax),%eax
 785:	89 c2                	mov    %eax,%edx
 787:	2b 55 ec             	sub    -0x14(%ebp),%edx
 78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 790:	8b 45 f4             	mov    -0xc(%ebp),%eax
 793:	8b 40 04             	mov    0x4(%eax),%eax
 796:	c1 e0 03             	shl    $0x3,%eax
 799:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	a3 58 0a 00 00       	mov    %eax,0xa58
      return (void*)(p + 1);
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	83 c0 08             	add    $0x8,%eax
 7b3:	eb 38                	jmp    7ed <malloc+0xde>
    }
    if(p == freep)
 7b5:	a1 58 0a 00 00       	mov    0xa58,%eax
 7ba:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7bd:	75 1b                	jne    7da <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7c2:	89 04 24             	mov    %eax,(%esp)
 7c5:	e8 ed fe ff ff       	call   6b7 <morecore>
 7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d1:	75 07                	jne    7da <malloc+0xcb>
        return 0;
 7d3:	b8 00 00 00 00       	mov    $0x0,%eax
 7d8:	eb 13                	jmp    7ed <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 00                	mov    (%eax),%eax
 7e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7e8:	e9 70 ff ff ff       	jmp    75d <malloc+0x4e>
}
 7ed:	c9                   	leave  
 7ee:	c3                   	ret    
