
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
   f:	c7 44 24 04 a8 0f 00 	movl   $0xfa8,0x4(%esp)
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
  60:	c7 44 24 04 bb 0f 00 	movl   $0xfbb,0x4(%esp)
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
 426:	0f b6 90 c8 14 00 00 	movzbl 0x14c8(%eax),%edx
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
 587:	c7 45 f4 cf 0f 00 00 	movl   $0xfcf,-0xc(%ebp)
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
 653:	a1 e8 14 00 00       	mov    0x14e8,%eax
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
 714:	a3 e8 14 00 00       	mov    %eax,0x14e8
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
 76c:	a1 e8 14 00 00       	mov    0x14e8,%eax
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
 788:	a1 e8 14 00 00       	mov    0x14e8,%eax
 78d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 790:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 794:	75 23                	jne    7b9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 796:	c7 45 f0 e0 14 00 00 	movl   $0x14e0,-0x10(%ebp)
 79d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a0:	a3 e8 14 00 00       	mov    %eax,0x14e8
 7a5:	a1 e8 14 00 00       	mov    0x14e8,%eax
 7aa:	a3 e0 14 00 00       	mov    %eax,0x14e0
    base.s.size = 0;
 7af:	c7 05 e4 14 00 00 00 	movl   $0x0,0x14e4
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
 80c:	a3 e8 14 00 00       	mov    %eax,0x14e8
      return (void*)(p + 1);
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	83 c0 08             	add    $0x8,%eax
 817:	eb 38                	jmp    851 <malloc+0xde>
    }
    if(p == freep)
 819:	a1 e8 14 00 00       	mov    0x14e8,%eax
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

00000854 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
 854:	55                   	push   %ebp
 855:	89 e5                	mov    %esp,%ebp
 857:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
 85a:	a1 00 5e 00 00       	mov    0x5e00,%eax
 85f:	8b 40 04             	mov    0x4(%eax),%eax
 862:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
 865:	a1 00 5e 00 00       	mov    0x5e00,%eax
 86a:	8b 00                	mov    (%eax),%eax
 86c:	89 44 24 08          	mov    %eax,0x8(%esp)
 870:	c7 44 24 04 d8 0f 00 	movl   $0xfd8,0x4(%esp)
 877:	00 
 878:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 87f:	e8 0b fc ff ff       	call   48f <printf>
  while((newesp < (int *)currentThread->ebp))
 884:	eb 3c                	jmp    8c2 <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
 886:	8b 45 f4             	mov    -0xc(%ebp),%eax
 889:	89 44 24 08          	mov    %eax,0x8(%esp)
 88d:	c7 44 24 04 ee 0f 00 	movl   $0xfee,0x4(%esp)
 894:	00 
 895:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 89c:	e8 ee fb ff ff       	call   48f <printf>
      printf(1,"val:%x\n",*newesp);
 8a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a4:	8b 00                	mov    (%eax),%eax
 8a6:	89 44 24 08          	mov    %eax,0x8(%esp)
 8aa:	c7 44 24 04 f6 0f 00 	movl   $0xff6,0x4(%esp)
 8b1:	00 
 8b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8b9:	e8 d1 fb ff ff       	call   48f <printf>
    newesp++;
 8be:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
 8c2:	a1 00 5e 00 00       	mov    0x5e00,%eax
 8c7:	8b 40 08             	mov    0x8(%eax),%eax
 8ca:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 8cd:	77 b7                	ja     886 <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
 8cf:	c9                   	leave  
 8d0:	c3                   	ret    

000008d1 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
 8d1:	55                   	push   %ebp
 8d2:	89 e5                	mov    %esp,%ebp
 8d4:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 8d7:	8b 45 08             	mov    0x8(%ebp),%eax
 8da:	83 c0 01             	add    $0x1,%eax
 8dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 8e0:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8e4:	75 07                	jne    8ed <getNextThread+0x1c>
    i=0;
 8e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 8ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f0:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 8f6:	05 00 15 00 00       	add    $0x1500,%eax
 8fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 8fe:	eb 3b                	jmp    93b <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 900:	8b 45 f8             	mov    -0x8(%ebp),%eax
 903:	8b 40 10             	mov    0x10(%eax),%eax
 906:	83 f8 03             	cmp    $0x3,%eax
 909:	75 05                	jne    910 <getNextThread+0x3f>
      return i;
 90b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90e:	eb 38                	jmp    948 <getNextThread+0x77>
    i++;
 910:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 914:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 918:	75 1a                	jne    934 <getNextThread+0x63>
    {
     i=0;
 91a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
 921:	8b 45 fc             	mov    -0x4(%ebp),%eax
 924:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 92a:	05 00 15 00 00       	add    $0x1500,%eax
 92f:	89 45 f8             	mov    %eax,-0x8(%ebp)
 932:	eb 07                	jmp    93b <getNextThread+0x6a>
   }
   else
    t++;
 934:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 93b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93e:	3b 45 08             	cmp    0x8(%ebp),%eax
 941:	75 bd                	jne    900 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
 943:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 948:	c9                   	leave  
 949:	c3                   	ret    

0000094a <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
 94a:	55                   	push   %ebp
 94b:	89 e5                	mov    %esp,%ebp
 94d:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 950:	c7 45 ec 00 15 00 00 	movl   $0x1500,-0x14(%ebp)
 957:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 95e:	eb 15                	jmp    975 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 960:	8b 45 ec             	mov    -0x14(%ebp),%eax
 963:	8b 40 10             	mov    0x10(%eax),%eax
 966:	85 c0                	test   %eax,%eax
 968:	74 1e                	je     988 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 96a:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
 971:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 975:	81 7d ec 00 5e 00 00 	cmpl   $0x5e00,-0x14(%ebp)
 97c:	72 e2                	jb     960 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 97e:	b8 00 00 00 00       	mov    $0x0,%eax
 983:	e9 a3 00 00 00       	jmp    a2b <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
 988:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
 989:	8b 45 ec             	mov    -0x14(%ebp),%eax
 98c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 98f:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
 991:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 995:	75 1c                	jne    9b3 <allocThread+0x69>
  {
    STORE_ESP(t->esp);
 997:	89 e2                	mov    %esp,%edx
 999:	8b 45 ec             	mov    -0x14(%ebp),%eax
 99c:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
 99f:	89 ea                	mov    %ebp,%edx
 9a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9a4:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
 9a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9aa:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
 9b1:	eb 3b                	jmp    9ee <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
 9b3:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9ba:	e8 b4 fd ff ff       	call   773 <malloc>
 9bf:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9c2:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
 9c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9c8:	8b 40 0c             	mov    0xc(%eax),%eax
 9cb:	05 00 10 00 00       	add    $0x1000,%eax
 9d0:	89 c2                	mov    %eax,%edx
 9d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d5:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
 9d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9db:	8b 50 08             	mov    0x8(%eax),%edx
 9de:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9e1:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
 9e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9e7:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
 9ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9f1:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
 9f8:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
 9fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 a02:	eb 14                	jmp    a18 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
 a04:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a07:	8b 55 f0             	mov    -0x10(%ebp),%edx
 a0a:	83 c2 08             	add    $0x8,%edx
 a0d:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
 a14:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 a18:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 a1c:	7e e6                	jle    a04 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
 a1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a21:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
 a28:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 a2b:	c9                   	leave  
 a2c:	c3                   	ret    

00000a2d <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
 a2d:	55                   	push   %ebp
 a2e:	89 e5                	mov    %esp,%ebp
 a30:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 a33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a3a:	eb 18                	jmp    a54 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
 a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3f:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 a45:	05 10 15 00 00       	add    $0x1510,%eax
 a4a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 a50:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a54:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 a58:	7e e2                	jle    a3c <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
 a5a:	e8 eb fe ff ff       	call   94a <allocThread>
 a5f:	a3 00 5e 00 00       	mov    %eax,0x5e00
  if(currentThread==0)
 a64:	a1 00 5e 00 00       	mov    0x5e00,%eax
 a69:	85 c0                	test   %eax,%eax
 a6b:	75 07                	jne    a74 <uthread_init+0x47>
    return -1;
 a6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a72:	eb 6b                	jmp    adf <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
 a74:	a1 00 5e 00 00       	mov    0x5e00,%eax
 a79:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
 a80:	c7 44 24 04 67 0d 00 	movl   $0xd67,0x4(%esp)
 a87:	00 
 a88:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a8f:	e8 0c f9 ff ff       	call   3a0 <signal>
 a94:	85 c0                	test   %eax,%eax
 a96:	79 19                	jns    ab1 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
 a98:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 a9f:	00 
 aa0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 aa7:	e8 e3 f9 ff ff       	call   48f <printf>
    exit();
 aac:	e8 2f f8 ff ff       	call   2e0 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
 ab1:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 ab8:	e8 f3 f8 ff ff       	call   3b0 <alarm>
 abd:	85 c0                	test   %eax,%eax
 abf:	79 19                	jns    ada <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
 ac1:	c7 44 24 04 20 10 00 	movl   $0x1020,0x4(%esp)
 ac8:	00 
 ac9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ad0:	e8 ba f9 ff ff       	call   48f <printf>
    exit();
 ad5:	e8 06 f8 ff ff       	call   2e0 <exit>
  }
  return 0;
 ada:	b8 00 00 00 00       	mov    $0x0,%eax
}
 adf:	c9                   	leave  
 ae0:	c3                   	ret    

00000ae1 <wrap_func>:

void
wrap_func()
{
 ae1:	55                   	push   %ebp
 ae2:	89 e5                	mov    %esp,%ebp
 ae4:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
 ae7:	a1 00 5e 00 00       	mov    0x5e00,%eax
 aec:	8b 50 18             	mov    0x18(%eax),%edx
 aef:	a1 00 5e 00 00       	mov    0x5e00,%eax
 af4:	8b 40 1c             	mov    0x1c(%eax),%eax
 af7:	89 04 24             	mov    %eax,(%esp)
 afa:	ff d2                	call   *%edx
  uthread_exit();
 afc:	e8 6c 00 00 00       	call   b6d <uthread_exit>
}
 b01:	c9                   	leave  
 b02:	c3                   	ret    

00000b03 <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
 b03:	55                   	push   %ebp
 b04:	89 e5                	mov    %esp,%ebp
 b06:	53                   	push   %ebx
 b07:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
 b0a:	e8 3b fe ff ff       	call   94a <allocThread>
 b0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
 b12:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b16:	75 07                	jne    b1f <uthread_create+0x1c>
    return -1;
 b18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b1d:	eb 48                	jmp    b67 <uthread_create+0x64>

  t->func=start_func;
 b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b22:	8b 55 08             	mov    0x8(%ebp),%edx
 b25:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
 b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2b:	8b 55 0c             	mov    0xc(%ebp),%edx
 b2e:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
 b31:	89 e3                	mov    %esp,%ebx
 b33:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
 b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b39:	8b 40 04             	mov    0x4(%eax),%eax
 b3c:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
 b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b41:	8b 50 08             	mov    0x8(%eax),%edx
 b44:	b8 e1 0a 00 00       	mov    $0xae1,%eax
 b49:	50                   	push   %eax
 b4a:	52                   	push   %edx
 b4b:	89 e2                	mov    %esp,%edx
 b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b50:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
 b53:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b56:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
 b58:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b5b:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 b62:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b65:	8b 00                	mov    (%eax),%eax
}
 b67:	83 c4 14             	add    $0x14,%esp
 b6a:	5b                   	pop    %ebx
 b6b:	5d                   	pop    %ebp
 b6c:	c3                   	ret    

00000b6d <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
 b6d:	55                   	push   %ebp
 b6e:	89 e5                	mov    %esp,%ebp
 b70:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 b73:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 b7a:	e8 31 f8 ff ff       	call   3b0 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 b7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 b86:	eb 51                	jmp    bd9 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
 b88:	a1 00 5e 00 00       	mov    0x5e00,%eax
 b8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b90:	83 c2 08             	add    $0x8,%edx
 b93:	8b 04 90             	mov    (%eax,%edx,4),%eax
 b96:	83 f8 01             	cmp    $0x1,%eax
 b99:	75 3a                	jne    bd5 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
 b9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b9e:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 ba4:	05 20 16 00 00       	add    $0x1620,%eax
 ba9:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
 baf:	a1 00 5e 00 00       	mov    0x5e00,%eax
 bb4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bb7:	83 c2 08             	add    $0x8,%edx
 bba:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
 bc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bc4:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 bca:	05 10 15 00 00       	add    $0x1510,%eax
 bcf:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 bd5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 bd9:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 bdd:	7e a9                	jle    b88 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
 bdf:	a1 00 5e 00 00       	mov    0x5e00,%eax
 be4:	8b 00                	mov    (%eax),%eax
 be6:	89 04 24             	mov    %eax,(%esp)
 be9:	e8 e3 fc ff ff       	call   8d1 <getNextThread>
 bee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
 bf1:	a1 00 5e 00 00       	mov    0x5e00,%eax
 bf6:	8b 00                	mov    (%eax),%eax
 bf8:	85 c0                	test   %eax,%eax
 bfa:	74 10                	je     c0c <uthread_exit+0x9f>
    free(currentThread->stack);
 bfc:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c01:	8b 40 0c             	mov    0xc(%eax),%eax
 c04:	89 04 24             	mov    %eax,(%esp)
 c07:	e8 38 fa ff ff       	call   644 <free>
  currentThread->tid=-1;
 c0c:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c11:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 c17:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c1c:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 c23:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c28:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
 c2f:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c34:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
 c3b:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c40:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
 c47:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c4c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
 c53:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c58:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
 c5f:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c64:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
 c6b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c6f:	78 7a                	js     ceb <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
 c71:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c74:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 c7a:	05 00 15 00 00       	add    $0x1500,%eax
 c7f:	a3 00 5e 00 00       	mov    %eax,0x5e00
    currentThread->state=T_RUNNING;
 c84:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c89:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
 c90:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c95:	8b 40 04             	mov    0x4(%eax),%eax
 c98:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 c9a:	a1 00 5e 00 00       	mov    0x5e00,%eax
 c9f:	8b 40 08             	mov    0x8(%eax),%eax
 ca2:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
 ca4:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 cab:	e8 00 f7 ff ff       	call   3b0 <alarm>
 cb0:	85 c0                	test   %eax,%eax
 cb2:	79 19                	jns    ccd <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
 cb4:	c7 44 24 04 20 10 00 	movl   $0x1020,0x4(%esp)
 cbb:	00 
 cbc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 cc3:	e8 c7 f7 ff ff       	call   48f <printf>
      exit();
 cc8:	e8 13 f6 ff ff       	call   2e0 <exit>
    }
    
    if(currentThread->firstTime==1)
 ccd:	a1 00 5e 00 00       	mov    0x5e00,%eax
 cd2:	8b 40 14             	mov    0x14(%eax),%eax
 cd5:	83 f8 01             	cmp    $0x1,%eax
 cd8:	75 10                	jne    cea <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
 cda:	a1 00 5e 00 00       	mov    0x5e00,%eax
 cdf:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
 ce6:	5d                   	pop    %ebp
 ce7:	c3                   	ret    
 ce8:	eb 01                	jmp    ceb <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
 cea:	61                   	popa   
    }
  }
}
 ceb:	c9                   	leave  
 cec:	c3                   	ret    

00000ced <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
 ced:	55                   	push   %ebp
 cee:	89 e5                	mov    %esp,%ebp
 cf0:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 cf3:	8b 45 08             	mov    0x8(%ebp),%eax
 cf6:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 cfc:	05 00 15 00 00       	add    $0x1500,%eax
 d01:	8b 40 10             	mov    0x10(%eax),%eax
 d04:	85 c0                	test   %eax,%eax
 d06:	75 07                	jne    d0f <uthread_join+0x22>
    return -1;
 d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d0d:	eb 56                	jmp    d65 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
 d0f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d16:	e8 95 f6 ff ff       	call   3b0 <alarm>
    currentThread->waitingFor=tid;
 d1b:	a1 00 5e 00 00       	mov    0x5e00,%eax
 d20:	8b 55 08             	mov    0x8(%ebp),%edx
 d23:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
 d29:	a1 00 5e 00 00       	mov    0x5e00,%eax
 d2e:	8b 08                	mov    (%eax),%ecx
 d30:	8b 55 08             	mov    0x8(%ebp),%edx
 d33:	89 d0                	mov    %edx,%eax
 d35:	c1 e0 03             	shl    $0x3,%eax
 d38:	01 d0                	add    %edx,%eax
 d3a:	c1 e0 03             	shl    $0x3,%eax
 d3d:	01 d0                	add    %edx,%eax
 d3f:	01 c8                	add    %ecx,%eax
 d41:	83 c0 08             	add    $0x8,%eax
 d44:	c7 04 85 00 15 00 00 	movl   $0x1,0x1500(,%eax,4)
 d4b:	01 00 00 00 
    currentThread->state=T_SLEEPING;
 d4f:	a1 00 5e 00 00       	mov    0x5e00,%eax
 d54:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
 d5b:	e8 07 00 00 00       	call   d67 <uthread_yield>
    return 1;
 d60:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d65:	c9                   	leave  
 d66:	c3                   	ret    

00000d67 <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
 d67:	55                   	push   %ebp
 d68:	89 e5                	mov    %esp,%ebp
 d6a:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 d6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d74:	e8 37 f6 ff ff       	call   3b0 <alarm>
  int new=getNextThread(currentThread->tid);
 d79:	a1 00 5e 00 00       	mov    0x5e00,%eax
 d7e:	8b 00                	mov    (%eax),%eax
 d80:	89 04 24             	mov    %eax,(%esp)
 d83:	e8 49 fb ff ff       	call   8d1 <getNextThread>
 d88:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
 d8b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 d8f:	75 2d                	jne    dbe <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
 d91:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 d98:	e8 13 f6 ff ff       	call   3b0 <alarm>
 d9d:	85 c0                	test   %eax,%eax
 d9f:	0f 89 c1 00 00 00    	jns    e66 <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
 da5:	c7 44 24 04 40 10 00 	movl   $0x1040,0x4(%esp)
 dac:	00 
 dad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 db4:	e8 d6 f6 ff ff       	call   48f <printf>
      exit();
 db9:	e8 22 f5 ff ff       	call   2e0 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
 dbe:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 dbf:	a1 00 5e 00 00       	mov    0x5e00,%eax
 dc4:	89 e2                	mov    %esp,%edx
 dc6:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
 dc9:	a1 00 5e 00 00       	mov    0x5e00,%eax
 dce:	89 ea                	mov    %ebp,%edx
 dd0:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
 dd3:	a1 00 5e 00 00       	mov    0x5e00,%eax
 dd8:	8b 40 10             	mov    0x10(%eax),%eax
 ddb:	83 f8 02             	cmp    $0x2,%eax
 dde:	75 0c                	jne    dec <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
 de0:	a1 00 5e 00 00       	mov    0x5e00,%eax
 de5:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
 dec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 def:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 df5:	05 00 15 00 00       	add    $0x1500,%eax
 dfa:	a3 00 5e 00 00       	mov    %eax,0x5e00

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
 dff:	a1 00 5e 00 00       	mov    0x5e00,%eax
 e04:	8b 40 04             	mov    0x4(%eax),%eax
 e07:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 e09:	a1 00 5e 00 00       	mov    0x5e00,%eax
 e0e:	8b 40 08             	mov    0x8(%eax),%eax
 e11:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
 e13:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 e1a:	e8 91 f5 ff ff       	call   3b0 <alarm>
 e1f:	85 c0                	test   %eax,%eax
 e21:	79 19                	jns    e3c <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
 e23:	c7 44 24 04 40 10 00 	movl   $0x1040,0x4(%esp)
 e2a:	00 
 e2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 e32:	e8 58 f6 ff ff       	call   48f <printf>
      exit();
 e37:	e8 a4 f4 ff ff       	call   2e0 <exit>
    }  
    currentThread->state=T_RUNNING;
 e3c:	a1 00 5e 00 00       	mov    0x5e00,%eax
 e41:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
 e48:	a1 00 5e 00 00       	mov    0x5e00,%eax
 e4d:	8b 40 14             	mov    0x14(%eax),%eax
 e50:	83 f8 01             	cmp    $0x1,%eax
 e53:	75 10                	jne    e65 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
 e55:	a1 00 5e 00 00       	mov    0x5e00,%eax
 e5a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
 e61:	5d                   	pop    %ebp
 e62:	c3                   	ret    
 e63:	eb 01                	jmp    e66 <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
 e65:	61                   	popa   
    }
  }
}
 e66:	c9                   	leave  
 e67:	c3                   	ret    

00000e68 <uthread_self>:

int
uthread_self(void)
{
 e68:	55                   	push   %ebp
 e69:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 e6b:	a1 00 5e 00 00       	mov    0x5e00,%eax
 e70:	8b 00                	mov    (%eax),%eax
 e72:	5d                   	pop    %ebp
 e73:	c3                   	ret    

00000e74 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
 e74:	55                   	push   %ebp
 e75:	89 e5                	mov    %esp,%ebp
 e77:	53                   	push   %ebx
 e78:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
 e7b:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e7e:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
 e81:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e84:	89 c3                	mov    %eax,%ebx
 e86:	89 d8                	mov    %ebx,%eax
 e88:	f0 87 02             	lock xchg %eax,(%edx)
 e8b:	89 c3                	mov    %eax,%ebx
 e8d:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 e90:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
 e93:	83 c4 10             	add    $0x10,%esp
 e96:	5b                   	pop    %ebx
 e97:	5d                   	pop    %ebp
 e98:	c3                   	ret    

00000e99 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
 e99:	55                   	push   %ebp
 e9a:	89 e5                	mov    %esp,%ebp
 e9c:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
 e9f:	8b 45 08             	mov    0x8(%ebp),%eax
 ea2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
 ea9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 ead:	74 0c                	je     ebb <binary_semaphore_init+0x22>
    semaphore->thread=-1;
 eaf:	8b 45 08             	mov    0x8(%ebp),%eax
 eb2:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
 eb9:	eb 0b                	jmp    ec6 <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
 ebb:	e8 a8 ff ff ff       	call   e68 <uthread_self>
 ec0:	8b 55 08             	mov    0x8(%ebp),%edx
 ec3:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
 ec6:	8b 55 0c             	mov    0xc(%ebp),%edx
 ec9:	8b 45 08             	mov    0x8(%ebp),%eax
 ecc:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
 ece:	8b 45 08             	mov    0x8(%ebp),%eax
 ed1:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
 ed8:	c9                   	leave  
 ed9:	c3                   	ret    

00000eda <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
 eda:	55                   	push   %ebp
 edb:	89 e5                	mov    %esp,%ebp
 edd:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
 ee0:	8b 45 08             	mov    0x8(%ebp),%eax
 ee3:	8b 40 08             	mov    0x8(%eax),%eax
 ee6:	85 c0                	test   %eax,%eax
 ee8:	75 20                	jne    f0a <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 eea:	8b 45 08             	mov    0x8(%ebp),%eax
 eed:	8b 40 04             	mov    0x4(%eax),%eax
 ef0:	89 44 24 08          	mov    %eax,0x8(%esp)
 ef4:	c7 44 24 04 64 10 00 	movl   $0x1064,0x4(%esp)
 efb:	00 
 efc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f03:	e8 87 f5 ff ff       	call   48f <printf>
    return;
 f08:	eb 3a                	jmp    f44 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
 f0a:	e8 59 ff ff ff       	call   e68 <uthread_self>
 f0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
 f12:	8b 45 08             	mov    0x8(%ebp),%eax
 f15:	8b 40 04             	mov    0x4(%eax),%eax
 f18:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 f1b:	74 27                	je     f44 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 f1d:	eb 05                	jmp    f24 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
 f1f:	e8 43 fe ff ff       	call   d67 <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 f24:	8b 45 08             	mov    0x8(%ebp),%eax
 f27:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 f2e:	00 
 f2f:	89 04 24             	mov    %eax,(%esp)
 f32:	e8 3d ff ff ff       	call   e74 <xchg>
 f37:	85 c0                	test   %eax,%eax
 f39:	74 e4                	je     f1f <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
 f3b:	8b 45 08             	mov    0x8(%ebp),%eax
 f3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 f41:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
 f44:	c9                   	leave  
 f45:	c3                   	ret    

00000f46 <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
 f46:	55                   	push   %ebp
 f47:	89 e5                	mov    %esp,%ebp
 f49:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
 f4c:	8b 45 08             	mov    0x8(%ebp),%eax
 f4f:	8b 40 08             	mov    0x8(%eax),%eax
 f52:	85 c0                	test   %eax,%eax
 f54:	75 20                	jne    f76 <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 f56:	8b 45 08             	mov    0x8(%ebp),%eax
 f59:	8b 40 04             	mov    0x4(%eax),%eax
 f5c:	89 44 24 08          	mov    %eax,0x8(%esp)
 f60:	c7 44 24 04 94 10 00 	movl   $0x1094,0x4(%esp)
 f67:	00 
 f68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f6f:	e8 1b f5 ff ff       	call   48f <printf>
    return;
 f74:	eb 2f                	jmp    fa5 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
 f76:	e8 ed fe ff ff       	call   e68 <uthread_self>
 f7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
 f7e:	8b 45 08             	mov    0x8(%ebp),%eax
 f81:	8b 00                	mov    (%eax),%eax
 f83:	85 c0                	test   %eax,%eax
 f85:	75 1e                	jne    fa5 <binary_semaphore_up+0x5f>
 f87:	8b 45 08             	mov    0x8(%ebp),%eax
 f8a:	8b 40 04             	mov    0x4(%eax),%eax
 f8d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 f90:	75 13                	jne    fa5 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
 f92:	8b 45 08             	mov    0x8(%ebp),%eax
 f95:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
 f9c:	8b 45 08             	mov    0x8(%ebp),%eax
 f9f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
 fa5:	c9                   	leave  
 fa6:	c3                   	ret    
