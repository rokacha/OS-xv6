
_mkdir:     file format elf32-i386


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

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "Usage: mkdir files...\n");
   f:	c7 44 24 04 b0 0f 00 	movl   $0xfb0,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 74 04 00 00       	call   497 <printf>
    exit();
  23:	e8 c0 02 00 00       	call   2e8 <exit>
  }

  for(i = 1; i < argc; i++){
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 43                	jmp    75 <main+0x75>
    if(mkdir(argv[i]) < 0){
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	c1 e0 02             	shl    $0x2,%eax
  39:	03 45 0c             	add    0xc(%ebp),%eax
  3c:	8b 00                	mov    (%eax),%eax
  3e:	89 04 24             	mov    %eax,(%esp)
  41:	e8 0a 03 00 00       	call   350 <mkdir>
  46:	85 c0                	test   %eax,%eax
  48:	79 26                	jns    70 <main+0x70>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  4a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  4e:	c1 e0 02             	shl    $0x2,%eax
  51:	03 45 0c             	add    0xc(%ebp),%eax
  54:	8b 00                	mov    (%eax),%eax
  56:	89 44 24 08          	mov    %eax,0x8(%esp)
  5a:	c7 44 24 04 c7 0f 00 	movl   $0xfc7,0x4(%esp)
  61:	00 
  62:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  69:	e8 29 04 00 00       	call   497 <printf>
      break;
  6e:	eb 0e                	jmp    7e <main+0x7e>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  70:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  75:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  79:	3b 45 08             	cmp    0x8(%ebp),%eax
  7c:	7c b4                	jl     32 <main+0x32>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  7e:	e8 65 02 00 00       	call   2e8 <exit>
  83:	90                   	nop

00000084 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	57                   	push   %edi
  88:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  89:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8c:	8b 55 10             	mov    0x10(%ebp),%edx
  8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  92:	89 cb                	mov    %ecx,%ebx
  94:	89 df                	mov    %ebx,%edi
  96:	89 d1                	mov    %edx,%ecx
  98:	fc                   	cld    
  99:	f3 aa                	rep stos %al,%es:(%edi)
  9b:	89 ca                	mov    %ecx,%edx
  9d:	89 fb                	mov    %edi,%ebx
  9f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  a2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a5:	5b                   	pop    %ebx
  a6:	5f                   	pop    %edi
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    

000000a9 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
  a9:	55                   	push   %ebp
  aa:	89 e5                	mov    %esp,%ebp
  ac:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  af:	8b 45 08             	mov    0x8(%ebp),%eax
  b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  b5:	90                   	nop
  b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  b9:	0f b6 10             	movzbl (%eax),%edx
  bc:	8b 45 08             	mov    0x8(%ebp),%eax
  bf:	88 10                	mov    %dl,(%eax)
  c1:	8b 45 08             	mov    0x8(%ebp),%eax
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	84 c0                	test   %al,%al
  c9:	0f 95 c0             	setne  %al
  cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  d4:	84 c0                	test   %al,%al
  d6:	75 de                	jne    b6 <strcpy+0xd>
    ;
  return os;
  d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  db:	c9                   	leave  
  dc:	c3                   	ret    

000000dd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  dd:	55                   	push   %ebp
  de:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e0:	eb 08                	jmp    ea <strcmp+0xd>
    p++, q++;
  e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ea:	8b 45 08             	mov    0x8(%ebp),%eax
  ed:	0f b6 00             	movzbl (%eax),%eax
  f0:	84 c0                	test   %al,%al
  f2:	74 10                	je     104 <strcmp+0x27>
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	0f b6 10             	movzbl (%eax),%edx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	38 c2                	cmp    %al,%dl
 102:	74 de                	je     e2 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	0f b6 00             	movzbl (%eax),%eax
 10a:	0f b6 d0             	movzbl %al,%edx
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	0f b6 00             	movzbl (%eax),%eax
 113:	0f b6 c0             	movzbl %al,%eax
 116:	89 d1                	mov    %edx,%ecx
 118:	29 c1                	sub    %eax,%ecx
 11a:	89 c8                	mov    %ecx,%eax
}
 11c:	5d                   	pop    %ebp
 11d:	c3                   	ret    

0000011e <strlen>:

uint
strlen(char *s)
{
 11e:	55                   	push   %ebp
 11f:	89 e5                	mov    %esp,%ebp
 121:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 124:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 12b:	eb 04                	jmp    131 <strlen+0x13>
 12d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 131:	8b 45 fc             	mov    -0x4(%ebp),%eax
 134:	03 45 08             	add    0x8(%ebp),%eax
 137:	0f b6 00             	movzbl (%eax),%eax
 13a:	84 c0                	test   %al,%al
 13c:	75 ef                	jne    12d <strlen+0xf>
    ;
  return n;
 13e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 141:	c9                   	leave  
 142:	c3                   	ret    

00000143 <memset>:

void*
memset(void *dst, int c, uint n)
{
 143:	55                   	push   %ebp
 144:	89 e5                	mov    %esp,%ebp
 146:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 149:	8b 45 10             	mov    0x10(%ebp),%eax
 14c:	89 44 24 08          	mov    %eax,0x8(%esp)
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	89 44 24 04          	mov    %eax,0x4(%esp)
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	89 04 24             	mov    %eax,(%esp)
 15d:	e8 22 ff ff ff       	call   84 <stosb>
  return dst;
 162:	8b 45 08             	mov    0x8(%ebp),%eax
}
 165:	c9                   	leave  
 166:	c3                   	ret    

00000167 <strchr>:

char*
strchr(const char *s, char c)
{
 167:	55                   	push   %ebp
 168:	89 e5                	mov    %esp,%ebp
 16a:	83 ec 04             	sub    $0x4,%esp
 16d:	8b 45 0c             	mov    0xc(%ebp),%eax
 170:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 173:	eb 14                	jmp    189 <strchr+0x22>
    if(*s == c)
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	0f b6 00             	movzbl (%eax),%eax
 17b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 17e:	75 05                	jne    185 <strchr+0x1e>
      return (char*)s;
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	eb 13                	jmp    198 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 185:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	0f b6 00             	movzbl (%eax),%eax
 18f:	84 c0                	test   %al,%al
 191:	75 e2                	jne    175 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 193:	b8 00 00 00 00       	mov    $0x0,%eax
}
 198:	c9                   	leave  
 199:	c3                   	ret    

0000019a <gets>:

char*
gets(char *buf, int max)
{
 19a:	55                   	push   %ebp
 19b:	89 e5                	mov    %esp,%ebp
 19d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a7:	eb 44                	jmp    1ed <gets+0x53>
    cc = read(0, &c, 1);
 1a9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1b0:	00 
 1b1:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b4:	89 44 24 04          	mov    %eax,0x4(%esp)
 1b8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1bf:	e8 3c 01 00 00       	call   300 <read>
 1c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1cb:	7e 2d                	jle    1fa <gets+0x60>
      break;
    buf[i++] = c;
 1cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d0:	03 45 08             	add    0x8(%ebp),%eax
 1d3:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1d7:	88 10                	mov    %dl,(%eax)
 1d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 1dd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e1:	3c 0a                	cmp    $0xa,%al
 1e3:	74 16                	je     1fb <gets+0x61>
 1e5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e9:	3c 0d                	cmp    $0xd,%al
 1eb:	74 0e                	je     1fb <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f6:	7c b1                	jl     1a9 <gets+0xf>
 1f8:	eb 01                	jmp    1fb <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1fa:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1fe:	03 45 08             	add    0x8(%ebp),%eax
 201:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 204:	8b 45 08             	mov    0x8(%ebp),%eax
}
 207:	c9                   	leave  
 208:	c3                   	ret    

00000209 <stat>:

int
stat(char *n, struct stat *st)
{
 209:	55                   	push   %ebp
 20a:	89 e5                	mov    %esp,%ebp
 20c:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 216:	00 
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	89 04 24             	mov    %eax,(%esp)
 21d:	e8 06 01 00 00       	call   328 <open>
 222:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 225:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 229:	79 07                	jns    232 <stat+0x29>
    return -1;
 22b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 230:	eb 23                	jmp    255 <stat+0x4c>
  r = fstat(fd, st);
 232:	8b 45 0c             	mov    0xc(%ebp),%eax
 235:	89 44 24 04          	mov    %eax,0x4(%esp)
 239:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23c:	89 04 24             	mov    %eax,(%esp)
 23f:	e8 fc 00 00 00       	call   340 <fstat>
 244:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	89 04 24             	mov    %eax,(%esp)
 24d:	e8 be 00 00 00       	call   310 <close>
  return r;
 252:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 255:	c9                   	leave  
 256:	c3                   	ret    

00000257 <atoi>:

int
atoi(const char *s)
{
 257:	55                   	push   %ebp
 258:	89 e5                	mov    %esp,%ebp
 25a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 264:	eb 23                	jmp    289 <atoi+0x32>
    n = n*10 + *s++ - '0';
 266:	8b 55 fc             	mov    -0x4(%ebp),%edx
 269:	89 d0                	mov    %edx,%eax
 26b:	c1 e0 02             	shl    $0x2,%eax
 26e:	01 d0                	add    %edx,%eax
 270:	01 c0                	add    %eax,%eax
 272:	89 c2                	mov    %eax,%edx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	0f be c0             	movsbl %al,%eax
 27d:	01 d0                	add    %edx,%eax
 27f:	83 e8 30             	sub    $0x30,%eax
 282:	89 45 fc             	mov    %eax,-0x4(%ebp)
 285:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3c 2f                	cmp    $0x2f,%al
 291:	7e 0a                	jle    29d <atoi+0x46>
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 00             	movzbl (%eax),%eax
 299:	3c 39                	cmp    $0x39,%al
 29b:	7e c9                	jle    266 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a0:	c9                   	leave  
 2a1:	c3                   	ret    

000002a2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a2:	55                   	push   %ebp
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b4:	eb 13                	jmp    2c9 <memmove+0x27>
    *dst++ = *src++;
 2b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2b9:	0f b6 10             	movzbl (%eax),%edx
 2bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2bf:	88 10                	mov    %dl,(%eax)
 2c1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 2c5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2cd:	0f 9f c0             	setg   %al
 2d0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2d4:	84 c0                	test   %al,%al
 2d6:	75 de                	jne    2b6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2db:	c9                   	leave  
 2dc:	c3                   	ret    
 2dd:	90                   	nop
 2de:	90                   	nop
 2df:	90                   	nop

000002e0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2e0:	b8 01 00 00 00       	mov    $0x1,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <exit>:
SYSCALL(exit)
 2e8:	b8 02 00 00 00       	mov    $0x2,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <wait>:
SYSCALL(wait)
 2f0:	b8 03 00 00 00       	mov    $0x3,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <pipe>:
SYSCALL(pipe)
 2f8:	b8 04 00 00 00       	mov    $0x4,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <read>:
SYSCALL(read)
 300:	b8 05 00 00 00       	mov    $0x5,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <write>:
SYSCALL(write)
 308:	b8 10 00 00 00       	mov    $0x10,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <close>:
SYSCALL(close)
 310:	b8 15 00 00 00       	mov    $0x15,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <kill>:
SYSCALL(kill)
 318:	b8 06 00 00 00       	mov    $0x6,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <exec>:
SYSCALL(exec)
 320:	b8 07 00 00 00       	mov    $0x7,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <open>:
SYSCALL(open)
 328:	b8 0f 00 00 00       	mov    $0xf,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mknod>:
SYSCALL(mknod)
 330:	b8 11 00 00 00       	mov    $0x11,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <unlink>:
SYSCALL(unlink)
 338:	b8 12 00 00 00       	mov    $0x12,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <fstat>:
SYSCALL(fstat)
 340:	b8 08 00 00 00       	mov    $0x8,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <link>:
SYSCALL(link)
 348:	b8 13 00 00 00       	mov    $0x13,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <mkdir>:
SYSCALL(mkdir)
 350:	b8 14 00 00 00       	mov    $0x14,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <chdir>:
SYSCALL(chdir)
 358:	b8 09 00 00 00       	mov    $0x9,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <dup>:
SYSCALL(dup)
 360:	b8 0a 00 00 00       	mov    $0xa,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <getpid>:
SYSCALL(getpid)
 368:	b8 0b 00 00 00       	mov    $0xb,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <sbrk>:
SYSCALL(sbrk)
 370:	b8 0c 00 00 00       	mov    $0xc,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <sleep>:
SYSCALL(sleep)
 378:	b8 0d 00 00 00       	mov    $0xd,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <uptime>:
SYSCALL(uptime)
 380:	b8 0e 00 00 00       	mov    $0xe,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <add_path>:
SYSCALL(add_path)
 388:	b8 16 00 00 00       	mov    $0x16,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <wait2>:
SYSCALL(wait2)
 390:	b8 17 00 00 00       	mov    $0x17,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <getquanta>:
SYSCALL(getquanta)
 398:	b8 18 00 00 00       	mov    $0x18,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <getqueue>:
SYSCALL(getqueue)
 3a0:	b8 19 00 00 00       	mov    $0x19,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <signal>:
SYSCALL(signal)
 3a8:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <sigsend>:
SYSCALL(sigsend)
 3b0:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <alarm>:
SYSCALL(alarm)
 3b8:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 28             	sub    $0x28,%esp
 3c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d3:	00 
 3d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3db:	8b 45 08             	mov    0x8(%ebp),%eax
 3de:	89 04 24             	mov    %eax,(%esp)
 3e1:	e8 22 ff ff ff       	call   308 <write>
}
 3e6:	c9                   	leave  
 3e7:	c3                   	ret    

000003e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3f9:	74 17                	je     412 <printint+0x2a>
 3fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3ff:	79 11                	jns    412 <printint+0x2a>
    neg = 1;
 401:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 408:	8b 45 0c             	mov    0xc(%ebp),%eax
 40b:	f7 d8                	neg    %eax
 40d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 410:	eb 06                	jmp    418 <printint+0x30>
  } else {
    x = xx;
 412:	8b 45 0c             	mov    0xc(%ebp),%eax
 415:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 418:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 41f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 422:	8b 45 ec             	mov    -0x14(%ebp),%eax
 425:	ba 00 00 00 00       	mov    $0x0,%edx
 42a:	f7 f1                	div    %ecx
 42c:	89 d0                	mov    %edx,%eax
 42e:	0f b6 90 dc 14 00 00 	movzbl 0x14dc(%eax),%edx
 435:	8d 45 dc             	lea    -0x24(%ebp),%eax
 438:	03 45 f4             	add    -0xc(%ebp),%eax
 43b:	88 10                	mov    %dl,(%eax)
 43d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 441:	8b 55 10             	mov    0x10(%ebp),%edx
 444:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 447:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44a:	ba 00 00 00 00       	mov    $0x0,%edx
 44f:	f7 75 d4             	divl   -0x2c(%ebp)
 452:	89 45 ec             	mov    %eax,-0x14(%ebp)
 455:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 459:	75 c4                	jne    41f <printint+0x37>
  if(neg)
 45b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45f:	74 2a                	je     48b <printint+0xa3>
    buf[i++] = '-';
 461:	8d 45 dc             	lea    -0x24(%ebp),%eax
 464:	03 45 f4             	add    -0xc(%ebp),%eax
 467:	c6 00 2d             	movb   $0x2d,(%eax)
 46a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 46e:	eb 1b                	jmp    48b <printint+0xa3>
    putc(fd, buf[i]);
 470:	8d 45 dc             	lea    -0x24(%ebp),%eax
 473:	03 45 f4             	add    -0xc(%ebp),%eax
 476:	0f b6 00             	movzbl (%eax),%eax
 479:	0f be c0             	movsbl %al,%eax
 47c:	89 44 24 04          	mov    %eax,0x4(%esp)
 480:	8b 45 08             	mov    0x8(%ebp),%eax
 483:	89 04 24             	mov    %eax,(%esp)
 486:	e8 35 ff ff ff       	call   3c0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 48b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 48f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 493:	79 db                	jns    470 <printint+0x88>
    putc(fd, buf[i]);
}
 495:	c9                   	leave  
 496:	c3                   	ret    

00000497 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 497:	55                   	push   %ebp
 498:	89 e5                	mov    %esp,%ebp
 49a:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 49d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4a4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4a7:	83 c0 04             	add    $0x4,%eax
 4aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4ad:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4b4:	e9 7d 01 00 00       	jmp    636 <printf+0x19f>
    c = fmt[i] & 0xff;
 4b9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4bf:	01 d0                	add    %edx,%eax
 4c1:	0f b6 00             	movzbl (%eax),%eax
 4c4:	0f be c0             	movsbl %al,%eax
 4c7:	25 ff 00 00 00       	and    $0xff,%eax
 4cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d3:	75 2c                	jne    501 <printf+0x6a>
      if(c == '%'){
 4d5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4d9:	75 0c                	jne    4e7 <printf+0x50>
        state = '%';
 4db:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4e2:	e9 4b 01 00 00       	jmp    632 <printf+0x19b>
      } else {
        putc(fd, c);
 4e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ea:	0f be c0             	movsbl %al,%eax
 4ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f1:	8b 45 08             	mov    0x8(%ebp),%eax
 4f4:	89 04 24             	mov    %eax,(%esp)
 4f7:	e8 c4 fe ff ff       	call   3c0 <putc>
 4fc:	e9 31 01 00 00       	jmp    632 <printf+0x19b>
      }
    } else if(state == '%'){
 501:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 505:	0f 85 27 01 00 00    	jne    632 <printf+0x19b>
      if(c == 'd'){
 50b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 50f:	75 2d                	jne    53e <printf+0xa7>
        printint(fd, *ap, 10, 1);
 511:	8b 45 e8             	mov    -0x18(%ebp),%eax
 514:	8b 00                	mov    (%eax),%eax
 516:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 51d:	00 
 51e:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 525:	00 
 526:	89 44 24 04          	mov    %eax,0x4(%esp)
 52a:	8b 45 08             	mov    0x8(%ebp),%eax
 52d:	89 04 24             	mov    %eax,(%esp)
 530:	e8 b3 fe ff ff       	call   3e8 <printint>
        ap++;
 535:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 539:	e9 ed 00 00 00       	jmp    62b <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 53e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 542:	74 06                	je     54a <printf+0xb3>
 544:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 548:	75 2d                	jne    577 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 54a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54d:	8b 00                	mov    (%eax),%eax
 54f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 556:	00 
 557:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 55e:	00 
 55f:	89 44 24 04          	mov    %eax,0x4(%esp)
 563:	8b 45 08             	mov    0x8(%ebp),%eax
 566:	89 04 24             	mov    %eax,(%esp)
 569:	e8 7a fe ff ff       	call   3e8 <printint>
        ap++;
 56e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 572:	e9 b4 00 00 00       	jmp    62b <printf+0x194>
      } else if(c == 's'){
 577:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 57b:	75 46                	jne    5c3 <printf+0x12c>
        s = (char*)*ap;
 57d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 580:	8b 00                	mov    (%eax),%eax
 582:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 585:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 589:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58d:	75 27                	jne    5b6 <printf+0x11f>
          s = "(null)";
 58f:	c7 45 f4 e3 0f 00 00 	movl   $0xfe3,-0xc(%ebp)
        while(*s != 0){
 596:	eb 1e                	jmp    5b6 <printf+0x11f>
          putc(fd, *s);
 598:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59b:	0f b6 00             	movzbl (%eax),%eax
 59e:	0f be c0             	movsbl %al,%eax
 5a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	89 04 24             	mov    %eax,(%esp)
 5ab:	e8 10 fe ff ff       	call   3c0 <putc>
          s++;
 5b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5b4:	eb 01                	jmp    5b7 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b6:	90                   	nop
 5b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ba:	0f b6 00             	movzbl (%eax),%eax
 5bd:	84 c0                	test   %al,%al
 5bf:	75 d7                	jne    598 <printf+0x101>
 5c1:	eb 68                	jmp    62b <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c7:	75 1d                	jne    5e6 <printf+0x14f>
        putc(fd, *ap);
 5c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cc:	8b 00                	mov    (%eax),%eax
 5ce:	0f be c0             	movsbl %al,%eax
 5d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d5:	8b 45 08             	mov    0x8(%ebp),%eax
 5d8:	89 04 24             	mov    %eax,(%esp)
 5db:	e8 e0 fd ff ff       	call   3c0 <putc>
        ap++;
 5e0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e4:	eb 45                	jmp    62b <printf+0x194>
      } else if(c == '%'){
 5e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ea:	75 17                	jne    603 <printf+0x16c>
        putc(fd, c);
 5ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ef:	0f be c0             	movsbl %al,%eax
 5f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f6:	8b 45 08             	mov    0x8(%ebp),%eax
 5f9:	89 04 24             	mov    %eax,(%esp)
 5fc:	e8 bf fd ff ff       	call   3c0 <putc>
 601:	eb 28                	jmp    62b <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 603:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 60a:	00 
 60b:	8b 45 08             	mov    0x8(%ebp),%eax
 60e:	89 04 24             	mov    %eax,(%esp)
 611:	e8 aa fd ff ff       	call   3c0 <putc>
        putc(fd, c);
 616:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 619:	0f be c0             	movsbl %al,%eax
 61c:	89 44 24 04          	mov    %eax,0x4(%esp)
 620:	8b 45 08             	mov    0x8(%ebp),%eax
 623:	89 04 24             	mov    %eax,(%esp)
 626:	e8 95 fd ff ff       	call   3c0 <putc>
      }
      state = 0;
 62b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 632:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 636:	8b 55 0c             	mov    0xc(%ebp),%edx
 639:	8b 45 f0             	mov    -0x10(%ebp),%eax
 63c:	01 d0                	add    %edx,%eax
 63e:	0f b6 00             	movzbl (%eax),%eax
 641:	84 c0                	test   %al,%al
 643:	0f 85 70 fe ff ff    	jne    4b9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 649:	c9                   	leave  
 64a:	c3                   	ret    
 64b:	90                   	nop

0000064c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 64c:	55                   	push   %ebp
 64d:	89 e5                	mov    %esp,%ebp
 64f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 652:	8b 45 08             	mov    0x8(%ebp),%eax
 655:	83 e8 08             	sub    $0x8,%eax
 658:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65b:	a1 08 15 00 00       	mov    0x1508,%eax
 660:	89 45 fc             	mov    %eax,-0x4(%ebp)
 663:	eb 24                	jmp    689 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66d:	77 12                	ja     681 <free+0x35>
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 24                	ja     69b <free+0x4f>
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67f:	77 1a                	ja     69b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	89 45 fc             	mov    %eax,-0x4(%ebp)
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68f:	76 d4                	jbe    665 <free+0x19>
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 699:	76 ca                	jbe    665 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	8b 40 04             	mov    0x4(%eax),%eax
 6a1:	c1 e0 03             	shl    $0x3,%eax
 6a4:	89 c2                	mov    %eax,%edx
 6a6:	03 55 f8             	add    -0x8(%ebp),%edx
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	39 c2                	cmp    %eax,%edx
 6b0:	75 24                	jne    6d6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b5:	8b 50 04             	mov    0x4(%eax),%edx
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	8b 00                	mov    (%eax),%eax
 6bd:	8b 40 04             	mov    0x4(%eax),%eax
 6c0:	01 c2                	add    %eax,%edx
 6c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	8b 10                	mov    (%eax),%edx
 6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d2:	89 10                	mov    %edx,(%eax)
 6d4:	eb 0a                	jmp    6e0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	8b 40 04             	mov    0x4(%eax),%eax
 6e6:	c1 e0 03             	shl    $0x3,%eax
 6e9:	03 45 fc             	add    -0x4(%ebp),%eax
 6ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ef:	75 20                	jne    711 <free+0xc5>
    p->s.size += bp->s.size;
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	8b 50 04             	mov    0x4(%eax),%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	01 c2                	add    %eax,%edx
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 705:	8b 45 f8             	mov    -0x8(%ebp),%eax
 708:	8b 10                	mov    (%eax),%edx
 70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70d:	89 10                	mov    %edx,(%eax)
 70f:	eb 08                	jmp    719 <free+0xcd>
  } else
    p->s.ptr = bp;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 55 f8             	mov    -0x8(%ebp),%edx
 717:	89 10                	mov    %edx,(%eax)
  freep = p;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	a3 08 15 00 00       	mov    %eax,0x1508
}
 721:	c9                   	leave  
 722:	c3                   	ret    

00000723 <morecore>:

static Header*
morecore(uint nu)
{
 723:	55                   	push   %ebp
 724:	89 e5                	mov    %esp,%ebp
 726:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 729:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 730:	77 07                	ja     739 <morecore+0x16>
    nu = 4096;
 732:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 739:	8b 45 08             	mov    0x8(%ebp),%eax
 73c:	c1 e0 03             	shl    $0x3,%eax
 73f:	89 04 24             	mov    %eax,(%esp)
 742:	e8 29 fc ff ff       	call   370 <sbrk>
 747:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 74a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74e:	75 07                	jne    757 <morecore+0x34>
    return 0;
 750:	b8 00 00 00 00       	mov    $0x0,%eax
 755:	eb 22                	jmp    779 <morecore+0x56>
  hp = (Header*)p;
 757:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 760:	8b 55 08             	mov    0x8(%ebp),%edx
 763:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 766:	8b 45 f0             	mov    -0x10(%ebp),%eax
 769:	83 c0 08             	add    $0x8,%eax
 76c:	89 04 24             	mov    %eax,(%esp)
 76f:	e8 d8 fe ff ff       	call   64c <free>
  return freep;
 774:	a1 08 15 00 00       	mov    0x1508,%eax
}
 779:	c9                   	leave  
 77a:	c3                   	ret    

0000077b <malloc>:

void*
malloc(uint nbytes)
{
 77b:	55                   	push   %ebp
 77c:	89 e5                	mov    %esp,%ebp
 77e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 781:	8b 45 08             	mov    0x8(%ebp),%eax
 784:	83 c0 07             	add    $0x7,%eax
 787:	c1 e8 03             	shr    $0x3,%eax
 78a:	83 c0 01             	add    $0x1,%eax
 78d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 790:	a1 08 15 00 00       	mov    0x1508,%eax
 795:	89 45 f0             	mov    %eax,-0x10(%ebp)
 798:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79c:	75 23                	jne    7c1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79e:	c7 45 f0 00 15 00 00 	movl   $0x1500,-0x10(%ebp)
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	a3 08 15 00 00       	mov    %eax,0x1508
 7ad:	a1 08 15 00 00       	mov    0x1508,%eax
 7b2:	a3 00 15 00 00       	mov    %eax,0x1500
    base.s.size = 0;
 7b7:	c7 05 04 15 00 00 00 	movl   $0x0,0x1504
 7be:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c4:	8b 00                	mov    (%eax),%eax
 7c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cc:	8b 40 04             	mov    0x4(%eax),%eax
 7cf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d2:	72 4d                	jb     821 <malloc+0xa6>
      if(p->s.size == nunits)
 7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d7:	8b 40 04             	mov    0x4(%eax),%eax
 7da:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7dd:	75 0c                	jne    7eb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e2:	8b 10                	mov    (%eax),%edx
 7e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e7:	89 10                	mov    %edx,(%eax)
 7e9:	eb 26                	jmp    811 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ee:	8b 40 04             	mov    0x4(%eax),%eax
 7f1:	89 c2                	mov    %eax,%edx
 7f3:	2b 55 ec             	sub    -0x14(%ebp),%edx
 7f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 40 04             	mov    0x4(%eax),%eax
 802:	c1 e0 03             	shl    $0x3,%eax
 805:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 811:	8b 45 f0             	mov    -0x10(%ebp),%eax
 814:	a3 08 15 00 00       	mov    %eax,0x1508
      return (void*)(p + 1);
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	83 c0 08             	add    $0x8,%eax
 81f:	eb 38                	jmp    859 <malloc+0xde>
    }
    if(p == freep)
 821:	a1 08 15 00 00       	mov    0x1508,%eax
 826:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 829:	75 1b                	jne    846 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 82b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 82e:	89 04 24             	mov    %eax,(%esp)
 831:	e8 ed fe ff ff       	call   723 <morecore>
 836:	89 45 f4             	mov    %eax,-0xc(%ebp)
 839:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 83d:	75 07                	jne    846 <malloc+0xcb>
        return 0;
 83f:	b8 00 00 00 00       	mov    $0x0,%eax
 844:	eb 13                	jmp    859 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
 849:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84f:	8b 00                	mov    (%eax),%eax
 851:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 854:	e9 70 ff ff ff       	jmp    7c9 <malloc+0x4e>
}
 859:	c9                   	leave  
 85a:	c3                   	ret    
 85b:	90                   	nop

0000085c <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
 85c:	55                   	push   %ebp
 85d:	89 e5                	mov    %esp,%ebp
 85f:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
 862:	a1 20 5e 00 00       	mov    0x5e20,%eax
 867:	8b 40 04             	mov    0x4(%eax),%eax
 86a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
 86d:	a1 20 5e 00 00       	mov    0x5e20,%eax
 872:	8b 00                	mov    (%eax),%eax
 874:	89 44 24 08          	mov    %eax,0x8(%esp)
 878:	c7 44 24 04 ec 0f 00 	movl   $0xfec,0x4(%esp)
 87f:	00 
 880:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 887:	e8 0b fc ff ff       	call   497 <printf>
  while((newesp < (int *)currentThread->ebp))
 88c:	eb 3c                	jmp    8ca <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
 88e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 891:	89 44 24 08          	mov    %eax,0x8(%esp)
 895:	c7 44 24 04 02 10 00 	movl   $0x1002,0x4(%esp)
 89c:	00 
 89d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8a4:	e8 ee fb ff ff       	call   497 <printf>
      printf(1,"val:%x\n",*newesp);
 8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ac:	8b 00                	mov    (%eax),%eax
 8ae:	89 44 24 08          	mov    %eax,0x8(%esp)
 8b2:	c7 44 24 04 0a 10 00 	movl   $0x100a,0x4(%esp)
 8b9:	00 
 8ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8c1:	e8 d1 fb ff ff       	call   497 <printf>
    newesp++;
 8c6:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
 8ca:	a1 20 5e 00 00       	mov    0x5e20,%eax
 8cf:	8b 40 08             	mov    0x8(%eax),%eax
 8d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 8d5:	77 b7                	ja     88e <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
 8d7:	c9                   	leave  
 8d8:	c3                   	ret    

000008d9 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
 8d9:	55                   	push   %ebp
 8da:	89 e5                	mov    %esp,%ebp
 8dc:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
 8df:	8b 45 08             	mov    0x8(%ebp),%eax
 8e2:	83 c0 01             	add    $0x1,%eax
 8e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
 8e8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 8ec:	75 07                	jne    8f5 <getNextThread+0x1c>
    i=0;
 8ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
 8f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 8fe:	05 20 15 00 00       	add    $0x1520,%eax
 903:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
 906:	eb 3b                	jmp    943 <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
 908:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90b:	8b 40 10             	mov    0x10(%eax),%eax
 90e:	83 f8 03             	cmp    $0x3,%eax
 911:	75 05                	jne    918 <getNextThread+0x3f>
      return i;
 913:	8b 45 fc             	mov    -0x4(%ebp),%eax
 916:	eb 38                	jmp    950 <getNextThread+0x77>
    i++;
 918:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
 91c:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
 920:	75 1a                	jne    93c <getNextThread+0x63>
    {
     i=0;
 922:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
 929:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 932:	05 20 15 00 00       	add    $0x1520,%eax
 937:	89 45 f8             	mov    %eax,-0x8(%ebp)
 93a:	eb 07                	jmp    943 <getNextThread+0x6a>
   }
   else
    t++;
 93c:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
 943:	8b 45 fc             	mov    -0x4(%ebp),%eax
 946:	3b 45 08             	cmp    0x8(%ebp),%eax
 949:	75 bd                	jne    908 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
 94b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 950:	c9                   	leave  
 951:	c3                   	ret    

00000952 <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
 952:	55                   	push   %ebp
 953:	89 e5                	mov    %esp,%ebp
 955:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 958:	c7 45 ec 20 15 00 00 	movl   $0x1520,-0x14(%ebp)
 95f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 966:	eb 15                	jmp    97d <allocThread+0x2b>
  {
    if(t->state==T_FREE)
 968:	8b 45 ec             	mov    -0x14(%ebp),%eax
 96b:	8b 40 10             	mov    0x10(%eax),%eax
 96e:	85 c0                	test   %eax,%eax
 970:	74 1e                	je     990 <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
 972:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
 979:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 97d:	81 7d ec 20 5e 00 00 	cmpl   $0x5e20,-0x14(%ebp)
 984:	72 e2                	jb     968 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
 986:	b8 00 00 00 00       	mov    $0x0,%eax
 98b:	e9 a3 00 00 00       	jmp    a33 <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
 990:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
 991:	8b 45 ec             	mov    -0x14(%ebp),%eax
 994:	8b 55 f4             	mov    -0xc(%ebp),%edx
 997:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
 999:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99d:	75 1c                	jne    9bb <allocThread+0x69>
  {
    STORE_ESP(t->esp);
 99f:	89 e2                	mov    %esp,%edx
 9a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9a4:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
 9a7:	89 ea                	mov    %ebp,%edx
 9a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9ac:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
 9af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9b2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
 9b9:	eb 3b                	jmp    9f6 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
 9bb:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
 9c2:	e8 b4 fd ff ff       	call   77b <malloc>
 9c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 9ca:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
 9cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9d0:	8b 40 0c             	mov    0xc(%eax),%eax
 9d3:	05 00 10 00 00       	add    $0x1000,%eax
 9d8:	89 c2                	mov    %eax,%edx
 9da:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9dd:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
 9e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9e3:	8b 50 08             	mov    0x8(%eax),%edx
 9e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9e9:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
 9ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9ef:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
 9f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9f9:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
 a00:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
 a03:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 a0a:	eb 14                	jmp    a20 <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
 a0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a0f:	8b 55 f0             	mov    -0x10(%ebp),%edx
 a12:	83 c2 08             	add    $0x8,%edx
 a15:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
 a1c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 a20:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
 a24:	7e e6                	jle    a0c <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
 a26:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a29:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
 a30:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
 a33:	c9                   	leave  
 a34:	c3                   	ret    

00000a35 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
 a35:	55                   	push   %ebp
 a36:	89 e5                	mov    %esp,%ebp
 a38:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 a3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a42:	eb 18                	jmp    a5c <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
 a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a47:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 a4d:	05 30 15 00 00       	add    $0x1530,%eax
 a52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
 a58:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 a5c:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 a60:	7e e2                	jle    a44 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
 a62:	e8 eb fe ff ff       	call   952 <allocThread>
 a67:	a3 20 5e 00 00       	mov    %eax,0x5e20
  if(currentThread==0)
 a6c:	a1 20 5e 00 00       	mov    0x5e20,%eax
 a71:	85 c0                	test   %eax,%eax
 a73:	75 07                	jne    a7c <uthread_init+0x47>
    return -1;
 a75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a7a:	eb 6b                	jmp    ae7 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
 a7c:	a1 20 5e 00 00       	mov    0x5e20,%eax
 a81:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
 a88:	c7 44 24 04 6f 0d 00 	movl   $0xd6f,0x4(%esp)
 a8f:	00 
 a90:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
 a97:	e8 0c f9 ff ff       	call   3a8 <signal>
 a9c:	85 c0                	test   %eax,%eax
 a9e:	79 19                	jns    ab9 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
 aa0:	c7 44 24 04 14 10 00 	movl   $0x1014,0x4(%esp)
 aa7:	00 
 aa8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 aaf:	e8 e3 f9 ff ff       	call   497 <printf>
    exit();
 ab4:	e8 2f f8 ff ff       	call   2e8 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
 ab9:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 ac0:	e8 f3 f8 ff ff       	call   3b8 <alarm>
 ac5:	85 c0                	test   %eax,%eax
 ac7:	79 19                	jns    ae2 <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
 ac9:	c7 44 24 04 34 10 00 	movl   $0x1034,0x4(%esp)
 ad0:	00 
 ad1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ad8:	e8 ba f9 ff ff       	call   497 <printf>
    exit();
 add:	e8 06 f8 ff ff       	call   2e8 <exit>
  }
  return 0;
 ae2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ae7:	c9                   	leave  
 ae8:	c3                   	ret    

00000ae9 <wrap_func>:

void
wrap_func()
{
 ae9:	55                   	push   %ebp
 aea:	89 e5                	mov    %esp,%ebp
 aec:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
 aef:	a1 20 5e 00 00       	mov    0x5e20,%eax
 af4:	8b 50 18             	mov    0x18(%eax),%edx
 af7:	a1 20 5e 00 00       	mov    0x5e20,%eax
 afc:	8b 40 1c             	mov    0x1c(%eax),%eax
 aff:	89 04 24             	mov    %eax,(%esp)
 b02:	ff d2                	call   *%edx
  uthread_exit();
 b04:	e8 6c 00 00 00       	call   b75 <uthread_exit>
}
 b09:	c9                   	leave  
 b0a:	c3                   	ret    

00000b0b <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
 b0b:	55                   	push   %ebp
 b0c:	89 e5                	mov    %esp,%ebp
 b0e:	53                   	push   %ebx
 b0f:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
 b12:	e8 3b fe ff ff       	call   952 <allocThread>
 b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
 b1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b1e:	75 07                	jne    b27 <uthread_create+0x1c>
    return -1;
 b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b25:	eb 48                	jmp    b6f <uthread_create+0x64>

  t->func=start_func;
 b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2a:	8b 55 08             	mov    0x8(%ebp),%edx
 b2d:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
 b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b33:	8b 55 0c             	mov    0xc(%ebp),%edx
 b36:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
 b39:	89 e3                	mov    %esp,%ebx
 b3b:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
 b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b41:	8b 40 04             	mov    0x4(%eax),%eax
 b44:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
 b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b49:	8b 50 08             	mov    0x8(%eax),%edx
 b4c:	b8 e9 0a 00 00       	mov    $0xae9,%eax
 b51:	50                   	push   %eax
 b52:	52                   	push   %edx
 b53:	89 e2                	mov    %esp,%edx
 b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b58:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
 b5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b5e:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
 b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b63:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
 b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6d:	8b 00                	mov    (%eax),%eax
}
 b6f:	83 c4 14             	add    $0x14,%esp
 b72:	5b                   	pop    %ebx
 b73:	5d                   	pop    %ebp
 b74:	c3                   	ret    

00000b75 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
 b75:	55                   	push   %ebp
 b76:	89 e5                	mov    %esp,%ebp
 b78:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 b7b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 b82:	e8 31 f8 ff ff       	call   3b8 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 b87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 b8e:	eb 51                	jmp    be1 <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
 b90:	a1 20 5e 00 00       	mov    0x5e20,%eax
 b95:	8b 55 f4             	mov    -0xc(%ebp),%edx
 b98:	83 c2 08             	add    $0x8,%edx
 b9b:	8b 04 90             	mov    (%eax,%edx,4),%eax
 b9e:	83 f8 01             	cmp    $0x1,%eax
 ba1:	75 3a                	jne    bdd <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
 ba3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ba6:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 bac:	05 40 16 00 00       	add    $0x1640,%eax
 bb1:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
 bb7:	a1 20 5e 00 00       	mov    0x5e20,%eax
 bbc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 bbf:	83 c2 08             	add    $0x8,%edx
 bc2:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
 bc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bcc:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 bd2:	05 30 15 00 00       	add    $0x1530,%eax
 bd7:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
 bdd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 be1:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
 be5:	7e a9                	jle    b90 <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
 be7:	a1 20 5e 00 00       	mov    0x5e20,%eax
 bec:	8b 00                	mov    (%eax),%eax
 bee:	89 04 24             	mov    %eax,(%esp)
 bf1:	e8 e3 fc ff ff       	call   8d9 <getNextThread>
 bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
 bf9:	a1 20 5e 00 00       	mov    0x5e20,%eax
 bfe:	8b 00                	mov    (%eax),%eax
 c00:	85 c0                	test   %eax,%eax
 c02:	74 10                	je     c14 <uthread_exit+0x9f>
    free(currentThread->stack);
 c04:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c09:	8b 40 0c             	mov    0xc(%eax),%eax
 c0c:	89 04 24             	mov    %eax,(%esp)
 c0f:	e8 38 fa ff ff       	call   64c <free>
  currentThread->tid=-1;
 c14:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c19:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
 c1f:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c24:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
 c2b:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c30:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
 c37:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c3c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
 c43:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c48:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
 c4f:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c54:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
 c5b:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c60:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
 c67:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c6c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
 c73:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 c77:	78 7a                	js     cf3 <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
 c79:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c7c:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 c82:	05 20 15 00 00       	add    $0x1520,%eax
 c87:	a3 20 5e 00 00       	mov    %eax,0x5e20
    currentThread->state=T_RUNNING;
 c8c:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c91:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
 c98:	a1 20 5e 00 00       	mov    0x5e20,%eax
 c9d:	8b 40 04             	mov    0x4(%eax),%eax
 ca0:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 ca2:	a1 20 5e 00 00       	mov    0x5e20,%eax
 ca7:	8b 40 08             	mov    0x8(%eax),%eax
 caa:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
 cac:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 cb3:	e8 00 f7 ff ff       	call   3b8 <alarm>
 cb8:	85 c0                	test   %eax,%eax
 cba:	79 19                	jns    cd5 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
 cbc:	c7 44 24 04 34 10 00 	movl   $0x1034,0x4(%esp)
 cc3:	00 
 cc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 ccb:	e8 c7 f7 ff ff       	call   497 <printf>
      exit();
 cd0:	e8 13 f6 ff ff       	call   2e8 <exit>
    }
    
    if(currentThread->firstTime==1)
 cd5:	a1 20 5e 00 00       	mov    0x5e20,%eax
 cda:	8b 40 14             	mov    0x14(%eax),%eax
 cdd:	83 f8 01             	cmp    $0x1,%eax
 ce0:	75 10                	jne    cf2 <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
 ce2:	a1 20 5e 00 00       	mov    0x5e20,%eax
 ce7:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
 cee:	5d                   	pop    %ebp
 cef:	c3                   	ret    
 cf0:	eb 01                	jmp    cf3 <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
 cf2:	61                   	popa   
    }
  }
}
 cf3:	c9                   	leave  
 cf4:	c3                   	ret    

00000cf5 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
 cf5:	55                   	push   %ebp
 cf6:	89 e5                	mov    %esp,%ebp
 cf8:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
 cfb:	8b 45 08             	mov    0x8(%ebp),%eax
 cfe:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 d04:	05 20 15 00 00       	add    $0x1520,%eax
 d09:	8b 40 10             	mov    0x10(%eax),%eax
 d0c:	85 c0                	test   %eax,%eax
 d0e:	75 07                	jne    d17 <uthread_join+0x22>
    return -1;
 d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d15:	eb 56                	jmp    d6d <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
 d17:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d1e:	e8 95 f6 ff ff       	call   3b8 <alarm>
    currentThread->waitingFor=tid;
 d23:	a1 20 5e 00 00       	mov    0x5e20,%eax
 d28:	8b 55 08             	mov    0x8(%ebp),%edx
 d2b:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
 d31:	a1 20 5e 00 00       	mov    0x5e20,%eax
 d36:	8b 08                	mov    (%eax),%ecx
 d38:	8b 55 08             	mov    0x8(%ebp),%edx
 d3b:	89 d0                	mov    %edx,%eax
 d3d:	c1 e0 03             	shl    $0x3,%eax
 d40:	01 d0                	add    %edx,%eax
 d42:	c1 e0 03             	shl    $0x3,%eax
 d45:	01 d0                	add    %edx,%eax
 d47:	01 c8                	add    %ecx,%eax
 d49:	83 c0 08             	add    $0x8,%eax
 d4c:	c7 04 85 20 15 00 00 	movl   $0x1,0x1520(,%eax,4)
 d53:	01 00 00 00 
    currentThread->state=T_SLEEPING;
 d57:	a1 20 5e 00 00       	mov    0x5e20,%eax
 d5c:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
 d63:	e8 07 00 00 00       	call   d6f <uthread_yield>
    return 1;
 d68:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
 d6d:	c9                   	leave  
 d6e:	c3                   	ret    

00000d6f <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
 d6f:	55                   	push   %ebp
 d70:	89 e5                	mov    %esp,%ebp
 d72:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
 d75:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 d7c:	e8 37 f6 ff ff       	call   3b8 <alarm>
  int new=getNextThread(currentThread->tid);
 d81:	a1 20 5e 00 00       	mov    0x5e20,%eax
 d86:	8b 00                	mov    (%eax),%eax
 d88:	89 04 24             	mov    %eax,(%esp)
 d8b:	e8 49 fb ff ff       	call   8d9 <getNextThread>
 d90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
 d93:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 d97:	75 2d                	jne    dc6 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
 d99:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 da0:	e8 13 f6 ff ff       	call   3b8 <alarm>
 da5:	85 c0                	test   %eax,%eax
 da7:	0f 89 c1 00 00 00    	jns    e6e <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
 dad:	c7 44 24 04 54 10 00 	movl   $0x1054,0x4(%esp)
 db4:	00 
 db5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 dbc:	e8 d6 f6 ff ff       	call   497 <printf>
      exit();
 dc1:	e8 22 f5 ff ff       	call   2e8 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
 dc6:	60                   	pusha  
    STORE_ESP(currentThread->esp);
 dc7:	a1 20 5e 00 00       	mov    0x5e20,%eax
 dcc:	89 e2                	mov    %esp,%edx
 dce:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
 dd1:	a1 20 5e 00 00       	mov    0x5e20,%eax
 dd6:	89 ea                	mov    %ebp,%edx
 dd8:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
 ddb:	a1 20 5e 00 00       	mov    0x5e20,%eax
 de0:	8b 40 10             	mov    0x10(%eax),%eax
 de3:	83 f8 02             	cmp    $0x2,%eax
 de6:	75 0c                	jne    df4 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
 de8:	a1 20 5e 00 00       	mov    0x5e20,%eax
 ded:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
 df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 df7:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
 dfd:	05 20 15 00 00       	add    $0x1520,%eax
 e02:	a3 20 5e 00 00       	mov    %eax,0x5e20

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
 e07:	a1 20 5e 00 00       	mov    0x5e20,%eax
 e0c:	8b 40 04             	mov    0x4(%eax),%eax
 e0f:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
 e11:	a1 20 5e 00 00       	mov    0x5e20,%eax
 e16:	8b 40 08             	mov    0x8(%eax),%eax
 e19:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
 e1b:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
 e22:	e8 91 f5 ff ff       	call   3b8 <alarm>
 e27:	85 c0                	test   %eax,%eax
 e29:	79 19                	jns    e44 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
 e2b:	c7 44 24 04 54 10 00 	movl   $0x1054,0x4(%esp)
 e32:	00 
 e33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 e3a:	e8 58 f6 ff ff       	call   497 <printf>
      exit();
 e3f:	e8 a4 f4 ff ff       	call   2e8 <exit>
    }  
    currentThread->state=T_RUNNING;
 e44:	a1 20 5e 00 00       	mov    0x5e20,%eax
 e49:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
 e50:	a1 20 5e 00 00       	mov    0x5e20,%eax
 e55:	8b 40 14             	mov    0x14(%eax),%eax
 e58:	83 f8 01             	cmp    $0x1,%eax
 e5b:	75 10                	jne    e6d <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
 e5d:	a1 20 5e 00 00       	mov    0x5e20,%eax
 e62:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
 e69:	5d                   	pop    %ebp
 e6a:	c3                   	ret    
 e6b:	eb 01                	jmp    e6e <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
 e6d:	61                   	popa   
    }
  }
}
 e6e:	c9                   	leave  
 e6f:	c3                   	ret    

00000e70 <uthread_self>:

int
uthread_self(void)
{
 e70:	55                   	push   %ebp
 e71:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
 e73:	a1 20 5e 00 00       	mov    0x5e20,%eax
 e78:	8b 00                	mov    (%eax),%eax
 e7a:	5d                   	pop    %ebp
 e7b:	c3                   	ret    

00000e7c <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
 e7c:	55                   	push   %ebp
 e7d:	89 e5                	mov    %esp,%ebp
 e7f:	53                   	push   %ebx
 e80:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
 e83:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e86:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
 e89:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 e8c:	89 c3                	mov    %eax,%ebx
 e8e:	89 d8                	mov    %ebx,%eax
 e90:	f0 87 02             	lock xchg %eax,(%edx)
 e93:	89 c3                	mov    %eax,%ebx
 e95:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 e98:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
 e9b:	83 c4 10             	add    $0x10,%esp
 e9e:	5b                   	pop    %ebx
 e9f:	5d                   	pop    %ebp
 ea0:	c3                   	ret    

00000ea1 <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
 ea1:	55                   	push   %ebp
 ea2:	89 e5                	mov    %esp,%ebp
 ea4:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
 ea7:	8b 45 08             	mov    0x8(%ebp),%eax
 eaa:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
 eb1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 eb5:	74 0c                	je     ec3 <binary_semaphore_init+0x22>
    semaphore->thread=-1;
 eb7:	8b 45 08             	mov    0x8(%ebp),%eax
 eba:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
 ec1:	eb 0b                	jmp    ece <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
 ec3:	e8 a8 ff ff ff       	call   e70 <uthread_self>
 ec8:	8b 55 08             	mov    0x8(%ebp),%edx
 ecb:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
 ece:	8b 55 0c             	mov    0xc(%ebp),%edx
 ed1:	8b 45 08             	mov    0x8(%ebp),%eax
 ed4:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
 ed6:	8b 45 08             	mov    0x8(%ebp),%eax
 ed9:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
 ee0:	c9                   	leave  
 ee1:	c3                   	ret    

00000ee2 <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
 ee2:	55                   	push   %ebp
 ee3:	89 e5                	mov    %esp,%ebp
 ee5:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
 ee8:	8b 45 08             	mov    0x8(%ebp),%eax
 eeb:	8b 40 08             	mov    0x8(%eax),%eax
 eee:	85 c0                	test   %eax,%eax
 ef0:	75 20                	jne    f12 <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 ef2:	8b 45 08             	mov    0x8(%ebp),%eax
 ef5:	8b 40 04             	mov    0x4(%eax),%eax
 ef8:	89 44 24 08          	mov    %eax,0x8(%esp)
 efc:	c7 44 24 04 78 10 00 	movl   $0x1078,0x4(%esp)
 f03:	00 
 f04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f0b:	e8 87 f5 ff ff       	call   497 <printf>
    return;
 f10:	eb 3a                	jmp    f4c <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
 f12:	e8 59 ff ff ff       	call   e70 <uthread_self>
 f17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
 f1a:	8b 45 08             	mov    0x8(%ebp),%eax
 f1d:	8b 40 04             	mov    0x4(%eax),%eax
 f20:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 f23:	74 27                	je     f4c <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 f25:	eb 05                	jmp    f2c <binary_semaphore_down+0x4a>
    {
      uthread_yield();
 f27:	e8 43 fe ff ff       	call   d6f <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
 f2c:	8b 45 08             	mov    0x8(%ebp),%eax
 f2f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 f36:	00 
 f37:	89 04 24             	mov    %eax,(%esp)
 f3a:	e8 3d ff ff ff       	call   e7c <xchg>
 f3f:	85 c0                	test   %eax,%eax
 f41:	74 e4                	je     f27 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
 f43:	8b 45 08             	mov    0x8(%ebp),%eax
 f46:	8b 55 f4             	mov    -0xc(%ebp),%edx
 f49:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
 f4c:	c9                   	leave  
 f4d:	c3                   	ret    

00000f4e <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
 f4e:	55                   	push   %ebp
 f4f:	89 e5                	mov    %esp,%ebp
 f51:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
 f54:	8b 45 08             	mov    0x8(%ebp),%eax
 f57:	8b 40 08             	mov    0x8(%eax),%eax
 f5a:	85 c0                	test   %eax,%eax
 f5c:	75 20                	jne    f7e <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
 f5e:	8b 45 08             	mov    0x8(%ebp),%eax
 f61:	8b 40 04             	mov    0x4(%eax),%eax
 f64:	89 44 24 08          	mov    %eax,0x8(%esp)
 f68:	c7 44 24 04 a8 10 00 	movl   $0x10a8,0x4(%esp)
 f6f:	00 
 f70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 f77:	e8 1b f5 ff ff       	call   497 <printf>
    return;
 f7c:	eb 2f                	jmp    fad <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
 f7e:	e8 ed fe ff ff       	call   e70 <uthread_self>
 f83:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
 f86:	8b 45 08             	mov    0x8(%ebp),%eax
 f89:	8b 00                	mov    (%eax),%eax
 f8b:	85 c0                	test   %eax,%eax
 f8d:	75 1e                	jne    fad <binary_semaphore_up+0x5f>
 f8f:	8b 45 08             	mov    0x8(%ebp),%eax
 f92:	8b 40 04             	mov    0x4(%eax),%eax
 f95:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 f98:	75 13                	jne    fad <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
 f9a:	8b 45 08             	mov    0x8(%ebp),%eax
 f9d:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
 fa4:	8b 45 08             	mov    0x8(%ebp),%eax
 fa7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
 fad:	c9                   	leave  
 fae:	c3                   	ret    
