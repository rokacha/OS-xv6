
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  for(i = 1; i < argc; i++)
   9:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  10:	00 
  11:	eb 45                	jmp    58 <main+0x58>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  13:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  17:	83 c0 01             	add    $0x1,%eax
  1a:	3b 45 08             	cmp    0x8(%ebp),%eax
  1d:	7d 07                	jge    26 <main+0x26>
  1f:	b8 a4 0c 00 00       	mov    $0xca4,%eax
  24:	eb 05                	jmp    2b <main+0x2b>
  26:	b8 a6 0c 00 00       	mov    $0xca6,%eax
  2b:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  2f:	c1 e2 02             	shl    $0x2,%edx
  32:	03 55 0c             	add    0xc(%ebp),%edx
  35:	8b 12                	mov    (%edx),%edx
  37:	89 44 24 0c          	mov    %eax,0xc(%esp)
  3b:	89 54 24 08          	mov    %edx,0x8(%esp)
  3f:	c7 44 24 04 a8 0c 00 	movl   $0xca8,0x4(%esp)
  46:	00 
  47:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4e:	e8 28 04 00 00       	call   47b <printf>
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  53:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  58:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5c:	3b 45 08             	cmp    0x8(%ebp),%eax
  5f:	7c b2                	jl     13 <main+0x13>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  61:	e8 66 02 00 00       	call   2cc <exit>
  66:	90                   	nop
  67:	90                   	nop

00000068 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	57                   	push   %edi
  6c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  70:	8b 55 10             	mov    0x10(%ebp),%edx
  73:	8b 45 0c             	mov    0xc(%ebp),%eax
  76:	89 cb                	mov    %ecx,%ebx
  78:	89 df                	mov    %ebx,%edi
  7a:	89 d1                	mov    %edx,%ecx
  7c:	fc                   	cld    
  7d:	f3 aa                	rep stos %al,%es:(%edi)
  7f:	89 ca                	mov    %ecx,%edx
  81:	89 fb                	mov    %edi,%ebx
  83:	89 5d 08             	mov    %ebx,0x8(%ebp)
  86:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  89:	5b                   	pop    %ebx
  8a:	5f                   	pop    %edi
  8b:	5d                   	pop    %ebp
  8c:	c3                   	ret    

0000008d <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
  8d:	55                   	push   %ebp
  8e:	89 e5                	mov    %esp,%ebp
  90:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  93:	8b 45 08             	mov    0x8(%ebp),%eax
  96:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  99:	90                   	nop
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 10             	movzbl (%eax),%edx
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	88 10                	mov    %dl,(%eax)
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 00             	movzbl (%eax),%eax
  ab:	84 c0                	test   %al,%al
  ad:	0f 95 c0             	setne  %al
  b0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  b8:	84 c0                	test   %al,%al
  ba:	75 de                	jne    9a <strcpy+0xd>
    ;
  return os;
  bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bf:	c9                   	leave  
  c0:	c3                   	ret    

000000c1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c4:	eb 08                	jmp    ce <strcmp+0xd>
    p++, q++;
  c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ca:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	8b 45 08             	mov    0x8(%ebp),%eax
  d1:	0f b6 00             	movzbl (%eax),%eax
  d4:	84 c0                	test   %al,%al
  d6:	74 10                	je     e8 <strcmp+0x27>
  d8:	8b 45 08             	mov    0x8(%ebp),%eax
  db:	0f b6 10             	movzbl (%eax),%edx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	0f b6 00             	movzbl (%eax),%eax
  e4:	38 c2                	cmp    %al,%dl
  e6:	74 de                	je     c6 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e8:	8b 45 08             	mov    0x8(%ebp),%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	0f b6 d0             	movzbl %al,%edx
  f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 c0             	movzbl %al,%eax
  fa:	89 d1                	mov    %edx,%ecx
  fc:	29 c1                	sub    %eax,%ecx
  fe:	89 c8                	mov    %ecx,%eax
}
 100:	5d                   	pop    %ebp
 101:	c3                   	ret    

00000102 <strlen>:

uint
strlen(char *s)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 108:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10f:	eb 04                	jmp    115 <strlen+0x13>
 111:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 115:	8b 45 fc             	mov    -0x4(%ebp),%eax
 118:	03 45 08             	add    0x8(%ebp),%eax
 11b:	0f b6 00             	movzbl (%eax),%eax
 11e:	84 c0                	test   %al,%al
 120:	75 ef                	jne    111 <strlen+0xf>
    ;
  return n;
 122:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 125:	c9                   	leave  
 126:	c3                   	ret    

00000127 <memset>:

void*
memset(void *dst, int c, uint n)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 12d:	8b 45 10             	mov    0x10(%ebp),%eax
 130:	89 44 24 08          	mov    %eax,0x8(%esp)
 134:	8b 45 0c             	mov    0xc(%ebp),%eax
 137:	89 44 24 04          	mov    %eax,0x4(%esp)
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 04 24             	mov    %eax,(%esp)
 141:	e8 22 ff ff ff       	call   68 <stosb>
  return dst;
 146:	8b 45 08             	mov    0x8(%ebp),%eax
}
 149:	c9                   	leave  
 14a:	c3                   	ret    

0000014b <strchr>:

char*
strchr(const char *s, char c)
{
 14b:	55                   	push   %ebp
 14c:	89 e5                	mov    %esp,%ebp
 14e:	83 ec 04             	sub    $0x4,%esp
 151:	8b 45 0c             	mov    0xc(%ebp),%eax
 154:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 157:	eb 14                	jmp    16d <strchr+0x22>
    if(*s == c)
 159:	8b 45 08             	mov    0x8(%ebp),%eax
 15c:	0f b6 00             	movzbl (%eax),%eax
 15f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 162:	75 05                	jne    169 <strchr+0x1e>
      return (char*)s;
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	eb 13                	jmp    17c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	84 c0                	test   %al,%al
 175:	75 e2                	jne    159 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 177:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17c:	c9                   	leave  
 17d:	c3                   	ret    

0000017e <gets>:

char*
gets(char *buf, int max)
{
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 184:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18b:	eb 44                	jmp    1d1 <gets+0x53>
    cc = read(0, &c, 1);
 18d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 194:	00 
 195:	8d 45 ef             	lea    -0x11(%ebp),%eax
 198:	89 44 24 04          	mov    %eax,0x4(%esp)
 19c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1a3:	e8 3c 01 00 00       	call   2e4 <read>
 1a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1af:	7e 2d                	jle    1de <gets+0x60>
      break;
    buf[i++] = c;
 1b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b4:	03 45 08             	add    0x8(%ebp),%eax
 1b7:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1bb:	88 10                	mov    %dl,(%eax)
 1bd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1c1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c5:	3c 0a                	cmp    $0xa,%al
 1c7:	74 16                	je     1df <gets+0x61>
 1c9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cd:	3c 0d                	cmp    $0xd,%al
 1cf:	74 0e                	je     1df <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1da:	7c b1                	jl     18d <gets+0xf>
 1dc:	eb 01                	jmp    1df <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1de:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e2:	03 45 08             	add    0x8(%ebp),%eax
 1e5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1eb:	c9                   	leave  
 1ec:	c3                   	ret    

000001ed <stat>:

int
stat(char *n, struct stat *st)
{
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
 1f0:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1fa:	00 
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	89 04 24             	mov    %eax,(%esp)
 201:	e8 06 01 00 00       	call   30c <open>
 206:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 209:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20d:	79 07                	jns    216 <stat+0x29>
    return -1;
 20f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 214:	eb 23                	jmp    239 <stat+0x4c>
  r = fstat(fd, st);
 216:	8b 45 0c             	mov    0xc(%ebp),%eax
 219:	89 44 24 04          	mov    %eax,0x4(%esp)
 21d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 220:	89 04 24             	mov    %eax,(%esp)
 223:	e8 fc 00 00 00       	call   324 <fstat>
 228:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22e:	89 04 24             	mov    %eax,(%esp)
 231:	e8 be 00 00 00       	call   2f4 <close>
  return r;
 236:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 239:	c9                   	leave  
 23a:	c3                   	ret    

0000023b <atoi>:

int
atoi(const char *s)
{
 23b:	55                   	push   %ebp
 23c:	89 e5                	mov    %esp,%ebp
 23e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 241:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 248:	eb 23                	jmp    26d <atoi+0x32>
    n = n*10 + *s++ - '0';
 24a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24d:	89 d0                	mov    %edx,%eax
 24f:	c1 e0 02             	shl    $0x2,%eax
 252:	01 d0                	add    %edx,%eax
 254:	01 c0                	add    %eax,%eax
 256:	89 c2                	mov    %eax,%edx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	0f b6 00             	movzbl (%eax),%eax
 25e:	0f be c0             	movsbl %al,%eax
 261:	01 d0                	add    %edx,%eax
 263:	83 e8 30             	sub    $0x30,%eax
 266:	89 45 fc             	mov    %eax,-0x4(%ebp)
 269:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x46>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c9                	jle    24a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 298:	eb 13                	jmp    2ad <memmove+0x27>
    *dst++ = *src++;
 29a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 29d:	0f b6 10             	movzbl (%eax),%edx
 2a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a3:	88 10                	mov    %dl,(%eax)
 2a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2a9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2b1:	0f 9f c0             	setg   %al
 2b4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2b8:	84 c0                	test   %al,%al
 2ba:	75 de                	jne    29a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bf:	c9                   	leave  
 2c0:	c3                   	ret    
 2c1:	90                   	nop
 2c2:	90                   	nop
 2c3:	90                   	nop

000002c4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c4:	b8 01 00 00 00       	mov    $0x1,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <exit>:
SYSCALL(exit)
 2cc:	b8 02 00 00 00       	mov    $0x2,%eax
 2d1:	cd 40                	int    $0x40
 2d3:	c3                   	ret    

000002d4 <wait>:
SYSCALL(wait)
 2d4:	b8 03 00 00 00       	mov    $0x3,%eax
 2d9:	cd 40                	int    $0x40
 2db:	c3                   	ret    

000002dc <pipe>:
SYSCALL(pipe)
 2dc:	b8 04 00 00 00       	mov    $0x4,%eax
 2e1:	cd 40                	int    $0x40
 2e3:	c3                   	ret    

000002e4 <read>:
SYSCALL(read)
 2e4:	b8 05 00 00 00       	mov    $0x5,%eax
 2e9:	cd 40                	int    $0x40
 2eb:	c3                   	ret    

000002ec <write>:
SYSCALL(write)
 2ec:	b8 10 00 00 00       	mov    $0x10,%eax
 2f1:	cd 40                	int    $0x40
 2f3:	c3                   	ret    

000002f4 <close>:
SYSCALL(close)
 2f4:	b8 15 00 00 00       	mov    $0x15,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <kill>:
SYSCALL(kill)
 2fc:	b8 06 00 00 00       	mov    $0x6,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <exec>:
SYSCALL(exec)
 304:	b8 07 00 00 00       	mov    $0x7,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <open>:
SYSCALL(open)
 30c:	b8 0f 00 00 00       	mov    $0xf,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <mknod>:
SYSCALL(mknod)
 314:	b8 11 00 00 00       	mov    $0x11,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <unlink>:
SYSCALL(unlink)
 31c:	b8 12 00 00 00       	mov    $0x12,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <fstat>:
SYSCALL(fstat)
 324:	b8 08 00 00 00       	mov    $0x8,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <link>:
SYSCALL(link)
 32c:	b8 13 00 00 00       	mov    $0x13,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <mkdir>:
SYSCALL(mkdir)
 334:	b8 14 00 00 00       	mov    $0x14,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <chdir>:
SYSCALL(chdir)
 33c:	b8 09 00 00 00       	mov    $0x9,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <dup>:
SYSCALL(dup)
 344:	b8 0a 00 00 00       	mov    $0xa,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <getpid>:
SYSCALL(getpid)
 34c:	b8 0b 00 00 00       	mov    $0xb,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <sbrk>:
SYSCALL(sbrk)
 354:	b8 0c 00 00 00       	mov    $0xc,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <sleep>:
SYSCALL(sleep)
 35c:	b8 0d 00 00 00       	mov    $0xd,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <uptime>:
SYSCALL(uptime)
 364:	b8 0e 00 00 00       	mov    $0xe,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <add_path>:
SYSCALL(add_path)
 36c:	b8 16 00 00 00       	mov    $0x16,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <wait2>:
SYSCALL(wait2)
 374:	b8 17 00 00 00       	mov    $0x17,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <getquanta>:
SYSCALL(getquanta)
 37c:	b8 18 00 00 00       	mov    $0x18,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <getqueue>:
SYSCALL(getqueue)
 384:	b8 19 00 00 00       	mov    $0x19,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <signal>:
SYSCALL(signal)
 38c:	b8 1a 00 00 00       	mov    $0x1a,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <sigsend>:
SYSCALL(sigsend)
 394:	b8 1b 00 00 00       	mov    $0x1b,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <alarm>:
SYSCALL(alarm)
 39c:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	83 ec 28             	sub    $0x28,%esp
 3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ad:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b7:	00 
 3b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 3bf:	8b 45 08             	mov    0x8(%ebp),%eax
 3c2:	89 04 24             	mov    %eax,(%esp)
 3c5:	e8 22 ff ff ff       	call   2ec <write>
}
 3ca:	c9                   	leave  
 3cb:	c3                   	ret    

000003cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3cc:	55                   	push   %ebp
 3cd:	89 e5                	mov    %esp,%ebp
 3cf:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3d9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3dd:	74 17                	je     3f6 <printint+0x2a>
 3df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3e3:	79 11                	jns    3f6 <printint+0x2a>
    neg = 1;
 3e5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	f7 d8                	neg    %eax
 3f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f4:	eb 06                	jmp    3fc <printint+0x30>
  } else {
    x = xx;
 3f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 403:	8b 4d 10             	mov    0x10(%ebp),%ecx
 406:	8b 45 ec             	mov    -0x14(%ebp),%eax
 409:	ba 00 00 00 00       	mov    $0x0,%edx
 40e:	f7 f1                	div    %ecx
 410:	89 d0                	mov    %edx,%eax
 412:	0f b6 90 64 10 00 00 	movzbl 0x1064(%eax),%edx
 419:	8d 45 dc             	lea    -0x24(%ebp),%eax
 41c:	03 45 f4             	add    -0xc(%ebp),%eax
 41f:	88 10                	mov    %dl,(%eax)
 421:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 425:	8b 55 10             	mov    0x10(%ebp),%edx
 428:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 42b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 42e:	ba 00 00 00 00       	mov    $0x0,%edx
 433:	f7 75 d4             	divl   -0x2c(%ebp)
 436:	89 45 ec             	mov    %eax,-0x14(%ebp)
 439:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43d:	75 c4                	jne    403 <printint+0x37>
  if(neg)
 43f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 443:	74 2a                	je     46f <printint+0xa3>
    buf[i++] = '-';
 445:	8d 45 dc             	lea    -0x24(%ebp),%eax
 448:	03 45 f4             	add    -0xc(%ebp),%eax
 44b:	c6 00 2d             	movb   $0x2d,(%eax)
 44e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 452:	eb 1b                	jmp    46f <printint+0xa3>
    putc(fd, buf[i]);
 454:	8d 45 dc             	lea    -0x24(%ebp),%eax
 457:	03 45 f4             	add    -0xc(%ebp),%eax
 45a:	0f b6 00             	movzbl (%eax),%eax
 45d:	0f be c0             	movsbl %al,%eax
 460:	89 44 24 04          	mov    %eax,0x4(%esp)
 464:	8b 45 08             	mov    0x8(%ebp),%eax
 467:	89 04 24             	mov    %eax,(%esp)
 46a:	e8 35 ff ff ff       	call   3a4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 46f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 473:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 477:	79 db                	jns    454 <printint+0x88>
    putc(fd, buf[i]);
}
 479:	c9                   	leave  
 47a:	c3                   	ret    

0000047b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 47b:	55                   	push   %ebp
 47c:	89 e5                	mov    %esp,%ebp
 47e:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 481:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 488:	8d 45 0c             	lea    0xc(%ebp),%eax
 48b:	83 c0 04             	add    $0x4,%eax
 48e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 491:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 498:	e9 7d 01 00 00       	jmp    61a <printf+0x19f>
    c = fmt[i] & 0xff;
 49d:	8b 55 0c             	mov    0xc(%ebp),%edx
 4a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4a3:	01 d0                	add    %edx,%eax
 4a5:	0f b6 00             	movzbl (%eax),%eax
 4a8:	0f be c0             	movsbl %al,%eax
 4ab:	25 ff 00 00 00       	and    $0xff,%eax
 4b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b7:	75 2c                	jne    4e5 <printf+0x6a>
      if(c == '%'){
 4b9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4bd:	75 0c                	jne    4cb <printf+0x50>
        state = '%';
 4bf:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4c6:	e9 4b 01 00 00       	jmp    616 <printf+0x19b>
      } else {
        putc(fd, c);
 4cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ce:	0f be c0             	movsbl %al,%eax
 4d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d5:	8b 45 08             	mov    0x8(%ebp),%eax
 4d8:	89 04 24             	mov    %eax,(%esp)
 4db:	e8 c4 fe ff ff       	call   3a4 <putc>
 4e0:	e9 31 01 00 00       	jmp    616 <printf+0x19b>
      }
    } else if(state == '%'){
 4e5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4e9:	0f 85 27 01 00 00    	jne    616 <printf+0x19b>
      if(c == 'd'){
 4ef:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4f3:	75 2d                	jne    522 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f8:	8b 00                	mov    (%eax),%eax
 4fa:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 501:	00 
 502:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 509:	00 
 50a:	89 44 24 04          	mov    %eax,0x4(%esp)
 50e:	8b 45 08             	mov    0x8(%ebp),%eax
 511:	89 04 24             	mov    %eax,(%esp)
 514:	e8 b3 fe ff ff       	call   3cc <printint>
        ap++;
 519:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 51d:	e9 ed 00 00 00       	jmp    60f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 522:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 526:	74 06                	je     52e <printf+0xb3>
 528:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 52c:	75 2d                	jne    55b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 52e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 531:	8b 00                	mov    (%eax),%eax
 533:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 53a:	00 
 53b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 542:	00 
 543:	89 44 24 04          	mov    %eax,0x4(%esp)
 547:	8b 45 08             	mov    0x8(%ebp),%eax
 54a:	89 04 24             	mov    %eax,(%esp)
 54d:	e8 7a fe ff ff       	call   3cc <printint>
        ap++;
 552:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 556:	e9 b4 00 00 00       	jmp    60f <printf+0x194>
      } else if(c == 's'){
 55b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 55f:	75 46                	jne    5a7 <printf+0x12c>
        s = (char*)*ap;
 561:	8b 45 e8             	mov    -0x18(%ebp),%eax
 564:	8b 00                	mov    (%eax),%eax
 566:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 569:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 56d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 571:	75 27                	jne    59a <printf+0x11f>
          s = "(null)";
 573:	c7 45 f4 ad 0c 00 00 	movl   $0xcad,-0xc(%ebp)
        while(*s != 0){
 57a:	eb 1e                	jmp    59a <printf+0x11f>
          putc(fd, *s);
 57c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57f:	0f b6 00             	movzbl (%eax),%eax
 582:	0f be c0             	movsbl %al,%eax
 585:	89 44 24 04          	mov    %eax,0x4(%esp)
 589:	8b 45 08             	mov    0x8(%ebp),%eax
 58c:	89 04 24             	mov    %eax,(%esp)
 58f:	e8 10 fe ff ff       	call   3a4 <putc>
          s++;
 594:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 598:	eb 01                	jmp    59b <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 59a:	90                   	nop
 59b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59e:	0f b6 00             	movzbl (%eax),%eax
 5a1:	84 c0                	test   %al,%al
 5a3:	75 d7                	jne    57c <printf+0x101>
 5a5:	eb 68                	jmp    60f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ab:	75 1d                	jne    5ca <printf+0x14f>
        putc(fd, *ap);
 5ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b0:	8b 00                	mov    (%eax),%eax
 5b2:	0f be c0             	movsbl %al,%eax
 5b5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b9:	8b 45 08             	mov    0x8(%ebp),%eax
 5bc:	89 04 24             	mov    %eax,(%esp)
 5bf:	e8 e0 fd ff ff       	call   3a4 <putc>
        ap++;
 5c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c8:	eb 45                	jmp    60f <printf+0x194>
      } else if(c == '%'){
 5ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ce:	75 17                	jne    5e7 <printf+0x16c>
        putc(fd, c);
 5d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5da:	8b 45 08             	mov    0x8(%ebp),%eax
 5dd:	89 04 24             	mov    %eax,(%esp)
 5e0:	e8 bf fd ff ff       	call   3a4 <putc>
 5e5:	eb 28                	jmp    60f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e7:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5ee:	00 
 5ef:	8b 45 08             	mov    0x8(%ebp),%eax
 5f2:	89 04 24             	mov    %eax,(%esp)
 5f5:	e8 aa fd ff ff       	call   3a4 <putc>
        putc(fd, c);
 5fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fd:	0f be c0             	movsbl %al,%eax
 600:	89 44 24 04          	mov    %eax,0x4(%esp)
 604:	8b 45 08             	mov    0x8(%ebp),%eax
 607:	89 04 24             	mov    %eax,(%esp)
 60a:	e8 95 fd ff ff       	call   3a4 <putc>
      }
      state = 0;
 60f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 616:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 61a:	8b 55 0c             	mov    0xc(%ebp),%edx
 61d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 620:	01 d0                	add    %edx,%eax
 622:	0f b6 00             	movzbl (%eax),%eax
 625:	84 c0                	test   %al,%al
 627:	0f 85 70 fe ff ff    	jne    49d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 62d:	c9                   	leave  
 62e:	c3                   	ret    
 62f:	90                   	nop

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 636:	8b 45 08             	mov    0x8(%ebp),%eax
 639:	83 e8 08             	sub    $0x8,%eax
 63c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63f:	a1 88 10 00 00       	mov    0x1088,%eax
 644:	89 45 fc             	mov    %eax,-0x4(%ebp)
 647:	eb 24                	jmp    66d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 651:	77 12                	ja     665 <free+0x35>
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 659:	77 24                	ja     67f <free+0x4f>
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 00                	mov    (%eax),%eax
 660:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 663:	77 1a                	ja     67f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 670:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 673:	76 d4                	jbe    649 <free+0x19>
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67d:	76 ca                	jbe    649 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 682:	8b 40 04             	mov    0x4(%eax),%eax
 685:	c1 e0 03             	shl    $0x3,%eax
 688:	89 c2                	mov    %eax,%edx
 68a:	03 55 f8             	add    -0x8(%ebp),%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	39 c2                	cmp    %eax,%edx
 694:	75 24                	jne    6ba <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	8b 50 04             	mov    0x4(%eax),%edx
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 00                	mov    (%eax),%eax
 6a1:	8b 40 04             	mov    0x4(%eax),%eax
 6a4:	01 c2                	add    %eax,%edx
 6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6af:	8b 00                	mov    (%eax),%eax
 6b1:	8b 10                	mov    (%eax),%edx
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	89 10                	mov    %edx,(%eax)
 6b8:	eb 0a                	jmp    6c4 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 10                	mov    (%eax),%edx
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 40 04             	mov    0x4(%eax),%eax
 6ca:	c1 e0 03             	shl    $0x3,%eax
 6cd:	03 45 fc             	add    -0x4(%ebp),%eax
 6d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6d3:	75 20                	jne    6f5 <free+0xc5>
    p->s.size += bp->s.size;
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	8b 50 04             	mov    0x4(%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	8b 40 04             	mov    0x4(%eax),%eax
 6e1:	01 c2                	add    %eax,%edx
 6e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ec:	8b 10                	mov    (%eax),%edx
 6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f1:	89 10                	mov    %edx,(%eax)
 6f3:	eb 08                	jmp    6fd <free+0xcd>
  } else
    p->s.ptr = bp;
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6fb:	89 10                	mov    %edx,(%eax)
  freep = p;
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	a3 88 10 00 00       	mov    %eax,0x1088
}
 705:	c9                   	leave  
 706:	c3                   	ret    

00000707 <morecore>:

static Header*
morecore(uint nu)
{
 707:	55                   	push   %ebp
 708:	89 e5                	mov    %esp,%ebp
 70a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 70d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 714:	77 07                	ja     71d <morecore+0x16>
    nu = 4096;
 716:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 71d:	8b 45 08             	mov    0x8(%ebp),%eax
 720:	c1 e0 03             	shl    $0x3,%eax
 723:	89 04 24             	mov    %eax,(%esp)
 726:	e8 29 fc ff ff       	call   354 <sbrk>
 72b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 72e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 732:	75 07                	jne    73b <morecore+0x34>
    return 0;
 734:	b8 00 00 00 00       	mov    $0x0,%eax
 739:	eb 22                	jmp    75d <morecore+0x56>
  hp = (Header*)p;
 73b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 741:	8b 45 f0             	mov    -0x10(%ebp),%eax
 744:	8b 55 08             	mov    0x8(%ebp),%edx
 747:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 74a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74d:	83 c0 08             	add    $0x8,%eax
 750:	89 04 24             	mov    %eax,(%esp)
 753:	e8 d8 fe ff ff       	call   630 <free>
  return freep;
 758:	a1 88 10 00 00       	mov    0x1088,%eax
}
 75d:	c9                   	leave  
 75e:	c3                   	ret    

0000075f <malloc>:

void*
malloc(uint nbytes)
{
 75f:	55                   	push   %ebp
 760:	89 e5                	mov    %esp,%ebp
 762:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 765:	8b 45 08             	mov    0x8(%ebp),%eax
 768:	83 c0 07             	add    $0x7,%eax
 76b:	c1 e8 03             	shr    $0x3,%eax
 76e:	83 c0 01             	add    $0x1,%eax
 771:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 774:	a1 88 10 00 00       	mov    0x1088,%eax
 779:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 780:	75 23                	jne    7a5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 782:	c7 45 f0 80 10 00 00 	movl   $0x1080,-0x10(%ebp)
 789:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78c:	a3 88 10 00 00       	mov    %eax,0x1088
 791:	a1 88 10 00 00       	mov    0x1088,%eax
 796:	a3 80 10 00 00       	mov    %eax,0x1080
    base.s.size = 0;
 79b:	c7 05 84 10 00 00 00 	movl   $0x0,0x1084
 7a2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b6:	72 4d                	jb     805 <malloc+0xa6>
      if(p->s.size == nunits)
 7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bb:	8b 40 04             	mov    0x4(%eax),%eax
 7be:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7c1:	75 0c                	jne    7cf <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cb:	89 10                	mov    %edx,(%eax)
 7cd:	eb 26                	jmp    7f5 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d2:	8b 40 04             	mov    0x4(%eax),%eax
 7d5:	89 c2                	mov    %eax,%edx
 7d7:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 40 04             	mov    0x4(%eax),%eax
 7e6:	c1 e0 03             	shl    $0x3,%eax
 7e9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7f2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f8:	a3 88 10 00 00       	mov    %eax,0x1088
      return (void*)(p + 1);
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	83 c0 08             	add    $0x8,%eax
 803:	eb 38                	jmp    83d <malloc+0xde>
    }
    if(p == freep)
 805:	a1 88 10 00 00       	mov    0x1088,%eax
 80a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 80d:	75 1b                	jne    82a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 80f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 812:	89 04 24             	mov    %eax,(%esp)
 815:	e8 ed fe ff ff       	call   707 <morecore>
 81a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 81d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 821:	75 07                	jne    82a <malloc+0xcb>
        return 0;
 823:	b8 00 00 00 00       	mov    $0x0,%eax
 828:	eb 13                	jmp    83d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	8b 00                	mov    (%eax),%eax
 835:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 838:	e9 70 ff ff ff       	jmp    7ad <malloc+0x4e>
}
 83d:	c9                   	leave  
 83e:	c3                   	ret    
 83f:	90                   	nop

00000840 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 846:	8b 45 08             	mov    0x8(%ebp),%eax
 849:	83 c0 01             	add    $0x1,%eax
 84c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 84f:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 853:	75 07                	jne    85c <getNextThread+0x1c>
    i=0;
 855:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 85c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85f:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 865:	05 a0 10 00 00       	add    $0x10a0,%eax
 86a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 86d:	eb 3b                	jmp    8aa <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 86f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 872:	8b 40 10             	mov    0x10(%eax),%eax
 875:	83 f8 03             	cmp    $0x3,%eax
 878:	75 05                	jne    87f <getNextThread+0x3f>
      return i;
 87a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87d:	eb 38                	jmp    8b7 <getNextThread+0x77>
    i++;
 87f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 883:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 887:	75 1a                	jne    8a3 <getNextThread+0x63>
    {
       i=0;
 889:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 890:	8b 45 fc             	mov    -0x4(%ebp),%eax
 893:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 899:	05 a0 10 00 00       	add    $0x10a0,%eax
 89e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 8a1:	eb 07                	jmp    8aa <getNextThread+0x6a>
    }
    else
      t++;
 8a3:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 8aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ad:	3b 45 08             	cmp    0x8(%ebp),%eax
 8b0:	75 bd                	jne    86f <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 8b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 8b7:	c9                   	leave  
 8b8:	c3                   	ret    

000008b9 <allocThread>:


static uthread_p
allocThread()
{
 8b9:	55                   	push   %ebp
 8ba:	89 e5                	mov    %esp,%ebp
 8bc:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 8bf:	c7 45 ec a0 10 00 00 	movl   $0x10a0,-0x14(%ebp)
 8c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 8cd:	eb 15                	jmp    8e4 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 8cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8d2:	8b 40 10             	mov    0x10(%eax),%eax
 8d5:	85 c0                	test   %eax,%eax
 8d7:	74 1e                	je     8f7 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 8d9:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 8e0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 8e4:	81 7d ec a0 56 00 00 	cmpl   $0x56a0,-0x14(%ebp)
 8eb:	76 e2                	jbe    8cf <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 8ed:	b8 00 00 00 00       	mov    $0x0,%eax
 8f2:	e9 88 00 00 00       	jmp    97f <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 8f7:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 8f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8fe:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 900:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 907:	e8 53 fe ff ff       	call   75f <malloc>
 90c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 90f:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 912:	8b 45 ec             	mov    -0x14(%ebp),%eax
 915:	8b 40 0c             	mov    0xc(%eax),%eax
 918:	89 c2                	mov    %eax,%edx
 91a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 91d:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 920:	8b 45 ec             	mov    -0x14(%ebp),%eax
 923:	8b 40 0c             	mov    0xc(%eax),%eax
 926:	89 c2                	mov    %eax,%edx
 928:	8b 45 ec             	mov    -0x14(%ebp),%eax
 92b:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 92e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 931:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 938:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 93f:	eb 15                	jmp    956 <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 941:	8b 45 ec             	mov    -0x14(%ebp),%eax
 944:	8b 55 f0             	mov    -0x10(%ebp),%edx
 947:	83 c2 04             	add    $0x4,%edx
 94a:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 951:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 952:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 956:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 95a:	7e e5                	jle    941 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 95c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 95f:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 962:	ba 7e 0a 00 00       	mov    $0xa7e,%edx
 967:	89 c4                	mov    %eax,%esp
 969:	52                   	push   %edx
 96a:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 96c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 96f:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 972:	8b 45 ec             	mov    -0x14(%ebp),%eax
 975:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 97c:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 97f:	c9                   	leave  
 980:	c3                   	ret    

00000981 <uthread_init>:

void 
uthread_init()
{  
 981:	55                   	push   %ebp
 982:	89 e5                	mov    %esp,%ebp
 984:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 987:	c7 05 a0 56 00 00 00 	movl   $0x0,0x56a0
 98e:	00 00 00 
  tTable.current=0;
 991:	c7 05 a4 56 00 00 00 	movl   $0x0,0x56a4
 998:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 99b:	e8 19 ff ff ff       	call   8b9 <allocThread>
 9a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 9a3:	89 e9                	mov    %ebp,%ecx
 9a5:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 9a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 9aa:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 9ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 9b0:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 9b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b6:	8b 50 08             	mov    0x8(%eax),%edx
 9b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bc:	8b 40 04             	mov    0x4(%eax),%eax
 9bf:	89 d1                	mov    %edx,%ecx
 9c1:	29 c1                	sub    %eax,%ecx
 9c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c6:	8b 40 04             	mov    0x4(%eax),%eax
 9c9:	89 c2                	mov    %eax,%edx
 9cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ce:	8b 40 0c             	mov    0xc(%eax),%eax
 9d1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 9d5:	89 54 24 04          	mov    %edx,0x4(%esp)
 9d9:	89 04 24             	mov    %eax,(%esp)
 9dc:	e8 a5 f8 ff ff       	call   286 <memmove>
  mainT->state = T_RUNNABLE;
 9e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e4:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 9eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ee:	a3 a8 56 00 00       	mov    %eax,0x56a8
  if(signal(SIGALRM,uthread_yield)<0)
 9f3:	c7 44 24 04 ee 0b 00 	movl   $0xbee,0x4(%esp)
 9fa:	00 
 9fb:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a02:	e8 85 f9 ff ff       	call   38c <signal>
 a07:	85 c0                	test   %eax,%eax
 a09:	79 19                	jns    a24 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 a0b:	c7 44 24 04 b4 0c 00 	movl   $0xcb4,0x4(%esp)
 a12:	00 
 a13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a1a:	e8 5c fa ff ff       	call   47b <printf>
    exit();
 a1f:	e8 a8 f8 ff ff       	call   2cc <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 a24:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 a2b:	e8 6c f9 ff ff       	call   39c <alarm>
 a30:	85 c0                	test   %eax,%eax
 a32:	79 19                	jns    a4d <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 a34:	c7 44 24 04 d4 0c 00 	movl   $0xcd4,0x4(%esp)
 a3b:	00 
 a3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a43:	e8 33 fa ff ff       	call   47b <printf>
    exit();
 a48:	e8 7f f8 ff ff       	call   2cc <exit>
  }
  
}
 a4d:	c9                   	leave  
 a4e:	c3                   	ret    

00000a4f <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 a4f:	55                   	push   %ebp
 a50:	89 e5                	mov    %esp,%ebp
 a52:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 a55:	e8 5f fe ff ff       	call   8b9 <allocThread>
 a5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
 a60:	8b 55 08             	mov    0x8(%ebp),%edx
 a63:	50                   	push   %eax
 a64:	52                   	push   %edx
 a65:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 a6a:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a70:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a7a:	8b 00                	mov    (%eax),%eax
}
 a7c:	c9                   	leave  
 a7d:	c3                   	ret    

00000a7e <uthread_exit>:

void 
uthread_exit()
{
 a7e:	55                   	push   %ebp
 a7f:	89 e5                	mov    %esp,%ebp
 a81:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 a84:	a1 a8 56 00 00       	mov    0x56a8,%eax
 a89:	8b 00                	mov    (%eax),%eax
 a8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 a8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 a95:	eb 25                	jmp    abc <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 a97:	a1 a8 56 00 00       	mov    0x56a8,%eax
 a9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a9f:	83 c2 04             	add    $0x4,%edx
 aa2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 aa6:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 aac:	05 a0 10 00 00       	add    $0x10a0,%eax
 ab1:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 ab8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 abc:	a1 a8 56 00 00       	mov    0x56a8,%eax
 ac1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ac4:	83 c2 04             	add    $0x4,%edx
 ac7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 acb:	83 f8 ff             	cmp    $0xffffffff,%eax
 ace:	75 c7                	jne    a97 <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 ad0:	a1 a8 56 00 00       	mov    0x56a8,%eax
 ad5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 adb:	a1 a8 56 00 00       	mov    0x56a8,%eax
 ae0:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 ae7:	a1 a8 56 00 00       	mov    0x56a8,%eax
 aec:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 af3:	a1 a8 56 00 00       	mov    0x56a8,%eax
 af8:	8b 40 0c             	mov    0xc(%eax),%eax
 afb:	89 04 24             	mov    %eax,(%esp)
 afe:	e8 2d fb ff ff       	call   630 <free>
  currentThread->state=T_FREE;
 b03:	a1 a8 56 00 00       	mov    0x56a8,%eax
 b08:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 b0f:	a1 a8 56 00 00       	mov    0x56a8,%eax
 b14:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 b1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b1e:	89 04 24             	mov    %eax,(%esp)
 b21:	e8 1a fd ff ff       	call   840 <getNextThread>
 b26:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 b29:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 b2d:	78 36                	js     b65 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 b2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b32:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b38:	05 a0 10 00 00       	add    $0x10a0,%eax
 b3d:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 b40:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b43:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 b4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b4d:	8b 40 04             	mov    0x4(%eax),%eax
 b50:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 b52:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b55:	8b 40 08             	mov    0x8(%eax),%eax
 b58:	89 c5                	mov    %eax,%ebp
             asm("popa");
 b5a:	61                   	popa   
             currentThread=newt;
 b5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b5e:	a3 a8 56 00 00       	mov    %eax,0x56a8
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 b63:	c9                   	leave  
 b64:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 b65:	e8 62 f7 ff ff       	call   2cc <exit>

00000b6a <uthred_join>:
}


int
uthred_join(int tid)
{
 b6a:	55                   	push   %ebp
 b6b:	89 e5                	mov    %esp,%ebp
 b6d:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 b70:	8b 45 08             	mov    0x8(%ebp),%eax
 b73:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b79:	05 a0 10 00 00       	add    $0x10a0,%eax
 b7e:	8b 40 10             	mov    0x10(%eax),%eax
 b81:	85 c0                	test   %eax,%eax
 b83:	75 07                	jne    b8c <uthred_join+0x22>
    return -1;
 b85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b8a:	eb 60                	jmp    bec <uthred_join+0x82>
  else
  {
      int i=0;
 b8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 b93:	eb 04                	jmp    b99 <uthred_join+0x2f>
        i++;
 b95:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 b99:	8b 45 08             	mov    0x8(%ebp),%eax
 b9c:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 ba2:	05 a0 10 00 00       	add    $0x10a0,%eax
 ba7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 baa:	83 c2 04             	add    $0x4,%edx
 bad:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 bb1:	83 f8 ff             	cmp    $0xffffffff,%eax
 bb4:	75 df                	jne    b95 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 bb6:	8b 45 08             	mov    0x8(%ebp),%eax
 bb9:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bbf:	8d 90 a0 10 00 00    	lea    0x10a0(%eax),%edx
 bc5:	a1 a8 56 00 00       	mov    0x56a8,%eax
 bca:	8b 00                	mov    (%eax),%eax
 bcc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 bcf:	83 c1 04             	add    $0x4,%ecx
 bd2:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 bd6:	a1 a8 56 00 00       	mov    0x56a8,%eax
 bdb:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 be2:	e8 07 00 00 00       	call   bee <uthread_yield>
      return 1;
 be7:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 bec:	c9                   	leave  
 bed:	c3                   	ret    

00000bee <uthread_yield>:

void 
uthread_yield()
{
 bee:	55                   	push   %ebp
 bef:	89 e5                	mov    %esp,%ebp
 bf1:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 bf4:	a1 a8 56 00 00       	mov    0x56a8,%eax
 bf9:	8b 00                	mov    (%eax),%eax
 bfb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c01:	89 04 24             	mov    %eax,(%esp)
 c04:	e8 37 fc ff ff       	call   840 <getNextThread>
 c09:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 c0c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c10:	79 19                	jns    c2b <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 c12:	c7 44 24 04 f4 0c 00 	movl   $0xcf4,0x4(%esp)
 c19:	00 
 c1a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c21:	e8 55 f8 ff ff       	call   47b <printf>
    exit();
 c26:	e8 a1 f6 ff ff       	call   2cc <exit>
  }
newt=&tTable.table[new];
 c2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c2e:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c34:	05 a0 10 00 00       	add    $0x10a0,%eax
 c39:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 c3c:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 c3d:	a1 a8 56 00 00       	mov    0x56a8,%eax
 c42:	89 e2                	mov    %esp,%edx
 c44:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 c47:	a1 a8 56 00 00       	mov    0x56a8,%eax
 c4c:	8b 40 10             	mov    0x10(%eax),%eax
 c4f:	83 f8 02             	cmp    $0x2,%eax
 c52:	75 0c                	jne    c60 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 c54:	a1 a8 56 00 00       	mov    0x56a8,%eax
 c59:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 c60:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c63:	8b 40 04             	mov    0x4(%eax),%eax
 c66:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 c68:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c6b:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 c72:	61                   	popa   
    if(currentThread->firstTime==0)
 c73:	a1 a8 56 00 00       	mov    0x56a8,%eax
 c78:	8b 40 14             	mov    0x14(%eax),%eax
 c7b:	85 c0                	test   %eax,%eax
 c7d:	75 0d                	jne    c8c <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 c7f:	c3                   	ret    
       currentThread->firstTime=1;
 c80:	a1 a8 56 00 00       	mov    0x56a8,%eax
 c85:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 c8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c8f:	a3 a8 56 00 00       	mov    %eax,0x56a8

}
 c94:	c9                   	leave  
 c95:	c3                   	ret    

00000c96 <uthred_self>:

int  uthred_self(void)
{
 c96:	55                   	push   %ebp
 c97:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 c99:	a1 a8 56 00 00       	mov    0x56a8,%eax
 c9e:	8b 00                	mov    (%eax),%eax
}
 ca0:	5d                   	pop    %ebp
 ca1:	c3                   	ret    
