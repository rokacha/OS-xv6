
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 1){
   9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "usage: kill pid...\n");
   f:	c7 44 24 04 00 0b 00 	movl   $0xb00,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 54 04 00 00       	call   477 <printf>
    exit();
  23:	e8 a0 02 00 00       	call   2c8 <exit>
  }
  for(i=1; i<argc; i++)
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 21                	jmp    53 <main+0x53>
    kill(atoi(argv[i]));
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	c1 e0 02             	shl    $0x2,%eax
  39:	03 45 0c             	add    0xc(%ebp),%eax
  3c:	8b 00                	mov    (%eax),%eax
  3e:	89 04 24             	mov    %eax,(%esp)
  41:	e8 f1 01 00 00       	call   237 <atoi>
  46:	89 04 24             	mov    %eax,(%esp)
  49:	e8 aa 02 00 00       	call   2f8 <kill>

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  4e:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  53:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  57:	3b 45 08             	cmp    0x8(%ebp),%eax
  5a:	7c d6                	jl     32 <main+0x32>
    kill(atoi(argv[i]));
  exit();
  5c:	e8 67 02 00 00       	call   2c8 <exit>
  61:	90                   	nop
  62:	90                   	nop
  63:	90                   	nop

00000064 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	57                   	push   %edi
  68:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  69:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6c:	8b 55 10             	mov    0x10(%ebp),%edx
  6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  72:	89 cb                	mov    %ecx,%ebx
  74:	89 df                	mov    %ebx,%edi
  76:	89 d1                	mov    %edx,%ecx
  78:	fc                   	cld    
  79:	f3 aa                	rep stos %al,%es:(%edi)
  7b:	89 ca                	mov    %ecx,%edx
  7d:	89 fb                	mov    %edi,%ebx
  7f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  82:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  85:	5b                   	pop    %ebx
  86:	5f                   	pop    %edi
  87:	5d                   	pop    %ebp
  88:	c3                   	ret    

00000089 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  8c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  95:	90                   	nop
  96:	8b 45 0c             	mov    0xc(%ebp),%eax
  99:	0f b6 10             	movzbl (%eax),%edx
  9c:	8b 45 08             	mov    0x8(%ebp),%eax
  9f:	88 10                	mov    %dl,(%eax)
  a1:	8b 45 08             	mov    0x8(%ebp),%eax
  a4:	0f b6 00             	movzbl (%eax),%eax
  a7:	84 c0                	test   %al,%al
  a9:	0f 95 c0             	setne  %al
  ac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  b4:	84 c0                	test   %al,%al
  b6:	75 de                	jne    96 <strcpy+0xd>
    ;
  return os;
  b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bb:	c9                   	leave  
  bc:	c3                   	ret    

000000bd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bd:	55                   	push   %ebp
  be:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c0:	eb 08                	jmp    ca <strcmp+0xd>
    p++, q++;
  c2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ca:	8b 45 08             	mov    0x8(%ebp),%eax
  cd:	0f b6 00             	movzbl (%eax),%eax
  d0:	84 c0                	test   %al,%al
  d2:	74 10                	je     e4 <strcmp+0x27>
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 10             	movzbl (%eax),%edx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	0f b6 00             	movzbl (%eax),%eax
  e0:	38 c2                	cmp    %al,%dl
  e2:	74 de                	je     c2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e4:	8b 45 08             	mov    0x8(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	0f b6 d0             	movzbl %al,%edx
  ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  f0:	0f b6 00             	movzbl (%eax),%eax
  f3:	0f b6 c0             	movzbl %al,%eax
  f6:	89 d1                	mov    %edx,%ecx
  f8:	29 c1                	sub    %eax,%ecx
  fa:	89 c8                	mov    %ecx,%eax
}
  fc:	5d                   	pop    %ebp
  fd:	c3                   	ret    

000000fe <strlen>:

uint
strlen(char *s)
{
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 104:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10b:	eb 04                	jmp    111 <strlen+0x13>
 10d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 111:	8b 45 fc             	mov    -0x4(%ebp),%eax
 114:	03 45 08             	add    0x8(%ebp),%eax
 117:	0f b6 00             	movzbl (%eax),%eax
 11a:	84 c0                	test   %al,%al
 11c:	75 ef                	jne    10d <strlen+0xf>
    ;
  return n;
 11e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 121:	c9                   	leave  
 122:	c3                   	ret    

00000123 <memset>:

void*
memset(void *dst, int c, uint n)
{
 123:	55                   	push   %ebp
 124:	89 e5                	mov    %esp,%ebp
 126:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 129:	8b 45 10             	mov    0x10(%ebp),%eax
 12c:	89 44 24 08          	mov    %eax,0x8(%esp)
 130:	8b 45 0c             	mov    0xc(%ebp),%eax
 133:	89 44 24 04          	mov    %eax,0x4(%esp)
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	89 04 24             	mov    %eax,(%esp)
 13d:	e8 22 ff ff ff       	call   64 <stosb>
  return dst;
 142:	8b 45 08             	mov    0x8(%ebp),%eax
}
 145:	c9                   	leave  
 146:	c3                   	ret    

00000147 <strchr>:

char*
strchr(const char *s, char c)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 04             	sub    $0x4,%esp
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 153:	eb 14                	jmp    169 <strchr+0x22>
    if(*s == c)
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15e:	75 05                	jne    165 <strchr+0x1e>
      return (char*)s;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	eb 13                	jmp    178 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 e2                	jne    155 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 173:	b8 00 00 00 00       	mov    $0x0,%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <gets>:

char*
gets(char *buf, int max)
{
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 187:	eb 44                	jmp    1cd <gets+0x53>
    cc = read(0, &c, 1);
 189:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 190:	00 
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	89 44 24 04          	mov    %eax,0x4(%esp)
 198:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19f:	e8 3c 01 00 00       	call   2e0 <read>
 1a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ab:	7e 2d                	jle    1da <gets+0x60>
      break;
    buf[i++] = c;
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	03 45 08             	add    0x8(%ebp),%eax
 1b3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1b7:	88 10                	mov    %dl,(%eax)
 1b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c1:	3c 0a                	cmp    $0xa,%al
 1c3:	74 16                	je     1db <gets+0x61>
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	3c 0d                	cmp    $0xd,%al
 1cb:	74 0e                	je     1db <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d0:	83 c0 01             	add    $0x1,%eax
 1d3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d6:	7c b1                	jl     189 <gets+0xf>
 1d8:	eb 01                	jmp    1db <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1da:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	03 45 08             	add    0x8(%ebp),%eax
 1e1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <stat>:

int
stat(char *n, struct stat *st)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ef:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f6:	00 
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	89 04 24             	mov    %eax,(%esp)
 1fd:	e8 06 01 00 00       	call   308 <open>
 202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 209:	79 07                	jns    212 <stat+0x29>
    return -1;
 20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 210:	eb 23                	jmp    235 <stat+0x4c>
  r = fstat(fd, st);
 212:	8b 45 0c             	mov    0xc(%ebp),%eax
 215:	89 44 24 04          	mov    %eax,0x4(%esp)
 219:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21c:	89 04 24             	mov    %eax,(%esp)
 21f:	e8 fc 00 00 00       	call   320 <fstat>
 224:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 227:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22a:	89 04 24             	mov    %eax,(%esp)
 22d:	e8 be 00 00 00       	call   2f0 <close>
  return r;
 232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 235:	c9                   	leave  
 236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
 237:	55                   	push   %ebp
 238:	89 e5                	mov    %esp,%ebp
 23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 244:	eb 23                	jmp    269 <atoi+0x32>
    n = n*10 + *s++ - '0';
 246:	8b 55 fc             	mov    -0x4(%ebp),%edx
 249:	89 d0                	mov    %edx,%eax
 24b:	c1 e0 02             	shl    $0x2,%eax
 24e:	01 d0                	add    %edx,%eax
 250:	01 c0                	add    %eax,%eax
 252:	89 c2                	mov    %eax,%edx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	0f b6 00             	movzbl (%eax),%eax
 25a:	0f be c0             	movsbl %al,%eax
 25d:	01 d0                	add    %edx,%eax
 25f:	83 e8 30             	sub    $0x30,%eax
 262:	89 45 fc             	mov    %eax,-0x4(%ebp)
 265:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 269:	8b 45 08             	mov    0x8(%ebp),%eax
 26c:	0f b6 00             	movzbl (%eax),%eax
 26f:	3c 2f                	cmp    $0x2f,%al
 271:	7e 0a                	jle    27d <atoi+0x46>
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	3c 39                	cmp    $0x39,%al
 27b:	7e c9                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 280:	c9                   	leave  
 281:	c3                   	ret    

00000282 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 282:	55                   	push   %ebp
 283:	89 e5                	mov    %esp,%ebp
 285:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 28e:	8b 45 0c             	mov    0xc(%ebp),%eax
 291:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 294:	eb 13                	jmp    2a9 <memmove+0x27>
    *dst++ = *src++;
 296:	8b 45 f8             	mov    -0x8(%ebp),%eax
 299:	0f b6 10             	movzbl (%eax),%edx
 29c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29f:	88 10                	mov    %dl,(%eax)
 2a1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2a5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2ad:	0f 9f c0             	setg   %al
 2b0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2b4:	84 c0                	test   %al,%al
 2b6:	75 de                	jne    296 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bb:	c9                   	leave  
 2bc:	c3                   	ret    
 2bd:	90                   	nop
 2be:	90                   	nop
 2bf:	90                   	nop

000002c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c0:	b8 01 00 00 00       	mov    $0x1,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <exit>:
SYSCALL(exit)
 2c8:	b8 02 00 00 00       	mov    $0x2,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <wait>:
SYSCALL(wait)
 2d0:	b8 03 00 00 00       	mov    $0x3,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <pipe>:
SYSCALL(pipe)
 2d8:	b8 04 00 00 00       	mov    $0x4,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <read>:
SYSCALL(read)
 2e0:	b8 05 00 00 00       	mov    $0x5,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <write>:
SYSCALL(write)
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <close>:
SYSCALL(close)
 2f0:	b8 15 00 00 00       	mov    $0x15,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <kill>:
SYSCALL(kill)
 2f8:	b8 06 00 00 00       	mov    $0x6,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <exec>:
SYSCALL(exec)
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <open>:
SYSCALL(open)
 308:	b8 0f 00 00 00       	mov    $0xf,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mknod>:
SYSCALL(mknod)
 310:	b8 11 00 00 00       	mov    $0x11,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <unlink>:
SYSCALL(unlink)
 318:	b8 12 00 00 00       	mov    $0x12,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <fstat>:
SYSCALL(fstat)
 320:	b8 08 00 00 00       	mov    $0x8,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <link>:
SYSCALL(link)
 328:	b8 13 00 00 00       	mov    $0x13,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mkdir>:
SYSCALL(mkdir)
 330:	b8 14 00 00 00       	mov    $0x14,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <chdir>:
SYSCALL(chdir)
 338:	b8 09 00 00 00       	mov    $0x9,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <dup>:
SYSCALL(dup)
 340:	b8 0a 00 00 00       	mov    $0xa,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <getpid>:
SYSCALL(getpid)
 348:	b8 0b 00 00 00       	mov    $0xb,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <sbrk>:
SYSCALL(sbrk)
 350:	b8 0c 00 00 00       	mov    $0xc,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sleep>:
SYSCALL(sleep)
 358:	b8 0d 00 00 00       	mov    $0xd,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <uptime>:
SYSCALL(uptime)
 360:	b8 0e 00 00 00       	mov    $0xe,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <add_path>:
SYSCALL(add_path)
 368:	b8 16 00 00 00       	mov    $0x16,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <wait2>:
SYSCALL(wait2)
 370:	b8 17 00 00 00       	mov    $0x17,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <getquanta>:
SYSCALL(getquanta)
 378:	b8 18 00 00 00       	mov    $0x18,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <getqueue>:
SYSCALL(getqueue)
 380:	b8 19 00 00 00       	mov    $0x19,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <signal>:
SYSCALL(signal)
 388:	b8 1a 00 00 00       	mov    $0x1a,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <sigsend>:
SYSCALL(sigsend)
 390:	b8 1b 00 00 00       	mov    $0x1b,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <alarm>:
SYSCALL(alarm)
 398:	b8 1c 00 00 00       	mov    $0x1c,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	83 ec 28             	sub    $0x28,%esp
 3a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ac:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b3:	00 
 3b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	89 04 24             	mov    %eax,(%esp)
 3c1:	e8 22 ff ff ff       	call   2e8 <write>
}
 3c6:	c9                   	leave  
 3c7:	c3                   	ret    

000003c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c8:	55                   	push   %ebp
 3c9:	89 e5                	mov    %esp,%ebp
 3cb:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3d5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3d9:	74 17                	je     3f2 <printint+0x2a>
 3db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3df:	79 11                	jns    3f2 <printint+0x2a>
    neg = 1;
 3e1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3e8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3eb:	f7 d8                	neg    %eax
 3ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f0:	eb 06                	jmp    3f8 <printint+0x30>
  } else {
    x = xx;
 3f2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
 402:	8b 45 ec             	mov    -0x14(%ebp),%eax
 405:	ba 00 00 00 00       	mov    $0x0,%edx
 40a:	f7 f1                	div    %ecx
 40c:	89 d0                	mov    %edx,%eax
 40e:	0f b6 90 ac 0e 00 00 	movzbl 0xeac(%eax),%edx
 415:	8d 45 dc             	lea    -0x24(%ebp),%eax
 418:	03 45 f4             	add    -0xc(%ebp),%eax
 41b:	88 10                	mov    %dl,(%eax)
 41d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 421:	8b 55 10             	mov    0x10(%ebp),%edx
 424:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 427:	8b 45 ec             	mov    -0x14(%ebp),%eax
 42a:	ba 00 00 00 00       	mov    $0x0,%edx
 42f:	f7 75 d4             	divl   -0x2c(%ebp)
 432:	89 45 ec             	mov    %eax,-0x14(%ebp)
 435:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 439:	75 c4                	jne    3ff <printint+0x37>
  if(neg)
 43b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 43f:	74 2a                	je     46b <printint+0xa3>
    buf[i++] = '-';
 441:	8d 45 dc             	lea    -0x24(%ebp),%eax
 444:	03 45 f4             	add    -0xc(%ebp),%eax
 447:	c6 00 2d             	movb   $0x2d,(%eax)
 44a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 44e:	eb 1b                	jmp    46b <printint+0xa3>
    putc(fd, buf[i]);
 450:	8d 45 dc             	lea    -0x24(%ebp),%eax
 453:	03 45 f4             	add    -0xc(%ebp),%eax
 456:	0f b6 00             	movzbl (%eax),%eax
 459:	0f be c0             	movsbl %al,%eax
 45c:	89 44 24 04          	mov    %eax,0x4(%esp)
 460:	8b 45 08             	mov    0x8(%ebp),%eax
 463:	89 04 24             	mov    %eax,(%esp)
 466:	e8 35 ff ff ff       	call   3a0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 46b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 46f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 473:	79 db                	jns    450 <printint+0x88>
    putc(fd, buf[i]);
}
 475:	c9                   	leave  
 476:	c3                   	ret    

00000477 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 477:	55                   	push   %ebp
 478:	89 e5                	mov    %esp,%ebp
 47a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 47d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 484:	8d 45 0c             	lea    0xc(%ebp),%eax
 487:	83 c0 04             	add    $0x4,%eax
 48a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 48d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 494:	e9 7d 01 00 00       	jmp    616 <printf+0x19f>
    c = fmt[i] & 0xff;
 499:	8b 55 0c             	mov    0xc(%ebp),%edx
 49c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 49f:	01 d0                	add    %edx,%eax
 4a1:	0f b6 00             	movzbl (%eax),%eax
 4a4:	0f be c0             	movsbl %al,%eax
 4a7:	25 ff 00 00 00       	and    $0xff,%eax
 4ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b3:	75 2c                	jne    4e1 <printf+0x6a>
      if(c == '%'){
 4b5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4b9:	75 0c                	jne    4c7 <printf+0x50>
        state = '%';
 4bb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4c2:	e9 4b 01 00 00       	jmp    612 <printf+0x19b>
      } else {
        putc(fd, c);
 4c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ca:	0f be c0             	movsbl %al,%eax
 4cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d1:	8b 45 08             	mov    0x8(%ebp),%eax
 4d4:	89 04 24             	mov    %eax,(%esp)
 4d7:	e8 c4 fe ff ff       	call   3a0 <putc>
 4dc:	e9 31 01 00 00       	jmp    612 <printf+0x19b>
      }
    } else if(state == '%'){
 4e1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4e5:	0f 85 27 01 00 00    	jne    612 <printf+0x19b>
      if(c == 'd'){
 4eb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ef:	75 2d                	jne    51e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 4f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f4:	8b 00                	mov    (%eax),%eax
 4f6:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4fd:	00 
 4fe:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 505:	00 
 506:	89 44 24 04          	mov    %eax,0x4(%esp)
 50a:	8b 45 08             	mov    0x8(%ebp),%eax
 50d:	89 04 24             	mov    %eax,(%esp)
 510:	e8 b3 fe ff ff       	call   3c8 <printint>
        ap++;
 515:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 519:	e9 ed 00 00 00       	jmp    60b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 51e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 522:	74 06                	je     52a <printf+0xb3>
 524:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 528:	75 2d                	jne    557 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 52a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52d:	8b 00                	mov    (%eax),%eax
 52f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 536:	00 
 537:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 53e:	00 
 53f:	89 44 24 04          	mov    %eax,0x4(%esp)
 543:	8b 45 08             	mov    0x8(%ebp),%eax
 546:	89 04 24             	mov    %eax,(%esp)
 549:	e8 7a fe ff ff       	call   3c8 <printint>
        ap++;
 54e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 552:	e9 b4 00 00 00       	jmp    60b <printf+0x194>
      } else if(c == 's'){
 557:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 55b:	75 46                	jne    5a3 <printf+0x12c>
        s = (char*)*ap;
 55d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 560:	8b 00                	mov    (%eax),%eax
 562:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 565:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 569:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 56d:	75 27                	jne    596 <printf+0x11f>
          s = "(null)";
 56f:	c7 45 f4 14 0b 00 00 	movl   $0xb14,-0xc(%ebp)
        while(*s != 0){
 576:	eb 1e                	jmp    596 <printf+0x11f>
          putc(fd, *s);
 578:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57b:	0f b6 00             	movzbl (%eax),%eax
 57e:	0f be c0             	movsbl %al,%eax
 581:	89 44 24 04          	mov    %eax,0x4(%esp)
 585:	8b 45 08             	mov    0x8(%ebp),%eax
 588:	89 04 24             	mov    %eax,(%esp)
 58b:	e8 10 fe ff ff       	call   3a0 <putc>
          s++;
 590:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 594:	eb 01                	jmp    597 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 596:	90                   	nop
 597:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59a:	0f b6 00             	movzbl (%eax),%eax
 59d:	84 c0                	test   %al,%al
 59f:	75 d7                	jne    578 <printf+0x101>
 5a1:	eb 68                	jmp    60b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5a7:	75 1d                	jne    5c6 <printf+0x14f>
        putc(fd, *ap);
 5a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ac:	8b 00                	mov    (%eax),%eax
 5ae:	0f be c0             	movsbl %al,%eax
 5b1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b5:	8b 45 08             	mov    0x8(%ebp),%eax
 5b8:	89 04 24             	mov    %eax,(%esp)
 5bb:	e8 e0 fd ff ff       	call   3a0 <putc>
        ap++;
 5c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c4:	eb 45                	jmp    60b <printf+0x194>
      } else if(c == '%'){
 5c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ca:	75 17                	jne    5e3 <printf+0x16c>
        putc(fd, c);
 5cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5cf:	0f be c0             	movsbl %al,%eax
 5d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d6:	8b 45 08             	mov    0x8(%ebp),%eax
 5d9:	89 04 24             	mov    %eax,(%esp)
 5dc:	e8 bf fd ff ff       	call   3a0 <putc>
 5e1:	eb 28                	jmp    60b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e3:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 5ea:	00 
 5eb:	8b 45 08             	mov    0x8(%ebp),%eax
 5ee:	89 04 24             	mov    %eax,(%esp)
 5f1:	e8 aa fd ff ff       	call   3a0 <putc>
        putc(fd, c);
 5f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f9:	0f be c0             	movsbl %al,%eax
 5fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 600:	8b 45 08             	mov    0x8(%ebp),%eax
 603:	89 04 24             	mov    %eax,(%esp)
 606:	e8 95 fd ff ff       	call   3a0 <putc>
      }
      state = 0;
 60b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 612:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 616:	8b 55 0c             	mov    0xc(%ebp),%edx
 619:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61c:	01 d0                	add    %edx,%eax
 61e:	0f b6 00             	movzbl (%eax),%eax
 621:	84 c0                	test   %al,%al
 623:	0f 85 70 fe ff ff    	jne    499 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 629:	c9                   	leave  
 62a:	c3                   	ret    
 62b:	90                   	nop

0000062c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 62c:	55                   	push   %ebp
 62d:	89 e5                	mov    %esp,%ebp
 62f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 632:	8b 45 08             	mov    0x8(%ebp),%eax
 635:	83 e8 08             	sub    $0x8,%eax
 638:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63b:	a1 c8 0e 00 00       	mov    0xec8,%eax
 640:	89 45 fc             	mov    %eax,-0x4(%ebp)
 643:	eb 24                	jmp    669 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 645:	8b 45 fc             	mov    -0x4(%ebp),%eax
 648:	8b 00                	mov    (%eax),%eax
 64a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 64d:	77 12                	ja     661 <free+0x35>
 64f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 652:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 655:	77 24                	ja     67b <free+0x4f>
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 65f:	77 1a                	ja     67b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	8b 45 fc             	mov    -0x4(%ebp),%eax
 664:	8b 00                	mov    (%eax),%eax
 666:	89 45 fc             	mov    %eax,-0x4(%ebp)
 669:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66f:	76 d4                	jbe    645 <free+0x19>
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 679:	76 ca                	jbe    645 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	8b 40 04             	mov    0x4(%eax),%eax
 681:	c1 e0 03             	shl    $0x3,%eax
 684:	89 c2                	mov    %eax,%edx
 686:	03 55 f8             	add    -0x8(%ebp),%edx
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	39 c2                	cmp    %eax,%edx
 690:	75 24                	jne    6b6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 692:	8b 45 f8             	mov    -0x8(%ebp),%eax
 695:	8b 50 04             	mov    0x4(%eax),%edx
 698:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69b:	8b 00                	mov    (%eax),%eax
 69d:	8b 40 04             	mov    0x4(%eax),%eax
 6a0:	01 c2                	add    %eax,%edx
 6a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	8b 00                	mov    (%eax),%eax
 6ad:	8b 10                	mov    (%eax),%edx
 6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b2:	89 10                	mov    %edx,(%eax)
 6b4:	eb 0a                	jmp    6c0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b9:	8b 10                	mov    (%eax),%edx
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	8b 40 04             	mov    0x4(%eax),%eax
 6c6:	c1 e0 03             	shl    $0x3,%eax
 6c9:	03 45 fc             	add    -0x4(%ebp),%eax
 6cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6cf:	75 20                	jne    6f1 <free+0xc5>
    p->s.size += bp->s.size;
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	8b 50 04             	mov    0x4(%eax),%edx
 6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6da:	8b 40 04             	mov    0x4(%eax),%eax
 6dd:	01 c2                	add    %eax,%edx
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e8:	8b 10                	mov    (%eax),%edx
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	89 10                	mov    %edx,(%eax)
 6ef:	eb 08                	jmp    6f9 <free+0xcd>
  } else
    p->s.ptr = bp;
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6f7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	a3 c8 0e 00 00       	mov    %eax,0xec8
}
 701:	c9                   	leave  
 702:	c3                   	ret    

00000703 <morecore>:

static Header*
morecore(uint nu)
{
 703:	55                   	push   %ebp
 704:	89 e5                	mov    %esp,%ebp
 706:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 709:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 710:	77 07                	ja     719 <morecore+0x16>
    nu = 4096;
 712:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 719:	8b 45 08             	mov    0x8(%ebp),%eax
 71c:	c1 e0 03             	shl    $0x3,%eax
 71f:	89 04 24             	mov    %eax,(%esp)
 722:	e8 29 fc ff ff       	call   350 <sbrk>
 727:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 72a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 72e:	75 07                	jne    737 <morecore+0x34>
    return 0;
 730:	b8 00 00 00 00       	mov    $0x0,%eax
 735:	eb 22                	jmp    759 <morecore+0x56>
  hp = (Header*)p;
 737:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 73d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 740:	8b 55 08             	mov    0x8(%ebp),%edx
 743:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 746:	8b 45 f0             	mov    -0x10(%ebp),%eax
 749:	83 c0 08             	add    $0x8,%eax
 74c:	89 04 24             	mov    %eax,(%esp)
 74f:	e8 d8 fe ff ff       	call   62c <free>
  return freep;
 754:	a1 c8 0e 00 00       	mov    0xec8,%eax
}
 759:	c9                   	leave  
 75a:	c3                   	ret    

0000075b <malloc>:

void*
malloc(uint nbytes)
{
 75b:	55                   	push   %ebp
 75c:	89 e5                	mov    %esp,%ebp
 75e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 761:	8b 45 08             	mov    0x8(%ebp),%eax
 764:	83 c0 07             	add    $0x7,%eax
 767:	c1 e8 03             	shr    $0x3,%eax
 76a:	83 c0 01             	add    $0x1,%eax
 76d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 770:	a1 c8 0e 00 00       	mov    0xec8,%eax
 775:	89 45 f0             	mov    %eax,-0x10(%ebp)
 778:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 77c:	75 23                	jne    7a1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 77e:	c7 45 f0 c0 0e 00 00 	movl   $0xec0,-0x10(%ebp)
 785:	8b 45 f0             	mov    -0x10(%ebp),%eax
 788:	a3 c8 0e 00 00       	mov    %eax,0xec8
 78d:	a1 c8 0e 00 00       	mov    0xec8,%eax
 792:	a3 c0 0e 00 00       	mov    %eax,0xec0
    base.s.size = 0;
 797:	c7 05 c4 0e 00 00 00 	movl   $0x0,0xec4
 79e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a4:	8b 00                	mov    (%eax),%eax
 7a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ac:	8b 40 04             	mov    0x4(%eax),%eax
 7af:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7b2:	72 4d                	jb     801 <malloc+0xa6>
      if(p->s.size == nunits)
 7b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b7:	8b 40 04             	mov    0x4(%eax),%eax
 7ba:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7bd:	75 0c                	jne    7cb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	8b 10                	mov    (%eax),%edx
 7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c7:	89 10                	mov    %edx,(%eax)
 7c9:	eb 26                	jmp    7f1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	8b 40 04             	mov    0x4(%eax),%eax
 7d1:	89 c2                	mov    %eax,%edx
 7d3:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	c1 e0 03             	shl    $0x3,%eax
 7e5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ee:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f4:	a3 c8 0e 00 00       	mov    %eax,0xec8
      return (void*)(p + 1);
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	83 c0 08             	add    $0x8,%eax
 7ff:	eb 38                	jmp    839 <malloc+0xde>
    }
    if(p == freep)
 801:	a1 c8 0e 00 00       	mov    0xec8,%eax
 806:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 809:	75 1b                	jne    826 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 80b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 80e:	89 04 24             	mov    %eax,(%esp)
 811:	e8 ed fe ff ff       	call   703 <morecore>
 816:	89 45 f4             	mov    %eax,-0xc(%ebp)
 819:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 81d:	75 07                	jne    826 <malloc+0xcb>
        return 0;
 81f:	b8 00 00 00 00       	mov    $0x0,%eax
 824:	eb 13                	jmp    839 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 826:	8b 45 f4             	mov    -0xc(%ebp),%eax
 829:	89 45 f0             	mov    %eax,-0x10(%ebp)
 82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82f:	8b 00                	mov    (%eax),%eax
 831:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 834:	e9 70 ff ff ff       	jmp    7a9 <malloc+0x4e>
}
 839:	c9                   	leave  
 83a:	c3                   	ret    
 83b:	90                   	nop

0000083c <getRunningThread>:
  int current;
} tTable;

int
getRunningThread()
{
 83c:	55                   	push   %ebp
 83d:	89 e5                	mov    %esp,%ebp
 83f:	83 ec 10             	sub    $0x10,%esp
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 842:	c7 45 f8 e0 0e 00 00 	movl   $0xee0,-0x8(%ebp)
 849:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 850:	eb 18                	jmp    86a <getRunningThread+0x2e>
  {
    if(t->state==T_RUNNING)
 852:	8b 45 f8             	mov    -0x8(%ebp),%eax
 855:	8b 40 10             	mov    0x10(%eax),%eax
 858:	83 f8 02             	cmp    $0x2,%eax
 85b:	75 05                	jne    862 <getRunningThread+0x26>
      return i;
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	eb 16                	jmp    878 <getRunningThread+0x3c>
getRunningThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 862:	83 45 f8 18          	addl   $0x18,-0x8(%ebp)
 866:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 86a:	81 7d f8 e0 14 00 00 	cmpl   $0x14e0,-0x8(%ebp)
 871:	76 df                	jbe    852 <getRunningThread+0x16>
  {
    if(t->state==T_RUNNING)
      return i;
  }
  return -1;
 873:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 878:	c9                   	leave  
 879:	c3                   	ret    

0000087a <getNextThread>:

int
getNextThread()
{
 87a:	55                   	push   %ebp
 87b:	89 e5                	mov    %esp,%ebp
 87d:	83 ec 10             	sub    $0x10,%esp
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 880:	c7 45 f8 e0 0e 00 00 	movl   $0xee0,-0x8(%ebp)
 887:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 88e:	eb 18                	jmp    8a8 <getNextThread+0x2e>
  {
    if(t->state==T_RUNNABLE)
 890:	8b 45 f8             	mov    -0x8(%ebp),%eax
 893:	8b 40 10             	mov    0x10(%eax),%eax
 896:	83 f8 03             	cmp    $0x3,%eax
 899:	75 05                	jne    8a0 <getNextThread+0x26>
      return i;
 89b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89e:	eb 16                	jmp    8b6 <getNextThread+0x3c>
getNextThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 8a0:	83 45 f8 18          	addl   $0x18,-0x8(%ebp)
 8a4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 8a8:	81 7d f8 e0 14 00 00 	cmpl   $0x14e0,-0x8(%ebp)
 8af:	76 df                	jbe    890 <getNextThread+0x16>
  {
    if(t->state==T_RUNNABLE)
      return i;
  }
  return -1;
 8b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 8b6:	c9                   	leave  
 8b7:	c3                   	ret    

000008b8 <allocThread>:

static uthread_p
allocThread()
{
 8b8:	55                   	push   %ebp
 8b9:	89 e5                	mov    %esp,%ebp
 8bb:	83 ec 28             	sub    $0x28,%esp
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 8be:	c7 45 f0 e0 0e 00 00 	movl   $0xee0,-0x10(%ebp)
 8c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 8cc:	eb 12                	jmp    8e0 <allocThread+0x28>
  {
    if(t->state==T_FREE)
 8ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d1:	8b 40 10             	mov    0x10(%eax),%eax
 8d4:	85 c0                	test   %eax,%eax
 8d6:	74 18                	je     8f0 <allocThread+0x38>
allocThread()
{
  int i;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
 8d8:	83 45 f0 18          	addl   $0x18,-0x10(%ebp)
 8dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 8e0:	81 7d f0 e0 14 00 00 	cmpl   $0x14e0,-0x10(%ebp)
 8e7:	76 e5                	jbe    8ce <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 8e9:	b8 00 00 00 00       	mov    $0x0,%eax
 8ee:	eb 64                	jmp    954 <allocThread+0x9c>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t <= &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
 8f0:	90                   	nop
  }
  return 0;
  
  found:
  
  t->tid=i;
 8f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8f7:	89 10                	mov    %edx,(%eax)
  t->stack=(char*)malloc(STACK_SIZE);
 8f9:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 900:	e8 56 fe ff ff       	call   75b <malloc>
 905:	8b 55 f0             	mov    -0x10(%ebp),%edx
 908:	89 42 0c             	mov    %eax,0xc(%edx)
  t->esp=(int)t->stack;
 90b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90e:	8b 40 0c             	mov    0xc(%eax),%eax
 911:	89 c2                	mov    %eax,%edx
 913:	8b 45 f0             	mov    -0x10(%ebp),%eax
 916:	89 50 04             	mov    %edx,0x4(%eax)
  t->ebp=(int)t->stack;
 919:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91c:	8b 40 0c             	mov    0xc(%eax),%eax
 91f:	89 c2                	mov    %eax,%edx
 921:	8b 45 f0             	mov    -0x10(%ebp),%eax
 924:	89 50 08             	mov    %edx,0x8(%eax)
  t->firstTime=0;
 927:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
 931:	8b 45 f0             	mov    -0x10(%ebp),%eax
 934:	8b 40 08             	mov    0x8(%eax),%eax
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 937:	ba 41 0a 00 00       	mov    $0xa41,%edx
 93c:	89 c4                	mov    %eax,%esp
 93e:	52                   	push   %edx
 93f:	89 e2                	mov    %esp,%edx
    : "=r" (t->esp) 
 941:	8b 45 f0             	mov    -0x10(%ebp),%eax
  t->tid=i;
  t->stack=(char*)malloc(STACK_SIZE);
  t->esp=(int)t->stack;
  t->ebp=(int)t->stack;
  t->firstTime=0;
  asm("movl %1,%%esp;" "push %2;" "movl %%esp,%0;" //pushes the uthread_exit func as return address
 944:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (t->esp) 
    : "r" (t->ebp) , "r"(uthread_exit)
  );
  t->state=T_UNINIT;
 947:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94a:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  return t;
 951:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 954:	c9                   	leave  
 955:	c3                   	ret    

00000956 <uthread_init>:

void 
uthread_init()
{  
 956:	55                   	push   %ebp
 957:	89 e5                	mov    %esp,%ebp
 959:	83 ec 28             	sub    $0x28,%esp
  tTable.length=0;
 95c:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
 963:	00 00 00 
  tTable.current=0;
 966:	c7 05 e4 14 00 00 00 	movl   $0x0,0x14e4
 96d:	00 00 00 
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
 970:	e8 43 ff ff ff       	call   8b8 <allocThread>
 975:	89 45 f4             	mov    %eax,-0xc(%ebp)
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 978:	89 e9                	mov    %ebp,%ecx
 97a:	89 e2                	mov    %esp,%edx
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 97c:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 97f:	89 48 08             	mov    %ecx,0x8(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
 982:	8b 45 f4             	mov    -0xc(%ebp),%eax
uthread_init()
{  
  tTable.length=0;
  tTable.current=0;
  uthread_p mainT = allocThread(); //needed to allocate the main thread !!!!!!
  asm("movl %%ebp,%0;" "movl %%esp,%1;" //get current thread ebp and esp
 985:	89 50 04             	mov    %edx,0x4(%eax)
    : "=r" (mainT->ebp) ,"=r"(mainT->esp)    
  );
  /*moves stack to mainT's stack
  /stacks grow backwards so we start from esp and finsh at ebp*/
  memmove(mainT->stack , (void*)mainT->esp , mainT->ebp - mainT->esp);
 988:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98b:	8b 50 08             	mov    0x8(%eax),%edx
 98e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 991:	8b 40 04             	mov    0x4(%eax),%eax
 994:	89 d1                	mov    %edx,%ecx
 996:	29 c1                	sub    %eax,%ecx
 998:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99b:	8b 40 04             	mov    0x4(%eax),%eax
 99e:	89 c2                	mov    %eax,%edx
 9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a3:	8b 40 0c             	mov    0xc(%eax),%eax
 9a6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 9aa:	89 54 24 04          	mov    %edx,0x4(%esp)
 9ae:	89 04 24             	mov    %eax,(%esp)
 9b1:	e8 cc f8 ff ff       	call   282 <memmove>
  mainT->state = T_RUNNABLE;
 9b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b9:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  if(signal(SIGALRM,uthread_yield)<0)
 9c0:	c7 44 24 04 46 0a 00 	movl   $0xa46,0x4(%esp)
 9c7:	00 
 9c8:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 9cf:	e8 b4 f9 ff ff       	call   388 <signal>
 9d4:	85 c0                	test   %eax,%eax
 9d6:	79 19                	jns    9f1 <uthread_init+0x9b>
  {
    printf(1,"Cant register the alarm signal");
 9d8:	c7 44 24 04 1c 0b 00 	movl   $0xb1c,0x4(%esp)
 9df:	00 
 9e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9e7:	e8 8b fa ff ff       	call   477 <printf>
    exit();
 9ec:	e8 d7 f8 ff ff       	call   2c8 <exit>
  }
  if(alarm(THREAD_QUANTA)<0)
 9f1:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 9f8:	e8 9b f9 ff ff       	call   398 <alarm>
 9fd:	85 c0                	test   %eax,%eax
 9ff:	79 19                	jns    a1a <uthread_init+0xc4>
  {
    printf(1,"Cant activate alarm system call");
 a01:	c7 44 24 04 3c 0b 00 	movl   $0xb3c,0x4(%esp)
 a08:	00 
 a09:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a10:	e8 62 fa ff ff       	call   477 <printf>
    exit();
 a15:	e8 ae f8 ff ff       	call   2c8 <exit>
  }
  
}
 a1a:	c9                   	leave  
 a1b:	c3                   	ret    

00000a1c <uthread_create>:

int  
uthread_create(void (*start_func)(void *), void* arg)
{
 a1c:	55                   	push   %ebp
 a1d:	89 e5                	mov    %esp,%ebp
 a1f:	83 ec 18             	sub    $0x18,%esp
  uthread_p t = allocThread();
 a22:	e8 91 fe ff ff       	call   8b8 <allocThread>
 a27:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  asm("push %1;"  //stores the arguments to be used
 a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
 a2d:	8b 55 08             	mov    0x8(%ebp),%edx
 a30:	50                   	push   %eax
 a31:	52                   	push   %edx
 a32:	89 e2                	mov    %esp,%edx
      "push %2;"  //stores the start_func location
      "movl %%esp,%0;"
      : "=r" (t->esp)
 a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
int  
uthread_create(void (*start_func)(void *), void* arg)
{
  uthread_p t = allocThread();
  
  asm("push %1;"  //stores the arguments to be used
 a37:	89 50 04             	mov    %edx,0x4(%eax)
      "movl %%esp,%0;"
      : "=r" (t->esp)
      : "r" (arg) , "r"(start_func)
  );
  
  return t->tid;
 a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3d:	8b 00                	mov    (%eax),%eax
}
 a3f:	c9                   	leave  
 a40:	c3                   	ret    

00000a41 <uthread_exit>:

void 
uthread_exit()
{
 a41:	55                   	push   %ebp
 a42:	89 e5                	mov    %esp,%ebp
  //needs to be filled
}
 a44:	5d                   	pop    %ebp
 a45:	c3                   	ret    

00000a46 <uthread_yield>:

void 
uthread_yield()
{
 a46:	55                   	push   %ebp
 a47:	89 e5                	mov    %esp,%ebp
 a49:	83 ec 28             	sub    $0x28,%esp
  
  uthread_p oldt;
  uthread_p newt;
  int old=getRunningThread();
 a4c:	e8 eb fd ff ff       	call   83c <getRunningThread>
 a51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int new=getNextThread();
 a54:	e8 21 fe ff ff       	call   87a <getNextThread>
 a59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(old<0)
 a5c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a60:	79 19                	jns    a7b <uthread_yield+0x35>
  {
     printf(1,"Cant find running thread");
 a62:	c7 44 24 04 5c 0b 00 	movl   $0xb5c,0x4(%esp)
 a69:	00 
 a6a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a71:	e8 01 fa ff ff       	call   477 <printf>
    exit();
 a76:	e8 4d f8 ff ff       	call   2c8 <exit>
  }
  if(new<0)
 a7b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a7f:	79 19                	jns    a9a <uthread_yield+0x54>
  {
     printf(1,"Cant find runnable thread");
 a81:	c7 44 24 04 75 0b 00 	movl   $0xb75,0x4(%esp)
 a88:	00 
 a89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a90:	e8 e2 f9 ff ff       	call   477 <printf>
    exit();
 a95:	e8 2e f8 ff ff       	call   2c8 <exit>
  }
oldt=&tTable.table[old];
 a9a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a9d:	89 d0                	mov    %edx,%eax
 a9f:	01 c0                	add    %eax,%eax
 aa1:	01 d0                	add    %edx,%eax
 aa3:	c1 e0 03             	shl    $0x3,%eax
 aa6:	05 e0 0e 00 00       	add    $0xee0,%eax
 aab:	89 45 ec             	mov    %eax,-0x14(%ebp)
newt=&tTable.table[new];
 aae:	8b 55 f0             	mov    -0x10(%ebp),%edx
 ab1:	89 d0                	mov    %edx,%eax
 ab3:	01 c0                	add    %eax,%eax
 ab5:	01 d0                	add    %edx,%eax
 ab7:	c1 e0 03             	shl    $0x3,%eax
 aba:	05 e0 0e 00 00       	add    $0xee0,%eax
 abf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  
    asm("pusha");
 ac2:	60                   	pusha  
    STORE_ESP(oldt->esp);
 ac3:	89 e2                	mov    %esp,%edx
 ac5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ac8:	89 50 04             	mov    %edx,0x4(%eax)
    oldt->state=T_RUNNABLE;
 acb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ace:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
    LOAD_ESP(newt->esp);
 ad5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ad8:	8b 40 04             	mov    0x4(%eax),%eax
 adb:	89 c4                	mov    %eax,%esp
    
  
    newt->state=T_RUNNING;
 add:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ae0:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)

    asm("popa");
 ae7:	61                   	popa   
    if(oldt->firstTime==0)
 ae8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aeb:	8b 40 14             	mov    0x14(%eax),%eax
 aee:	85 c0                	test   %eax,%eax
 af0:	75 0b                	jne    afd <uthread_yield+0xb7>
    {
       asm("ret");////only firest time
 af2:	c3                   	ret    
       oldt->firstTime=1;
 af3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 af6:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }
   


}
 afd:	c9                   	leave  
 afe:	c3                   	ret    