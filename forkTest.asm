
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
 3da:	0f b6 90 6c 0e 00 00 	movzbl 0xe6c(%eax),%edx
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
 53b:	c7 45 f4 cc 0a 00 00 	movl   $0xacc,-0xc(%ebp)
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
 607:	a1 88 0e 00 00       	mov    0xe88,%eax
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
 6c8:	a3 88 0e 00 00       	mov    %eax,0xe88
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
 720:	a1 88 0e 00 00       	mov    0xe88,%eax
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
 73c:	a1 88 0e 00 00       	mov    0xe88,%eax
 741:	89 45 f0             	mov    %eax,-0x10(%ebp)
 744:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 748:	75 23                	jne    76d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 74a:	c7 45 f0 80 0e 00 00 	movl   $0xe80,-0x10(%ebp)
 751:	8b 45 f0             	mov    -0x10(%ebp),%eax
 754:	a3 88 0e 00 00       	mov    %eax,0xe88
 759:	a1 88 0e 00 00       	mov    0xe88,%eax
 75e:	a3 80 0e 00 00       	mov    %eax,0xe80
    base.s.size = 0;
 763:	c7 05 84 0e 00 00 00 	movl   $0x0,0xe84
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
 7c0:	a3 88 0e 00 00       	mov    %eax,0xe88
      return (void*)(p + 1);
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	83 c0 08             	add    $0x8,%eax
 7cb:	eb 38                	jmp    805 <malloc+0xde>
    }
    if(p == freep)
 7cd:	a1 88 0e 00 00       	mov    0xe88,%eax
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

00000808 <getRunningThread>:
  int current;
} tTable;

int
getRunningThread()
{
 808:	55                   	push   %ebp
 809:	89 e5                	mov    %esp,%ebp
 80b:	83 ec 10             	sub    $0x10,%esp
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 80e:	c7 45 f8 a0 0e 00 00 	movl   $0xea0,-0x8(%ebp)
 815:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 81c:	eb 18                	jmp    836 <getRunningThread+0x2e>
  {
    if(t->state==T_RUNNING)
 81e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 821:	8b 40 10             	mov    0x10(%eax),%eax
 824:	83 f8 02             	cmp    $0x2,%eax
 827:	75 05                	jne    82e <getRunningThread+0x26>
      return i;
 829:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82c:	eb 16                	jmp    844 <getRunningThread+0x3c>
getRunningThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 82e:	83 45 f8 18          	addl   $0x18,-0x8(%ebp)
 832:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 836:	81 7d f8 a0 14 00 00 	cmpl   $0x14a0,-0x8(%ebp)
 83d:	76 df                	jbe    81e <getRunningThread+0x16>
  {
    if(t->state==T_RUNNING)
      return i;
  }
  return -1;
 83f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 844:	c9                   	leave  
 845:	c3                   	ret    

00000846 <getNextThread>:

int
getNextThread()
{
 846:	55                   	push   %ebp
 847:	89 e5                	mov    %esp,%ebp
 849:	83 ec 10             	sub    $0x10,%esp
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 84c:	c7 45 f8 a0 0e 00 00 	movl   $0xea0,-0x8(%ebp)
 853:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 85a:	eb 18                	jmp    874 <getNextThread+0x2e>
  {
    if(t->state==T_RUNNABLE)
 85c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85f:	8b 40 10             	mov    0x10(%eax),%eax
 862:	83 f8 03             	cmp    $0x3,%eax
 865:	75 05                	jne    86c <getNextThread+0x26>
      return i;
 867:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86a:	eb 16                	jmp    882 <getNextThread+0x3c>
getNextThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 86c:	83 45 f8 18          	addl   $0x18,-0x8(%ebp)
 870:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 874:	81 7d f8 a0 14 00 00 	cmpl   $0x14a0,-0x8(%ebp)
 87b:	76 df                	jbe    85c <getNextThread+0x16>
  {
    if(t->state==T_RUNNABLE)
      return i;
  }
  return -1;
 87d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 882:	c9                   	leave  
 883:	c3                   	ret    

00000884 <allocThread>:

static uthread_p
allocThread()
{
 884:	55                   	push   %ebp
 885:	89 e5                	mov    %esp,%ebp
 887:	83 ec 28             	sub    $0x28,%esp
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 88a:	c7 45 f0 a0 0e 00 00 	movl   $0xea0,-0x10(%ebp)
 891:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 898:	eb 12                	jmp    8ac <allocThread+0x28>
  {
    if(t->state==T_FREE)
 89a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 89d:	8b 40 10             	mov    0x10(%eax),%eax
 8a0:	85 c0                	test   %eax,%eax
 8a2:	74 18                	je     8bc <allocThread+0x38>
allocThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 8a4:	83 45 f0 18          	addl   $0x18,-0x10(%ebp)
 8a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 8ac:	81 7d f0 a0 14 00 00 	cmpl   $0x14a0,-0x10(%ebp)
 8b3:	76 e5                	jbe    89a <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 8b5:	b8 00 00 00 00       	mov    $0x0,%eax
 8ba:	eb 64                	jmp    920 <allocThread+0x9c>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
 8bc:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 8bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8c3:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 8c5:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 8cc:	e8 56 fe ff ff       	call   727 <malloc>
 8d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
 8d4:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 8d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8da:	8b 40 0c             	mov    0xc(%eax),%eax
 8dd:	89 c2                	mov    %eax,%edx
 8df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e2:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 8e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e8:	8b 40 0c             	mov    0xc(%eax),%eax
 8eb:	89 c2                	mov    %eax,%edx
 8ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f0:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 8f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 8fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 900:	8b 40 08             	mov    0x8(%eax),%eax
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 903:	ba 0d 0a 00 00       	mov    $0xa0d,%edx
 908:	89 c4                	mov    %eax,%esp
 90a:	52                   	push   %edx
 90b:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 90d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 910:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 913:	8b 45 f0             	mov    -0x10(%ebp),%eax
 916:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 91d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 920:	c9                   	leave  
 921:	c3                   	ret    

00000922 <uthread_init>:

void 
uthread_init()
{  
 922:	55                   	push   %ebp
 923:	89 e5                	mov    %esp,%ebp
 925:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 928:	c7 05 a0 14 00 00 00 	movl   $0x0,0x14a0
 92f:	00 00 00 
  tTable.current=0;
 932:	c7 05 a4 14 00 00 00 	movl   $0x0,0x14a4
 939:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 93c:	e8 43 ff ff ff       	call   884 <allocThread>
 941:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 944:	89 e9                	mov    %ebp,%ecx
 946:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 948:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 94b:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 94e:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 951:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 954:	8b 45 f4             	mov    -0xc(%ebp),%eax
 957:	8b 50 08             	mov    0x8(%eax),%edx
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	8b 40 04             	mov    0x4(%eax),%eax
 960:	89 d1                	mov    %edx,%ecx
 962:	29 c1                	sub    %eax,%ecx
 964:	8b 45 f4             	mov    -0xc(%ebp),%eax
 967:	8b 40 04             	mov    0x4(%eax),%eax
 96a:	89 c2                	mov    %eax,%edx
 96c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96f:	8b 40 0c             	mov    0xc(%eax),%eax
 972:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 976:	89 54 24 04          	mov    %edx,0x4(%esp)
 97a:	89 04 24             	mov    %eax,(%esp)
 97d:	e8 cc f8 ff ff       	call   24e <memmove>
  mainT->state = T_RUNNABLE;
 982:	8b 45 f4             	mov    -0xc(%ebp),%eax
 985:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  if(signal(SIGALRM,uthread_yield)<0)
 98c:	c7 44 24 04 12 0a 00 	movl   $0xa12,0x4(%esp)
 993:	00 
 994:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 99b:	e8 b4 f9 ff ff       	call   354 <signal>
 9a0:	85 c0                	test   %eax,%eax
 9a2:	79 19                	jns    9bd <uthread_init+0x9b>
  {
    printf(1,"Cant register the alarm signal");
 9a4:	c7 44 24 04 d4 0a 00 	movl   $0xad4,0x4(%esp)
 9ab:	00 
 9ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9b3:	e8 8b fa ff ff       	call   443 <printf>
    exit();
 9b8:	e8 d7 f8 ff ff       	call   294 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 9bd:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 9c4:	e8 9b f9 ff ff       	call   364 <alarm>
 9c9:	85 c0                	test   %eax,%eax
 9cb:	79 19                	jns    9e6 <uthread_init+0xc4>
  {
    printf(1,"Cant activate alarm system call");
 9cd:	c7 44 24 04 f4 0a 00 	movl   $0xaf4,0x4(%esp)
 9d4:	00 
 9d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9dc:	e8 62 fa ff ff       	call   443 <printf>
    exit();
 9e1:	e8 ae f8 ff ff       	call   294 <exit>
  }
  
}
 9e6:	c9                   	leave  
 9e7:	c3                   	ret    

000009e8 <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 9e8:	55                   	push   %ebp
 9e9:	89 e5                	mov    %esp,%ebp
 9eb:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 9ee:	e8 91 fe ff ff       	call   884 <allocThread>
 9f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 9f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 9f9:	8b 55 08             	mov    0x8(%ebp),%edx
 9fc:	50                   	push   %eax
 9fd:	52                   	push   %edx
 9fe:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 a03:	89 50 04             	mov    %edx,0x4(%eax)
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  
  return t->tid;
 a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a09:	8b 00                	mov    (%eax),%eax
}
 a0b:	c9                   	leave  
 a0c:	c3                   	ret    

00000a0d <uthread_exit>:

void 
uthread_exit()
{
 a0d:	55                   	push   %ebp
 a0e:	89 e5                	mov    %esp,%ebp
  //needs to be filled
}
 a10:	5d                   	pop    %ebp
 a11:	c3                   	ret    

00000a12 <uthread_yield>:

void 
uthread_yield()
{
 a12:	55                   	push   %ebp
 a13:	89 e5                	mov    %esp,%ebp
 a15:	83 ec 28             	sub    $0x28,%esp
  
  uthread_p oldt;
  uthread_p newt;
  int old=getRunningThread();
 a18:	e8 eb fd ff ff       	call   808 <getRunningThread>
 a1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread();
 a20:	e8 21 fe ff ff       	call   846 <getNextThread>
 a25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(old<0)
 a28:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a2c:	79 19                	jns    a47 <uthread_yield+0x35>
  {
     printf(1,"Cant find running thread");
 a2e:	c7 44 24 04 14 0b 00 	movl   $0xb14,0x4(%esp)
 a35:	00 
 a36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a3d:	e8 01 fa ff ff       	call   443 <printf>
    exit();
 a42:	e8 4d f8 ff ff       	call   294 <exit>
  }
  if(new<0)
 a47:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a4b:	79 19                	jns    a66 <uthread_yield+0x54>
  {
     printf(1,"Cant find runnable thread");
 a4d:	c7 44 24 04 2d 0b 00 	movl   $0xb2d,0x4(%esp)
 a54:	00 
 a55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a5c:	e8 e2 f9 ff ff       	call   443 <printf>
    exit();
 a61:	e8 2e f8 ff ff       	call   294 <exit>
  }
oldt=&tTable.table[old];
 a66:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a69:	89 d0                	mov    %edx,%eax
 a6b:	01 c0                	add    %eax,%eax
 a6d:	01 d0                	add    %edx,%eax
 a6f:	c1 e0 03             	shl    $0x3,%eax
 a72:	05 a0 0e 00 00       	add    $0xea0,%eax
 a77:	89 45 ec             	mov    %eax,-0x14(%ebp)
newt=&tTable.table[new];
 a7a:	8b 55 f0             	mov    -0x10(%ebp),%edx
 a7d:	89 d0                	mov    %edx,%eax
 a7f:	01 c0                	add    %eax,%eax
 a81:	01 d0                	add    %edx,%eax
 a83:	c1 e0 03             	shl    $0x3,%eax
 a86:	05 a0 0e 00 00       	add    $0xea0,%eax
 a8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  
    asm("pusha");
 a8e:	60                   	pusha  
    STORE_ESP(oldt->esp);
 a8f:	89 e2                	mov    %esp,%edx
 a91:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a94:	89 50 04             	mov    %edx,0x4(%eax)
    oldt->state=T_RUNNABLE;
 a97:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a9a:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 aa1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 aa4:	8b 40 04             	mov    0x4(%eax),%eax
 aa7:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 aa9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 aac:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 ab3:	61                   	popa   
    if(oldt->firstTime==0)
 ab4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ab7:	8b 40 14             	mov    0x14(%eax),%eax
 aba:	85 c0                	test   %eax,%eax
 abc:	75 0b                	jne    ac9 <uthread_yield+0xb7>
    {
       asm("ret");////only firest time
 abe:	c3                   	ret    
       oldt->firstTime=1;
 abf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ac2:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   


}
 ac9:	c9                   	leave  
 aca:	c3                   	ret    
