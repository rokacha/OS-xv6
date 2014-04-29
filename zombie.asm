
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 72 02 00 00       	call   280 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 fa 02 00 00       	call   318 <sleep>
  exit();
  1e:	e8 65 02 00 00       	call   288 <exit>
  23:	90                   	nop

00000024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	57                   	push   %edi
  28:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2c:	8b 55 10             	mov    0x10(%ebp),%edx
  2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  32:	89 cb                	mov    %ecx,%ebx
  34:	89 df                	mov    %ebx,%edi
  36:	89 d1                	mov    %edx,%ecx
  38:	fc                   	cld    
  39:	f3 aa                	rep stos %al,%es:(%edi)
  3b:	89 ca                	mov    %ecx,%edx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  42:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  45:	5b                   	pop    %ebx
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4f:	8b 45 08             	mov    0x8(%ebp),%eax
  52:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  55:	90                   	nop
  56:	8b 45 0c             	mov    0xc(%ebp),%eax
  59:	0f b6 10             	movzbl (%eax),%edx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	88 10                	mov    %dl,(%eax)
  61:	8b 45 08             	mov    0x8(%ebp),%eax
  64:	0f b6 00             	movzbl (%eax),%eax
  67:	84 c0                	test   %al,%al
  69:	0f 95 c0             	setne  %al
  6c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  70:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  74:	84 c0                	test   %al,%al
  76:	75 de                	jne    56 <strcpy+0xd>
    ;
  return os;
  78:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7b:	c9                   	leave  
  7c:	c3                   	ret    

0000007d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7d:	55                   	push   %ebp
  7e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  80:	eb 08                	jmp    8a <strcmp+0xd>
    p++, q++;
  82:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  86:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8a:	8b 45 08             	mov    0x8(%ebp),%eax
  8d:	0f b6 00             	movzbl (%eax),%eax
  90:	84 c0                	test   %al,%al
  92:	74 10                	je     a4 <strcmp+0x27>
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	0f b6 10             	movzbl (%eax),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 00             	movzbl (%eax),%eax
  a0:	38 c2                	cmp    %al,%dl
  a2:	74 de                	je     82 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	0f b6 00             	movzbl (%eax),%eax
  aa:	0f b6 d0             	movzbl %al,%edx
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	0f b6 c0             	movzbl %al,%eax
  b6:	89 d1                	mov    %edx,%ecx
  b8:	29 c1                	sub    %eax,%ecx
  ba:	89 c8                	mov    %ecx,%eax
}
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    

000000be <strlen>:

uint
strlen(char *s)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cb:	eb 04                	jmp    d1 <strlen+0x13>
  cd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d4:	03 45 08             	add    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	75 ef                	jne    cd <strlen+0xf>
    ;
  return n;
  de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e1:	c9                   	leave  
  e2:	c3                   	ret    

000000e3 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  e9:	8b 45 10             	mov    0x10(%ebp),%eax
  ec:	89 44 24 08          	mov    %eax,0x8(%esp)
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	89 04 24             	mov    %eax,(%esp)
  fd:	e8 22 ff ff ff       	call   24 <stosb>
  return dst;
 102:	8b 45 08             	mov    0x8(%ebp),%eax
}
 105:	c9                   	leave  
 106:	c3                   	ret    

00000107 <strchr>:

char*
strchr(const char *s, char c)
{
 107:	55                   	push   %ebp
 108:	89 e5                	mov    %esp,%ebp
 10a:	83 ec 04             	sub    $0x4,%esp
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 113:	eb 14                	jmp    129 <strchr+0x22>
    if(*s == c)
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 11e:	75 05                	jne    125 <strchr+0x1e>
      return (char*)s;
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	eb 13                	jmp    138 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 125:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 129:	8b 45 08             	mov    0x8(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	84 c0                	test   %al,%al
 131:	75 e2                	jne    115 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 133:	b8 00 00 00 00       	mov    $0x0,%eax
}
 138:	c9                   	leave  
 139:	c3                   	ret    

0000013a <gets>:

char*
gets(char *buf, int max)
{
 13a:	55                   	push   %ebp
 13b:	89 e5                	mov    %esp,%ebp
 13d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 147:	eb 44                	jmp    18d <gets+0x53>
    cc = read(0, &c, 1);
 149:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 150:	00 
 151:	8d 45 ef             	lea    -0x11(%ebp),%eax
 154:	89 44 24 04          	mov    %eax,0x4(%esp)
 158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15f:	e8 3c 01 00 00       	call   2a0 <read>
 164:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 167:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16b:	7e 2d                	jle    19a <gets+0x60>
      break;
    buf[i++] = c;
 16d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 170:	03 45 08             	add    0x8(%ebp),%eax
 173:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 177:	88 10                	mov    %dl,(%eax)
 179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 17d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 181:	3c 0a                	cmp    $0xa,%al
 183:	74 16                	je     19b <gets+0x61>
 185:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 189:	3c 0d                	cmp    $0xd,%al
 18b:	74 0e                	je     19b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 190:	83 c0 01             	add    $0x1,%eax
 193:	3b 45 0c             	cmp    0xc(%ebp),%eax
 196:	7c b1                	jl     149 <gets+0xf>
 198:	eb 01                	jmp    19b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 19a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19e:	03 45 08             	add    0x8(%ebp),%eax
 1a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a7:	c9                   	leave  
 1a8:	c3                   	ret    

000001a9 <stat>:

int
stat(char *n, struct stat *st)
{
 1a9:	55                   	push   %ebp
 1aa:	89 e5                	mov    %esp,%ebp
 1ac:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b6:	00 
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	89 04 24             	mov    %eax,(%esp)
 1bd:	e8 06 01 00 00       	call   2c8 <open>
 1c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c9:	79 07                	jns    1d2 <stat+0x29>
    return -1;
 1cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d0:	eb 23                	jmp    1f5 <stat+0x4c>
  r = fstat(fd, st);
 1d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dc:	89 04 24             	mov    %eax,(%esp)
 1df:	e8 fc 00 00 00       	call   2e0 <fstat>
 1e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ea:	89 04 24             	mov    %eax,(%esp)
 1ed:	e8 be 00 00 00       	call   2b0 <close>
  return r;
 1f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    

000001f7 <atoi>:

int
atoi(const char *s)
{
 1f7:	55                   	push   %ebp
 1f8:	89 e5                	mov    %esp,%ebp
 1fa:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 204:	eb 23                	jmp    229 <atoi+0x32>
    n = n*10 + *s++ - '0';
 206:	8b 55 fc             	mov    -0x4(%ebp),%edx
 209:	89 d0                	mov    %edx,%eax
 20b:	c1 e0 02             	shl    $0x2,%eax
 20e:	01 d0                	add    %edx,%eax
 210:	01 c0                	add    %eax,%eax
 212:	89 c2                	mov    %eax,%edx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	0f b6 00             	movzbl (%eax),%eax
 21a:	0f be c0             	movsbl %al,%eax
 21d:	01 d0                	add    %edx,%eax
 21f:	83 e8 30             	sub    $0x30,%eax
 222:	89 45 fc             	mov    %eax,-0x4(%ebp)
 225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	0f b6 00             	movzbl (%eax),%eax
 22f:	3c 2f                	cmp    $0x2f,%al
 231:	7e 0a                	jle    23d <atoi+0x46>
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 00             	movzbl (%eax),%eax
 239:	3c 39                	cmp    $0x39,%al
 23b:	7e c9                	jle    206 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 23d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 240:	c9                   	leave  
 241:	c3                   	ret    

00000242 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 242:	55                   	push   %ebp
 243:	89 e5                	mov    %esp,%ebp
 245:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24e:	8b 45 0c             	mov    0xc(%ebp),%eax
 251:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 254:	eb 13                	jmp    269 <memmove+0x27>
    *dst++ = *src++;
 256:	8b 45 f8             	mov    -0x8(%ebp),%eax
 259:	0f b6 10             	movzbl (%eax),%edx
 25c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25f:	88 10                	mov    %dl,(%eax)
 261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 265:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 26d:	0f 9f c0             	setg   %al
 270:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 274:	84 c0                	test   %al,%al
 276:	75 de                	jne    256 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 278:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27b:	c9                   	leave  
 27c:	c3                   	ret    
 27d:	90                   	nop
 27e:	90                   	nop
 27f:	90                   	nop

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 05 00 00 00       	mov    $0x5,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 15 00 00 00       	mov    $0x15,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 06 00 00 00       	mov    $0x6,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 07 00 00 00       	mov    $0x7,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 11 00 00 00       	mov    $0x11,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 12 00 00 00       	mov    $0x12,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 08 00 00 00       	mov    $0x8,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 13 00 00 00       	mov    $0x13,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 14 00 00 00       	mov    $0x14,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 09 00 00 00       	mov    $0x9,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 0a 00 00 00       	mov    $0xa,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 0b 00 00 00       	mov    $0xb,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 0c 00 00 00       	mov    $0xc,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 0d 00 00 00       	mov    $0xd,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 0e 00 00 00       	mov    $0xe,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <add_path>:
SYSCALL(add_path)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <wait2>:
SYSCALL(wait2)
 330:	b8 17 00 00 00       	mov    $0x17,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <getquanta>:
SYSCALL(getquanta)
 338:	b8 18 00 00 00       	mov    $0x18,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <getqueue>:
SYSCALL(getqueue)
 340:	b8 19 00 00 00       	mov    $0x19,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <signal>:
SYSCALL(signal)
 348:	b8 1a 00 00 00       	mov    $0x1a,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <sigsend>:
SYSCALL(sigsend)
 350:	b8 1b 00 00 00       	mov    $0x1b,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <alarm>:
SYSCALL(alarm)
 358:	b8 1c 00 00 00       	mov    $0x1c,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 28             	sub    $0x28,%esp
 366:	8b 45 0c             	mov    0xc(%ebp),%eax
 369:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 36c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 373:	00 
 374:	8d 45 f4             	lea    -0xc(%ebp),%eax
 377:	89 44 24 04          	mov    %eax,0x4(%esp)
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
 37e:	89 04 24             	mov    %eax,(%esp)
 381:	e8 22 ff ff ff       	call   2a8 <write>
}
 386:	c9                   	leave  
 387:	c3                   	ret    

00000388 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 38e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 395:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 399:	74 17                	je     3b2 <printint+0x2a>
 39b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 39f:	79 11                	jns    3b2 <printint+0x2a>
    neg = 1;
 3a1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ab:	f7 d8                	neg    %eax
 3ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b0:	eb 06                	jmp    3b8 <printint+0x30>
  } else {
    x = xx;
 3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3c5:	ba 00 00 00 00       	mov    $0x0,%edx
 3ca:	f7 f1                	div    %ecx
 3cc:	89 d0                	mov    %edx,%eax
 3ce:	0f b6 90 48 14 00 00 	movzbl 0x1448(%eax),%edx
 3d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3d8:	03 45 f4             	add    -0xc(%ebp),%eax
 3db:	88 10                	mov    %dl,(%eax)
 3dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3e1:	8b 55 10             	mov    0x10(%ebp),%edx
 3e4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ea:	ba 00 00 00 00       	mov    $0x0,%edx
 3ef:	f7 75 d4             	divl   -0x2c(%ebp)
 3f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3f9:	75 c4                	jne    3bf <printint+0x37>
  if(neg)
 3fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3ff:	74 2a                	je     42b <printint+0xa3>
    buf[i++] = '-';
 401:	8d 45 dc             	lea    -0x24(%ebp),%eax
 404:	03 45 f4             	add    -0xc(%ebp),%eax
 407:	c6 00 2d             	movb   $0x2d,(%eax)
 40a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 40e:	eb 1b                	jmp    42b <printint+0xa3>
    putc(fd, buf[i]);
 410:	8d 45 dc             	lea    -0x24(%ebp),%eax
 413:	03 45 f4             	add    -0xc(%ebp),%eax
 416:	0f b6 00             	movzbl (%eax),%eax
 419:	0f be c0             	movsbl %al,%eax
 41c:	89 44 24 04          	mov    %eax,0x4(%esp)
 420:	8b 45 08             	mov    0x8(%ebp),%eax
 423:	89 04 24             	mov    %eax,(%esp)
 426:	e8 35 ff ff ff       	call   360 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 42b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 42f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 433:	79 db                	jns    410 <printint+0x88>
    putc(fd, buf[i]);
}
 435:	c9                   	leave  
 436:	c3                   	ret    

00000437 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 437:	55                   	push   %ebp
 438:	89 e5                	mov    %esp,%ebp
 43a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 43d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 444:	8d 45 0c             	lea    0xc(%ebp),%eax
 447:	83 c0 04             	add    $0x4,%eax
 44a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 44d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 454:	e9 7d 01 00 00       	jmp    5d6 <printf+0x19f>
    c = fmt[i] & 0xff;
 459:	8b 55 0c             	mov    0xc(%ebp),%edx
 45c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 45f:	01 d0                	add    %edx,%eax
 461:	0f b6 00             	movzbl (%eax),%eax
 464:	0f be c0             	movsbl %al,%eax
 467:	25 ff 00 00 00       	and    $0xff,%eax
 46c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 46f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 473:	75 2c                	jne    4a1 <printf+0x6a>
      if(c == '%'){
 475:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 479:	75 0c                	jne    487 <printf+0x50>
        state = '%';
 47b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 482:	e9 4b 01 00 00       	jmp    5d2 <printf+0x19b>
      } else {
        putc(fd, c);
 487:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 48a:	0f be c0             	movsbl %al,%eax
 48d:	89 44 24 04          	mov    %eax,0x4(%esp)
 491:	8b 45 08             	mov    0x8(%ebp),%eax
 494:	89 04 24             	mov    %eax,(%esp)
 497:	e8 c4 fe ff ff       	call   360 <putc>
 49c:	e9 31 01 00 00       	jmp    5d2 <printf+0x19b>
      }
    } else if(state == '%'){
 4a1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4a5:	0f 85 27 01 00 00    	jne    5d2 <printf+0x19b>
      if(c == 'd'){
 4ab:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4af:	75 2d                	jne    4de <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b4:	8b 00                	mov    (%eax),%eax
 4b6:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4bd:	00 
 4be:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4c5:	00 
 4c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ca:	8b 45 08             	mov    0x8(%ebp),%eax
 4cd:	89 04 24             	mov    %eax,(%esp)
 4d0:	e8 b3 fe ff ff       	call   388 <printint>
        ap++;
 4d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d9:	e9 ed 00 00 00       	jmp    5cb <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4de:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4e2:	74 06                	je     4ea <printf+0xb3>
 4e4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e8:	75 2d                	jne    517 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ed:	8b 00                	mov    (%eax),%eax
 4ef:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4f6:	00 
 4f7:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4fe:	00 
 4ff:	89 44 24 04          	mov    %eax,0x4(%esp)
 503:	8b 45 08             	mov    0x8(%ebp),%eax
 506:	89 04 24             	mov    %eax,(%esp)
 509:	e8 7a fe ff ff       	call   388 <printint>
        ap++;
 50e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 512:	e9 b4 00 00 00       	jmp    5cb <printf+0x194>
      } else if(c == 's'){
 517:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 51b:	75 46                	jne    563 <printf+0x12c>
        s = (char*)*ap;
 51d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 520:	8b 00                	mov    (%eax),%eax
 522:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 525:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 529:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 52d:	75 27                	jne    556 <printf+0x11f>
          s = "(null)";
 52f:	c7 45 f4 50 0f 00 00 	movl   $0xf50,-0xc(%ebp)
        while(*s != 0){
 536:	eb 1e                	jmp    556 <printf+0x11f>
          putc(fd, *s);
 538:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53b:	0f b6 00             	movzbl (%eax),%eax
 53e:	0f be c0             	movsbl %al,%eax
 541:	89 44 24 04          	mov    %eax,0x4(%esp)
 545:	8b 45 08             	mov    0x8(%ebp),%eax
 548:	89 04 24             	mov    %eax,(%esp)
 54b:	e8 10 fe ff ff       	call   360 <putc>
          s++;
 550:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 554:	eb 01                	jmp    557 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 556:	90                   	nop
 557:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55a:	0f b6 00             	movzbl (%eax),%eax
 55d:	84 c0                	test   %al,%al
 55f:	75 d7                	jne    538 <printf+0x101>
 561:	eb 68                	jmp    5cb <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 563:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 567:	75 1d                	jne    586 <printf+0x14f>
        putc(fd, *ap);
 569:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56c:	8b 00                	mov    (%eax),%eax
 56e:	0f be c0             	movsbl %al,%eax
 571:	89 44 24 04          	mov    %eax,0x4(%esp)
 575:	8b 45 08             	mov    0x8(%ebp),%eax
 578:	89 04 24             	mov    %eax,(%esp)
 57b:	e8 e0 fd ff ff       	call   360 <putc>
        ap++;
 580:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 584:	eb 45                	jmp    5cb <printf+0x194>
      } else if(c == '%'){
 586:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 58a:	75 17                	jne    5a3 <printf+0x16c>
        putc(fd, c);
 58c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58f:	0f be c0             	movsbl %al,%eax
 592:	89 44 24 04          	mov    %eax,0x4(%esp)
 596:	8b 45 08             	mov    0x8(%ebp),%eax
 599:	89 04 24             	mov    %eax,(%esp)
 59c:	e8 bf fd ff ff       	call   360 <putc>
 5a1:	eb 28                	jmp    5cb <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5aa:	00 
 5ab:	8b 45 08             	mov    0x8(%ebp),%eax
 5ae:	89 04 24             	mov    %eax,(%esp)
 5b1:	e8 aa fd ff ff       	call   360 <putc>
        putc(fd, c);
 5b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b9:	0f be c0             	movsbl %al,%eax
 5bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c0:	8b 45 08             	mov    0x8(%ebp),%eax
 5c3:	89 04 24             	mov    %eax,(%esp)
 5c6:	e8 95 fd ff ff       	call   360 <putc>
      }
      state = 0;
 5cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5d6:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5dc:	01 d0                	add    %edx,%eax
 5de:	0f b6 00             	movzbl (%eax),%eax
 5e1:	84 c0                	test   %al,%al
 5e3:	0f 85 70 fe ff ff    	jne    459 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5e9:	c9                   	leave  
 5ea:	c3                   	ret    
 5eb:	90                   	nop

000005ec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ec:	55                   	push   %ebp
 5ed:	89 e5                	mov    %esp,%ebp
 5ef:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5f2:	8b 45 08             	mov    0x8(%ebp),%eax
 5f5:	83 e8 08             	sub    $0x8,%eax
 5f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fb:	a1 68 14 00 00       	mov    0x1468,%eax
 600:	89 45 fc             	mov    %eax,-0x4(%ebp)
 603:	eb 24                	jmp    629 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 605:	8b 45 fc             	mov    -0x4(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 60d:	77 12                	ja     621 <free+0x35>
 60f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 612:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 615:	77 24                	ja     63b <free+0x4f>
 617:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61a:	8b 00                	mov    (%eax),%eax
 61c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 61f:	77 1a                	ja     63b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	89 45 fc             	mov    %eax,-0x4(%ebp)
 629:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 62f:	76 d4                	jbe    605 <free+0x19>
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 639:	76 ca                	jbe    605 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63e:	8b 40 04             	mov    0x4(%eax),%eax
 641:	c1 e0 03             	shl    $0x3,%eax
 644:	89 c2                	mov    %eax,%edx
 646:	03 55 f8             	add    -0x8(%ebp),%edx
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	39 c2                	cmp    %eax,%edx
 650:	75 24                	jne    676 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	8b 50 04             	mov    0x4(%eax),%edx
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	8b 40 04             	mov    0x4(%eax),%eax
 660:	01 c2                	add    %eax,%edx
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	8b 10                	mov    (%eax),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	89 10                	mov    %edx,(%eax)
 674:	eb 0a                	jmp    680 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	8b 10                	mov    (%eax),%edx
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 680:	8b 45 fc             	mov    -0x4(%ebp),%eax
 683:	8b 40 04             	mov    0x4(%eax),%eax
 686:	c1 e0 03             	shl    $0x3,%eax
 689:	03 45 fc             	add    -0x4(%ebp),%eax
 68c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68f:	75 20                	jne    6b1 <free+0xc5>
    p->s.size += bp->s.size;
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 50 04             	mov    0x4(%eax),%edx
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	8b 40 04             	mov    0x4(%eax),%eax
 69d:	01 c2                	add    %eax,%edx
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a8:	8b 10                	mov    (%eax),%edx
 6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ad:	89 10                	mov    %edx,(%eax)
 6af:	eb 08                	jmp    6b9 <free+0xcd>
  } else
    p->s.ptr = bp;
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	a3 68 14 00 00       	mov    %eax,0x1468
}
 6c1:	c9                   	leave  
 6c2:	c3                   	ret    

000006c3 <morecore>:

static Header*
morecore(uint nu)
{
 6c3:	55                   	push   %ebp
 6c4:	89 e5                	mov    %esp,%ebp
 6c6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6d0:	77 07                	ja     6d9 <morecore+0x16>
    nu = 4096;
 6d2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
 6dc:	c1 e0 03             	shl    $0x3,%eax
 6df:	89 04 24             	mov    %eax,(%esp)
 6e2:	e8 29 fc ff ff       	call   310 <sbrk>
 6e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ea:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ee:	75 07                	jne    6f7 <morecore+0x34>
    return 0;
 6f0:	b8 00 00 00 00       	mov    $0x0,%eax
 6f5:	eb 22                	jmp    719 <morecore+0x56>
  hp = (Header*)p;
 6f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 700:	8b 55 08             	mov    0x8(%ebp),%edx
 703:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 706:	8b 45 f0             	mov    -0x10(%ebp),%eax
 709:	83 c0 08             	add    $0x8,%eax
 70c:	89 04 24             	mov    %eax,(%esp)
 70f:	e8 d8 fe ff ff       	call   5ec <free>
  return freep;
 714:	a1 68 14 00 00       	mov    0x1468,%eax
}
 719:	c9                   	leave  
 71a:	c3                   	ret    

0000071b <malloc>:

void*
malloc(uint nbytes)
{
 71b:	55                   	push   %ebp
 71c:	89 e5                	mov    %esp,%ebp
 71e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 721:	8b 45 08             	mov    0x8(%ebp),%eax
 724:	83 c0 07             	add    $0x7,%eax
 727:	c1 e8 03             	shr    $0x3,%eax
 72a:	83 c0 01             	add    $0x1,%eax
 72d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 730:	a1 68 14 00 00       	mov    0x1468,%eax
 735:	89 45 f0             	mov    %eax,-0x10(%ebp)
 738:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 73c:	75 23                	jne    761 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 73e:	c7 45 f0 60 14 00 00 	movl   $0x1460,-0x10(%ebp)
 745:	8b 45 f0             	mov    -0x10(%ebp),%eax
 748:	a3 68 14 00 00       	mov    %eax,0x1468
 74d:	a1 68 14 00 00       	mov    0x1468,%eax
 752:	a3 60 14 00 00       	mov    %eax,0x1460
    base.s.size = 0;
 757:	c7 05 64 14 00 00 00 	movl   $0x0,0x1464
 75e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 761:	8b 45 f0             	mov    -0x10(%ebp),%eax
 764:	8b 00                	mov    (%eax),%eax
 766:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 769:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76c:	8b 40 04             	mov    0x4(%eax),%eax
 76f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 772:	72 4d                	jb     7c1 <malloc+0xa6>
      if(p->s.size == nunits)
 774:	8b 45 f4             	mov    -0xc(%ebp),%eax
 777:	8b 40 04             	mov    0x4(%eax),%eax
 77a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 77d:	75 0c                	jne    78b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 77f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 782:	8b 10                	mov    (%eax),%edx
 784:	8b 45 f0             	mov    -0x10(%ebp),%eax
 787:	89 10                	mov    %edx,(%eax)
 789:	eb 26                	jmp    7b1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	89 c2                	mov    %eax,%edx
 793:	2b 55 ec             	sub    -0x14(%ebp),%edx
 796:	8b 45 f4             	mov    -0xc(%ebp),%eax
 799:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	8b 40 04             	mov    0x4(%eax),%eax
 7a2:	c1 e0 03             	shl    $0x3,%eax
 7a5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ae:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	a3 68 14 00 00       	mov    %eax,0x1468
      return (void*)(p + 1);
 7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bc:	83 c0 08             	add    $0x8,%eax
 7bf:	eb 38                	jmp    7f9 <malloc+0xde>
    }
    if(p == freep)
 7c1:	a1 68 14 00 00       	mov    0x1468,%eax
 7c6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c9:	75 1b                	jne    7e6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7ce:	89 04 24             	mov    %eax,(%esp)
 7d1:	e8 ed fe ff ff       	call   6c3 <morecore>
 7d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7dd:	75 07                	jne    7e6 <malloc+0xcb>
        return 0;
 7df:	b8 00 00 00 00       	mov    $0x0,%eax
 7e4:	eb 13                	jmp    7f9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 00                	mov    (%eax),%eax
 7f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7f4:	e9 70 ff ff ff       	jmp    769 <malloc+0x4e>
}
 7f9:	c9                   	leave  
 7fa:	c3                   	ret    
 7fb:	90                   	nop

000007fc <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
 7fc:	55                   	push   %ebp
 7fd:	89 e5                	mov    %esp,%ebp
 7ff:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
 802:	a1 80 5d 00 00       	mov    0x5d80,%eax
 807:	8b 40 04             	mov    0x4(%eax),%eax
 80a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
 80d:	a1 80 5d 00 00       	mov    0x5d80,%eax
 812:	8b 00                	mov    (%eax),%eax
 814:	89 44 24 08          	mov    %eax,0x8(%esp)
 818:	c7 44 24 04 58 0f 00 	movl   $0xf58,0x4(%esp)
 81f:	00 
 820:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 827:	e8 0b fc ff ff       	call   437 <printf>
  while((newesp < (int *)currentThread->ebp))
 82c:	eb 3c                	jmp    86a <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
 82e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 831:	89 44 24 08          	mov    %eax,0x8(%esp)
 835:	c7 44 24 04 6e 0f 00 	movl   $0xf6e,0x4(%esp)
 83c:	00 
 83d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 844:	e8 ee fb ff ff       	call   437 <printf>
      printf(1,"val:%x\n",*newesp);
 849:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84c:	8b 00                	mov    (%eax),%eax
 84e:	89 44 24 08          	mov    %eax,0x8(%esp)
 852:	c7 44 24 04 76 0f 00 	movl   $0xf76,0x4(%esp)
 859:	00 
 85a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 861:	e8 d1 fb ff ff       	call   437 <printf>
    newesp++;
 866:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
 86a:	a1 80 5d 00 00       	mov    0x5d80,%eax
 86f:	8b 40 08             	mov    0x8(%eax),%eax
 872:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 875:	77 b7                	ja     82e <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
 877:	c9                   	leave  
 878:	c3                   	ret    

00000879 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
 879:	55                   	push   %ebp
 87a:	89 e5                	mov    %esp,%ebp
 87c:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 87f:	8b 45 08             	mov    0x8(%ebp),%eax
 882:	83 c0 01             	add    $0x1,%eax
 885:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 888:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 88c:	75 07                	jne    895 <getNextThread+0x1c>
    i=0;
 88e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 895:	8b 45 fc             	mov    -0x4(%ebp),%eax
 898:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 89e:	05 80 14 00 00       	add    $0x1480,%eax
 8a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 8a6:	eb 3b                	jmp    8e3 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 8a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ab:	8b 40 10             	mov    0x10(%eax),%eax
 8ae:	83 f8 03             	cmp    $0x3,%eax
 8b1:	75 05                	jne    8b8 <getNextThread+0x3f>
      return i;
 8b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b6:	eb 38                	jmp    8f0 <getNextThread+0x77>
    i++;
 8b8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 8bc:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8c0:	75 1a                	jne    8dc <getNextThread+0x63>
    {
     i=0;
 8c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
 8c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 8d2:	05 80 14 00 00       	add    $0x1480,%eax
 8d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
 8da:	eb 07                	jmp    8e3 <getNextThread+0x6a>
   }
   else
    t++;
 8dc:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 8e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e6:	3b 45 08             	cmp    0x8(%ebp),%eax
 8e9:	75 bd                	jne    8a8 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
 8eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 8f0:	c9                   	leave  
 8f1:	c3                   	ret    

000008f2 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
 8f2:	55                   	push   %ebp
 8f3:	89 e5                	mov    %esp,%ebp
 8f5:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 8f8:	c7 45 ec 80 14 00 00 	movl   $0x1480,-0x14(%ebp)
 8ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 906:	eb 15                	jmp    91d <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 908:	8b 45 ec             	mov    -0x14(%ebp),%eax
 90b:	8b 40 10             	mov    0x10(%eax),%eax
 90e:	85 c0                	test   %eax,%eax
 910:	74 1e                	je     930 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 912:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
 919:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 91d:	81 7d ec 80 5d 00 00 	cmpl   $0x5d80,-0x14(%ebp)
 924:	72 e2                	jb     908 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 926:	b8 00 00 00 00       	mov    $0x0,%eax
 92b:	e9 a3 00 00 00       	jmp    9d3 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
 930:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
 931:	8b 45 ec             	mov    -0x14(%ebp),%eax
 934:	8b 55 f4             	mov    -0xc(%ebp),%edx
 937:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
 939:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 93d:	75 1c                	jne    95b <allocThread+0x69>
  {
    STORE_ESP(t->esp);
 93f:	89 e2                	mov    %esp,%edx
 941:	8b 45 ec             	mov    -0x14(%ebp),%eax
 944:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
 947:	89 ea                	mov    %ebp,%edx
 949:	8b 45 ec             	mov    -0x14(%ebp),%eax
 94c:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
 94f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 952:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
 959:	eb 3b                	jmp    996 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
 95b:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 962:	e8 b4 fd ff ff       	call   71b <malloc>
 967:	8b 55 ec             	mov    -0x14(%ebp),%edx
 96a:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
 96d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 970:	8b 40 0c             	mov    0xc(%eax),%eax
 973:	05 00 10 00 00       	add    $0x1000,%eax
 978:	89 c2                	mov    %eax,%edx
 97a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 97d:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
 980:	8b 45 ec             	mov    -0x14(%ebp),%eax
 983:	8b 50 08             	mov    0x8(%eax),%edx
 986:	8b 45 ec             	mov    -0x14(%ebp),%eax
 989:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
 98c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 98f:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
 996:	8b 45 ec             	mov    -0x14(%ebp),%eax
 999:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
 9a0:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
 9a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 9aa:	eb 14                	jmp    9c0 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
 9ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9af:	8b 55 f0             	mov    -0x10(%ebp),%edx
 9b2:	83 c2 08             	add    $0x8,%edx
 9b5:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
 9bc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 9c0:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 9c4:	7e e6                	jle    9ac <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
 9c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9c9:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
 9d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 9d3:	c9                   	leave  
 9d4:	c3                   	ret    

000009d5 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
 9d5:	55                   	push   %ebp
 9d6:	89 e5                	mov    %esp,%ebp
 9d8:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 9db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 9e2:	eb 18                	jmp    9fc <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
 9e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 9ed:	05 90 14 00 00       	add    $0x1490,%eax
 9f2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 9f8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 9fc:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 a00:	7e e2                	jle    9e4 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
 a02:	e8 eb fe ff ff       	call   8f2 <allocThread>
 a07:	a3 80 5d 00 00       	mov    %eax,0x5d80
  if(currentThread==0)
 a0c:	a1 80 5d 00 00       	mov    0x5d80,%eax
 a11:	85 c0                	test   %eax,%eax
 a13:	75 07                	jne    a1c <uthread_init+0x47>
    return -1;
 a15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a1a:	eb 6b                	jmp    a87 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
 a1c:	a1 80 5d 00 00       	mov    0x5d80,%eax
 a21:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
 a28:	c7 44 24 04 0f 0d 00 	movl   $0xd0f,0x4(%esp)
 a2f:	00 
 a30:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a37:	e8 0c f9 ff ff       	call   348 <signal>
 a3c:	85 c0                	test   %eax,%eax
 a3e:	79 19                	jns    a59 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
 a40:	c7 44 24 04 80 0f 00 	movl   $0xf80,0x4(%esp)
 a47:	00 
 a48:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a4f:	e8 e3 f9 ff ff       	call   437 <printf>
    exit();
 a54:	e8 2f f8 ff ff       	call   288 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
 a59:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 a60:	e8 f3 f8 ff ff       	call   358 <alarm>
 a65:	85 c0                	test   %eax,%eax
 a67:	79 19                	jns    a82 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
 a69:	c7 44 24 04 a0 0f 00 	movl   $0xfa0,0x4(%esp)
 a70:	00 
 a71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a78:	e8 ba f9 ff ff       	call   437 <printf>
    exit();
 a7d:	e8 06 f8 ff ff       	call   288 <exit>
  }
  return 0;
 a82:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a87:	c9                   	leave  
 a88:	c3                   	ret    

00000a89 <wrap_func>:

void
wrap_func()
{
 a89:	55                   	push   %ebp
 a8a:	89 e5                	mov    %esp,%ebp
 a8c:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
 a8f:	a1 80 5d 00 00       	mov    0x5d80,%eax
 a94:	8b 50 18             	mov    0x18(%eax),%edx
 a97:	a1 80 5d 00 00       	mov    0x5d80,%eax
 a9c:	8b 40 1c             	mov    0x1c(%eax),%eax
 a9f:	89 04 24             	mov    %eax,(%esp)
 aa2:	ff d2                	call   *%edx
  uthread_exit();
 aa4:	e8 6c 00 00 00       	call   b15 <uthread_exit>
}
 aa9:	c9                   	leave  
 aaa:	c3                   	ret    

00000aab <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
 aab:	55                   	push   %ebp
 aac:	89 e5                	mov    %esp,%ebp
 aae:	53                   	push   %ebx
 aaf:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
 ab2:	e8 3b fe ff ff       	call   8f2 <allocThread>
 ab7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
 aba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 abe:	75 07                	jne    ac7 <uthread_create+0x1c>
    return -1;
 ac0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ac5:	eb 48                	jmp    b0f <uthread_create+0x64>

  t->func=start_func;
 ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aca:	8b 55 08             	mov    0x8(%ebp),%edx
 acd:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
 ad0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
 ad6:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
 ad9:	89 e3                	mov    %esp,%ebx
 adb:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
 ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae1:	8b 40 04             	mov    0x4(%eax),%eax
 ae4:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
 ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae9:	8b 50 08             	mov    0x8(%eax),%edx
 aec:	b8 89 0a 00 00       	mov    $0xa89,%eax
 af1:	50                   	push   %eax
 af2:	52                   	push   %edx
 af3:	89 e2                	mov    %esp,%edx
 af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af8:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
 afb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 afe:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
 b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b03:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 b0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b0d:	8b 00                	mov    (%eax),%eax
}
 b0f:	83 c4 14             	add    $0x14,%esp
 b12:	5b                   	pop    %ebx
 b13:	5d                   	pop    %ebp
 b14:	c3                   	ret    

00000b15 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
 b15:	55                   	push   %ebp
 b16:	89 e5                	mov    %esp,%ebp
 b18:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 b1b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 b22:	e8 31 f8 ff ff       	call   358 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 b27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 b2e:	eb 51                	jmp    b81 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
 b30:	a1 80 5d 00 00       	mov    0x5d80,%eax
 b35:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b38:	83 c2 08             	add    $0x8,%edx
 b3b:	8b 04 90             	mov    (%eax,%edx,4),%eax
 b3e:	83 f8 01             	cmp    $0x1,%eax
 b41:	75 3a                	jne    b7d <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
 b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b46:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 b4c:	05 a0 15 00 00       	add    $0x15a0,%eax
 b51:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
 b57:	a1 80 5d 00 00       	mov    0x5d80,%eax
 b5c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b5f:	83 c2 08             	add    $0x8,%edx
 b62:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
 b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 b72:	05 90 14 00 00       	add    $0x1490,%eax
 b77:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 b7d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 b81:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 b85:	7e a9                	jle    b30 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
 b87:	a1 80 5d 00 00       	mov    0x5d80,%eax
 b8c:	8b 00                	mov    (%eax),%eax
 b8e:	89 04 24             	mov    %eax,(%esp)
 b91:	e8 e3 fc ff ff       	call   879 <getNextThread>
 b96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
 b99:	a1 80 5d 00 00       	mov    0x5d80,%eax
 b9e:	8b 00                	mov    (%eax),%eax
 ba0:	85 c0                	test   %eax,%eax
 ba2:	74 10                	je     bb4 <uthread_exit+0x9f>
    free(currentThread->stack);
 ba4:	a1 80 5d 00 00       	mov    0x5d80,%eax
 ba9:	8b 40 0c             	mov    0xc(%eax),%eax
 bac:	89 04 24             	mov    %eax,(%esp)
 baf:	e8 38 fa ff ff       	call   5ec <free>
  currentThread->tid=-1;
 bb4:	a1 80 5d 00 00       	mov    0x5d80,%eax
 bb9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 bbf:	a1 80 5d 00 00       	mov    0x5d80,%eax
 bc4:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 bcb:	a1 80 5d 00 00       	mov    0x5d80,%eax
 bd0:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
 bd7:	a1 80 5d 00 00       	mov    0x5d80,%eax
 bdc:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
 be3:	a1 80 5d 00 00       	mov    0x5d80,%eax
 be8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
 bef:	a1 80 5d 00 00       	mov    0x5d80,%eax
 bf4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
 bfb:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c00:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
 c07:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c0c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
 c13:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c17:	78 7a                	js     c93 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
 c19:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c1c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 c22:	05 80 14 00 00       	add    $0x1480,%eax
 c27:	a3 80 5d 00 00       	mov    %eax,0x5d80
    currentThread->state=T_RUNNING;
 c2c:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c31:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
 c38:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c3d:	8b 40 04             	mov    0x4(%eax),%eax
 c40:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 c42:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c47:	8b 40 08             	mov    0x8(%eax),%eax
 c4a:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
 c4c:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 c53:	e8 00 f7 ff ff       	call   358 <alarm>
 c58:	85 c0                	test   %eax,%eax
 c5a:	79 19                	jns    c75 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
 c5c:	c7 44 24 04 a0 0f 00 	movl   $0xfa0,0x4(%esp)
 c63:	00 
 c64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c6b:	e8 c7 f7 ff ff       	call   437 <printf>
      exit();
 c70:	e8 13 f6 ff ff       	call   288 <exit>
    }
    
    if(currentThread->firstTime==1)
 c75:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c7a:	8b 40 14             	mov    0x14(%eax),%eax
 c7d:	83 f8 01             	cmp    $0x1,%eax
 c80:	75 10                	jne    c92 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
 c82:	a1 80 5d 00 00       	mov    0x5d80,%eax
 c87:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
 c8e:	5d                   	pop    %ebp
 c8f:	c3                   	ret    
 c90:	eb 01                	jmp    c93 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
 c92:	61                   	popa   
    }
  }
}
 c93:	c9                   	leave  
 c94:	c3                   	ret    

00000c95 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
 c95:	55                   	push   %ebp
 c96:	89 e5                	mov    %esp,%ebp
 c98:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 c9b:	8b 45 08             	mov    0x8(%ebp),%eax
 c9e:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 ca4:	05 80 14 00 00       	add    $0x1480,%eax
 ca9:	8b 40 10             	mov    0x10(%eax),%eax
 cac:	85 c0                	test   %eax,%eax
 cae:	75 07                	jne    cb7 <uthread_join+0x22>
    return -1;
 cb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 cb5:	eb 56                	jmp    d0d <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
 cb7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 cbe:	e8 95 f6 ff ff       	call   358 <alarm>
    currentThread->waitingFor=tid;
 cc3:	a1 80 5d 00 00       	mov    0x5d80,%eax
 cc8:	8b 55 08             	mov    0x8(%ebp),%edx
 ccb:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
 cd1:	a1 80 5d 00 00       	mov    0x5d80,%eax
 cd6:	8b 08                	mov    (%eax),%ecx
 cd8:	8b 55 08             	mov    0x8(%ebp),%edx
 cdb:	89 d0                	mov    %edx,%eax
 cdd:	c1 e0 03             	shl    $0x3,%eax
 ce0:	01 d0                	add    %edx,%eax
 ce2:	c1 e0 03             	shl    $0x3,%eax
 ce5:	01 d0                	add    %edx,%eax
 ce7:	01 c8                	add    %ecx,%eax
 ce9:	83 c0 08             	add    $0x8,%eax
 cec:	c7 04 85 80 14 00 00 	movl   $0x1,0x1480(,%eax,4)
 cf3:	01 00 00 00 
    currentThread->state=T_SLEEPING;
 cf7:	a1 80 5d 00 00       	mov    0x5d80,%eax
 cfc:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
 d03:	e8 07 00 00 00       	call   d0f <uthread_yield>
    return 1;
 d08:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d0d:	c9                   	leave  
 d0e:	c3                   	ret    

00000d0f <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
 d0f:	55                   	push   %ebp
 d10:	89 e5                	mov    %esp,%ebp
 d12:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 d15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d1c:	e8 37 f6 ff ff       	call   358 <alarm>
  int new=getNextThread(currentThread->tid);
 d21:	a1 80 5d 00 00       	mov    0x5d80,%eax
 d26:	8b 00                	mov    (%eax),%eax
 d28:	89 04 24             	mov    %eax,(%esp)
 d2b:	e8 49 fb ff ff       	call   879 <getNextThread>
 d30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
 d33:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 d37:	75 2d                	jne    d66 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
 d39:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 d40:	e8 13 f6 ff ff       	call   358 <alarm>
 d45:	85 c0                	test   %eax,%eax
 d47:	0f 89 c1 00 00 00    	jns    e0e <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
 d4d:	c7 44 24 04 c0 0f 00 	movl   $0xfc0,0x4(%esp)
 d54:	00 
 d55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d5c:	e8 d6 f6 ff ff       	call   437 <printf>
      exit();
 d61:	e8 22 f5 ff ff       	call   288 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
 d66:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 d67:	a1 80 5d 00 00       	mov    0x5d80,%eax
 d6c:	89 e2                	mov    %esp,%edx
 d6e:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
 d71:	a1 80 5d 00 00       	mov    0x5d80,%eax
 d76:	89 ea                	mov    %ebp,%edx
 d78:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
 d7b:	a1 80 5d 00 00       	mov    0x5d80,%eax
 d80:	8b 40 10             	mov    0x10(%eax),%eax
 d83:	83 f8 02             	cmp    $0x2,%eax
 d86:	75 0c                	jne    d94 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
 d88:	a1 80 5d 00 00       	mov    0x5d80,%eax
 d8d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
 d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
 d97:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 d9d:	05 80 14 00 00       	add    $0x1480,%eax
 da2:	a3 80 5d 00 00       	mov    %eax,0x5d80

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
 da7:	a1 80 5d 00 00       	mov    0x5d80,%eax
 dac:	8b 40 04             	mov    0x4(%eax),%eax
 daf:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 db1:	a1 80 5d 00 00       	mov    0x5d80,%eax
 db6:	8b 40 08             	mov    0x8(%eax),%eax
 db9:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
 dbb:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 dc2:	e8 91 f5 ff ff       	call   358 <alarm>
 dc7:	85 c0                	test   %eax,%eax
 dc9:	79 19                	jns    de4 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
 dcb:	c7 44 24 04 c0 0f 00 	movl   $0xfc0,0x4(%esp)
 dd2:	00 
 dd3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 dda:	e8 58 f6 ff ff       	call   437 <printf>
      exit();
 ddf:	e8 a4 f4 ff ff       	call   288 <exit>
    }  
    currentThread->state=T_RUNNING;
 de4:	a1 80 5d 00 00       	mov    0x5d80,%eax
 de9:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
 df0:	a1 80 5d 00 00       	mov    0x5d80,%eax
 df5:	8b 40 14             	mov    0x14(%eax),%eax
 df8:	83 f8 01             	cmp    $0x1,%eax
 dfb:	75 10                	jne    e0d <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
 dfd:	a1 80 5d 00 00       	mov    0x5d80,%eax
 e02:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
 e09:	5d                   	pop    %ebp
 e0a:	c3                   	ret    
 e0b:	eb 01                	jmp    e0e <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
 e0d:	61                   	popa   
    }
  }
}
 e0e:	c9                   	leave  
 e0f:	c3                   	ret    

00000e10 <uthread_self>:

int
uthread_self(void)
{
 e10:	55                   	push   %ebp
 e11:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 e13:	a1 80 5d 00 00       	mov    0x5d80,%eax
 e18:	8b 00                	mov    (%eax),%eax
 e1a:	5d                   	pop    %ebp
 e1b:	c3                   	ret    

00000e1c <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
 e1c:	55                   	push   %ebp
 e1d:	89 e5                	mov    %esp,%ebp
 e1f:	53                   	push   %ebx
 e20:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
 e23:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e26:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
 e29:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e2c:	89 c3                	mov    %eax,%ebx
 e2e:	89 d8                	mov    %ebx,%eax
 e30:	f0 87 02             	lock xchg %eax,(%edx)
 e33:	89 c3                	mov    %eax,%ebx
 e35:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 e38:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
 e3b:	83 c4 10             	add    $0x10,%esp
 e3e:	5b                   	pop    %ebx
 e3f:	5d                   	pop    %ebp
 e40:	c3                   	ret    

00000e41 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
 e41:	55                   	push   %ebp
 e42:	89 e5                	mov    %esp,%ebp
 e44:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
 e47:	8b 45 08             	mov    0x8(%ebp),%eax
 e4a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
 e51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 e55:	74 0c                	je     e63 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
 e57:	8b 45 08             	mov    0x8(%ebp),%eax
 e5a:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
 e61:	eb 0b                	jmp    e6e <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
 e63:	e8 a8 ff ff ff       	call   e10 <uthread_self>
 e68:	8b 55 08             	mov    0x8(%ebp),%edx
 e6b:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
 e6e:	8b 55 0c             	mov    0xc(%ebp),%edx
 e71:	8b 45 08             	mov    0x8(%ebp),%eax
 e74:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
 e76:	8b 45 08             	mov    0x8(%ebp),%eax
 e79:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
 e80:	c9                   	leave  
 e81:	c3                   	ret    

00000e82 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
 e82:	55                   	push   %ebp
 e83:	89 e5                	mov    %esp,%ebp
 e85:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
 e88:	8b 45 08             	mov    0x8(%ebp),%eax
 e8b:	8b 40 08             	mov    0x8(%eax),%eax
 e8e:	85 c0                	test   %eax,%eax
 e90:	75 20                	jne    eb2 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 e92:	8b 45 08             	mov    0x8(%ebp),%eax
 e95:	8b 40 04             	mov    0x4(%eax),%eax
 e98:	89 44 24 08          	mov    %eax,0x8(%esp)
 e9c:	c7 44 24 04 e4 0f 00 	movl   $0xfe4,0x4(%esp)
 ea3:	00 
 ea4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 eab:	e8 87 f5 ff ff       	call   437 <printf>
    return;
 eb0:	eb 3a                	jmp    eec <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
 eb2:	e8 59 ff ff ff       	call   e10 <uthread_self>
 eb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
 eba:	8b 45 08             	mov    0x8(%ebp),%eax
 ebd:	8b 40 04             	mov    0x4(%eax),%eax
 ec0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 ec3:	74 27                	je     eec <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 ec5:	eb 05                	jmp    ecc <binary_semaphore_down+0x4a>
    {
      uthread_yield();
 ec7:	e8 43 fe ff ff       	call   d0f <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 ecc:	8b 45 08             	mov    0x8(%ebp),%eax
 ecf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 ed6:	00 
 ed7:	89 04 24             	mov    %eax,(%esp)
 eda:	e8 3d ff ff ff       	call   e1c <xchg>
 edf:	85 c0                	test   %eax,%eax
 ee1:	74 e4                	je     ec7 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
 ee3:	8b 45 08             	mov    0x8(%ebp),%eax
 ee6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ee9:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
 eec:	c9                   	leave  
 eed:	c3                   	ret    

00000eee <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
 eee:	55                   	push   %ebp
 eef:	89 e5                	mov    %esp,%ebp
 ef1:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
 ef4:	8b 45 08             	mov    0x8(%ebp),%eax
 ef7:	8b 40 08             	mov    0x8(%eax),%eax
 efa:	85 c0                	test   %eax,%eax
 efc:	75 20                	jne    f1e <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 efe:	8b 45 08             	mov    0x8(%ebp),%eax
 f01:	8b 40 04             	mov    0x4(%eax),%eax
 f04:	89 44 24 08          	mov    %eax,0x8(%esp)
 f08:	c7 44 24 04 14 10 00 	movl   $0x1014,0x4(%esp)
 f0f:	00 
 f10:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f17:	e8 1b f5 ff ff       	call   437 <printf>
    return;
 f1c:	eb 2f                	jmp    f4d <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
 f1e:	e8 ed fe ff ff       	call   e10 <uthread_self>
 f23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
 f26:	8b 45 08             	mov    0x8(%ebp),%eax
 f29:	8b 00                	mov    (%eax),%eax
 f2b:	85 c0                	test   %eax,%eax
 f2d:	75 1e                	jne    f4d <binary_semaphore_up+0x5f>
 f2f:	8b 45 08             	mov    0x8(%ebp),%eax
 f32:	8b 40 04             	mov    0x4(%eax),%eax
 f35:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 f38:	75 13                	jne    f4d <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
 f3a:	8b 45 08             	mov    0x8(%ebp),%eax
 f3d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
 f44:	8b 45 08             	mov    0x8(%ebp),%eax
 f47:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
 f4d:	c9                   	leave  
 f4e:	c3                   	ret    
