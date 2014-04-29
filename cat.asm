
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
       6:	eb 1b                	jmp    23 <cat+0x23>
    write(1, buf, n);
       8:	8b 45 f4             	mov    -0xc(%ebp),%eax
       b:	89 44 24 08          	mov    %eax,0x8(%esp)
       f:	c7 44 24 04 c0 5e 00 	movl   $0x5ec0,0x4(%esp)
      16:	00 
      17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      1e:	e8 71 03 00 00       	call   394 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
      23:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
      2a:	00 
      2b:	c7 44 24 04 c0 5e 00 	movl   $0x5ec0,0x4(%esp)
      32:	00 
      33:	8b 45 08             	mov    0x8(%ebp),%eax
      36:	89 04 24             	mov    %eax,(%esp)
      39:	e8 4e 03 00 00       	call   38c <read>
      3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      45:	7f c1                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
      47:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      4b:	79 19                	jns    66 <cat+0x66>
    printf(1, "cat: read error\n");
      4d:	c7 44 24 04 3c 10 00 	movl   $0x103c,0x4(%esp)
      54:	00 
      55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      5c:	e8 c2 04 00 00       	call   523 <printf>
    exit();
      61:	e8 0e 03 00 00       	call   374 <exit>
  }
}
      66:	c9                   	leave  
      67:	c3                   	ret    

00000068 <main>:

int
main(int argc, char *argv[])
{
      68:	55                   	push   %ebp
      69:	89 e5                	mov    %esp,%ebp
      6b:	83 e4 f0             	and    $0xfffffff0,%esp
      6e:	83 ec 20             	sub    $0x20,%esp
  int fd, i;

  if(argc <= 1){
      71:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
      75:	7f 11                	jg     88 <main+0x20>
    cat(0);
      77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
      7e:	e8 7d ff ff ff       	call   0 <cat>
    exit();
      83:	e8 ec 02 00 00       	call   374 <exit>
  }

  for(i = 1; i < argc; i++){
      88:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
      8f:	00 
      90:	eb 6d                	jmp    ff <main+0x97>
    if((fd = open(argv[i], 0)) < 0){
      92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
      96:	c1 e0 02             	shl    $0x2,%eax
      99:	03 45 0c             	add    0xc(%ebp),%eax
      9c:	8b 00                	mov    (%eax),%eax
      9e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      a5:	00 
      a6:	89 04 24             	mov    %eax,(%esp)
      a9:	e8 06 03 00 00       	call   3b4 <open>
      ae:	89 44 24 18          	mov    %eax,0x18(%esp)
      b2:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
      b7:	79 29                	jns    e2 <main+0x7a>
      printf(1, "cat: cannot open %s\n", argv[i]);
      b9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
      bd:	c1 e0 02             	shl    $0x2,%eax
      c0:	03 45 0c             	add    0xc(%ebp),%eax
      c3:	8b 00                	mov    (%eax),%eax
      c5:	89 44 24 08          	mov    %eax,0x8(%esp)
      c9:	c7 44 24 04 4d 10 00 	movl   $0x104d,0x4(%esp)
      d0:	00 
      d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      d8:	e8 46 04 00 00       	call   523 <printf>
      exit();
      dd:	e8 92 02 00 00       	call   374 <exit>
    }
    cat(fd);
      e2:	8b 44 24 18          	mov    0x18(%esp),%eax
      e6:	89 04 24             	mov    %eax,(%esp)
      e9:	e8 12 ff ff ff       	call   0 <cat>
    close(fd);
      ee:	8b 44 24 18          	mov    0x18(%esp),%eax
      f2:	89 04 24             	mov    %eax,(%esp)
      f5:	e8 a2 02 00 00       	call   39c <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
      fa:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
      ff:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     103:	3b 45 08             	cmp    0x8(%ebp),%eax
     106:	7c 8a                	jl     92 <main+0x2a>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
     108:	e8 67 02 00 00       	call   374 <exit>
     10d:	90                   	nop
     10e:	90                   	nop
     10f:	90                   	nop

00000110 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	57                   	push   %edi
     114:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     115:	8b 4d 08             	mov    0x8(%ebp),%ecx
     118:	8b 55 10             	mov    0x10(%ebp),%edx
     11b:	8b 45 0c             	mov    0xc(%ebp),%eax
     11e:	89 cb                	mov    %ecx,%ebx
     120:	89 df                	mov    %ebx,%edi
     122:	89 d1                	mov    %edx,%ecx
     124:	fc                   	cld    
     125:	f3 aa                	rep stos %al,%es:(%edi)
     127:	89 ca                	mov    %ecx,%edx
     129:	89 fb                	mov    %edi,%ebx
     12b:	89 5d 08             	mov    %ebx,0x8(%ebp)
     12e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     131:	5b                   	pop    %ebx
     132:	5f                   	pop    %edi
     133:	5d                   	pop    %ebp
     134:	c3                   	ret    

00000135 <strcpy>:
#include "x86.h"


char*
strcpy(char *s, char *t)
{
     135:	55                   	push   %ebp
     136:	89 e5                	mov    %esp,%ebp
     138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     141:	90                   	nop
     142:	8b 45 0c             	mov    0xc(%ebp),%eax
     145:	0f b6 10             	movzbl (%eax),%edx
     148:	8b 45 08             	mov    0x8(%ebp),%eax
     14b:	88 10                	mov    %dl,(%eax)
     14d:	8b 45 08             	mov    0x8(%ebp),%eax
     150:	0f b6 00             	movzbl (%eax),%eax
     153:	84 c0                	test   %al,%al
     155:	0f 95 c0             	setne  %al
     158:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     15c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
     160:	84 c0                	test   %al,%al
     162:	75 de                	jne    142 <strcpy+0xd>
    ;
  return os;
     164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     167:	c9                   	leave  
     168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     169:	55                   	push   %ebp
     16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
     16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     176:	8b 45 08             	mov    0x8(%ebp),%eax
     179:	0f b6 00             	movzbl (%eax),%eax
     17c:	84 c0                	test   %al,%al
     17e:	74 10                	je     190 <strcmp+0x27>
     180:	8b 45 08             	mov    0x8(%ebp),%eax
     183:	0f b6 10             	movzbl (%eax),%edx
     186:	8b 45 0c             	mov    0xc(%ebp),%eax
     189:	0f b6 00             	movzbl (%eax),%eax
     18c:	38 c2                	cmp    %al,%dl
     18e:	74 de                	je     16e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     190:	8b 45 08             	mov    0x8(%ebp),%eax
     193:	0f b6 00             	movzbl (%eax),%eax
     196:	0f b6 d0             	movzbl %al,%edx
     199:	8b 45 0c             	mov    0xc(%ebp),%eax
     19c:	0f b6 00             	movzbl (%eax),%eax
     19f:	0f b6 c0             	movzbl %al,%eax
     1a2:	89 d1                	mov    %edx,%ecx
     1a4:	29 c1                	sub    %eax,%ecx
     1a6:	89 c8                	mov    %ecx,%eax
}
     1a8:	5d                   	pop    %ebp
     1a9:	c3                   	ret    

000001aa <strlen>:

uint
strlen(char *s)
{
     1aa:	55                   	push   %ebp
     1ab:	89 e5                	mov    %esp,%ebp
     1ad:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1b7:	eb 04                	jmp    1bd <strlen+0x13>
     1b9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     1c0:	03 45 08             	add    0x8(%ebp),%eax
     1c3:	0f b6 00             	movzbl (%eax),%eax
     1c6:	84 c0                	test   %al,%al
     1c8:	75 ef                	jne    1b9 <strlen+0xf>
    ;
  return n;
     1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1cd:	c9                   	leave  
     1ce:	c3                   	ret    

000001cf <memset>:

void*
memset(void *dst, int c, uint n)
{
     1cf:	55                   	push   %ebp
     1d0:	89 e5                	mov    %esp,%ebp
     1d2:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
     1d5:	8b 45 10             	mov    0x10(%ebp),%eax
     1d8:	89 44 24 08          	mov    %eax,0x8(%esp)
     1dc:	8b 45 0c             	mov    0xc(%ebp),%eax
     1df:	89 44 24 04          	mov    %eax,0x4(%esp)
     1e3:	8b 45 08             	mov    0x8(%ebp),%eax
     1e6:	89 04 24             	mov    %eax,(%esp)
     1e9:	e8 22 ff ff ff       	call   110 <stosb>
  return dst;
     1ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1f1:	c9                   	leave  
     1f2:	c3                   	ret    

000001f3 <strchr>:

char*
strchr(const char *s, char c)
{
     1f3:	55                   	push   %ebp
     1f4:	89 e5                	mov    %esp,%ebp
     1f6:	83 ec 04             	sub    $0x4,%esp
     1f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     1fc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1ff:	eb 14                	jmp    215 <strchr+0x22>
    if(*s == c)
     201:	8b 45 08             	mov    0x8(%ebp),%eax
     204:	0f b6 00             	movzbl (%eax),%eax
     207:	3a 45 fc             	cmp    -0x4(%ebp),%al
     20a:	75 05                	jne    211 <strchr+0x1e>
      return (char*)s;
     20c:	8b 45 08             	mov    0x8(%ebp),%eax
     20f:	eb 13                	jmp    224 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     215:	8b 45 08             	mov    0x8(%ebp),%eax
     218:	0f b6 00             	movzbl (%eax),%eax
     21b:	84 c0                	test   %al,%al
     21d:	75 e2                	jne    201 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     21f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     224:	c9                   	leave  
     225:	c3                   	ret    

00000226 <gets>:

char*
gets(char *buf, int max)
{
     226:	55                   	push   %ebp
     227:	89 e5                	mov    %esp,%ebp
     229:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     22c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     233:	eb 44                	jmp    279 <gets+0x53>
    cc = read(0, &c, 1);
     235:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     23c:	00 
     23d:	8d 45 ef             	lea    -0x11(%ebp),%eax
     240:	89 44 24 04          	mov    %eax,0x4(%esp)
     244:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     24b:	e8 3c 01 00 00       	call   38c <read>
     250:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     253:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     257:	7e 2d                	jle    286 <gets+0x60>
      break;
    buf[i++] = c;
     259:	8b 45 f4             	mov    -0xc(%ebp),%eax
     25c:	03 45 08             	add    0x8(%ebp),%eax
     25f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
     263:	88 10                	mov    %dl,(%eax)
     265:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
     269:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     26d:	3c 0a                	cmp    $0xa,%al
     26f:	74 16                	je     287 <gets+0x61>
     271:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     275:	3c 0d                	cmp    $0xd,%al
     277:	74 0e                	je     287 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     279:	8b 45 f4             	mov    -0xc(%ebp),%eax
     27c:	83 c0 01             	add    $0x1,%eax
     27f:	3b 45 0c             	cmp    0xc(%ebp),%eax
     282:	7c b1                	jl     235 <gets+0xf>
     284:	eb 01                	jmp    287 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     286:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     287:	8b 45 f4             	mov    -0xc(%ebp),%eax
     28a:	03 45 08             	add    0x8(%ebp),%eax
     28d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     290:	8b 45 08             	mov    0x8(%ebp),%eax
}
     293:	c9                   	leave  
     294:	c3                   	ret    

00000295 <stat>:

int
stat(char *n, struct stat *st)
{
     295:	55                   	push   %ebp
     296:	89 e5                	mov    %esp,%ebp
     298:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     29b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2a2:	00 
     2a3:	8b 45 08             	mov    0x8(%ebp),%eax
     2a6:	89 04 24             	mov    %eax,(%esp)
     2a9:	e8 06 01 00 00       	call   3b4 <open>
     2ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2b5:	79 07                	jns    2be <stat+0x29>
    return -1;
     2b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2bc:	eb 23                	jmp    2e1 <stat+0x4c>
  r = fstat(fd, st);
     2be:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c1:	89 44 24 04          	mov    %eax,0x4(%esp)
     2c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2c8:	89 04 24             	mov    %eax,(%esp)
     2cb:	e8 fc 00 00 00       	call   3cc <fstat>
     2d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2d6:	89 04 24             	mov    %eax,(%esp)
     2d9:	e8 be 00 00 00       	call   39c <close>
  return r;
     2de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2e1:	c9                   	leave  
     2e2:	c3                   	ret    

000002e3 <atoi>:

int
atoi(const char *s)
{
     2e3:	55                   	push   %ebp
     2e4:	89 e5                	mov    %esp,%ebp
     2e6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2f0:	eb 23                	jmp    315 <atoi+0x32>
    n = n*10 + *s++ - '0';
     2f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2f5:	89 d0                	mov    %edx,%eax
     2f7:	c1 e0 02             	shl    $0x2,%eax
     2fa:	01 d0                	add    %edx,%eax
     2fc:	01 c0                	add    %eax,%eax
     2fe:	89 c2                	mov    %eax,%edx
     300:	8b 45 08             	mov    0x8(%ebp),%eax
     303:	0f b6 00             	movzbl (%eax),%eax
     306:	0f be c0             	movsbl %al,%eax
     309:	01 d0                	add    %edx,%eax
     30b:	83 e8 30             	sub    $0x30,%eax
     30e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     311:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     315:	8b 45 08             	mov    0x8(%ebp),%eax
     318:	0f b6 00             	movzbl (%eax),%eax
     31b:	3c 2f                	cmp    $0x2f,%al
     31d:	7e 0a                	jle    329 <atoi+0x46>
     31f:	8b 45 08             	mov    0x8(%ebp),%eax
     322:	0f b6 00             	movzbl (%eax),%eax
     325:	3c 39                	cmp    $0x39,%al
     327:	7e c9                	jle    2f2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
     329:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     32c:	c9                   	leave  
     32d:	c3                   	ret    

0000032e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     32e:	55                   	push   %ebp
     32f:	89 e5                	mov    %esp,%ebp
     331:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     334:	8b 45 08             	mov    0x8(%ebp),%eax
     337:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     33a:	8b 45 0c             	mov    0xc(%ebp),%eax
     33d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     340:	eb 13                	jmp    355 <memmove+0x27>
    *dst++ = *src++;
     342:	8b 45 f8             	mov    -0x8(%ebp),%eax
     345:	0f b6 10             	movzbl (%eax),%edx
     348:	8b 45 fc             	mov    -0x4(%ebp),%eax
     34b:	88 10                	mov    %dl,(%eax)
     34d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     351:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     355:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     359:	0f 9f c0             	setg   %al
     35c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     360:	84 c0                	test   %al,%al
     362:	75 de                	jne    342 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
     364:	8b 45 08             	mov    0x8(%ebp),%eax
}
     367:	c9                   	leave  
     368:	c3                   	ret    
     369:	90                   	nop
     36a:	90                   	nop
     36b:	90                   	nop

0000036c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     36c:	b8 01 00 00 00       	mov    $0x1,%eax
     371:	cd 40                	int    $0x40
     373:	c3                   	ret    

00000374 <exit>:
SYSCALL(exit)
     374:	b8 02 00 00 00       	mov    $0x2,%eax
     379:	cd 40                	int    $0x40
     37b:	c3                   	ret    

0000037c <wait>:
SYSCALL(wait)
     37c:	b8 03 00 00 00       	mov    $0x3,%eax
     381:	cd 40                	int    $0x40
     383:	c3                   	ret    

00000384 <pipe>:
SYSCALL(pipe)
     384:	b8 04 00 00 00       	mov    $0x4,%eax
     389:	cd 40                	int    $0x40
     38b:	c3                   	ret    

0000038c <read>:
SYSCALL(read)
     38c:	b8 05 00 00 00       	mov    $0x5,%eax
     391:	cd 40                	int    $0x40
     393:	c3                   	ret    

00000394 <write>:
SYSCALL(write)
     394:	b8 10 00 00 00       	mov    $0x10,%eax
     399:	cd 40                	int    $0x40
     39b:	c3                   	ret    

0000039c <close>:
SYSCALL(close)
     39c:	b8 15 00 00 00       	mov    $0x15,%eax
     3a1:	cd 40                	int    $0x40
     3a3:	c3                   	ret    

000003a4 <kill>:
SYSCALL(kill)
     3a4:	b8 06 00 00 00       	mov    $0x6,%eax
     3a9:	cd 40                	int    $0x40
     3ab:	c3                   	ret    

000003ac <exec>:
SYSCALL(exec)
     3ac:	b8 07 00 00 00       	mov    $0x7,%eax
     3b1:	cd 40                	int    $0x40
     3b3:	c3                   	ret    

000003b4 <open>:
SYSCALL(open)
     3b4:	b8 0f 00 00 00       	mov    $0xf,%eax
     3b9:	cd 40                	int    $0x40
     3bb:	c3                   	ret    

000003bc <mknod>:
SYSCALL(mknod)
     3bc:	b8 11 00 00 00       	mov    $0x11,%eax
     3c1:	cd 40                	int    $0x40
     3c3:	c3                   	ret    

000003c4 <unlink>:
SYSCALL(unlink)
     3c4:	b8 12 00 00 00       	mov    $0x12,%eax
     3c9:	cd 40                	int    $0x40
     3cb:	c3                   	ret    

000003cc <fstat>:
SYSCALL(fstat)
     3cc:	b8 08 00 00 00       	mov    $0x8,%eax
     3d1:	cd 40                	int    $0x40
     3d3:	c3                   	ret    

000003d4 <link>:
SYSCALL(link)
     3d4:	b8 13 00 00 00       	mov    $0x13,%eax
     3d9:	cd 40                	int    $0x40
     3db:	c3                   	ret    

000003dc <mkdir>:
SYSCALL(mkdir)
     3dc:	b8 14 00 00 00       	mov    $0x14,%eax
     3e1:	cd 40                	int    $0x40
     3e3:	c3                   	ret    

000003e4 <chdir>:
SYSCALL(chdir)
     3e4:	b8 09 00 00 00       	mov    $0x9,%eax
     3e9:	cd 40                	int    $0x40
     3eb:	c3                   	ret    

000003ec <dup>:
SYSCALL(dup)
     3ec:	b8 0a 00 00 00       	mov    $0xa,%eax
     3f1:	cd 40                	int    $0x40
     3f3:	c3                   	ret    

000003f4 <getpid>:
SYSCALL(getpid)
     3f4:	b8 0b 00 00 00       	mov    $0xb,%eax
     3f9:	cd 40                	int    $0x40
     3fb:	c3                   	ret    

000003fc <sbrk>:
SYSCALL(sbrk)
     3fc:	b8 0c 00 00 00       	mov    $0xc,%eax
     401:	cd 40                	int    $0x40
     403:	c3                   	ret    

00000404 <sleep>:
SYSCALL(sleep)
     404:	b8 0d 00 00 00       	mov    $0xd,%eax
     409:	cd 40                	int    $0x40
     40b:	c3                   	ret    

0000040c <uptime>:
SYSCALL(uptime)
     40c:	b8 0e 00 00 00       	mov    $0xe,%eax
     411:	cd 40                	int    $0x40
     413:	c3                   	ret    

00000414 <add_path>:
SYSCALL(add_path)
     414:	b8 16 00 00 00       	mov    $0x16,%eax
     419:	cd 40                	int    $0x40
     41b:	c3                   	ret    

0000041c <wait2>:
SYSCALL(wait2)
     41c:	b8 17 00 00 00       	mov    $0x17,%eax
     421:	cd 40                	int    $0x40
     423:	c3                   	ret    

00000424 <getquanta>:
SYSCALL(getquanta)
     424:	b8 18 00 00 00       	mov    $0x18,%eax
     429:	cd 40                	int    $0x40
     42b:	c3                   	ret    

0000042c <getqueue>:
SYSCALL(getqueue)
     42c:	b8 19 00 00 00       	mov    $0x19,%eax
     431:	cd 40                	int    $0x40
     433:	c3                   	ret    

00000434 <signal>:
SYSCALL(signal)
     434:	b8 1a 00 00 00       	mov    $0x1a,%eax
     439:	cd 40                	int    $0x40
     43b:	c3                   	ret    

0000043c <sigsend>:
SYSCALL(sigsend)
     43c:	b8 1b 00 00 00       	mov    $0x1b,%eax
     441:	cd 40                	int    $0x40
     443:	c3                   	ret    

00000444 <alarm>:
SYSCALL(alarm)
     444:	b8 1c 00 00 00       	mov    $0x1c,%eax
     449:	cd 40                	int    $0x40
     44b:	c3                   	ret    

0000044c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     44c:	55                   	push   %ebp
     44d:	89 e5                	mov    %esp,%ebp
     44f:	83 ec 28             	sub    $0x28,%esp
     452:	8b 45 0c             	mov    0xc(%ebp),%eax
     455:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     458:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     45f:	00 
     460:	8d 45 f4             	lea    -0xc(%ebp),%eax
     463:	89 44 24 04          	mov    %eax,0x4(%esp)
     467:	8b 45 08             	mov    0x8(%ebp),%eax
     46a:	89 04 24             	mov    %eax,(%esp)
     46d:	e8 22 ff ff ff       	call   394 <write>
}
     472:	c9                   	leave  
     473:	c3                   	ret    

00000474 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     474:	55                   	push   %ebp
     475:	89 e5                	mov    %esp,%ebp
     477:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     47a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     481:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     485:	74 17                	je     49e <printint+0x2a>
     487:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     48b:	79 11                	jns    49e <printint+0x2a>
    neg = 1;
     48d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     494:	8b 45 0c             	mov    0xc(%ebp),%eax
     497:	f7 d8                	neg    %eax
     499:	89 45 ec             	mov    %eax,-0x14(%ebp)
     49c:	eb 06                	jmp    4a4 <printint+0x30>
  } else {
    x = xx;
     49e:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4b1:	ba 00 00 00 00       	mov    $0x0,%edx
     4b6:	f7 f1                	div    %ecx
     4b8:	89 d0                	mov    %edx,%eax
     4ba:	0f b6 90 7c 15 00 00 	movzbl 0x157c(%eax),%edx
     4c1:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4c4:	03 45 f4             	add    -0xc(%ebp),%eax
     4c7:	88 10                	mov    %dl,(%eax)
     4c9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
     4cd:	8b 55 10             	mov    0x10(%ebp),%edx
     4d0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     4d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4d6:	ba 00 00 00 00       	mov    $0x0,%edx
     4db:	f7 75 d4             	divl   -0x2c(%ebp)
     4de:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e5:	75 c4                	jne    4ab <printint+0x37>
  if(neg)
     4e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4eb:	74 2a                	je     517 <printint+0xa3>
    buf[i++] = '-';
     4ed:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4f0:	03 45 f4             	add    -0xc(%ebp),%eax
     4f3:	c6 00 2d             	movb   $0x2d,(%eax)
     4f6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
     4fa:	eb 1b                	jmp    517 <printint+0xa3>
    putc(fd, buf[i]);
     4fc:	8d 45 dc             	lea    -0x24(%ebp),%eax
     4ff:	03 45 f4             	add    -0xc(%ebp),%eax
     502:	0f b6 00             	movzbl (%eax),%eax
     505:	0f be c0             	movsbl %al,%eax
     508:	89 44 24 04          	mov    %eax,0x4(%esp)
     50c:	8b 45 08             	mov    0x8(%ebp),%eax
     50f:	89 04 24             	mov    %eax,(%esp)
     512:	e8 35 ff ff ff       	call   44c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     517:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     51b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     51f:	79 db                	jns    4fc <printint+0x88>
    putc(fd, buf[i]);
}
     521:	c9                   	leave  
     522:	c3                   	ret    

00000523 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     523:	55                   	push   %ebp
     524:	89 e5                	mov    %esp,%ebp
     526:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     529:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     530:	8d 45 0c             	lea    0xc(%ebp),%eax
     533:	83 c0 04             	add    $0x4,%eax
     536:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     540:	e9 7d 01 00 00       	jmp    6c2 <printf+0x19f>
    c = fmt[i] & 0xff;
     545:	8b 55 0c             	mov    0xc(%ebp),%edx
     548:	8b 45 f0             	mov    -0x10(%ebp),%eax
     54b:	01 d0                	add    %edx,%eax
     54d:	0f b6 00             	movzbl (%eax),%eax
     550:	0f be c0             	movsbl %al,%eax
     553:	25 ff 00 00 00       	and    $0xff,%eax
     558:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     55b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     55f:	75 2c                	jne    58d <printf+0x6a>
      if(c == '%'){
     561:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     565:	75 0c                	jne    573 <printf+0x50>
        state = '%';
     567:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     56e:	e9 4b 01 00 00       	jmp    6be <printf+0x19b>
      } else {
        putc(fd, c);
     573:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     576:	0f be c0             	movsbl %al,%eax
     579:	89 44 24 04          	mov    %eax,0x4(%esp)
     57d:	8b 45 08             	mov    0x8(%ebp),%eax
     580:	89 04 24             	mov    %eax,(%esp)
     583:	e8 c4 fe ff ff       	call   44c <putc>
     588:	e9 31 01 00 00       	jmp    6be <printf+0x19b>
      }
    } else if(state == '%'){
     58d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     591:	0f 85 27 01 00 00    	jne    6be <printf+0x19b>
      if(c == 'd'){
     597:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     59b:	75 2d                	jne    5ca <printf+0xa7>
        printint(fd, *ap, 10, 1);
     59d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a0:	8b 00                	mov    (%eax),%eax
     5a2:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     5a9:	00 
     5aa:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     5b1:	00 
     5b2:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b6:	8b 45 08             	mov    0x8(%ebp),%eax
     5b9:	89 04 24             	mov    %eax,(%esp)
     5bc:	e8 b3 fe ff ff       	call   474 <printint>
        ap++;
     5c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c5:	e9 ed 00 00 00       	jmp    6b7 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
     5ca:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5ce:	74 06                	je     5d6 <printf+0xb3>
     5d0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5d4:	75 2d                	jne    603 <printf+0xe0>
        printint(fd, *ap, 16, 0);
     5d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d9:	8b 00                	mov    (%eax),%eax
     5db:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     5e2:	00 
     5e3:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     5ea:	00 
     5eb:	89 44 24 04          	mov    %eax,0x4(%esp)
     5ef:	8b 45 08             	mov    0x8(%ebp),%eax
     5f2:	89 04 24             	mov    %eax,(%esp)
     5f5:	e8 7a fe ff ff       	call   474 <printint>
        ap++;
     5fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5fe:	e9 b4 00 00 00       	jmp    6b7 <printf+0x194>
      } else if(c == 's'){
     603:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     607:	75 46                	jne    64f <printf+0x12c>
        s = (char*)*ap;
     609:	8b 45 e8             	mov    -0x18(%ebp),%eax
     60c:	8b 00                	mov    (%eax),%eax
     60e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     611:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     615:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     619:	75 27                	jne    642 <printf+0x11f>
          s = "(null)";
     61b:	c7 45 f4 62 10 00 00 	movl   $0x1062,-0xc(%ebp)
        while(*s != 0){
     622:	eb 1e                	jmp    642 <printf+0x11f>
          putc(fd, *s);
     624:	8b 45 f4             	mov    -0xc(%ebp),%eax
     627:	0f b6 00             	movzbl (%eax),%eax
     62a:	0f be c0             	movsbl %al,%eax
     62d:	89 44 24 04          	mov    %eax,0x4(%esp)
     631:	8b 45 08             	mov    0x8(%ebp),%eax
     634:	89 04 24             	mov    %eax,(%esp)
     637:	e8 10 fe ff ff       	call   44c <putc>
          s++;
     63c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     640:	eb 01                	jmp    643 <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     642:	90                   	nop
     643:	8b 45 f4             	mov    -0xc(%ebp),%eax
     646:	0f b6 00             	movzbl (%eax),%eax
     649:	84 c0                	test   %al,%al
     64b:	75 d7                	jne    624 <printf+0x101>
     64d:	eb 68                	jmp    6b7 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     64f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     653:	75 1d                	jne    672 <printf+0x14f>
        putc(fd, *ap);
     655:	8b 45 e8             	mov    -0x18(%ebp),%eax
     658:	8b 00                	mov    (%eax),%eax
     65a:	0f be c0             	movsbl %al,%eax
     65d:	89 44 24 04          	mov    %eax,0x4(%esp)
     661:	8b 45 08             	mov    0x8(%ebp),%eax
     664:	89 04 24             	mov    %eax,(%esp)
     667:	e8 e0 fd ff ff       	call   44c <putc>
        ap++;
     66c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     670:	eb 45                	jmp    6b7 <printf+0x194>
      } else if(c == '%'){
     672:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     676:	75 17                	jne    68f <printf+0x16c>
        putc(fd, c);
     678:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     67b:	0f be c0             	movsbl %al,%eax
     67e:	89 44 24 04          	mov    %eax,0x4(%esp)
     682:	8b 45 08             	mov    0x8(%ebp),%eax
     685:	89 04 24             	mov    %eax,(%esp)
     688:	e8 bf fd ff ff       	call   44c <putc>
     68d:	eb 28                	jmp    6b7 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     68f:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
     696:	00 
     697:	8b 45 08             	mov    0x8(%ebp),%eax
     69a:	89 04 24             	mov    %eax,(%esp)
     69d:	e8 aa fd ff ff       	call   44c <putc>
        putc(fd, c);
     6a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6a5:	0f be c0             	movsbl %al,%eax
     6a8:	89 44 24 04          	mov    %eax,0x4(%esp)
     6ac:	8b 45 08             	mov    0x8(%ebp),%eax
     6af:	89 04 24             	mov    %eax,(%esp)
     6b2:	e8 95 fd ff ff       	call   44c <putc>
      }
      state = 0;
     6b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     6be:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6c2:	8b 55 0c             	mov    0xc(%ebp),%edx
     6c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6c8:	01 d0                	add    %edx,%eax
     6ca:	0f b6 00             	movzbl (%eax),%eax
     6cd:	84 c0                	test   %al,%al
     6cf:	0f 85 70 fe ff ff    	jne    545 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     6d5:	c9                   	leave  
     6d6:	c3                   	ret    
     6d7:	90                   	nop

000006d8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6d8:	55                   	push   %ebp
     6d9:	89 e5                	mov    %esp,%ebp
     6db:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6de:	8b 45 08             	mov    0x8(%ebp),%eax
     6e1:	83 e8 08             	sub    $0x8,%eax
     6e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6e7:	a1 a8 15 00 00       	mov    0x15a8,%eax
     6ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6ef:	eb 24                	jmp    715 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f4:	8b 00                	mov    (%eax),%eax
     6f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6f9:	77 12                	ja     70d <free+0x35>
     6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     701:	77 24                	ja     727 <free+0x4f>
     703:	8b 45 fc             	mov    -0x4(%ebp),%eax
     706:	8b 00                	mov    (%eax),%eax
     708:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     70b:	77 1a                	ja     727 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     70d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     710:	8b 00                	mov    (%eax),%eax
     712:	89 45 fc             	mov    %eax,-0x4(%ebp)
     715:	8b 45 f8             	mov    -0x8(%ebp),%eax
     718:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     71b:	76 d4                	jbe    6f1 <free+0x19>
     71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     720:	8b 00                	mov    (%eax),%eax
     722:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     725:	76 ca                	jbe    6f1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
     727:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72a:	8b 40 04             	mov    0x4(%eax),%eax
     72d:	c1 e0 03             	shl    $0x3,%eax
     730:	89 c2                	mov    %eax,%edx
     732:	03 55 f8             	add    -0x8(%ebp),%edx
     735:	8b 45 fc             	mov    -0x4(%ebp),%eax
     738:	8b 00                	mov    (%eax),%eax
     73a:	39 c2                	cmp    %eax,%edx
     73c:	75 24                	jne    762 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
     73e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     741:	8b 50 04             	mov    0x4(%eax),%edx
     744:	8b 45 fc             	mov    -0x4(%ebp),%eax
     747:	8b 00                	mov    (%eax),%eax
     749:	8b 40 04             	mov    0x4(%eax),%eax
     74c:	01 c2                	add    %eax,%edx
     74e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     751:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     754:	8b 45 fc             	mov    -0x4(%ebp),%eax
     757:	8b 00                	mov    (%eax),%eax
     759:	8b 10                	mov    (%eax),%edx
     75b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     75e:	89 10                	mov    %edx,(%eax)
     760:	eb 0a                	jmp    76c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
     762:	8b 45 fc             	mov    -0x4(%ebp),%eax
     765:	8b 10                	mov    (%eax),%edx
     767:	8b 45 f8             	mov    -0x8(%ebp),%eax
     76a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     76c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76f:	8b 40 04             	mov    0x4(%eax),%eax
     772:	c1 e0 03             	shl    $0x3,%eax
     775:	03 45 fc             	add    -0x4(%ebp),%eax
     778:	3b 45 f8             	cmp    -0x8(%ebp),%eax
     77b:	75 20                	jne    79d <free+0xc5>
    p->s.size += bp->s.size;
     77d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     780:	8b 50 04             	mov    0x4(%eax),%edx
     783:	8b 45 f8             	mov    -0x8(%ebp),%eax
     786:	8b 40 04             	mov    0x4(%eax),%eax
     789:	01 c2                	add    %eax,%edx
     78b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     791:	8b 45 f8             	mov    -0x8(%ebp),%eax
     794:	8b 10                	mov    (%eax),%edx
     796:	8b 45 fc             	mov    -0x4(%ebp),%eax
     799:	89 10                	mov    %edx,(%eax)
     79b:	eb 08                	jmp    7a5 <free+0xcd>
  } else
    p->s.ptr = bp;
     79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     7a3:	89 10                	mov    %edx,(%eax)
  freep = p;
     7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a8:	a3 a8 15 00 00       	mov    %eax,0x15a8
}
     7ad:	c9                   	leave  
     7ae:	c3                   	ret    

000007af <morecore>:

static Header*
morecore(uint nu)
{
     7af:	55                   	push   %ebp
     7b0:	89 e5                	mov    %esp,%ebp
     7b2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7b5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7bc:	77 07                	ja     7c5 <morecore+0x16>
    nu = 4096;
     7be:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7c5:	8b 45 08             	mov    0x8(%ebp),%eax
     7c8:	c1 e0 03             	shl    $0x3,%eax
     7cb:	89 04 24             	mov    %eax,(%esp)
     7ce:	e8 29 fc ff ff       	call   3fc <sbrk>
     7d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7d6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7da:	75 07                	jne    7e3 <morecore+0x34>
    return 0;
     7dc:	b8 00 00 00 00       	mov    $0x0,%eax
     7e1:	eb 22                	jmp    805 <morecore+0x56>
  hp = (Header*)p;
     7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7ec:	8b 55 08             	mov    0x8(%ebp),%edx
     7ef:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f5:	83 c0 08             	add    $0x8,%eax
     7f8:	89 04 24             	mov    %eax,(%esp)
     7fb:	e8 d8 fe ff ff       	call   6d8 <free>
  return freep;
     800:	a1 a8 15 00 00       	mov    0x15a8,%eax
}
     805:	c9                   	leave  
     806:	c3                   	ret    

00000807 <malloc>:

void*
malloc(uint nbytes)
{
     807:	55                   	push   %ebp
     808:	89 e5                	mov    %esp,%ebp
     80a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     80d:	8b 45 08             	mov    0x8(%ebp),%eax
     810:	83 c0 07             	add    $0x7,%eax
     813:	c1 e8 03             	shr    $0x3,%eax
     816:	83 c0 01             	add    $0x1,%eax
     819:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     81c:	a1 a8 15 00 00       	mov    0x15a8,%eax
     821:	89 45 f0             	mov    %eax,-0x10(%ebp)
     824:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     828:	75 23                	jne    84d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     82a:	c7 45 f0 a0 15 00 00 	movl   $0x15a0,-0x10(%ebp)
     831:	8b 45 f0             	mov    -0x10(%ebp),%eax
     834:	a3 a8 15 00 00       	mov    %eax,0x15a8
     839:	a1 a8 15 00 00       	mov    0x15a8,%eax
     83e:	a3 a0 15 00 00       	mov    %eax,0x15a0
    base.s.size = 0;
     843:	c7 05 a4 15 00 00 00 	movl   $0x0,0x15a4
     84a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     84d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     850:	8b 00                	mov    (%eax),%eax
     852:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     855:	8b 45 f4             	mov    -0xc(%ebp),%eax
     858:	8b 40 04             	mov    0x4(%eax),%eax
     85b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     85e:	72 4d                	jb     8ad <malloc+0xa6>
      if(p->s.size == nunits)
     860:	8b 45 f4             	mov    -0xc(%ebp),%eax
     863:	8b 40 04             	mov    0x4(%eax),%eax
     866:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     869:	75 0c                	jne    877 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86e:	8b 10                	mov    (%eax),%edx
     870:	8b 45 f0             	mov    -0x10(%ebp),%eax
     873:	89 10                	mov    %edx,(%eax)
     875:	eb 26                	jmp    89d <malloc+0x96>
      else {
        p->s.size -= nunits;
     877:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87a:	8b 40 04             	mov    0x4(%eax),%eax
     87d:	89 c2                	mov    %eax,%edx
     87f:	2b 55 ec             	sub    -0x14(%ebp),%edx
     882:	8b 45 f4             	mov    -0xc(%ebp),%eax
     885:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     888:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88b:	8b 40 04             	mov    0x4(%eax),%eax
     88e:	c1 e0 03             	shl    $0x3,%eax
     891:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     894:	8b 45 f4             	mov    -0xc(%ebp),%eax
     897:	8b 55 ec             	mov    -0x14(%ebp),%edx
     89a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     89d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8a0:	a3 a8 15 00 00       	mov    %eax,0x15a8
      return (void*)(p + 1);
     8a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8a8:	83 c0 08             	add    $0x8,%eax
     8ab:	eb 38                	jmp    8e5 <malloc+0xde>
    }
    if(p == freep)
     8ad:	a1 a8 15 00 00       	mov    0x15a8,%eax
     8b2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8b5:	75 1b                	jne    8d2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
     8b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     8ba:	89 04 24             	mov    %eax,(%esp)
     8bd:	e8 ed fe ff ff       	call   7af <morecore>
     8c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8c9:	75 07                	jne    8d2 <malloc+0xcb>
        return 0;
     8cb:	b8 00 00 00 00       	mov    $0x0,%eax
     8d0:	eb 13                	jmp    8e5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8db:	8b 00                	mov    (%eax),%eax
     8dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
     8e0:	e9 70 ff ff ff       	jmp    855 <malloc+0x4e>
}
     8e5:	c9                   	leave  
     8e6:	c3                   	ret    
     8e7:	90                   	nop

000008e8 <print_stack>:
 * prints the stack of the currently running thread
 * DEBUGGING purposes
 */
void
print_stack()
{
     8e8:	55                   	push   %ebp
     8e9:	89 e5                	mov    %esp,%ebp
     8eb:	83 ec 28             	sub    $0x28,%esp
  int *newesp = (int*)currentThread->esp;  
     8ee:	a1 c0 60 00 00       	mov    0x60c0,%eax
     8f3:	8b 40 04             	mov    0x4(%eax),%eax
     8f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"stack for thread %d \n",currentThread->tid);
     8f9:	a1 c0 60 00 00       	mov    0x60c0,%eax
     8fe:	8b 00                	mov    (%eax),%eax
     900:	89 44 24 08          	mov    %eax,0x8(%esp)
     904:	c7 44 24 04 6c 10 00 	movl   $0x106c,0x4(%esp)
     90b:	00 
     90c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     913:	e8 0b fc ff ff       	call   523 <printf>
  while((newesp < (int *)currentThread->ebp))
     918:	eb 3c                	jmp    956 <print_stack+0x6e>
  {
    printf(1,"add:%x ",newesp);
     91a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91d:	89 44 24 08          	mov    %eax,0x8(%esp)
     921:	c7 44 24 04 82 10 00 	movl   $0x1082,0x4(%esp)
     928:	00 
     929:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     930:	e8 ee fb ff ff       	call   523 <printf>
      printf(1,"val:%x\n",*newesp);
     935:	8b 45 f4             	mov    -0xc(%ebp),%eax
     938:	8b 00                	mov    (%eax),%eax
     93a:	89 44 24 08          	mov    %eax,0x8(%esp)
     93e:	c7 44 24 04 8a 10 00 	movl   $0x108a,0x4(%esp)
     945:	00 
     946:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     94d:	e8 d1 fb ff ff       	call   523 <printf>
    newesp++;
     952:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
void
print_stack()
{
  int *newesp = (int*)currentThread->esp;  
  printf(1,"stack for thread %d \n",currentThread->tid);
  while((newesp < (int *)currentThread->ebp))
     956:	a1 c0 60 00 00       	mov    0x60c0,%eax
     95b:	8b 40 08             	mov    0x8(%eax),%eax
     95e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     961:	77 b7                	ja     91a <print_stack+0x32>
    printf(1,"add:%x ",newesp);
      printf(1,"val:%x\n",*newesp);
    newesp++;
  }

}
     963:	c9                   	leave  
     964:	c3                   	ret    

00000965 <getNextThread>:
 * returns the next thread in line to run
 * if none exists it returns -1
 */
int
getNextThread(int j)
{
     965:	55                   	push   %ebp
     966:	89 e5                	mov    %esp,%ebp
     968:	83 ec 10             	sub    $0x10,%esp
  int i=j+1;
     96b:	8b 45 08             	mov    0x8(%ebp),%eax
     96e:	83 c0 01             	add    $0x1,%eax
     971:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(i==MAX_THREAD)
     974:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     978:	75 07                	jne    981 <getNextThread+0x1c>
    i=0;
     97a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  uthread_p t=&tTable.table[i];
     981:	8b 45 fc             	mov    -0x4(%ebp),%eax
     984:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     98a:	05 c0 15 00 00       	add    $0x15c0,%eax
     98f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(i!=j)
     992:	eb 3b                	jmp    9cf <getNextThread+0x6a>
  {
    if(t->state==T_RUNNABLE)
     994:	8b 45 f8             	mov    -0x8(%ebp),%eax
     997:	8b 40 10             	mov    0x10(%eax),%eax
     99a:	83 f8 03             	cmp    $0x3,%eax
     99d:	75 05                	jne    9a4 <getNextThread+0x3f>
      return i;
     99f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a2:	eb 38                	jmp    9dc <getNextThread+0x77>
    i++;
     9a4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    if(i==MAX_THREAD)
     9a8:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
     9ac:	75 1a                	jne    9c8 <getNextThread+0x63>
    {
     i=0;
     9ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     t=&tTable.table[i];
     9b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b8:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     9be:	05 c0 15 00 00       	add    $0x15c0,%eax
     9c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
     9c6:	eb 07                	jmp    9cf <getNextThread+0x6a>
   }
   else
    t++;
     9c8:	81 45 f8 24 01 00 00 	addl   $0x124,-0x8(%ebp)
{
  int i=j+1;
  if(i==MAX_THREAD)
    i=0;
  uthread_p t=&tTable.table[i];
  while(i!=j)
     9cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d2:	3b 45 08             	cmp    0x8(%ebp),%eax
     9d5:	75 bd                	jne    994 <getNextThread+0x2f>
   }
   else
    t++;

}
return -1;
     9d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     9dc:	c9                   	leave  
     9dd:	c3                   	ret    

000009de <allocThread>:
 * allocates a spot for a new thread
 * if none exist it returns NULL
 */
static uthread_p
allocThread()
{
     9de:	55                   	push   %ebp
     9df:	89 e5                	mov    %esp,%ebp
     9e1:	83 ec 28             	sub    $0x28,%esp
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     9e4:	c7 45 ec c0 15 00 00 	movl   $0x15c0,-0x14(%ebp)
     9eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     9f2:	eb 15                	jmp    a09 <allocThread+0x2b>
  {
    if(t->state==T_FREE)
     9f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     9f7:	8b 40 10             	mov    0x10(%eax),%eax
     9fa:	85 c0                	test   %eax,%eax
     9fc:	74 1e                	je     a1c <allocThread+0x3e>
allocThread()
{
  int i,j;
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
     9fe:	81 45 ec 24 01 00 00 	addl   $0x124,-0x14(%ebp)
     a05:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a09:	81 7d ec c0 5e 00 00 	cmpl   $0x5ec0,-0x14(%ebp)
     a10:	72 e2                	jb     9f4 <allocThread+0x16>
  {
    if(t->state==T_FREE)
      goto found;
  }
  return 0;
     a12:	b8 00 00 00 00       	mov    $0x0,%eax
     a17:	e9 a3 00 00 00       	jmp    abf <allocThread+0xe1>
  uthread_p t;
  
  for (t=tTable.table,i=0 ; t < &tTable.table[MAX_THREAD]; t++,i++)
  {
    if(t->state==T_FREE)
      goto found;
     a1c:	90                   	nop
  }
  return 0;
  
  found:
  //Init all fields
  t->tid=i;
     a1d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a20:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a23:	89 10                	mov    %edx,(%eax)
  if(i==0) //main thread init
     a25:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a29:	75 1c                	jne    a47 <allocThread+0x69>
  {
    STORE_ESP(t->esp);
     a2b:	89 e2                	mov    %esp,%edx
     a2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a30:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(t->ebp);
     a33:	89 ea                	mov    %ebp,%edx
     a35:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a38:	89 50 08             	mov    %edx,0x8(%eax)
    t->firstTime=0;
     a3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a3e:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
     a45:	eb 3b                	jmp    a82 <allocThread+0xa4>
  }
  else
  {
    t->stack=(char*)malloc(STACK_SIZE);
     a47:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
     a4e:	e8 b4 fd ff ff       	call   807 <malloc>
     a53:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a56:	89 42 0c             	mov    %eax,0xc(%edx)
    t->ebp=(int)t->stack+STACK_SIZE;
     a59:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a5c:	8b 40 0c             	mov    0xc(%eax),%eax
     a5f:	05 00 10 00 00       	add    $0x1000,%eax
     a64:	89 c2                	mov    %eax,%edx
     a66:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a69:	89 50 08             	mov    %edx,0x8(%eax)
    t->esp=t->ebp;
     a6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a6f:	8b 50 08             	mov    0x8(%eax),%edx
     a72:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a75:	89 50 04             	mov    %edx,0x4(%eax)
    t->firstTime=1;
     a78:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a7b:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  }
  
  t->waitingFor=-1;
     a82:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a85:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
     a8c:	ff ff ff 
  
  for(j=0;j<MAX_THREAD;j++)
     a8f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a96:	eb 14                	jmp    aac <allocThread+0xce>
  {
    t->waitedOn[j]=-1;
     a98:	8b 45 ec             	mov    -0x14(%ebp),%eax
     a9b:	8b 55 f0             	mov    -0x10(%ebp),%edx
     a9e:	83 c2 08             	add    $0x8,%edx
     aa1:	c7 04 90 ff ff ff ff 	movl   $0xffffffff,(%eax,%edx,4)
    t->firstTime=1;
  }
  
  t->waitingFor=-1;
  
  for(j=0;j<MAX_THREAD;j++)
     aa8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     aac:	83 7d f0 3f          	cmpl   $0x3f,-0x10(%ebp)
     ab0:	7e e6                	jle    a98 <allocThread+0xba>
  {
    t->waitedOn[j]=-1;
  }
   
  t->state=T_UNINIT;
     ab2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ab5:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  
    
  return t;
     abc:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
     abf:	c9                   	leave  
     ac0:	c3                   	ret    

00000ac1 <uthread_init>:
/*
 * initializes all the uthread structures
 */
int
uthread_init()
{   
     ac1:	55                   	push   %ebp
     ac2:	89 e5                	mov    %esp,%ebp
     ac4:	83 ec 28             	sub    $0x28,%esp
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     ac7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ace:	eb 18                	jmp    ae8 <uthread_init+0x27>
  {
    tTable.table[i].state=T_FREE;
     ad0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad3:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     ad9:	05 d0 15 00 00       	add    $0x15d0,%eax
     ade:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
uthread_init()
{   
  //Initialize table
  int i;
  
  for(i=0;i<MAX_THREAD;i++)
     ae4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ae8:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     aec:	7e e2                	jle    ad0 <uthread_init+0xf>
  {
    tTable.table[i].state=T_FREE;
  }
  
 //allocate the main thread
  currentThread = allocThread();
     aee:	e8 eb fe ff ff       	call   9de <allocThread>
     af3:	a3 c0 60 00 00       	mov    %eax,0x60c0
  if(currentThread==0)
     af8:	a1 c0 60 00 00       	mov    0x60c0,%eax
     afd:	85 c0                	test   %eax,%eax
     aff:	75 07                	jne    b08 <uthread_init+0x47>
    return -1;
     b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b06:	eb 6b                	jmp    b73 <uthread_init+0xb2>
  
  currentThread->state = T_RUNNING;
     b08:	a1 c0 60 00 00       	mov    0x60c0,%eax
     b0d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  //register uthread_yield as signal handler for alarm
  if(signal(SIGALRM,uthread_yield)<0)
     b14:	c7 44 24 04 fb 0d 00 	movl   $0xdfb,0x4(%esp)
     b1b:	00 
     b1c:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
     b23:	e8 0c f9 ff ff       	call   434 <signal>
     b28:	85 c0                	test   %eax,%eax
     b2a:	79 19                	jns    b45 <uthread_init+0x84>
  {
    printf(1,"Cant register the alarm signal");
     b2c:	c7 44 24 04 94 10 00 	movl   $0x1094,0x4(%esp)
     b33:	00 
     b34:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b3b:	e8 e3 f9 ff ff       	call   523 <printf>
    exit();
     b40:	e8 2f f8 ff ff       	call   374 <exit>
  }
  //set new alarm clock
  if(alarm(THREAD_QUANTA)<0)
     b45:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     b4c:	e8 f3 f8 ff ff       	call   444 <alarm>
     b51:	85 c0                	test   %eax,%eax
     b53:	79 19                	jns    b6e <uthread_init+0xad>
  {
    printf(1,"Cant activate alarm system call");
     b55:	c7 44 24 04 b4 10 00 	movl   $0x10b4,0x4(%esp)
     b5c:	00 
     b5d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b64:	e8 ba f9 ff ff       	call   523 <printf>
    exit();
     b69:	e8 06 f8 ff ff       	call   374 <exit>
  }
  return 0;
     b6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b73:	c9                   	leave  
     b74:	c3                   	ret    

00000b75 <wrap_func>:

void
wrap_func()
{
     b75:	55                   	push   %ebp
     b76:	89 e5                	mov    %esp,%ebp
     b78:	83 ec 18             	sub    $0x18,%esp
  currentThread->func(currentThread->arguments);
     b7b:	a1 c0 60 00 00       	mov    0x60c0,%eax
     b80:	8b 50 18             	mov    0x18(%eax),%edx
     b83:	a1 c0 60 00 00       	mov    0x60c0,%eax
     b88:	8b 40 1c             	mov    0x1c(%eax),%eax
     b8b:	89 04 24             	mov    %eax,(%esp)
     b8e:	ff d2                	call   *%edx
  uthread_exit();
     b90:	e8 6c 00 00 00       	call   c01 <uthread_exit>
}
     b95:	c9                   	leave  
     b96:	c3                   	ret    

00000b97 <uthread_create>:
 * to that function
 * if none can be created it returns -1;
 */
int  
uthread_create(void (*start_func)(void *), void* arg)
{
     b97:	55                   	push   %ebp
     b98:	89 e5                	mov    %esp,%ebp
     b9a:	53                   	push   %ebx
     b9b:	83 ec 14             	sub    $0x14,%esp
  uint local_esp;
  uthread_p t = allocThread();
     b9e:	e8 3b fe ff ff       	call   9de <allocThread>
     ba3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(t==0)
     ba6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     baa:	75 07                	jne    bb3 <uthread_create+0x1c>
    return -1;
     bac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bb1:	eb 48                	jmp    bfb <uthread_create+0x64>

  t->func=start_func;
     bb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bb6:	8b 55 08             	mov    0x8(%ebp),%edx
     bb9:	89 50 18             	mov    %edx,0x18(%eax)
  t->arguments=arg;
     bbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bbf:	8b 55 0c             	mov    0xc(%ebp),%edx
     bc2:	89 50 1c             	mov    %edx,0x1c(%eax)
  
  //push starting func and return value on the right stack
  STORE_ESP(local_esp);
     bc5:	89 e3                	mov    %esp,%ebx
     bc7:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  LOAD_ESP(t->esp);
     bca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bcd:	8b 40 04             	mov    0x4(%eax),%eax
     bd0:	89 c4                	mov    %eax,%esp
  PUSH_FUNC(t->esp,t->ebp,wrap_func);
     bd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bd5:	8b 50 08             	mov    0x8(%eax),%edx
     bd8:	b8 75 0b 00 00       	mov    $0xb75,%eax
     bdd:	50                   	push   %eax
     bde:	52                   	push   %edx
     bdf:	89 e2                	mov    %esp,%edx
     be1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be4:	89 50 04             	mov    %edx,0x4(%eax)
  LOAD_ESP(local_esp);
     be7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bea:	89 c4                	mov    %eax,%esp
  
  t->state = T_RUNNABLE;
     bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bef:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  
  return t->tid;
     bf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf9:	8b 00                	mov    (%eax),%eax
}
     bfb:	83 c4 14             	add    $0x14,%esp
     bfe:	5b                   	pop    %ebx
     bff:	5d                   	pop    %ebp
     c00:	c3                   	ret    

00000c01 <uthread_exit>:
 * closes the running thread, wakes up all
 * the threads waiting for this one (if they require waking up)
 */
void 
uthread_exit()
{
     c01:	55                   	push   %ebp
     c02:	89 e5                	mov    %esp,%ebp
     c04:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     c07:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c0e:	e8 31 f8 ff ff       	call   444 <alarm>
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c1a:	eb 51                	jmp    c6d <uthread_exit+0x6c>
  {
   if(currentThread->waitedOn[i]==1)
     c1c:	a1 c0 60 00 00       	mov    0x60c0,%eax
     c21:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c24:	83 c2 08             	add    $0x8,%edx
     c27:	8b 04 90             	mov    (%eax,%edx,4),%eax
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	75 3a                	jne    c69 <uthread_exit+0x68>
   {
     tTable.table[i].waitingFor=-1; //release thread i from waiting
     c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c32:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c38:	05 e0 16 00 00       	add    $0x16e0,%eax
     c3d:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
     currentThread->waitedOn[i]=0; //not necessary maybe   
     c43:	a1 c0 60 00 00       	mov    0x60c0,%eax
     c48:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c4b:	83 c2 08             	add    $0x8,%edx
     c4e:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
     tTable.table[i].state=T_RUNNABLE;
     c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c58:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     c5e:	05 d0 15 00 00       	add    $0x15d0,%eax
     c63:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
uthread_exit()
{
  alarm(0); //clear the alarm so as not to disturb running of function
  int new,i;
  //wakeup all threads waiting for this one
  for(i=0;i<MAX_THREAD;i++)
     c69:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c6d:	83 7d f4 3f          	cmpl   $0x3f,-0xc(%ebp)
     c71:	7e a9                	jle    c1c <uthread_exit+0x1b>
     tTable.table[i].state=T_RUNNABLE;
   }
  }
  
  //pick next thread
  new=getNextThread(currentThread->tid);
     c73:	a1 c0 60 00 00       	mov    0x60c0,%eax
     c78:	8b 00                	mov    (%eax),%eax
     c7a:	89 04 24             	mov    %eax,(%esp)
     c7d:	e8 e3 fc ff ff       	call   965 <getNextThread>
     c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  //release all resources and zero all fields
  if(currentThread->tid!=0)
     c85:	a1 c0 60 00 00       	mov    0x60c0,%eax
     c8a:	8b 00                	mov    (%eax),%eax
     c8c:	85 c0                	test   %eax,%eax
     c8e:	74 10                	je     ca0 <uthread_exit+0x9f>
    free(currentThread->stack);
     c90:	a1 c0 60 00 00       	mov    0x60c0,%eax
     c95:	8b 40 0c             	mov    0xc(%eax),%eax
     c98:	89 04 24             	mov    %eax,(%esp)
     c9b:	e8 38 fa ff ff       	call   6d8 <free>
  currentThread->tid=-1;
     ca0:	a1 c0 60 00 00       	mov    0x60c0,%eax
     ca5:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
  currentThread->esp=-1;
     cab:	a1 c0 60 00 00       	mov    0x60c0,%eax
     cb0:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
  currentThread->ebp=-1;
     cb7:	a1 c0 60 00 00       	mov    0x60c0,%eax
     cbc:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  currentThread->func=0;
     cc3:	a1 c0 60 00 00       	mov    0x60c0,%eax
     cc8:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  currentThread->arguments=0;
     ccf:	a1 c0 60 00 00       	mov    0x60c0,%eax
     cd4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  currentThread->stack=0;
     cdb:	a1 c0 60 00 00       	mov    0x60c0,%eax
     ce0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  currentThread->firstTime=1;
     ce7:	a1 c0 60 00 00       	mov    0x60c0,%eax
     cec:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
  currentThread->state=T_FREE;
     cf3:	a1 c0 60 00 00       	mov    0x60c0,%eax
     cf8:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  
  //load new thread
  if(new>=0)
     cff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d03:	78 7a                	js     d7f <uthread_exit+0x17e>
  {
    currentThread=&tTable.table[new];
     d05:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d08:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d0e:	05 c0 15 00 00       	add    $0x15c0,%eax
     d13:	a3 c0 60 00 00       	mov    %eax,0x60c0
    currentThread->state=T_RUNNING;
     d18:	a1 c0 60 00 00       	mov    0x60c0,%eax
     d1d:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    LOAD_ESP(currentThread->esp);
     d24:	a1 c0 60 00 00       	mov    0x60c0,%eax
     d29:	8b 40 04             	mov    0x4(%eax),%eax
     d2c:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     d2e:	a1 c0 60 00 00       	mov    0x60c0,%eax
     d33:	8b 40 08             	mov    0x8(%eax),%eax
     d36:	89 c5                	mov    %eax,%ebp
    
    //set new alarm clock
    if(alarm(THREAD_QUANTA)<0)
     d38:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     d3f:	e8 00 f7 ff ff       	call   444 <alarm>
     d44:	85 c0                	test   %eax,%eax
     d46:	79 19                	jns    d61 <uthread_exit+0x160>
    {
      printf(1,"Cant activate alarm system call");
     d48:	c7 44 24 04 b4 10 00 	movl   $0x10b4,0x4(%esp)
     d4f:	00 
     d50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d57:	e8 c7 f7 ff ff       	call   523 <printf>
      exit();
     d5c:	e8 13 f6 ff ff       	call   374 <exit>
    }
    
    if(currentThread->firstTime==1)
     d61:	a1 c0 60 00 00       	mov    0x60c0,%eax
     d66:	8b 40 14             	mov    0x14(%eax),%eax
     d69:	83 f8 01             	cmp    $0x1,%eax
     d6c:	75 10                	jne    d7e <uthread_exit+0x17d>
    {
      currentThread->firstTime=0;
     d6e:	a1 c0 60 00 00       	mov    0x60c0,%eax
     d73:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
      POP_AND_RET();
     d7a:	5d                   	pop    %ebp
     d7b:	c3                   	ret    
     d7c:	eb 01                	jmp    d7f <uthread_exit+0x17e>
    }
    else
    {  
    POP_ALL_REGISTERS();
     d7e:	61                   	popa   
    }
  }
}
     d7f:	c9                   	leave  
     d80:	c3                   	ret    

00000d81 <uthread_join>:
/*
 * causes this thread to wait for the finish of another thread
 */
int
uthread_join(int tid)
{
     d81:	55                   	push   %ebp
     d82:	89 e5                	mov    %esp,%ebp
     d84:	83 ec 18             	sub    $0x18,%esp
  if((&tTable.table[tid])->state==T_FREE)
     d87:	8b 45 08             	mov    0x8(%ebp),%eax
     d8a:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     d90:	05 c0 15 00 00       	add    $0x15c0,%eax
     d95:	8b 40 10             	mov    0x10(%eax),%eax
     d98:	85 c0                	test   %eax,%eax
     d9a:	75 07                	jne    da3 <uthread_join+0x22>
    return -1;
     d9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     da1:	eb 56                	jmp    df9 <uthread_join+0x78>
  else
  {
    alarm(0); //clear the alarm so as not to disturb running of function
     da3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     daa:	e8 95 f6 ff ff       	call   444 <alarm>
    currentThread->waitingFor=tid;
     daf:	a1 c0 60 00 00       	mov    0x60c0,%eax
     db4:	8b 55 08             	mov    0x8(%ebp),%edx
     db7:	89 90 20 01 00 00    	mov    %edx,0x120(%eax)
    tTable.table[tid].waitedOn[currentThread->tid]=1;
     dbd:	a1 c0 60 00 00       	mov    0x60c0,%eax
     dc2:	8b 08                	mov    (%eax),%ecx
     dc4:	8b 55 08             	mov    0x8(%ebp),%edx
     dc7:	89 d0                	mov    %edx,%eax
     dc9:	c1 e0 03             	shl    $0x3,%eax
     dcc:	01 d0                	add    %edx,%eax
     dce:	c1 e0 03             	shl    $0x3,%eax
     dd1:	01 d0                	add    %edx,%eax
     dd3:	01 c8                	add    %ecx,%eax
     dd5:	83 c0 08             	add    $0x8,%eax
     dd8:	c7 04 85 c0 15 00 00 	movl   $0x1,0x15c0(,%eax,4)
     ddf:	01 00 00 00 
    currentThread->state=T_SLEEPING;
     de3:	a1 c0 60 00 00       	mov    0x60c0,%eax
     de8:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
    uthread_yield();
     def:	e8 07 00 00 00       	call   dfb <uthread_yield>
    return 1;
     df4:	b8 01 00 00 00       	mov    $0x1,%eax
  }
}
     df9:	c9                   	leave  
     dfa:	c3                   	ret    

00000dfb <uthread_yield>:
/*
 * yields the run-time of the current thread to another thread
 */
void 
uthread_yield()
{
     dfb:	55                   	push   %ebp
     dfc:	89 e5                	mov    %esp,%ebp
     dfe:	83 ec 28             	sub    $0x28,%esp
  alarm(0); //clear the alarm so as not to disturb running of function
     e01:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e08:	e8 37 f6 ff ff       	call   444 <alarm>
  int new=getNextThread(currentThread->tid);
     e0d:	a1 c0 60 00 00       	mov    0x60c0,%eax
     e12:	8b 00                	mov    (%eax),%eax
     e14:	89 04 24             	mov    %eax,(%esp)
     e17:	e8 49 fb ff ff       	call   965 <getNextThread>
     e1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(new==-1)
     e1f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     e23:	75 2d                	jne    e52 <uthread_yield+0x57>
  {
    if(alarm(THREAD_QUANTA)<0)
     e25:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     e2c:	e8 13 f6 ff ff       	call   444 <alarm>
     e31:	85 c0                	test   %eax,%eax
     e33:	0f 89 c1 00 00 00    	jns    efa <uthread_yield+0xff>
    {
      printf(1,"Cant activate alarm system call\n");
     e39:	c7 44 24 04 d4 10 00 	movl   $0x10d4,0x4(%esp)
     e40:	00 
     e41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e48:	e8 d6 f6 ff ff       	call   523 <printf>
      exit();
     e4d:	e8 22 f5 ff ff       	call   374 <exit>
    } 
  }
  else
  {
    //store all leaving thread registers and pointers
    PUSH_ALL_REGISTERS();
     e52:	60                   	pusha  
    STORE_ESP(currentThread->esp);
     e53:	a1 c0 60 00 00       	mov    0x60c0,%eax
     e58:	89 e2                	mov    %esp,%edx
     e5a:	89 50 04             	mov    %edx,0x4(%eax)
    STORE_EBP(currentThread->ebp);
     e5d:	a1 c0 60 00 00       	mov    0x60c0,%eax
     e62:	89 ea                	mov    %ebp,%edx
     e64:	89 50 08             	mov    %edx,0x8(%eax)
    
    //change thread state
    if(currentThread->state==T_RUNNING) //might be sleeping from join operation
     e67:	a1 c0 60 00 00       	mov    0x60c0,%eax
     e6c:	8b 40 10             	mov    0x10(%eax),%eax
     e6f:	83 f8 02             	cmp    $0x2,%eax
     e72:	75 0c                	jne    e80 <uthread_yield+0x85>
      currentThread->state=T_RUNNABLE;
     e74:	a1 c0 60 00 00       	mov    0x60c0,%eax
     e79:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

    currentThread=&tTable.table[new];
     e80:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e83:	69 c0 24 01 00 00    	imul   $0x124,%eax,%eax
     e89:	05 c0 15 00 00       	add    $0x15c0,%eax
     e8e:	a3 c0 60 00 00       	mov    %eax,0x60c0

    //load all new thread registers and pointers
    LOAD_ESP(currentThread->esp);
     e93:	a1 c0 60 00 00       	mov    0x60c0,%eax
     e98:	8b 40 04             	mov    0x4(%eax),%eax
     e9b:	89 c4                	mov    %eax,%esp
    LOAD_EBP(currentThread->ebp);
     e9d:	a1 c0 60 00 00       	mov    0x60c0,%eax
     ea2:	8b 40 08             	mov    0x8(%eax),%eax
     ea5:	89 c5                	mov    %eax,%ebp
    //set new alram clock
    if(alarm(THREAD_QUANTA)<0)
     ea7:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
     eae:	e8 91 f5 ff ff       	call   444 <alarm>
     eb3:	85 c0                	test   %eax,%eax
     eb5:	79 19                	jns    ed0 <uthread_yield+0xd5>
    {
      printf(1,"Cant activate alarm system call\n");
     eb7:	c7 44 24 04 d4 10 00 	movl   $0x10d4,0x4(%esp)
     ebe:	00 
     ebf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ec6:	e8 58 f6 ff ff       	call   523 <printf>
      exit();
     ecb:	e8 a4 f4 ff ff       	call   374 <exit>
    }  
    currentThread->state=T_RUNNING;
     ed0:	a1 c0 60 00 00       	mov    0x60c0,%eax
     ed5:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
    
    if(currentThread->firstTime==1)
     edc:	a1 c0 60 00 00       	mov    0x60c0,%eax
     ee1:	8b 40 14             	mov    0x14(%eax),%eax
     ee4:	83 f8 01             	cmp    $0x1,%eax
     ee7:	75 10                	jne    ef9 <uthread_yield+0xfe>
    {
    currentThread->firstTime=0;
     ee9:	a1 c0 60 00 00       	mov    0x60c0,%eax
     eee:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
    POP_AND_RET();
     ef5:	5d                   	pop    %ebp
     ef6:	c3                   	ret    
     ef7:	eb 01                	jmp    efa <uthread_yield+0xff>
    }
    else
    {
      POP_ALL_REGISTERS();
     ef9:	61                   	popa   
    }
  }
}
     efa:	c9                   	leave  
     efb:	c3                   	ret    

00000efc <uthread_self>:

int
uthread_self(void)
{
     efc:	55                   	push   %ebp
     efd:	89 e5                	mov    %esp,%ebp
  return currentThread->tid;
     eff:	a1 c0 60 00 00       	mov    0x60c0,%eax
     f04:	8b 00                	mov    (%eax),%eax
     f06:	5d                   	pop    %ebp
     f07:	c3                   	ret    

00000f08 <xchg>:
#include "fs.h"
#include "uthread.h"

static inline uint
xchg(volatile uint *addr, uint newval)
{
     f08:	55                   	push   %ebp
     f09:	89 e5                	mov    %esp,%ebp
     f0b:	53                   	push   %ebx
     f0c:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
               "+m" (*addr), "=a" (result) :
     f0f:	8b 55 08             	mov    0x8(%ebp),%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f12:	8b 45 0c             	mov    0xc(%ebp),%eax
               "+m" (*addr), "=a" (result) :
     f15:	8b 4d 08             	mov    0x8(%ebp),%ecx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
     f18:	89 c3                	mov    %eax,%ebx
     f1a:	89 d8                	mov    %ebx,%eax
     f1c:	f0 87 02             	lock xchg %eax,(%edx)
     f1f:	89 c3                	mov    %eax,%ebx
     f21:	89 5d f8             	mov    %ebx,-0x8(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
     f24:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
     f27:	83 c4 10             	add    $0x10,%esp
     f2a:	5b                   	pop    %ebx
     f2b:	5d                   	pop    %ebp
     f2c:	c3                   	ret    

00000f2d <binary_semaphore_init>:
semaphore->taken=0;
}*/

void
binary_semaphore_init(struct binary_semaphore* semaphore, int value)
{
     f2d:	55                   	push   %ebp
     f2e:	89 e5                	mov    %esp,%ebp
     f30:	83 ec 08             	sub    $0x8,%esp
  semaphore->init=0;
     f33:	8b 45 08             	mov    0x8(%ebp),%eax
     f36:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  
  if(value!=0)
     f3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f41:	74 0c                	je     f4f <binary_semaphore_init+0x22>
    semaphore->thread=-1;
     f43:	8b 45 08             	mov    0x8(%ebp),%eax
     f46:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
     f4d:	eb 0b                	jmp    f5a <binary_semaphore_init+0x2d>
  else 
    semaphore->thread = uthread_self();
     f4f:	e8 a8 ff ff ff       	call   efc <uthread_self>
     f54:	8b 55 08             	mov    0x8(%ebp),%edx
     f57:	89 42 04             	mov    %eax,0x4(%edx)
  
  semaphore->locked = value;
     f5a:	8b 55 0c             	mov    0xc(%ebp),%edx
     f5d:	8b 45 08             	mov    0x8(%ebp),%eax
     f60:	89 10                	mov    %edx,(%eax)
 // semaphore->taken=0;
  semaphore->init=1;
     f62:	8b 45 08             	mov    0x8(%ebp),%eax
     f65:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  
}
     f6c:	c9                   	leave  
     f6d:	c3                   	ret    

00000f6e <binary_semaphore_down>:

void 
binary_semaphore_down(struct binary_semaphore* semaphore)
{
     f6e:	55                   	push   %ebp
     f6f:	89 e5                	mov    %esp,%ebp
     f71:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
  if(semaphore->init==0)
     f74:	8b 45 08             	mov    0x8(%ebp),%eax
     f77:	8b 40 08             	mov    0x8(%eax),%eax
     f7a:	85 c0                	test   %eax,%eax
     f7c:	75 20                	jne    f9e <binary_semaphore_down+0x30>
  {
   printf(1,"(down)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     f7e:	8b 45 08             	mov    0x8(%ebp),%eax
     f81:	8b 40 04             	mov    0x4(%eax),%eax
     f84:	89 44 24 08          	mov    %eax,0x8(%esp)
     f88:	c7 44 24 04 f8 10 00 	movl   $0x10f8,0x4(%esp)
     f8f:	00 
     f90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f97:	e8 87 f5 ff ff       	call   523 <printf>
    return;
     f9c:	eb 3a                	jmp    fd8 <binary_semaphore_down+0x6a>
  }
  
  
  int i= uthread_self();
     f9e:	e8 59 ff ff ff       	call   efc <uthread_self>
     fa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(semaphore->thread!=i)
     fa6:	8b 45 08             	mov    0x8(%ebp),%eax
     fa9:	8b 40 04             	mov    0x4(%eax),%eax
     fac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     faf:	74 27                	je     fd8 <binary_semaphore_down+0x6a>
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
     fb1:	eb 05                	jmp    fb8 <binary_semaphore_down+0x4a>
    {
      uthread_yield();
     fb3:	e8 43 fe ff ff       	call   dfb <uthread_yield>
  
  
  int i= uthread_self();
  if(semaphore->thread!=i)
  {
    while(xchg(&semaphore->locked, 0) == 0) //means the semaphore is taken allready
     fb8:	8b 45 08             	mov    0x8(%ebp),%eax
     fbb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     fc2:	00 
     fc3:	89 04 24             	mov    %eax,(%esp)
     fc6:	e8 3d ff ff ff       	call   f08 <xchg>
     fcb:	85 c0                	test   %eax,%eax
     fcd:	74 e4                	je     fb3 <binary_semaphore_down+0x45>
    {
      uthread_yield();
    }
    semaphore->thread = i;
     fcf:	8b 45 08             	mov    0x8(%ebp),%eax
     fd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     fd5:	89 50 04             	mov    %edx,0x4(%eax)
  }
  //semaphore_release(semaphore);
}
     fd8:	c9                   	leave  
     fd9:	c3                   	ret    

00000fda <binary_semaphore_up>:

void 
binary_semaphore_up(struct binary_semaphore* semaphore)
{
     fda:	55                   	push   %ebp
     fdb:	89 e5                	mov    %esp,%ebp
     fdd:	83 ec 28             	sub    $0x28,%esp
  //semaphore_acquire(semaphore);
    if(semaphore->init==0)
     fe0:	8b 45 08             	mov    0x8(%ebp),%eax
     fe3:	8b 40 08             	mov    0x8(%eax),%eax
     fe6:	85 c0                	test   %eax,%eax
     fe8:	75 20                	jne    100a <binary_semaphore_up+0x30>
    {
    printf(1,"(up)semaphore uninitialized yet (thread %d)\n",semaphore->thread);
     fea:	8b 45 08             	mov    0x8(%ebp),%eax
     fed:	8b 40 04             	mov    0x4(%eax),%eax
     ff0:	89 44 24 08          	mov    %eax,0x8(%esp)
     ff4:	c7 44 24 04 28 11 00 	movl   $0x1128,0x4(%esp)
     ffb:	00 
     ffc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1003:	e8 1b f5 ff ff       	call   523 <printf>
    return;
    1008:	eb 2f                	jmp    1039 <binary_semaphore_up+0x5f>
    }
  
  int i= uthread_self();
    100a:	e8 ed fe ff ff       	call   efc <uthread_self>
    100f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if( semaphore->locked == 0 && semaphore->thread == i)
    1012:	8b 45 08             	mov    0x8(%ebp),%eax
    1015:	8b 00                	mov    (%eax),%eax
    1017:	85 c0                	test   %eax,%eax
    1019:	75 1e                	jne    1039 <binary_semaphore_up+0x5f>
    101b:	8b 45 08             	mov    0x8(%ebp),%eax
    101e:	8b 40 04             	mov    0x4(%eax),%eax
    1021:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1024:	75 13                	jne    1039 <binary_semaphore_up+0x5f>
  {
      semaphore->thread = -1;
    1026:	8b 45 08             	mov    0x8(%ebp),%eax
    1029:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
      semaphore->locked = 1;
    1030:	8b 45 08             	mov    0x8(%ebp),%eax
    1033:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  }
//semaphore_release(semaphore);
    1039:	c9                   	leave  
    103a:	c3                   	ret    
