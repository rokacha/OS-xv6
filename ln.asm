
_ln:     file format elf32-i386


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
   6:	83 ec 10             	sub    $0x10,%esp
  if(argc != 3){
   9:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
   d:	74 19                	je     28 <main+0x28>
    printf(2, "Usage: ln old new\n");
   f:	c7 44 24 04 b8 0c 00 	movl   $0xcb8,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 6c 04 00 00       	call   48f <printf>
    exit();
  23:	e8 b8 02 00 00       	call   2e0 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  28:	8b 45 0c             	mov    0xc(%ebp),%eax
  2b:	83 c0 08             	add    $0x8,%eax
  2e:	8b 10                	mov    (%eax),%edx
  30:	8b 45 0c             	mov    0xc(%ebp),%eax
  33:	83 c0 04             	add    $0x4,%eax
  36:	8b 00                	mov    (%eax),%eax
  38:	89 54 24 04          	mov    %edx,0x4(%esp)
  3c:	89 04 24             	mov    %eax,(%esp)
  3f:	e8 fc 02 00 00       	call   340 <link>
  44:	85 c0                	test   %eax,%eax
  46:	79 2c                	jns    74 <main+0x74>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	8b 45 0c             	mov    0xc(%ebp),%eax
  4b:	83 c0 08             	add    $0x8,%eax
  4e:	8b 10                	mov    (%eax),%edx
  50:	8b 45 0c             	mov    0xc(%ebp),%eax
  53:	83 c0 04             	add    $0x4,%eax
  56:	8b 00                	mov    (%eax),%eax
  58:	89 54 24 0c          	mov    %edx,0xc(%esp)
  5c:	89 44 24 08          	mov    %eax,0x8(%esp)
  60:	c7 44 24 04 cb 0c 00 	movl   $0xccb,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	e8 1b 04 00 00       	call   48f <printf>
  exit();
  74:	e8 67 02 00 00       	call   2e0 <exit>
  79:	90                   	nop
  7a:	90                   	nop
  7b:	90                   	nop

0000007c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7c:	55                   	push   %ebp
  7d:	89 e5                	mov    %esp,%ebp
  7f:	57                   	push   %edi
  80:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  81:	8b 4d 08             	mov    0x8(%ebp),%ecx
  84:	8b 55 10             	mov    0x10(%ebp),%edx
  87:	8b 45 0c             	mov    0xc(%ebp),%eax
  8a:	89 cb                	mov    %ecx,%ebx
  8c:	89 df                	mov    %ebx,%edi
  8e:	89 d1                	mov    %edx,%ecx
  90:	fc                   	cld    
  91:	f3 aa                	rep stos %al,%es:(%edi)
  93:	89 ca                	mov    %ecx,%edx
  95:	89 fb                	mov    %edi,%ebx
  97:	89 5d 08             	mov    %ebx,0x8(%ebp)
  9a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9d:	5b                   	pop    %ebx
  9e:	5f                   	pop    %edi
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    

000000a1 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
  a1:	55                   	push   %ebp
  a2:	89 e5                	mov    %esp,%ebp
  a4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a7:	8b 45 08             	mov    0x8(%ebp),%eax
  aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ad:	90                   	nop
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	0f b6 10             	movzbl (%eax),%edx
  b4:	8b 45 08             	mov    0x8(%ebp),%eax
  b7:	88 10                	mov    %dl,(%eax)
  b9:	8b 45 08             	mov    0x8(%ebp),%eax
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	0f 95 c0             	setne  %al
  c4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  cc:	84 c0                	test   %al,%al
  ce:	75 de                	jne    ae <strcpy+0xd>
    ;
  return os;
  d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d3:	c9                   	leave  
  d4:	c3                   	ret    

000000d5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d5:	55                   	push   %ebp
  d6:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d8:	eb 08                	jmp    e2 <strcmp+0xd>
    p++, q++;
  da:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  de:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 00             	movzbl (%eax),%eax
  e8:	84 c0                	test   %al,%al
  ea:	74 10                	je     fc <strcmp+0x27>
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	0f b6 10             	movzbl (%eax),%edx
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	0f b6 00             	movzbl (%eax),%eax
  f8:	38 c2                	cmp    %al,%dl
  fa:	74 de                	je     da <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 00             	movzbl (%eax),%eax
 102:	0f b6 d0             	movzbl %al,%edx
 105:	8b 45 0c             	mov    0xc(%ebp),%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	0f b6 c0             	movzbl %al,%eax
 10e:	89 d1                	mov    %edx,%ecx
 110:	29 c1                	sub    %eax,%ecx
 112:	89 c8                	mov    %ecx,%eax
}
 114:	5d                   	pop    %ebp
 115:	c3                   	ret    

00000116 <strlen>:

uint
strlen(char *s)
{
 116:	55                   	push   %ebp
 117:	89 e5                	mov    %esp,%ebp
 119:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 11c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 123:	eb 04                	jmp    129 <strlen+0x13>
 125:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 129:	8b 45 fc             	mov    -0x4(%ebp),%eax
 12c:	03 45 08             	add    0x8(%ebp),%eax
 12f:	0f b6 00             	movzbl (%eax),%eax
 132:	84 c0                	test   %al,%al
 134:	75 ef                	jne    125 <strlen+0xf>
    ;
  return n;
 136:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 139:	c9                   	leave  
 13a:	c3                   	ret    

0000013b <memset>:

void*
memset(void *dst, int c, uint n)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 141:	8b 45 10             	mov    0x10(%ebp),%eax
 144:	89 44 24 08          	mov    %eax,0x8(%esp)
 148:	8b 45 0c             	mov    0xc(%ebp),%eax
 14b:	89 44 24 04          	mov    %eax,0x4(%esp)
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 22 ff ff ff       	call   7c <stosb>
  return dst;
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <strchr>:

char*
strchr(const char *s, char c)
{
 15f:	55                   	push   %ebp
 160:	89 e5                	mov    %esp,%ebp
 162:	83 ec 04             	sub    $0x4,%esp
 165:	8b 45 0c             	mov    0xc(%ebp),%eax
 168:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16b:	eb 14                	jmp    181 <strchr+0x22>
    if(*s == c)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	3a 45 fc             	cmp    -0x4(%ebp),%al
 176:	75 05                	jne    17d <strchr+0x1e>
      return (char*)s;
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	eb 13                	jmp    190 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 17d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 181:	8b 45 08             	mov    0x8(%ebp),%eax
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	84 c0                	test   %al,%al
 189:	75 e2                	jne    16d <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 18b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 190:	c9                   	leave  
 191:	c3                   	ret    

00000192 <gets>:

char*
gets(char *buf, int max)
{
 192:	55                   	push   %ebp
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 198:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 19f:	eb 44                	jmp    1e5 <gets+0x53>
    cc = read(0, &c, 1);
 1a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a8:	00 
 1a9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b7:	e8 3c 01 00 00       	call   2f8 <read>
 1bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c3:	7e 2d                	jle    1f2 <gets+0x60>
      break;
    buf[i++] = c;
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	03 45 08             	add    0x8(%ebp),%eax
 1cb:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1cf:	88 10                	mov    %dl,(%eax)
 1d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d9:	3c 0a                	cmp    $0xa,%al
 1db:	74 16                	je     1f3 <gets+0x61>
 1dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e1:	3c 0d                	cmp    $0xd,%al
 1e3:	74 0e                	je     1f3 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e8:	83 c0 01             	add    $0x1,%eax
 1eb:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1ee:	7c b1                	jl     1a1 <gets+0xf>
 1f0:	eb 01                	jmp    1f3 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1f2:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f6:	03 45 08             	add    0x8(%ebp),%eax
 1f9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <stat>:

int
stat(char *n, struct stat *st)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 207:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 20e:	00 
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	89 04 24             	mov    %eax,(%esp)
 215:	e8 06 01 00 00       	call   320 <open>
 21a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 21d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 221:	79 07                	jns    22a <stat+0x29>
    return -1;
 223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 228:	eb 23                	jmp    24d <stat+0x4c>
  r = fstat(fd, st);
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 44 24 04          	mov    %eax,0x4(%esp)
 231:	8b 45 f4             	mov    -0xc(%ebp),%eax
 234:	89 04 24             	mov    %eax,(%esp)
 237:	e8 fc 00 00 00       	call   338 <fstat>
 23c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 242:	89 04 24             	mov    %eax,(%esp)
 245:	e8 be 00 00 00       	call   308 <close>
  return r;
 24a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 24d:	c9                   	leave  
 24e:	c3                   	ret    

0000024f <atoi>:

int
atoi(const char *s)
{
 24f:	55                   	push   %ebp
 250:	89 e5                	mov    %esp,%ebp
 252:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 255:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25c:	eb 23                	jmp    281 <atoi+0x32>
    n = n*10 + *s++ - '0';
 25e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 261:	89 d0                	mov    %edx,%eax
 263:	c1 e0 02             	shl    $0x2,%eax
 266:	01 d0                	add    %edx,%eax
 268:	01 c0                	add    %eax,%eax
 26a:	89 c2                	mov    %eax,%edx
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	0f b6 00             	movzbl (%eax),%eax
 272:	0f be c0             	movsbl %al,%eax
 275:	01 d0                	add    %edx,%eax
 277:	83 e8 30             	sub    $0x30,%eax
 27a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 27d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 281:	8b 45 08             	mov    0x8(%ebp),%eax
 284:	0f b6 00             	movzbl (%eax),%eax
 287:	3c 2f                	cmp    $0x2f,%al
 289:	7e 0a                	jle    295 <atoi+0x46>
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	0f b6 00             	movzbl (%eax),%eax
 291:	3c 39                	cmp    $0x39,%al
 293:	7e c9                	jle    25e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 295:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 298:	c9                   	leave  
 299:	c3                   	ret    

0000029a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 29a:	55                   	push   %ebp
 29b:	89 e5                	mov    %esp,%ebp
 29d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a0:	8b 45 08             	mov    0x8(%ebp),%eax
 2a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2ac:	eb 13                	jmp    2c1 <memmove+0x27>
    *dst++ = *src++;
 2ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2b1:	0f b6 10             	movzbl (%eax),%edx
 2b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b7:	88 10                	mov    %dl,(%eax)
 2b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2bd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2c5:	0f 9f c0             	setg   %al
 2c8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2cc:	84 c0                	test   %al,%al
 2ce:	75 de                	jne    2ae <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d3:	c9                   	leave  
 2d4:	c3                   	ret    
 2d5:	90                   	nop
 2d6:	90                   	nop
 2d7:	90                   	nop

000002d8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d8:	b8 01 00 00 00       	mov    $0x1,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exit>:
SYSCALL(exit)
 2e0:	b8 02 00 00 00       	mov    $0x2,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <wait>:
SYSCALL(wait)
 2e8:	b8 03 00 00 00       	mov    $0x3,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <pipe>:
SYSCALL(pipe)
 2f0:	b8 04 00 00 00       	mov    $0x4,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <read>:
SYSCALL(read)
 2f8:	b8 05 00 00 00       	mov    $0x5,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <write>:
SYSCALL(write)
 300:	b8 10 00 00 00       	mov    $0x10,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <close>:
SYSCALL(close)
 308:	b8 15 00 00 00       	mov    $0x15,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <kill>:
SYSCALL(kill)
 310:	b8 06 00 00 00       	mov    $0x6,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <exec>:
SYSCALL(exec)
 318:	b8 07 00 00 00       	mov    $0x7,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <open>:
SYSCALL(open)
 320:	b8 0f 00 00 00       	mov    $0xf,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <mknod>:
SYSCALL(mknod)
 328:	b8 11 00 00 00       	mov    $0x11,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <unlink>:
SYSCALL(unlink)
 330:	b8 12 00 00 00       	mov    $0x12,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <fstat>:
SYSCALL(fstat)
 338:	b8 08 00 00 00       	mov    $0x8,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <link>:
SYSCALL(link)
 340:	b8 13 00 00 00       	mov    $0x13,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <mkdir>:
SYSCALL(mkdir)
 348:	b8 14 00 00 00       	mov    $0x14,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <chdir>:
SYSCALL(chdir)
 350:	b8 09 00 00 00       	mov    $0x9,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <dup>:
SYSCALL(dup)
 358:	b8 0a 00 00 00       	mov    $0xa,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <getpid>:
SYSCALL(getpid)
 360:	b8 0b 00 00 00       	mov    $0xb,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <sbrk>:
SYSCALL(sbrk)
 368:	b8 0c 00 00 00       	mov    $0xc,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <sleep>:
SYSCALL(sleep)
 370:	b8 0d 00 00 00       	mov    $0xd,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <uptime>:
SYSCALL(uptime)
 378:	b8 0e 00 00 00       	mov    $0xe,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <add_path>:
SYSCALL(add_path)
 380:	b8 16 00 00 00       	mov    $0x16,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <wait2>:
SYSCALL(wait2)
 388:	b8 17 00 00 00       	mov    $0x17,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <getquanta>:
SYSCALL(getquanta)
 390:	b8 18 00 00 00       	mov    $0x18,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <getqueue>:
SYSCALL(getqueue)
 398:	b8 19 00 00 00       	mov    $0x19,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <signal>:
SYSCALL(signal)
 3a0:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <sigsend>:
SYSCALL(sigsend)
 3a8:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <alarm>:
SYSCALL(alarm)
 3b0:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3b8:	55                   	push   %ebp
 3b9:	89 e5                	mov    %esp,%ebp
 3bb:	83 ec 28             	sub    $0x28,%esp
 3be:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3cb:	00 
 3cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3cf:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	89 04 24             	mov    %eax,(%esp)
 3d9:	e8 22 ff ff ff       	call   300 <write>
}
 3de:	c9                   	leave  
 3df:	c3                   	ret    

000003e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3ed:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3f1:	74 17                	je     40a <printint+0x2a>
 3f3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3f7:	79 11                	jns    40a <printint+0x2a>
    neg = 1;
 3f9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 400:	8b 45 0c             	mov    0xc(%ebp),%eax
 403:	f7 d8                	neg    %eax
 405:	89 45 ec             	mov    %eax,-0x14(%ebp)
 408:	eb 06                	jmp    410 <printint+0x30>
  } else {
    x = xx;
 40a:	8b 45 0c             	mov    0xc(%ebp),%eax
 40d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 410:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 417:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41d:	ba 00 00 00 00       	mov    $0x0,%edx
 422:	f7 f1                	div    %ecx
 424:	89 d0                	mov    %edx,%eax
 426:	0f b6 90 98 10 00 00 	movzbl 0x1098(%eax),%edx
 42d:	8d 45 dc             	lea    -0x24(%ebp),%eax
 430:	03 45 f4             	add    -0xc(%ebp),%eax
 433:	88 10                	mov    %dl,(%eax)
 435:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 439:	8b 55 10             	mov    0x10(%ebp),%edx
 43c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 43f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 442:	ba 00 00 00 00       	mov    $0x0,%edx
 447:	f7 75 d4             	divl   -0x2c(%ebp)
 44a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 451:	75 c4                	jne    417 <printint+0x37>
  if(neg)
 453:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 457:	74 2a                	je     483 <printint+0xa3>
    buf[i++] = '-';
 459:	8d 45 dc             	lea    -0x24(%ebp),%eax
 45c:	03 45 f4             	add    -0xc(%ebp),%eax
 45f:	c6 00 2d             	movb   $0x2d,(%eax)
 462:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 466:	eb 1b                	jmp    483 <printint+0xa3>
    putc(fd, buf[i]);
 468:	8d 45 dc             	lea    -0x24(%ebp),%eax
 46b:	03 45 f4             	add    -0xc(%ebp),%eax
 46e:	0f b6 00             	movzbl (%eax),%eax
 471:	0f be c0             	movsbl %al,%eax
 474:	89 44 24 04          	mov    %eax,0x4(%esp)
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	89 04 24             	mov    %eax,(%esp)
 47e:	e8 35 ff ff ff       	call   3b8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 483:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 487:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 48b:	79 db                	jns    468 <printint+0x88>
    putc(fd, buf[i]);
}
 48d:	c9                   	leave  
 48e:	c3                   	ret    

0000048f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 48f:	55                   	push   %ebp
 490:	89 e5                	mov    %esp,%ebp
 492:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 495:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 49c:	8d 45 0c             	lea    0xc(%ebp),%eax
 49f:	83 c0 04             	add    $0x4,%eax
 4a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ac:	e9 7d 01 00 00       	jmp    62e <printf+0x19f>
    c = fmt[i] & 0xff;
 4b1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4b7:	01 d0                	add    %edx,%eax
 4b9:	0f b6 00             	movzbl (%eax),%eax
 4bc:	0f be c0             	movsbl %al,%eax
 4bf:	25 ff 00 00 00       	and    $0xff,%eax
 4c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4cb:	75 2c                	jne    4f9 <printf+0x6a>
      if(c == '%'){
 4cd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4d1:	75 0c                	jne    4df <printf+0x50>
        state = '%';
 4d3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4da:	e9 4b 01 00 00       	jmp    62a <printf+0x19b>
      } else {
        putc(fd, c);
 4df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4e2:	0f be c0             	movsbl %al,%eax
 4e5:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ec:	89 04 24             	mov    %eax,(%esp)
 4ef:	e8 c4 fe ff ff       	call   3b8 <putc>
 4f4:	e9 31 01 00 00       	jmp    62a <printf+0x19b>
      }
    } else if(state == '%'){
 4f9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4fd:	0f 85 27 01 00 00    	jne    62a <printf+0x19b>
      if(c == 'd'){
 503:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 507:	75 2d                	jne    536 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 509:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50c:	8b 00                	mov    (%eax),%eax
 50e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 515:	00 
 516:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 51d:	00 
 51e:	89 44 24 04          	mov    %eax,0x4(%esp)
 522:	8b 45 08             	mov    0x8(%ebp),%eax
 525:	89 04 24             	mov    %eax,(%esp)
 528:	e8 b3 fe ff ff       	call   3e0 <printint>
        ap++;
 52d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 531:	e9 ed 00 00 00       	jmp    623 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 536:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 53a:	74 06                	je     542 <printf+0xb3>
 53c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 540:	75 2d                	jne    56f <printf+0xe0>
        printint(fd, *ap, 16, 0);
 542:	8b 45 e8             	mov    -0x18(%ebp),%eax
 545:	8b 00                	mov    (%eax),%eax
 547:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 54e:	00 
 54f:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 556:	00 
 557:	89 44 24 04          	mov    %eax,0x4(%esp)
 55b:	8b 45 08             	mov    0x8(%ebp),%eax
 55e:	89 04 24             	mov    %eax,(%esp)
 561:	e8 7a fe ff ff       	call   3e0 <printint>
        ap++;
 566:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56a:	e9 b4 00 00 00       	jmp    623 <printf+0x194>
      } else if(c == 's'){
 56f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 573:	75 46                	jne    5bb <printf+0x12c>
        s = (char*)*ap;
 575:	8b 45 e8             	mov    -0x18(%ebp),%eax
 578:	8b 00                	mov    (%eax),%eax
 57a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 57d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 581:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 585:	75 27                	jne    5ae <printf+0x11f>
          s = "(null)";
 587:	c7 45 f4 df 0c 00 00 	movl   $0xcdf,-0xc(%ebp)
        while(*s != 0){
 58e:	eb 1e                	jmp    5ae <printf+0x11f>
          putc(fd, *s);
 590:	8b 45 f4             	mov    -0xc(%ebp),%eax
 593:	0f b6 00             	movzbl (%eax),%eax
 596:	0f be c0             	movsbl %al,%eax
 599:	89 44 24 04          	mov    %eax,0x4(%esp)
 59d:	8b 45 08             	mov    0x8(%ebp),%eax
 5a0:	89 04 24             	mov    %eax,(%esp)
 5a3:	e8 10 fe ff ff       	call   3b8 <putc>
          s++;
 5a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5ac:	eb 01                	jmp    5af <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ae:	90                   	nop
 5af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b2:	0f b6 00             	movzbl (%eax),%eax
 5b5:	84 c0                	test   %al,%al
 5b7:	75 d7                	jne    590 <printf+0x101>
 5b9:	eb 68                	jmp    623 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5bb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5bf:	75 1d                	jne    5de <printf+0x14f>
        putc(fd, *ap);
 5c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c4:	8b 00                	mov    (%eax),%eax
 5c6:	0f be c0             	movsbl %al,%eax
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	8b 45 08             	mov    0x8(%ebp),%eax
 5d0:	89 04 24             	mov    %eax,(%esp)
 5d3:	e8 e0 fd ff ff       	call   3b8 <putc>
        ap++;
 5d8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5dc:	eb 45                	jmp    623 <printf+0x194>
      } else if(c == '%'){
 5de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5e2:	75 17                	jne    5fb <printf+0x16c>
        putc(fd, c);
 5e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e7:	0f be c0             	movsbl %al,%eax
 5ea:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ee:	8b 45 08             	mov    0x8(%ebp),%eax
 5f1:	89 04 24             	mov    %eax,(%esp)
 5f4:	e8 bf fd ff ff       	call   3b8 <putc>
 5f9:	eb 28                	jmp    623 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5fb:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 602:	00 
 603:	8b 45 08             	mov    0x8(%ebp),%eax
 606:	89 04 24             	mov    %eax,(%esp)
 609:	e8 aa fd ff ff       	call   3b8 <putc>
        putc(fd, c);
 60e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 611:	0f be c0             	movsbl %al,%eax
 614:	89 44 24 04          	mov    %eax,0x4(%esp)
 618:	8b 45 08             	mov    0x8(%ebp),%eax
 61b:	89 04 24             	mov    %eax,(%esp)
 61e:	e8 95 fd ff ff       	call   3b8 <putc>
      }
      state = 0;
 623:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 62a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 62e:	8b 55 0c             	mov    0xc(%ebp),%edx
 631:	8b 45 f0             	mov    -0x10(%ebp),%eax
 634:	01 d0                	add    %edx,%eax
 636:	0f b6 00             	movzbl (%eax),%eax
 639:	84 c0                	test   %al,%al
 63b:	0f 85 70 fe ff ff    	jne    4b1 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 641:	c9                   	leave  
 642:	c3                   	ret    
 643:	90                   	nop

00000644 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 644:	55                   	push   %ebp
 645:	89 e5                	mov    %esp,%ebp
 647:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 64a:	8b 45 08             	mov    0x8(%ebp),%eax
 64d:	83 e8 08             	sub    $0x8,%eax
 650:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 653:	a1 c8 10 00 00       	mov    0x10c8,%eax
 658:	89 45 fc             	mov    %eax,-0x4(%ebp)
 65b:	eb 24                	jmp    681 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 00                	mov    (%eax),%eax
 662:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 665:	77 12                	ja     679 <free+0x35>
 667:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66d:	77 24                	ja     693 <free+0x4f>
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 677:	77 1a                	ja     693 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 687:	76 d4                	jbe    65d <free+0x19>
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 691:	76 ca                	jbe    65d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	8b 40 04             	mov    0x4(%eax),%eax
 699:	c1 e0 03             	shl    $0x3,%eax
 69c:	89 c2                	mov    %eax,%edx
 69e:	03 55 f8             	add    -0x8(%ebp),%edx
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	39 c2                	cmp    %eax,%edx
 6a8:	75 24                	jne    6ce <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	8b 00                	mov    (%eax),%eax
 6b5:	8b 40 04             	mov    0x4(%eax),%eax
 6b8:	01 c2                	add    %eax,%edx
 6ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	8b 00                	mov    (%eax),%eax
 6c5:	8b 10                	mov    (%eax),%edx
 6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ca:	89 10                	mov    %edx,(%eax)
 6cc:	eb 0a                	jmp    6d8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d1:	8b 10                	mov    (%eax),%edx
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 40 04             	mov    0x4(%eax),%eax
 6de:	c1 e0 03             	shl    $0x3,%eax
 6e1:	03 45 fc             	add    -0x4(%ebp),%eax
 6e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e7:	75 20                	jne    709 <free+0xc5>
    p->s.size += bp->s.size;
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 50 04             	mov    0x4(%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	01 c2                	add    %eax,%edx
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	8b 10                	mov    (%eax),%edx
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	89 10                	mov    %edx,(%eax)
 707:	eb 08                	jmp    711 <free+0xcd>
  } else
    p->s.ptr = bp;
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70f:	89 10                	mov    %edx,(%eax)
  freep = p;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	a3 c8 10 00 00       	mov    %eax,0x10c8
}
 719:	c9                   	leave  
 71a:	c3                   	ret    

0000071b <morecore>:

static Header*
morecore(uint nu)
{
 71b:	55                   	push   %ebp
 71c:	89 e5                	mov    %esp,%ebp
 71e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 721:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 728:	77 07                	ja     731 <morecore+0x16>
    nu = 4096;
 72a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 731:	8b 45 08             	mov    0x8(%ebp),%eax
 734:	c1 e0 03             	shl    $0x3,%eax
 737:	89 04 24             	mov    %eax,(%esp)
 73a:	e8 29 fc ff ff       	call   368 <sbrk>
 73f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 742:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 746:	75 07                	jne    74f <morecore+0x34>
    return 0;
 748:	b8 00 00 00 00       	mov    $0x0,%eax
 74d:	eb 22                	jmp    771 <morecore+0x56>
  hp = (Header*)p;
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 755:	8b 45 f0             	mov    -0x10(%ebp),%eax
 758:	8b 55 08             	mov    0x8(%ebp),%edx
 75b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 75e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 761:	83 c0 08             	add    $0x8,%eax
 764:	89 04 24             	mov    %eax,(%esp)
 767:	e8 d8 fe ff ff       	call   644 <free>
  return freep;
 76c:	a1 c8 10 00 00       	mov    0x10c8,%eax
}
 771:	c9                   	leave  
 772:	c3                   	ret    

00000773 <malloc>:

void*
malloc(uint nbytes)
{
 773:	55                   	push   %ebp
 774:	89 e5                	mov    %esp,%ebp
 776:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 779:	8b 45 08             	mov    0x8(%ebp),%eax
 77c:	83 c0 07             	add    $0x7,%eax
 77f:	c1 e8 03             	shr    $0x3,%eax
 782:	83 c0 01             	add    $0x1,%eax
 785:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 788:	a1 c8 10 00 00       	mov    0x10c8,%eax
 78d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 790:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 794:	75 23                	jne    7b9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 796:	c7 45 f0 c0 10 00 00 	movl   $0x10c0,-0x10(%ebp)
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	a3 c8 10 00 00       	mov    %eax,0x10c8
 7a5:	a1 c8 10 00 00       	mov    0x10c8,%eax
 7aa:	a3 c0 10 00 00       	mov    %eax,0x10c0
    base.s.size = 0;
 7af:	c7 05 c4 10 00 00 00 	movl   $0x0,0x10c4
 7b6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bc:	8b 00                	mov    (%eax),%eax
 7be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	8b 40 04             	mov    0x4(%eax),%eax
 7c7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ca:	72 4d                	jb     819 <malloc+0xa6>
      if(p->s.size == nunits)
 7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cf:	8b 40 04             	mov    0x4(%eax),%eax
 7d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d5:	75 0c                	jne    7e3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7da:	8b 10                	mov    (%eax),%edx
 7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7df:	89 10                	mov    %edx,(%eax)
 7e1:	eb 26                	jmp    809 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 40 04             	mov    0x4(%eax),%eax
 7e9:	89 c2                	mov    %eax,%edx
 7eb:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	c1 e0 03             	shl    $0x3,%eax
 7fd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	8b 55 ec             	mov    -0x14(%ebp),%edx
 806:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 809:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80c:	a3 c8 10 00 00       	mov    %eax,0x10c8
      return (void*)(p + 1);
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	83 c0 08             	add    $0x8,%eax
 817:	eb 38                	jmp    851 <malloc+0xde>
    }
    if(p == freep)
 819:	a1 c8 10 00 00       	mov    0x10c8,%eax
 81e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 821:	75 1b                	jne    83e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 823:	8b 45 ec             	mov    -0x14(%ebp),%eax
 826:	89 04 24             	mov    %eax,(%esp)
 829:	e8 ed fe ff ff       	call   71b <morecore>
 82e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 831:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 835:	75 07                	jne    83e <malloc+0xcb>
        return 0;
 837:	b8 00 00 00 00       	mov    $0x0,%eax
 83c:	eb 13                	jmp    851 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 841:	89 45 f0             	mov    %eax,-0x10(%ebp)
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	8b 00                	mov    (%eax),%eax
 849:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 84c:	e9 70 ff ff ff       	jmp    7c1 <malloc+0x4e>
}
 851:	c9                   	leave  
 852:	c3                   	ret    
 853:	90                   	nop

00000854 <getNextThread>:
} tTable;


int
getNextThread(int j)
{
 854:	55                   	push   %ebp
 855:	89 e5                	mov    %esp,%ebp
 857:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 85a:	8b 45 08             	mov    0x8(%ebp),%eax
 85d:	83 c0 01             	add    $0x1,%eax
 860:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 863:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 867:	75 07                	jne    870 <getNextThread+0x1c>
    i=0;
 869:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 870:	8b 45 fc             	mov    -0x4(%ebp),%eax
 873:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 879:	05 e0 10 00 00       	add    $0x10e0,%eax
 87e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 881:	eb 3b                	jmp    8be <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 883:	8b 45 f8             	mov    -0x8(%ebp),%eax
 886:	8b 40 10             	mov    0x10(%eax),%eax
 889:	83 f8 03             	cmp    $0x3,%eax
 88c:	75 05                	jne    893 <getNextThread+0x3f>
      return i;
 88e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 891:	eb 38                	jmp    8cb <getNextThread+0x77>
    i++;
 893:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 897:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 89b:	75 1a                	jne    8b7 <getNextThread+0x63>
    {
       i=0;
 89d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
       t=&tTable.table[i];
 8a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a7:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 8ad:	05 e0 10 00 00       	add    $0x10e0,%eax
 8b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
 8b5:	eb 07                	jmp    8be <getNextThread+0x6a>
    }
    else
      t++;
 8b7:	81 45 f8 18 01 00 00 	addl   $0x118,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 8be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c1:	3b 45 08             	cmp    0x8(%ebp),%eax
 8c4:	75 bd                	jne    883 <getNextThread+0x2f>
    }
    else
      t++;
    
  }
  return -1;
 8c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 8cb:	c9                   	leave  
 8cc:	c3                   	ret    

000008cd <allocThread>:


static uthread_p
allocThread()
{
 8cd:	55                   	push   %ebp
 8ce:	89 e5                	mov    %esp,%ebp
 8d0:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 8d3:	c7 45 ec e0 10 00 00 	movl   $0x10e0,-0x14(%ebp)
 8da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 8e1:	eb 15                	jmp    8f8 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 8e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8e6:	8b 40 10             	mov    0x10(%eax),%eax
 8e9:	85 c0                	test   %eax,%eax
 8eb:	74 1e                	je     90b <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
 8ed:	81 45 ec 18 01 00 00 	addl   $0x118,-0x14(%ebp)
 8f4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 8f8:	81 7d ec e0 56 00 00 	cmpl   $0x56e0,-0x14(%ebp)
 8ff:	76 e2                	jbe    8e3 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 901:	b8 00 00 00 00       	mov    $0x0,%eax
 906:	e9 88 00 00 00       	jmp    993 <allocThread+0xc6>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)// <= should be < ??
  {
    if(t->state==T_FREE)
      goto found;
 90b:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 90c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 90f:	8b 55 f4             	mov    -0xc(%ebp),%edx
 912:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 914:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 91b:	e8 53 fe ff ff       	call   773 <malloc>
 920:	8b 55 ec             	mov    -0x14(%ebp),%edx
 923:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 926:	8b 45 ec             	mov    -0x14(%ebp),%eax
 929:	8b 40 0c             	mov    0xc(%eax),%eax
 92c:	89 c2                	mov    %eax,%edx
 92e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 931:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 934:	8b 45 ec             	mov    -0x14(%ebp),%eax
 937:	8b 40 0c             	mov    0xc(%eax),%eax
 93a:	89 c2                	mov    %eax,%edx
 93c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 93f:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 942:	8b 45 ec             	mov    -0x14(%ebp),%eax
 945:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(j=0;j<64;j++)
 94c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 953:	eb 15                	jmp    96a <allocThread+0x9d>
  {
    t->waiting[j]=-1;
 955:	8b 45 ec             	mov    -0x14(%ebp),%eax
 958:	8b 55 f0             	mov    -0x10(%ebp),%edx
 95b:	83 c2 04             	add    $0x4,%edx
 95e:	c7 44 90 08 ff ff ff 	movl   $0xffffffff,0x8(%eax,%edx,4)
 965:	ff 
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  for(j=0;j<64;j++)
 966:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 96a:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 96e:	7e e5                	jle    955 <allocThread+0x88>
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 970:	8b 45 ec             	mov    -0x14(%ebp),%eax
 973:	8b 40 08             	mov    0x8(%eax),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 976:	ba 92 0a 00 00       	mov    $0xa92,%edx
 97b:	89 c4                	mov    %eax,%esp
 97d:	52                   	push   %edx
 97e:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 980:	8b 45 ec             	mov    -0x14(%ebp),%eax
  t->firstTime=0;
  for(j=0;j<64;j++)
  {
    t->waiting[j]=-1;
  }
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 983:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 986:	8b 45 ec             	mov    -0x14(%ebp),%eax
 989:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 990:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 993:	c9                   	leave  
 994:	c3                   	ret    

00000995 <uthread_init>:

void 
uthread_init()
{  
 995:	55                   	push   %ebp
 996:	89 e5                	mov    %esp,%ebp
 998:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 99b:	c7 05 e0 56 00 00 00 	movl   $0x0,0x56e0
 9a2:	00 00 00 
  tTable.current=0;
 9a5:	c7 05 e4 56 00 00 00 	movl   $0x0,0x56e4
 9ac:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 9af:	e8 19 ff ff ff       	call   8cd <allocThread>
 9b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 9b7:	89 e9                	mov    %ebp,%ecx
 9b9:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 9bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 9be:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 9c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 9c4:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 9c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ca:	8b 50 08             	mov    0x8(%eax),%edx
 9cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d0:	8b 40 04             	mov    0x4(%eax),%eax
 9d3:	89 d1                	mov    %edx,%ecx
 9d5:	29 c1                	sub    %eax,%ecx
 9d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9da:	8b 40 04             	mov    0x4(%eax),%eax
 9dd:	89 c2                	mov    %eax,%edx
 9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e2:	8b 40 0c             	mov    0xc(%eax),%eax
 9e5:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 9e9:	89 54 24 04          	mov    %edx,0x4(%esp)
 9ed:	89 04 24             	mov    %eax,(%esp)
 9f0:	e8 a5 f8 ff ff       	call   29a <memmove>
  mainT->state = T_RUNNABLE;
 9f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f8:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  currentThread=mainT;
 9ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a02:	a3 e8 56 00 00       	mov    %eax,0x56e8
  if(signal(SIGALRM,uthread_yield)<0)
 a07:	c7 44 24 04 02 0c 00 	movl   $0xc02,0x4(%esp)
 a0e:	00 
 a0f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a16:	e8 85 f9 ff ff       	call   3a0 <signal>
 a1b:	85 c0                	test   %eax,%eax
 a1d:	79 19                	jns    a38 <uthread_init+0xa3>
  {
    printf(1,"Cant register the alarm signal");
 a1f:	c7 44 24 04 e8 0c 00 	movl   $0xce8,0x4(%esp)
 a26:	00 
 a27:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a2e:	e8 5c fa ff ff       	call   48f <printf>
    exit();
 a33:	e8 a8 f8 ff ff       	call   2e0 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 a38:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 a3f:	e8 6c f9 ff ff       	call   3b0 <alarm>
 a44:	85 c0                	test   %eax,%eax
 a46:	79 19                	jns    a61 <uthread_init+0xcc>
  {
    printf(1,"Cant activate alarm system call");
 a48:	c7 44 24 04 08 0d 00 	movl   $0xd08,0x4(%esp)
 a4f:	00 
 a50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a57:	e8 33 fa ff ff       	call   48f <printf>
    exit();
 a5c:	e8 7f f8 ff ff       	call   2e0 <exit>
  }
  
}
 a61:	c9                   	leave  
 a62:	c3                   	ret    

00000a63 <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 a63:	55                   	push   %ebp
 a64:	89 e5                	mov    %esp,%ebp
 a66:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 a69:	e8 5f fe ff ff       	call   8cd <allocThread>
 a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 a71:	8b 45 0c             	mov    0xc(%ebp),%eax
 a74:	8b 55 08             	mov    0x8(%ebp),%edx
 a77:	50                   	push   %eax
 a78:	52                   	push   %edx
 a79:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 a7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 a7e:	89 50 04             	mov    %edx,0x4(%eax)
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  t->state= T_RUNNABLE;
 a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a84:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 a8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8e:	8b 00                	mov    (%eax),%eax
}
 a90:	c9                   	leave  
 a91:	c3                   	ret    

00000a92 <uthread_exit>:

void 
uthread_exit()
{
 a92:	55                   	push   %ebp
 a93:	89 e5                	mov    %esp,%ebp
 a95:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 a98:	a1 e8 56 00 00       	mov    0x56e8,%eax
 a9d:	8b 00                	mov    (%eax),%eax
 a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  int i=0;
 aa2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while(currentThread->waiting[i]!=-1)
 aa9:	eb 25                	jmp    ad0 <uthread_exit+0x3e>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
 aab:	a1 e8 56 00 00       	mov    0x56e8,%eax
 ab0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ab3:	83 c2 04             	add    $0x4,%edx
 ab6:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 aba:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 ac0:	05 e0 10 00 00       	add    $0x10e0,%eax
 ac5:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    i++;
 acc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  uthread_p newt;
  int old=currentThread->tid;
  
  int i=0;
  while(currentThread->waiting[i]!=-1)
 ad0:	a1 e8 56 00 00       	mov    0x56e8,%eax
 ad5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ad8:	83 c2 04             	add    $0x4,%edx
 adb:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 adf:	83 f8 ff             	cmp    $0xffffffff,%eax
 ae2:	75 c7                	jne    aab <uthread_exit+0x19>
  {
    (&tTable.table[currentThread->waiting[i]])->state=T_RUNNABLE;
    i++;
  }
  currentThread->tid=-1;
 ae4:	a1 e8 56 00 00       	mov    0x56e8,%eax
 ae9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 aef:	a1 e8 56 00 00       	mov    0x56e8,%eax
 af4:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 afb:	a1 e8 56 00 00       	mov    0x56e8,%eax
 b00:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  free(currentThread->stack);
 b07:	a1 e8 56 00 00       	mov    0x56e8,%eax
 b0c:	8b 40 0c             	mov    0xc(%eax),%eax
 b0f:	89 04 24             	mov    %eax,(%esp)
 b12:	e8 2d fb ff ff       	call   644 <free>
  currentThread->state=T_FREE;
 b17:	a1 e8 56 00 00       	mov    0x56e8,%eax
 b1c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  currentThread->firstTime=0;
 b23:	a1 e8 56 00 00       	mov    0x56e8,%eax
 b28:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  int new=getNextThread(old);
 b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b32:	89 04 24             	mov    %eax,(%esp)
 b35:	e8 1a fd ff ff       	call   854 <getNextThread>
 b3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(new>=0)
 b3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 b41:	78 36                	js     b79 <uthread_exit+0xe7>
          {
             newt=&tTable.table[new];
 b43:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b46:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b4c:	05 e0 10 00 00       	add    $0x10e0,%eax
 b51:	89 45 e8             	mov    %eax,-0x18(%ebp)
             newt->state=T_RUNNING;
 b54:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b57:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
             LOAD_ESP(newt->esp);
 b5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b61:	8b 40 04             	mov    0x4(%eax),%eax
 b64:	89 c4                	mov    %eax,%esp
             LOAD_EBP(newt->ebp);
 b66:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b69:	8b 40 08             	mov    0x8(%eax),%eax
 b6c:	89 c5                	mov    %eax,%ebp
             asm("popa");
 b6e:	61                   	popa   
             currentThread=newt;
 b6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 b72:	a3 e8 56 00 00       	mov    %eax,0x56e8
        {/////what if some thread state is sleeping?
             
             exit();
        }
     
}
 b77:	c9                   	leave  
 b78:	c3                   	ret    
             currentThread=newt;
          }
        else
        {/////what if some thread state is sleeping?
             
             exit();
 b79:	e8 62 f7 ff ff       	call   2e0 <exit>

00000b7e <uthred_join>:
}


int
uthred_join(int tid)
{
 b7e:	55                   	push   %ebp
 b7f:	89 e5                	mov    %esp,%ebp
 b81:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 b84:	8b 45 08             	mov    0x8(%ebp),%eax
 b87:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 b8d:	05 e0 10 00 00       	add    $0x10e0,%eax
 b92:	8b 40 10             	mov    0x10(%eax),%eax
 b95:	85 c0                	test   %eax,%eax
 b97:	75 07                	jne    ba0 <uthred_join+0x22>
    return -1;
 b99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b9e:	eb 60                	jmp    c00 <uthred_join+0x82>
  else
  {
      int i=0;
 ba0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      while((&tTable.table[tid])->waiting[i]!=-1)
 ba7:	eb 04                	jmp    bad <uthred_join+0x2f>
        i++;
 ba9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  if((&tTable.table[tid])->state==T_FREE)
    return -1;
  else
  {
      int i=0;
      while((&tTable.table[tid])->waiting[i]!=-1)
 bad:	8b 45 08             	mov    0x8(%ebp),%eax
 bb0:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bb6:	05 e0 10 00 00       	add    $0x10e0,%eax
 bbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bbe:	83 c2 04             	add    $0x4,%edx
 bc1:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
 bc5:	83 f8 ff             	cmp    $0xffffffff,%eax
 bc8:	75 df                	jne    ba9 <uthred_join+0x2b>
        i++;
      (&tTable.table[tid])->waiting[i]=currentThread->tid;
 bca:	8b 45 08             	mov    0x8(%ebp),%eax
 bcd:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 bd3:	8d 90 e0 10 00 00    	lea    0x10e0(%eax),%edx
 bd9:	a1 e8 56 00 00       	mov    0x56e8,%eax
 bde:	8b 00                	mov    (%eax),%eax
 be0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 be3:	83 c1 04             	add    $0x4,%ecx
 be6:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
      currentThread->state=T_SLEEPING;
 bea:	a1 e8 56 00 00       	mov    0x56e8,%eax
 bef:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      uthread_yield();
 bf6:	e8 07 00 00 00       	call   c02 <uthread_yield>
      return 1;
 bfb:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 c00:	c9                   	leave  
 c01:	c3                   	ret    

00000c02 <uthread_yield>:

void 
uthread_yield()
{
 c02:	55                   	push   %ebp
 c03:	89 e5                	mov    %esp,%ebp
 c05:	83 ec 28             	sub    $0x28,%esp
  uthread_p newt;
  int old=currentThread->tid;
 c08:	a1 e8 56 00 00       	mov    0x56e8,%eax
 c0d:	8b 00                	mov    (%eax),%eax
 c0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread(old);
 c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c15:	89 04 24             	mov    %eax,(%esp)
 c18:	e8 37 fc ff ff       	call   854 <getNextThread>
 c1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(new<0)
 c20:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c24:	79 19                	jns    c3f <uthread_yield+0x3d>
  {
     printf(1,"(fun uthread_yield)Cant find runnable thread");
 c26:	c7 44 24 04 28 0d 00 	movl   $0xd28,0x4(%esp)
 c2d:	00 
 c2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 c35:	e8 55 f8 ff ff       	call   48f <printf>
    exit();
 c3a:	e8 a1 f6 ff ff       	call   2e0 <exit>
  }
newt=&tTable.table[new];
 c3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c42:	69 c0 18 01 00 00    	imul   $0x118,%eax,%eax
 c48:	05 e0 10 00 00       	add    $0x10e0,%eax
 c4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  
    asm("pusha");
 c50:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 c51:	a1 e8 56 00 00       	mov    0x56e8,%eax
 c56:	89 e2                	mov    %esp,%edx
 c58:	89 50 04             	mov    %edx,0x4(%eax)
    if(currentThread->state==T_RUNNING)
 c5b:	a1 e8 56 00 00       	mov    0x56e8,%eax
 c60:	8b 40 10             	mov    0x10(%eax),%eax
 c63:	83 f8 02             	cmp    $0x2,%eax
 c66:	75 0c                	jne    c74 <uthread_yield+0x72>
      currentThread->state=T_RUNNABLE;
 c68:	a1 e8 56 00 00       	mov    0x56e8,%eax
 c6d:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 c74:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c77:	8b 40 04             	mov    0x4(%eax),%eax
 c7a:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 c7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c7f:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 c86:	61                   	popa   
    if(currentThread->firstTime==0)
 c87:	a1 e8 56 00 00       	mov    0x56e8,%eax
 c8c:	8b 40 14             	mov    0x14(%eax),%eax
 c8f:	85 c0                	test   %eax,%eax
 c91:	75 0d                	jne    ca0 <uthread_yield+0x9e>
    {
       asm("ret");////only firest time
 c93:	c3                   	ret    
       currentThread->firstTime=1;
 c94:	a1 e8 56 00 00       	mov    0x56e8,%eax
 c99:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   
currentThread=newt;
 ca0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ca3:	a3 e8 56 00 00       	mov    %eax,0x56e8

}
 ca8:	c9                   	leave  
 ca9:	c3                   	ret    

00000caa <uthred_self>:

int  uthred_self(void)
{
 caa:	55                   	push   %ebp
 cab:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 cad:	a1 e8 56 00 00       	mov    0x56e8,%eax
 cb2:	8b 00                	mov    (%eax),%eax
}
 cb4:	5d                   	pop    %ebp
 cb5:	c3                   	ret    
